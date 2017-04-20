require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  # 用户注册的集成测试
  test 'invalid signup information' do
    # 发送注册请求
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: {
          name:                  '',
          email:                 'user@invalid',
          password:              'foo',
          password_confirmation: 'bar'
        }
      }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
  end

  test 'valid signup information' do
    assert_difference 'User.count', 1 do
      post users_path, params: {
        user: {
          name: 'zhuomi',
          email: 'wanglizheng@skio.cn',
          password: '123456',
          password_confirmation: '123456'
        }
      }
    end

    follow_redirect!
    assert_template 'users/show'
    assert flash
  end
end
