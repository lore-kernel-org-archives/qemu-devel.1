Received: from eggs.gnu.org ([2001:4830:134:3::10]:53129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZI-00025c-5T
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZE-00079O-Km
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:40 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 23 May 2018 15:11:37 +0200
Message-Id: <20180523131155.12359-29-kwolf@redhat.com>
In-Reply-To: <20180523131155.12359-1-kwolf@redhat.com>
References: <20180523131155.12359-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 28/46] job: Add job_drain()
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

block_job_drain() contains a blk_drain() call which cannot be moved to
Job, so add a new JobDriver callback JobDriver.drain which has a common
implementation for all BlockJobs. In addition to this we keep the
existing BlockJobDriver.drain callback that is called by the common
drain implementation for all block jobs.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/blockjob_int.h | 12 ++++++++++++
 include/qemu/job.h           | 13 +++++++++++++
 block/backup.c               |  1 +
 block/commit.c               |  1 +
 block/mirror.c               |  2 ++
 block/stream.c               |  1 +
 blockjob.c                   | 20 ++++++++++----------
 job.c                        | 11 +++++++++++
 tests/test-bdrv-drain.c      |  1 +
 tests/test-blockjob-txn.c    |  1 +
 tests/test-blockjob.c        |  2 ++
 11 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index bf2b762808..38fe22d7e0 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -65,6 +65,10 @@ struct BlockJobDriver {
      * If the callback is not NULL, it will be invoked when the job has to be
      * synchronously cancelled or completed; it should drain BlockDriverStates
      * as required to ensure progress.
+     *
+     * Block jobs must use the default implementation for job_driver.drain,
+     * which will in turn call this callback after doing generic block job
+     * stuff.
      */
     void (*drain)(BlockJob *job);
 };
@@ -112,6 +116,14 @@ void block_job_free(Job *job);
 void block_job_user_resume(Job *job);
 
 /**
+ * block_job_drain:
+ * Callback to be used for JobDriver.drain in all block jobs. Drains the main
+ * block node associated with the block jobs and calls BlockJobDriver.drain for
+ * job-specific actions.
+ */
+void block_job_drain(Job *job);
+
+/**
  * block_job_yield:
  * @job: The job that calls the function.
  *
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 2648c74281..aebc1959e6 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -167,6 +167,13 @@ struct JobDriver {
      */
     void (*user_resume)(Job *job);
 
+    /*
+     * If the callback is not NULL, it will be invoked when the job has to be
+     * synchronously cancelled or completed; it should drain any activities
+     * as required to ensure progress.
+     */
+    void (*drain)(Job *job);
+
     /**
      * If the callback is not NULL, it will be invoked when all the jobs
      * belonging to the same transaction complete; or upon this job's
@@ -325,6 +332,12 @@ bool job_user_paused(Job *job);
  */
 void job_user_resume(Job *job, Error **errp);
 
+/*
+ * Drain any activities as required to ensure progress. This can be called in a
+ * loop to synchronously complete a job.
+ */
+void job_drain(Job *job);
+
 /**
  * Get the next element from the list of block jobs after @job, or the
  * first one if @job is %NULL.
diff --git a/block/backup.c b/block/backup.c
index bd31282924..ca7d990b21 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -529,6 +529,7 @@ static const BlockJobDriver backup_job_driver = {
         .job_type               = JOB_TYPE_BACKUP,
         .free                   = block_job_free,
         .user_resume            = block_job_user_resume,
+        .drain                  = block_job_drain,
         .start                  = backup_run,
         .commit                 = backup_commit,
         .abort                  = backup_abort,
diff --git a/block/commit.c b/block/commit.c
index e53b2d7d55..02a8af9127 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -221,6 +221,7 @@ static const BlockJobDriver commit_job_driver = {
         .job_type      = JOB_TYPE_COMMIT,
         .free          = block_job_free,
         .user_resume   = block_job_user_resume,
+        .drain         = block_job_drain,
         .start         = commit_run,
     },
 };
diff --git a/block/mirror.c b/block/mirror.c
index c3951d1ca2..a579bd8cd1 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -992,6 +992,7 @@ static const BlockJobDriver mirror_job_driver = {
         .job_type               = JOB_TYPE_MIRROR,
         .free                   = block_job_free,
         .user_resume            = block_job_user_resume,
+        .drain                  = block_job_drain,
         .start                  = mirror_run,
         .pause                  = mirror_pause,
     },
@@ -1006,6 +1007,7 @@ static const BlockJobDriver commit_active_job_driver = {
         .job_type               = JOB_TYPE_COMMIT,
         .free                   = block_job_free,
         .user_resume            = block_job_user_resume,
+        .drain                  = block_job_drain,
         .start                  = mirror_run,
         .pause                  = mirror_pause,
     },
diff --git a/block/stream.c b/block/stream.c
index eee02538ed..b996278ab3 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -215,6 +215,7 @@ static const BlockJobDriver stream_job_driver = {
         .free          = block_job_free,
         .start         = stream_run,
         .user_resume   = block_job_user_resume,
+        .drain         = block_job_drain,
     },
 };
 
diff --git a/blockjob.c b/blockjob.c
index 4cac3670ad..63e166927a 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -169,14 +169,13 @@ static void block_job_attached_aio_context(AioContext *new_context,
     job_resume(&job->job);
 }
 
-static void block_job_drain(BlockJob *job)
+void block_job_drain(Job *job)
 {
-    /* If job is !job->job.busy this kicks it into the next pause point. */
-    block_job_enter(job);
+    BlockJob *bjob = container_of(job, BlockJob, job);
 
