Received: from eggs.gnu.org ([2001:4830:134:3::10]:50183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAcD4-0003h8-Pt
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAcD0-00087Z-3I
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:45:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAcCy-00085Z-VM
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:45:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id e187-v6so9787063wmf.0
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 07:44:58 -0700 (PDT)
References: <20181010213102.8373-1-f4bug@amsat.org>
	<20181011113340.GA4417@localhost.localdomain>
	<ff422e9b-fd56-1be1-68cf-300dcd7a0cb4@redhat.com>
	<877eio37m2.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8c42ffd9-e766-114a-59da-7c7b249d21d5@redhat.com>
Date: Thu, 11 Oct 2018 16:44:52 +0200
MIME-Version: 1.0
In-Reply-To: <877eio37m2.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] python: Use io.StringIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 11/10/2018 16:01, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 11/10/2018 13:33, Kevin Wolf wrote:
>>> 045 1s ...        [13:31:47] [13:31:47] [failed, exit status 1] - output mismatch (see 045.out.bad)
>>> --- /home/kwolf/source/qemu/tests/qemu-iotests/045.out  2017-01-24 14:49:48.000000000 +0100
>>> +++ /home/kwolf/source/qemu/tests/qemu-iotests/045.out.bad      2018-10-11 13:31:47.266876850 +0200
>>> @@ -1,5 +1,26 @@
>>> -...........
>>> -----------------------------------------------------------------------
>>> -Ran 11 tests
>>> -
>>> -OK
>>> +Traceback (most recent call last):
>>> +  File "045", line 178, in <module>
>>> +    iotests.main(supported_fmts=['raw'])
>>> +  File "/home/kwolf/source/qemu/tests/qemu-iotests/iotests.py", line 698, in main
>>> +    unittest.main(testRunner=MyTestRunner)
>>> +  File "/usr/lib64/python2.7/unittest/main.py", line 95, in __init__
>>> +    self.runTests()
>>> +  File "/usr/lib64/python2.7/unittest/main.py", line 232, in runTests
>>> +    self.result = testRunner.run(self.test)
>>> +  File "/usr/lib64/python2.7/unittest/runner.py", line 151, in run
>>> +    test(result)
>>> +  File "/usr/lib64/python2.7/unittest/suite.py", line 70, in __call__
>>> +    return self.run(*args, **kwds)
>>> +  File "/usr/lib64/python2.7/unittest/suite.py", line 108, in run
>>> +    test(result)
>>> +  File "/usr/lib64/python2.7/unittest/suite.py", line 70, in __call__
>>> +    return self.run(*args, **kwds)
>>> +  File "/usr/lib64/python2.7/unittest/suite.py", line 108, in run
>>> +    test(result)
>>> +  File "/usr/lib64/python2.7/unittest/case.py", line 431, in __call__
>>> +    return self.run(*args, **kwds)
>>> +  File "/usr/lib64/python2.7/unittest/case.py", line 406, in run
>>> +    result.addSuccess(self)
>>> +  File "/usr/lib64/python2.7/unittest/runner.py", line 62, in addSuccess
>>> +    self.stream.write('.')
>>> +TypeError: unicode argument expected, got 'str'
>>> Failures: 045
>>> Failed 1 of 1 tests
>>>
>>> $ /usr/bin/env python --version
>>> Python 2.7.15
>>
>> Indeed, io.StringIO exists in Python 2.7 but it's different!  If Python
>> 2 code is not unicode-friendly (it almost never is) it should use
>> StringIO.StringIO, for example 'six' defines
>>
>>   six.StringIO:
>>     This is an fake file object for textual data. It’s an alias for
>>     StringIO.StringIO in Python 2 and io.StringIO in Python 3.
>>
>>   six.BytesIO:
>>     This is a fake file object for binary data. In Python 2, it’s an
>>     alias for StringIO.StringIO, but in Python 3, it’s an alias for
>>     io.BytesIO.

o_O

Thanks for the clarification.
I'll let people who actually do understand Python fix this.

>>
>> So the solution seems to be a try/except (and then, better move the
>> "from X import StringIO" to the top of the file then, rather than
>> keeping it in def main).
>>
>> Paolo
> 
> I think we need to invest more resources in Python 2/3 compatiblity, or
> else we'll miss our hard deadline of January 1, 2020.
> 
> https://pythonclock.org/

Some distributions already dropped Python2, so you need to specifically
install it to run block tests (other tests work with Python3).

See this thread:
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06461.html
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06510.html

Regards,

Phil.
