Received: from eggs.gnu.org ([2001:4830:134:3::10]:48361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGt20-0001Xh-9J
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGt1z-0006gm-AE
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:51:04 -0500
References: <20171106145345.12038-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <281c6f1c-1d60-bc3d-ac55-be8974c34b05@redhat.com>
Date: Mon, 20 Nov 2017 21:50:53 +0100
MIME-Version: 1.0
In-Reply-To: <20171106145345.12038-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D7DqlrHbpg3KWmIFSIPWKmtVoQL21EnAN"
Subject: Re: [Qemu-devel] [PATCH] block: Close a BlockDriverState completely
 even when bs->drv is NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D7DqlrHbpg3KWmIFSIPWKmtVoQL21EnAN
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <281c6f1c-1d60-bc3d-ac55-be8974c34b05@redhat.com>
Subject: Re: [PATCH] block: Close a BlockDriverState completely even when
 bs->drv is NULL
References: <20171106145345.12038-1-berto@igalia.com>
In-Reply-To: <20171106145345.12038-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-06 15:53, Alberto Garcia wrote:
> bdrv_close() skips much of its logic when bs->drv is NULL. This is
> fine when we're closing a BlockDriverState that has just been created
> (because e.g the initialization process failed), but it's not enough
> in other cases.
>=20
> For example, when a valid qcow2 image is found to be corrupted then
> QEMU marks it as such in the file header and then sets bs->drv to
> NULL in order to make the BlockDriverState unusable. When that BDS is
> later closed then many of its data structures are not freed (leaking
> their memory) and none of its children are detached. This results in
> bdrv_close_all() failing to close all BDSs and making this assertion
> fail when QEMU is being shut down:
>=20
>    bdrv_close_all: Assertion `QTAILQ_EMPTY(&all_bdrv_states)' failed.
>=20
> This patch makes bdrv_close() do the full uninitialization process
> in all cases. This fixes the problem with corrupted images and still
> works fine with freshly created BDSs.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c                    | 57 +++++++++++++++++++++++---------------=
--------
>  tests/qemu-iotests/060     | 13 +++++++++++
>  tests/qemu-iotests/060.out | 12 ++++++++++
>  3 files changed, 53 insertions(+), 29 deletions(-)

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--D7DqlrHbpg3KWmIFSIPWKmtVoQL21EnAN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloTQC0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ahu4H/Ri/lzm9VY0MH+fK9o2InZQVE+SnxJqp
hWRArQM5O5DMvUSFydXLSf4kR71InYi+UIGyxXnjL50aqjO8m4iUH/kJfNup3gIw
UkFNE29oOY2RF2OApsiRcsZp3rTDfgjhtLfD5wd2GPB1Mamuq4Fu9IgfueYPuxVY
0NF3PPtA8d7Gngrz1YiaMxh39Bd8LLzbP+XOi5gmaTEjrAMRbddtP10IJ6IX1gYT
FUraDyiFKmKKdpxP0shGlKJyL3/AMvOlxbbRZbC4C92kwyc4ymYjGg/ShzEzOsxL
J/Q2Ka08h70uiIwPDROMMBHxDmo9Wlt6yzNFLXBO1ewWNSGP9uS5V4I=
=KecS
-----END PGP SIGNATURE-----

--D7DqlrHbpg3KWmIFSIPWKmtVoQL21EnAN--
