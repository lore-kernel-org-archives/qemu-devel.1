Received: from eggs.gnu.org ([2001:4830:134:3::10]:37410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFsA-00019i-8V
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFs8-0008To-Ri
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:38 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 26 Jan 2018 21:05:12 -0500
Message-Id: <20180127020515.27137-12-jsnow@redhat.com>
In-Reply-To: <20180127020515.27137-1-jsnow@redhat.com>
References: <20180127020515.27137-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v3 11/14] blockjobs: add PENDING status and event
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

Valid transitions:
Running -> Pending (non-transactional, non-mirror jobs)
Ready -> Pending (non-transactional mirror jobs)
Waiting -> Pending (transactional jobs)

Invalid transitions:
Waiting -> Concluded (no longer possible with this commit)

Valid verbs:
Cancel: A pending job may still be canceled.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c           | 45 ++++++++++++++++++++++++++++++---------------
 qapi/block-core.json | 26 +++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 6a3a630517..d31b65273c 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -44,14 +44,15 @@ static QemuMutex block_job_mutex;
 
 /* BlockJob State Transition Table */
 bool BlockJobSTT[BLOCK_JOB_STATUS__MAX][BLOCK_JOB_STATUS__MAX] = {
-                                          /* U, C, R, P, Y, W, E */
-    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0},
-    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 0},
-    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 1, 1},
-    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 1, 0, 1},
-    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 1, 0, 1, 1},
-    /* W: */ [BLOCK_JOB_STATUS_WAITING]   = {0, 0, 0, 0, 0, 0, 1},
-    /* E: */ [BLOCK_JOB_STATUS_CONCLUDED] = {1, 0, 0, 0, 0, 0, 0},
+                                          /* U, C, R, P, Y, W, D, E */
+    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0, 0},
+    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 0, 0},
+    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 1, 1, 1},
+    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 1, 0, 0, 1},
+    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 1, 0, 1, 1, 1},
+    /* W: */ [BLOCK_JOB_STATUS_WAITING]   = {0, 0, 0, 0, 0, 0, 1, 1},
+    /* D: */ [BLOCK_JOB_STATUS_PENDING]   = {0, 0, 0, 0, 0, 0, 0, 1},
+    /* E: */ [BLOCK_JOB_STATUS_CONCLUDED] = {1, 0, 0, 0, 0, 0, 0, 0},
 };
 
 enum BlockJobVerb {
@@ -65,13 +66,13 @@ enum BlockJobVerb {
 };
 
 bool BlockJobVerb[BLOCK_JOB_VERB__MAX][BLOCK_JOB_STATUS__MAX] = {
-                                          /* U, C, R, P, Y, W, E */
-    [BLOCK_JOB_VERB_CANCEL]               = {0, 1, 1, 1, 1, 1, 0},
-    [BLOCK_JOB_VERB_PAUSE]                = {0, 1, 1, 1, 1, 0, 0},
-    [BLOCK_JOB_VERB_RESUME]               = {0, 0, 0, 1, 0, 0, 0},
-    [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 0, 0},
-    [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0, 0},
-    [BLOCK_JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0, 0, 1},
+                                          /* U, C, R, P, Y, W, D, E */
+    [BLOCK_JOB_VERB_CANCEL]               = {0, 1, 1, 1, 1, 1, 1, 0},
+    [BLOCK_JOB_VERB_PAUSE]                = {0, 1, 1, 1, 1, 0, 0, 0},
+    [BLOCK_JOB_VERB_RESUME]               = {0, 0, 0, 1, 0, 0, 0, 0},
+    [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 0, 0, 0},
+    [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0, 0, 0},
+    [BLOCK_JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0, 0, 0, 1},
 };
 
 static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
@@ -111,6 +112,7 @@ static void __attribute__((__constructor__)) block_job_init(void)
 static void block_job_event_cancelled(BlockJob *job);
 static void block_job_event_completed(BlockJob *job, const char *msg);
 static void block_job_event_concluded(BlockJob *job);
+static void block_job_event_pending(BlockJob *job);
 static void block_job_enter_cond(BlockJob *job, bool(*fn)(BlockJob *job));
 
 /* Transactional group of block jobs */
@@ -805,6 +807,19 @@ static void block_job_event_waiting(BlockJob *job)
                                       &error_abort);
 }
 
+__attribute__((__unused__)) /* FIXME */
+static void block_job_event_pending(BlockJob *job)
+{
+    if (block_job_is_internal(job) || !job->manual) {
+        return;
+    }
+    block_job_state_transition(job, BLOCK_JOB_STATUS_PENDING);
+
+    qapi_event_send_block_job_pending(job->driver->job_type,
+                                      job->id,
+                                      &error_abort);
+}
+
 static void block_job_event_concluded(BlockJob *job)
 {
     if (block_job_is_internal(job) || !job->manual) {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index f26fd1d8fd..1f2eb39810 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -966,7 +966,7 @@
 ##
 { 'enum': 'BlockJobStatus',
   'data': ['undefined', 'created', 'running', 'paused', 'ready',
-           'waiting', 'concluded' ] }
+           'waiting', 'pending', 'concluded' ] }
 
 ##
 # @BlockJobInfo:
@@ -3890,6 +3890,30 @@
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
