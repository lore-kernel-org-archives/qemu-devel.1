Received: from eggs.gnu.org ([2001:4830:134:3::10]:59613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJfKW-0008L4-Bw
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJfKS-00061G-9J
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:21:56 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 18 May 2018 15:20:49 +0200
Message-Id: <20180518132114.4070-16-kwolf@redhat.com>
In-Reply-To: <20180518132114.4070-1-kwolf@redhat.com>
References: <20180518132114.4070-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 15/40] job: Move pause/resume functions to
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
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

While we already moved the state related to job pausing to Job, the
functions to do were still BlockJob only. This commit moves them over to
Job.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 include/block/blockjob.h     | 32 -----------------
 include/block/blockjob_int.h |  7 ++++
 include/qemu/job.h           | 37 ++++++++++++++++++++
 block/backup.c               |  1 +
 block/commit.c               |  1 +
 block/mirror.c               |  2 ++
 block/stream.c               |  1 +
 blockdev.c                   |  6 ++--
 blockjob.c                   | 81 +++++++++-----------------------------------
 job.c                        | 59 ++++++++++++++++++++++++++++++++
 tests/test-bdrv-drain.c      |  1 +
 tests/test-blockjob-txn.c    |  1 +
 tests/test-blockjob.c        |  6 ++--
 13 files changed, 133 insertions(+), 102 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index b60d919fbf..556a8f6375 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -57,12 +57,6 @@ typedef struct BlockJob {
     bool force;
 
     /**
-     * Set to true if the job is paused by user.  Can be unpaused with the
-     * block-job-resume QMP command.
-     */
-    bool user_paused;
-
-    /**
      * Set to true when the job is ready to be completed.
      */
     bool ready;
@@ -248,32 +242,6 @@ void block_job_progress_set_remaining(BlockJob *job, uint64_t remaining);
 BlockJobInfo *block_job_query(BlockJob *job, Error **errp);
 
 /**
- * block_job_user_pause:
- * @job: The job to be paused.
- *
- * Asynchronously pause the specified job.
- * Do not allow a resume until a matching call to block_job_user_resume.
- */
-void block_job_user_pause(BlockJob *job, Error **errp);
-
-/**
- * block_job_paused:
- * @job: The job to query.
- *
- * Returns true if the job is user-paused.
- */
-bool block_job_user_paused(BlockJob *job);
-
-/**
- * block_job_user_resume:
- * @job: The job to be resumed.
- *
- * Resume the specified job.
- * Must be paired with a preceding block_job_user_pause.
- */
-void block_job_user_resume(BlockJob *job, Error **errp);
-
-/**
  * block_job_user_cancel:
  * @job: The job to be cancelled.
  * @force: Quit a job without waiting for data to be in sync.
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 8937f5b163..7e705ae0e9 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -134,6 +134,13 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
 void block_job_free(Job *job);
 
 /**
+ * block_job_user_resume:
+ * Callback to be used for JobDriver.user_resume in all block jobs. Resets the
+ * iostatus when the user resumes @job.
+ */
+void block_job_user_resume(Job *job);
+
+/**
  * block_job_yield:
  * @job: The job that calls the function.
  *
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 509408f747..bc6398568f 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -83,6 +83,12 @@ typedef struct Job {
     bool paused;
 
     /**
+     * Set to true if the job is paused by user.  Can be unpaused with the
+     * block-job-resume QMP command.
+     */
+    bool user_paused;
+
+    /**
      * Set to true if the job should cancel itself.  The flag must
      * always be tested just before toggling the busy flag from false
      * to true.  After a job has been cancelled, it should only yield
@@ -124,6 +130,12 @@ struct JobDriver {
      */
     void coroutine_fn (*resume)(Job *job);
 
+    /**
+     * Called when the job is resumed by the user (i.e. user_paused becomes
+     * false). .user_resume is called before .resume.
+     */
+    void (*user_resume)(Job *job);
+
     /** Called when the job is freed */
     void (*free)(Job *job);
 };
