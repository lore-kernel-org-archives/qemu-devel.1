Received: from eggs.gnu.org ([2001:4830:134:3::10]:39673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ciNv1-0005os-1N
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:13:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ciNuz-0000Dz-HV
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:12:59 -0500
References: <20170227004545.hzpr266jzturlxdh@var.youpi.perso.aquilenet.fr>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4bbc4d50-3c87-bd83-b74d-6aa8b020f2c1@redhat.com>
Date: Mon, 27 Feb 2017 17:12:47 +0100
MIME-Version: 1.0
In-Reply-To: <20170227004545.hzpr266jzturlxdh@var.youpi.perso.aquilenet.fr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xs7gA6T9X5O576G7xsu1qaRHuObI0ei6d"
Subject: Re: [Qemu-devel] [PATCH] blk: Add discard=sparse mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xs7gA6T9X5O576G7xsu1qaRHuObI0ei6d
From: Max Reitz <mreitz@redhat.com>
To: Samuel Thibault <samuel.thibault@gnu.org>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <4bbc4d50-3c87-bd83-b74d-6aa8b020f2c1@redhat.com>
Subject: Re: [PATCH] blk: Add discard=sparse mode
References: <20170227004545.hzpr266jzturlxdh@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20170227004545.hzpr266jzturlxdh@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 27.02.2017 01:45, Samuel Thibault wrote:
> By default, on discard requests, the posix block backend punches holes =
but
> re-fallocates them to keep the allocated size intact. In some situation=
s
> it is however convenient, when using sparse disk images, to see disk im=
age
> sizes shrink on discard requests.
>=20
> This commit adds a discard=3Dsparse mode which does this, by disabling =
the
> fallocate call.
>=20
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>=20
> diff --git a/block.c b/block.c
> index b663204f3f..e9cd83210a 100644
> --- a/block.c
> +++ b/block.c
> @@ -665,12 +665,14 @@ static void bdrv_join_options(BlockDriverState *b=
s, QDict *options,
>   */
>  int bdrv_parse_discard_flags(const char *mode, int *flags)
>  {
> -    *flags &=3D ~BDRV_O_UNMAP;
> +    *flags &=3D ~(BDRV_O_UNMAP | BDRV_O_SPARSE);
> =20
>      if (!strcmp(mode, "off") || !strcmp(mode, "ignore")) {
>          /* do nothing */
>      } else if (!strcmp(mode, "on") || !strcmp(mode, "unmap")) {
>          *flags |=3D BDRV_O_UNMAP;
> +    } else if (!strcmp(mode, "sparse")) {
> +        *flags |=3D BDRV_O_UNMAP | BDRV_O_SPARSE;
>      } else {
>          return -1;
>      }
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 4de1abd023..f9efadc5be 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1057,6 +1057,10 @@ static ssize_t handle_aiocb_write_zeroes(RawPosi=
xAIOData *aiocb)
>      BDRVRawState *s =3D aiocb->bs->opaque;
>  #endif
> =20
> +#if defined(CONFIG_FALLOCATE_PUNCH_HOLE) || defined(CONFIG_FALLOCATE)
> +    int open_flags =3D aiocb->bs->open_flags;
> +#endif
> +
>      if (aiocb->aio_type & QEMU_AIO_BLKDEV) {
>          return handle_aiocb_write_zeroes_block(aiocb);
>      }
> @@ -1079,7 +1083,7 @@ static ssize_t handle_aiocb_write_zeroes(RawPosix=
AIOData *aiocb)
>  #endif
> =20
>  #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> -    if (s->has_discard && s->has_fallocate) {
> +    if (s->has_discard && (s->has_fallocate || open_flags & BDRV_O_SPA=
RSE)) {

s->has_fallocate has a meaning. I wouldn't try to call do_fallocate() if
s->has_fallocate is false. Therefore, I consider this to effectively be
a no-op.

>          int ret =3D do_fallocate(s->fd,
>                                 FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_S=
IZE,
>                                 aiocb->aio_offset, aiocb->aio_nbytes);
> @@ -1098,7 +1102,8 @@ static ssize_t handle_aiocb_write_zeroes(RawPosix=
AIOData *aiocb)
>  #endif
> =20
>  #ifdef CONFIG_FALLOCATE
> -    if (s->has_fallocate && aiocb->aio_offset >=3D bdrv_getlength(aioc=
b->bs)) {
> +    if (s->has_fallocate && !(open_flags & BDRV_O_SPARSE)
> +            && aiocb->aio_offset >=3D bdrv_getlength(aiocb->bs)) {

First, this part is only invoked if everything before it has failed.
Second, this condition will only be true if we try to write zeroes
beyond the end of the file. This is a pretty unusual request that
normally doesn't happen (it may happen during qcow2 image creation with
preallocation or something like that).

This part here is just a final fallback for growing files on systems
which do not have any advanced fallocate() modes. It seems very unlikely
to me that anyone would hit this in normal operation.

So all in all I don't know how this patch changes anything.


Also, this function is for writing zeroes, not for handling discards.
That is done in handle_aiocb_discard().

And as far as I can tell, handle_aiocb_discard() does exactly what you
want it to do. It's invoked by raw_aio_pdiscard() and also by
raw_co_pwrite_zeroes() if BDRV_REQ_MAY_UNMAP is set. If that flag is not
set, raw_co_pwrite_zeroes() will use the above zero-writing function.

Unless I'm mistaken, unmap/trim requests from the guest should result in
a discard request in the block layer. This should always trigger
handle_aiocb_discard() here and that should do what you want it to.

I don't know exactly what you are doing so maybe for some reason the
request doesn't arrive as a discard but as a write-zeroes. As I said,
even if that is so, I don't see how this patch then changes the behavior
when compared to discard=3Dunmap.

What might make sense is to make BDRV_O_SPARSE always set
BDRV_REQ_MAY_UNMAP for any zero-write request. But I don't know why that
would be necessary. With virtio-scsi, discard requests from the guest
should result in discard requests in the block layer anyway. And
detect-zeroes=3Dunmap does set BDRV_REQ_MAY_UNMAP for the write-zeroes
requests it generates.


Could you maybe give me the configuration that results in the issue
you're describing in the commit message?

Max

>          int ret =3D do_fallocate(s->fd, 0, aiocb->aio_offset, aiocb->a=
io_nbytes);
>          if (ret =3D=3D 0 || ret !=3D -ENOTSUP) {
>              return ret;
> diff --git a/include/block/block.h b/include/block/block.h
> index bde5ebda18..103313bee0 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -97,6 +97,8 @@ typedef struct HDGeometry {
>                                        select an appropriate protocol d=
river,
>                                        ignoring the format layer */
>  #define BDRV_O_NO_IO       0x10000 /* don't initialize for I/O */
> +#define BDRV_O_SPARSE      0x20000 /* make guest UNMAP/TRIM operations=
 make image
> +                                      possibly sparse */
> =20
>  #define BDRV_O_CACHE_MASK  (BDRV_O_NOCACHE | BDRV_O_NO_FLUSH)
> =20
> diff --git a/qemu-nbd.texi b/qemu-nbd.texi
> index 9a84e81eed..8df4f58ddc 100644
> --- a/qemu-nbd.texi
> +++ b/qemu-nbd.texi
> @@ -63,8 +63,8 @@ and @samp{native} (Linux only).
>  @item --discard=3D@var{discard}
>  Control whether @dfn{discard} (also known as @dfn{trim} or @dfn{unmap}=
)
>  requests are ignored or passed to the filesystem.  @var{discard} is on=
e of
> -@samp{ignore} (or @samp{off}), @samp{unmap} (or @samp{on}).  The defau=
lt is
> -@samp{ignore}.
> +@samp{ignore} (or @samp{off}), @samp{unmap} (or @samp{on}), or @samp{s=
parse}.
> +The default is @samp{ignore}.
>  @item --detect-zeroes=3D@var{detect-zeroes}
>  Control the automatic conversion of plain zero writes by the OS to
>  driver-specific optimized zero write commands.  @var{detect-zeroes} is=
 one of
> diff --git a/qemu-options.hx b/qemu-options.hx
> index bf458f83c3..f5c7455fd1 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -539,7 +539,7 @@ DEF("drive", HAS_ARG, QEMU_OPTION_drive,
>      "       [,serial=3Ds][,addr=3DA][,rerror=3Dignore|stop|report]\n"
>      "       [,werror=3Dignore|stop|report|enospc][,id=3Dname][,aio=3Dt=
hreads|native]\n"
>      "       [,readonly=3Don|off][,copy-on-read=3Don|off]\n"
> -    "       [,discard=3Dignore|unmap][,detect-zeroes=3Don|off|unmap]\n=
"
> +    "       [,discard=3Dignore|unmap|sparse][,detect-zeroes=3Don|off|u=
nmap]\n"
>      "       [[,bps=3Db]|[[,bps_rd=3Dr][,bps_wr=3Dw]]]\n"
>      "       [[,iops=3Di]|[[,iops_rd=3Dr][,iops_wr=3Dw]]]\n"
>      "       [[,bps_max=3Dbm]|[[,bps_rd_max=3Drm][,bps_wr_max=3Dwm]]]\n=
"
> @@ -582,7 +582,7 @@ These options have the same definition as they have=
 in @option{-hdachs}.
>  @item aio=3D@var{aio}
>  @var{aio} is "threads", or "native" and selects between pthread based =
disk I/O and native Linux AIO.
>  @item discard=3D@var{discard}
> -@var{discard} is one of "ignore" (or "off") or "unmap" (or "on") and c=
ontrols whether @dfn{discard} (also known as @dfn{trim} or @dfn{unmap}) r=
equests are ignored or passed to the filesystem.  Some machine types may =
not support discard requests.
> +@var{discard} is one of "ignore" (or "off") or "unmap" (or "on") or "s=
parse" and controls whether @dfn{discard} (also known as @dfn{trim} or @d=
fn{unmap}) requests are ignored or passed to the filesystem.  Some machin=
e types may not support discard requests.
>  @item format=3D@var{format}
>  Specify which disk @var{format} will be used rather than detecting
>  the format.  Can be used to specify format=3Draw to avoid interpreting=

>=20



--xs7gA6T9X5O576G7xsu1qaRHuObI0ei6d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli0UAASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AmaYIAJuFs8WpSZwZGxhuv/N3nhxOo41eJ8yv
VOapW2xlxd/O2J7+dLLj9Oqj5sPMdvO1EwxjfBnUI4Ekv8T7r+B9h6lkbayaWaN7
p9opeX9nJghKCxELkLKn+lFjFYHqItoNPq6wGU9mZZyuNjOEoEwwZ9aa+XS7HBsv
QzAxAivb6f/n0CyAROX+VFM+GG5jXg6sqkYR8XOL359jW8D3KGsJAInk86EgxGrX
mjWtQlYsAW1kpKvNXT1JyW/XRChpbtnWEOFcxxVzIAm3KzY771TeQTZ0cuN2ConG
eR3pqNte/7fYmuXcyQ/jIuCOz1JmLo+C73F7Knwi4DipbPbz/Gz342M=
=JnWI
-----END PGP SIGNATURE-----

--xs7gA6T9X5O576G7xsu1qaRHuObI0ei6d--
