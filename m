Received: from eggs.gnu.org ([2001:4830:134:3::10]:55480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8S-0005zg-9P
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8P-000664-JQ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:16 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 23 Feb 2018 18:51:38 -0500
Message-Id: <20180223235142.21501-18-jsnow@redhat.com>
In-Reply-To: <20180223235142.21501-1-jsnow@redhat.com>
References: <20180223235142.21501-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v4 17/21] blockjobs: add PENDING status and event
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

For jobs utilizing the new manual workflow, we intend to prohibit
them from modifying the block graph until the management layer provides
an explicit ACK via block-job-finalize to move the process forward.

To distinguish this runstate from "ready" or "waiting," we add a new
"pending" event.

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
             |CREATED+-----------------+
             +--+----+                 |
                |                      |
             +--+----+     +------+    |
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
   +---------+WAITING+---------------+ |
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
             |NULL+--------------------+
             +----+

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c           | 66 +++++++++++++++++++++++++++++++++-------------------
 qapi/block-core.json | 31 +++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 25 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 4aed86fc6b..23b4b99fd4 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -44,27 +44,28 @@ static QemuMutex block_job_mutex;
 
 /* BlockJob State Transition Table */
 bool BlockJobSTT[BLOCK_JOB_STATUS__MAX][BLOCK_JOB_STATUS__MAX] = {
-                                          /* U, C, R, P, Y, S, W, X, E, N */
-    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
-    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 0, 0, 0, 1},
-    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0, 1, 1, 0, 0},
-    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
-    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1, 1, 1, 0, 0},
-    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
-    /* W: */ [BLOCK_JOB_STATUS_WAITING]   = {0, 0, 0, 0, 0, 0, 0, 1, 1, 0},
-    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
-    /* E: */ [BLOCK_JOB_STATUS_CONCLUDED] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
-    /* N: */ [BLOCK_JOB_STATUS_NULL]      = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
+                                          /* U, C, R, P, Y, S, W, D, X, E, N */
+    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},
+    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1},
+    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0},
+    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
+    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0},
+    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
+    /* W: */ [BLOCK_JOB_STATUS_WAITING]   = {0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0},
+    /* D: */ [BLOCK_JOB_STATUS_PENDING]   = {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0},
+    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
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
@@ -119,6 +120,7 @@ static void __attribute__((__constructor__)) block_job_init(void)
 static void block_job_event_cancelled(BlockJob *job);
 static void block_job_event_completed(BlockJob *job, const char *msg);
 static void block_job_event_concluded(BlockJob *job);
+static int block_job_event_pending(BlockJob *job);
 static void block_job_enter_cond(BlockJob *job, bool(*fn)(BlockJob *job));
 
 /* Transactional group of block jobs */
@@ -481,17 +483,21 @@ static void block_job_cancel_async(BlockJob *job)
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
@@ -601,14 +607,15 @@ static void block_job_completed_txn_success(BlockJob *job)
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
@@ -817,6 +824,17 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
                                         &error_abort);
 }
 
+static int block_job_event_pending(BlockJob *job)
+{
+    block_job_state_transition(job, BLOCK_JOB_STATUS_PENDING);
+    if (job->manual && !block_job_is_internal(job)) {
+        qapi_event_send_block_job_pending(job->driver->job_type,
+                                          job->id,
+                                          &error_abort);
+    }
+    return 0;
+}
+
 static void block_job_event_concluded(BlockJob *job)
 {
     block_job_state_transition(job, BLOCK_JOB_STATUS_CONCLUDED);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 3005aac7e2..acf9e56876 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1002,6 +1002,11 @@
 #           to the waiting state. This status will likely not be visible for
 #           the last job in a transaction.
 #
+# @pending: The job has finished its work, but has finalization steps that it
+#           needs to make prior to completing. These changes may require
+#           manual intervention by the management process if manual was set
+#           to true.
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
@@ -3961,6 +3966,30 @@
   'data': { 'type'  : 'BlockJobType',
             'id'    : 'str' } }
 
+##
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
 ##
 # @PreallocMode:
 #
-- 
2.14.3
