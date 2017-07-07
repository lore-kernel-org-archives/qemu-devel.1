Received: from eggs.gnu.org ([2001:4830:134:3::10]:41669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWlB-0004zf-CM
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWl9-0007sB-Gx
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:36 +0200
Message-Id: <1499447335-6125-22-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 021/100] trace: Show blockjob actions via bytes,
 not sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Upcoming patches are going to switch to byte-based interfaces
instead of sector-based.  Even worse, trace_backup_do_cow_enter()
had a weird mix of cluster and sector indices.

The trace interface is low enough that there are no stability
guarantees, and therefore nothing wrong with changing our units,
even in cases like trace_backup_do_cow_skip() where we are not
changing the trace output.  So make the tracing uniformly use
bytes.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/backup.c     | 16 ++++++++++------
 block/commit.c     |  3 ++-
 block/mirror.c     | 26 +++++++++++++++++---------
 block/stream.c     |  3 ++-
 block/trace-events | 14 +++++++-------
 5 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 9ca1d8e..06431ac 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -102,6 +102,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
     void *bounce_buffer = NULL;
     int ret = 0;
     int64_t sectors_per_cluster = cluster_size_sectors(job);
+    int64_t bytes_per_cluster = sectors_per_cluster * BDRV_SECTOR_SIZE;
     int64_t start, end;
     int n;
 
@@ -110,18 +111,20 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
     start = sector_num / sectors_per_cluster;
     end = DIV_ROUND_UP(sector_num + nb_sectors, sectors_per_cluster);
 
