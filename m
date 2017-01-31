Received: from eggs.gnu.org ([2001:4830:134:3::10]:51994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYZoZ-0006lB-OC
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYZoY-0004A3-Nm
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:53:47 -0500
References: <20170131135703.5638-1-nirsof@gmail.com>
	<20170131135703.5638-3-nirsof@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <13faa208-1731-8b71-1dae-4cfc60f47ed5@redhat.com>
Date: Tue, 31 Jan 2017 08:53:34 -0600
MIME-Version: 1.0
In-Reply-To: <20170131135703.5638-3-nirsof@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lj9XnaFkUfte0cdx0hBOxO2TDgDpINQbh"
Subject: Re: [Qemu-devel] [PATCH v4 2/2] qemu-io: Add regression tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Nir Soffer <nsoffer@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lj9XnaFkUfte0cdx0hBOxO2TDgDpINQbh
From: Eric Blake <eblake@redhat.com>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Nir Soffer <nsoffer@redhat.com>, qemu-block@nongnu.org
Message-ID: <13faa208-1731-8b71-1dae-4cfc60f47ed5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/2] qemu-io: Add regression tests
References: <20170131135703.5638-1-nirsof@gmail.com>
 <20170131135703.5638-3-nirsof@gmail.com>
In-Reply-To: <20170131135703.5638-3-nirsof@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2017 07:57 AM, Nir Soffer wrote:
> From: Nir Soffer <nsoffer@redhat.com>
>=20
> Add regression tests checking that qemu-io fail with non-zero exit code=


s/fail/fails/

> when reading non-existing file or using the wrong format.
>=20
> Signed-off-by: Nir Soffer <nirsof@gmail.com>

Odd to have the 'From:' and the 'S-o-b:' from different addresses.  More
on that below...

> ---
>  tests/qemu-iotests/173     | 59 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/173.out |  9 +++++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 69 insertions(+)
>  create mode 100755 tests/qemu-iotests/173
>  create mode 100644 tests/qemu-iotests/173.out
>=20
> diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
> new file mode 100755
> index 0000000..1d1fd6d
> --- /dev/null
> +++ b/tests/qemu-iotests/173
> @@ -0,0 +1,59 @@
> +#!/bin/bash
> +#
> +# Test that qemu-io fail with non-zero exit code
> +#
> +# Copyright (C) 2017 Red Hat, Inc.

A bit unusual to use a Red Hat copyright,...

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
> +
> +# creator
> +owner=3Dnirsof@gmail.com

=2E..but a personal address.  But as I understand, Red Hat doesn't see
anything wrong with that, so the copyright line is no need to respin
(other companies may have different policies, but that's up to employees
of those companies to comply with).  Still, you may want to check
whether .mailmap needs an entry, and/or fix your git config settings to
use a consistent address, since mixing email addresses in the git log
can make it harder to trace which email address you prefer.

> +
> +_supported_fmt raw

Is it worth making this test work for more than just raw?

> +
> +
> +size=3D256K
> +_make_test_img $size
> +
> +echo
> +echo "=3D=3D reading wrong format should fail =3D=3D"
> +$QEMU_IO -f qcow2 -c "read 0 $size" "$TEST_IMG" 2>&1 | _filter_testdir=


If we widen the test to support additional formats, then the '-f qcow2'
would have to be variable to guarantee that it is not the same type as
the current format.

I guess that the point of this test is to ensure qemu-io behaves sanely,
and we've done that with a single format (even if it means that test
doesn't get run on other formats, we aren't really losing much because
it is not a format-specific failure).  So I guess I'm okay with your
decision to just support raw.

> +test "${PIPESTATUS[0]}" -eq 1 || _fail "did not fail"

Thank goodness this is a bash script, as that is a bashism.  But it
works for me.

> +++ b/tests/qemu-iotests/group
> @@ -165,3 +165,4 @@
>  170 rw auto quick
>  171 rw auto quick
>  172 auto
> +173 auto

I already have a pending patch series that adds test 173; it's a trivial
merge conflict for whoever lands second, although if you have a reason
to respin, you may want to grab 174.
https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg02834.html

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--lj9XnaFkUfte0cdx0hBOxO2TDgDpINQbh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkKTuAAoJEKeha0olJ0Nq+JIH/2CmQIsuLOt5mHoow0mi84KD
CMV7l9znojXQlaorADpgCfFS6NCQNpSB0QA8yyNeLHO1hUTlxp556mLEUXjZP23i
VzxRZTnmNod5lBfKbzFL0oCLKmzT8r5gGshwTGjy1w7MDHE6yQfFxpMj4DgAeQs1
g2qX8mQcwx4NABBtTyPE8TW0BYm9O+X6YgPN7tfNVTicE0sxt68IAeQNB7vR2GBL
/Oa9iVxuoIHkexx/+ijMcQGR9QrZ/A5mQoN1Nkbwx4SCCCLlb3+0g8hJlPQ+x/4x
8z7Vvqk0SKHYXTq+5WQA4EkM0smEluFmfm0d5aKcUaE6EXyMB2emxcjqq/IuQAM=
=Zyjz
-----END PGP SIGNATURE-----

--lj9XnaFkUfte0cdx0hBOxO2TDgDpINQbh--
