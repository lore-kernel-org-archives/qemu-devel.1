Received: from eggs.gnu.org ([2001:4830:134:3::10]:59418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJfKM-0008EY-Bi
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJfKI-0005sc-Eh
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:21:46 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 18 May 2018 15:20:44 +0200
Message-Id: <20180518132114.4070-11-kwolf@redhat.com>
In-Reply-To: <20180518132114.4070-1-kwolf@redhat.com>
References: <20180518132114.4070-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/40] job: Move cancelled to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

We cannot yet move the whole logic around job cancelling to Job because
it depends on quite a few other things that are still only in BlockJob,
but we can move the cancelled field at least.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 include/block/blockjob.h     |  8 --------
 include/block/blockjob_int.h |  8 --------
 include/qemu/job.h           | 11 +++++++++++
 block/backup.c               |  6 +++---
 block/commit.c               |  4 ++--
 block/mirror.c               | 20 ++++++++++----------
 block/stream.c               |  4 ++--
 blockjob.c                   | 28 +++++++++++++---------------
 job.c                        |  5 +++++
 tests/test-blockjob-txn.c    |  6 +++---
 tests/test-blockjob.c        |  2 +-
 11 files changed, 50 insertions(+), 52 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 087e7820f5..1e708f468a 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -57,14 +57,6 @@ typedef struct BlockJob {
     Coroutine *co;
 
     /**
-     * Set to true if the job should cancel itself.  The flag must
-     * always be tested just before toggling the busy flag from false
-     * to true.  After a job has been cancelled, it should only yield
-     * if #aio_poll will ("sooner or later") reenter the coroutine.
-     */
-    bool cancelled;
-
-    /**
      * Set to true if the job should abort immediately without waiting
      * for data to be in sync.
      */
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 6f0fe3c48d..d64f30e6b0 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -196,14 +196,6 @@ void block_job_early_fail(BlockJob *job);
 void block_job_completed(BlockJob *job, int ret);
 
 /**
- * block_job_is_cancelled:
- * @job: The job being queried.
- *
- * Returns whether the job is scheduled for cancellation.
- */
-bool block_job_is_cancelled(BlockJob *job);
-
-/**
  * block_job_pause_point:
  * @job: The job that is ready to pause.
  *
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 0751e2afab..5dfbec5d69 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -47,6 +47,14 @@ typedef struct Job {
     /** Current state; See @JobStatus for details. */
     JobStatus status;
 
+    /**
+     * Set to true if the job should cancel itself.  The flag must
+     * always be tested just before toggling the busy flag from false
+     * to true.  After a job has been cancelled, it should only yield
+     * if #aio_poll will ("sooner or later") reenter the coroutine.
+     */
+    bool cancelled;
+
     /** Element of the list of jobs */
     QLIST_ENTRY(Job) job_list;
 } Job;
@@ -93,6 +101,9 @@ JobType job_type(const Job *job);
 /** Returns the enum string for the JobType of a given Job. */
 const char *job_type_str(const Job *job);
 
+/** Returns whether the job is scheduled for cancellation. */
+bool job_is_cancelled(Job *job);
+
 /**
  * Get the next element from the list of block jobs after @job, or the
  * first one if @job is %NULL.
diff --git a/block/backup.c b/block/backup.c
index cfdb89d977..ef0aa0e24e 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -329,7 +329,7 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
 {
     uint64_t delay_ns;
 
-    if (block_job_is_cancelled(&job->common)) {
+    if (job_is_cancelled(&job->common.job)) {
         return true;
     }
 
@@ -339,7 +339,7 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
     job->bytes_read = 0;
     block_job_sleep_ns(&job->common, delay_ns);
 
-    if (block_job_is_cancelled(&job->common)) {
+    if (job_is_cancelled(&job->common.job)) {
         return true;
     }
 
@@ -441,7 +441,7 @@ static void coroutine_fn backup_run(void *opaque)
     if (job->sync_mode == MIRROR_SYNC_MODE_NONE) {
         /* All bits are set in copy_bitmap to allow any cluster to be copied.
          * This does not actually require them to be copied. */
