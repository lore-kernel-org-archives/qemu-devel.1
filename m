Received: from eggs.gnu.org ([2001:4830:134:3::10]:59499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJfKQ-0008Hw-Rv
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJfKO-0005yB-UV
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:21:50 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 18 May 2018 15:20:48 +0200
Message-Id: <20180518132114.4070-15-kwolf@redhat.com>
In-Reply-To: <20180518132114.4070-1-kwolf@redhat.com>
References: <20180518132114.4070-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/40] job: Add job_sleep_ns()
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

There is nothing block layer specific about block_job_sleep_ns(), so
move the function to Job.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/blockjob_int.h | 11 -----------
 include/qemu/job.h           | 19 ++++++++++++++++++-
 block/backup.c               |  2 +-
 block/commit.c               |  2 +-
 block/mirror.c               |  4 ++--
 block/stream.c               |  2 +-
 blockjob.c                   | 27 ---------------------------
 job.c                        | 32 ++++++++++++++++++++++++++++++++
 tests/test-bdrv-drain.c      |  8 ++++----
 tests/test-blockjob-txn.c    |  2 +-
 tests/test-blockjob.c        |  2 +-
 11 files changed, 61 insertions(+), 50 deletions(-)

diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 0a614a89b8..8937f5b163 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -134,17 +134,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
 void block_job_free(Job *job);
 
 /**
- * block_job_sleep_ns:
- * @job: The job that calls the function.
- * @ns: How many nanoseconds to stop for.
- *
- * Put the job to sleep (assuming that it wasn't canceled) for @ns
- * %QEMU_CLOCK_REALTIME nanoseconds.  Canceling the job will immediately
- * interrupt the wait.
- */
-void block_job_sleep_ns(BlockJob *job, int64_t ns);
-
-/**
  * block_job_yield:
  * @job: The job that calls the function.
  *
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 9dcff12283..509408f747 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -58,7 +58,7 @@ typedef struct Job {
     Coroutine *co;
 
     /**
-     * Timer that is used by @block_job_sleep_ns. Accessed under job_mutex (in
+     * Timer that is used by @job_sleep_ns. Accessed under job_mutex (in
      * job.c).
      */
     QEMUTimer sleep_timer;
@@ -168,6 +168,13 @@ void job_enter_cond(Job *job, bool(*fn)(Job *job));
 void job_start(Job *job);
 
 /**
+ * @job: The job to enter.
+ *
+ * Continue the specified job by entering the coroutine.
+ */
+void job_enter(Job *job);
+
+/**
  * @job: The job that is ready to pause.
  *
  * Pause now if job_pause() has been called. Jobs that perform lots of I/O
@@ -175,6 +182,16 @@ void job_start(Job *job);
  */
 void coroutine_fn job_pause_point(Job *job);
 
+/**
+ * @job: The job that calls the function.
+ * @ns: How many nanoseconds to stop for.
+ *
+ * Put the job to sleep (assuming that it wasn't canceled) for @ns
+ * %QEMU_CLOCK_REALTIME nanoseconds.  Canceling the job will immediately
+ * interrupt the wait.
+ */
+void coroutine_fn job_sleep_ns(Job *job, int64_t ns);
+
 
 /** Returns the JobType of a given Job. */
 JobType job_type(const Job *job);
diff --git a/block/backup.c b/block/backup.c
index 7d9aad9749..f3a4f7c898 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -338,7 +338,7 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
      * return. Without a yield, the VM would not reboot. */
     delay_ns = block_job_ratelimit_get_delay(&job->common, job->bytes_read);
     job->bytes_read = 0;
