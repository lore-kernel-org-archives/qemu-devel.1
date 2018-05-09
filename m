Received: from eggs.gnu.org ([2001:4830:134:3::10]:52858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwj-00060C-0S
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwf-0002sm-UE
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:28:05 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  9 May 2018 18:26:27 +0200
Message-Id: <20180509162637.15575-33-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-1-kwolf@redhat.com>
References: <20180509162637.15575-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 32/42] job: Move completion and cancellation to
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
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This moves the top-level job completion and cancellation functions from
BlockJob to Job.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob.h     | 55 -------------------------------
 include/block/blockjob_int.h | 18 ----------
 include/qemu/job.h           | 58 ++++++++++++++++++++++++++++----
 block.c                      |  2 +-
 block/backup.c               |  3 +-
 block/commit.c               |  8 ++---
 block/mirror.c               |  6 ++--
 block/replication.c          |  4 +--
 block/stream.c               |  2 +-
 blockdev.c                   |  8 ++---
 blockjob.c                   | 76 ------------------------------------------
 job.c                        | 78 +++++++++++++++++++++++++++++++++++++++++---
 qemu-img.c                   |  2 +-
 tests/test-bdrv-drain.c      |  5 ++-
 tests/test-blockjob-txn.c    | 14 ++++----
 tests/test-blockjob.c        | 21 ++++++------
 block/trace-events           |  3 --
 trace-events                 |  1 +
 18 files changed, 162 insertions(+), 202 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index e8e9e5f370..7a0d95e789 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -141,15 +141,6 @@ void block_job_remove_all_bdrv(BlockJob *job);
 void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp);
 
 /**
- * block_job_cancel:
- * @job: The job to be canceled.
- * @force: Quit a job without waiting for data to be in sync.
- *
- * Asynchronously cancel the specified job.
- */
-void block_job_cancel(BlockJob *job, bool force);
-
-/**
  * block_job_dismiss:
  * @job: The job to be dismissed.
  * @errp: Error object.
@@ -186,52 +177,6 @@ void block_job_progress_set_remaining(BlockJob *job, uint64_t remaining);
 BlockJobInfo *block_job_query(BlockJob *job, Error **errp);
 
 /**
- * block_job_user_cancel:
- * @job: The job to be cancelled.
- * @force: Quit a job without waiting for data to be in sync.
- *
- * Cancels the specified job, but may refuse to do so if the
- * operation isn't currently meaningful.
- */
-void block_job_user_cancel(BlockJob *job, bool force, Error **errp);
-
-/**
- * block_job_cancel_sync:
- * @job: The job to be canceled.
- *
- * Synchronously cancel the job.  The completion callback is called
- * before the function returns.  The job may actually complete
- * instead of canceling itself; the circumstances under which this
- * happens depend on the kind of job that is active.
- *
- * Returns the return value from the job if the job actually completed
- * during the call, or -ECANCELED if it was canceled.
- */
-int block_job_cancel_sync(BlockJob *job);
-
-/**
- * block_job_cancel_sync_all:
- *
- * Synchronously cancels all jobs using block_job_cancel_sync().
- */
-void block_job_cancel_sync_all(void);
-
-/**
- * block_job_complete_sync:
- * @job: The job to be completed.
- * @errp: Error object which may be set by block_job_complete(); this is not
- *        necessarily set on every error, the job return value has to be
- *        checked as well.
- *
- * Synchronously complete the job.  The completion callback is called before the
- * function returns, unless it is NULL (which is permissible when using this
- * function).
- *
- * Returns the return value from the job.
- */
-int block_job_complete_sync(BlockJob *job, Error **errp);
-
-/**
  * block_job_iostatus_reset:
  * @job: The job whose I/O status should be reset.
  *
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 29a28020ac..7df07b20cf 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -124,24 +124,6 @@ void block_job_yield(BlockJob *job);
 int64_t block_job_ratelimit_get_delay(BlockJob *job, uint64_t n);
 
 /**
- * block_job_completed:
- * @job: The job being completed.
- * @ret: The status code.
- *
- * Call the completion function that was registered at creation time, and
- * free @job.
- */
-void block_job_completed(BlockJob *job, int ret);
-
-/**
- * block_job_enter:
- * @job: The job to enter.
- *
- * Continue the specified job by entering the coroutine.
- */
-void block_job_enter(BlockJob *job);
-
-/**
  * block_job_event_ready:
  * @job: The job which is now ready to be completed.
  *
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 84a9eb7980..a7e253a6fb 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -416,8 +416,59 @@ int job_apply_verb(Job *job, JobVerb bv, Error **errp);
 /** The @job could not be started, free it. */
 void job_early_fail(Job *job);
 
