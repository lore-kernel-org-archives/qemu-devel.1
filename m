Received: from eggs.gnu.org ([2001:4830:134:3::10]:37170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFs1-0000jP-TP
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFs0-0008Li-Ma
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:29 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 26 Jan 2018 21:05:04 -0500
Message-Id: <20180127020515.27137-4-jsnow@redhat.com>
In-Reply-To: <20180127020515.27137-1-jsnow@redhat.com>
References: <20180127020515.27137-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v3 03/14] blockjobs: add state transition table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

The state transition table has mostly been implied. We're about to make
it a bit more complex, so let's make the STM explicit instead.

Perform state transitions with a function that for now just asserts the
transition is appropriate.

undefined: May only transition to 'created'.
created: May only transition to 'running'.
         It cannot transition to pause directly, but if a created job
         is requested to pause prior to starting, it will transition
         synchronously to 'running' and then to 'paused'.
running: May transition either to 'paused' or 'ready'.
paused: May transition to either 'running' or 'ready', but only in
        terms of returning to that prior state.
        p->r->y is not possible, but this is not encapsulated by the
        STM table.
ready: May transition to paused.
Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 6eb783a354..d084a1e318 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -42,6 +42,35 @@
  * block_job_enter. */
 static QemuMutex block_job_mutex;
 
+/* BlockJob State Transition Table */
+bool BlockJobSTT[BLOCK_JOB_STATUS__MAX][BLOCK_JOB_STATUS__MAX] = {
+                                          /* U, C, R, P, Y */
+    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0},
+    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0},
+    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1},
+    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 1},
+    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 1, 0},
+};
+
+static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
+{
+    BlockJobStatus s0 = job->status;
+    if (s0 == s1) {
+        return;
+    }
+    assert(s1 >= 0 && s1 <= BLOCK_JOB_STATUS__MAX);
+    assert(BlockJobSTT[s0][s1]);
+    switch (s1) {
+    case BLOCK_JOB_STATUS_WAITING:
+    case BLOCK_JOB_STATUS_PENDING:
+    case BLOCK_JOB_STATUS_CONCLUDED:
+        assert(job->manual);
+    default:
+        break;
+    }
+    job->status = s1;
+}
+
 static void block_job_lock(void)
 {
     qemu_mutex_lock(&block_job_mutex);
@@ -321,7 +350,7 @@ void block_job_start(BlockJob *job)
     job->pause_count--;
     job->busy = true;
     job->paused = false;
-    job->status = BLOCK_JOB_STATUS_RUNNING;
+    block_job_state_transition(job, BLOCK_JOB_STATUS_RUNNING);
     bdrv_coroutine_enter(blk_bs(job->blk), job->co);
 }
 
@@ -709,7 +738,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job->pause_count   = 1;
     job->refcnt        = 1;
     job->manual        = manual;
-    job->status        = BLOCK_JOB_STATUS_CREATED;
+    block_job_state_transition(job, BLOCK_JOB_STATUS_CREATED);
     aio_timer_init(qemu_get_aio_context(), &job->sleep_timer,
                    QEMU_CLOCK_REALTIME, SCALE_NS,
                    block_job_sleep_timer_cb, job);
@@ -815,11 +844,11 @@ void coroutine_fn block_job_pause_point(BlockJob *job)
 
     if (block_job_should_pause(job) && !block_job_is_cancelled(job)) {
         BlockJobStatus status = job->status;
-        job->status = BLOCK_JOB_STATUS_PAUSED;
+        block_job_state_transition(job, BLOCK_JOB_STATUS_PAUSED);
         job->paused = true;
         block_job_do_yield(job, -1);
         job->paused = false;
-        job->status = status;
+        block_job_state_transition(job, status);
     }
 
     if (job->driver->resume) {
@@ -925,7 +954,7 @@ void block_job_iostatus_reset(BlockJob *job)
 
 void block_job_event_ready(BlockJob *job)
 {
-    job->status = BLOCK_JOB_STATUS_READY;
+    block_job_state_transition(job, BLOCK_JOB_STATUS_READY);
     job->ready = true;
 
     if (block_job_is_internal(job)) {
-- 
2.14.3