-    block_job_sleep_ns(&job->common, delay_ns);
+    job_sleep_ns(&job->common.job, delay_ns);
 
     if (job_is_cancelled(&job->common.job)) {
         return true;
diff --git a/block/commit.c b/block/commit.c
index 2fbc31077a..1c6cb6c298 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -172,7 +172,7 @@ static void coroutine_fn commit_run(void *opaque)
         /* Note that even when no rate limit is applied we need to yield
          * with no pending I/O here so that bdrv_drain_all() returns.
          */
-        block_job_sleep_ns(&s->common, delay_ns);
+        job_sleep_ns(&s->common.job, delay_ns);
         if (job_is_cancelled(&s->common.job)) {
             break;
         }
diff --git a/block/mirror.c b/block/mirror.c
index 95fc8072b0..5d8f75c677 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -595,7 +595,7 @@ static void mirror_throttle(MirrorBlockJob *s)
 
     if (now - s->last_pause_ns > BLOCK_JOB_SLICE_TIME) {
         s->last_pause_ns = now;
-        block_job_sleep_ns(&s->common, 0);
+        job_sleep_ns(&s->common.job, 0);
     } else {
         job_pause_point(&s->common.job);
     }
@@ -869,7 +869,7 @@ static void coroutine_fn mirror_run(void *opaque)
                         cnt == 0 ? BLOCK_JOB_SLICE_TIME : 0);
         }
         trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
-        block_job_sleep_ns(&s->common, delay_ns);
+        job_sleep_ns(&s->common.job, delay_ns);
         if (job_is_cancelled(&s->common.job) &&
             (!s->synced || s->common.force))
         {
diff --git a/block/stream.c b/block/stream.c
index 6d8b7b6eee..1faab02086 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -140,7 +140,7 @@ static void coroutine_fn stream_run(void *opaque)
         /* Note that even when no rate limit is applied we need to yield
          * with no pending I/O here so that bdrv_drain_all() returns.
          */
-        block_job_sleep_ns(&s->common, delay_ns);
+        job_sleep_ns(&s->common.job, delay_ns);
         if (job_is_cancelled(&s->common.job)) {
             break;
         }
diff --git a/blockjob.c b/blockjob.c
index 313b1ff7ce..4dc360c794 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -181,7 +181,6 @@ void block_job_free(Job *job)
                                     block_job_detach_aio_context, bjob);
     blk_unref(bjob->blk);
     error_free(bjob->blocker);
-    assert(!timer_pending(&bjob->job.sleep_timer));
 }
 
 static void block_job_attached_aio_context(AioContext *new_context,
@@ -290,13 +289,6 @@ const BlockJobDriver *block_job_driver(BlockJob *job)
     return job->driver;
 }
 
-static void block_job_sleep_timer_cb(void *opaque)
-{
-    BlockJob *job = opaque;
-
-    block_job_enter(job);
-}
-
 static void block_job_decommission(BlockJob *job)
 {
     assert(job);
@@ -866,9 +858,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job->opaque        = opaque;
     job->auto_finalize = !(flags & BLOCK_JOB_MANUAL_FINALIZE);
     job->auto_dismiss  = !(flags & BLOCK_JOB_MANUAL_DISMISS);
-    aio_timer_init(qemu_get_aio_context(), &job->job.sleep_timer,
-                   QEMU_CLOCK_REALTIME, SCALE_NS,
-                   block_job_sleep_timer_cb, job);
 
     error_setg(&job->blocker, "block device is in use by block job: %s",
                job_type_str(&job->job));
@@ -931,22 +920,6 @@ void block_job_enter(BlockJob *job)
     job_enter_cond(&job->job, NULL);
 }
 
-void block_job_sleep_ns(BlockJob *job, int64_t ns)
-{
-    assert(job->job.busy);
-
-    /* Check cancellation *before* setting busy = false, too!  */
-    if (job_is_cancelled(&job->job)) {
-        return;
-    }
-
-    if (!job_should_pause(&job->job)) {
-        job_do_yield(&job->job, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ns);
-    }
-
-    job_pause_point(&job->job);
-}
-
 void block_job_yield(BlockJob *job)
 {
     assert(job->job.busy);
diff --git a/job.c b/job.c
index 08b9273adf..bff69bdaa5 100644
--- a/job.c
+++ b/job.c
@@ -152,6 +152,13 @@ Job *job_get(const char *id)
     return NULL;
 }
 
