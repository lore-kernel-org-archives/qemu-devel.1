Received: from eggs.gnu.org ([2001:4830:134:3::10]:37415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFsA-00019t-DU
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFs9-0008U8-0z
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:38 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 26 Jan 2018 21:05:11 -0500
Message-Id: <20180127020515.27137-11-jsnow@redhat.com>
In-Reply-To: <20180127020515.27137-1-jsnow@redhat.com>
References: <20180127020515.27137-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v3 10/14] blockjobs: Add waiting event
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

Valid transitions:
Running -> Waiting (transactional, non-mirror jobs upon completion)
Ready -> Waiting (hypothetically: transactional mirror jobs upon
                  block-job-complete)
Waiting -> Concluded (transactional jobs of any kind upon convergence)

Valid verbs:
Cancel: A waiting job may still be canceled.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c           | 45 +++++++++++++++++++++++++++++++--------------
 qapi/block-core.json | 25 ++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index e52b4c4ce0..6a3a630517 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -44,13 +44,14 @@ static QemuMutex block_job_mutex;
 
 /* BlockJob State Transition Table */
 bool BlockJobSTT[BLOCK_JOB_STATUS__MAX][BLOCK_JOB_STATUS__MAX] = {
-                                          /* U, C, R, P, Y, E */
-    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0},
-    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0},
-    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 1},
-    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 1, 1},
-    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 1, 0, 1},
-    /* E: */ [BLOCK_JOB_STATUS_CONCLUDED] = {1, 0, 0, 0, 0, 0},
+                                          /* U, C, R, P, Y, W, E */
+    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0},
+    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 0},
+    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 1, 1},
+    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 1, 0, 1},
+    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 1, 0, 1, 1},
+    /* W: */ [BLOCK_JOB_STATUS_WAITING]   = {0, 0, 0, 0, 0, 0, 1},
+    /* E: */ [BLOCK_JOB_STATUS_CONCLUDED] = {1, 0, 0, 0, 0, 0, 0},
 };
 
 enum BlockJobVerb {
@@ -64,13 +65,13 @@ enum BlockJobVerb {
 };
 
 bool BlockJobVerb[BLOCK_JOB_VERB__MAX][BLOCK_JOB_STATUS__MAX] = {
-                                          /* U, C, R, P, Y, E */
-    [BLOCK_JOB_VERB_CANCEL]               = {0, 1, 1, 1, 1, 0},
-    [BLOCK_JOB_VERB_PAUSE]                = {0, 1, 1, 1, 1, 0},
-    [BLOCK_JOB_VERB_RESUME]               = {0, 0, 0, 1, 0, 0},
-    [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 0},
-    [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0},
-    [BLOCK_JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0, 1},
+                                          /* U, C, R, P, Y, W, E */
+    [BLOCK_JOB_VERB_CANCEL]               = {0, 1, 1, 1, 1, 1, 0},
+    [BLOCK_JOB_VERB_PAUSE]                = {0, 1, 1, 1, 1, 0, 0},
+    [BLOCK_JOB_VERB_RESUME]               = {0, 0, 0, 1, 0, 0, 0},
+    [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 0, 0},
+    [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0, 0},
+    [BLOCK_JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0, 0, 1},
 };
 
 static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
@@ -789,6 +790,21 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
                                         &error_abort);
 }
 
+static void block_job_event_waiting(BlockJob *job)
+{
+    if (!job->manual) {
+        return;
+    }
+    block_job_state_transition(job, BLOCK_JOB_STATUS_WAITING);
+    if (block_job_is_internal(job)) {
+        return;
+    }
+
+    qapi_event_send_block_job_waiting(job->driver->job_type,
+                                      job->id,
+                                      &error_abort);
+}
+
 static void block_job_event_concluded(BlockJob *job)
 {
     if (block_job_is_internal(job) || !job->manual) {
@@ -925,6 +941,7 @@ void block_job_completed(BlockJob *job, int ret)
     } else if (ret < 0 || block_job_is_cancelled(job)) {
         block_job_completed_txn_abort(job);
     } else {
+        block_job_event_waiting(job);
         block_job_completed_txn_success(job);
     }
 }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index f27c7054d2..f26fd1d8fd 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -966,7 +966,7 @@
 ##
 { 'enum': 'BlockJobStatus',
   'data': ['undefined', 'created', 'running', 'paused', 'ready',
-           'concluded' ] }
+           'waiting', 'concluded' ] }
 
 ##
 # @BlockJobInfo:
@@ -3867,6 +3867,29 @@
             'offset': 'int',
             'speed' : 'int' } }
 
+##
+# @BLOCK_JOB_WAITING:
+#
+# Emitted when a block job that is part of a transction has stopped work and is
+# waiting for other jobs in the transaction to reach the same state.
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
+#      "data": { "id": "drive0", "type": "mirror" },
+#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+##
+{ 'event': 'BLOCK_JOB_WAITING',
+  'data': { 'type'  : 'BlockJobType',
+            'id'    : 'str' } }
+
 ##
 # @PreallocMode:
 #
-- 
2.14.3
