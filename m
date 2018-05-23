Received: from eggs.gnu.org ([2001:4830:134:3::10]:53244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZM-0002Cx-St
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZJ-0007DW-SR
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:44 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 23 May 2018 15:11:44 +0200
Message-Id: <20180523131155.12359-36-kwolf@redhat.com>
In-Reply-To: <20180523131155.12359-1-kwolf@redhat.com>
References: <20180523131155.12359-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 35/46] job: Add job_yield()
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

This moves block_job_yield() to the Job layer.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/blockjob_int.h |  8 --------
 include/qemu/job.h           |  9 +++++++--
 block/backup.c               |  2 +-
 block/mirror.c               |  2 +-
 blockjob.c                   | 16 ----------------
 job.c                        | 20 ++++++++++++++++++--
 tests/test-blockjob-txn.c    |  2 +-
 7 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 7df07b20cf..806ac64d87 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -108,14 +108,6 @@ void block_job_user_resume(Job *job);
 void block_job_drain(Job *job);
 
 /**
- * block_job_yield:
- * @job: The job that calls the function.
- *
- * Yield the block job coroutine.
- */
-void block_job_yield(BlockJob *job);
-
-/**
  * block_job_ratelimit_get_delay:
  *
  * Calculate and return delay for the next request in ns. See the documentation
diff --git a/include/qemu/job.h b/include/qemu/job.h
index bbe1b0cd1a..94900ec008 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -339,6 +339,13 @@ void coroutine_fn job_pause_point(Job *job);
 
 /**
  * @job: The job that calls the function.
+ *
+ * Yield the job coroutine.
+ */
+void job_yield(Job *job);
+
+/**
+ * @job: The job that calls the function.
  * @ns: How many nanoseconds to stop for.
  *
  * Put the job to sleep (assuming that it wasn't canceled) for @ns
@@ -508,8 +515,6 @@ int job_finish_sync(Job *job, void (*finish)(Job *, Error **errp), Error **errp)
 
 /* TODO To be removed from the public interface */
 void job_state_transition(Job *job, JobStatus s1);
-void coroutine_fn job_do_yield(Job *job, uint64_t ns);
-bool job_should_pause(Job *job);
 void job_do_dismiss(Job *job);
 
 #endif
diff --git a/block/backup.c b/block/backup.c
index b13f91d8a7..6f4f3df229 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -444,7 +444,7 @@ static void coroutine_fn backup_run(void *opaque)
         while (!job_is_cancelled(&job->common.job)) {
             /* Yield until the job is cancelled.  We just let our before_write
              * notify callback service CoW requests. */
-            block_job_yield(&job->common);
+            job_yield(&job->common.job);
         }
     } else if (job->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
         ret = backup_run_incremental(job);
diff --git a/block/mirror.c b/block/mirror.c
index c63cf7cbc9..687f955c22 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -731,7 +731,7 @@ static void coroutine_fn mirror_run(void *opaque)
         block_job_event_ready(&s->common);
         s->synced = true;
         while (!job_is_cancelled(&s->common.job) && !s->should_complete) {
-            block_job_yield(&s->common);
+            job_yield(&s->common.job);
         }
         s->common.job.cancelled = false;
         goto immediate_exit;
diff --git a/blockjob.c b/blockjob.c
index 438baa1778..f146fe0cbd 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -431,22 +431,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     return job;
 }
 
-void block_job_yield(BlockJob *job)
-{
-    assert(job->job.busy);
-
-    /* Check cancellation *before* setting busy = false, too!  */
-    if (job_is_cancelled(&job->job)) {
-        return;
-    }
-
-    if (!job_should_pause(&job->job)) {
-        job_do_yield(&job->job, -1);
-    }
-
-    job_pause_point(&job->job);
-}
-
 void block_job_iostatus_reset(BlockJob *job)
 {
     if (job->iostatus == BLOCK_DEVICE_IO_STATUS_OK) {
diff --git a/job.c b/job.c
index 2e453f60bc..eede6802ae 100644
--- a/job.c
+++ b/job.c
@@ -226,7 +226,7 @@ static bool job_started(Job *job)
     return job->co;
 }
 
-bool job_should_pause(Job *job)
+static bool job_should_pause(Job *job)
 {
     return job->pause_count > 0;
 }
@@ -396,7 +396,7 @@ void job_enter(Job *job)
  *
  * If @ns is (uint64_t) -1, no timer is scheduled and job_enter() must be
  * called explicitly. */
-void coroutine_fn job_do_yield(Job *job, uint64_t ns)
+static void coroutine_fn job_do_yield(Job *job, uint64_t ns)
 {
     job_lock();
     if (ns != -1) {
@@ -441,6 +441,22 @@ void coroutine_fn job_pause_point(Job *job)
     }
 }
 
+void job_yield(Job *job)
+{
+    assert(job->busy);
+
+    /* Check cancellation *before* setting busy = false, too!  */
+    if (job_is_cancelled(job)) {
+        return;
+    }
+
+    if (!job_should_pause(job)) {
+        job_do_yield(job, -1);
+    }
+
+    job_pause_point(job);
+}
+
 void coroutine_fn job_sleep_ns(Job *job, int64_t ns)
 {
     assert(job->busy);
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 34ee179574..fce836639a 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -47,7 +47,7 @@ static void coroutine_fn test_block_job_run(void *opaque)
         if (s->use_timer) {
             job_sleep_ns(&job->job, 0);
         } else {
-            block_job_yield(job);
+            job_yield(&job->job);
         }
 
         if (job_is_cancelled(&job->job)) {
-- 
2.13.6