+/**
+ * @job: The job being completed.
+ * @ret: The status code.
+ *
+ * Marks @job as completed. If @ret is non-zero, the job transaction it is part
+ * of is aborted. If @ret is zero, the job moves into the WAITING state. If it
+ * is the last job to complete in its transaction, all jobs in the transaction
+ * move from WAITING to PENDING.
+ */
+void job_completed(Job *job, int ret);
+
 /** Asynchronously complete the specified @job. */
-void job_complete(Job *job, Error **errp);;
+void job_complete(Job *job, Error **errp);
+
+/**
+ * Asynchronously cancel the specified @job. If @force is true, the job should
+ * be cancelled immediately without waiting for a consistent state.
+ */
+void job_cancel(Job *job, bool force);
+
+/**
+ * Cancels the specified job like job_cancel(), but may refuse to do so if the
+ * operation isn't meaningful in the current state of the job.
+ */
+void job_user_cancel(Job *job, bool force, Error **errp);
+
+/**
+ * Synchronously cancel the @job.  The completion callback is called
+ * before the function returns.  The job may actually complete
+ * instead of canceling itself; the circumstances under which this
+ * happens depend on the kind of job that is active.
+ *
+ * Returns the return value from the job if the job actually completed
+ * during the call, or -ECANCELED if it was canceled.
+ */
+int job_cancel_sync(Job *job);
+
+/** Synchronously cancels all jobs using job_cancel_sync(). */
+void job_cancel_sync_all(void);
+
+/**
+ * @job: The job to be completed.
+ * @errp: Error object which may be set by job_complete(); this is not
+ *        necessarily set on every error, the job return value has to be
+ *        checked as well.
+ *
+ * Synchronously complete the job.  The completion callback is called before the
+ * function returns, unless it is NULL (which is permissible when using this
+ * function).
+ *
+ * Returns the return value from the job.
+ */
+int job_complete_sync(Job *job, Error **errp);
 
 /**
  * For a @job that has finished its work and is pending awaiting explicit
@@ -459,11 +510,6 @@ int job_finish_sync(Job *job, void (*finish)(Job *, Error **errp), Error **errp)
 void job_state_transition(Job *job, JobStatus s1);
 void coroutine_fn job_do_yield(Job *job, uint64_t ns);
 bool job_should_pause(Job *job);
-bool job_started(Job *job);
 void job_do_dismiss(Job *job);
-void job_update_rc(Job *job);
-void job_cancel_async(Job *job, bool force);
-void job_completed_txn_abort(Job *job);
-void job_completed_txn_success(Job *job);
 
 #endif
diff --git a/block.c b/block.c
index 676e57f562..7a149bfea9 100644
--- a/block.c
+++ b/block.c
@@ -3362,7 +3362,7 @@ static void bdrv_close(BlockDriverState *bs)
 
 void bdrv_close_all(void)
 {
-    block_job_cancel_sync_all();
+    job_cancel_sync_all();
     nbd_export_close_all();
 
     /* Drop references from requests still in flight, such as canceled block
diff --git a/block/backup.c b/block/backup.c
index 6172f90c90..b13f91d8a7 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -319,10 +319,9 @@ typedef struct {
 
 static void backup_complete(Job *job, void *opaque)
 {
-    BlockJob *bjob = container_of(job, BlockJob, job);
     BackupCompleteData *data = opaque;
 
-    block_job_completed(bjob, data->ret);
+    job_completed(job, data->ret);
     g_free(data);
 }
 
diff --git a/block/commit.c b/block/commit.c
index 02a8af9127..56c3810bad 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -112,12 +112,12 @@ static void commit_complete(Job *job, void *opaque)
     blk_unref(s->top);
 
     /* If there is more than one reference to the job (e.g. if called from
-     * block_job_finish_sync()), block_job_completed() won't free it and
-     * therefore the blockers on the intermediate nodes remain. This would
-     * cause bdrv_set_backing_hd() to fail. */
+     * block_job_finish_sync()), job_completed() won't free it and therefore
+     * the blockers on the intermediate nodes remain. This would cause
+     * bdrv_set_backing_hd() to fail. */
     block_job_remove_all_bdrv(bjob);
 
