Received: from eggs.gnu.org ([2001:4830:134:3::10]:48208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cySXL-00039o-SF
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 20:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cySXK-0005ar-LH
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 20:22:59 -0400
References: <20170412174920.8744-1-eblake@redhat.com>
	<20170412174920.8744-8-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <951c3fd3-dcde-c06a-5f25-0fb78a4e687f@redhat.com>
Date: Wed, 12 Apr 2017 20:22:45 -0400
MIME-Version: 1.0
In-Reply-To: <20170412174920.8744-8-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/12] dirty-bitmap: Change
 bdrv_get_dirty_count() to report bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Jeff Cody <jcody@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 04/12/2017 01:49 PM, Eric Blake wrote:
> Thanks to recent cleanups, all callers were scaling a return value
> of sectors into bytes; do the scaling internally instead.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/dirty-bitmap.c |  4 ++--
>  block/mirror.c       | 13 +++++--------
>  migration/block.c    |  2 +-
>  3 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 2f9f554..e3c2e34 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -319,7 +319,7 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
>      QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
>          BlockDirtyInfo *info = g_new0(BlockDirtyInfo, 1);
>          BlockDirtyInfoList *entry = g_new0(BlockDirtyInfoList, 1);
> -        info->count = bdrv_get_dirty_count(bm) << BDRV_SECTOR_BITS;
> +        info->count = bdrv_get_dirty_count(bm);
>          info->granularity = bdrv_dirty_bitmap_granularity(bm);
>          info->has_name = !!bm->name;
>          info->name = g_strdup(bm->name);
> @@ -494,7 +494,7 @@ void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *iter, int64_t offset)
> 
>  int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap)
>  {
> -    return hbitmap_count(bitmap->bitmap);
> +    return hbitmap_count(bitmap->bitmap) << BDRV_SECTOR_BITS;
>  }
> 
>  int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap)
> diff --git a/block/mirror.c b/block/mirror.c
> index f404ff3..1b98a77 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -794,11 +794,10 @@ static void coroutine_fn mirror_run(void *opaque)
> 
>          cnt = bdrv_get_dirty_count(s->dirty_bitmap);
>          /* s->common.offset contains the number of bytes already processed so
> -         * far, cnt is the number of dirty sectors remaining and
> +         * far, cnt is the number of dirty bytes remaining and
>           * s->bytes_in_flight is the number of bytes currently being
>           * processed; together those are the current total operation length */
> -        s->common.len = s->common.offset + s->bytes_in_flight +
> -            cnt * BDRV_SECTOR_SIZE;
> +        s->common.len = s->common.offset + s->bytes_in_flight + cnt;
> 
>          /* Note that even when no rate limit is applied we need to yield
>           * periodically with no pending I/O so that bdrv_drain_all() returns.
> @@ -810,8 +809,7 @@ static void coroutine_fn mirror_run(void *opaque)
>              s->common.iostatus == BLOCK_DEVICE_IO_STATUS_OK) {
>              if (s->in_flight >= MAX_IN_FLIGHT || s->buf_free_count == 0 ||
>                  (cnt == 0 && s->in_flight > 0)) {
> -                trace_mirror_yield(s, cnt * BDRV_SECTOR_SIZE,
> -                                   s->buf_free_count, s->in_flight);
> +                trace_mirror_yield(s, cnt, s->buf_free_count, s->in_flight);
>                  mirror_wait_for_io(s);
>                  continue;
>              } else if (cnt != 0) {
> @@ -852,7 +850,7 @@ static void coroutine_fn mirror_run(void *opaque)
>               * whether to switch to target check one last time if I/O has
>               * come in the meanwhile, and if not flush the data to disk.
>               */
> -            trace_mirror_before_drain(s, cnt * BDRV_SECTOR_SIZE);
> +            trace_mirror_before_drain(s, cnt);
> 
>              bdrv_drained_begin(bs);
>              cnt = bdrv_get_dirty_count(s->dirty_bitmap);
> @@ -871,8 +869,7 @@ static void coroutine_fn mirror_run(void *opaque)
>          }
> 
>          ret = 0;
> -        trace_mirror_before_sleep(s, cnt * BDRV_SECTOR_SIZE,
> -                                  s->synced, delay_ns);
> +        trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
>          if (!s->synced) {
>              block_job_sleep_ns(&s->common, QEMU_CLOCK_REALTIME, delay_ns);
>              if (block_job_is_cancelled(&s->common)) {
> diff --git a/migration/block.c b/migration/block.c
> index 9a9c214..3daa5c7 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -672,7 +672,7 @@ static int64_t get_remaining_dirty(void)
>          aio_context_release(blk_get_aio_context(bmds->blk));
>      }
> 
> -    return dirty << BDRV_SECTOR_BITS;
> +    return dirty;
>  }
> 
>  /* Called with iothread lock taken.  */
> 

Reviewed-by: John Snow <jsnow@redhat.com>