+static void job_sleep_timer_cb(void *opaque)
+{
+    Job *job = opaque;
+
+    job_enter(job);
+}
+
 void *job_create(const char *job_id, const JobDriver *driver, AioContext *ctx,
                  Error **errp)
 {
@@ -178,6 +185,9 @@ void *job_create(const char *job_id, const JobDriver *driver, AioContext *ctx,
     job->pause_count   = 1;
 
     job_state_transition(job, JOB_STATUS_CREATED);
+    aio_timer_init(qemu_get_aio_context(), &job->sleep_timer,
+                   QEMU_CLOCK_REALTIME, SCALE_NS,
+                   job_sleep_timer_cb, job);
 
     QLIST_INSERT_HEAD(&jobs, job, job_list);
 
@@ -193,6 +203,7 @@ void job_unref(Job *job)
 {
     if (--job->refcnt == 0) {
         assert(job->status == JOB_STATUS_NULL);
+        assert(!timer_pending(&job->sleep_timer));
 
         if (job->driver->free) {
             job->driver->free(job);
@@ -232,6 +243,11 @@ void job_enter_cond(Job *job, bool(*fn)(Job *job))
     aio_co_wake(job->co);
 }
 
+void job_enter(Job *job)
+{
+    job_enter_cond(job, NULL);
+}
+
 /* Yield, and schedule a timer to reenter the coroutine after @ns nanoseconds.
  * Reentering the job coroutine with block_job_enter() before the timer has
  * expired is allowed and cancels the timer.
@@ -283,6 +299,22 @@ void coroutine_fn job_pause_point(Job *job)
     }
 }
 
+void coroutine_fn job_sleep_ns(Job *job, int64_t ns)
+{
+    assert(job->busy);
+
+    /* Check cancellation *before* setting busy = false, too!  */
+    if (job_is_cancelled(job)) {
+        return;
+    }
+
+    if (!job_should_pause(job)) {
+        job_do_yield(job, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ns);
+    }
+
+    job_pause_point(job);
+}
+
 /**
  * All jobs must allow a pause point before entering their job proper. This
  * ensures that jobs can be paused prior to being started, then resumed later.
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index c9f2f9b183..50232f5eaf 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -508,7 +508,7 @@ static void coroutine_fn test_job_start(void *opaque)
 
     block_job_event_ready(&s->common);
     while (!s->should_complete) {
-        block_job_sleep_ns(&s->common, 100000);
+        job_sleep_ns(&s->common.job, 100000);
     }
 
     job_defer_to_main_loop(&s->common.job, test_job_completed, NULL);
@@ -553,7 +553,7 @@ static void test_blockjob_common(enum drain_type drain_type)
 
     g_assert_cmpint(job->job.pause_count, ==, 0);
     g_assert_false(job->job.paused);
-    g_assert_false(job->job.busy); /* We're in block_job_sleep_ns() */
+    g_assert_false(job->job.busy); /* We're in job_sleep_ns() */
 
     do_drain_begin(drain_type, src);
 
@@ -571,7 +571,7 @@ static void test_blockjob_common(enum drain_type drain_type)
 
     g_assert_cmpint(job->job.pause_count, ==, 0);
     g_assert_false(job->job.paused);
-    g_assert_false(job->job.busy); /* We're in block_job_sleep_ns() */
+    g_assert_false(job->job.busy); /* We're in job_sleep_ns() */
 
     do_drain_begin(drain_type, target);
 
@@ -589,7 +589,7 @@ static void test_blockjob_common(enum drain_type drain_type)
 
     g_assert_cmpint(job->job.pause_count, ==, 0);
     g_assert_false(job->job.paused);
-    g_assert_false(job->job.busy); /* We're in block_job_sleep_ns() */
+    g_assert_false(job->job.busy); /* We're in job_sleep_ns() */
 
     ret = block_job_complete_sync(job, &error_abort);
     g_assert_cmpint(ret, ==, 0);
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 323e154a00..0e6162bc71 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -45,7 +45,7 @@ static void coroutine_fn test_block_job_run(void *opaque)
 
     while (s->iterations--) {
         if (s->use_timer) {
-            block_job_sleep_ns(job, 0);
+            job_sleep_ns(&job->job, 0);
         } else {
             block_job_yield(job);
         }
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 1d18325feb..b329bd5274 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -188,7 +188,7 @@ static void coroutine_fn cancel_job_start(void *opaque)
             block_job_event_ready(&s->common);
         }
 
-        block_job_sleep_ns(&s->common, 100000);
+        job_sleep_ns(&s->common.job, 100000);
     }
 
  defer:
-- 
2.13.6
