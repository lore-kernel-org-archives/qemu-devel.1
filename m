Received: from eggs.gnu.org ([2001:4830:134:3::10]:59273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmd7-0001Lt-IV
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmd3-0004XH-8Q
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:25 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:30 +0100
Message-Id: <20180313161803.1814-9-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 08/41] blockjobs: add ABORTING state
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

Add a new state ABORTING.

This makes transitions from normative states to error states explicit
in the STM, and serves as a disambiguation for which states may complete
normally when normal end-states (CONCLUDED) are added in future commits.

Notably, Paused/Standby jobs do not transition directly to aborting,
as they must wake up first and cooperate in their cancellation.

Transitions:
Created -> Aborting: can be cancelled (by the system)
Running -> Aborting: can be cancelled or encounter an error
Ready   -> Aborting: can be cancelled or encounter an error

Verbs:
None. The job must finish cleaning itself up and report its final status.

             +---------+
             |UNDEFINED|
             +--+------+
                |
             +--v----+
   +---------+CREATED|
   |         +--+----+
   |            |
   |         +--v----+     +------+
   +---------+RUNNING<----->PAUSED|
   |         +--+----+     +------+
   |            |
   |         +--v--+       +-------+
   +---------+READY<------->STANDBY|
   |         +-----+       +-------+
   |
+--v-----+
|ABORTING|
+--------+

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json |  7 ++++++-
 blockjob.c           | 31 ++++++++++++++++++-------------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 217a31385f..c33a9e91a7 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -996,10 +996,15 @@
 # @standby: The job is ready, but paused. This is nearly identical to @paused.
 #           The job may return to @ready or otherwise be canceled.
 #
+# @aborting: The job is in the process of being aborted, and will finish with
+#            an error.
+#            This status may not be visible to the management process.
+#
 # Since: 2.12
 ##
 { 'enum': 'BlockJobStatus',
-  'data': ['undefined', 'created', 'running', 'paused', 'ready', 'standby'] }
+  'data': ['undefined', 'created', 'running', 'paused', 'ready', 'standby',
+           'aborting' ] }
 
 ##
 # @BlockJobInfo:
diff --git a/blockjob.c b/blockjob.c
index d369c0cb4d..fe5b0041f7 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -44,22 +44,23 @@ static QemuMutex block_job_mutex;
 
 /* BlockJob State Transition Table */
 bool BlockJobSTT[BLOCK_JOB_STATUS__MAX][BLOCK_JOB_STATUS__MAX] = {
-                                          /* U, C, R, P, Y, S */
-    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0},
-    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0},
-    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0},
-    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0},
-    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1},
-    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0},
+                                          /* U, C, R, P, Y, S, X */
+    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0},
+    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 1},
+    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0, 1},
+    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0, 0},
+    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1, 1},
+    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0, 0},
+    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 0},
 };
 
 bool BlockJobVerbTable[BLOCK_JOB_VERB__MAX][BLOCK_JOB_STATUS__MAX] = {
-                                          /* U, C, R, P, Y, S */
-    [BLOCK_JOB_VERB_CANCEL]               = {0, 1, 1, 1, 1, 1},
-    [BLOCK_JOB_VERB_PAUSE]                = {0, 1, 1, 1, 1, 1},
-    [BLOCK_JOB_VERB_RESUME]               = {0, 1, 1, 1, 1, 1},
-    [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 1},
-    [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0},
+                                          /* U, C, R, P, Y, S, X */
+    [BLOCK_JOB_VERB_CANCEL]               = {0, 1, 1, 1, 1, 1, 0},
+    [BLOCK_JOB_VERB_PAUSE]                = {0, 1, 1, 1, 1, 1, 0},
+    [BLOCK_JOB_VERB_RESUME]               = {0, 1, 1, 1, 1, 1, 0},
+    [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 1, 0},
+    [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0, 0},
 };
 
 static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
@@ -380,6 +381,10 @@ static void block_job_completed_single(BlockJob *job)
 {
     assert(job->completed);
 
+    if (job->ret || block_job_is_cancelled(job)) {
+        block_job_state_transition(job, BLOCK_JOB_STATUS_ABORTING);
+    }
+
     if (!job->ret) {
         if (job->driver->commit) {
             job->driver->commit(job);
-- 
2.13.6