-    blk_drain(job->blk);
-    if (job->driver->drain) {
-        job->driver->drain(job);
+    blk_drain(bjob->blk);
+    if (bjob->driver->drain) {
+        bjob->driver->drain(bjob);
     }
 }
 
@@ -190,7 +189,7 @@ static void block_job_detach_aio_context(void *opaque)
     job_pause(&job->job);
 
     while (!job->job.paused && !job_is_completed(&job->job)) {
-        block_job_drain(job);
+        job_drain(&job->job);
     }
 
     job->job.aio_context = NULL;
@@ -327,11 +326,11 @@ static int block_job_finish_sync(BlockJob *job,
         job_unref(&job->job);
         return -EBUSY;
     }
-    /* block_job_drain calls block_job_enter, and it should be enough to
-     * induce progress until the job completes or moves to the main thread.
+    /* job_drain calls job_enter, and it should be enough to induce progress
+     * until the job completes or moves to the main thread.
     */
     while (!job->job.deferred_to_main_loop && !job_is_completed(&job->job)) {
-        block_job_drain(job);
+        job_drain(&job->job);
     }
     while (!job_is_completed(&job->job)) {
         aio_poll(qemu_get_aio_context(), true);
@@ -713,6 +712,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     assert(is_block_job(&job->job));
     assert(job->job.driver->free == &block_job_free);
     assert(job->job.driver->user_resume == &block_job_user_resume);
+    assert(job->job.driver->drain == &block_job_drain);
 
     job->driver        = driver;
     job->blk           = blk;
diff --git a/job.c b/job.c
index 64b64daf68..3772a35fcf 100644
--- a/job.c
+++ b/job.c
@@ -367,6 +367,17 @@ void coroutine_fn job_sleep_ns(Job *job, int64_t ns)
     job_pause_point(job);
 }
 
+void job_drain(Job *job)
+{
+    /* If job is !busy this kicks it into the next pause point. */
+    job_enter(job);
+
+    if (job->driver->drain) {
+        job->driver->drain(job);
+    }
+}
+
+
 /**
  * All jobs must allow a pause point before entering their job proper. This
  * ensures that jobs can be paused prior to being started, then resumed later.
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index c993512f66..58ea5663f0 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -525,6 +525,7 @@ BlockJobDriver test_job_driver = {
         .instance_size  = sizeof(TestBlockJob),
         .free           = block_job_free,
         .user_resume    = block_job_user_resume,
+        .drain          = block_job_drain,
         .start          = test_job_start,
     },
     .complete       = test_job_complete,
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 60e9fa2298..1572f8d96f 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -79,6 +79,7 @@ static const BlockJobDriver test_block_job_driver = {
         .instance_size = sizeof(TestBlockJob),
         .free          = block_job_free,
         .user_resume   = block_job_user_resume,
+        .drain         = block_job_drain,
         .start         = test_block_job_run,
     },
 };
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 1fe6803fe0..592a13613d 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -21,6 +21,7 @@ static const BlockJobDriver test_block_job_driver = {
         .instance_size = sizeof(BlockJob),
         .free          = block_job_free,
         .user_resume   = block_job_user_resume,
+        .drain         = block_job_drain,
     },
 };
 
@@ -201,6 +202,7 @@ static const BlockJobDriver test_cancel_driver = {
         .instance_size = sizeof(CancelJob),
         .free          = block_job_free,
         .user_resume   = block_job_user_resume,
+        .drain         = block_job_drain,
         .start         = cancel_job_start,
     },
     .complete      = cancel_job_complete,
-- 
2.13.6
