Received: from eggs.gnu.org ([2001:4830:134:3::10]:36787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1fB40A-0004oH-5v
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1fB406-0007kS-5q
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:53:22 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:42862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1fB406-0007jx-1k
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:53:18 -0400
Received: by mail-yb0-f195.google.com with SMTP id j69-v6so3416366ybg.9
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 12:53:17 -0700 (PDT)
MIME-Version: 1.0
Reply-To: dillaman@redhat.com
In-Reply-To: <20180424192506.149089-5-eblake@redhat.com>
References: <20180424192506.149089-1-eblake@redhat.com>
	<20180424192506.149089-5-eblake@redhat.com>
From: Jason Dillaman <jdillama@redhat.com>
Date: Tue, 24 Apr 2018 15:53:15 -0400
Message-ID: <CA+aFP1B=Hh81BktL-8V1LD5A9wZQEdJw4yMgV_WEDQ85C-a5WQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 4/6] rbd: Switch to
 byte-based callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue, Apr 24, 2018 at 3:25 PM, Eric Blake <eblake@redhat.com> wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Make the change for the last few sector-based callbacks
> in the rbd driver.
>
> Note that the driver was already using byte-based calls for
> performing actual I/O, so this just gets rid of a round trip
> of scaling; however, as I don't know if RBD is tolerant of
> non-sector AIO operations, I went with the conservate approach
> of adding .bdrv_refresh_limits to override the block layer
> defaults back to the pre-patch value of 512.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v2: override new block layer default alignment [Kevin]
> ---
>  block/rbd.c | 44 ++++++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index c9359d0ad84..638ecf8d986 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -231,6 +231,13 @@ done:
>  }
>
>
> +static void qemu_rbd_refresh_limits(BlockDriverState *bs, Error **errp)
> +{
> +    /* XXX Does RBD support AIO on less than 512-byte alignment? */

Yes, librbd internally supports 1-byte alignment for IO, but the
optimal alignment/length would be object size * stripe count.

> +    bs->bl.request_alignment = 512;
> +}
> +
> +
>  static int qemu_rbd_set_auth(rados_t cluster, const char *secretid,
>                               Error **errp)
>  {
> @@ -899,27 +906,23 @@ failed:
>      return NULL;
>  }
>
> -static BlockAIOCB *qemu_rbd_aio_readv(BlockDriverState *bs,
> -                                      int64_t sector_num,
> -                                      QEMUIOVector *qiov,
> -                                      int nb_sectors,
> -                                      BlockCompletionFunc *cb,
> -                                      void *opaque)
> -{
> -    return rbd_start_aio(bs, sector_num << BDRV_SECTOR_BITS, qiov,
> -                         (int64_t) nb_sectors << BDRV_SECTOR_BITS, cb, opaque,
> -                         RBD_AIO_READ);
> -}
> -
> -static BlockAIOCB *qemu_rbd_aio_writev(BlockDriverState *bs,
> -                                       int64_t sector_num,
> -                                       QEMUIOVector *qiov,
> -                                       int nb_sectors,
> +static BlockAIOCB *qemu_rbd_aio_preadv(BlockDriverState *bs,
> +                                       uint64_t offset, uint64_t bytes,
> +                                       QEMUIOVector *qiov, int flags,
>                                         BlockCompletionFunc *cb,
>                                         void *opaque)
>  {
> -    return rbd_start_aio(bs, sector_num << BDRV_SECTOR_BITS, qiov,
> -                         (int64_t) nb_sectors << BDRV_SECTOR_BITS, cb, opaque,
> +    return rbd_start_aio(bs, offset, qiov, bytes, cb, opaque,
> +                         RBD_AIO_READ);
> +}
> +
> +static BlockAIOCB *qemu_rbd_aio_pwritev(BlockDriverState *bs,
> +                                        uint64_t offset, uint64_t bytes,
> +                                        QEMUIOVector *qiov, int flags,
> +                                        BlockCompletionFunc *cb,
> +                                        void *opaque)
> +{
> +    return rbd_start_aio(bs, offset, qiov, bytes, cb, opaque,
>                           RBD_AIO_WRITE);
>  }
>
> @@ -1158,6 +1161,7 @@ static BlockDriver bdrv_rbd = {
>      .format_name            = "rbd",
>      .instance_size          = sizeof(BDRVRBDState),
>      .bdrv_parse_filename    = qemu_rbd_parse_filename,
> +    .bdrv_refresh_limits    = qemu_rbd_refresh_limits,
>      .bdrv_file_open         = qemu_rbd_open,
>      .bdrv_close             = qemu_rbd_close,
>      .bdrv_reopen_prepare    = qemu_rbd_reopen_prepare,
> @@ -1170,8 +1174,8 @@ static BlockDriver bdrv_rbd = {
>      .bdrv_truncate          = qemu_rbd_truncate,
>      .protocol_name          = "rbd",
>
> -    .bdrv_aio_readv         = qemu_rbd_aio_readv,
> -    .bdrv_aio_writev        = qemu_rbd_aio_writev,
> +    .bdrv_aio_preadv        = qemu_rbd_aio_preadv,
> +    .bdrv_aio_pwritev       = qemu_rbd_aio_pwritev,
>
>  #ifdef LIBRBD_SUPPORTS_AIO_FLUSH
>      .bdrv_aio_flush         = qemu_rbd_aio_flush,
> --
> 2.14.3
>
>



-- 
Jason
