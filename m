Received: from eggs.gnu.org ([2001:4830:134:3::10]:54538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK4GX-00037p-MH
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:27:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK4GW-0007iA-9f
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:27:13 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 29 Nov 2017 16:26:27 +0100
Message-Id: <20171129152628.14906-10-kwolf@redhat.com>
In-Reply-To: <20171129152628.14906-1-kwolf@redhat.com>
References: <20171129152628.14906-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/10] blockjob: reimplement block_job_sleep_ns
 to allow cancellation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

This reverts the effects of commit 4afeffc857 ("blockjob: do not allow
coroutine double entry or entry-after-completion", 2017-11-21)

This fixed the symptom of a bug rather than the root cause. Canceling the
wait on a sleeping blockjob coroutine is generally fine, we just need to
make it work correctly across AioContexts.  To do so, use a QEMUTimer
that calls block_job_enter.  Use a mutex to ensure that block_job_enter
synchronizes correctly with block_job_sleep_ns.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-By: Jeff Cody <jcody@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob.h     |  8 +++++-
 include/block/blockjob_int.h |  4 +--
 blockjob.c                   | 63 ++++++++++++++++++++++++++++++++++++--------
 3 files changed, 61 insertions(+), 14 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 67c0968fa5..00403d9482 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -77,7 +77,7 @@ typedef struct BlockJob {
     /**
      * Set to false by the job while the coroutine has yielded and may be
      * re-entered by block_job_enter().  There may still be I/O or event loop
-     * activity pending.
+     * activity pending.  Accessed under block_job_mutex (in blockjob.c).
      */
     bool busy;
 
@@ -135,6 +135,12 @@ typedef struct BlockJob {
      */
     int ret;
 
+    /**
+     * Timer that is used by @block_job_sleep_ns. Accessed under
+     * block_job_mutex (in blockjob.c).
+     */
+    QEMUTimer sleep_timer;
+
     /** Non-NULL if this job is part of a transaction */
     BlockJobTxn *txn;
     QLIST_ENTRY(BlockJob) txn_list;
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index f7ab183a39..c9b23b0cc9 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -142,8 +142,8 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
  * @ns: How many nanoseconds to stop for.
  *
  * Put the job to sleep (assuming that it wasn't canceled) for @ns
- * %QEMU_CLOCK_REALTIME nanoseconds.  Canceling the job will not interrupt
- * the wait, so the cancel will not process until the coroutine wakes up.
+ * %QEMU_CLOCK_REALTIME nanoseconds.  Canceling the job will immediately
+ * interrupt the wait.
  */
 void block_job_sleep_ns(BlockJob *job, int64_t ns);
 
diff --git a/blockjob.c b/blockjob.c
index 4d22b7d2fb..0ed50b953b 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -37,6 +37,26 @@
 #include "qemu/timer.h"
 #include "qapi-event.h"
 
+/* Right now, this mutex is only needed to synchronize accesses to job->busy
+ * and job->sleep_timer, such as concurrent calls to block_job_do_yield and
+ * block_job_enter. */
+static QemuMutex block_job_mutex;
+
+static void block_job_lock(void)
+{
+    qemu_mutex_lock(&block_job_mutex);
+}
+
+static void block_job_unlock(void)
+{
+    qemu_mutex_unlock(&block_job_mutex);
+}
+
+static void __attribute__((__constructor__)) block_job_init(void)
+{
+    qemu_mutex_init(&block_job_mutex);
+}
+
 static void block_job_event_cancelled(BlockJob *job);
 static void block_job_event_completed(BlockJob *job, const char *msg);
 
@@ -161,6 +181,7 @@ void block_job_unref(BlockJob *job)
         blk_unref(job->blk);
         error_free(job->blocker);
         g_free(job->id);
+        assert(!timer_pending(&job->sleep_timer));
         g_free(job);
     }
 }
@@ -287,6 +308,13 @@ static void coroutine_fn block_job_co_entry(void *opaque)
     job->driver->start(job);
 }
 
+static void block_job_sleep_timer_cb(void *opaque)
+{
+    BlockJob *job = opaque;
+
+    block_job_enter(job);
+}
+
 void block_job_start(BlockJob *job)
 {
     assert(job && !block_job_started(job) && job->paused &&
@@ -556,7 +584,7 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
     info->type      = g_strdup(BlockJobType_str(job->driver->job_type));
     info->device    = g_strdup(job->id);
     info->len       = job->len;
-    info->busy      = job->busy;
+    info->busy      = atomic_read(&job->busy);
     info->paused    = job->pause_count > 0;
     info->offset    = job->offset;
     info->speed     = job->speed;
@@ -664,6 +692,9 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job->paused        = true;
     job->pause_count   = 1;
     job->refcnt        = 1;
+    aio_timer_init(qemu_get_aio_context(), &job->sleep_timer,
+                   QEMU_CLOCK_REALTIME, SCALE_NS,
+                   block_job_sleep_timer_cb, job);
 
     error_setg(&job->blocker, "block device is in use by block job: %s",
                BlockJobType_str(driver->job_type));
@@ -729,9 +760,20 @@ static bool block_job_should_pause(BlockJob *job)
     return job->pause_count > 0;
 }
 
-static void block_job_do_yield(BlockJob *job)
+/* Yield, and schedule a timer to reenter the coroutine after @ns nanoseconds.
+ * Reentering the job coroutine with block_job_enter() before the timer has
+ * expired is allowed and cancels the timer.
+ *
+ * If @ns is (uint64_t) -1, no timer is scheduled and block_job_enter() must be
+ * called explicitly. */
+static void block_job_do_yield(BlockJob *job, uint64_t ns)
 {
+    block_job_lock();
+    if (ns != -1) {
+        timer_mod(&job->sleep_timer, ns);
+    }
     job->busy = false;
+    block_job_unlock();
     qemu_coroutine_yield();
 
     /* Set by block_job_enter before re-entering the coroutine.  */
@@ -755,7 +797,7 @@ void coroutine_fn block_job_pause_point(BlockJob *job)
 
     if (block_job_should_pause(job) && !block_job_is_cancelled(job)) {
         job->paused = true;
-        block_job_do_yield(job);
+        block_job_do_yield(job, -1);
         job->paused = false;
     }
 
@@ -785,11 +827,16 @@ void block_job_enter(BlockJob *job)
         return;
     }
 
+    block_job_lock();
     if (job->busy) {
+        block_job_unlock();
         return;
     }
 
+    assert(!job->deferred_to_main_loop);
+    timer_del(&job->sleep_timer);
     job->busy = true;
+    block_job_unlock();
     aio_co_wake(job->co);
 }
 
@@ -807,14 +854,8 @@ void block_job_sleep_ns(BlockJob *job, int64_t ns)
         return;
     }
 
-    /* We need to leave job->busy set here, because when we have
-     * put a coroutine to 'sleep', we have scheduled it to run in
-     * the future.  We cannot enter that same coroutine again before
-     * it wakes and runs, otherwise we risk double-entry or entry after
-     * completion. */
     if (!block_job_should_pause(job)) {
-        co_aio_sleep_ns(blk_get_aio_context(job->blk),
-                        QEMU_CLOCK_REALTIME, ns);
+        block_job_do_yield(job, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ns);
     }
 
     block_job_pause_point(job);
@@ -830,7 +871,7 @@ void block_job_yield(BlockJob *job)
     }
 
     if (!block_job_should_pause(job)) {
-        block_job_do_yield(job);
+        block_job_do_yield(job, -1);
     }
 
     block_job_pause_point(job);
-- 
2.13.6
