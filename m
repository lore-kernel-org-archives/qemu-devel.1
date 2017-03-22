Received: from eggs.gnu.org ([2001:4830:134:3::10]:56105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqq0d-0005K6-Qd
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 19:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqq0d-0002tG-2o
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 19:49:43 -0400
Date: Thu, 23 Mar 2017 07:49:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170322234933.GB25152@lemon>
References: <20170322210005.16533-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170322210005.16533-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9?] file-posix: Make bdrv_flush()
 failure permanent without O_DIRECT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

On Wed, 03/22 22:00, Kevin Wolf wrote:
> Success for bdrv_flush() means that all previously written data is safe
> on disk. For fdatasync(), the best semantics we can hope for on Linux
> (without O_DIRECT) is that all data that was written since the last call
> was successfully written back. Therefore, and because we can't redo all
> writes after a flush failure, we have to give up after a single
> fdatasync() failure. After this failure, we would never be able to make
> the promise that a successful bdrv_flush() makes.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-posix.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 53febd3..beb7a4f 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -144,6 +144,7 @@ typedef struct BDRVRawState {
>      bool has_write_zeroes:1;
>      bool discard_zeroes:1;
>      bool use_linux_aio:1;
> +    bool page_cache_inconsistent:1;
>      bool has_fallocate;
>      bool needs_alignment;
>  } BDRVRawState;
> @@ -824,10 +825,31 @@ static ssize_t handle_aiocb_ioctl(RawPosixAIOData *aiocb)
>  
>  static ssize_t handle_aiocb_flush(RawPosixAIOData *aiocb)
>  {
> +    BDRVRawState *s = aiocb->bs->opaque;
>      int ret;
>  
> +    if (s->page_cache_inconsistent) {
> +        return -EIO;
> +    }
> +
>      ret = qemu_fdatasync(aiocb->aio_fildes);
>      if (ret == -1) {
> +        /* There is no clear definition of the semantics of a failing fsync(),
> +         * so we may have to assume the worst. The sad truth is that this
> +         * assumption is correct for Linux. Some pages are now probably marked
> +         * clean in the page cache even though they are inconsistent with the
> +         * on-disk contents. The next fdatasync() call would succeed, but no
> +         * further writeback attempt will be made. We can't get back to a state
> +         * in which we know what is on disk (we would have to rewrite
> +         * everything that was touched since the last fdatasync() at least), so
> +         * make bdrv_flush() fail permanently. Given that the behaviour isn't
> +         * really defined, I have little hope that other OSes are doing better.
> +         *
> +         * Obviously, this doesn't affect O_DIRECT, which bypasses the page
> +         * cache. */
> +        if ((s->open_flags & O_DIRECT) == 0) {
> +            s->page_cache_inconsistent = true;
> +        }
>          return -errno;
>      }
>      return 0;
> -- 
> 2.9.3
> 
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
