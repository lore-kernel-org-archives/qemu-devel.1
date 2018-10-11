Received: from eggs.gnu.org ([2001:4830:134:3::10]:53913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAcOG-0007XU-M8
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAcOC-0001WE-VQ
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:56:38 -0400
Date: Thu, 11 Oct 2018 16:56:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181011145604.GA23047@localhost.localdomain>
References: <20181010213102.8373-1-f4bug@amsat.org>
	<20181011113340.GA4417@localhost.localdomain>
	<ff422e9b-fd56-1be1-68cf-300dcd7a0cb4@redhat.com>
	<877eio37m2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877eio37m2.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

Am 11.10.2018 um 16:01 hat Markus Armbruster geschrieben:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
> > On 11/10/2018 13:33, Kevin Wolf wrote:
> >> 045 1s ...        [13:31:47] [13:31:47] [failed, exit status 1] - ou=
tput mismatch (see 045.out.bad)
> >> --- /home/kwolf/source/qemu/tests/qemu-iotests/045.out  2017-01-24 1=
4:49:48.000000000 +0100
> >> +++ /home/kwolf/source/qemu/tests/qemu-iotests/045.out.bad      2018=
-10-11 13:31:47.266876850 +0200
> >> @@ -1,5 +1,26 @@
> >> -...........
> >> --------------------------------------------------------------------=
---
> >> -Ran 11 tests
> >> -
> >> -OK
> >> +Traceback (most recent call last):
> >> +  File "045", line 178, in <module>
> >> +    iotests.main(supported_fmts=3D['raw'])
> >> +  File "/home/kwolf/source/qemu/tests/qemu-iotests/iotests.py", lin=
e 698, in main
> >> +    unittest.main(testRunner=3DMyTestRunner)
> >> +  File "/usr/lib64/python2.7/unittest/main.py", line 95, in __init_=
_
> >> +    self.runTests()
> >> +  File "/usr/lib64/python2.7/unittest/main.py", line 232, in runTes=
ts
> >> +    self.result =3D testRunner.run(self.test)
> >> +  File "/usr/lib64/python2.7/unittest/runner.py", line 151, in run
> >> +    test(result)
> >> +  File "/usr/lib64/python2.7/unittest/suite.py", line 70, in __call=
__
> >> +    return self.run(*args, **kwds)
> >> +  File "/usr/lib64/python2.7/unittest/suite.py", line 108, in run
> >> +    test(result)
> >> +  File "/usr/lib64/python2.7/unittest/suite.py", line 70, in __call=
__
> >> +    return self.run(*args, **kwds)
> >> +  File "/usr/lib64/python2.7/unittest/suite.py", line 108, in run
> >> +    test(result)
> >> +  File "/usr/lib64/python2.7/unittest/case.py", line 431, in __call=
__
> >> +    return self.run(*args, **kwds)
> >> +  File "/usr/lib64/python2.7/unittest/case.py", line 406, in run
> >> +    result.addSuccess(self)
> >> +  File "/usr/lib64/python2.7/unittest/runner.py", line 62, in addSu=
ccess
> >> +    self.stream.write('.')
> >> +TypeError: unicode argument expected, got 'str'
> >> Failures: 045
> >> Failed 1 of 1 tests
> >>=20
> >> $ /usr/bin/env python --version
> >> Python 2.7.15
> >
> > Indeed, io.StringIO exists in Python 2.7 but it's different!  If Pyth=
on
> > 2 code is not unicode-friendly (it almost never is) it should use
> > StringIO.StringIO, for example 'six' defines
> >
> >   six.StringIO:
> >     This is an fake file object for textual data. It=E2=80=99s an ali=
as for
> >     StringIO.StringIO in Python 2 and io.StringIO in Python 3.
> >
> >   six.BytesIO:
> >     This is a fake file object for binary data. In Python 2, it=E2=80=
=99s an
> >     alias for StringIO.StringIO, but in Python 3, it=E2=80=99s an ali=
as for
> >     io.BytesIO.
> >
> > So the solution seems to be a try/except (and then, better move the
> > "from X import StringIO" to the top of the file then, rather than
> > keeping it in def main).
> >
> > Paolo
>=20
> I think we need to invest more resources in Python 2/3 compatiblity, or
> else we'll miss our hard deadline of January 1, 2020.

Did we decide until when we want to support Python-2-only hosts in QEMU?

I think I would be okay with just getting rid of Python 2 support and
always using Python 3 instead of trying to write code that works with
both. Python 3 was installed for me, but the scripts didn't use it.

Kevin