@@ -203,6 +215,31 @@ const char *job_type_str(const Job *job);
 bool job_is_cancelled(Job *job);
 
 /**
+ * Request @job to pause at the next pause point. Must be paired with
+ * job_resume(). If the job is supposed to be resumed by user action, call
+ * job_user_pause() instead.
+ */
+void job_pause(Job *job);
+
+/** Resumes a @job paused with job_pause. */
+void job_resume(Job *job);
+
+/**
+ * Asynchronously pause the specified @job.
+ * Do not allow a resume until a matching call to job_user_resume.
+ */
+void job_user_pause(Job *job, Error **errp);
+
+/** Returns true if the job is user-paused. */
+bool job_user_paused(Job *job);
+
+/**
+ * Resume the specified @job.
+ * Must be paired with a preceding job_user_pause.
+ */
+void job_user_resume(Job *job, Error **errp);
+
+/**
  * Get the next element from the list of block jobs after @job, or the
  * first one if @job is %NULL.
  *
diff --git a/block/backup.c b/block/backup.c
index f3a4f7c898..4d011d5a5c 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -528,6 +528,7 @@ static const BlockJobDriver backup_job_driver = {
         .instance_size          = sizeof(BackupBlockJob),
         .job_type               = JOB_TYPE_BACKUP,
         .free                   = block_job_free,
+        .user_resume            = block_job_user_resume,
         .start                  = backup_run,
     },
     .commit                 = backup_commit,
diff --git a/block/commit.c b/block/commit.c
index 1c6cb6c298..c4a98e5804 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -220,6 +220,7 @@ static const BlockJobDriver commit_job_driver = {
         .instance_size = sizeof(CommitBlockJob),
         .job_type      = JOB_TYPE_COMMIT,
         .free          = block_job_free,
+        .user_resume   = block_job_user_resume,
         .start         = commit_run,
     },
 };
diff --git a/block/mirror.c b/block/mirror.c
index 5d8f75c677..9a7226f38c 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -991,6 +991,7 @@ static const BlockJobDriver mirror_job_driver = {
         .instance_size          = sizeof(MirrorBlockJob),
         .job_type               = JOB_TYPE_MIRROR,
         .free                   = block_job_free,
+        .user_resume            = block_job_user_resume,
         .start                  = mirror_run,
         .pause                  = mirror_pause,
     },
@@ -1004,6 +1005,7 @@ static const BlockJobDriver commit_active_job_driver = {
         .instance_size          = sizeof(MirrorBlockJob),
         .job_type               = JOB_TYPE_COMMIT,
         .free                   = block_job_free,
+        .user_resume            = block_job_user_resume,
         .start                  = mirror_run,
         .pause                  = mirror_pause,
     },
diff --git a/block/stream.c b/block/stream.c
index 1faab02086..e81b488a22 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -214,6 +214,7 @@ static const BlockJobDriver stream_job_driver = {
         .job_type      = JOB_TYPE_STREAM,
         .free          = block_job_free,
         .start         = stream_run,
+        .user_resume   = block_job_user_resume,
     },
 };
 
diff --git a/blockdev.c b/blockdev.c
index c551fdf39a..3533c0dd6a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3844,7 +3844,7 @@ void qmp_block_job_cancel(const char *device,
         force = false;
     }
 
-    if (block_job_user_paused(job) && !force) {
+    if (job_user_paused(&job->job) && !force) {
         error_setg(errp, "The block job for device '%s' is currently paused",
                    device);
         goto out;
@@ -3866,7 +3866,7 @@ void qmp_block_job_pause(const char *device, Error **errp)
     }
 
     trace_qmp_block_job_pause(job);
-    block_job_user_pause(job, errp);
+    job_user_pause(&job->job, errp);
     aio_context_release(aio_context);
 }
 
@@ -3880,7 +3880,7 @@ void qmp_block_job_resume(const char *device, Error **errp)
     }
 
     trace_qmp_block_job_resume(job);
-    block_job_user_resume(job, errp);
+    job_user_resume(&job->job, errp);
     aio_context_release(aio_context);
 }
 
diff --git a/blockjob.c b/blockjob.c
index 4dc360c794..6334a54f50 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -140,29 +140,6 @@ static void block_job_txn_del_job(BlockJob *job)
     }
 }
 
-/* Assumes the job_mutex is held */
-static bool job_timer_not_pending(Job *job)
-{
-    return !timer_pending(&job->sleep_timer);
-}
-
-static void block_job_pause(BlockJob *job)
-{
-    job->job.pause_count++;
-}
-
-static void block_job_resume(BlockJob *job)
-{
-    assert(job->job.pause_count > 0);
-    job->job.pause_count--;
-    if (job->job.pause_count) {
-        return;
-    }
-
-    /* kick only if no timer is pending */
-    job_enter_cond(&job->job, job_timer_not_pending);
-}
-
 static void block_job_attached_aio_context(AioContext *new_context,
                                            void *opaque);
 static void block_job_detach_aio_context(void *opaque);
