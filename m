Received: from eggs.gnu.org ([2001:4830:134:3::10]:53649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrM-0002QJ-6B
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrJ-0000CI-Ja
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:08 -0500
From: John Snow <jsnow@redhat.com>
Date: Sat, 10 Mar 2018 03:27:34 -0500
Message-Id: <20180310082746.24198-10-jsnow@redhat.com>
In-Reply-To: <20180310082746.24198-1-jsnow@redhat.com>
References: <20180310082746.24198-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 09/21] blockjobs: add CONCLUDED state
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

add a new state "CONCLUDED" that identifies a job that has ceased all
operations. The wording was chosen to avoid any phrasing that might
imply success, error, or cancellation. The task has simply ceased all
operation and can never again perform any work.

("finished", "done", and "completed" might all imply success.)

Transitions:
Running  -> Concluded: normal completion
Ready    -> Concluded: normal completion
Aborting -> Concluded: error and cancellations

Verbs:
None as of this commit. (a future commit adds 'dismiss')

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
   |         +--+-+--+     +------+
   |            | |
   |            | +------------------+
   |            |                    |
   |         +--v--+       +-------+ |
   +---------+READY<------->STANDBY| |
   |         +--+--+       +-------+ |
   |            |                    |
+--v-----+   +--v------+             |
|ABORTING+--->CONCLUDED<-------------+
+--------+   +---------+

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c           | 39 ++++++++++++++++++++++++---------------
 qapi/block-core.json |  7 +++++--
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index fe5b0041f7..3f730967b3 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -44,23 +44,24 @@ static QemuMutex block_job_mutex;
 
 /* BlockJob State Transition Table */
 bool BlockJobSTT[BLOCK_JOB_STATUS__MAX][BLOCK_JOB_STATUS__MAX] = {
-                                          /* U, C, R, P, Y, S, X */
-    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0},
-    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 1},
-    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0, 1},
-    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0, 0},
-    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1, 1},
-    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0, 0},
-    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 0},
+                                          /* U, C, R, P, Y, S, X, E */
+    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0, 0},
+    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 1, 0},
+    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0, 1, 1},
+    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0, 0, 0},
+    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1, 1, 1},
+    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0, 0, 0},
+    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 0, 1},
+    /* E: */ [BLOCK_JOB_STATUS_CONCLUDED] = {0, 0, 0, 0, 0, 0, 0, 0},
 };
 
 bool BlockJobVerbTable[BLOCK_JOB_VERB__MAX][BLOCK_JOB_STATUS__MAX] = {
-                                          /* U, C, R, P, Y, S, X */
-    [BLOCK_JOB_VERB_CANCEL]               = {0, 1, 1, 1, 1, 1, 0},
-    [BLOCK_JOB_VERB_PAUSE]                = {0, 1, 1, 1, 1, 1, 0},
-    [BLOCK_JOB_VERB_RESUME]               = {0, 1, 1, 1, 1, 1, 0},
-    [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 1, 0},
-    [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0, 0},
+                                          /* U, C, R, P, Y, S, X, E */
+    [BLOCK_JOB_VERB_CANCEL]               = {0, 1, 1, 1, 1, 1, 0, 0},
+    [BLOCK_JOB_VERB_PAUSE]                = {0, 1, 1, 1, 1, 1, 0, 0},
+    [BLOCK_JOB_VERB_RESUME]               = {0, 1, 1, 1, 1, 1, 0, 0},
+    [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 1, 0, 0},
+    [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0, 0, 0},
 };
 
 static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
@@ -377,6 +378,11 @@ void block_job_start(BlockJob *job)
     bdrv_coroutine_enter(blk_bs(job->blk), job->co);
 }
 
+static void block_job_conclude(BlockJob *job)
+{
+    block_job_state_transition(job, BLOCK_JOB_STATUS_CONCLUDED);
+}
+
 static void block_job_completed_single(BlockJob *job)
 {
     assert(job->completed);
@@ -417,6 +423,7 @@ static void block_job_completed_single(BlockJob *job)
 
     QLIST_REMOVE(job, txn_list);
     block_job_txn_unref(job->txn);
+    block_job_conclude(job);
     block_job_unref(job);
 }
 
@@ -617,7 +624,9 @@ void block_job_user_resume(BlockJob *job, Error **errp)
 
 void block_job_cancel(BlockJob *job)
 {
-    if (block_job_started(job)) {
+    if (job->status == BLOCK_JOB_STATUS_CONCLUDED) {
+        return;
+    } else if (block_job_started(job)) {
         block_job_cancel_async(job);
         block_job_enter(job);
     } else {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 01c16c42dc..e489660886 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -997,14 +997,17 @@
 #           The job may return to @ready or otherwise be canceled.
 #
 # @aborting: The job is in the process of being aborted, and will finish with
-#            an error.
+#            an error. The job will afterwards report that it is @concluded.
 #            This status may not be visible to the management process.
 #
+# @concluded: The job has finished all work. If manual was set to true, the job
+#             will remain in the query list until it is dismissed.
+#
 # Since: 2.12
 ##
 { 'enum': 'BlockJobStatus',
   'data': ['undefined', 'created', 'running', 'paused', 'ready', 'standby',
-           'aborting' ] }
+           'aborting', 'concluded' ] }
 
 ##
 # @BlockJobInfo:
-- 
2.14.3
