Received: from eggs.gnu.org ([2001:4830:134:3::10]:52909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwn-00065M-Ks
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwl-00032f-VY
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:28:09 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  9 May 2018 18:26:32 +0200
Message-Id: <20180509162637.15575-38-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-1-kwolf@redhat.com>
References: <20180509162637.15575-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 37/42] job: Move progress fields to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

BlockJob has fields .offset and .len, which are actually misnomers today
because they are no longer tied to block device sizes, but just progress
counters. As such they make a lot of sense in generic Jobs.

This patch moves the fields to Job and renames them to .progress_current
and .progress_total to describe their function better.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob.h | 25 -------------------------
 include/qemu/job.h       | 27 +++++++++++++++++++++++++++
 block/backup.c           |  8 ++++----
 block/commit.c           |  4 ++--
 block/mirror.c           |  4 ++--
 block/stream.c           |  4 ++--
 blockjob.c               | 26 ++++++++------------------
 job.c                    | 10 ++++++++++
 qemu-img.c               |  8 ++++++--
 9 files changed, 61 insertions(+), 55 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index d2f0d81dfa..af34b97b4b 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -52,12 +52,6 @@ typedef struct BlockJob {
     /** Status that is published by the query-block-jobs QMP API */
     BlockDeviceIoStatus iostatus;
 
-    /** Offset that is published by the query-block-jobs QMP API */
-    int64_t offset;
-
-    /** Length that is published by the query-block-jobs QMP API */
-    int64_t len;
-
     /** Speed that was set with @block_job_set_speed.  */
     int64_t speed;
 
@@ -139,25 +133,6 @@ void block_job_remove_all_bdrv(BlockJob *job);
 void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp);
 
 /**
- * block_job_progress_update:
- * @job: The job that has made progress
- * @done: How much progress the job made
- *
- * Updates the progress counter of the job.
- */
-void block_job_progress_update(BlockJob *job, uint64_t done);
-
-/**
- * block_job_progress_set_remaining:
- * @job: The job whose expected progress end value is set
- * @remaining: Expected end value of the progress counter of the job
- *
- * Sets the expected end value of the progress counter of a job so that a
- * completion percentage can be calculated when the progress is updated.
- */
-void block_job_progress_set_remaining(BlockJob *job, uint64_t remaining);
-
-/**
  * block_job_query:
  * @job: The job to get information about.
  *
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 20b48926d9..9e61663f3a 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -114,6 +114,16 @@ typedef struct Job {
     /** True if this job should automatically dismiss itself */
     bool auto_dismiss;
 
+    /**
+     * Current progress. The unit is arbitrary as long as the ratio between
+     * progress_current and progress_total represents the estimated percentage
+     * of work already done.
+     */
+    int64_t progress_current;
+
+    /** Estimated progress_current value at the completion of the job */
+    int64_t progress_total;
+
     /** ret code passed to block_job_completed. */
     int ret;
 
@@ -304,6 +314,23 @@ void job_ref(Job *job);
  */
 void job_unref(Job *job);
 
+/**
+ * @job: The job that has made progress
+ * @done: How much progress the job made
+ *
+ * Updates the progress counter of the job.
+ */
+void job_progress_update(Job *job, uint64_t done);
+
+/**
+ * @job: The job whose expected progress end value is set
+ * @remaining: Expected end value of the progress counter of the job
+ *
+ * Sets the expected end value of the progress counter of a job so that a
+ * completion percentage can be calculated when the progress is updated.
+ */
+void job_progress_set_remaining(Job *job, uint64_t remaining);
+
 /** To be called when a cancelled job is finalised. */
 void job_event_cancelled(Job *job);
 
diff --git a/block/backup.c b/block/backup.c
index 6f4f3df229..4e228e959b 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -160,7 +160,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
          * offset field is an opaque progress value, it is not a disk offset.
          */
         job->bytes_read += n;
-        block_job_progress_update(&job->common, n);
+        job_progress_update(&job->common.job, n);
     }
 
 out:
@@ -406,8 +406,8 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
         bdrv_set_dirty_iter(dbi, next_cluster * job->cluster_size);
     }
 
-    /* TODO block_job_progress_set_remaining() would make more sense */
-    block_job_progress_update(&job->common,
+    /* TODO job_progress_set_remaining() would make more sense */
+    job_progress_update(&job->common.job,
         job->len - hbitmap_count(job->copy_bitmap) * job->cluster_size);
 
     bdrv_dirty_iter_free(dbi);
@@ -425,7 +425,7 @@ static void coroutine_fn backup_run(void *opaque)
     qemu_co_rwlock_init(&job->flush_rwlock);
 
     nb_clusters = DIV_ROUND_UP(job->len, job->cluster_size);
-    block_job_progress_set_remaining(&job->common, job->len);
+    job_progress_set_remaining(&job->common.job, job->len);
 
     job->copy_bitmap = hbitmap_alloc(nb_clusters, 0);
     if (job->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
diff --git a/block/commit.c b/block/commit.c
index 56c3810bad..4b48c25750 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -150,7 +150,7 @@ static void coroutine_fn commit_run(void *opaque)
     if (len < 0) {
         goto out;
     }
-    block_job_progress_set_remaining(&s->common, len);
+    job_progress_set_remaining(&s->common.job, len);
 
     ret = base_len = blk_getlength(s->base);
     if (base_len < 0) {
@@ -196,7 +196,7 @@ static void coroutine_fn commit_run(void *opaque)
             }
         }
         /* Publish progress */
-        block_job_progress_update(&s->common, n);
+        job_progress_update(&s->common.job, n);
 
         if (copy) {
             delay_ns = block_job_ratelimit_get_delay(&s->common, n);
diff --git a/block/mirror.c b/block/mirror.c
index 376b08bdcd..9583870425 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -119,7 +119,7 @@ static void mirror_iteration_done(MirrorOp *op, int ret)
             bitmap_set(s->cow_bitmap, chunk_num, nb_chunks);
         }
         if (!s->initial_zeroing_ongoing) {
-            block_job_progress_update(&s->common, op->bytes);
+            job_progress_update(&s->common.job, op->bytes);
         }
     }
     qemu_iovec_destroy(&op->qiov);
