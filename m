Received: from eggs.gnu.org ([2001:4830:134:3::10]:34713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dQa61-0005jz-Jb
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dQa60-0006nX-NL
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:07:01 -0400
Date: Thu, 29 Jun 2017 15:00:35 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170629140035.GA18146@stefanha-x1.localdomain>
References: <20170627224616.18538-1-el13635@mail.ntua.gr>
	<20170627224616.18538-2-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20170627224616.18538-2-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] block: pass bdrv_*
 methods to bs->file by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2017 at 01:46:15AM +0300, Manos Pitsidianakis wrote:
> @@ -3406,13 +3410,18 @@ int bdrv_truncate(BdrvChild *child, int64_t offse=
t, Error **errp)
> =20
>      assert(child->perm & BLK_PERM_RESIZE);
> =20
> -    if (!drv) {
> -        error_setg(errp, "No medium inserted");
> -        return -ENOMEDIUM;
> -    }
> -    if (!drv->bdrv_truncate) {
> -        error_setg(errp, "Image format driver does not support resize");
> -        return -ENOTSUP;
> +    if (!drv || !drv->bdrv_truncate) {

bs->drv =3D=3D NULL means the BDS is closed.  We should not forward to
bs->file.  In practice bs->file will be NULL but please leave the
original if statement unchanged so it's clear that !drv results in
-ENOMEDIUM.

The same applies to the other changes below.

> @@ -3832,10 +3844,15 @@ void bdrv_get_backing_filename(BlockDriverState *=
bs,
>  int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
>  {
>      BlockDriver *drv =3D bs->drv;
> -    if (!drv)
> -        return -ENOMEDIUM;
> -    if (!drv->bdrv_get_info)
> -        return -ENOTSUP;
> +    if (!drv || !drv->bdrv_get_info) {
> +        if (bs->file && bs->file->bs) {
> +            return bdrv_get_info(bs->file->bs, bdi);
> +        }
> +        if (!drv)
> +            return -ENOMEDIUM;

QEMU coding style always uses curly braces, even when the if statement
body is just 1 line.

> diff --git a/block/io.c b/block/io.c
> index c72d7015..c1b73226 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2403,6 +2403,10 @@ int bdrv_co_ioctl(BlockDriverState *bs, int req, v=
oid *buf)
> =20
>      bdrv_inc_in_flight(bs);
>      if (!drv || (!drv->bdrv_aio_ioctl && !drv->bdrv_co_ioctl)) {
> +        if (bs->file && bs->file->bs) {
> +            bdrv_dec_in_flight(bs);
> +            return bdrv_co_ioctl(bs->file->bs, req, buf);

bdrv_dec_in_flight() must happen after the request finishes, otherwise
bdrv_drain() will break.

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZVQgCAAoJEJykq7OBq3PI2gEH/0moPTQjJxRyf5rKMsDsspbL
k4BqSR0cHd2wmqLnwm06PCQ8eVsZEUUujSls48hg7FsxOm4R9dSWzTmh2pZYd8Qe
L5DoJbhtauXD3YJf18TbPTVfcVLSSn3PyeoxrTeQKJWRtnhdWKwBW/l5CcNjXBbg
BsIqL9wDJy62BiJzdMbPJcjGz+nQGhcDWTuZgSLiC4IJ4rEHPFjmXhhVipHzzJOt
wQdDDuoFlfVh5EChg0fgqju/xDvofEixml27Q+FxrWpWgPb1EKb2iXWLdIi3t7SP
jVqlx96wEtBahOhnBEkMrHfbucAzETTD9ecUfZdVzaxp4Jp8kOLtmIeZC0uSFys=
=7hx9
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
