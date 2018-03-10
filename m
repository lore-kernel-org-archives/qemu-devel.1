Received: from eggs.gnu.org ([2001:4830:134:3::10]:53697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrN-0002RI-IK
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrK-0000D1-80
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:09 -0500
From: John Snow <jsnow@redhat.com>
Date: Sat, 10 Mar 2018 03:27:35 -0500
Message-Id: <20180310082746.24198-11-jsnow@redhat.com>
In-Reply-To: <20180310082746.24198-1-jsnow@redhat.com>
References: <20180310082746.24198-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 10/21] blockjobs: add NULL state
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

Add a new state that specifically demarcates when we begin to permanently
demolish a job after it has performed all work. This makes the transition
explicit in the STM table and highlights conditions under which a job may
be demolished.

Alongside this state, add a new helper command "block_job_decommission",
which transitions to the NULL state and puts down our implicit reference.
This separates instances in the code for "block_job_unref" which merely
undo a matching "block_job_ref" with instances intended to initiate the
full destruction of the object.

This decommission action also sets a number of fields to make sure that
block internals or external users that are holding a reference to a job
to see when it "finishes" are convinced that the job object is "done."
This is necessary, for instance, to do a block_job_cancel_sync on a
created object which will not make any progress.

Now, all jobs must go through block_job_decommission prior to being
freed, giving us start-to-finish state machine coverage for jobs.


Transitions:
Created   -> Null: Early failure event before the job is started
Concluded -> Null: Standard transition.

Verbs:
None. This should not ever be visible to the monitor.

             +---------+
             |UNDEFINED|
             +--+------+
                |
             +--v----+
   +---------+CREATED+------------------+
   |         +--+----+                  |
   |            |                       |
   |         +--v----+     +------+     |
   +---------+RUNNING<----->PAUSED|     |
   |         +--+-+--+     +------+     |
   |            | |                     |
   |            | +------------------+  |
   |            |                    |  |
   |         +--v--+       +-------+ |  |
   +---------+READY<------->STANDBY| |  |
   |         +--+--+       +-------+ |  |
   |            |                    |  |
+--v-----+   +--v------+             |  |
|ABORTING+--->CONCLUDED<-------------+  |
+--------+   +--+------+                |
                |                       |
             +--v-+                     |
             |NULL<---------------------+
             +----+

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c           | 50 ++++++++++++++++++++++++++++++++------------------
 qapi/block-core.json |  5 ++++-
 2 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 3f730967b3..2ef48075b0 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -44,24 +44,25 @@ static QemuMutex block_job_mutex;
 
 /* BlockJob State Transition Table */
 bool BlockJobSTT[BLOCK_JOB_STATUS__MAX][BLOCK_JOB_STATUS__MAX] = {
-                                          /* U, C, R, P, Y, S, X, E */
-    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0, 0},
-    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 1, 0},
-    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0, 1, 1},
-    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0, 0, 0},
-    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1, 1, 1},
-    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0, 0, 0},
-    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 0, 1},
-    /* E: */ [BLOCK_JOB_STATUS_CONCLUDED] = {0, 0, 0, 0, 0, 0, 0, 0},
+                                          /* U, C, R, P, Y, S, X, E, N */
+    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0, 0, 0},
+    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 1, 0, 1},
+    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0, 1, 1, 0},
+    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0, 0, 0, 0},
+    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1, 1, 1, 0},
+    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0, 0, 0, 0},
+    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 0, 1, 0},
+    /* E: */ [BLOCK_JOB_STATUS_CONCLUDED] = {0, 0, 0, 0, 0, 0, 0, 0, 1},
+    /* N: */ [BLOCK_JOB_STATUS_NULL]      = {0, 0, 0, 0, 0, 0, 0, 0, 0},
 };
 
 bool BlockJobVerbTable[BLOCK_JOB_VERB__MAX][BLOCK_JOB_STATUS__MAX] = {
-                                          /* U, C, R, P, Y, S, X, E */
-    [BLOCK_JOB_VERB_CANCEL]               = {0, 1, 1, 1, 1, 1, 0, 0},
-    [BLOCK_JOB_VERB_PAUSE]                = {0, 1, 1, 1, 1, 1, 0, 0},
-    [BLOCK_JOB_VERB_RESUME]               = {0, 1, 1, 1, 1, 1, 0, 0},
-    [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 1, 0, 0},
-    [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0, 0, 0},
+                                          /* U, C, R, P, Y, S, X, E, N */
+    [BLOCK_JOB_VERB_CANCEL]               = {0, 1, 1, 1, 1, 1, 0, 0, 0},
+    [BLOCK_JOB_VERB_PAUSE]                = {0, 1, 1, 1, 1, 1, 0, 0, 0},
+    [BLOCK_JOB_VERB_RESUME]               = {0, 1, 1, 1, 1, 1, 0, 0, 0},
+    [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 1, 0, 0, 0},
+    [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0, 0, 0, 0},
 };
 
 static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
@@ -225,6 +226,7 @@ static void block_job_detach_aio_context(void *opaque);
 void block_job_unref(BlockJob *job)
 {
     if (--job->refcnt == 0) {
+        assert(job->status == BLOCK_JOB_STATUS_NULL);
         BlockDriverState *bs = blk_bs(job->blk);
         QLIST_REMOVE(job, job_list);
         bs->job = NULL;
@@ -378,6 +380,17 @@ void block_job_start(BlockJob *job)
     bdrv_coroutine_enter(blk_bs(job->blk), job->co);
 }
 
+static void block_job_decommission(BlockJob *job)
+{
+    assert(job);
+    job->completed = true;
+    job->busy = false;
+    job->paused = false;
+    job->deferred_to_main_loop = true;
+    block_job_state_transition(job, BLOCK_JOB_STATUS_NULL);
+    block_job_unref(job);
+}
+
 static void block_job_conclude(BlockJob *job)
 {
     block_job_state_transition(job, BLOCK_JOB_STATUS_CONCLUDED);
@@ -424,7 +437,7 @@ static void block_job_completed_single(BlockJob *job)
     QLIST_REMOVE(job, txn_list);
     block_job_txn_unref(job->txn);
     block_job_conclude(job);
-    block_job_unref(job);
+    block_job_decommission(job);
 }
 
 static void block_job_cancel_async(BlockJob *job)
@@ -817,7 +830,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
 
         block_job_set_speed(job, speed, &local_err);
         if (local_err) {
-            block_job_unref(job);
+            block_job_early_fail(job);
             error_propagate(errp, local_err);
             return NULL;
         }
@@ -851,7 +864,8 @@ void block_job_pause_all(void)
 
 void block_job_early_fail(BlockJob *job)
 {
-    block_job_unref(job);
+    assert(job->status == BLOCK_JOB_STATUS_CREATED);
+    block_job_decommission(job);
 }
 
 void block_job_completed(BlockJob *job, int ret)
diff --git a/qapi/block-core.json b/qapi/block-core.json
index e489660886..dc25d1d306 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1003,11 +1003,14 @@
 # @concluded: The job has finished all work. If manual was set to true, the job
 #             will remain in the query list until it is dismissed.
 #
+# @null: The job is in the process of being dismantled. This state should not
+#        ever be visible externally.
+#
 # Since: 2.12
 ##
 { 'enum': 'BlockJobStatus',
   'data': ['undefined', 'created', 'running', 'paused', 'ready', 'standby',
-           'aborting', 'concluded' ] }
+           'aborting', 'concluded', 'null' ] }
 
 ##
 # @BlockJobInfo:
-- 
2.14.3
