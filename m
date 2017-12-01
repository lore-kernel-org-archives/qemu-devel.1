Received: from eggs.gnu.org ([2001:4830:134:3::10]:47444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKsc0-0004Kd-Iu
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 16:12:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKsby-0005JJ-SW
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 16:12:44 -0500
References: <20171116173810.16457-1-crosa@redhat.com>
	<20171116173810.16457-11-crosa@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b2affdb0-16b2-3e26-d8a1-ce12cb836ccc@redhat.com>
Date: Fri, 1 Dec 2017 22:12:32 +0100
MIME-Version: 1.0
In-Reply-To: <20171116173810.16457-11-crosa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fKfrt1wWO1bMnPu900Md5jh1JGTLhe8UV"
Subject: Re: [Qemu-devel] [PATCH 10/10] qemu-iotests: add section on how to
 write a new I/O test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fKfrt1wWO1bMnPu900Md5jh1JGTLhe8UV
From: Max Reitz <mreitz@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <b2affdb0-16b2-3e26-d8a1-ce12cb836ccc@redhat.com>
Subject: Re: [PATCH 10/10] qemu-iotests: add section on how to write a new I/O
 test
References: <20171116173810.16457-1-crosa@redhat.com>
 <20171116173810.16457-11-crosa@redhat.com>
In-Reply-To: <20171116173810.16457-11-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-16 18:38, Cleber Rosa wrote:
> This adds some basic information on how to write a new test.  I'm
> aware that some of the information in the wiki (Testing/QemuIoTests)
> could also belong here.
>=20
> Since copying content over won't generate much interesting feedback,
> the goal here is to get feedback on the sample_test_templates, general
> workflow proposed for writing a new test, etc.
>=20
> After feedback is received, I can go over and sync both sides (wiki
> and README).
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/qemu-iotests/README                          | 44 ++++++++++++++=
--
>  tests/qemu-iotests/sample_test_templates/sample.py | 59 ++++++++++++++=
++++++++
>  tests/qemu-iotests/sample_test_templates/sample.sh | 40 ++++++++++++++=
+
>  3 files changed, 138 insertions(+), 5 deletions(-)
>  create mode 100755 tests/qemu-iotests/sample_test_templates/sample.py
>  create mode 100755 tests/qemu-iotests/sample_test_templates/sample.sh

Thanks a lot!

> diff --git a/tests/qemu-iotests/README b/tests/qemu-iotests/README
> index 6079b401ae..efaf72d5e7 100644
> --- a/tests/qemu-iotests/README
> +++ b/tests/qemu-iotests/README
> @@ -1,20 +1,54 @@
> +=3D This is the QEMU I/O test suite =3D
> =20
> -=3D=3D=3D This is the QEMU I/O test suite =3D=3D=3D
> -
> -* Intro
> +=3D=3D Intro =3D=3D
> =20
>  This package contains a simple test suite for the I/O layer of qemu.
>  It does not require a guest, but only the qemu, qemu-img and qemu-io
>  binaries.  This does limit it to exercise the low-level I/O path only
>  but no actual block drivers like ide, scsi or virtio.
> =20
> -* Usage
> +=3D=3D Usage =3D=3D
> =20
>  Just run ./check to run all tests for the raw image format, or ./check=

>  -qcow2 to test the qcow2 image format.  The output of ./check -h expla=
ins
>  additional options to test further image formats or I/O methods.
> =20
> -* Feedback and patches
> +=3D=3D Writing a QEMU I/O test =3D=3D
> +
> +It's a common practice to start with an existing test that may relate
> +to the task you have.  QEMU I/O tests are usually written either in
> +shell or Python, so it's also a good idea to pick an existing test
> +based on your familiarity with those languages and/or what you
> +anticipate about your test.
> +
> +You can find templates available at "sample_test_templates/", or you
> +can start with an existing test, such as 001 (shell based) or 030
> +(Python based).

It might make sense to mention 194 as an alternative, because 030
represents QMPTestCase-based Python tests and 194 is a plain
output-comparison-based test (like the shell tests) which does not use
that framework.

It should probably be noted somewhere that the shebang line for Python
tests is vital to be exactly "#!/usr/bin/env python".

(Or we could change it to something like "#!qemu-python" to make it
clear that we're not actually invoking env)
> +
> +After you pick your template, name it as a three-digits file, starting=

> +with the next available one.  If `ls -1 ??? | sort -rn | head -1` give=
s
> +you "197", name your test "198".  Finally, add an entry to the "group"=

> +file, which manages just that, test group classification, allowing a
> +user to run all "quick" tests, for instance.

We really need some overview over which groups we have...

I personally just see "Oh, they all have rw auto, so I should put my
test into those groups, too" but that completely defies the purpose.
And nobody ever complains about group classification for a newly added
patch, except when it comes to the quick group...

> +
> +=3D=3D=3D Test configuration, expected results and reporting =3D=3D=3D=

> +
> +The tests are (mostly) standard executable files, that are executed by=

> +"./check" as such.  Tests get most of their configuration (directly or=

> +indirectly) by environment variables.  Some of the framework auxiliary=

> +code (for instance, "common.rc") defines or changes some of the
> +environment variables.  You'll come across tests that reference
> +"$TEST_IMG", "$QEMU_IO" and other variables.
> +
> +The expected results for a test are stored in a file named after the
> +(sequential) test number.  For test 001, the expected output (stdout +=

> +stderr) is stored at 001.out.

There is more that could be said about this (see 051.pc.out or
178.out.qcow2), but this should be enough for this document.  If you
ever need different reference outputs based on something, you'll
probably be able to find out yourself.

> +
> +Tests that finish successfully should exit with status code 0.  To be

s/should/must/ (or "have to")

> +considered a successful run, a test must also produce output that
> +matches what is recorded in the expected output file (say, 001.out).
> +
> +=3D=3D Feedback and patches =3D=3D
> =20
>  Please send improvements to the test suite, general feedback or just
>  reports of failing tests cases to qemu-devel@nongnu.org with a CC:
> diff --git a/tests/qemu-iotests/sample_test_templates/sample.py b/tests=
/qemu-iotests/sample_test_templates/sample.py
> new file mode 100755
> index 0000000000..35a7410b5c
> --- /dev/null
> +++ b/tests/qemu-iotests/sample_test_templates/sample.py
> @@ -0,0 +1,59 @@
> +#!/usr/bin/env python
> +#
> +# DESCRIPTION HERE, such as "Test a complex thing using a simple thing=
"
> +#
> +# COPYRIGHT NOTICE HERE, such as "Copyright (C) YYYY Yourself, Inc.
> +#
> +# This program is free software; you can redistribute it and/or modify=

> +# it under the terms of the GNU General Public License as published by=

> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>=
=2E
> +#
> +# Creator/Owner: your.email@example.com
> +#

As said by the others, I'm not sure we need this line.  git log should
be enough to tell you to whom should send your patch emails for a broken
test. :-)

> +
> +import iotests
> +
> +
> +class Sample(iotests.QMPTestCase):
> +
> +    def setUp(self):
> +        """
> +        Method that runs before test method(s).  Use it to prepare the=

> +        environment that is common to the all tests, but doesn't
> +        necessarily mean that is part of the feature testing
> +        specifics.
> +
> +        Remove this docstring unless you have a really good use for it=
=2E
> +        """
> +        pass
> +
> +    def tearDown(self):
> +        """
> +        Method that runs after the test method(s).  Use it to clean up=

> +        the environment created previously in setUp().
> +
> +        Remove this docstring unless you have a really good use for it=
=2E
> +        """
> +        pass
> +
> +    def test(self):
> +        """
> +        Test code goes here, or in any other method whose name starts
> +        with "test".
> +
> +        It's a good idea to describe what it's about.
> +        """
> +        pass
> +
> +
> +if __name__ =3D=3D '__main__':
> +    iotests.main()

This is a QMPTestCase-based Python test.  That's OK, but I'd really like
194-like tests to gain popularity, so it should be noted somewhere (e.g.
in the README and/or above the Sample class definition here) that you
don't have to follow this structure, but that you can write simple
reference-output-based tests as well.

> diff --git a/tests/qemu-iotests/sample_test_templates/sample.sh b/tests=
/qemu-iotests/sample_test_templates/sample.sh
> new file mode 100755
> index 0000000000..d50e228efc
> --- /dev/null
> +++ b/tests/qemu-iotests/sample_test_templates/sample.sh
> @@ -0,0 +1,40 @@
> +#!/bin/bash
> +#
> +# DESCRIPTION HERE, such as "Test a complex thing using a simple thing=
"
> +#
> +# COPYRIGHT NOTICE HERE, such as "Copyright (C) YYYY Yourself, Inc.
> +#
> +# This program is free software; you can redistribute it and/or modify=

> +# it under the terms of the GNU General Public License as published by=

> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>=
=2E
> +#
> +# Creator/Owner: your.email@example.com
> +#
> +
> +seq=3D`basename $0`

I remember Eric scolded me because he preferred seq=3D"$(basename $0)"
instead.

> +echo "QA output created by $seq"
> +
> +status=3D1	# failure is the default!

Then again, why do we have these four lines anyway?

The echo is pretty pointless, nobody but it uses $seq, nor does anyone
really need $status, do they?

> +
> +# get standard environment, filters and checks
> +. ./common.rc
> +

What about the cleanup function?  I think every shell test has it and it
does make sense to me.

> +# describe supported environment, and then remove this line.
> + _supported_fmt generic
> + _supported_proto generic
> + _supported_os Linux
> +
> +# put your test code goes here, and then remove this line.
> +
> +# success, all done
> +echo "*** done"
> +status=3D0
>=20

I don't think we really need these three lines either... (in no test)

Max


--fKfrt1wWO1bMnPu900Md5jh1JGTLhe8UV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlohxcASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AE4sH/0MrDMkRznHC2BWCvq64df+whbDsJZJ+
3oLUUI3cPqNFjYFLZiTqiFjeWKJmq9WJCM9OWm/VCv7G8mTNSa6FTZUjvH+YZ5ub
nxluUJQBuRNIgGEeiJuLSIMuImshwudJXMZcpFpLjlAAnOKYyUk9bL6PPCtO/gJR
zy+JvLC495bX7CgwifTm4oOf/lbajP8Vp8mYuINgcVlbr1IEx+SPuZHlzZnwoGWZ
w1XDePti89rye+q8cIICVemvwIdaftum3e1qR7zxvteF5f8bjiGdV1YZp8+xH6ws
5bCU5jvMBVZNV1bqihwyNorZBkgEXqsxZpdlepnDmA0Ugsl7Oby3lK0=
=Eaoy
-----END PGP SIGNATURE-----

--fKfrt1wWO1bMnPu900Md5jh1JGTLhe8UV--