-    trace_backup_do_cow_enter(job, start, sector_num, nb_sectors);
+    trace_backup_do_cow_enter(job, start * bytes_per_cluster,
+                              sector_num * BDRV_SECTOR_SIZE,
+                              nb_sectors * BDRV_SECTOR_SIZE);
 
     wait_for_overlapping_requests(job, start, end);
     cow_request_begin(&cow_request, job, start, end);
 
     for (; start < end; start++) {
         if (test_bit(start, job->done_bitmap)) {
-            trace_backup_do_cow_skip(job, start);
+            trace_backup_do_cow_skip(job, start * bytes_per_cluster);
             continue; /* already copied */
         }
 
-        trace_backup_do_cow_process(job, start);
+        trace_backup_do_cow_process(job, start * bytes_per_cluster);
 
         n = MIN(sectors_per_cluster,
                 job->common.len / BDRV_SECTOR_SIZE -
@@ -138,7 +141,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
                             bounce_qiov.size, &bounce_qiov,
                             is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0);
         if (ret < 0) {
-            trace_backup_do_cow_read_fail(job, start, ret);
+            trace_backup_do_cow_read_fail(job, start * bytes_per_cluster, ret);
             if (error_is_read) {
                 *error_is_read = true;
             }
@@ -154,7 +157,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
                                  job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
         }
         if (ret < 0) {
-            trace_backup_do_cow_write_fail(job, start, ret);
+            trace_backup_do_cow_write_fail(job, start * bytes_per_cluster, ret);
             if (error_is_read) {
                 *error_is_read = false;
             }
@@ -177,7 +180,8 @@ out:
 
     cow_request_end(&cow_request);
 
-    trace_backup_do_cow_return(job, sector_num, nb_sectors, ret);
+    trace_backup_do_cow_return(job, sector_num * BDRV_SECTOR_SIZE,
+                               nb_sectors * BDRV_SECTOR_SIZE, ret);
 
     qemu_co_rwlock_unlock(&job->flush_rwlock);
 
diff --git a/block/commit.c b/block/commit.c
index 6993994..4cda7f2 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -190,7 +190,8 @@ static void coroutine_fn commit_run(void *opaque)
                                       COMMIT_BUFFER_SIZE / BDRV_SECTOR_SIZE,
                                       &n);
         copy = (ret == 1);
-        trace_commit_one_iteration(s, sector_num, n, ret);
+        trace_commit_one_iteration(s, sector_num * BDRV_SECTOR_SIZE,
+                                   n * BDRV_SECTOR_SIZE, ret);
         if (copy) {
             ret = commit_populate(s->top, s->base, sector_num, n, buf);
             bytes_written += n * BDRV_SECTOR_SIZE;
diff --git a/block/mirror.c b/block/mirror.c
index eb27efc..b4dfe95 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -103,7 +103,8 @@ static void mirror_iteration_done(MirrorOp *op, int ret)
     int64_t chunk_num;
     int i, nb_chunks, sectors_per_chunk;
 
-    trace_mirror_iteration_done(s, op->sector_num, op->nb_sectors, ret);
+    trace_mirror_iteration_done(s, op->sector_num * BDRV_SECTOR_SIZE,
+                                op->nb_sectors * BDRV_SECTOR_SIZE, ret);
 
     s->in_flight--;
     s->sectors_in_flight -= op->nb_sectors;
@@ -268,7 +269,8 @@ static int mirror_do_read(MirrorBlockJob *s, int64_t sector_num,
     nb_chunks = DIV_ROUND_UP(nb_sectors, sectors_per_chunk);
 
     while (s->buf_free_count < nb_chunks) {
-        trace_mirror_yield_in_flight(s, sector_num, s->in_flight);
+        trace_mirror_yield_in_flight(s, sector_num * BDRV_SECTOR_SIZE,
+                                     s->in_flight);
         mirror_wait_for_io(s);
     }
 
@@ -294,7 +296,8 @@ static int mirror_do_read(MirrorBlockJob *s, int64_t sector_num,
     /* Copy the dirty cluster.  */
     s->in_flight++;
     s->sectors_in_flight += nb_sectors;
-    trace_mirror_one_iteration(s, sector_num, nb_sectors);
+    trace_mirror_one_iteration(s, sector_num * BDRV_SECTOR_SIZE,
+                               nb_sectors * BDRV_SECTOR_SIZE);
 
     blk_aio_preadv(source, sector_num * BDRV_SECTOR_SIZE, &op->qiov, 0,
                    mirror_read_complete, op);
@@ -347,14 +350,16 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
     if (sector_num < 0) {
         bdrv_set_dirty_iter(s->dbi, 0);
         sector_num = bdrv_dirty_iter_next(s->dbi);
-        trace_mirror_restart_iter(s, bdrv_get_dirty_count(s->dirty_bitmap));
+        trace_mirror_restart_iter(s, bdrv_get_dirty_count(s->dirty_bitmap) *
+                                  BDRV_SECTOR_SIZE);
         assert(sector_num >= 0);
     }
     bdrv_dirty_bitmap_unlock(s->dirty_bitmap);
 
     first_chunk = sector_num / sectors_per_chunk;
     while (test_bit(first_chunk, s->in_flight_bitmap)) {
-        trace_mirror_yield_in_flight(s, sector_num, s->in_flight);
+        trace_mirror_yield_in_flight(s, sector_num * BDRV_SECTOR_SIZE,
+                                     s->in_flight);
         mirror_wait_for_io(s);
     }
 
@@ -433,7 +438,8 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         }
 
         while (s->in_flight >= MAX_IN_FLIGHT) {
-            trace_mirror_yield_in_flight(s, sector_num, s->in_flight);
+            trace_mirror_yield_in_flight(s, sector_num * BDRV_SECTOR_SIZE,
+                                         s->in_flight);
             mirror_wait_for_io(s);
         }
 
@@ -823,7 +829,8 @@ static void coroutine_fn mirror_run(void *opaque)
             s->common.iostatus == BLOCK_DEVICE_IO_STATUS_OK) {
             if (s->in_flight >= MAX_IN_FLIGHT || s->buf_free_count == 0 ||
                 (cnt == 0 && s->in_flight > 0)) {
-                trace_mirror_yield(s, cnt, s->buf_free_count, s->in_flight);
+                trace_mirror_yield(s, cnt * BDRV_SECTOR_SIZE,
+                                   s->buf_free_count, s->in_flight);
                 mirror_wait_for_io(s);
                 continue;
             } else if (cnt != 0) {
@@ -864,7 +871,7 @@ static void coroutine_fn mirror_run(void *opaque)
              * whether to switch to target check one last time if I/O has
              * come in the meanwhile, and if not flush the data to disk.
              */
-            trace_mirror_before_drain(s, cnt);
+            trace_mirror_before_drain(s, cnt * BDRV_SECTOR_SIZE);
 
             bdrv_drained_begin(bs);
             cnt = bdrv_get_dirty_count(s->dirty_bitmap);
@@ -883,7 +890,8 @@ static void coroutine_fn mirror_run(void *opaque)
         }
 
         ret = 0;
-        trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
+        trace_mirror_before_sleep(s, cnt * BDRV_SECTOR_SIZE,
+                                  s->synced, delay_ns);
         if (!s->synced) {
             block_job_sleep_ns(&s->common, QEMU_CLOCK_REALTIME, delay_ns);
             if (block_job_is_cancelled(&s->common)) {
diff --git a/block/stream.c b/block/stream.c
index 29273a5..6cb3939 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -168,7 +168,8 @@ static void coroutine_fn stream_run(void *opaque)
 
             copy = (ret == 1);
         }
-        trace_stream_one_iteration(s, sector_num, n, ret);
+        trace_stream_one_iteration(s, sector_num * BDRV_SECTOR_SIZE,
+                                   n * BDRV_SECTOR_SIZE, ret);
         if (copy) {
             ret = stream_populate(blk, sector_num, n, buf);
         }
diff --git a/block/trace-events b/block/trace-events
index 752de6a..4a4df25 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -15,11 +15,11 @@ bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p off
 bdrv_co_do_copy_on_readv(void *bs, int64_t offset, unsigned int bytes, int64_t cluster_offset, unsigned int cluster_bytes) "bs %p offset %"PRId64" bytes %u cluster_offset %"PRId64" cluster_bytes %u"
 
 # block/stream.c
-stream_one_iteration(void *s, int64_t sector_num, int nb_sectors, int is_allocated) "s %p sector_num %"PRId64" nb_sectors %d is_allocated %d"
+stream_one_iteration(void *s, int64_t offset, uint64_t bytes, int is_allocated) "s %p offset %" PRId64 " bytes %" PRIu64 " is_allocated %d"
 stream_start(void *bs, void *base, void *s) "bs %p base %p s %p"
 
 # block/commit.c
-commit_one_iteration(void *s, int64_t sector_num, int nb_sectors, int is_allocated) "s %p sector_num %"PRId64" nb_sectors %d is_allocated %d"
+commit_one_iteration(void *s, int64_t offset, uint64_t bytes, int is_allocated) "s %p offset %" PRId64 " bytes %" PRIu64 " is_allocated %d"
 commit_start(void *bs, void *base, void *top, void *s) "bs %p base %p top %p s %p"
 
 # block/mirror.c
@@ -28,14 +28,14 @@ mirror_restart_iter(void *s, int64_t cnt) "s %p dirty count %"PRId64
 mirror_before_flush(void *s) "s %p"
 mirror_before_drain(void *s, int64_t cnt) "s %p dirty count %"PRId64
 mirror_before_sleep(void *s, int64_t cnt, int synced, uint64_t delay_ns) "s %p dirty count %"PRId64" synced %d delay %"PRIu64"ns"
-mirror_one_iteration(void *s, int64_t sector_num, int nb_sectors) "s %p sector_num %"PRId64" nb_sectors %d"
-mirror_iteration_done(void *s, int64_t sector_num, int nb_sectors, int ret) "s %p sector_num %"PRId64" nb_sectors %d ret %d"
+mirror_one_iteration(void *s, int64_t offset, uint64_t bytes) "s %p offset %" PRId64 " bytes %" PRIu64
+mirror_iteration_done(void *s, int64_t offset, uint64_t bytes, int ret) "s %p offset %" PRId64 " bytes %" PRIu64 " ret %d"
 mirror_yield(void *s, int64_t cnt, int buf_free_count, int in_flight) "s %p dirty count %"PRId64" free buffers %d in_flight %d"
-mirror_yield_in_flight(void *s, int64_t sector_num, int in_flight) "s %p sector_num %"PRId64" in_flight %d"
+mirror_yield_in_flight(void *s, int64_t offset, int in_flight) "s %p offset %" PRId64 " in_flight %d"
 
 # block/backup.c
-backup_do_cow_enter(void *job, int64_t start, int64_t sector_num, int nb_sectors) "job %p start %"PRId64" sector_num %"PRId64" nb_sectors %d"
-backup_do_cow_return(void *job, int64_t sector_num, int nb_sectors, int ret) "job %p sector_num %"PRId64" nb_sectors %d ret %d"
+backup_do_cow_enter(void *job, int64_t start, int64_t offset, uint64_t bytes) "job %p start %" PRId64 " offset %" PRId64 " bytes %" PRIu64
+backup_do_cow_return(void *job, int64_t offset, uint64_t bytes, int ret) "job %p offset %" PRId64 " bytes %" PRIu64 " ret %d"
 backup_do_cow_skip(void *job, int64_t start) "job %p start %"PRId64
 backup_do_cow_process(void *job, int64_t start) "job %p start %"PRId64
 backup_do_cow_read_fail(void *job, int64_t start, int ret) "job %p start %"PRId64" ret %d"
-- 
1.8.3.1
