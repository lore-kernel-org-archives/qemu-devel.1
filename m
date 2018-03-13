Received: from eggs.gnu.org ([2001:4830:134:3::10]:59507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdH-0001Up-4Q
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdF-0004fT-DV
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:35 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:39 +0100
Message-Id: <20180313161803.1814-18-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 17/41] blockjobs: add PENDING status and event
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

For jobs utilizing the new manual workflow, we intend to prohibit
them from modifying the block graph until the management layer provides
an explicit ACK via block-job-finalize to move the process forward.

To distinguish this runstate from "ready" or "waiting," we add a new
"pending" event and status.

For now, the transition from PENDING to CONCLUDED/ABORTING is automatic,
but a future commit will add the explicit block-job-finalize step.

Transitions:
Waiting -> Pending:   Normal transition.
Pending -> Concluded: Normal transition.
Pending -> Aborting:  Late transactional failures and cancellations.

Removed Transitions:
Waiting -> Concluded: Jobs must go to PENDING first.

Verbs:
Cancel: Can be applied to a pending job.

             +---------+
             |UNDEFINED|
             +--+------+
                |
             +--v----+
   +---------+CREATED+-----------------+
   |         +--+----+                 |
   |            |                      |
   |         +--+----+     +------+    |
   +---------+RUNNING<----->PAUSED|    |
   |         +--+-+--+     +------+    |
   |            | |                    |
   |            | +------------------+ |
   |            |                    | |
   |         +--v--+       +-------+ | |
   +---------+READY<------->STANDBY| | |
   |         +--+--+       +-------+ | |
   |            |                    | |
   |         +--v----+               | |
   +---------+WAITING<---------------+ |
   |         +--+----+                 |
   |            |                      |
   |         +--v----+                 |
   +---------+PENDING|                 |
   |         +--+----+                 |
   |            |                      |
+--v-----+   +--v------+               |
|ABORTING+--->CONCLUDED|               |
+--------+   +--+------+               |
                |                      |
             +--v-+                    |
             |NULL<--------------------+
             +----+

Signed-off-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json     | 31 +++++++++++++++++++++-
 include/block/blockjob.h |  5 ++++
 blockjob.c               | 67 +++++++++++++++++++++++++++++++-----------------
 3 files changed, 78 insertions(+), 25 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6631614d0b..0ae12272ff 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1002,6 +1002,11 @@
 #           to the waiting state. This status will likely not be visible for
 #           the last job in a transaction.
 #
+# @pending: The job has finished its work, but has finalization steps that it
+#           needs to make prior to completing. These changes may require
+#           manual intervention by the management process if manual was set
+#           to true. These changes may still fail.
+#
 # @aborting: The job is in the process of being aborted, and will finish with
 #            an error. The job will afterwards report that it is @concluded.
 #            This status may not be visible to the management process.
@@ -1016,7 +1021,7 @@
 ##
 { 'enum': 'BlockJobStatus',
   'data': ['undefined', 'created', 'running', 'paused', 'ready', 'standby',
-           'waiting', 'aborting', 'concluded', 'null' ] }
+           'waiting', 'pending', 'aborting', 'concluded', 'null' ] }
 
 ##
 # @BlockJobInfo:
@@ -4263,6 +4268,30 @@
             'speed' : 'int' } }
 
 ##
