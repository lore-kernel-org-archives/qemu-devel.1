Received: from eggs.gnu.org ([2001:4830:134:3::10]:56146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg7Eq-00029B-Nu
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg7El-00076o-JH
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:04:36 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:35553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eg7El-00075Y-8s
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:04:31 -0500
Received: by mail-wm0-x233.google.com with SMTP id r78so32858419wme.0
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 03:04:30 -0800 (PST)
Date: Mon, 29 Jan 2018 11:04:26 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180129110426.GA20446@stefanha-x1.localdomain>
References: <20180129033133.31288-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20180129033133.31288-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, f4bug@amsat.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org, armbru@redhat.com


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 29, 2018 at 11:31:33AM +0800, Fam Zheng wrote:

Thanks for writing this!

I have only reviewed some parts in detail.

> +"Make check" testings
> +=====================
> +
> +The "make check" testing family includes most of the C based tests in QEMU. For
> +a quick help, run ``make check-help`` from the source tree.
> +
> +The usual way to run these tests is:
> +
> +.. code::
> +
> +  make check
> +
> +which includes QAPI schema tests, unit tests, and QTests. Different sub-types
> +of "make check" testings will be explained below.
> +
> +Before running tests, it is best to build QEMU programs first. Some tests
> +expect the executables to exist and will fail with obscure messages if cannot

s/if cannot/if they cannot/

> +find them.
> +
> +Unit tests
> +----------
> +
> +Unit tests, which can be invoked with ``make check-unit``, are simple C tests
> +that typically link to individual QEMU objects and exercise them by calling

I think this is clearer:
s/objects/object files/

Otherwise people might think "QEMU objects" is releated to QOM objects.

> +into the modules.

The term "modules" hasn't been defined.  I think the following is
clearer:

s/into the modules/exported functions/

> +
> +If you are writing new code in QEMU, consider adding a unit test, especially
> +for utility modules that are relatively stateless or have few dependencies. To
> +add a new unit test:
> +
> +1. Create a new source file. For example, ``tests/test-foo.c``.
> +
> +2. Write the test. Normally you would include the headers file which exports

s/headers/header/

> +   the module API, then verify the interface behaves as expected from your
> +   test. The test code should be organized with the glib testing framework.
> +   Copy and modify an existing test is usually a good idea.

s/Copy and modify/Copying and modifying/

> +
> +3. Add the test to ``tests/Makefile.include``. First, name the unit test
> +   program and add it to ``$(check-unit-y)``; then add a rule to build the
> +   executable. Optionally, you can add a magical variable to support ``gcov``.
> +   For example:
> +
> +.. code::
> +
> +  check-unit-y += tests/test-foo$(EXESUF)
> +  tests/test-foo$(EXESUF): tests/test-foo.o $(test-util-obj-y)
> +  ...
> +  gcov-files-test-foo-y = util/foo.c
> +
> +QTest
> +-----
> +
> +QTest is a testing framework that simplifies starting QEMU and interacting with

"simplifies starting QEMU" is not the most important aspect of qtest and
I would drop this completely.

The following single-sentence summary is a good opener: QTest is a
device emulation testing framework.

> +the virtual machine just like a guest kernel does. It can be very useful to
> +test hardware emulation, for example; it could also control certain aspects of
> +QEMU (such as virtual clock stepping), with a specially purposed "qtest"

s/a specially purposed/the special purpose/

> +protocol. Refer to the documentation in ``qtest.c`` file for more details of

s/in ``qtest.c`` file/in ``qtest.c``/

(If you want to keep "file" then a definite article is needed - "the".)

> +the protocol.
> +
> +QTest cases can be executed with
> +
> +.. code::
> +
> +   make check-qtest
> +
> +The QTest library is implemented by ``tests/libqtest.c`` and the API is defined
> +in ``tests/libqtest.h``.
> +
> +Consider adding a new QTest case when you are introducing a new virtual
> +hardware, or extending one if you are adding functionalities to an existing
> +virtual device.
> +
> +On top of libqtest, a higher level library, ``libqos``, was created to
> +encapsulate common tasks of device drivers, such as memory management and
> +communicating with system buses or devices. Many virtual device tests use

s/buses/busses/

> +libqos instead of directly calling into libqos.
> +
> +Steps to add a new QTest case are:
> +
> +1. Create a new source file for the test. (More than one file can be added as
> +   necessary.) For example, ``tests/test-foo-device.c``.  2. Write the test
> +   code with the glib and libqtest/libqos API. See also existing tests and the
> +   library headers for reference.
> +
> +3. Register the new test in ``tests/Makefile.include``. Add the test executable
> +   name to an appropriate ``check-qtest-*-y`` variable. For example:
> +
> +   ``check-qtest-generic-y = tests/test-foo-device$(EXESUF)``
> +
> +4. Add object dependencies of the executable in the Makefile, including the
> +   test source file(s) and other interesting objects. For example:
> +
> +   ``tests/test-foo-device$(EXESUF): tests/test-foo-device.o $(libqos-obj-y)``
> +
> +QAPI schema tests
> +-----------------
> +
> +The QAPI schema tests validate the QAPI parser used by QMP, by feeding
> +predefined input to the parser and compare the result with the reference

s/compare/comparing/

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJabv+6AAoJEJykq7OBq3PIDgAH+wckIa53yeBR73PJfiuLvnDf
ztncRrN4RSsT16oUwtowowgVQDxUg33Z9fHv0hMbK2p5cY8KTzTQ2xW6eHtD+JGI
GKrQyqysVkFPuOchEH3I5PEiPS3/h/bzg93cYdBarrSJwkXI5LHlzXEIbhzytqY6
4Jaw1peMG+8wHPEtzUjDZFsCozXAnnY9Qo/RZk4XHo2Ey5CnxPaBNry/xSxhbm2B
6jldqPnH85IfoXO9ZYh8ccthNgweycFmouuVGDuvzJr9X9YSSd3rQFm7cI44QBZB
DHNi50G9H01pTiSNKrQ65BncfaA9PPyYnjy/tZs4LTh7uhFfctPR/bBiSv6QPvw=
=4sAL
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
