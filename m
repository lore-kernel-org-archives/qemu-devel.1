Received: from eggs.gnu.org ([2001:4830:134:3::10]:55804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAZE5-0005R1-VH
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAZE4-0004EO-SZ
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:33:57 -0400
Date: Thu, 11 Oct 2018 13:33:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181011113340.GA4417@localhost.localdomain>
References: <20181010213102.8373-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181010213102.8373-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] python: Use io.StringIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 10.10.2018 um 23:31 hat Philippe Mathieu-Daud=E9 geschrieben:
> Both Python 2.7 and 3 support the same io.StringIO to
> handle unicode strings.
>=20
> Use the common form to use indistinctly Python 2.7 or 3.
>=20
> http://python-future.org/compatible_idioms.html#stringio
>=20
> This fixes running tests on the Fedora Docker image,
> which uses Python3 since 356dc290f:
>=20
>   $ make docker-test-block@fedora
>   [...]
>   045         [failed, exit status 1] - output mismatch (see 045.out.ba=
d)
>   --- /tmp/qemu-test/src/tests/qemu-iotests/045.out       2018-07-17 16=
:56:18.000000000 +0000
>   +++ /tmp/qemu-test/build/tests/qemu-iotests/045.out.bad 2018-07-17 17=
:19:22.448409007 +0000
>   @@ -1,5 +1,6 @@
>   -...........
>   ---------------------------------------------------------------------=
--
>   -Ran 11 tests
>   -
>   -OK
>   +Traceback (most recent call last):
>   +  File "045", line 178, in <module>
>   +    iotests.main(supported_fmts=3D['raw'])
>   +  File "/tmp/qemu-test/src/tests/qemu-iotests/iotests.py", line 682,=
 in main
>   +    import StringIO
>   +ModuleNotFoundError: No module named 'StringIO'
>   132         [failed, exit status 1] - output mismatch (see 132.out.ba=
d)
>   152         [failed, exit status 1] - output mismatch (see 152.out.ba=
d)
>=20
>   Failures: 045 132 152
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

This doesn't work for me:

045 1s ...        [13:31:47] [13:31:47] [failed, exit status 1] - output =
mismatch (see 045.out.bad)
--- /home/kwolf/source/qemu/tests/qemu-iotests/045.out  2017-01-24 14:49:=
48.000000000 +0100
+++ /home/kwolf/source/qemu/tests/qemu-iotests/045.out.bad      2018-10-1=
1 13:31:47.266876850 +0200
@@ -1,5 +1,26 @@
-...........
-----------------------------------------------------------------------
-Ran 11 tests
-
-OK
+Traceback (most recent call last):
+  File "045", line 178, in <module>
+    iotests.main(supported_fmts=3D['raw'])
+  File "/home/kwolf/source/qemu/tests/qemu-iotests/iotests.py", line 698=
, in main
+    unittest.main(testRunner=3DMyTestRunner)
+  File "/usr/lib64/python2.7/unittest/main.py", line 95, in __init__
+    self.runTests()
+  File "/usr/lib64/python2.7/unittest/main.py", line 232, in runTests
+    self.result =3D testRunner.run(self.test)
+  File "/usr/lib64/python2.7/unittest/runner.py", line 151, in run
+    test(result)
+  File "/usr/lib64/python2.7/unittest/suite.py", line 70, in __call__
+    return self.run(*args, **kwds)
+  File "/usr/lib64/python2.7/unittest/suite.py", line 108, in run
+    test(result)
+  File "/usr/lib64/python2.7/unittest/suite.py", line 70, in __call__
+    return self.run(*args, **kwds)
+  File "/usr/lib64/python2.7/unittest/suite.py", line 108, in run
+    test(result)
+  File "/usr/lib64/python2.7/unittest/case.py", line 431, in __call__
+    return self.run(*args, **kwds)
+  File "/usr/lib64/python2.7/unittest/case.py", line 406, in run
+    result.addSuccess(self)
+  File "/usr/lib64/python2.7/unittest/runner.py", line 62, in addSuccess
+    self.stream.write('.')
+TypeError: unicode argument expected, got 'str'
Failures: 045
Failed 1 of 1 tests

$ /usr/bin/env python --version
Python 2.7.15

Kevin
