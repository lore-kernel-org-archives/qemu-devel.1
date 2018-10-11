Received: from eggs.gnu.org ([2001:4830:134:3::10]:44971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAaJZ-0000Jo-Fg
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAaJW-0006YL-9W
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:43:41 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:45446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gAaJW-0006XU-1s
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:43:38 -0400
Received: by mail-wr1-f46.google.com with SMTP id q5-v6so9512936wrw.12
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 05:43:37 -0700 (PDT)
References: <20181010213102.8373-1-f4bug@amsat.org>
	<20181011113340.GA4417@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff422e9b-fd56-1be1-68cf-300dcd7a0cb4@redhat.com>
Date: Thu, 11 Oct 2018 14:43:34 +0200
MIME-Version: 1.0
In-Reply-To: <20181011113340.GA4417@localhost.localdomain>
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
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 11/10/2018 13:33, Kevin Wolf wrote:
> 045 1s ...        [13:31:47] [13:31:47] [failed, exit status 1] - output mismatch (see 045.out.bad)
> --- /home/kwolf/source/qemu/tests/qemu-iotests/045.out  2017-01-24 14:49:48.000000000 +0100
> +++ /home/kwolf/source/qemu/tests/qemu-iotests/045.out.bad      2018-10-11 13:31:47.266876850 +0200
> @@ -1,5 +1,26 @@
> -...........
> -----------------------------------------------------------------------
> -Ran 11 tests
> -
> -OK
> +Traceback (most recent call last):
> +  File "045", line 178, in <module>
> +    iotests.main(supported_fmts=['raw'])
> +  File "/home/kwolf/source/qemu/tests/qemu-iotests/iotests.py", line 698, in main
> +    unittest.main(testRunner=MyTestRunner)
> +  File "/usr/lib64/python2.7/unittest/main.py", line 95, in __init__
> +    self.runTests()
> +  File "/usr/lib64/python2.7/unittest/main.py", line 232, in runTests
> +    self.result = testRunner.run(self.test)
> +  File "/usr/lib64/python2.7/unittest/runner.py", line 151, in run
> +    test(result)
> +  File "/usr/lib64/python2.7/unittest/suite.py", line 70, in __call__
> +    return self.run(*args, **kwds)
> +  File "/usr/lib64/python2.7/unittest/suite.py", line 108, in run
> +    test(result)
> +  File "/usr/lib64/python2.7/unittest/suite.py", line 70, in __call__
> +    return self.run(*args, **kwds)
> +  File "/usr/lib64/python2.7/unittest/suite.py", line 108, in run
> +    test(result)
> +  File "/usr/lib64/python2.7/unittest/case.py", line 431, in __call__
> +    return self.run(*args, **kwds)
> +  File "/usr/lib64/python2.7/unittest/case.py", line 406, in run
> +    result.addSuccess(self)
> +  File "/usr/lib64/python2.7/unittest/runner.py", line 62, in addSuccess
> +    self.stream.write('.')
> +TypeError: unicode argument expected, got 'str'
> Failures: 045
> Failed 1 of 1 tests
> 
> $ /usr/bin/env python --version
> Python 2.7.15

Indeed, io.StringIO exists in Python 2.7 but it's different!  If Python
2 code is not unicode-friendly (it almost never is) it should use
StringIO.StringIO, for example 'six' defines

  six.StringIO:
    This is an fake file object for textual data. It’s an alias for
    StringIO.StringIO in Python 2 and io.StringIO in Python 3.

  six.BytesIO:
    This is a fake file object for binary data. In Python 2, it’s an
    alias for StringIO.StringIO, but in Python 3, it’s an alias for
    io.BytesIO.

So the solution seems to be a try/except (and then, better move the
"from X import StringIO" to the top of the file then, rather than
keeping it in def main).

Paolo
