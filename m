Received: from eggs.gnu.org ([2001:4830:134:3::10]:34380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fihFc-0002fT-Sl
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fihFZ-000107-T1
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:28:20 -0400
References: <20180726113337.23144-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <605ad10a-13c0-7f62-1c71-a8afe9021ee6@redhat.com>
Date: Thu, 26 Jul 2018 09:28:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180726113337.23144-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0] file-posix: Fix write_zeroes with
 unmap on block devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On 07/26/2018 06:33 AM, Kevin Wolf wrote:
> The BLKDISCARD ioctl doesn't guarantee that the discarded blocks read as
> all-zero afterwards, so don't try to abuse it for zero writing. We try
> to only use this if BLKDISCARDZEROES tells us that it is safe, but this
> is unreliable on older kernels and a constant 0 in newer kernels. In

For my own curiosity, which kernel commit switched to constant 0, so I 
can read the rationale in that commit message?

> other words, this code path is never actually used with newer kernels,
> so we don't even try to unmap while writing zeros.
> 
> This patch removes the abuse of discard for writing zeroes from
> file-posix and instead adds a new function that uses interfaces that are
> actually meant to deallocate and zero out at the same time. Only if
> those fail, it falls back to zeroing out without unmap. We never fall
> back to a discard operation any more that may or may not result in
> zeros.

Makes sense.

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/file-posix.c | 62 +++++++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 47 insertions(+), 15 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 60af4b3d51..9c66cd87d1 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -648,7 +648,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>       }
>   #endif
>   
> -    bs->supported_zero_flags = s->discard_zeroes ? BDRV_REQ_MAY_UNMAP : 0;
> +    bs->supported_zero_flags = BDRV_REQ_MAY_UNMAP;
>       ret = 0;
>   fail:
>       if (filename && (bdrv_flags & BDRV_O_TEMPORARY)) {
> @@ -1487,6 +1487,38 @@ static ssize_t handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
>       return -ENOTSUP;
>   }
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

Umm, doesn't this have to use FALLOC_FL_ZERO_RANGE? FALLOC_FL_PUNCH_HOLE 
deallocs, but is not required to write zeroes.

> +    if (ret != -ENOTSUP) {
> +        return ret;
> +    }
> +#endif
> +
> +#ifdef CONFIG_XFS
> +    if (s->is_xfs) {
> +        /* xfs_discard() guarantees that the discarded area reads as all-zero
> +         * afterwards, so we can use it here. */
> +        return xfs_discard(s, aiocb->aio_offset, aiocb->aio_nbytes);
> +    }
> +#endif
> +
> +    /* Make the compiler happy if neither of the above is compiled in */
> +    (void) s;

Could also be done in fewer lines by use of:

    BDRVRawState *s G_GNUC_UNUSED = aiocb->bs->opaque;

since that attribute means "might be unused, don't warn if it is 
actually unused" (and not the stricter "must be unused, warn if it got 
used anyway")

> +
> +    /* If we couldn't manage to unmap while guaranteed that the area reads as
> +     * all-zero afterwards, just write zeroes without unmapping */
> +    ret = handle_aiocb_write_zeroes(aiocb);
> +    return ret;
> +}
> +
>   #ifndef HAVE_COPY_FILE_RANGE
>   static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
>                                off_t *out_off, size_t len, unsigned int flags)


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
