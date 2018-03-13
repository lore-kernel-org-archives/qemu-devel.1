Received: from eggs.gnu.org ([2001:4830:134:3::10]:59287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmd8-0001MN-3L
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmd3-0004XA-7T
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:26 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:27 +0100
Message-Id: <20180313161803.1814-6-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/41] blockjobs: add state transition table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: John Snow <jsnow@redhat.com>

The state transition table has mostly been implied. We're about to make
it a bit more complex, so let's make the STM explicit instead.

Perform state transitions with a function that for now just asserts the
transition is appropriate.

Transitions:
Undefined -> Created: During job initialization.
Created   -> Running: Once the job is started.
                      Jobs cannot transition from "Created" to "Paused"
                      directly, but will instead synchronously transition
                      to running to paused immediately.
Running   -> Paused:  Normal workflow for pauses.
Running   -> Ready:   Normal workflow for jobs reaching their sync point.
                      (e.g. mirror)
Ready     -> Standby: Normal workflow for pausing ready jobs.
Paused    -> Running: Normal resume.
Standby   -> Ready:   Resume of a Standby job.

+---------+
|UNDEFINED|
+--+------+
   |
+--v----+
|CREATED|
+--+----+
   |
+--v----+     +------+
|RUNNING<----->PAUSED|
+--+----+     +------+
   |
+--v--+       +-------+
|READY<------->STANDBY|
+-----+       +-------+

Notably, there is no state presently defined as of this commit that
deals with a job after the "running" or "ready" states, so this table
will be adjusted alongside the commits that introduce those states.

Signed-off-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockjob.c         | 40 +++++++++++++++++++++++++++++++++-------
 block/trace-events |  3 +++
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 719169cccd..442426e27b 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -28,6 +28,7 @@
 #include "block/block.h"
 #include "block/blockjob_int.h"
 #include "block/block_int.h"
+#include "block/trace.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-block-core.h"
@@ -41,6 +42,31 @@
  * block_job_enter. */
 static QemuMutex block_job_mutex;
 
+/* BlockJob State Transition Table */
+bool BlockJobSTT[BLOCK_JOB_STATUS__MAX][BLOCK_JOB_STATUS__MAX] = {
+                                          /* U, C, R, P, Y, S */
+    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0},
+    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0},
+    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0},
+    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0},
+    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1},
+    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0},
+};
+
+static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
+{
+    BlockJobStatus s0 = job->status;
+    assert(s1 >= 0 && s1 <= BLOCK_JOB_STATUS__MAX);
+    trace_block_job_state_transition(job, job->ret, BlockJobSTT[s0][s1] ?
+                                     "allowed" : "disallowed",
+                                     qapi_enum_lookup(&BlockJobStatus_lookup,
+                                                      s0),
+                                     qapi_enum_lookup(&BlockJobStatus_lookup,
+                                                      s1));
+    assert(BlockJobSTT[s0][s1]);
+    job->status = s1;
+}
+
 static void block_job_lock(void)
 {
     qemu_mutex_lock(&block_job_mutex);
@@ -320,7 +346,7 @@ void block_job_start(BlockJob *job)
     job->pause_count--;
     job->busy = true;
     job->paused = false;
-    job->status = BLOCK_JOB_STATUS_RUNNING;
+    block_job_state_transition(job, BLOCK_JOB_STATUS_RUNNING);
     bdrv_coroutine_enter(blk_bs(job->blk), job->co);
 }
 
@@ -702,7 +728,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job->paused        = true;
     job->pause_count   = 1;
     job->refcnt        = 1;
-    job->status        = BLOCK_JOB_STATUS_CREATED;
+    block_job_state_transition(job, BLOCK_JOB_STATUS_CREATED);
     aio_timer_init(qemu_get_aio_context(), &job->sleep_timer,
                    QEMU_CLOCK_REALTIME, SCALE_NS,
                    block_job_sleep_timer_cb, job);
@@ -817,13 +843,13 @@ void coroutine_fn block_job_pause_point(BlockJob *job)
 
     if (block_job_should_pause(job) && !block_job_is_cancelled(job)) {
         BlockJobStatus status = job->status;
-        job->status = status == BLOCK_JOB_STATUS_READY ? \
-                                BLOCK_JOB_STATUS_STANDBY : \
-                                BLOCK_JOB_STATUS_PAUSED;
+        block_job_state_transition(job, status == BLOCK_JOB_STATUS_READY ? \
+                                   BLOCK_JOB_STATUS_STANDBY :           \
+                                   BLOCK_JOB_STATUS_PAUSED);
         job->paused = true;
         block_job_do_yield(job, -1);
         job->paused = false;
-        job->status = status;
+        block_job_state_transition(job, status);
     }
 
     if (job->driver->resume) {
@@ -929,7 +955,7 @@ void block_job_iostatus_reset(BlockJob *job)
 
 void block_job_event_ready(BlockJob *job)
 {
-    job->status = BLOCK_JOB_STATUS_READY;
+    block_job_state_transition(job, BLOCK_JOB_STATUS_READY);
     job->ready = true;
 
     if (block_job_is_internal(job)) {
diff --git a/block/trace-events b/block/trace-events
index 02dd80ff0c..b75a0c8409 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -4,6 +4,9 @@
 bdrv_open_common(void *bs, const char *filename, int flags, const char *format_name) "bs %p filename \"%s\" flags 0x%x format_name \"%s\""
 bdrv_lock_medium(void *bs, bool locked) "bs %p locked %d"
 
+# blockjob.c
+block_job_state_transition(void *job,  int ret, const char *legal, const char *s0, const char *s1) "job %p (ret: %d) attempting %s transition (%s-->%s)"
+
 # block/block-backend.c
 blk_co_preadv(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags 0x%x"
 blk_co_pwritev(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags 0x%x"
-- 
2.13.6
