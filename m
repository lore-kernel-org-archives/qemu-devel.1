Received: from eggs.gnu.org ([2001:4830:134:3::10]:59784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJfKg-00004r-2y
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJfKc-0006BU-VQ
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:22:06 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 18 May 2018 15:20:58 +0200
Message-Id: <20180518132114.4070-25-kwolf@redhat.com>
In-Reply-To: <20180518132114.4070-1-kwolf@redhat.com>
References: <20180518132114.4070-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 24/40] job: Move job_finish_sync() to Job
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

block_job_finish_sync() doesn't contain anything block job specific any
more, so it can be moved to Job.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/qemu/job.h |  9 +++++++++
 block/commit.c     |  6 +++---
 blockjob.c         | 55 +++++++++---------------------------------------------
 job.c              | 28 +++++++++++++++++++++++++++
 4 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/include/qemu/job.h b/include/qemu/job.h
index 8f7f71a9b1..17e2ceca87 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -389,6 +389,15 @@ typedef void JobDeferToMainLoopFn(Job *job, void *opaque);
  */
 void job_defer_to_main_loop(Job *job, JobDeferToMainLoopFn *fn, void *opaque);
 
+/**
+ * Synchronously finishes the given @job. If @finish is given, it is called to
+ * trigger completion or cancellation of the job.
+ *
+ * Returns 0 if the job is successfully completed, -ECANCELED if the job was
+ * cancelled before completing, and -errno in other error cases.
+ */
+int job_finish_sync(Job *job, void (*finish)(Job *, Error **errp), Error **errp);
+
 /* TODO To be removed from the public interface */
 void job_state_transition(Job *job, JobStatus s1);
 void coroutine_fn job_do_yield(Job *job, uint64_t ns);
diff --git a/block/commit.c b/block/commit.c
index 02a8af9127..40d97a35a5 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -112,9 +112,9 @@ static void commit_complete(Job *job, void *opaque)
     blk_unref(s->top);
 
     /* If there is more than one reference to the job (e.g. if called from
-     * block_job_finish_sync()), block_job_completed() won't free it and
-     * therefore the blockers on the intermediate nodes remain. This would
-     * cause bdrv_set_backing_hd() to fail. */
+     * job_finish_sync()), block_job_completed() won't free it and therefore
+     * the blockers on the intermediate nodes remain. This would cause
+     * bdrv_set_backing_hd() to fail. */
     block_job_remove_all_bdrv(bjob);
 
     block_job_completed(&s->common, ret);
diff --git a/blockjob.c b/blockjob.c
index 0ca7672941..1ed3e9c88d 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -307,40 +307,6 @@ static int block_job_txn_apply(BlockJobTxn *txn, int fn(BlockJob *), bool lock)
     return rc;
 }
 
-static int block_job_finish_sync(BlockJob *job,
-                                 void (*finish)(BlockJob *, Error **errp),
-                                 Error **errp)
-{
-    Error *local_err = NULL;
-    int ret;
-
-    assert(blk_bs(job->blk)->job == job);
-
-    job_ref(&job->job);
-
-    if (finish) {
-        finish(job, &local_err);
-    }
-    if (local_err) {
-        error_propagate(errp, local_err);
-        job_unref(&job->job);
-        return -EBUSY;
-    }
-    /* job_drain calls job_enter, and it should be enough to induce progress
-     * until the job completes or moves to the main thread.
-    */
-    while (!job->job.deferred_to_main_loop && !job_is_completed(&job->job)) {
-        job_drain(&job->job);
-    }
-    while (!job_is_completed(&job->job)) {
-        aio_poll(qemu_get_aio_context(), true);
-    }
-    ret = (job_is_cancelled(&job->job) && job->job.ret == 0)
-          ? -ECANCELED : job->job.ret;
-    job_unref(&job->job);
-    return ret;
-}
-
 static void block_job_completed_txn_abort(BlockJob *job)
 {
     AioContext *ctx;
@@ -375,7 +341,7 @@ static void block_job_completed_txn_abort(BlockJob *job)
         ctx = blk_get_aio_context(other_job->blk);
         if (!job_is_completed(&other_job->job)) {
             assert(job_is_cancelled(&other_job->job));
-            block_job_finish_sync(other_job, NULL, NULL);
+            job_finish_sync(&other_job->job, NULL, NULL);
         }
         job_finalize_single(&other_job->job);
         aio_context_release(ctx);
@@ -528,16 +494,18 @@ void block_job_user_cancel(BlockJob *job, bool force, Error **errp)
 }
 
 /* A wrapper around block_job_cancel() taking an Error ** parameter so it may be
- * used with block_job_finish_sync() without the need for (rather nasty)
- * function pointer casts there. */
-static void block_job_cancel_err(BlockJob *job, Error **errp)
+ * used with job_finish_sync() without the need for (rather nasty) function
+ * pointer casts there. */
+static void block_job_cancel_err(Job *job, Error **errp)
 {
-    block_job_cancel(job, false);
+    BlockJob *bjob = container_of(job, BlockJob, job);
+    assert(is_block_job(job));
+    block_job_cancel(bjob, false);
 }
 
 int block_job_cancel_sync(BlockJob *job)
 {
-    return block_job_finish_sync(job, &block_job_cancel_err, NULL);
+    return job_finish_sync(&job->job, &block_job_cancel_err, NULL);
 }
 
 void block_job_cancel_sync_all(void)
@@ -553,14 +521,9 @@ void block_job_cancel_sync_all(void)
     }
 }
 
-static void block_job_complete(BlockJob *job, Error **errp)
-{
-    job_complete(&job->job, errp);
-}
-
 int block_job_complete_sync(BlockJob *job, Error **errp)
 {
-    return block_job_finish_sync(job, &block_job_complete, errp);
+    return job_finish_sync(&job->job, job_complete, errp);
 }
 
 void block_job_progress_update(BlockJob *job, uint64_t done)
diff --git a/job.c b/job.c
index 8a455798e2..7c9a3a7b47 100644
--- a/job.c
+++ b/job.c
@@ -603,3 +603,31 @@ void job_defer_to_main_loop(Job *job, JobDeferToMainLoopFn *fn, void *opaque)
     aio_bh_schedule_oneshot(qemu_get_aio_context(),
                             job_defer_to_main_loop_bh, data);
 }
+
+int job_finish_sync(Job *job, void (*finish)(Job *, Error **errp), Error **errp)
+{
+    Error *local_err = NULL;
+    int ret;
+
+    job_ref(job);
+
+    if (finish) {
+        finish(job, &local_err);
+    }
+    if (local_err) {
+        error_propagate(errp, local_err);
+        job_unref(job);
+        return -EBUSY;
+    }
+    /* job_drain calls job_enter, and it should be enough to induce progress
+     * until the job completes or moves to the main thread. */
+    while (!job->deferred_to_main_loop && !job_is_completed(job)) {
+        job_drain(job);
+    }
+    while (!job_is_completed(job)) {
+        aio_poll(qemu_get_aio_context(), true);
+    }
+    ret = (job_is_cancelled(job) && job->ret == 0) ? -ECANCELED : job->ret;
+    job_unref(job);
+    return ret;
+}
-- 
2.13.6
