Received: from eggs.gnu.org ([2001:4830:134:3::10]:53298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1che2u-0001Jr-Fm
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:14:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1che2t-00039R-Fo
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:14:04 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-52-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bbc72854-fae4-d307-7c8e-a6e4d3ae0155@redhat.com>
Date: Sat, 25 Feb 2017 16:13:55 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-52-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="O5A8RW76HWrNIppf6v4A5s6TI9ut8kWaW"
Subject: Re: [Qemu-devel] [PATCH 51/54] block: Assertions for write
 permissions
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
--O5A8RW76HWrNIppf6v4A5s6TI9ut8kWaW
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <bbc72854-fae4-d307-7c8e-a6e4d3ae0155@redhat.com>
Subject: Re: [PATCH 51/54] block: Assertions for write permissions
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-52-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-52-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> This adds assertions that ensure that the necessary write permissions
> have been granted before someone attempts to write to a node.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/io.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/io.c b/block/io.c
> index 63e4400..4c79745 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -925,9 +925,11 @@ bdrv_driver_pwritev_compressed(BlockDriverState *b=
s, uint64_t offset,
>      return drv->bdrv_co_pwritev_compressed(bs, offset, bytes, qiov);
>  }
> =20
> -static int coroutine_fn bdrv_co_do_copy_on_readv(BlockDriverState *bs,=

> +static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
>          int64_t offset, unsigned int bytes, QEMUIOVector *qiov)
>  {
> +    BlockDriverState *bs =3D child->bs;
> +
>      /* Perform I/O through a temporary buffer so that users who scribb=
le over
>       * their read buffer while the operation is in progress do not end=
 up
>       * modifying the image file.  This is critical for zero-copy guest=
 I/O

As I said, I think this hunk needs to be in the previous patch.

Max

> @@ -943,6 +945,8 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(Bl=
ockDriverState *bs,
>      size_t skip_bytes;
>      int ret;
> =20
> +    assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE));=

> +
>      /* Cover entire cluster so no additional backing file I/O is requi=
red when
>       * allocating cluster in the image file.
>       */
> @@ -1051,7 +1055,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvC=
hild *child,
>          }
> =20
>          if (!ret || pnum !=3D nb_sectors) {
> -            ret =3D bdrv_co_do_copy_on_readv(bs, offset, bytes, qiov);=

> +            ret =3D bdrv_co_do_copy_on_readv(child, offset, bytes, qio=
v);
>              goto out;
>          }
>      }
> @@ -1334,6 +1338,7 @@ static int coroutine_fn bdrv_aligned_pwritev(Bdrv=
Child *child,
>      assert(!waited || !req->serialising);
>      assert(req->overlap_offset <=3D offset);
>      assert(offset + bytes <=3D req->overlap_offset + req->overlap_byte=
s);
> +    assert(child->perm & BLK_PERM_WRITE);
> =20
>      ret =3D notifier_with_return_list_notify(&bs->before_write_notifie=
rs, req);
> =20
>=20



--O5A8RW76HWrNIppf6v4A5s6TI9ut8kWaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlixnzMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A6M4H/2LcI3xDI2rVkmf6Ao385cpCqGwDlQJo
RIg/tHW0jTV5pAzVH9CvWCx98wtr0yXx7heCOz4YGniHM8mdxRw5JuPZJYjtgV0G
LrNrQFicSL/Hkqy+6sPlAlJtrnFqehpK3bixG97zeNKWjZO0OvXPv1bAxofh9GaK
ve8PQAYW8ACizOpGSU8aizetP0/ekchel6t9ll50ogSojTEWzOpZuoH1ro7/pZJD
EHeRWuSzx5Y9E1bTrRpSpPF2D7BHVwKS7NFuYxoXhEwFSoiSc25zmxgww9XzwQPQ
tftemsjuSFYqfGGmaP62I4rNhU+2EowiP+u3Iu9q5eGecAr5eMCfyKk=
=2W1Y
-----END PGP SIGNATURE-----

--O5A8RW76HWrNIppf6v4A5s6TI9ut8kWaW--