-    block_job_completed(&s->common, ret);
+    job_completed(job, ret);
     g_free(data);
 
     /* If bdrv_drop_intermediate() didn't already do that, remove the commit
diff --git a/block/mirror.c b/block/mirror.c
index f4e3576a17..2f33ee42fc 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -498,7 +498,7 @@ static void mirror_exit(Job *job, void *opaque)
     bdrv_release_dirty_bitmap(src, s->dirty_bitmap);
 
     /* Make sure that the source BDS doesn't go away before we called
-     * block_job_completed(). */
+     * job_completed(). */
     bdrv_ref(src);
     bdrv_ref(mirror_top_bs);
     bdrv_ref(target_bs);
@@ -581,7 +581,7 @@ static void mirror_exit(Job *job, void *opaque)
     blk_set_perm(bjob->blk, 0, BLK_PERM_ALL, &error_abort);
     blk_insert_bs(bjob->blk, mirror_top_bs, &error_abort);
 
-    block_job_completed(&s->common, data->ret);
+    job_completed(job, data->ret);
 
     g_free(data);
     bdrv_drained_end(src);
@@ -954,7 +954,7 @@ static void mirror_complete(Job *job, Error **errp)
     }
 
     s->should_complete = true;
-    block_job_enter(&s->common);
+    job_enter(job);
 }
 
 static void mirror_pause(Job *job)
diff --git a/block/replication.c b/block/replication.c
index ff2e2028af..826db7b304 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -145,7 +145,7 @@ static void replication_close(BlockDriverState *bs)
         replication_stop(s->rs, false, NULL);
     }
     if (s->stage == BLOCK_REPLICATION_FAILOVER) {
-        block_job_cancel_sync(s->active_disk->bs->job);
+        job_cancel_sync(&s->active_disk->bs->job->job);
     }
 
     if (s->mode == REPLICATION_MODE_SECONDARY) {
@@ -681,7 +681,7 @@ static void replication_stop(ReplicationState *rs, bool failover, Error **errp)
          * disk, secondary disk in backup_job_completed().
          */
         if (s->secondary_disk->bs->job) {
-            block_job_cancel_sync(s->secondary_disk->bs->job);
+            job_cancel_sync(&s->secondary_disk->bs->job->job);
         }
 
         if (!failover) {
diff --git a/block/stream.c b/block/stream.c
index b996278ab3..8546c412cd 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -93,7 +93,7 @@ out:
     }
 
     g_free(s->backing_file_str);
-    block_job_completed(&s->common, data->ret);
+    job_completed(job, data->ret);
     g_free(data);
 }
 
diff --git a/blockdev.c b/blockdev.c
index 87a23bed6f..31319a6d5a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -150,7 +150,7 @@ void blockdev_mark_auto_del(BlockBackend *blk)
         aio_context_acquire(aio_context);
 
         if (bs->job) {
-            block_job_cancel(bs->job, false);
+            job_cancel(&bs->job->job, false);
         }
 
         aio_context_release(aio_context);
@@ -1925,7 +1925,7 @@ static void drive_backup_abort(BlkActionState *common)
         aio_context = bdrv_get_aio_context(state->bs);
         aio_context_acquire(aio_context);
 
-        block_job_cancel_sync(state->job);
+        job_cancel_sync(&state->job->job);
 
         aio_context_release(aio_context);
     }
@@ -2023,7 +2023,7 @@ static void blockdev_backup_abort(BlkActionState *common)
         aio_context = bdrv_get_aio_context(state->bs);
         aio_context_acquire(aio_context);
 
-        block_job_cancel_sync(state->job);
+        job_cancel_sync(&state->job->job);
 
         aio_context_release(aio_context);
     }
@@ -3851,7 +3851,7 @@ void qmp_block_job_cancel(const char *device,
     }
 
     trace_qmp_block_job_cancel(job);
-    block_job_user_cancel(job, force, errp);
+    job_user_cancel(&job->job, force, errp);
 out:
     aio_context_release(aio_context);
 }
diff --git a/blockjob.c b/blockjob.c
index fd096e0f0c..c409788723 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -256,63 +256,6 @@ void block_job_dismiss(BlockJob **jobptr, Error **errp)
     *jobptr = NULL;
 }
 
