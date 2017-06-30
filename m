Received: from eggs.gnu.org ([2001:4830:134:3::10]:40995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dR230-0005Qu-Op
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dR230-0004zp-2R
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:57:46 -0400
Date: Fri, 30 Jun 2017 15:57:37 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170630195737.GC4997@localhost.localdomain>
References: <20170627192458.15519-1-eblake@redhat.com>
	<20170627192458.15519-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170627192458.15519-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/20] stream: Switch stream_populate()
 to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, jsnow@redhat.com, Max Reitz <mreitz@redhat.com>

On Tue, Jun 27, 2017 at 02:24:41PM -0500, Eric Blake wrote:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Start by converting an
> internal function (no semantic change).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
> v2: no change
> ---
>  block/stream.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/block/stream.c b/block/stream.c
> index 6cb3939..746d525 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -41,20 +41,20 @@ typedef struct StreamBlockJob {
>  } StreamBlockJob;
> 
>  static int coroutine_fn stream_populate(BlockBackend *blk,
> -                                        int64_t sector_num, int nb_sectors,
> +                                        int64_t offset, uint64_t bytes,
>                                          void *buf)
>  {
>      struct iovec iov = {
>          .iov_base = buf,
> -        .iov_len  = nb_sectors * BDRV_SECTOR_SIZE,
> +        .iov_len  = bytes,
>      };
>      QEMUIOVector qiov;
> 
> +    assert(bytes < SIZE_MAX);
>      qemu_iovec_init_external(&qiov, &iov, 1);
> 
>      /* Copy-on-read the unallocated clusters */
> -    return blk_co_preadv(blk, sector_num * BDRV_SECTOR_SIZE, qiov.size, &qiov,
> -                         BDRV_REQ_COPY_ON_READ);
> +    return blk_co_preadv(blk, offset, qiov.size, &qiov, BDRV_REQ_COPY_ON_READ);
>  }
> 
>  typedef struct {
> @@ -171,7 +171,8 @@ static void coroutine_fn stream_run(void *opaque)
>          trace_stream_one_iteration(s, sector_num * BDRV_SECTOR_SIZE,
>                                     n * BDRV_SECTOR_SIZE, ret);
>          if (copy) {
> -            ret = stream_populate(blk, sector_num, n, buf);
> +            ret = stream_populate(blk, sector_num * BDRV_SECTOR_SIZE,
> +                                  n * BDRV_SECTOR_SIZE, buf);
>          }
>          if (ret < 0) {
>              BlockErrorAction action =
> -- 
> 2.9.4
> 
