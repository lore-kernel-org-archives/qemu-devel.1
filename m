Received: from eggs.gnu.org ([2001:4830:134:3::10]:34287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f95iL-0000fz-9H
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 05:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f95iK-0001Nl-Au
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 05:18:49 -0400
Date: Thu, 19 Apr 2018 10:18:33 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180419091832.GB2730@work-vm>
References: <20180419075232.31407-1-stefanha@redhat.com>
	<20180419075232.31407-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419075232.31407-2-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [RFC 1/2] block/file-posix: implement
 bdrv_co_invalidate_cache() on Linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Linux posix_fadvise(POSIX_FADV_DONTNEED) invalidates pages*.  Use
> this to drop page cache on the destination host during shared storage
> migration.  This way the destination host will read the latest copy of
> the data and will not use stale data from the page cache.
> 
> The flow is as follows:
> 
> 1. Source host writes out all dirty pages and inactivates drives.
> 2. QEMU_VM_EOF is sent on migration stream.
> 3. Destination host invalidates caches before accessing drives.
> 
> This patch enables live migration even with -drive cache.direct=off.
> 
> * Terms and conditions may apply, please see patch for details.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/file-posix.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 3794c0007a..df4f52919f 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2236,6 +2236,42 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
>      return ret | BDRV_BLOCK_OFFSET_VALID;
>  }
>  
> +static void coroutine_fn raw_co_invalidate_cache(BlockDriverState *bs,
> +                                                 Error **errp)
> +{
> +    BDRVRawState *s = bs->opaque;
> +    int ret;
> +
> +    ret = fd_open(bs);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "The file descriptor is not open");
> +        return;
> +    }
> +
> +    if (s->open_flags & O_DIRECT) {
> +        return; /* No host kernel page cache */
> +    }
> +
> +#if defined(__linux__)
> +    /* This sets the scene for the next syscall... */
> +    ret = bdrv_co_flush(bs);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "flush failed");
> +        return;
> +    }
> +
> +    /* Linux does not invalidate pages that are dirty, locked, or mmapped by a
> +     * process.  These limitations are okay because we just fsynced the file,
> +     * we don't use mmap, and the file should not be in use by other processes.
> +     */
> +    ret = posix_fadvise(s->fd, 0, 0, POSIX_FADV_DONTNEED);

What happens if I try a migrate between two qemu's on the same host?
(Which I, and avocado, both use for testing; I think think users
occasionally do for QEMU updates).

Dave

> +    if (ret != 0) { /* the return value is a positive errno */
> +        error_setg_errno(errp, ret, "fadvise failed");
> +        return;
> +    }
> +#endif /* __linux__ */
> +}
> +
>  static coroutine_fn BlockAIOCB *raw_aio_pdiscard(BlockDriverState *bs,
>      int64_t offset, int bytes,
>      BlockCompletionFunc *cb, void *opaque)
> @@ -2328,6 +2364,7 @@ BlockDriver bdrv_file = {
>      .bdrv_co_create_opts = raw_co_create_opts,
>      .bdrv_has_zero_init = bdrv_has_zero_init_1,
>      .bdrv_co_block_status = raw_co_block_status,
> +    .bdrv_co_invalidate_cache = raw_co_invalidate_cache,
>      .bdrv_co_pwrite_zeroes = raw_co_pwrite_zeroes,
>  
>      .bdrv_co_preadv         = raw_co_preadv,
> @@ -2805,6 +2842,7 @@ static BlockDriver bdrv_host_device = {
>      .bdrv_reopen_abort   = raw_reopen_abort,
>      .bdrv_co_create_opts = hdev_co_create_opts,
>      .create_opts         = &raw_create_opts,
> +    .bdrv_co_invalidate_cache = raw_co_invalidate_cache,
>      .bdrv_co_pwrite_zeroes = hdev_co_pwrite_zeroes,
>  
>      .bdrv_co_preadv         = raw_co_preadv,
> @@ -2927,6 +2965,7 @@ static BlockDriver bdrv_host_cdrom = {
>      .bdrv_reopen_abort   = raw_reopen_abort,
>      .bdrv_co_create_opts = hdev_co_create_opts,
>      .create_opts         = &raw_create_opts,
> +    .bdrv_co_invalidate_cache = raw_co_invalidate_cache,
>  
>  
>      .bdrv_co_preadv         = raw_co_preadv,
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
