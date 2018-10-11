Received: from eggs.gnu.org ([2001:4830:134:3::10]:37622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAbY1-0001s2-08
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAbXp-0000JM-OJ
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:02:40 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181010213102.8373-1-f4bug@amsat.org>
	<20181011113340.GA4417@localhost.localdomain>
	<ff422e9b-fd56-1be1-68cf-300dcd7a0cb4@redhat.com>
Date: Thu, 11 Oct 2018 16:01:25 +0200
In-Reply-To: <ff422e9b-fd56-1be1-68cf-300dcd7a0cb4@redhat.com> (Paolo
	Bonzini's message of "Thu, 11 Oct 2018 14:43:34 +0200")
Message-ID: <877eio37m2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] python: Use io.StringIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 11/10/2018 13:33, Kevin Wolf wrote:
>> 045 1s ...        [13:31:47] [13:31:47] [failed, exit status 1] - output=
 mismatch (see 045.out.bad)
>> --- /home/kwolf/source/qemu/tests/qemu-iotests/045.out  2017-01-24 14:49=
:48.000000000 +0100
>> +++ /home/kwolf/source/qemu/tests/qemu-iotests/045.out.bad      2018-10-=
11 13:31:47.266876850 +0200
>> @@ -1,5 +1,26 @@
>> -...........
>> -----------------------------------------------------------------------
>> -Ran 11 tests
>> -
>> -OK
>> +Traceback (most recent call last):
>> +  File "045", line 178, in <module>
>> +    iotests.main(supported_fmts=3D['raw'])
>> +  File "/home/kwolf/source/qemu/tests/qemu-iotests/iotests.py", line 69=
8, in main
>> +    unittest.main(testRunner=3DMyTestRunner)
>> +  File "/usr/lib64/python2.7/unittest/main.py", line 95, in __init__
>> +    self.runTests()
>> +  File "/usr/lib64/python2.7/unittest/main.py", line 232, in runTests
>> +    self.result =3D testRunner.run(self.test)
>> +  File "/usr/lib64/python2.7/unittest/runner.py", line 151, in run
>> +    test(result)
>> +  File "/usr/lib64/python2.7/unittest/suite.py", line 70, in __call__
>> +    return self.run(*args, **kwds)
>> +  File "/usr/lib64/python2.7/unittest/suite.py", line 108, in run
>> +    test(result)
>> +  File "/usr/lib64/python2.7/unittest/suite.py", line 70, in __call__
>> +    return self.run(*args, **kwds)
>> +  File "/usr/lib64/python2.7/unittest/suite.py", line 108, in run
>> +    test(result)
>> +  File "/usr/lib64/python2.7/unittest/case.py", line 431, in __call__
>> +    return self.run(*args, **kwds)
>> +  File "/usr/lib64/python2.7/unittest/case.py", line 406, in run
>> +    result.addSuccess(self)
>> +  File "/usr/lib64/python2.7/unittest/runner.py", line 62, in addSuccess
>> +    self.stream.write('.')
>> +TypeError: unicode argument expected, got 'str'
>> Failures: 045
>> Failed 1 of 1 tests
>>=20
>> $ /usr/bin/env python --version
>> Python 2.7.15
>
> Indeed, io.StringIO exists in Python 2.7 but it's different!  If Python
> 2 code is not unicode-friendly (it almost never is) it should use
> StringIO.StringIO, for example 'six' defines
>
>   six.StringIO:
>     This is an fake file object for textual data. It=E2=80=99s an alias f=
or
>     StringIO.StringIO in Python 2 and io.StringIO in Python 3.
>
>   six.BytesIO:
>     This is a fake file object for binary data. In Python 2, it=E2=80=99s=
 an
>     alias for StringIO.StringIO, but in Python 3, it=E2=80=99s an alias f=
or
>     io.BytesIO.
>
> So the solution seems to be a try/except (and then, better move the
> "from X import StringIO" to the top of the file then, rather than
> keeping it in def main).
>
> Paolo

I think we need to invest more resources in Python 2/3 compatiblity, or
else we'll miss our hard deadline of January 1, 2020.

https://pythonclock.org/
