Received: from eggs.gnu.org ([2001:4830:134:3::10]:59636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGVSA-0007S6-Ne
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGVS6-00036r-KR
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:08:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGVS6-00036c-AL
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:08:10 -0400
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496330073-51338-2-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <998632ec-09c0-4365-e965-9ee7b780931f@redhat.com>
Date: Thu, 1 Jun 2017 14:07:59 -0500
MIME-Version: 1.0
In-Reply-To: <1496330073-51338-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="50l21EMpGmEkTVGLF28JuR3dJrfSC1JvS"
Subject: Re: [Qemu-devel] [PATCH v2 01/15] block: introduce
 BDRV_REQ_ALLOCATE flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--50l21EMpGmEkTVGLF28JuR3dJrfSC1JvS
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <998632ec-09c0-4365-e965-9ee7b780931f@redhat.com>
Subject: Re: [PATCH v2 01/15] block: introduce BDRV_REQ_ALLOCATE flag
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1496330073-51338-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496330073-51338-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 10:14 AM, Anton Nefedov wrote:
> The flag is supposed to indicate that the region of the disk image has
> to be sufficiently allocated so it reads as zeroes. The call with the f=
lag
> set has to return -ENOTSUP if allocation cannot be done efficiently
> (i.e. without falling back to writing actual buffers)
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/io.c            | 19 ++++++++++++++++---
>  block/trace-events    |  1 +
>  include/block/block.h |  6 +++++-
>  3 files changed, 22 insertions(+), 4 deletions(-)

You may want to 'git config diff.orderFile /path/to/file' (with a
suitably populated file) so that .h files come first in your diffs, as
that can aid reviewers.  At one point, there was a thread about adding
such a file to qemu.git proper for everyone to share, although it seems
to have stalled.

>=20
> diff --git a/block/io.c b/block/io.c
> index ed31810..d47efa9 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1272,7 +1272,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(=
BlockDriverState *bs,
>              assert(!bs->supported_zero_flags);
>          }
> =20
> -        if (ret =3D=3D -ENOTSUP) {
> +        if (ret =3D=3D -ENOTSUP && !(flags & BDRV_REQ_ALLOCATE)) {

I'd feel MUCH better if you first fixed the conditional just above this
point to ensure that if the caller requests BDRV_REQ_ALLOCATE that we do
not call bdrv->bdrv_co_pwrite_zeroes() unless bs->supported_zero_flags
also mentions this bit.

Remember, the existing semantics of .bdrv_co_pwrite_zeroes() merely
state that we must return -ENOTSUP unless we can guarantee that we read
back as zeroes, but puts no timing constraints on it.  A driver that has
not been retrofitted to understand the BDRV_REQ_ALLOCATE flag will
therefore risk taking too long.  Using bs->supported_zero_flags as your
gate is what will let you avoid calling into a driver that has not been
audited for fitting the new contract.

>              /* Fall back to bounce buffer if write zeroes is unsupport=
ed */
>              BdrvRequestFlags write_flags =3D flags & ~BDRV_REQ_ZERO_WR=
ITE;
> =20
> @@ -1355,8 +1355,8 @@ static int coroutine_fn bdrv_aligned_pwritev(Bdrv=
Child *child,
>      ret =3D notifier_with_return_list_notify(&bs->before_write_notifie=
rs, req);
> =20
>      if (!ret && bs->detect_zeroes !=3D BLOCKDEV_DETECT_ZEROES_OPTIONS_=
OFF &&
> -        !(flags & BDRV_REQ_ZERO_WRITE) && drv->bdrv_co_pwrite_zeroes &=
&
> -        qemu_iovec_is_zero(qiov)) {
> +        !(flags & BDRV_REQ_ZERO_WRITE) && !(flags & BDRV_REQ_ALLOCATE)=
 &&
> +        drv->bdrv_co_pwrite_zeroes && qemu_iovec_is_zero(qiov)) {
>          flags |=3D BDRV_REQ_ZERO_WRITE;
>          if (bs->detect_zeroes =3D=3D BLOCKDEV_DETECT_ZEROES_OPTIONS_UN=
MAP) {
>              flags |=3D BDRV_REQ_MAY_UNMAP;
> @@ -1436,6 +1436,9 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(B=
drvChild *child,
> =20
>      assert(flags & BDRV_REQ_ZERO_WRITE);
>      if (head_padding_bytes || tail_padding_bytes) {
> +        if (flags & BDRV_REQ_ALLOCATE) {
> +            return -ENOTSUP;
> +        }

Can we assert that BDRV_REQ_ALLOCATE will only be supplied by a caller
that is already using aligned values?  Or is that too strict?

>          buf =3D qemu_blockalign(bs, align);
>          iov =3D (struct iovec) {
>              .iov_base   =3D buf,
> @@ -1534,6 +1537,11 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *chil=
d,
>          return ret;
>      }
> =20
> +    if (qiov && flags & BDRV_REQ_ALLOCATE) {
> +        /* allocation request with qiov provided doesn't make much sen=
se */
> +        return -ENOTSUP;

Should this be an assertion (bug in the program for mixing things that
don't make sense) rather than just a runtime error return?

> +    }
> +
>      bdrv_inc_in_flight(bs);
>      /*
>       * Align write if necessary by performing a read-modify-write cycl=
e.
> @@ -1665,6 +1673,11 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild=
 *child, int64_t offset,
>  {
>      trace_bdrv_co_pwrite_zeroes(child->bs, offset, count, flags);
> =20
> +    if (flags & BDRV_REQ_MAY_UNMAP && flags & BDRV_REQ_ALLOCATE) {
> +        /* nonsense */
> +        return -ENOTSUP;
> +    }

Ditto.

> +
>      if (!(child->bs->open_flags & BDRV_O_UNMAP)) {
>          flags &=3D ~BDRV_REQ_MAY_UNMAP;
>      }
> diff --git a/block/trace-events b/block/trace-events
> index 9a71c7f..a15c2cc 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -15,6 +15,7 @@ bdrv_aio_writev(void *bs, int64_t sector_num, int nb_=
sectors, void *opaque) "bs
>  bdrv_co_readv(void *bs, int64_t sector_num, int nb_sector) "bs %p sect=
or_num %"PRId64" nb_sectors %d"
>  bdrv_co_writev(void *bs, int64_t sector_num, int nb_sector) "bs %p sec=
tor_num %"PRId64" nb_sectors %d"
>  bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) =
"bs %p offset %"PRId64" count %d flags %#x"
> +bdrv_co_allocate(void *bs, int64_t offset, int count) "bs %p offset %"=
PRId64" count %d"
>  bdrv_co_do_copy_on_readv(void *bs, int64_t offset, unsigned int bytes,=
 int64_t cluster_offset, unsigned int cluster_bytes) "bs %p offset %"PRId=
64" bytes %u cluster_offset %"PRId64" cluster_bytes %u"
> =20
>  # block/stream.c
> diff --git a/include/block/block.h b/include/block/block.h
> index 9b355e9..53a357c 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -65,9 +65,13 @@ typedef enum {
>      BDRV_REQ_NO_SERIALISING     =3D 0x8,
>      BDRV_REQ_FUA                =3D 0x10,
>      BDRV_REQ_WRITE_COMPRESSED   =3D 0x20,
> +    /* BDRV_REQ_ALLOCATE is used to indicate that the driver is to
> +     * efficiently allocate the space so it reads as zeroes or return =
an error
> +     */
> +    BDRV_REQ_ALLOCATE           =3D 0x40,

Doesn't match how the other flags are documented, but any documentation
is better than none.

Missing mention of the new flag in the documentation for
supported_zero_flags.

> =20
>      /* Mask of valid flags */
> -    BDRV_REQ_MASK               =3D 0x3f,
> +    BDRV_REQ_MASK               =3D 0x7f,
>  } BdrvRequestFlags;
> =20
>  typedef struct BlockSizes {
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--50l21EMpGmEkTVGLF28JuR3dJrfSC1JvS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMGYPAAoJEKeha0olJ0NqNqcIAKKxcvWoreSa9GpSW5Swg/NE
Tzv/v/h56F9/BKX3F2CVZUxsRb79nw1IBEQZgQGcOK4y6wx6hOOHBQJf57GVj11s
9VsbpEE8D6Enh4ooFa4lLuiI2UOVDGPNn7ceTyY7yhPcwB1FBSoc4yzoGuvuSGi0
tKs82MVUzd+BaVsbvX9c0gzWQh54JQo3rfWrDBBM6CM21k7znJtxrTBbru7Fuw4X
lzINpInfwcdHTMJhtGfrPVbMKpFPl85GS92qzOEWQnMe8egnk3lXV9bejyK0SddC
uxj+P5CNx2XsYTW2REb2z2iPCGN2Y/hs1HM+9729cLU09Bi6ikI8p8NfV0kIQY8=
=m9dX
-----END PGP SIGNATURE-----

--50l21EMpGmEkTVGLF28JuR3dJrfSC1JvS--
