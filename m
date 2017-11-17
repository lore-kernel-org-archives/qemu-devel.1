Received: from eggs.gnu.org ([2001:4830:134:3::10]:52384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eFj81-0000z9-50
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:04:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eFj7z-00041K-Qq
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:04:29 -0500
References: <20171117154739.32565-1-kwolf@redhat.com>
	<20171117154739.32565-3-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <813f3819-077a-b433-70fc-6582a23eb11f@redhat.com>
Date: Fri, 17 Nov 2017 17:04:14 +0100
MIME-Version: 1.0
In-Reply-To: <20171117154739.32565-3-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qGM7oSA3MG3la4oGJvFBWQ2gG3wlEtanE"
Subject: Re: [Qemu-devel] [PATCH for-2.11 2/2] iotests: test clearing
 unknown autoclear_features by qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qGM7oSA3MG3la4oGJvFBWQ2gG3wlEtanE
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org,
 qemu-devel@nongnu.org
Message-ID: <813f3819-077a-b433-70fc-6582a23eb11f@redhat.com>
Subject: Re: [PATCH for-2.11 2/2] iotests: test clearing unknown
 autoclear_features by qcow2
References: <20171117154739.32565-1-kwolf@redhat.com>
 <20171117154739.32565-3-kwolf@redhat.com>
In-Reply-To: <20171117154739.32565-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-17 16:47, Kevin Wolf wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Test clearing unknown autoclear_features by qcow2 on incoming
> migration.
>=20
> [ kwolf: Fixed wait for destination VM startup ]
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/196     | 66 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/196.out |  5 ++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 72 insertions(+)
>  create mode 100755 tests/qemu-iotests/196
>  create mode 100644 tests/qemu-iotests/196.out
>=20
> diff --git a/tests/qemu-iotests/196 b/tests/qemu-iotests/196
> new file mode 100755
> index 0000000000..4116ebc92b
> --- /dev/null
> +++ b/tests/qemu-iotests/196
> @@ -0,0 +1,66 @@
> +#!/usr/bin/env python
> +#
> +# Test clearing unknown autoclear_features flag by qcow2 after
> +# migration. This test mimics migration to older qemu.
> +#
> +# Copyright (c) 2017 Parallels International GmbH
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
> +import os
> +import iotests
> +from iotests import qemu_img
> +
> +disk =3D os.path.join(iotests.test_dir, 'disk')
> +migfile =3D os.path.join(iotests.test_dir, 'migfile')
> +
> +class TestInvalidateAutoclear(iotests.QMPTestCase):
> +
> +    def tearDown(self):
> +        self.vm_a.shutdown()
> +        self.vm_b.shutdown()
> +        os.remove(disk)
> +        os.remove(migfile)
> +
> +    def setUp(self):
> +        qemu_img('create', '-f', iotests.imgfmt, disk, '1M')
> +
> +        self.vm_a =3D iotests.VM(path_suffix=3D'a').add_drive(disk)
> +        self.vm_a.launch()
> +
> +        self.vm_b =3D iotests.VM(path_suffix=3D'b').add_drive(disk)
> +        self.vm_b.add_incoming("exec: cat '" + migfile + "'")
> +
> +    def test_migration(self):
> +        result =3D self.vm_a.qmp('migrate', uri=3D'exec:cat>' + migfil=
e)
> +        self.assert_qmp(result, 'return', {});
> +        self.assertNotEqual(self.vm_a.event_wait("STOP"), None)
> +
> +        with open(disk, 'r+b') as f:
> +            f.seek(88) # first byte of autoclear_features field
> +            f.write(b'\xff')
> +
> +        self.vm_b.launch()
> +        while True:
> +            result =3D self.vm_b.qmp('query-status')
> +            if result['return']['status'] =3D=3D 'running':
> +                break
> +
> +        with open(disk, 'rb') as f:
> +            f.seek(88)
> +            self.assertEqual(f.read(1), b'\x00')

I guess I'd rather shutdown the VM first and do the check then, but
since the header is updated on-disk when opening the qcow2 file...

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +
> +if __name__ =3D=3D '__main__':
> +    iotests.main(supported_fmts=3D['qcow2'])
> diff --git a/tests/qemu-iotests/196.out b/tests/qemu-iotests/196.out
> new file mode 100644
> index 0000000000..ae1213e6f8
> --- /dev/null
> +++ b/tests/qemu-iotests/196.out
> @@ -0,0 +1,5 @@
> +.
> +----------------------------------------------------------------------=

> +Ran 1 tests
> +
> +OK
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 83b839bbe3..1fad602152 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -193,5 +193,6 @@
>  192 rw auto quick
>  194 rw auto migration quick
>  195 rw auto quick
> +196 rw auto quick
>  197 rw auto quick
>  198 rw auto
>=20



--qGM7oSA3MG3la4oGJvFBWQ2gG3wlEtanE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloPCH4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AaEQH/ivmzBgzK6XYJ5wUfFrJAGKYStPDky4J
8ZJwNiFG0HGe4tKmh3jaqfcAb2h25PVTLbo8o7+kwo7FB0cp/YjVayFPeTR2omJI
Wj5B2jcUqaVDQ6UDm/tLo0UGN9BiZI5YgDZ19LHqIaKWKEST+ZTS9gMLNHN104VP
KM5q8lwMHoLdEPoPA+6gWi74MKZQPka5gp/pusRMKUckMuKju6KNIwjEK+wYWYQo
4+zfFIaXuc8f2EXX+7gLjNm/nsDuIcsUQIr8nMZXZL4KBnRJn/g6RnE+pfvuvXBQ
CXBmYlsKkXpkhxhdQCLKQwTxZHXuvzQrDVUNPumIqyjgP1X/MvNfaEg=
=oNSz
-----END PGP SIGNATURE-----

--qGM7oSA3MG3la4oGJvFBWQ2gG3wlEtanE--
