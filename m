Received: from eggs.gnu.org ([2001:4830:134:3::10]:48140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fAzpT-0008JE-PY
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fAzpR-0008TJ-5d
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:26:03 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 24 Apr 2018 17:25:06 +0200
Message-Id: <20180424152515.25664-25-kwolf@redhat.com>
In-Reply-To: <20180424152515.25664-1-kwolf@redhat.com>
References: <20180424152515.25664-1-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 24/33] job: Move single job finalisation to
 Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This moves the finalisation of a single job from BlockJob to Job.

Some part of this code depends on job transactions, and job transactions
call this code, we introduce some temporary calls from Job functions to
BlockJob ones. This will be fixed once transactions move to Job, too.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob.h     |   9 ---
 include/block/blockjob_int.h |  36 -----------
 include/qemu/job.h           |  53 ++++++++++++++++-
 block/backup.c               |  22 +++----
 block/commit.c               |   2 +-
 block/mirror.c               |   2 +-
 blockjob.c                   | 138 ++++++++-----------------------------------
 job.c                        | 101 ++++++++++++++++++++++++++++++-
 qemu-img.c                   |   2 +-
 tests/test-blockjob.c        |  10 ++--
 10 files changed, 194 insertions(+), 181 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index b5bcb52219..e5af02f751 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -76,9 +76,6 @@ typedef struct BlockJob {
     /** Rate limiting data structure for implementing @speed. */
     RateLimit limit;
 
-    /** The completion function that will be called when the job completes.  */
-    BlockCompletionFunc *cb;
-
     /** Block other operations when block job is running */
     Error *blocker;
 
@@ -94,12 +91,6 @@ typedef struct BlockJob {
     /** BlockDriverStates that are involved in this block job */
     GSList *nodes;
 
-    /** The opaque value that is passed to the completion function.  */
-    void *opaque;
-
-    /** ret code passed to block_job_completed. */
-    int ret;
-
     BlockJobTxn *txn;
     QLIST_ENTRY(BlockJob) txn_list;
 } BlockJob;
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 543ca556fc..5b0a905c76 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -54,34 +54,6 @@ struct BlockJobDriver {
      */
     int (*prepare)(BlockJob *job);
 
-    /**
-     * If the callback is not NULL, it will be invoked when all the jobs
-     * belonging to the same transaction complete; or upon this job's
-     * completion if it is not in a transaction. Skipped if NULL.
-     *
-     * All jobs will complete with a call to either .commit() or .abort() but
-     * never both.
-     */
-    void (*commit)(BlockJob *job);
-
-    /**
-     * If the callback is not NULL, it will be invoked when any job in the
-     * same transaction fails; or upon this job's failure (due to error or
-     * cancellation) if it is not in a transaction. Skipped if NULL.
-     *
-     * All jobs will complete with a call to either .commit() or .abort() but
-     * never both.
-     */
-    void (*abort)(BlockJob *job);
-
-    /**
-     * If the callback is not NULL, it will be invoked after a call to either
-     * .commit() or .abort(). Regardless of which callback is invoked after
-     * completion, .clean() will always be called, even if the job does not
-     * belong to a transaction group.
-     */
-    void (*clean)(BlockJob *job);
-
     /*
      * If the callback is not NULL, it will be invoked before the job is
      * resumed in a new AioContext.  This is the place to move any resources
@@ -156,14 +128,6 @@ void block_job_yield(BlockJob *job);
 int64_t block_job_ratelimit_get_delay(BlockJob *job, uint64_t n);
 
 /**
- * block_job_early_fail:
- * @bs: The block device.
- *
- * The block job could not be started, free it.
- */
-void block_job_early_fail(BlockJob *job);
-
-/**
  * block_job_completed:
  * @job: The job being completed.
  * @ret: The status code.
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 3d9a9a8d77..f456e4f27d 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -29,6 +29,7 @@
 #include "qapi/qapi-types-block-core.h"
 #include "qemu/queue.h"
 #include "qemu/coroutine.h"
+#include "block/aio.h"
 
 typedef struct JobDriver JobDriver;
 
@@ -105,6 +106,15 @@ typedef struct Job {
     /** True if this job should automatically dismiss itself */
     bool auto_dismiss;
 
+    /** ret code passed to block_job_completed. */
+    int ret;
+
+    /** The completion function that will be called when the job completes.  */
+    BlockCompletionFunc *cb;
+
+    /** The opaque value that is passed to the completion function.  */
+    void *opaque;
+
     /** Notifiers called when a cancelled job is finalised */
     NotifierList on_finalize_cancelled;
 
@@ -151,6 +161,35 @@ struct JobDriver {
      */
     void (*user_resume)(Job *job);
 
+    /**
+     * If the callback is not NULL, it will be invoked when all the jobs
+     * belonging to the same transaction complete; or upon this job's
+     * completion if it is not in a transaction. Skipped if NULL.
+     *
+     * All jobs will complete with a call to either .commit() or .abort() but
+     * never both.
+     */
+    void (*commit)(Job *job);
+
+    /**
+     * If the callback is not NULL, it will be invoked when any job in the
+     * same transaction fails; or upon this job's failure (due to error or
+     * cancellation) if it is not in a transaction. Skipped if NULL.
+     *
+     * All jobs will complete with a call to either .commit() or .abort() but
+     * never both.
+     */
+    void (*abort)(Job *job);
+
+    /**
+     * If the callback is not NULL, it will be invoked after a call to either
+     * .commit() or .abort(). Regardless of which callback is invoked after
+     * completion, .clean() will always be called, even if the job does not
+     * belong to a transaction group.
+     */
+    void (*clean)(Job *job);
+
+
     /** Called when the job is freed */
     void (*free)(Job *job);
 };
@@ -174,10 +213,12 @@ typedef enum JobCreateFlags {
  * @driver: The class object for the newly-created job.
  * @ctx: The AioContext to run the job coroutine in.
  * @flags: Creation flags for the job. See @JobCreateFlags.
+ * @cb: Completion function for the job.
+ * @opaque: Opaque pointer value passed to @cb.
  * @errp: Error object.
  */
 void *job_create(const char *job_id, const JobDriver *driver, AioContext *ctx,
-                 int flags, Error **errp);
+                 int flags, BlockCompletionFunc *cb, void *opaque, Error **errp);
 
 /**
  * Add a reference to Job refcnt, it will be decreased with job_unref, and then
@@ -276,6 +317,10 @@ Job *job_next(Job *job);
  */
 Job *job_get(const char *id);
 
+/** The @job could not be started, free it. */
+void job_early_fail(Job *job);
+
+
 typedef void JobDeferToMainLoopFn(Job *job, void *opaque);
 
 /**
@@ -302,5 +347,11 @@ bool job_started(Job *job);
 void job_enter_cond(Job *job, bool(*fn)(Job *job));
 void job_pause(Job *job);
 void job_resume(Job *job);
+void job_do_dismiss(Job *job);
+int job_finalize_single(Job *job);
+void job_update_rc(Job *job);
+
+typedef struct BlockJob BlockJob;
+void block_job_txn_del_job(BlockJob *job);
 
 #endif
diff --git a/block/backup.c b/block/backup.c
index eca4f764c4..1f17025505 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -207,25 +207,25 @@ static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
     }
 }
 
-static void backup_commit(BlockJob *job)
+static void backup_commit(Job *job)
 {
-    BackupBlockJob *s = container_of(job, BackupBlockJob, common);
+    BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
     if (s->sync_bitmap) {
         backup_cleanup_sync_bitmap(s, 0);
     }
 }
 
-static void backup_abort(BlockJob *job)
+static void backup_abort(Job *job)
 {
-    BackupBlockJob *s = container_of(job, BackupBlockJob, common);
+    BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
     if (s->sync_bitmap) {
         backup_cleanup_sync_bitmap(s, -1);
     }
 }
 
-static void backup_clean(BlockJob *job)
+static void backup_clean(Job *job)
 {
-    BackupBlockJob *s = container_of(job, BackupBlockJob, common);
+    BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
     assert(s->target);
     blk_unref(s->target);
     s->target = NULL;
@@ -530,10 +530,10 @@ static const BlockJobDriver backup_job_driver = {
         .free                   = block_job_free,
         .user_resume            = block_job_user_resume,
         .start                  = backup_run,
+        .commit                 = backup_commit,
+        .abort                  = backup_abort,
+        .clean                  = backup_clean,
     },
-    .commit                 = backup_commit,
-    .abort                  = backup_abort,
-    .clean                  = backup_clean,
     .attached_aio_context   = backup_attached_aio_context,
     .drain                  = backup_drain,
 };
@@ -678,8 +678,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         bdrv_reclaim_dirty_bitmap(bs, sync_bitmap, NULL);
     }
     if (job) {
-        backup_clean(&job->common);
-        block_job_early_fail(&job->common);
+        backup_clean(&job->common.job);
+        job_early_fail(&job->common.job);
     }
 
     return NULL;
diff --git a/block/commit.c b/block/commit.c
index 7a6ae59d42..e53b2d7d55 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -385,7 +385,7 @@ fail:
     if (commit_top_bs) {
         bdrv_replace_node(commit_top_bs, top, &error_abort);
     }
-    block_job_early_fail(&s->common);
+    job_early_fail(&s->common.job);
 }
 
 
diff --git a/block/mirror.c b/block/mirror.c
index fc3bd702dc..3266553ffb 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1251,7 +1251,7 @@ fail:
 
         g_free(s->replaces);
         blk_unref(s->target);
-        block_job_early_fail(&s->common);
+        job_early_fail(&s->common.job);
     }
 
     bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
diff --git a/blockjob.c b/blockjob.c
index 2f36888c0a..677938a3b7 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -128,7 +128,7 @@ void block_job_txn_add_job(BlockJobTxn *txn, BlockJob *job)
     block_job_txn_ref(txn);
 }
 
-static void block_job_txn_del_job(BlockJob *job)
+void block_job_txn_del_job(BlockJob *job)
 {
     if (job->txn) {
         QLIST_REMOVE(job, txn_list);
@@ -263,101 +263,12 @@ const BlockJobDriver *block_job_driver(BlockJob *job)
     return job->driver;
 }
 
-static void block_job_decommission(BlockJob *job)
-{
-    assert(job);
-    job->job.busy = false;
-    job->job.paused = false;
-    job->job.deferred_to_main_loop = true;
-    block_job_txn_del_job(job);
-    job_state_transition(&job->job, JOB_STATUS_NULL);
-    job_unref(&job->job);
-}
-
-static void block_job_do_dismiss(BlockJob *job)
-{
-    block_job_decommission(job);
-}
-
-static void block_job_conclude(BlockJob *job)
-{
-    job_state_transition(&job->job, JOB_STATUS_CONCLUDED);
-    if (job->job.auto_dismiss || !job_started(&job->job)) {
-        block_job_do_dismiss(job);
-    }
-}
-
-static void block_job_update_rc(BlockJob *job)
-{
-    if (!job->ret && job_is_cancelled(&job->job)) {
-        job->ret = -ECANCELED;
-    }
-    if (job->ret) {
-        job_state_transition(&job->job, JOB_STATUS_ABORTING);
-    }
-}
-
 static int block_job_prepare(BlockJob *job)
 {
-    if (job->ret == 0 && job->driver->prepare) {
-        job->ret = job->driver->prepare(job);
-    }
-    return job->ret;
-}
-
-static void block_job_commit(BlockJob *job)
-{
-    assert(!job->ret);
-    if (job->driver->commit) {
-        job->driver->commit(job);
-    }
-}
-
-static void block_job_abort(BlockJob *job)
-{
-    assert(job->ret);
-    if (job->driver->abort) {
-        job->driver->abort(job);
-    }
-}
-
-static void block_job_clean(BlockJob *job)
-{
-    if (job->driver->clean) {
-        job->driver->clean(job);
+    if (job->job.ret == 0 && job->driver->prepare) {
+        job->job.ret = job->driver->prepare(job);
     }
-}
-
-static int block_job_finalize_single(BlockJob *job)
-{
-    assert(job_is_completed(&job->job));
-
-    /* Ensure abort is called for late-transactional failures */
-    block_job_update_rc(job);
-
-    if (!job->ret) {
-        block_job_commit(job);
-    } else {
-        block_job_abort(job);
-    }
-    block_job_clean(job);
-
-    if (job->cb) {
-        job->cb(job->opaque, job->ret);
-    }
-
-    /* Emit events only if we actually started */
-    if (job_started(&job->job)) {
-        if (job_is_cancelled(&job->job)) {
-            job_event_cancelled(&job->job);
-        } else {
-            job_event_completed(&job->job);
-        }
-    }
-
-    block_job_txn_del_job(job);
-    block_job_conclude(job);
-    return 0;
+    return job->job.ret;
 }
 
 static void block_job_cancel_async(BlockJob *job, bool force)
@@ -425,8 +336,8 @@ static int block_job_finish_sync(BlockJob *job,
     while (!job_is_completed(&job->job)) {
         aio_poll(qemu_get_aio_context(), true);
     }
-    ret = (job_is_cancelled(&job->job) && job->ret == 0)
-          ? -ECANCELED : job->ret;
+    ret = (job_is_cancelled(&job->job) && job->job.ret == 0)
+          ? -ECANCELED : job->job.ret;
     job_unref(&job->job);
     return ret;
 }
@@ -467,7 +378,7 @@ static void block_job_completed_txn_abort(BlockJob *job)
             assert(job_is_cancelled(&other_job->job));
             block_job_finish_sync(other_job, NULL, NULL);
         }