+# @BLOCK_JOB_PENDING:
+#
+# Emitted when a block job is awaiting explicit authorization to finalize graph
+# changes via @block-job-finalize. If this job is part of a transaction, it will
+# not emit this event until the transaction has converged first.
+#
+# @type: job type
+#
+# @id: The job identifier.
+#
+# Since: 2.12
+#
+# Example:
+#
+# <- { "event": "BLOCK_JOB_WAITING",
+#      "data": { "device": "drive0", "type": "mirror" },
+#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+##
+{ 'event': 'BLOCK_JOB_PENDING',
+  'data': { 'type'  : 'BlockJobType',
+            'id'    : 'str' } }
+
+##
 # @PreallocMode:
 #
 # Preallocation mode of QEMU image file
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index c535829b46..7c8d51effa 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -142,6 +142,9 @@ typedef struct BlockJob {
     /** Current state; See @BlockJobStatus for details. */
     BlockJobStatus status;
 
+    /** True if this job should automatically finalize itself */
+    bool auto_finalize;
+
     /** True if this job should automatically dismiss itself */
     bool auto_dismiss;
 
@@ -154,6 +157,8 @@ typedef enum BlockJobCreateFlags {
     BLOCK_JOB_DEFAULT = 0x00,
     /* BlockJob is not QMP-created and should not send QMP events */
     BLOCK_JOB_INTERNAL = 0x01,
+    /* BlockJob requires manual finalize step */
+    BLOCK_JOB_MANUAL_FINALIZE = 0x02,
     /* BlockJob requires manual dismiss step */
     BLOCK_JOB_MANUAL_DISMISS = 0x04,
 } BlockJobCreateFlags;
diff --git a/blockjob.c b/blockjob.c
index 996278ed9c..3880a89678 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -44,27 +44,28 @@ static QemuMutex block_job_mutex;
 
 /* BlockJob State Transition Table */
 bool BlockJobSTT[BLOCK_JOB_STATUS__MAX][BLOCK_JOB_STATUS__MAX] = {
-                                          /* U, C, R, P, Y, S, W, X, E, N */
-    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
-    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 0, 1, 0, 1},
-    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0, 1, 1, 0, 0},
-    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
-    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1, 1, 1, 0, 0},
-    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
-    /* W: */ [BLOCK_JOB_STATUS_WAITING]   = {0, 0, 0, 0, 0, 0, 0, 1, 1, 0},
-    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 0, 1, 1, 0},
-    /* E: */ [BLOCK_JOB_STATUS_CONCLUDED] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
-    /* N: */ [BLOCK_JOB_STATUS_NULL]      = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
+                                          /* U, C, R, P, Y, S, W, D, X, E, N */
+    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},
+    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1},
+    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0},
+    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
+    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0},
+    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
+    /* W: */ [BLOCK_JOB_STATUS_WAITING]   = {0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0},
+    /* D: */ [BLOCK_JOB_STATUS_PENDING]   = {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0},
+    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0},
+    /* E: */ [BLOCK_JOB_STATUS_CONCLUDED] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
+    /* N: */ [BLOCK_JOB_STATUS_NULL]      = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
 };
 
 bool BlockJobVerbTable[BLOCK_JOB_VERB__MAX][BLOCK_JOB_STATUS__MAX] = {
-                                          /* U, C, R, P, Y, S, W, X, E, N */
-    [BLOCK_JOB_VERB_CANCEL]               = {0, 1, 1, 1, 1, 1, 1, 0, 0, 0},
-    [BLOCK_JOB_VERB_PAUSE]                = {0, 1, 1, 1, 1, 1, 0, 0, 0, 0},
-    [BLOCK_JOB_VERB_RESUME]               = {0, 1, 1, 1, 1, 1, 0, 0, 0, 0},
-    [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 1, 0, 0, 0, 0},
-    [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
-    [BLOCK_JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
+                                          /* U, C, R, P, Y, S, W, D, X, E, N */
+    [BLOCK_JOB_VERB_CANCEL]               = {0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
+    [BLOCK_JOB_VERB_PAUSE]                = {0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0},
+    [BLOCK_JOB_VERB_RESUME]               = {0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0},
+    [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0},
+    [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
+    [BLOCK_JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
 };
 
 static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
@@ -115,6 +116,7 @@ static void __attribute__((__constructor__)) block_job_init(void)
 
 static void block_job_event_cancelled(BlockJob *job);
 static void block_job_event_completed(BlockJob *job, const char *msg);
+static int block_job_event_pending(BlockJob *job);
 static void block_job_enter_cond(BlockJob *job, bool(*fn)(BlockJob *job));
 
 /* Transactional group of block jobs */
@@ -497,17 +499,21 @@ static void block_job_cancel_async(BlockJob *job)
     job->cancelled = true;
 }
 
-static int block_job_txn_apply(BlockJobTxn *txn, int fn(BlockJob *))
+static int block_job_txn_apply(BlockJobTxn *txn, int fn(BlockJob *), bool lock)
 {
     AioContext *ctx;
     BlockJob *job, *next;
     int rc;
 
     QLIST_FOREACH_SAFE(job, &txn->jobs, txn_list, next) {
-        ctx = blk_get_aio_context(job->blk);
-        aio_context_acquire(ctx);
+        if (lock) {
+            ctx = blk_get_aio_context(job->blk);
+            aio_context_acquire(ctx);
+        }
         rc = fn(job);
-        aio_context_release(ctx);
+        if (lock) {
+            aio_context_release(ctx);
+        }
         if (rc) {
             break;
         }
@@ -611,14 +617,15 @@ static void block_job_completed_txn_success(BlockJob *job)
     }
 
     /* Jobs may require some prep-work to complete without failure */
-    rc = block_job_txn_apply(txn, block_job_prepare);
+    rc = block_job_txn_apply(txn, block_job_prepare, true);
     if (rc) {
         block_job_completed_txn_abort(job);
         return;
     }
 
     /* We are the last completed job, commit the transaction. */
-    block_job_txn_apply(txn, block_job_completed_single);
+    block_job_txn_apply(txn, block_job_event_pending, false);
+    block_job_txn_apply(txn, block_job_completed_single, true);
 }
 
 /* Assumes the block_job_mutex is held */
@@ -827,6 +834,17 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
                                         &error_abort);
 }
 
+static int block_job_event_pending(BlockJob *job)
+{
+    block_job_state_transition(job, BLOCK_JOB_STATUS_PENDING);
+    if (!job->auto_finalize && !block_job_is_internal(job)) {
+        qapi_event_send_block_job_pending(job->driver->job_type,
+                                          job->id,
+                                          &error_abort);
+    }
+    return 0;
+}
+
 /*
  * API for block job drivers and the block layer.  These functions are
  * declared in blockjob_int.h.
@@ -888,6 +906,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job->paused        = true;
     job->pause_count   = 1;
     job->refcnt        = 1;
+    job->auto_finalize = !(flags & BLOCK_JOB_MANUAL_FINALIZE);
     job->auto_dismiss  = !(flags & BLOCK_JOB_MANUAL_DISMISS);
     block_job_state_transition(job, BLOCK_JOB_STATUS_CREATED);
     aio_timer_init(qemu_get_aio_context(), &job->sleep_timer,
-- 
2.13.6