@@ -792,7 +792,7 @@ static void coroutine_fn mirror_run(void *opaque)
         /* cnt is the number of dirty bytes remaining and s->bytes_in_flight is
          * the number of bytes currently being processed; together those are
          * the current total operation length */
-        block_job_progress_set_remaining(&s->common, s->bytes_in_flight + cnt);
+        job_progress_set_remaining(&s->common.job, s->bytes_in_flight + cnt);
 
         /* Note that even when no rate limit is applied we need to yield
          * periodically with no pending I/O so that bdrv_drain_all() returns.
diff --git a/block/stream.c b/block/stream.c
index 8546c412cd..a5d6e0cf8a 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -121,7 +121,7 @@ static void coroutine_fn stream_run(void *opaque)
         ret = len;
         goto out;
     }
-    block_job_progress_set_remaining(&s->common, len);
+    job_progress_set_remaining(&s->common.job, len);
 
     buf = qemu_blockalign(bs, STREAM_BUFFER_SIZE);
 
@@ -184,7 +184,7 @@ static void coroutine_fn stream_run(void *opaque)
         ret = 0;
 
         /* Publish progress */
-        block_job_progress_update(&s->common, n);
+        job_progress_update(&s->common.job, n);
         if (copy) {
             delay_ns = block_job_ratelimit_get_delay(&s->common, n);
         } else {
diff --git a/blockjob.c b/blockjob.c
index 27f3199a20..26d9017a61 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -243,16 +243,6 @@ int64_t block_job_ratelimit_get_delay(BlockJob *job, uint64_t n)
     return ratelimit_calculate_delay(&job->limit, n);
 }
 
-void block_job_progress_update(BlockJob *job, uint64_t done)
-{
-    job->offset += done;
-}
-
-void block_job_progress_set_remaining(BlockJob *job, uint64_t remaining)
-{
-    job->len = job->offset + remaining;
-}
-
 BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
 {
     BlockJobInfo *info;
@@ -264,10 +254,10 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
     info = g_new0(BlockJobInfo, 1);
     info->type      = g_strdup(job_type_str(&job->job));
     info->device    = g_strdup(job->job.id);
-    info->len       = job->len;
     info->busy      = atomic_read(&job->job.busy);
     info->paused    = job->job.pause_count > 0;
-    info->offset    = job->offset;
+    info->offset    = job->job.progress_current;
+    info->len       = job->job.progress_total;
     info->speed     = job->speed;
     info->io_status = job->iostatus;
     info->ready     = job_is_ready(&job->job),
@@ -297,8 +287,8 @@ static void block_job_event_cancelled(Notifier *n, void *opaque)
 
     qapi_event_send_block_job_cancelled(job_type(&job->job),
                                         job->job.id,
-                                        job->len,
-                                        job->offset,
+                                        job->job.progress_total,
+                                        job->job.progress_current,
                                         job->speed,
                                         &error_abort);
 }
@@ -318,8 +308,8 @@ static void block_job_event_completed(Notifier *n, void *opaque)
 
     qapi_event_send_block_job_completed(job_type(&job->job),
                                         job->job.id,
-                                        job->len,
-                                        job->offset,
+                                        job->job.progress_total,
+                                        job->job.progress_current,
                                         job->speed,
                                         !!msg,
                                         msg,
@@ -349,8 +339,8 @@ static void block_job_event_ready(Notifier *n, void *opaque)
 
     qapi_event_send_block_job_ready(job_type(&job->job),
                                     job->job.id,
-                                    job->len,
-                                    job->offset,
+                                    job->job.progress_total,
+                                    job->job.progress_current,
                                     job->speed, &error_abort);
 }
 
diff --git a/job.c b/job.c
index 4e898b5c5e..e45c301fcd 100644
--- a/job.c
+++ b/job.c
@@ -364,6 +364,16 @@ void job_unref(Job *job)
     }
 }
 
+void job_progress_update(Job *job, uint64_t done)
+{
+    job->progress_current += done;
+}
+
+void job_progress_set_remaining(Job *job, uint64_t remaining)
+{
+    job->progress_total = job->progress_current + remaining;
+}
+
 void job_event_cancelled(Job *job)
 {
     notifier_list_notify(&job->on_finalize_cancelled, job);
diff --git a/qemu-img.c b/qemu-img.c
index 6361d4edf5..b248357e22 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -864,9 +864,13 @@ static void run_block_job(BlockJob *job, Error **errp)
     aio_context_acquire(aio_context);
     job_ref(&job->job);
     do {
+        float progress = 0.0f;
         aio_poll(aio_context, true);
-        qemu_progress_print(job->len ?
-                            ((float)job->offset / job->len * 100.f) : 0.0f, 0);
+        if (job->job.progress_total) {
+            progress = (float)job->job.progress_current /
+                       job->job.progress_total * 100.f;
+        }
+        qemu_progress_print(progress, 0);
     } while (!job_is_ready(&job->job) && !job_is_completed(&job->job));
 
     if (!job_is_completed(&job->job)) {
-- 
2.13.6
