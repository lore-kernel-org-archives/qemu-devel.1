Received: from eggs.gnu.org ([2001:4830:134:3::10]:37160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3TVK-0002Q2-Of
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 16:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3TVJ-0007xC-Kr
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 16:25:38 -0400
References: <1492768654-11053-1-git-send-email-lidongchen@tencent.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e2c5132f-abd5-131d-c65b-b6fbdaa7b9bb@redhat.com>
Date: Wed, 26 Apr 2017 22:25:28 +0200
MIME-Version: 1.0
In-Reply-To: <1492768654-11053-1-git-send-email-lidongchen@tencent.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SmikCgu7jeCQMV7Q0LvAoNlGKRd3Fc7D1"
Subject: Re: [Qemu-devel] [PATCH v2] qemu-img: use blk_co_pwrite_zeroes for
 zero sectors when compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jemmy858585@gmail.com, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SmikCgu7jeCQMV7Q0LvAoNlGKRd3Fc7D1
From: Max Reitz <mreitz@redhat.com>
To: jemmy858585@gmail.com, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Lidong Chen <lidongchen@tencent.com>
Message-ID: <e2c5132f-abd5-131d-c65b-b6fbdaa7b9bb@redhat.com>
Subject: Re: [PATCH v2] qemu-img: use blk_co_pwrite_zeroes for zero sectors
 when compressed
References: <1492768654-11053-1-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1492768654-11053-1-git-send-email-lidongchen@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.04.2017 11:57, jemmy858585@gmail.com wrote:
> From: Lidong Chen <lidongchen@tencent.com>
>=20
> when the buffer is zero, blk_co_pwrite_zeroes is more effectively than

s/when/When/, s/effectively/effective/

> blk_co_pwritev with BDRV_REQ_WRITE_COMPRESSED. this patch can reduces

s/this/This/, s/reduces/reduce/

> the time when converts the qcow2 image with lots of zero.

s/when converts the qcow2 image/for converting qcow2 images/,
s/zero/zero data/

>=20
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---
> v2 changelog:
>     unify the compressed and non-compressed code paths
> ---
>  qemu-img.c | 41 +++++++++++------------------------------
>  1 file changed, 11 insertions(+), 30 deletions(-)

Functionally, looks good to me. Just some stylistic nit picks:

>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index b220cf7..60c9adf 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1661,6 +1661,8 @@ static int coroutine_fn convert_co_write(ImgConve=
rtState *s, int64_t sector_num,
> =20
>      while (nb_sectors > 0) {
>          int n =3D nb_sectors;
> +        BdrvRequestFlags flags =3D s->compressed ? BDRV_REQ_WRITE_COMP=
RESSED : 0;
> +
>          switch (status) {
>          case BLK_BACKING_FILE:
>              /* If we have a backing file, leave clusters unallocated t=
hat are
> @@ -1670,43 +1672,21 @@ static int coroutine_fn convert_co_write(ImgCon=
vertState *s, int64_t sector_num,
>              break;
> =20
>          case BLK_DATA:
> -            /* We must always write compressed clusters as a whole, so=
 don't
> -             * try to find zeroed parts in the buffer. We can only sav=
e the
> -             * write if the buffer is completely zeroed and we're allo=
wed to
> -             * keep the target sparse. */
> -            if (s->compressed) {
> -                if (s->has_zero_init && s->min_sparse &&
> -                    buffer_is_zero(buf, n * BDRV_SECTOR_SIZE))
> -                {
> -                    assert(!s->target_has_backing);
> -                    break;
> -                }
> -
> -                iov.iov_base =3D buf;
> -                iov.iov_len =3D n << BDRV_SECTOR_BITS;
> -                qemu_iovec_init_external(&qiov, &iov, 1);
> -
> -                ret =3D blk_co_pwritev(s->target, sector_num << BDRV_S=
ECTOR_BITS,
> -                                     n << BDRV_SECTOR_BITS, &qiov,
> -                                     BDRV_REQ_WRITE_COMPRESSED);
> -                if (ret < 0) {
> -                    return ret;
> -                }
> -                break;
> -            }
> -
> -            /* If there is real non-zero data or we're told to keep th=
e target
> -             * fully allocated (-S 0), we must write it. Otherwise we =
can treat
> +            /* If we're told to keep the target fully allocated (-S 0)=
 or there
> +             * is real non-zero data, we must write it. Otherwise we c=
an treat
>               * it as zero sectors. */

I think we should still mention why there is a difference depending on
s->compressed. Maybe like this:

/* If we're told to keep the target fully allocated (-S 0) or there
 * is real non-zero data, we must write it. Otherwise we can treat
 * it as zero sectors.
 * Compressed clusters need to be written as a whole, so in that
 * case we can only save the write if the buffer is completely
 * zeroed. */

>              if (!s->min_sparse ||
> -                is_allocated_sectors_min(buf, n, &n, s->min_sparse))
> -            {
> +                (!s->compressed &&
> +                 is_allocated_sectors_min(buf, n, &n, s->min_sparse)) =
||
> +                (s->compressed &&
> +                 !buffer_is_zero(buf, n * BDRV_SECTOR_SIZE))) {
> +

This newline is a bit weird. Normally we don't have newlines at the
start of a block.

If you (like me) think there should be a visual separation between the
if condition and the block, I'd suggest keeping the opening brace { on
its own line (as it is now).

Max

>                  iov.iov_base =3D buf;
>                  iov.iov_len =3D n << BDRV_SECTOR_BITS;
>                  qemu_iovec_init_external(&qiov, &iov, 1);
> =20
>                  ret =3D blk_co_pwritev(s->target, sector_num << BDRV_S=
ECTOR_BITS,
> -                                     n << BDRV_SECTOR_BITS, &qiov, 0);=

> +                                     n << BDRV_SECTOR_BITS, &qiov, fla=
gs);
>                  if (ret < 0) {
>                      return ret;
>                  }
> @@ -1716,6 +1696,7 @@ static int coroutine_fn convert_co_write(ImgConve=
rtState *s, int64_t sector_num,
> =20
>          case BLK_ZERO:
>              if (s->has_zero_init) {
> +                assert(!s->target_has_backing);
>                  break;
>              }
>              ret =3D blk_co_pwrite_zeroes(s->target,
>=20



--SmikCgu7jeCQMV7Q0LvAoNlGKRd3Fc7D1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkBAjgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ACIQH/3dTECenSfc7oJNtI/ZLSLru39tq1+Wi
vyGcz3tu8iVLeHkrJM/An8w8PYo63HhBFv8wa5mAmNi5qC8gBMxJC5e3W6tPCj1p
9qxuiRukF5i3r0WFbKNzRGeo1wNrRGMlO3HgslEZIRkXGViLZRA3ojW+TaOv18w5
RuDsLqWaI1ahNOEcpmlukFQyC+UDDbJUEvo7E9ZsQBvtfpTF2uIXSUeT+C/qhLcK
nkw+5YR2FekP3dMibBHWnslJj/q2CbzkJU6/C0BWFKzrSG5zjPpAeu3v6SzSTHKv
+ev3muyGRy/DyHVlectrt/TEN5XVhNYH+LWoq+pa906bqDz0ECK1VJM=
=SCBj
-----END PGP SIGNATURE-----

--SmikCgu7jeCQMV7Q0LvAoNlGKRd3Fc7D1--