-void block_job_cancel(BlockJob *job, bool force)
-{
-    if (job->job.status == JOB_STATUS_CONCLUDED) {
-        job_do_dismiss(&job->job);
-        return;
-    }
-    job_cancel_async(&job->job, force);
-    if (!job_started(&job->job)) {
-        block_job_completed(job, -ECANCELED);
-    } else if (job->job.deferred_to_main_loop) {
-        job_completed_txn_abort(&job->job);
-    } else {
-        block_job_enter(job);
-    }
-}
-
-void block_job_user_cancel(BlockJob *job, bool force, Error **errp)
-{
-    if (job_apply_verb(&job->job, JOB_VERB_CANCEL, errp)) {
-        return;
-    }
-    block_job_cancel(job, force);
-}
-
-/* A wrapper around block_job_cancel() taking an Error ** parameter so it may be
- * used with job_finish_sync() without the need for (rather nasty) function
- * pointer casts there. */
-static void block_job_cancel_err(Job *job, Error **errp)
-{
-    BlockJob *bjob = container_of(job, BlockJob, job);
-    assert(is_block_job(job));
-    block_job_cancel(bjob, false);
-}
-
-int block_job_cancel_sync(BlockJob *job)
-{
-    return job_finish_sync(&job->job, &block_job_cancel_err, NULL);
-}
-
-void block_job_cancel_sync_all(void)
-{
-    BlockJob *job;
-    AioContext *aio_context;
-
-    while ((job = block_job_next(NULL))) {
-        aio_context = blk_get_aio_context(job->blk);
-        aio_context_acquire(aio_context);
-        block_job_cancel_sync(job);
-        aio_context_release(aio_context);
-    }
-}
-
-int block_job_complete_sync(BlockJob *job, Error **errp)
-{
-    return job_finish_sync(&job->job, job_complete, errp);
-}
-
 void block_job_progress_update(BlockJob *job, uint64_t done)
 {
     job->offset += done;
@@ -490,25 +433,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     return job;
 }
 
-void block_job_completed(BlockJob *job, int ret)
-{
-    assert(job && job->job.txn && !job_is_completed(&job->job));
-    assert(blk_bs(job->blk)->job == job);
-    job->job.ret = ret;
-    job_update_rc(&job->job);
-    trace_block_job_completed(job, ret, job->job.ret);
-    if (job->job.ret) {
-        job_completed_txn_abort(&job->job);
-    } else {
-        job_completed_txn_success(&job->job);
-    }
-}
-
-void block_job_enter(BlockJob *job)
-{
-    job_enter_cond(&job->job, NULL);
-}
-
 void block_job_yield(BlockJob *job)
 {
     assert(job->job.busy);
diff --git a/job.c b/job.c
index 2d782859ac..892affba54 100644
--- a/job.c
+++ b/job.c
@@ -221,7 +221,7 @@ bool job_is_completed(Job *job)
     return false;
 }
 
-bool job_started(Job *job)
+static bool job_started(Job *job)
 {
     return job->co;
 }
@@ -572,7 +572,7 @@ static void job_conclude(Job *job)
     }
 }
 
