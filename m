Received: from eggs.gnu.org ([2001:4830:134:3::10]:55313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8M-0005sR-Pj
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8I-0005tA-Tq
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:10 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 23 Feb 2018 18:51:30 -0500
Message-Id: <20180223235142.21501-10-jsnow@redhat.com>
In-Reply-To: <20180223235142.21501-1-jsnow@redhat.com>
References: <20180223235142.21501-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v4 09/21] blockjobs: add CONCLUDED state
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
             |CREATED|
             +--+----+
                |
             +--v----+     +------+
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
 blockjob.c           | 43 ++++++++++++++++++++++++++++---------------
 qapi/block-core.json |  5 ++++-
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 4c3fcda46c..93b0a36306 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -44,23 +44,24 @@ static QemuMutex block_job_mutex;
 
 /* BlockJob State Transition Table */
 bool BlockJobSTT[BLOCK_JOB_STATUS__MAX][BLOCK_JOB_STATUS__MAX] = {
-                                          /* U, C, R, P, Y, S, X */
-    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0},
-    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 0},
-    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0, 1},
-    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0, 0},
-    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1, 1},
-    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0, 0},
-    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 0},
+                                          /* U, C, R, P, Y, S, X, E */
+    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0, 0},
+    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 0, 0},
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
@@ -114,6 +115,7 @@ static void __attribute__((__constructor__)) block_job_init(void)
 
 static void block_job_event_cancelled(BlockJob *job);
 static void block_job_event_completed(BlockJob *job, const char *msg);
+static void block_job_event_concluded(BlockJob *job);
 static void block_job_enter_cond(BlockJob *job, bool(*fn)(BlockJob *job));
 
 /* Transactional group of block jobs */
@@ -420,6 +422,7 @@ static void block_job_completed_single(BlockJob *job)
 
     QLIST_REMOVE(job, txn_list);
     block_job_txn_unref(job->txn);
+    block_job_event_concluded(job);
     block_job_unref(job);
 }
 
@@ -620,7 +623,9 @@ void block_job_user_resume(BlockJob *job, Error **errp)
 
 void block_job_cancel(BlockJob *job)
 {
-    if (block_job_started(job)) {
+    if (job->status == BLOCK_JOB_STATUS_CONCLUDED) {
+        return;
+    } else if (block_job_started(job)) {
         block_job_cancel_async(job);
         block_job_enter(job);
     } else {
@@ -727,6 +732,14 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
                                         &error_abort);
 }
 
+static void block_job_event_concluded(BlockJob *job)
+{
+    if (block_job_is_internal(job) || !job->manual) {
+        return;
+    }
+    block_job_state_transition(job, BLOCK_JOB_STATUS_CONCLUDED);
+}
+
 /*
  * API for block job drivers and the block layer.  These functions are
  * declared in blockjob_int.h.
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 3f7d559fc0..aeb9b1937b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1000,11 +1000,14 @@
 #            an error. The job will afterwards report that it is @concluded.
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
