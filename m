Received: from eggs.gnu.org ([2001:4830:134:3::10]:38807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4S-0006iH-PL
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4Q-0001Ta-Mu
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:00 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:08 +0200
Message-Id: <20180515154033.19899-13-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 12/37] blockjob: Wrappers for progress counter
 access
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

Block job drivers are not expected to mess with the internals of the
BlockJob object, so provide wrapper functions for one of the cases where
they still do it: Updating the progress counter.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 include/block/blockjob.h | 19 +++++++++++++++++++
 block/backup.c           | 22 +++++++++++++---------
 block/commit.c           | 16 ++++++++--------
 block/mirror.c           | 11 +++++------
 block/stream.c           | 14 ++++++++------
 blockjob.c               | 10 ++++++++++
 6 files changed, 63 insertions(+), 29 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index fc645dac68..a2cc52233b 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -278,6 +278,25 @@ void block_job_finalize(BlockJob *job, Error **errp);
 void block_job_dismiss(BlockJob **job, Error **errp);
 
 /**
+ * block_job_progress_update:
+ * @job: The job that has made progress
+ * @done: How much progress the job made
+ *
+ * Updates the progress counter of the job.
+ */
+void block_job_progress_update(BlockJob *job, uint64_t done);
+
+/**
+ * block_job_progress_set_remaining:
+ * @job: The job whose expected progress end value is set
+ * @remaining: Expected end value of the progress counter of the job
+ *
+ * Sets the expected end value of the progress counter of a job so that a
+ * completion percentage can be calculated when the progress is updated.
+ */
+void block_job_progress_set_remaining(BlockJob *job, uint64_t remaining);
+
+/**
  * block_job_query:
  * @job: The job to get information about.
  *
diff --git a/block/backup.c b/block/backup.c
index 453cd62c24..5d95805472 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -39,6 +39,7 @@ typedef struct BackupBlockJob {
     BlockdevOnError on_source_error;
     BlockdevOnError on_target_error;
     CoRwlock flush_rwlock;
+    uint64_t len;
     uint64_t bytes_read;
     int64_t cluster_size;
     bool compress;
@@ -118,7 +119,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
 
         trace_backup_do_cow_process(job, start);
 
-        n = MIN(job->cluster_size, job->common.len - start);
+        n = MIN(job->cluster_size, job->len - start);
 
         if (!bounce_buffer) {
             bounce_buffer = blk_blockalign(blk, job->cluster_size);
@@ -159,7 +160,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
          * offset field is an opaque progress value, it is not a disk offset.
          */
         job->bytes_read += n;
-        job->common.offset += n;
+        block_job_progress_update(&job->common, n);
     }
 
 out:
@@ -261,7 +262,7 @@ void backup_do_checkpoint(BlockJob *job, Error **errp)
         return;
     }
 
-    len = DIV_ROUND_UP(backup_job->common.len, backup_job->cluster_size);
+    len = DIV_ROUND_UP(backup_job->len, backup_job->cluster_size);
     hbitmap_set(backup_job->copy_bitmap, 0, len);
 }
 
@@ -420,8 +421,9 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
         bdrv_set_dirty_iter(dbi, next_cluster * job->cluster_size);
     }
 
-    job->common.offset = job->common.len -
-                         hbitmap_count(job->copy_bitmap) * job->cluster_size;
+    /* TODO block_job_progress_set_remaining() would make more sense */
+    block_job_progress_update(&job->common,
+        job->len - hbitmap_count(job->copy_bitmap) * job->cluster_size);
 
     bdrv_dirty_iter_free(dbi);
 }
@@ -437,7 +439,9 @@ static void coroutine_fn backup_run(void *opaque)
     QLIST_INIT(&job->inflight_reqs);
     qemu_co_rwlock_init(&job->flush_rwlock);
 
