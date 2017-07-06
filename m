Received: from eggs.gnu.org ([2001:4830:134:3::10]:46967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT2n1-0005Kq-AI
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT2my-000126-4Z
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:09:35 -0400
Date: Thu, 6 Jul 2017 10:09:27 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170706090927.GC30447@stefanha-x1.localdomain>
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
	<20170629184320.7151-2-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <20170629184320.7151-2-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 1/3] block: pass bdrv_*
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


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2017 at 09:43:18PM +0300, Manos Pitsidianakis wrote:
> diff --git a/block.c b/block.c
> index 69439628..9e8d34ad 100644
> --- a/block.c
> +++ b/block.c
> @@ -494,6 +494,8 @@ int bdrv_probe_blocksizes(BlockDriverState *bs, Block=
Sizes *bsz)
> =20
>      if (drv && drv->bdrv_probe_blocksizes) {
>          return drv->bdrv_probe_blocksizes(bs, bsz);
> +    } else if (drv && bs->file && bs->file->bs) {
> +        return bdrv_probe_blocksizes(bs->file->bs, bsz);
>      }
> =20
>      return -ENOTSUP;

Currently only raw-format.c and file-posix.c implement
bdrv_probe_blocksizes().  qcow2 will start reporting bs->file's
blocksizes after this patch.

This can lead to a change in blocksizes when live migrating from an old
QEMU to a new QEMU.  Guest operating systems and applications can be
confused if the device suddenly changes beneath them.

On the other hand, it's already possible to hit that today by migrating
=66rom a raw image to a qcow2 image.

I think this change makes sense - we should propagate blocksizes through
the graph - but it may introduce an incompatibility.

Kevin: Do you think this is safe?

> @@ -3406,11 +3410,15 @@ int bdrv_truncate(BdrvChild *child, int64_t offse=
t, Error **errp)
> =20
>      assert(child->perm & BLK_PERM_RESIZE);
> =20
> +    /* if bs->drv =3D=3D NULL, bs is closed, so there's nothing to do he=
re */
>      if (!drv) {
>          error_setg(errp, "No medium inserted");
>          return -ENOMEDIUM;
>      }
>      if (!drv->bdrv_truncate) {
> +        if (bs->file && bs->file->bs) {
> +            return bdrv_truncate(bs->file, offset, errp);
> +        }
>          error_setg(errp, "Image format driver does not support resize");
>          return -ENOTSUP;
>      }

This is not safe because existing image formats (e.g. vmdk, dmg) do not
implement .bdrv_truncate().  If we begin truncating the underlying host
file ("foo.vmdk") the disk image will be corrupted.

It is only safe to forward .bdrv_truncate() in filter drivers.  I
suggest providing a default implementation instead:

int bdrv_truncate_file(...);

Then filters can do:

  .bdrv_truncate =3D bdrv_truncate_file,

> diff --git a/block/io.c b/block/io.c
> index c72d7015..a1aee01d 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2401,6 +2401,11 @@ int bdrv_co_ioctl(BlockDriverState *bs, int req, v=
oid *buf)
>      };
>      BlockAIOCB *acb;
> =20
> +    if (drv && !drv->bdrv_aio_ioctl && !drv->bdrv_co_ioctl &&
> +        bs->file && bs->file->bs) {
> +        return bdrv_co_ioctl(bs->file->bs, req, buf);
> +    }
> +
>      bdrv_inc_in_flight(bs);
>      if (!drv || (!drv->bdrv_aio_ioctl && !drv->bdrv_co_ioctl)) {
>          co.ret =3D -ENOTSUP;

This operation cannot be allowed by default for the same reason as
=2Ebdrv_truncate().  It could change the host file in ways that the format
driver can't handle.  A separate function is needed here:
bdrv_co_ioctl_file().

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZXf5HAAoJEJykq7OBq3PIpt4IAMqNm4r4lHo3iP2xXmhLEPBO
QUNutEn/VAdo1l4RUeMqCGoMWBAjuj/FRqXzcuvoGYm+LuPlbuLF+tYFaWEQnFik
7icx2fTxsAw6MUqeEiS0TtOSi54us3zlvtV/SYeTdbsvDdFLmNnc8PB6Jo3b8NP5
2vaJTNiCrG8LME5XpGebaVoK9jB1TQwx27sK1YuFObw8asb42T9dxU+tMbBhIOCn
LEkZK1SVkFdiUsHx4ShiB4jcavCfETlHNHEEM5JBEKfD+ZPzC7k5sPy0d1CYvcSg
IaPaR92KGt478TT3HOZQiIYqz0ZzM6XJJt7e7LfHHYwFLRcooJlATvQKqnymK9U=
=l1e9
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