-        while (!block_job_is_cancelled(&job->common)) {
+        while (!job_is_cancelled(&job->common.job)) {
             /* Yield until the job is cancelled.  We just let our before_write
              * notify callback service CoW requests. */
             block_job_yield(&job->common);
diff --git a/block/commit.c b/block/commit.c
index 925c96abe7..85baea8f92 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -90,7 +90,7 @@ static void commit_complete(BlockJob *job, void *opaque)
      * the normal backing chain can be restored. */
     blk_unref(s->base);
 
-    if (!block_job_is_cancelled(&s->common) && ret == 0) {
+    if (!job_is_cancelled(&s->common.job) && ret == 0) {
         /* success */
         ret = bdrv_drop_intermediate(s->commit_top_bs, base,
                                      s->backing_file_str);
@@ -172,7 +172,7 @@ static void coroutine_fn commit_run(void *opaque)
          * with no pending I/O here so that bdrv_drain_all() returns.
          */
         block_job_sleep_ns(&s->common, delay_ns);
-        if (block_job_is_cancelled(&s->common)) {
+        if (job_is_cancelled(&s->common.job)) {
             break;
         }
         /* Copy if allocated above the base */
diff --git a/block/mirror.c b/block/mirror.c
index 0df4f709fd..424072ed00 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -622,7 +622,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
 
             mirror_throttle(s);
 
-            if (block_job_is_cancelled(&s->common)) {
+            if (job_is_cancelled(&s->common.job)) {
                 s->initial_zeroing_ongoing = false;
                 return 0;
             }
@@ -650,7 +650,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
 
         mirror_throttle(s);
 
-        if (block_job_is_cancelled(&s->common)) {
+        if (job_is_cancelled(&s->common.job)) {
             return 0;
         }
 
@@ -695,7 +695,7 @@ static void coroutine_fn mirror_run(void *opaque)
                                  checking for a NULL string */
     int ret = 0;
 
-    if (block_job_is_cancelled(&s->common)) {
+    if (job_is_cancelled(&s->common.job)) {
         goto immediate_exit;
     }
 
@@ -729,10 +729,10 @@ static void coroutine_fn mirror_run(void *opaque)
         /* Report BLOCK_JOB_READY and wait for complete. */
         block_job_event_ready(&s->common);
         s->synced = true;
-        while (!block_job_is_cancelled(&s->common) && !s->should_complete) {
+        while (!job_is_cancelled(&s->common.job) && !s->should_complete) {
             block_job_yield(&s->common);
         }
-        s->common.cancelled = false;
+        s->common.job.cancelled = false;
         goto immediate_exit;
     }
 
@@ -768,7 +768,7 @@ static void coroutine_fn mirror_run(void *opaque)
     s->last_pause_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     if (!s->is_none_mode) {
         ret = mirror_dirty_init(s);
-        if (ret < 0 || block_job_is_cancelled(&s->common)) {
+        if (ret < 0 || job_is_cancelled(&s->common.job)) {
             goto immediate_exit;
         }
     }
@@ -828,7 +828,7 @@ static void coroutine_fn mirror_run(void *opaque)
             }
 
             should_complete = s->should_complete ||
-                block_job_is_cancelled(&s->common);
+                job_is_cancelled(&s->common.job);
             cnt = bdrv_get_dirty_count(s->dirty_bitmap);
         }
 
@@ -856,7 +856,7 @@ static void coroutine_fn mirror_run(void *opaque)
              * completion.
              */
             assert(QLIST_EMPTY(&bs->tracked_requests));
-            s->common.cancelled = false;
+            s->common.job.cancelled = false;
             need_drain = false;
             break;
         }
@@ -869,7 +869,7 @@ static void coroutine_fn mirror_run(void *opaque)
         }
         trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
         block_job_sleep_ns(&s->common, delay_ns);
-        if (block_job_is_cancelled(&s->common) &&
+        if (job_is_cancelled(&s->common.job) &&
             (!s->synced || s->common.force))
         {
             break;
@@ -884,7 +884,7 @@ immediate_exit:
          * the target is a copy of the source.
          */
         assert(ret < 0 || ((s->common.force || !s->synced) &&
-               block_job_is_cancelled(&s->common)));
+               job_is_cancelled(&s->common.job)));
         assert(need_drain);
         mirror_wait_for_all_io(s);
     }
diff --git a/block/stream.c b/block/stream.c
index 7273d2213c..22c71ae100 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -66,7 +66,7 @@ static void stream_complete(BlockJob *job, void *opaque)
     BlockDriverState *base = s->base;
     Error *local_err = NULL;
 
-    if (!block_job_is_cancelled(&s->common) && bs->backing &&
+    if (!job_is_cancelled(&s->common.job) && bs->backing &&
         data->ret == 0) {
         const char *base_id = NULL, *base_fmt = NULL;
         if (base) {
@@ -141,7 +141,7 @@ static void coroutine_fn stream_run(void *opaque)
          * with no pending I/O here so that bdrv_drain_all() returns.
          */
         block_job_sleep_ns(&s->common, delay_ns);
-        if (block_job_is_cancelled(&s->common)) {
+        if (job_is_cancelled(&s->common.job)) {
             break;
         }
 
diff --git a/blockjob.c b/blockjob.c
index 0bf0a26af0..f4f9956678 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -379,7 +379,7 @@ static void block_job_conclude(BlockJob *job)
 
 static void block_job_update_rc(BlockJob *job)
 {
-    if (!job->ret && block_job_is_cancelled(job)) {
+    if (!job->ret && job_is_cancelled(&job->job)) {
         job->ret = -ECANCELED;
     }
     if (job->ret) {
@@ -438,7 +438,7 @@ static int block_job_finalize_single(BlockJob *job)
 
     /* Emit events only if we actually started */
     if (block_job_started(job)) {
-        if (block_job_is_cancelled(job)) {
+        if (job_is_cancelled(&job->job)) {
             block_job_event_cancelled(job);
         } else {
             const char *msg = NULL;
@@ -464,7 +464,7 @@ static void block_job_cancel_async(BlockJob *job, bool force)
         job->user_paused = false;
         job->pause_count--;
     }
-    job->cancelled = true;
+    job->job.cancelled = true;
     /* To prevent 'force == false' overriding a previous 'force == true' */
     job->force |= force;
 }
@@ -519,7 +519,8 @@ static int block_job_finish_sync(BlockJob *job,
     while (!job->completed) {
         aio_poll(qemu_get_aio_context(), true);
     }
-    ret = (job->cancelled && job->ret == 0) ? -ECANCELED : job->ret;
+    ret = (job_is_cancelled(&job->job) && job->ret == 0)
+          ? -ECANCELED : job->ret;
     job_unref(&job->job);
     return ret;
 }
@@ -557,7 +558,7 @@ static void block_job_completed_txn_abort(BlockJob *job)
         other_job = QLIST_FIRST(&txn->jobs);
         ctx = blk_get_aio_context(other_job->blk);
         if (!other_job->completed) {
-            assert(other_job->cancelled);
+            assert(job_is_cancelled(&other_job->job));
             block_job_finish_sync(other_job, NULL, NULL);
         }
         block_job_finalize_single(other_job);
@@ -651,7 +652,9 @@ void block_job_complete(BlockJob *job, Error **errp)
     if (job_apply_verb(&job->job, JOB_VERB_COMPLETE, errp)) {
         return;
     }
-    if (job->pause_count || job->cancelled || !job->driver->complete) {
+    if (job->pause_count || job_is_cancelled(&job->job) ||
+        !job->driver->complete)
+    {
         error_setg(errp, "The active block job '%s' cannot be completed",
                    job->job.id);
         return;
@@ -1006,7 +1009,7 @@ void coroutine_fn block_job_pause_point(BlockJob *job)
     if (!block_job_should_pause(job)) {
         return;
     }
-    if (block_job_is_cancelled(job)) {
+    if (job_is_cancelled(&job->job)) {
         return;
     }
 
@@ -1014,7 +1017,7 @@ void coroutine_fn block_job_pause_point(BlockJob *job)
         job->driver->pause(job);
     }
 
-    if (block_job_should_pause(job) && !block_job_is_cancelled(job)) {
+    if (block_job_should_pause(job) && !job_is_cancelled(&job->job)) {
         JobStatus status = job->job.status;
         job_state_transition(&job->job, status == JOB_STATUS_READY
                                         ? JOB_STATUS_STANDBY
@@ -1066,17 +1069,12 @@ void block_job_enter(BlockJob *job)
     block_job_enter_cond(job, NULL);
 }
 
-bool block_job_is_cancelled(BlockJob *job)
-{
-    return job->cancelled;
-}
-
 void block_job_sleep_ns(BlockJob *job, int64_t ns)
 {
     assert(job->busy);
 
     /* Check cancellation *before* setting busy = false, too!  */
-    if (block_job_is_cancelled(job)) {
+    if (job_is_cancelled(&job->job)) {
         return;
     }
 
@@ -1092,7 +1090,7 @@ void block_job_yield(BlockJob *job)
     assert(job->busy);
 
     /* Check cancellation *before* setting busy = false, too!  */
-    if (block_job_is_cancelled(job)) {
+    if (job_is_cancelled(&job->job)) {
         return;
     }
 
diff --git a/job.c b/job.c
index e588fbe53d..92729cffa4 100644
--- a/job.c
+++ b/job.c
@@ -95,6 +95,11 @@ const char *job_type_str(const Job *job)
     return JobType_str(job_type(job));
 }
 
+bool job_is_cancelled(Job *job)
+{
+    return job->cancelled;
+}
+
 Job *job_next(Job *job)
 {
     if (!job) {
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index b49b28ca27..26b4bbb230 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -29,7 +29,7 @@ static void test_block_job_complete(BlockJob *job, void *opaque)
     BlockDriverState *bs = blk_bs(job->blk);
     int rc = (intptr_t)opaque;
 
-    if (block_job_is_cancelled(job)) {
+    if (job_is_cancelled(&job->job)) {
         rc = -ECANCELED;
     }
 
@@ -49,7 +49,7 @@ static void coroutine_fn test_block_job_run(void *opaque)
             block_job_yield(job);
         }
 
-        if (block_job_is_cancelled(job)) {
+        if (job_is_cancelled(&job->job)) {
             break;
         }
     }
@@ -66,7 +66,7 @@ typedef struct {
 static void test_block_job_cb(void *opaque, int ret)
 {
     TestBlockJobCBData *data = opaque;
-    if (!ret && block_job_is_cancelled(&data->job->common)) {
+    if (!ret && job_is_cancelled(&data->job->common.job)) {
         ret = -ECANCELED;
     }
     *data->result = ret;
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index e24fc3f140..fa31481537 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -179,7 +179,7 @@ static void coroutine_fn cancel_job_start(void *opaque)
     CancelJob *s = opaque;
 
     while (!s->should_complete) {
-        if (block_job_is_cancelled(&s->common)) {
+        if (job_is_cancelled(&s->common.job)) {
             goto defer;
         }
 
-- 
2.13.6