@@ -193,7 +170,7 @@ static void block_job_attached_aio_context(AioContext *new_context,
         job->driver->attached_aio_context(job, new_context);
     }
 
-    block_job_resume(job);
+    job_resume(&job->job);
 }
 
 static void block_job_drain(BlockJob *job)
@@ -214,7 +191,7 @@ static void block_job_detach_aio_context(void *opaque)
     /* In case the job terminates during aio_poll()... */
     job_ref(&job->job);
 
-    block_job_pause(job);
+    job_pause(&job->job);
 
     while (!job->job.paused && !job->completed) {
         block_job_drain(job);
@@ -233,13 +210,13 @@ static char *child_job_get_parent_desc(BdrvChild *c)
 static void child_job_drained_begin(BdrvChild *c)
 {
     BlockJob *job = c->opaque;
-    block_job_pause(job);
+    job_pause(&job->job);
 }
 
 static void child_job_drained_end(BdrvChild *c)
 {
     BlockJob *job = c->opaque;
-    block_job_resume(job);
+    job_resume(&job->job);
 }
 
 static const BdrvChildRole child_job = {
@@ -396,9 +373,9 @@ static void block_job_cancel_async(BlockJob *job, bool force)
     if (job->iostatus != BLOCK_DEVICE_IO_STATUS_OK) {
         block_job_iostatus_reset(job);
     }
-    if (job->user_paused) {
+    if (job->job.user_paused) {
         /* Do not call block_job_enter here, the caller will handle it.  */
-        job->user_paused = false;
+        job->job.user_paused = false;
         job->job.pause_count--;
     }
     job->job.cancelled = true;
@@ -628,39 +605,6 @@ void block_job_dismiss(BlockJob **jobptr, Error **errp)
     *jobptr = NULL;
 }
 
-void block_job_user_pause(BlockJob *job, Error **errp)
-{
-    if (job_apply_verb(&job->job, JOB_VERB_PAUSE, errp)) {
-        return;
-    }
-    if (job->user_paused) {
-        error_setg(errp, "Job is already paused");
-        return;
-    }
-    job->user_paused = true;
-    block_job_pause(job);
-}
-
-bool block_job_user_paused(BlockJob *job)
-{
-    return job->user_paused;
-}
-
-void block_job_user_resume(BlockJob *job, Error **errp)
-{
-    assert(job);
-    if (!job->user_paused || job->job.pause_count <= 0) {
-        error_setg(errp, "Can't resume a job that was not paused");
-        return;
-    }
-    if (job_apply_verb(&job->job, JOB_VERB_RESUME, errp)) {
-        return;
-    }
-    block_job_iostatus_reset(job);
-    job->user_paused = false;
-    block_job_resume(job);
-}
-
 void block_job_cancel(BlockJob *job, bool force)
 {
     if (job->job.status == JOB_STATUS_CONCLUDED) {
@@ -851,6 +795,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
 
     assert(is_block_job(&job->job));
     assert(job->job.driver->free == &block_job_free);
+    assert(job->job.driver->user_resume == &block_job_user_resume);
 
     job->driver        = driver;
     job->blk           = blk;
@@ -941,10 +886,16 @@ void block_job_iostatus_reset(BlockJob *job)
     if (job->iostatus == BLOCK_DEVICE_IO_STATUS_OK) {
         return;
     }
-    assert(job->user_paused && job->job.pause_count > 0);
+    assert(job->job.user_paused && job->job.pause_count > 0);
     job->iostatus = BLOCK_DEVICE_IO_STATUS_OK;
 }
 
+void block_job_user_resume(Job *job)
+{
+    BlockJob *bjob = container_of(job, BlockJob, job);
+    block_job_iostatus_reset(bjob);
+}
+
 void block_job_event_ready(BlockJob *job)
 {
     job_state_transition(&job->job, JOB_STATUS_READY);
@@ -991,9 +942,9 @@ BlockErrorAction block_job_error_action(BlockJob *job, BlockdevOnError on_err,
                                         action, &error_abort);
     }
     if (action == BLOCK_ERROR_ACTION_STOP) {
-        block_job_pause(job);
+        job_pause(&job->job);
         /* make the pause user visible, which will be resumed from QMP. */
-        job->user_paused = true;
+        job->job.user_paused = true;
         block_job_iostatus_set_err(job, error);
     }
     return action;
diff --git a/job.c b/job.c
index bff69bdaa5..21e3219495 100644
--- a/job.c
+++ b/job.c
@@ -341,6 +341,65 @@ void job_start(Job *job)
     aio_co_enter(job->aio_context, job->co);
 }
 
+/* Assumes the block_job_mutex is held */
+static bool job_timer_not_pending(Job *job)
+{
+    return !timer_pending(&job->sleep_timer);
+}
+
+void job_pause(Job *job)
+{
+    job->pause_count++;
+}
+
+void job_resume(Job *job)
+{
+    assert(job->pause_count > 0);
+    job->pause_count--;
+    if (job->pause_count) {
+        return;
+    }
+
+    /* kick only if no timer is pending */
+    job_enter_cond(job, job_timer_not_pending);
+}
+
+void job_user_pause(Job *job, Error **errp)
+{
+    if (job_apply_verb(job, JOB_VERB_PAUSE, errp)) {
+        return;
+    }
+    if (job->user_paused) {
+        error_setg(errp, "Job is already paused");
+        return;
+    }
+    job->user_paused = true;
+    job_pause(job);
+}
+
+bool job_user_paused(Job *job)
+{
+    return job->user_paused;
+}
+
+void job_user_resume(Job *job, Error **errp)
+{
+    assert(job);
+    if (!job->user_paused || job->pause_count <= 0) {
+        error_setg(errp, "Can't resume a job that was not paused");
+        return;
+    }
+    if (job_apply_verb(job, JOB_VERB_RESUME, errp)) {
+        return;
+    }
+    if (job->driver->user_resume) {
+        job->driver->user_resume(job);
+    }
+    job->user_paused = false;
+    job_resume(job);
+}
+
+
 typedef struct {
     Job *job;
     JobDeferToMainLoopFn *fn;
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 50232f5eaf..c993512f66 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -524,6 +524,7 @@ BlockJobDriver test_job_driver = {
     .job_driver = {
         .instance_size  = sizeof(TestBlockJob),
         .free           = block_job_free,
+        .user_resume    = block_job_user_resume,
         .start          = test_job_start,
     },
     .complete       = test_job_complete,
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 0e6162bc71..93d1ff0859 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -78,6 +78,7 @@ static const BlockJobDriver test_block_job_driver = {
     .job_driver = {
         .instance_size = sizeof(TestBlockJob),
         .free          = block_job_free,
+        .user_resume   = block_job_user_resume,
         .start         = test_block_job_run,
     },
 };
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index b329bd5274..ceb59600ed 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -20,6 +20,7 @@ static const BlockJobDriver test_block_job_driver = {
     .job_driver = {
         .instance_size = sizeof(BlockJob),
         .free          = block_job_free,
+        .user_resume   = block_job_user_resume,
     },
 };
 
@@ -199,6 +200,7 @@ static const BlockJobDriver test_cancel_driver = {
     .job_driver = {
         .instance_size = sizeof(CancelJob),
         .free          = block_job_free,
+        .user_resume   = block_job_user_resume,
         .start         = cancel_job_start,
     },
     .complete      = cancel_job_complete,
@@ -270,7 +272,7 @@ static void test_cancel_paused(void)
     job_start(&job->job);
     assert(job->job.status == JOB_STATUS_RUNNING);
 
-    block_job_user_pause(job, &error_abort);
+    job_user_pause(&job->job, &error_abort);
     block_job_enter(job);
     assert(job->job.status == JOB_STATUS_PAUSED);
 
@@ -308,7 +310,7 @@ static void test_cancel_standby(void)
     block_job_enter(job);
     assert(job->job.status == JOB_STATUS_READY);
 
-    block_job_user_pause(job, &error_abort);
+    job_user_pause(&job->job, &error_abort);
     block_job_enter(job);
     assert(job->job.status == JOB_STATUS_STANDBY);
 
-- 
2.13.6
