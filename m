Received: from eggs.gnu.org ([2001:4830:134:3::10]:58524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cflx7-0004wF-Vo
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:16:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cflx6-00048R-UR
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:16:21 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-18-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <82620383-eadb-b0d7-ba73-12f17d7eb798@redhat.com>
Date: Mon, 20 Feb 2017 12:16:10 +0100
MIME-Version: 1.0
In-Reply-To: <1487006583-24350-18-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="H39aPSwFG71PPr4oCGX9nUFAgXCAF9qX1"
Subject: Re: [Qemu-devel] [RFC PATCH 17/41] block: Request real permissions
 in blk_new_open()
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
--H39aPSwFG71PPr4oCGX9nUFAgXCAF9qX1
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <82620383-eadb-b0d7-ba73-12f17d7eb798@redhat.com>
Subject: Re: [RFC PATCH 17/41] block: Request real permissions in
 blk_new_open()
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-18-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-18-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 18:22, Kevin Wolf wrote:
> We can figure out the necessary permissions from the flags that the
> caller passed.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/block-backend.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 1f80854..e10a278 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -160,6 +160,7 @@ BlockBackend *blk_new_open(const char *filename, co=
nst char *reference,
>  {
>      BlockBackend *blk;
>      BlockDriverState *bs;
> +    uint64_t perm;
> =20
>      blk =3D blk_new(0, BLK_PERM_ALL);

What about this?

Max

>      bs =3D bdrv_open(filename, reference, options, flags, errp);
> @@ -168,9 +169,20 @@ BlockBackend *blk_new_open(const char *filename, c=
onst char *reference,
>          return NULL;
>      }
> =20
> -    /* FIXME Use real permissions */
> +    /* blk_new_open() is mainly used in .bdrv_create implementations a=
nd the
> +     * tools where sharing isn't a concern because the BDS stays priva=
te, so we
> +     * just request permission according to the flags.
> +     *
> +     * The exceptions are xen_disk and blockdev_init(); in these cases=
, the
> +     * caller of blk_new_open() doesn't make use of the permissions, b=
ut they
> +     * shouldn't hurt either. We can still share everything here becau=
se the
> +     * guest devices will add their own blockers if they can't share. =
*/
> +    perm =3D BLK_PERM_CONSISTENT_READ;
> +    if (flags & BDRV_O_RDWR) {
> +        perm |=3D BLK_PERM_WRITE;
> +    }
>      blk->root =3D bdrv_root_attach_child(bs, "root", &child_root,
> -                                       0, BLK_PERM_ALL, blk, &error_ab=
ort);
> +                                       perm, BLK_PERM_ALL, blk, &error=
_abort);
> =20
>      return blk;
>  }
>=20



--H39aPSwFG71PPr4oCGX9nUFAgXCAF9qX1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliqz/oSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ALLQIAIpgTJB8k1EaC62uNVHTm7PndZ7MKCnE
i2uLD/tRA4Ehux1heWc4bfRGR9qhQ3gwjh2ZVNQuH9oBkGtlsilgmNPToafi2/Hi
NXOZa8QS/VwQC4bvrPx8TBQrbozCkMpZsL9xhpadxRGQE02mIiYE/t65fLFO5OoQ
6s9XrvPnVj1FX4t6r+wyWUU8JbHU4G78BafTroCQ1hNDoPl1zsT25tPgcizKY+Or
auMAEkAFAbHPkQmjJWuuv7y5lTWOCb8sjImcaUU4F6B3svwsiyEAug9dFZqHKiYo
82PN61NoZNqK75qFL5VUFzhmGK72YJcxhQlyFM16A/ykWD+2NOKwIRA=
=6Saw
-----END PGP SIGNATURE-----

--H39aPSwFG71PPr4oCGX9nUFAgXCAF9qX1--
