// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.2 ;


contract Token {
    
    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowance;
    
    uint256 public totalSupply = 10e24;
    string public name = "GoldCurrency";
    string public symbol = "GC";
    uint256 public decimals = 12;
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    
    constructor() {
        balances[msg.sender] = totalSupply;
    }
    
    function balanceOf(address owner) public view returns(uint256) {
        return balances[owner];
    }
    
    function transfer(address to, uint256 value) public returns(bool) {
        require(balanceOf(msg.sender) >= value, 'Saldo insuficiente (insufficient funds)');
        balances[to] += value;
        balances[msg.sender] -= value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns(bool) {
        require(balanceOf(msg.sender)>=value,'Saldo insuficiente (insufficient funds)');
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
    
    function eu() public view returns(address){
        return msg.sender;
    }

    function transferFrom(address from, address to, uint256 value) public returns(bool) {
        require(balanceOf(from) >= value, 'Saldo insuficiente (insufficient funds)');
        require(allowance[from][msg.sender] >= value, 'Sem permissao (without permission)');
        balances[to] += value;
        balances[from] -= value;
        allowance[from][msg.sender]-=value;
        emit Transfer(from, to, value);
        return true;
    }
}
