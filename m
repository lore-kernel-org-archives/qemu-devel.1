Received: from eggs.gnu.org ([2001:4830:134:3::10]:49780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dR2PO-0005d0-In
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 16:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dR2PM-0006b2-Tb
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 16:20:54 -0400
Date: Fri, 30 Jun 2017 16:20:43 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170630202043.GG4997@localhost.localdomain>
References: <20170627192458.15519-1-eblake@redhat.com>
	<20170627192458.15519-8-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170627192458.15519-8-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/20] mirror: Switch MirrorBlockJob to
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

On Tue, Jun 27, 2017 at 02:24:45PM -0500, Eric Blake wrote:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Continue by converting an
> internal structure (no semantic change), and all references to the
> buffer size.
> 
> [checkpatch has a false positive on use of MIN() in this patch]
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
> v2: no change
> ---
>  block/mirror.c | 79 ++++++++++++++++++++++++++++------------------------------
>  1 file changed, 38 insertions(+), 41 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index b4dfe95..9e28d59 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -24,9 +24,8 @@
> 
>  #define SLICE_TIME    100000000ULL /* ns */
>  #define MAX_IN_FLIGHT 16
> -#define MAX_IO_SECTORS ((1 << 20) >> BDRV_SECTOR_BITS) /* 1 Mb */
> -#define DEFAULT_MIRROR_BUF_SIZE \
> -    (MAX_IN_FLIGHT * MAX_IO_SECTORS * BDRV_SECTOR_SIZE)
> +#define MAX_IO_BYTES (1 << 20) /* 1 Mb */
> +#define DEFAULT_MIRROR_BUF_SIZE (MAX_IN_FLIGHT * MAX_IO_BYTES)
> 
>  /* The mirroring buffer is a list of granularity-sized chunks.
>   * Free chunks are organized in a list.
> @@ -67,11 +66,11 @@ typedef struct MirrorBlockJob {
>      uint64_t last_pause_ns;
>      unsigned long *in_flight_bitmap;
>      int in_flight;
> -    int64_t sectors_in_flight;
> +    int64_t bytes_in_flight;
>      int ret;
>      bool unmap;
>      bool waiting_for_io;
> -    int target_cluster_sectors;
> +    int target_cluster_size;
>      int max_iov;
>      bool initial_zeroing_ongoing;
>  } MirrorBlockJob;
> @@ -79,8 +78,8 @@ typedef struct MirrorBlockJob {
>  typedef struct MirrorOp {
>      MirrorBlockJob *s;
>      QEMUIOVector qiov;
> -    int64_t sector_num;
> -    int nb_sectors;
> +    int64_t offset;
> +    uint64_t bytes;
>  } MirrorOp;
> 
>  static BlockErrorAction mirror_error_action(MirrorBlockJob *s, bool read,
> @@ -101,13 +100,12 @@ static void mirror_iteration_done(MirrorOp *op, int ret)
>      MirrorBlockJob *s = op->s;
>      struct iovec *iov;
>      int64_t chunk_num;
> -    int i, nb_chunks, sectors_per_chunk;
> +    int i, nb_chunks;
> 
> -    trace_mirror_iteration_done(s, op->sector_num * BDRV_SECTOR_SIZE,
> -                                op->nb_sectors * BDRV_SECTOR_SIZE, ret);
> +    trace_mirror_iteration_done(s, op->offset, op->bytes, ret);
> 
>      s->in_flight--;
> -    s->sectors_in_flight -= op->nb_sectors;
> +    s->bytes_in_flight -= op->bytes;
>      iov = op->qiov.iov;
>      for (i = 0; i < op->qiov.niov; i++) {
>          MirrorBuffer *buf = (MirrorBuffer *) iov[i].iov_base;
> @@ -115,16 +113,15 @@ static void mirror_iteration_done(MirrorOp *op, int ret)
>          s->buf_free_count++;
>      }
> 
> -    sectors_per_chunk = s->granularity >> BDRV_SECTOR_BITS;
> -    chunk_num = op->sector_num / sectors_per_chunk;
> -    nb_chunks = DIV_ROUND_UP(op->nb_sectors, sectors_per_chunk);
> +    chunk_num = op->offset / s->granularity;
> +    nb_chunks = DIV_ROUND_UP(op->bytes, s->granularity);
>      bitmap_clear(s->in_flight_bitmap, chunk_num, nb_chunks);
>      if (ret >= 0) {
>          if (s->cow_bitmap) {
>              bitmap_set(s->cow_bitmap, chunk_num, nb_chunks);
>          }
>          if (!s->initial_zeroing_ongoing) {
> -            s->common.offset += (uint64_t)op->nb_sectors * BDRV_SECTOR_SIZE;
> +            s->common.offset += op->bytes;
>          }
>      }
>      qemu_iovec_destroy(&op->qiov);
> @@ -144,7 +141,8 @@ static void mirror_write_complete(void *opaque, int ret)
>      if (ret < 0) {
>          BlockErrorAction action;
> 
> -        bdrv_set_dirty_bitmap(s->dirty_bitmap, op->sector_num, op->nb_sectors);
> +        bdrv_set_dirty_bitmap(s->dirty_bitmap, op->offset >> BDRV_SECTOR_BITS,
> +                              op->bytes >> BDRV_SECTOR_BITS);
>          action = mirror_error_action(s, false, -ret);
>          if (action == BLOCK_ERROR_ACTION_REPORT && s->ret >= 0) {
>              s->ret = ret;
> @@ -163,7 +161,8 @@ static void mirror_read_complete(void *opaque, int ret)
>      if (ret < 0) {
>          BlockErrorAction action;
> 
> -        bdrv_set_dirty_bitmap(s->dirty_bitmap, op->sector_num, op->nb_sectors);
> +        bdrv_set_dirty_bitmap(s->dirty_bitmap, op->offset >> BDRV_SECTOR_BITS,
> +                              op->bytes >> BDRV_SECTOR_BITS);
>          action = mirror_error_action(s, true, -ret);
>          if (action == BLOCK_ERROR_ACTION_REPORT && s->ret >= 0) {
>              s->ret = ret;
> @@ -171,7 +170,7 @@ static void mirror_read_complete(void *opaque, int ret)
> 
>          mirror_iteration_done(op, ret);
>      } else {
> -        blk_aio_pwritev(s->target, op->sector_num * BDRV_SECTOR_SIZE, &op->qiov,
> +        blk_aio_pwritev(s->target, op->offset, &op->qiov,
>                          0, mirror_write_complete, op);
>      }
>      aio_context_release(blk_get_aio_context(s->common.blk));
> @@ -211,7 +210,8 @@ static int mirror_cow_align(MirrorBlockJob *s,
>          align_nb_sectors = max_sectors;
>          if (need_cow) {
>              align_nb_sectors = QEMU_ALIGN_DOWN(align_nb_sectors,
> -                                               s->target_cluster_sectors);
> +                                               s->target_cluster_size >>
> +                                               BDRV_SECTOR_BITS);
>          }
>      }
>      /* Clipping may result in align_nb_sectors unaligned to chunk boundary, but
> @@ -277,8 +277,8 @@ static int mirror_do_read(MirrorBlockJob *s, int64_t sector_num,
>      /* Allocate a MirrorOp that is used as an AIO callback.  */
>      op = g_new(MirrorOp, 1);
>      op->s = s;
> -    op->sector_num = sector_num;
> -    op->nb_sectors = nb_sectors;
> +    op->offset = sector_num * BDRV_SECTOR_SIZE;
> +    op->bytes = nb_sectors * BDRV_SECTOR_SIZE;
> 
>      /* Now make a QEMUIOVector taking enough granularity-sized chunks
>       * from s->buf_free.
> @@ -295,7 +295,7 @@ static int mirror_do_read(MirrorBlockJob *s, int64_t sector_num,
> 
>      /* Copy the dirty cluster.  */
>      s->in_flight++;
> -    s->sectors_in_flight += nb_sectors;
> +    s->bytes_in_flight += nb_sectors * BDRV_SECTOR_SIZE;
>      trace_mirror_one_iteration(s, sector_num * BDRV_SECTOR_SIZE,
>                                 nb_sectors * BDRV_SECTOR_SIZE);
> 
> @@ -315,19 +315,17 @@ static void mirror_do_zero_or_discard(MirrorBlockJob *s,
>       * so the freeing in mirror_iteration_done is nop. */
>      op = g_new0(MirrorOp, 1);
>      op->s = s;
> -    op->sector_num = sector_num;
> -    op->nb_sectors = nb_sectors;
> +    op->offset = sector_num * BDRV_SECTOR_SIZE;
> +    op->bytes = nb_sectors * BDRV_SECTOR_SIZE;
> 
>      s->in_flight++;
> -    s->sectors_in_flight += nb_sectors;
> +    s->bytes_in_flight += nb_sectors * BDRV_SECTOR_SIZE;
>      if (is_discard) {
>          blk_aio_pdiscard(s->target, sector_num << BDRV_SECTOR_BITS,
> -                         op->nb_sectors << BDRV_SECTOR_BITS,
> -                         mirror_write_complete, op);
> +                         op->bytes, mirror_write_complete, op);
>      } else {
>          blk_aio_pwrite_zeroes(s->target, sector_num * BDRV_SECTOR_SIZE,
> -                              op->nb_sectors * BDRV_SECTOR_SIZE,
> -                              s->unmap ? BDRV_REQ_MAY_UNMAP : 0,
> +                              op->bytes, s->unmap ? BDRV_REQ_MAY_UNMAP : 0,
>                                mirror_write_complete, op);
>      }
>  }
> @@ -342,8 +340,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
>      int64_t end = s->bdev_length / BDRV_SECTOR_SIZE;
>      int sectors_per_chunk = s->granularity >> BDRV_SECTOR_BITS;
>      bool write_zeroes_ok = bdrv_can_write_zeroes_with_unmap(blk_bs(s->target));
> -    int max_io_sectors = MAX((s->buf_size >> BDRV_SECTOR_BITS) / MAX_IN_FLIGHT,
> -                             MAX_IO_SECTORS);
> +    int max_io_bytes = MAX(s->buf_size / MAX_IN_FLIGHT, MAX_IO_BYTES);
> 
>      bdrv_dirty_bitmap_lock(s->dirty_bitmap);
>      sector_num = bdrv_dirty_iter_next(s->dbi);
> @@ -415,9 +412,10 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
>                                            nb_chunks * sectors_per_chunk,
>                                            &io_sectors, &file);
>          if (ret < 0) {
> -            io_sectors = MIN(nb_chunks * sectors_per_chunk, max_io_sectors);
> +            io_sectors = MIN(nb_chunks * sectors_per_chunk,
> +                             max_io_bytes >> BDRV_SECTOR_BITS);
>          } else if (ret & BDRV_BLOCK_DATA) {
> -            io_sectors = MIN(io_sectors, max_io_sectors);
> +            io_sectors = MIN(io_sectors, max_io_bytes >> BDRV_SECTOR_BITS);
>          }
> 
>          io_sectors -= io_sectors % sectors_per_chunk;
> @@ -719,7 +717,6 @@ static void coroutine_fn mirror_run(void *opaque)
>      char backing_filename[2]; /* we only need 2 characters because we are only
>                                   checking for a NULL string */
>      int ret = 0;
> -    int target_cluster_size = BDRV_SECTOR_SIZE;
> 
>      if (block_job_is_cancelled(&s->common)) {
>          goto immediate_exit;
> @@ -768,17 +765,17 @@ static void coroutine_fn mirror_run(void *opaque)
>       * the destination do COW.  Instead, we copy sectors around the
>       * dirty data if needed.  We need a bitmap to do that.
>       */
> +    s->target_cluster_size = BDRV_SECTOR_SIZE;
>      bdrv_get_backing_filename(target_bs, backing_filename,
>                                sizeof(backing_filename));
>      if (!bdrv_get_info(target_bs, &bdi) && bdi.cluster_size) {
> -        target_cluster_size = bdi.cluster_size;
> +        s->target_cluster_size = bdi.cluster_size;
>      }
>      if (backing_filename[0] && !target_bs->backing
> -        && s->granularity < target_cluster_size) {
> -        s->buf_size = MAX(s->buf_size, target_cluster_size);
> +        && s->granularity < s->target_cluster_size) {
> +        s->buf_size = MAX(s->buf_size, s->target_cluster_size);
>          s->cow_bitmap = bitmap_new(length);
>      }
> -    s->target_cluster_sectors = target_cluster_size >> BDRV_SECTOR_BITS;
>      s->max_iov = MIN(bs->bl.max_iov, target_bs->bl.max_iov);
> 
>      s->buf = qemu_try_blockalign(bs, s->buf_size);
> @@ -814,10 +811,10 @@ static void coroutine_fn mirror_run(void *opaque)
>          cnt = bdrv_get_dirty_count(s->dirty_bitmap);
>          /* s->common.offset contains the number of bytes already processed so
>           * far, cnt is the number of dirty sectors remaining and
> -         * s->sectors_in_flight is the number of sectors currently being
> +         * s->bytes_in_flight is the number of bytes currently being
>           * processed; together those are the current total operation length */
> -        s->common.len = s->common.offset +
> -                        (cnt + s->sectors_in_flight) * BDRV_SECTOR_SIZE;
> +        s->common.len = s->common.offset + s->bytes_in_flight +
> +            cnt * BDRV_SECTOR_SIZE;
> 
>          /* Note that even when no rate limit is applied we need to yield
>           * periodically with no pending I/O so that bdrv_drain_all() returns.
> -- 
> 2.9.4
> 
