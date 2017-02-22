Received: from eggs.gnu.org ([2001:4830:134:3::10]:45701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgWTY-0008TI-RY
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgWTY-0005rZ-3K
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:56:56 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-8-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <18c67b42-2d42-c600-216c-7a35ee8830ab@redhat.com>
Date: Wed, 22 Feb 2017 13:56:47 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-8-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i127OLwfP3GvIxG2eJrJA2hsOG146T2I5"
Subject: Re: [Qemu-devel] [PATCH 07/54] block: Use BlockBackend for image
 probing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i127OLwfP3GvIxG2eJrJA2hsOG146T2I5
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <18c67b42-2d42-c600-216c-7a35ee8830ab@redhat.com>
Subject: Re: [PATCH 07/54] block: Use BlockBackend for image probing
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-8-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> This fixes the use of a parent-less BdrvChild in bdrv_open_inherit() by=

> converting it into a BlockBackend. Which is exactly what it should be,
> image probing is an external, standalone user of a node. The requests
> can't be considered to originate from the format driver node because
> that one isn't even opened yet.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index e9d90aa..0f17576 100644
> --- a/block.c
> +++ b/block.c

[...]

> @@ -1922,7 +1926,7 @@ static BlockDriverState *bdrv_open_inherit(const =
char *filename,
> =20
>  fail:
>      if (file !=3D NULL) {
> -        bdrv_unref_child(bs, file);
> +        blk_unref(file);
>      }

You could drop the now superfluous condition around it, but anyway:

Reviewed-by: Max Reitz <mreitz@redhat.com>

(Also, you could revert the change to bdrv_unref_child() done in patch 5.=
)

Max

>      if (bs->file !=3D NULL) {
>          bdrv_unref_child(bs, bs->file);
>=20



--i127OLwfP3GvIxG2eJrJA2hsOG146T2I5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitio8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AD9oH/2Rq66XoNV7Rkfq4Ax8QqWIUO+lZtOZl
ryNiR3+2DP0uAeE1Q1L5v6ZecoPv6NyW19KJx895V05/RFgs1sTvS2OKD4UG9u8u
OoTBd/3/398E+w8qACBwoWN0P2cgiS7RzdtGlyEmyAOp8kykf8aBr83wK/D+/TEQ
ScYRMWyFm2FNb0EoC+HGbGVbKn3gqkBylfoWItnWg2eroj0rdtPcAs4G9pjdf2hZ
VDNXRgMR0SWyztEBPieyLDvFSqTYRmWRQanboKPfEjDweCcQC4hhp1wElgBXq32d
2Y4Vhr/ae/E3rtiIExPt3X+PA8vEZudFphdcBR0MdT2Yc6MT8JyouEg=
=AM0F
-----END PGP SIGNATURE-----

--i127OLwfP3GvIxG2eJrJA2hsOG146T2I5--