-        block_job_finalize_single(other_job);
+        job_finalize_single(&other_job->job);
         aio_context_release(ctx);
     }
 
@@ -479,6 +390,11 @@ static int block_job_needs_finalize(BlockJob *job)
     return !job->job.auto_finalize;
 }
 
+static int block_job_finalize_single(BlockJob *job)
+{
+    return job_finalize_single(&job->job);
+}
+
 static void block_job_do_finalize(BlockJob *job)
 {
     int rc;
@@ -517,7 +433,7 @@ static void block_job_completed_txn_success(BlockJob *job)
         if (!job_is_completed(&other_job->job)) {
             return;
         }
-        assert(other_job->ret == 0);
+        assert(other_job->job.ret == 0);
     }
 
     block_job_txn_apply(txn, block_job_transition_to_pending, false);
@@ -602,14 +518,14 @@ void block_job_dismiss(BlockJob **jobptr, Error **errp)
         return;
     }
 
-    block_job_do_dismiss(job);
+    job_do_dismiss(&job->job);
     *jobptr = NULL;
 }
 
 void block_job_cancel(BlockJob *job, bool force)
 {
     if (job->job.status == JOB_STATUS_CONCLUDED) {
-        block_job_do_dismiss(job);
+        job_do_dismiss(&job->job);
         return;
     }
     block_job_cancel_async(job, force);
@@ -728,8 +644,8 @@ static void block_job_event_completed(Notifier *n, void *opaque)
         return;
     }
 
