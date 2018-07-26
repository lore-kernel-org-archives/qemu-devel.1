Received: from eggs.gnu.org ([2001:4830:134:3::10]:60134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1fij2h-0003pb-UD
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 12:23:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1fij2e-0005vw-QU
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 12:23:07 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:34630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1fij2e-0005vd-J1
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 12:23:04 -0400
Received: by mail-ua0-f177.google.com with SMTP id r10-v6so1477656uao.1
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 09:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180726113337.23144-1-kwolf@redhat.com>
In-Reply-To: <20180726113337.23144-1-kwolf@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 26 Jul 2018 19:22:52 +0300
Message-ID: <CAMRbyyt-+ncsJzNbtF6dVNVHGiykORE-edF4z=nXepW9U=-RZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-3.0] file-posix: Fix
 write_zeroes with unmap on block devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On Thu, Jul 26, 2018 at 2:33 PM Kevin Wolf <kwolf@redhat.com> wrote:

> The BLKDISCARD ioctl doesn't guarantee that the discarded blocks read as
> all-zero afterwards, so don't try to abuse it for zero writing. We try
> to only use this if BLKDISCARDZEROES tells us that it is safe, but this
> is unreliable on older kernels and a constant 0 in newer kernels. In
> other words, this code path is never actually used with newer kernels,
> so we don't even try to unmap while writing zeros.
>
> This patch removes the abuse of discard for writing zeroes from
> file-posix and instead adds a new function that uses interfaces that are
> actually meant to deallocate and zero out at the same time. Only if
> those fail, it falls back to zeroing out without unmap. We never fall
> back to a discard operation any more that may or may not result in
> zeros.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-posix.c | 62
> +++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 47 insertions(+), 15 deletions(-)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 60af4b3d51..9c66cd87d1 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -648,7 +648,7 @@ static int raw_open_common(BlockDriverState *bs, QDict
> *options,
>      }
>  #endif
>
> -    bs->supported_zero_flags = s->discard_zeroes ? BDRV_REQ_MAY_UNMAP : 0;
> +    bs->supported_zero_flags = BDRV_REQ_MAY_UNMAP;
>      ret = 0;
>  fail:
>      if (filename && (bdrv_flags & BDRV_O_TEMPORARY)) {
> @@ -1487,6 +1487,38 @@ static ssize_t
> handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
>      return -ENOTSUP;
>  }
>
> +static ssize_t handle_aiocb_write_zeroes_unmap(RawPosixAIOData *aiocb)
> +{
> +    BDRVRawState *s = aiocb->bs->opaque;
> +    int ret;
> +
> +    /* First try to write zeros and unmap at the same time */
> +
> +#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> +    ret = do_fallocate(s->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +                       aiocb->aio_offset, aiocb->aio_nbytes);
> +    if (ret != -ENOTSUP) {
>

This fails with ENODEV on RHEL 7.5 when fd is a block device.

The manual says:

       ENODEV fd does not refer to a regular file or a directory.  (If fd
is a pipe or FIFO, a different error results.)

Same issue exists in this patch:
http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg07194.html

+        return ret;
> +    }
> +#endif
> +
> +#ifdef CONFIG_XFS
> +    if (s->is_xfs) {
> +        /* xfs_discard() guarantees that the discarded area reads as
> all-zero
> +         * afterwards, so we can use it here. */
> +        return xfs_discard(s, aiocb->aio_offset, aiocb->aio_nbytes);
> +    }
> +#endif
> +
> +    /* Make the compiler happy if neither of the above is compiled in */
> +    (void) s;
> +
> +    /* If we couldn't manage to unmap while guaranteed that the area
> reads as
> +     * all-zero afterwards, just write zeroes without unmapping */
> +    ret = handle_aiocb_write_zeroes(aiocb);
> +    return ret;
> +}
> +
>  #ifndef HAVE_COPY_FILE_RANGE
>  static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
>                               off_t *out_off, size_t len, unsigned int
> flags)
> @@ -1729,6 +1761,9 @@ static int aio_worker(void *arg)
>      case QEMU_AIO_WRITE_ZEROES:
>          ret = handle_aiocb_write_zeroes(aiocb);
>          break;
> +    case QEMU_AIO_WRITE_ZEROES | QEMU_AIO_DISCARD:
> +        ret = handle_aiocb_write_zeroes_unmap(aiocb);
> +        break;
>      case QEMU_AIO_COPY_RANGE:
>          ret = handle_aiocb_copy_range(aiocb);
>          break;
> @@ -2553,15 +2588,13 @@ static int coroutine_fn raw_co_pwrite_zeroes(
>      int bytes, BdrvRequestFlags flags)
>  {
>      BDRVRawState *s = bs->opaque;
> +    int operation = QEMU_AIO_WRITE_ZEROES;
>
> -    if (!(flags & BDRV_REQ_MAY_UNMAP)) {
> -        return paio_submit_co(bs, s->fd, offset, NULL, bytes,
> -                              QEMU_AIO_WRITE_ZEROES);
> -    } else if (s->discard_zeroes) {
> -        return paio_submit_co(bs, s->fd, offset, NULL, bytes,
> -                              QEMU_AIO_DISCARD);
> +    if (flags & BDRV_REQ_MAY_UNMAP) {
> +        operation |= QEMU_AIO_DISCARD;
>      }
> -    return -ENOTSUP;
> +
> +    return paio_submit_co(bs, s->fd, offset, NULL, bytes, operation);
>  }
>
>  static int raw_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
> @@ -3054,20 +3087,19 @@ static coroutine_fn int
> hdev_co_pwrite_zeroes(BlockDriverState *bs,
>      int64_t offset, int bytes, BdrvRequestFlags flags)
>  {
>      BDRVRawState *s = bs->opaque;
> +    int operation = QEMU_AIO_WRITE_ZEROES | QEMU_AIO_BLKDEV;
>      int rc;
>
>      rc = fd_open(bs);
>      if (rc < 0) {
>          return rc;
>      }
> -    if (!(flags & BDRV_REQ_MAY_UNMAP)) {
> -        return paio_submit_co(bs, s->fd, offset, NULL, bytes,
> -                              QEMU_AIO_WRITE_ZEROES|QEMU_AIO_BLKDEV);
> -    } else if (s->discard_zeroes) {
> -        return paio_submit_co(bs, s->fd, offset, NULL, bytes,
> -                              QEMU_AIO_DISCARD|QEMU_AIO_BLKDEV);
> +
> +    if (flags & BDRV_REQ_MAY_UNMAP) {
> +        operation |= QEMU_AIO_DISCARD;
>      }
> -    return -ENOTSUP;
> +
> +    return paio_submit_co(bs, s->fd, offset, NULL, bytes, operation);
>  }
>
>  static int coroutine_fn hdev_co_create_opts(const char *filename,
> QemuOpts *opts,
> --
> 2.13.6
>
>
>
