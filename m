Received: from eggs.gnu.org ([2001:4830:134:3::10]:53762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrP-0002Tq-53
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrM-0000ED-2b
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:11 -0500
From: John Snow <jsnow@redhat.com>
Date: Sat, 10 Mar 2018 03:27:41 -0500
Message-Id: <20180310082746.24198-17-jsnow@redhat.com>
In-Reply-To: <20180310082746.24198-1-jsnow@redhat.com>
References: <20180310082746.24198-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 16/21] blockjobs: add waiting status
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

For jobs that are stuck waiting on others in a transaction, it would
be nice to know that they are no longer "running" in that sense, but
instead are waiting on other jobs in the transaction.

Jobs that are "waiting" in this sense cannot be meaningfully altered
any longer as they have left their running loop. The only meaningful
user verb for jobs in this state is "cancel," which will cancel the
whole transaction, too.

Transitions:
Running -> Waiting:   Normal transition.
Ready   -> Waiting:   Normal transition.
Waiting -> Aborting:  Transactional cancellation.
Waiting -> Concluded: Normal transition.

Removed Transitions:
Running -> Concluded: Jobs must go to WAITING first.
Ready   -> Concluded: Jobs must go to WAITING first.

Verbs:
Cancel: Can be applied to WAITING jobs.

             +---------+
             |UNDEFINED|
             +--+------+
                |
             +--v----+
   +---------+CREATED+-----------------+
   |         +--+----+                 |
   |            |                      |
   |         +--v----+     +------+    |
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
+--v-----+   +--v------+               |
|ABORTING+--->CONCLUDED|               |
+--------+   +--+------+               |
                |                      |
             +--v-+                    |
             |NULL<--------------------+
             +----+

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c           | 37 ++++++++++++++++++++-----------------
 qapi/block-core.json |  6 +++++-
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 1395d8eed1..996278ed9c 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -44,26 +44,27 @@ static QemuMutex block_job_mutex;
 
 /* BlockJob State Transition Table */
 bool BlockJobSTT[BLOCK_JOB_STATUS__MAX][BLOCK_JOB_STATUS__MAX] = {
-                                          /* U, C, R, P, Y, S, X, E, N */
-    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0, 0, 0},
-    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 1, 0, 1},
-    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0, 1, 1, 0},
-    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0, 0, 0, 0},
-    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1, 1, 1, 0},
-    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0, 0, 0, 0},
-    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 1, 1, 0},
-    /* E: */ [BLOCK_JOB_STATUS_CONCLUDED] = {0, 0, 0, 0, 0, 0, 0, 0, 1},
-    /* N: */ [BLOCK_JOB_STATUS_NULL]      = {0, 0, 0, 0, 0, 0, 0, 0, 0},
+                                          /* U, C, R, P, Y, S, W, X, E, N */
+    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
+    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 0, 1, 0, 1},
+    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0, 1, 1, 0, 0},
+    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
+    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1, 1, 1, 0, 0},
+    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
+    /* W: */ [BLOCK_JOB_STATUS_WAITING]   = {0, 0, 0, 0, 0, 0, 0, 1, 1, 0},
+    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 0, 1, 1, 0},
+    /* E: */ [BLOCK_JOB_STATUS_CONCLUDED] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
+    /* N: */ [BLOCK_JOB_STATUS_NULL]      = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
 };
 
 bool BlockJobVerbTable[BLOCK_JOB_VERB__MAX][BLOCK_JOB_STATUS__MAX] = {
-                                          /* U, C, R, P, Y, S, X, E, N */
-    [BLOCK_JOB_VERB_CANCEL]               = {0, 1, 1, 1, 1, 1, 0, 0, 0},
-    [BLOCK_JOB_VERB_PAUSE]                = {0, 1, 1, 1, 1, 1, 0, 0, 0},
-    [BLOCK_JOB_VERB_RESUME]               = {0, 1, 1, 1, 1, 1, 0, 0, 0},
-    [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 1, 0, 0, 0},
-    [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0, 0, 0, 0},
-    [BLOCK_JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0, 0, 0, 1, 0},
+                                          /* U, C, R, P, Y, S, W, X, E, N */
+    [BLOCK_JOB_VERB_CANCEL]               = {0, 1, 1, 1, 1, 1, 1, 0, 0, 0},
+    [BLOCK_JOB_VERB_PAUSE]                = {0, 1, 1, 1, 1, 1, 0, 0, 0, 0},
+    [BLOCK_JOB_VERB_RESUME]               = {0, 1, 1, 1, 1, 1, 0, 0, 0, 0},
+    [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 1, 0, 0, 0, 0},
+    [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
+    [BLOCK_JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
 };
 
 static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
@@ -596,6 +597,8 @@ static void block_job_completed_txn_success(BlockJob *job)
     BlockJob *other_job;
     int rc = 0;
 
+    block_job_state_transition(job, BLOCK_JOB_STATUS_WAITING);
+
     /*
      * Successful completion, see if there are other running jobs in this
      * txn.
diff --git a/qapi/block-core.json b/qapi/block-core.json
index e815d7d255..374272014f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -998,6 +998,10 @@
 # @standby: The job is ready, but paused. This is nearly identical to @paused.
 #           The job may return to @ready or otherwise be canceled.
 #
+# @waiting: The job is waiting for other jobs in the transaction to converge
+#           to the waiting state. This status will likely not be visible for
+#           the last job in a transaction.
+#
 # @aborting: The job is in the process of being aborted, and will finish with
 #            an error. The job will afterwards report that it is @concluded.
 #            This status may not be visible to the management process.
@@ -1012,7 +1016,7 @@
 ##
 { 'enum': 'BlockJobStatus',
   'data': ['undefined', 'created', 'running', 'paused', 'ready', 'standby',
-           'aborting', 'concluded', 'null' ] }
+           'waiting', 'aborting', 'concluded', 'null' ] }
 
 ##
 # @BlockJobInfo:
-- 
2.14.3