-    if (job->ret < 0) {
-        msg = strerror(-job->ret);
+    if (job->job.ret < 0) {
+        msg = strerror(-job->job.ret);
     }
 
     qapi_event_send_block_job_completed(job_type(&job->job),
@@ -786,7 +702,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     }
 
     job = job_create(job_id, &driver->job_driver, blk_get_aio_context(blk),
-                     flags, errp);
+                     flags, cb, opaque, errp);
     if (job == NULL) {
         blk_unref(blk);
         return NULL;
@@ -798,8 +714,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
 
     job->driver        = driver;
     job->blk           = blk;
-    job->cb            = cb;
-    job->opaque        = opaque;
 
     job->finalize_cancelled_notifier.notify = block_job_event_cancelled;
     job->finalize_completed_notifier.notify = block_job_event_completed;
@@ -828,7 +742,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
 
         block_job_set_speed(job, speed, &local_err);
         if (local_err) {
-            block_job_early_fail(job);
+            job_early_fail(&job->job);
             error_propagate(errp, local_err);
             return NULL;
         }
@@ -847,20 +761,14 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     return job;
 }
 
-void block_job_early_fail(BlockJob *job)
-{
-    assert(job->job.status == JOB_STATUS_CREATED);
-    block_job_decommission(job);
-}
-
 void block_job_completed(BlockJob *job, int ret)
 {
     assert(job && job->txn && !job_is_completed(&job->job));
     assert(blk_bs(job->blk)->job == job);
-    job->ret = ret;
-    block_job_update_rc(job);
-    trace_block_job_completed(job, ret, job->ret);
-    if (job->ret) {
+    job->job.ret = ret;
+    job_update_rc(&job->job);
+    trace_block_job_completed(job, ret, job->job.ret);
+    if (job->job.ret) {
         block_job_completed_txn_abort(job);
     } else {
         block_job_completed_txn_success(job);
diff --git a/job.c b/job.c
index ab9d6d8a22..0ad8f29982 100644
--- a/job.c
+++ b/job.c
@@ -31,6 +31,9 @@
 #include "qemu/main-loop.h"
 #include "trace-root.h"
 
+/* TODO Remove again once the direct calls back to blockjob_* are gone */
+#include "block/blockjob_int.h"
+
 static QLIST_HEAD(, Job) jobs = QLIST_HEAD_INITIALIZER(jobs);
 
 /* Job State Transition Table */
@@ -183,7 +186,7 @@ static void job_sleep_timer_cb(void *opaque)
 }
 
 void *job_create(const char *job_id, const JobDriver *driver, AioContext *ctx,
-                 int flags, Error **errp)
+                 int flags, BlockCompletionFunc *cb, void *opaque, Error **errp)
 {
     Job *job;
 
@@ -215,6 +218,8 @@ void *job_create(const char *job_id, const JobDriver *driver, AioContext *ctx,
     job->pause_count   = 1;
     job->auto_finalize = !(flags & JOB_MANUAL_FINALIZE);
     job->auto_dismiss  = !(flags & JOB_MANUAL_DISMISS);
+    job->cb            = cb;
+    job->opaque        = opaque;
 
     notifier_list_init(&job->on_finalize_cancelled);
     notifier_list_init(&job->on_finalize_completed);
@@ -446,6 +451,100 @@ void job_user_resume(Job *job, Error **errp)
     job_resume(job);
 }
 
+void job_do_dismiss(Job *job)
+{
+    assert(job);
+    job->busy = false;
+    job->paused = false;
+    job->deferred_to_main_loop = true;
+
+    /* TODO Don't assume it's a BlockJob */
+    block_job_txn_del_job((BlockJob*) job);
+
+    job_state_transition(job, JOB_STATUS_NULL);
+    job_unref(job);
+}
+
+void job_early_fail(Job *job)
+{
+    assert(job->status == JOB_STATUS_CREATED);
+    job_do_dismiss(job);
+}
+
+static void job_conclude(Job *job)
+{
+    job_state_transition(job, JOB_STATUS_CONCLUDED);
+    if (job->auto_dismiss || !job_started(job)) {
+        job_do_dismiss(job);
+    }
+}
+
+void job_update_rc(Job *job)
+{
+    if (!job->ret && job_is_cancelled(job)) {
+        job->ret = -ECANCELED;
+    }
+    if (job->ret) {
+        job_state_transition(job, JOB_STATUS_ABORTING);
+    }
+}
+
+static void job_commit(Job *job)
+{
+    assert(!job->ret);
+    if (job->driver->commit) {
+        job->driver->commit(job);
+    }
+}
+
+static void job_abort(Job *job)
+{
+    assert(job->ret);
+    if (job->driver->abort) {
+        job->driver->abort(job);
+    }
+}
+
+static void job_clean(Job *job)
+{
+    if (job->driver->clean) {
+        job->driver->clean(job);
+    }
+}
+
+int job_finalize_single(Job *job)
+{
+    assert(job_is_completed(job));
+
+    /* Ensure abort is called for late-transactional failures */
+    job_update_rc(job);
+
+    if (!job->ret) {
+        job_commit(job);
+    } else {
+        job_abort(job);
+    }
+    job_clean(job);
+
+    if (job->cb) {
+        job->cb(job->opaque, job->ret);
+    }
+
+    /* Emit events only if we actually started */
+    if (job_started(job)) {
+        if (job_is_cancelled(job)) {
+            job_event_cancelled(job);
+        } else {
+            job_event_completed(job);
+        }
+    }
+
+    /* TODO Don't assume it's a BlockJob */
+    block_job_txn_del_job((BlockJob*) job);
+    job_conclude(job);
+    return 0;
+}
+
 
 typedef struct {
     Job *job;
diff --git a/qemu-img.c b/qemu-img.c
index 3db8c557b4..4888064beb 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -872,7 +872,7 @@ static void run_block_job(BlockJob *job, Error **errp)
     if (!job_is_completed(&job->job)) {
         ret = block_job_complete_sync(job, errp);
     } else {
-        ret = job->ret;
+        ret = job->job.ret;
     }
     job_unref(&job->job);
     aio_context_release(aio_context);
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 8bb0aa8f85..1fe6803fe0 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -128,11 +128,11 @@ static void test_job_ids(void)
     job[1] = do_test_id(blk[1], "id0", false);
 
     /* But once job[0] finishes we can reuse its ID */
-    block_job_early_fail(job[0]);
+    job_early_fail(&job[0]->job);
     job[1] = do_test_id(blk[1], "id0", true);
 
     /* No job ID specified, defaults to the backend name ('drive1') */
-    block_job_early_fail(job[1]);
+    job_early_fail(&job[1]->job);
     job[1] = do_test_id(blk[1], NULL, true);
 
     /* Duplicate job ID */
@@ -145,9 +145,9 @@ static void test_job_ids(void)
     /* This one is valid */
     job[2] = do_test_id(blk[2], "id_2", true);
 
-    block_job_early_fail(job[0]);
-    block_job_early_fail(job[1]);
-    block_job_early_fail(job[2]);
+    job_early_fail(&job[0]->job);
+    job_early_fail(&job[1]->job);
+    job_early_fail(&job[2]->job);
 
     destroy_blk(blk[0]);
     destroy_blk(blk[1]);
-- 
2.13.6
