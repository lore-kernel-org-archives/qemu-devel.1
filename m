Received: from eggs.gnu.org ([2001:4830:134:3::10]:48496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egAmW-0007Kf-6N
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egAmR-0000gc-J2
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:51:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egAmR-0000dh-9i
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:51:31 -0500
References: <20180129033133.31288-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <944b5ec8-4037-479f-ac8e-f1c3a601d77a@redhat.com>
Date: Mon, 29 Jan 2018 08:51:16 -0600
MIME-Version: 1.0
In-Reply-To: <20180129033133.31288-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wp9cCDS11bzbJmKUtisNAjOWqL9uYOEFc"
Subject: Re: [Qemu-devel] [PATCH] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, alex.bennee@linaro.org, f4bug@amsat.org, mreitz@redhat.com, berrange@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wp9cCDS11bzbJmKUtisNAjOWqL9uYOEFc
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, alex.bennee@linaro.org, f4bug@amsat.org,
 mreitz@redhat.com, berrange@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com
Message-ID: <944b5ec8-4037-479f-ac8e-f1c3a601d77a@redhat.com>
Subject: Re: [PATCH] docs: Add docs/devel/testing.rst
References: <20180129033133.31288-1-famz@redhat.com>
In-Reply-To: <20180129033133.31288-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/28/2018 09:31 PM, Fam Zheng wrote:
> To make our efforts on QEMU testing easier to consume by contributors,
> let's add a document. For example, Patchew reports build errors on
> patches that should be relativly easy to reproduce with a few steps, an=
d

s/relativly/relatively/

> it is much nicer if there is such a documentation that it can refer to.=

>=20
> This focues on how to run existing tests and how to write new test

s/focues/focuses/

> cases, without going into the frameworks themselves.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> ---
>=20

I'll try not to repeat comments made by others...

> +This document describes the testing infrastructure in QEMU.
> +
> +"Make check" testings
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

s/testings/tests/, or 'Testing with "make check"'

> +
> +The "make check" testing family includes most of the C based tests in =
QEMU. For
> +a quick help, run ``make check-help`` from the source tree.
> +
> +The usual way to run these tests is:
> +
> +.. code::
> +
> +  make check
> +
> +which includes QAPI schema tests, unit tests, and QTests. Different su=
b-types
> +of "make check" testings will be explained below.

s/testings/tests/

> +
> +Before running tests, it is best to build QEMU programs first. Some te=
sts
> +expect the executables to exist and will fail with obscure messages if=
 cannot
> +find them.

Should we fix 'make check' to depend on 'make all', so that we don't
have to require this?

> +
> +Unit tests
> +----------
> +
> +Unit tests, which can be invoked with ``make check-unit``, are simple =
C tests
> +that typically link to individual QEMU objects and exercise them by ca=
lling
> +into the modules.
> +
> +If you are writing new code in QEMU, consider adding a unit test, espe=
cially
> +for utility modules that are relatively stateless or have few dependen=
cies. To
> +add a new unit test:
> +
> +1. Create a new source file. For example, ``tests/test-foo.c``.
> +
> +2. Write the test. Normally you would include the headers file which e=
xports
> +   the module API, then verify the interface behaves as expected from =
your
> +   test. The test code should be organized with the glib testing frame=
work.
> +   Copy and modify an existing test is usually a good idea.
> +
> +3. Add the test to ``tests/Makefile.include``. First, name the unit te=
st
> +   program and add it to ``$(check-unit-y)``; then add a rule to build=
 the
> +   executable. Optionally, you can add a magical variable to support `=
`gcov``.
> +   For example:
> +
> +.. code::
> +
> +  check-unit-y +=3D tests/test-foo$(EXESUF)
> +  tests/test-foo$(EXESUF): tests/test-foo.o $(test-util-obj-y)
> +  ...
> +  gcov-files-test-foo-y =3D util/foo.c

Is it worth documenting that you can often run 'gdb ./test-foo' after
the fact for a failing test?  (Most unit tests don't require any magic
environment variables to be set)

> +
> +QTest
> +-----
> +
> +QTest is a testing framework that simplifies starting QEMU and interac=
ting with
> +the virtual machine just like a guest kernel does. It can be very usef=
ul to
> +test hardware emulation, for example; it could also control certain as=
pects of
> +QEMU (such as virtual clock stepping), with a specially purposed "qtes=
t"
> +protocol. Refer to the documentation in ``qtest.c`` file for more deta=
ils of
> +the protocol.
> +
> +QTest cases can be executed with
> +
> +.. code::
> +
> +   make check-qtest
> +
> +The QTest library is implemented by ``tests/libqtest.c`` and the API i=
s defined
> +in ``tests/libqtest.h``.
> +
> +Consider adding a new QTest case when you are introducing a new virtua=
l
> +hardware, or extending one if you are adding functionalities to an exi=
sting
> +virtual device.
> +
> +On top of libqtest, a higher level library, ``libqos``, was created to=

> +encapsulate common tasks of device drivers, such as memory management =
and
> +communicating with system buses or devices. Many virtual device tests =
use
> +libqos instead of directly calling into libqos.
> +
> +Steps to add a new QTest case are:
> +
> +1. Create a new source file for the test. (More than one file can be a=
dded as
> +   necessary.) For example, ``tests/test-foo-device.c``.  2. Write the=
 test
> +   code with the glib and libqtest/libqos API. See also existing tests=
 and the
> +   library headers for reference.
> +
> +3. Register the new test in ``tests/Makefile.include``. Add the test e=
xecutable
> +   name to an appropriate ``check-qtest-*-y`` variable. For example:
> +
> +   ``check-qtest-generic-y =3D tests/test-foo-device$(EXESUF)``
> +
> +4. Add object dependencies of the executable in the Makefile, includin=
g the
> +   test source file(s) and other interesting objects. For example:
> +
> +   ``tests/test-foo-device$(EXESUF): tests/test-foo-device.o $(libqos-=
obj-y)``

Is it worth documenting that 'make check-qtest' runs EVERY test unless
you define magic environment variables; and if it fails, running 'make
check-qtest V=3D1' can help identify which test failed?  Here, running a
mere 'gdb foo-device-test' is prone to fail (because it is missing magic
environment variables); it's possible to run individual tests under gdb
but it requires more effort (among other things, the V=3D1 helps you lear=
n
what environment variables to set).

> +

> +Docker based testing
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

'Docker based tests' or 'Testing with docker'

> +
> +Introduction
> +------------
> +
> +Docker testing framework in QEMU utilizes the public Docker images to =
build and

s/^Docker/The Docker/
s/the public/public/

> +test QEMU in predefined and widely accessible Linux environments.  Thi=
s makes
> +it possible to expand the test coverage across distros, toolchain flav=
ors and
> +library versions.
> +


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wp9cCDS11bzbJmKUtisNAjOWqL9uYOEFc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpvNOQACgkQp6FrSiUn
Q2rknQf/cSJjKLn3P5eCIRYir2nBNV+avZ73mCwpQvcImbmUpKsahw0hEVepLAyu
HvyNkMMgVY2x07dFMbb55sSqNxjMj97fJNvBbTrPfmJpLlObeJKihlggqPwWs92U
ZknaRKSQ69wMYnW8tDaHQ/j6IBfm5snqeb0flnTIxV7ZCjp3JUHZCvzMMsNOsF88
jNCFxzkySQmh9K2RjGv1cz0PKLpITQRSsS07I56Ch6vYklKf3h2+w18k7MvE62g5
abTw9Nv0Hk8zApBCv0v0NUDjlC3AbJd9nQgTcdwvnjWuc2VXUGzVJcJRODzRyLgf
j32tCree5ZDy31u6uAxdPhU/H8dWFA==
=L68I
-----END PGP SIGNATURE-----

--wp9cCDS11bzbJmKUtisNAjOWqL9uYOEFc--