-void job_update_rc(Job *job)
+static void job_update_rc(Job *job)
 {
     if (!job->ret && job_is_cancelled(job)) {
         job->ret = -ECANCELED;
@@ -637,7 +637,7 @@ static int job_finalize_single(Job *job)
     return 0;
 }
 
-void job_cancel_async(Job *job, bool force)
+static void job_cancel_async(Job *job, bool force)
 {
     if (job->user_paused) {
         /* Do not call job_enter here, the caller will handle it.  */
@@ -653,7 +653,7 @@ void job_cancel_async(Job *job, bool force)
     job->force_cancel |= force;
 }
 
-void job_completed_txn_abort(Job *job)
+static void job_completed_txn_abort(Job *job)
 {
     AioContext *ctx;
     JobTxn *txn = job->txn;
@@ -741,7 +741,7 @@ static int job_transition_to_pending(Job *job)
     return 0;
 }
 
-void job_completed_txn_success(Job *job)
+static void job_completed_txn_success(Job *job)
 {
     JobTxn *txn = job->txn;
     Job *other_job;
@@ -767,6 +767,74 @@ void job_completed_txn_success(Job *job)
     }
 }
 
+void job_completed(Job *job, int ret)
+{
+    assert(job && job->txn && !job_is_completed(job));
+    job->ret = ret;
+    job_update_rc(job);
+    trace_job_completed(job, ret, job->ret);
+    if (job->ret) {
+        job_completed_txn_abort(job);
+    } else {
+        job_completed_txn_success(job);
+    }
+}
+
+void job_cancel(Job *job, bool force)
+{
+    if (job->status == JOB_STATUS_CONCLUDED) {
+        job_do_dismiss(job);
+        return;
+    }
+    job_cancel_async(job, force);
+    if (!job_started(job)) {
+        job_completed(job, -ECANCELED);
+    } else if (job->deferred_to_main_loop) {
+        job_completed_txn_abort(job);
+    } else {
+        job_enter(job);
+    }
+}
+
+void job_user_cancel(Job *job, bool force, Error **errp)
+{
+    if (job_apply_verb(job, JOB_VERB_CANCEL, errp)) {
+        return;
+    }
+    job_cancel(job, force);
+}
+
+/* A wrapper around job_cancel() taking an Error ** parameter so it may be
+ * used with job_finish_sync() without the need for (rather nasty) function
+ * pointer casts there. */
+static void job_cancel_err(Job *job, Error **errp)
+{
+    job_cancel(job, false);
+}
+
+int job_cancel_sync(Job *job)
+{
+    return job_finish_sync(job, &job_cancel_err, NULL);
+}
+
+void job_cancel_sync_all(void)
+{
+    Job *job;
+    AioContext *aio_context;
+
+    while ((job = job_next(NULL))) {
+        aio_context = job->aio_context;
+        aio_context_acquire(aio_context);
+        job_cancel_sync(job);
+        aio_context_release(aio_context);
+    }
+}
+
+int job_complete_sync(Job *job, Error **errp)
+{
+    return job_finish_sync(job, job_complete, errp);
+}
+
 void job_complete(Job *job, Error **errp)
 {
     /* Should not be reachable via external interface for internal jobs */
diff --git a/qemu-img.c b/qemu-img.c
index ee214269aa..176eb630a1 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -870,7 +870,7 @@ static void run_block_job(BlockJob *job, Error **errp)
     } while (!job->ready && !job_is_completed(&job->job));
 
     if (!job_is_completed(&job->job)) {
-        ret = block_job_complete_sync(job, errp);
+        ret = job_complete_sync(&job->job, errp);
     } else {
         ret = job->job.ret;
     }
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index b428aaca68..3600ffd3fb 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -498,8 +498,7 @@ typedef struct TestBlockJob {
 
 static void test_job_completed(Job *job, void *opaque)
 {
-    BlockJob *bjob = container_of(job, BlockJob, job);
-    block_job_completed(bjob, 0);
+    job_completed(job, 0);
 }
 
 static void coroutine_fn test_job_start(void *opaque)
@@ -593,7 +592,7 @@ static void test_blockjob_common(enum drain_type drain_type)
     g_assert_false(job->job.paused);
     g_assert_false(job->job.busy); /* We're in job_sleep_ns() */
 
-    ret = block_job_complete_sync(job, &error_abort);
+    ret = job_complete_sync(&job->job, &error_abort);
     g_assert_cmpint(ret, ==, 0);
 
     blk_unref(blk_src);
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 6ee31d59ad..34ee179574 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -34,7 +34,7 @@ static void test_block_job_complete(Job *job, void *opaque)
         rc = -ECANCELED;
     }
 
-    block_job_completed(bjob, rc);
+    job_completed(job, rc);
     bdrv_unref(bs);
 }
 
