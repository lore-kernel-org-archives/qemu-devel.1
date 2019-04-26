Received: from eggs.gnu.org ([209.51.188.92]:57716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK7us-00039i-F7
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 16:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK7ur-0007Z5-53
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 16:57:54 -0400
References: <cover.1554985749.git.berto@igalia.com>
	<437727cd1a4ba03312b56d331f2f69fe92846af8.1554985749.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <23d216b2-409c-d397-18ca-3c4662dedf52@redhat.com>
Date: Fri, 26 Apr 2019 22:57:46 +0200
MIME-Version: 1.0
In-Reply-To: <437727cd1a4ba03312b56d331f2f69fe92846af8.1554985749.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eWs7BqQPGXigAC6PLHcHUUI0Z56CSIcV6"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 2/2] iotests: Check that images
 are in read-only mode after block-commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eWs7BqQPGXigAC6PLHcHUUI0Z56CSIcV6
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <23d216b2-409c-d397-18ca-3c4662dedf52@redhat.com>
Subject: Re: [PATCH for-4.1 v2 2/2] iotests: Check that images are in
 read-only mode after block-commit
References: <cover.1554985749.git.berto@igalia.com>
 <437727cd1a4ba03312b56d331f2f69fe92846af8.1554985749.git.berto@igalia.com>
In-Reply-To: <437727cd1a4ba03312b56d331f2f69fe92846af8.1554985749.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.04.19 14:32, Alberto Garcia wrote:
> This tests the fix from the previous patch.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/qemu-iotests/249     | 115 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/249.out |  35 ++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 151 insertions(+)
>  create mode 100755 tests/qemu-iotests/249
>  create mode 100644 tests/qemu-iotests/249.out
>=20
> diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
> new file mode 100755
> index 0000000000..a6ee2ef492
> --- /dev/null
> +++ b/tests/qemu-iotests/249
> @@ -0,0 +1,115 @@
> +#!/usr/bin/env bash
> +#
> +# Test that a backing image is put back in read-only mode after
> +# block-commit (both when it fails and when it succeeds).
> +#
> +# Copyright (C) 2019 Igalia, S.L.
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
> +owner=3Dberto@igalia.com
> +
> +seq=3D`basename $0`

I have been berated for not using $() here...

> +echo "QA output created by $seq"
> +
> +here=3D`pwd`

=2E..and including this line here, so I suppose I'll pass that criticism
along. O:-)

Otherwise, the test looks good to me, just one thing...

[...]

> +echo
> +echo '=3D=3D=3D Run block-commit on base using the default filter node=
 name'
> +echo
> +_send_qemu_cmd $QEMU_HANDLE \
> +    "{ 'execute': 'block-commit',
> +       'arguments': {'job-id': 'job0', 'device': 'none1', 'top-node': =
'int'}}" \
> +    'return'
> +
> +# Wait for block-commit to finish
> +sleep 0.5

Why not just

_send_qemu_cmd $QEMU_HANDLE '' \
    '"status": "null"'

?

First, that would avoid timing issues.  Second, this places all the job
logs above the "=3D=3D=3D Send a write command [...] (3)" line.

Max

> +echo
> +echo '=3D=3D=3D Send a write command to a drive opened in read-only mo=
de (3)'
> +echo


--eWs7BqQPGXigAC6PLHcHUUI0Z56CSIcV6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzDcMoACgkQ9AfbAGHV
z0CsyQf+MKjfVAfOiV2TpRACOltI4KxpxUkPfwHACjbRM40ifphplRTU2uQe2cyY
jOuvABdQaFbl5xHoGH8B1MRBS/gxKKO3+LzrKYaCywqQ6g9YR38ZXJoVrEyWWb6j
Yw2BR67trfR83m4Tc7z22V//cKi5IjQ6k0owrKs4Yl36d3L6NM/hb9Se/NzwmXOM
GD4OzRzOJh4YhNk8GgT7pkKhKCgwiwiov9PCBzVehWLmxoRdGTujmRexosYmxHC4
cDm4473+HPx72UkdZv0XYPXUhIh84/Ev0UmTHp4kSrlFaNmpmcczGEzPPXkhZOUp
AmIUqPNr6zAnw1VlNfsRvfdAB1GSrA==
=+E4O
-----END PGP SIGNATURE-----

--eWs7BqQPGXigAC6PLHcHUUI0Z56CSIcV6--
