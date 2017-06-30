Received: from eggs.gnu.org ([2001:4830:134:3::10]:42936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dR275-0007ZY-4p
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 16:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dR274-00083U-52
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 16:01:59 -0400
Date: Fri, 30 Jun 2017 16:01:47 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170630200146.GD4997@localhost.localdomain>
References: <20170627192458.15519-1-eblake@redhat.com>
	<20170627192458.15519-5-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170627192458.15519-5-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 04/20] stream: Switch stream_run() to
 byte-based
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

On Tue, Jun 27, 2017 at 02:24:42PM -0500, Eric Blake wrote:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Change the internal
> loop iteration of streaming to track by bytes instead of sectors
> (although we are still guaranteed that we iterate by steps that
> are sector-aligned).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
> v2: no change
> ---
>  block/stream.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/block/stream.c b/block/stream.c
> index 746d525..2f9618b 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -108,12 +108,11 @@ static void coroutine_fn stream_run(void *opaque)
>      BlockBackend *blk = s->common.blk;
>      BlockDriverState *bs = blk_bs(blk);
>      BlockDriverState *base = s->base;
> -    int64_t sector_num = 0;
> -    int64_t end = -1;
> +    int64_t offset = 0;
>      uint64_t delay_ns = 0;
>      int error = 0;
>      int ret = 0;
> -    int n = 0;
> +    int n = 0; /* sectors */
>      void *buf;
> 
>      if (!bs->backing) {
> @@ -126,7 +125,6 @@ static void coroutine_fn stream_run(void *opaque)
>          goto out;
>      }
> 
> -    end = s->common.len >> BDRV_SECTOR_BITS;
>      buf = qemu_blockalign(bs, STREAM_BUFFER_SIZE);
> 
>      /* Turn on copy-on-read for the whole block device so that guest read
> @@ -138,7 +136,7 @@ static void coroutine_fn stream_run(void *opaque)
>          bdrv_enable_copy_on_read(bs);
>      }
> 
> -    for (sector_num = 0; sector_num < end; sector_num += n) {
> +    for ( ; offset < s->common.len; offset += n * BDRV_SECTOR_SIZE) {
>          bool copy;
> 
>          /* Note that even when no rate limit is applied we need to yield
> @@ -151,28 +149,26 @@ static void coroutine_fn stream_run(void *opaque)
> 
>          copy = false;
> 
> -        ret = bdrv_is_allocated(bs, sector_num,
> +        ret = bdrv_is_allocated(bs, offset / BDRV_SECTOR_SIZE,
>                                  STREAM_BUFFER_SIZE / BDRV_SECTOR_SIZE, &n);
>          if (ret == 1) {
>              /* Allocated in the top, no need to copy.  */
>          } else if (ret >= 0) {
>              /* Copy if allocated in the intermediate images.  Limit to the
> -             * known-unallocated area [sector_num, sector_num+n).  */
> +             * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE).  */
>              ret = bdrv_is_allocated_above(backing_bs(bs), base,
> -                                          sector_num, n, &n);
> +                                          offset / BDRV_SECTOR_SIZE, n, &n);
> 
>              /* Finish early if end of backing file has been reached */
>              if (ret == 0 && n == 0) {
> -                n = end - sector_num;
> +                n = (s->common.len - offset) / BDRV_SECTOR_SIZE;
>              }
> 
>              copy = (ret == 1);
>          }
> -        trace_stream_one_iteration(s, sector_num * BDRV_SECTOR_SIZE,
> -                                   n * BDRV_SECTOR_SIZE, ret);
> +        trace_stream_one_iteration(s, offset, n * BDRV_SECTOR_SIZE, ret);
>          if (copy) {
> -            ret = stream_populate(blk, sector_num * BDRV_SECTOR_SIZE,
> -                                  n * BDRV_SECTOR_SIZE, buf);
> +            ret = stream_populate(blk, offset, n * BDRV_SECTOR_SIZE, buf);
>          }
>          if (ret < 0) {
>              BlockErrorAction action =
> @@ -211,7 +207,7 @@ out:
>      /* Modify backing chain and close BDSes in main loop */
>      data = g_malloc(sizeof(*data));
>      data->ret = ret;
> -    data->reached_end = sector_num == end;
> +    data->reached_end = offset == s->common.len;
>      block_job_defer_to_main_loop(&s->common, stream_complete, data);
>  }
> 
> -- 
> 2.9.4
> 