@@ -130,7 +130,7 @@ static void test_single_job(int expected)
     job_start(&job->job);
 
     if (expected == -ECANCELED) {
-        block_job_cancel(job, false);
+        job_cancel(&job->job, false);
     }
 
     while (result == -EINPROGRESS) {
@@ -176,10 +176,10 @@ static void test_pair_jobs(int expected1, int expected2)
     job_txn_unref(txn);
 
     if (expected1 == -ECANCELED) {
-        block_job_cancel(job1, false);
+        job_cancel(&job1->job, false);
     }
     if (expected2 == -ECANCELED) {
-        block_job_cancel(job2, false);
+        job_cancel(&job2->job, false);
     }
 
     while (result1 == -EINPROGRESS || result2 == -EINPROGRESS) {
@@ -232,13 +232,13 @@ static void test_pair_jobs_fail_cancel_race(void)
     job_start(&job1->job);
     job_start(&job2->job);
 
-    block_job_cancel(job1, false);
+    job_cancel(&job1->job, false);
 
     /* Now make job2 finish before the main loop kicks jobs.  This simulates
      * the race between a pending kick and another job completing.
      */
-    block_job_enter(job2);
-    block_job_enter(job2);
+    job_enter(&job2->job);
+    job_enter(&job2->job);
 
     while (result1 == -EINPROGRESS || result2 == -EINPROGRESS) {
         aio_poll(qemu_get_aio_context(), true);
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 1e052c2e9c..46a78739aa 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -165,10 +165,9 @@ typedef struct CancelJob {
 
 static void cancel_job_completed(Job *job, void *opaque)
 {
-    BlockJob *bjob = container_of(job, BlockJob, job);
     CancelJob *s = opaque;
     s->completed = true;
-    block_job_completed(bjob, 0);
+    job_completed(job, 0);
 }
 
 static void cancel_job_complete(Job *job, Error **errp)
@@ -232,7 +231,7 @@ static void cancel_common(CancelJob *s)
     BlockBackend *blk = s->blk;
     JobStatus sts = job->job.status;
 
-    block_job_cancel_sync(job);
+    job_cancel_sync(&job->job);
     if (sts != JOB_STATUS_CREATED && sts != JOB_STATUS_CONCLUDED) {
         BlockJob *dummy = job;
         block_job_dismiss(&dummy, &error_abort);
@@ -275,7 +274,7 @@ static void test_cancel_paused(void)
     assert(job->job.status == JOB_STATUS_RUNNING);
 
     job_user_pause(&job->job, &error_abort);
-    block_job_enter(job);
+    job_enter(&job->job);
     assert(job->job.status == JOB_STATUS_PAUSED);
 
     cancel_common(s);
@@ -292,7 +291,7 @@ static void test_cancel_ready(void)
     assert(job->job.status == JOB_STATUS_RUNNING);
 
     s->should_converge = true;
-    block_job_enter(job);
+    job_enter(&job->job);
     assert(job->job.status == JOB_STATUS_READY);
 
     cancel_common(s);
@@ -309,11 +308,11 @@ static void test_cancel_standby(void)
     assert(job->job.status == JOB_STATUS_RUNNING);
 
     s->should_converge = true;
-    block_job_enter(job);
+    job_enter(&job->job);
     assert(job->job.status == JOB_STATUS_READY);
 
     job_user_pause(&job->job, &error_abort);
-    block_job_enter(job);
+    job_enter(&job->job);
     assert(job->job.status == JOB_STATUS_STANDBY);
 
     cancel_common(s);
@@ -330,11 +329,11 @@ static void test_cancel_pending(void)
     assert(job->job.status == JOB_STATUS_RUNNING);
 
     s->should_converge = true;
-    block_job_enter(job);
+    job_enter(&job->job);
     assert(job->job.status == JOB_STATUS_READY);
 
     job_complete(&job->job, &error_abort);
-    block_job_enter(job);
+    job_enter(&job->job);
     while (!s->completed) {
         aio_poll(qemu_get_aio_context(), true);
     }
@@ -354,11 +353,11 @@ static void test_cancel_concluded(void)
     assert(job->job.status == JOB_STATUS_RUNNING);
 
     s->should_converge = true;
-    block_job_enter(job);
+    job_enter(&job->job);
     assert(job->job.status == JOB_STATUS_READY);
 
     job_complete(&job->job, &error_abort);
-    block_job_enter(job);
+    job_enter(&job->job);
     while (!s->completed) {
         aio_poll(qemu_get_aio_context(), true);
     }
diff --git a/block/trace-events b/block/trace-events
index 93b927908a..2d59b53fd3 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -4,9 +4,6 @@
 bdrv_open_common(void *bs, const char *filename, int flags, const char *format_name) "bs %p filename \"%s\" flags 0x%x format_name \"%s\""
 bdrv_lock_medium(void *bs, bool locked) "bs %p locked %d"
 
-# blockjob.c
-block_job_completed(void *job, int ret, int jret) "job %p ret %d corrected ret %d"
-
 # block/block-backend.c
 blk_co_preadv(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags 0x%x"
 blk_co_pwritev(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags 0x%x"
diff --git a/trace-events b/trace-events
index 2507e1327d..ef7579a285 100644
--- a/trace-events
+++ b/trace-events
@@ -107,6 +107,7 @@ gdbstub_err_checksum_incorrect(uint8_t expected, uint8_t got) "got command packe
 # job.c
 job_state_transition(void *job,  int ret, const char *legal, const char *s0, const char *s1) "job %p (ret: %d) attempting %s transition (%s-->%s)"
 job_apply_verb(void *job, const char *state, const char *verb, const char *legal) "job %p in state %s; applying verb %s (%s)"
+job_completed(void *job, int ret, int jret) "job %p ret %d corrected ret %d"
 
 ### Guest events, keep at bottom
 
-- 
2.13.6