-    nb_clusters = DIV_ROUND_UP(job->common.len, job->cluster_size);
+    nb_clusters = DIV_ROUND_UP(job->len, job->cluster_size);
+    block_job_progress_set_remaining(&job->common, job->len);
+
     job->copy_bitmap = hbitmap_alloc(nb_clusters, 0);
     if (job->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
         backup_incremental_init_copy_bitmap(job);
@@ -461,7 +465,7 @@ static void coroutine_fn backup_run(void *opaque)
         ret = backup_run_incremental(job);
     } else {
         /* Both FULL and TOP SYNC_MODE's require copying.. */
-        for (offset = 0; offset < job->common.len;
+        for (offset = 0; offset < job->len;
              offset += job->cluster_size) {
             bool error_is_read;
             int alloced = 0;
@@ -620,7 +624,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         goto error;
     }
 
-    /* job->common.len is fixed, so we can't allow resize */
+    /* job->len is fixed, so we can't allow resize */
     job = block_job_create(job_id, &backup_job_driver, txn, bs,
                            BLK_PERM_CONSISTENT_READ,
                            BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
@@ -676,7 +680,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     /* Required permissions are already taken with target's blk_new() */
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
                        &error_abort);
-    job->common.len = len;
+    job->len = len;
 
     return &job->common;
 
diff --git a/block/commit.c b/block/commit.c
index 1432baeef4..50b191c980 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -146,21 +146,21 @@ static void coroutine_fn commit_run(void *opaque)
     int64_t n = 0; /* bytes */
     void *buf = NULL;
     int bytes_written = 0;
-    int64_t base_len;
+    int64_t len, base_len;
 
-    ret = s->common.len = blk_getlength(s->top);
-
-    if (s->common.len < 0) {
+    ret = len = blk_getlength(s->top);
+    if (len < 0) {
         goto out;
     }
+    block_job_progress_set_remaining(&s->common, len);
 
     ret = base_len = blk_getlength(s->base);
     if (base_len < 0) {
         goto out;
     }
 
-    if (base_len < s->common.len) {
-        ret = blk_truncate(s->base, s->common.len, PREALLOC_MODE_OFF, NULL);
+    if (base_len < len) {
+        ret = blk_truncate(s->base, len, PREALLOC_MODE_OFF, NULL);
         if (ret) {
             goto out;
         }
@@ -168,7 +168,7 @@ static void coroutine_fn commit_run(void *opaque)
 
     buf = blk_blockalign(s->top, COMMIT_BUFFER_SIZE);
 
-    for (offset = 0; offset < s->common.len; offset += n) {
+    for (offset = 0; offset < len; offset += n) {
         bool copy;
 
         /* Note that even when no rate limit is applied we need to yield
@@ -198,7 +198,7 @@ static void coroutine_fn commit_run(void *opaque)
             }
         }
         /* Publish progress */
-        s->common.offset += n;
+        block_job_progress_update(&s->common, n);
 
         if (copy && s->common.speed) {
             delay_ns = ratelimit_calculate_delay(&s->limit, n);
diff --git a/block/mirror.c b/block/mirror.c
index 99da9c0858..56a7ce2f55 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -121,7 +121,7 @@ static void mirror_iteration_done(MirrorOp *op, int ret)
             bitmap_set(s->cow_bitmap, chunk_num, nb_chunks);
         }
         if (!s->initial_zeroing_ongoing) {
-            s->common.offset += op->bytes;
+            block_job_progress_update(&s->common, op->bytes);
         }
     }
     qemu_iovec_destroy(&op->qiov);
@@ -792,11 +792,10 @@ static void coroutine_fn mirror_run(void *opaque)
         block_job_pause_point(&s->common);
 
         cnt = bdrv_get_dirty_count(s->dirty_bitmap);
-        /* s->common.offset contains the number of bytes already processed so
-         * far, cnt is the number of dirty bytes remaining and
-         * s->bytes_in_flight is the number of bytes currently being
-         * processed; together those are the current total operation length */
-        s->common.len = s->common.offset + s->bytes_in_flight + cnt;
+        /* cnt is the number of dirty bytes remaining and s->bytes_in_flight is
+         * the number of bytes currently being processed; together those are
+         * the current remaining operation length */
+        block_job_progress_set_remaining(&s->common, s->bytes_in_flight + cnt);
 
         /* Note that even when no rate limit is applied we need to yield
          * periodically with no pending I/O so that bdrv_drain_all() returns.
diff --git a/block/stream.c b/block/stream.c
index 1a85708fcf..8369852bda 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -107,6 +107,7 @@ static void coroutine_fn stream_run(void *opaque)
     BlockBackend *blk = s->common.blk;
     BlockDriverState *bs = blk_bs(blk);
     BlockDriverState *base = s->base;
+    int64_t len;
     int64_t offset = 0;
     uint64_t delay_ns = 0;
     int error = 0;
@@ -118,11 +119,12 @@ static void coroutine_fn stream_run(void *opaque)
         goto out;
     }
 
-    s->common.len = bdrv_getlength(bs);
-    if (s->common.len < 0) {
-        ret = s->common.len;
+    len = bdrv_getlength(bs);
+    if (len < 0) {
+        ret = len;
         goto out;
     }
+    block_job_progress_set_remaining(&s->common, len);
 
     buf = qemu_blockalign(bs, STREAM_BUFFER_SIZE);
 
@@ -135,7 +137,7 @@ static void coroutine_fn stream_run(void *opaque)
         bdrv_enable_copy_on_read(bs);
     }
 
-    for ( ; offset < s->common.len; offset += n) {
+    for ( ; offset < len; offset += n) {
         bool copy;
 
         /* Note that even when no rate limit is applied we need to yield
@@ -159,7 +161,7 @@ static void coroutine_fn stream_run(void *opaque)
 
             /* Finish early if end of backing file has been reached */
             if (ret == 0 && n == 0) {
-                n = s->common.len - offset;
+                n = len - offset;
             }
 
             copy = (ret == 1);
@@ -185,7 +187,7 @@ static void coroutine_fn stream_run(void *opaque)
         ret = 0;
 
         /* Publish progress */
-        s->common.offset += n;
+        block_job_progress_update(&s->common, n);
         if (copy && s->common.speed) {
             delay_ns = ratelimit_calculate_delay(&s->limit, n);
         } else {
diff --git a/blockjob.c b/blockjob.c
index 0ebc5ab178..ebc26a5245 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -810,6 +810,16 @@ int block_job_complete_sync(BlockJob *job, Error **errp)
     return block_job_finish_sync(job, &block_job_complete, errp);
 }
 
+void block_job_progress_update(BlockJob *job, uint64_t done)
+{
+    job->offset += done;
+}
+
+void block_job_progress_set_remaining(BlockJob *job, uint64_t remaining)
+{
+    job->len = job->offset + remaining;
+}
+
 BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
 {
     BlockJobInfo *info;
-- 
2.13.6
