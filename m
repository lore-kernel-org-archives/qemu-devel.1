Received: from eggs.gnu.org ([2001:4830:134:3::10]:37273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFs4-0000tx-Ty
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFs3-0008P2-Tm
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:32 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 26 Jan 2018 21:05:07 -0500
Message-Id: <20180127020515.27137-7-jsnow@redhat.com>
In-Reply-To: <20180127020515.27137-1-jsnow@redhat.com>
References: <20180127020515.27137-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v3 06/14] blockjobs: add CONCLUDED state
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

Valid transitions:
Running -> Concluded (cancellation, normal completion)
Paused -> Concluded (cancellation)
Ready -> Concluded (cancellation, manual completion)
Concluded -> Undefined (immediately prior to destruction)

Valid verbs:
Dismiss: culls the job and job info from the query list.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c           | 56 +++++++++++++++++++++++++++++++++++++---------------
 qapi/block-core.json |  8 +++++---
 2 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 5531f5c2ab..0083fd7b0c 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -44,12 +44,13 @@ static QemuMutex block_job_mutex;
 
 /* BlockJob State Transition Table */
 bool BlockJobSTT[BLOCK_JOB_STATUS__MAX][BLOCK_JOB_STATUS__MAX] = {
-                                          /* U, C, R, P, Y */
-    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0},
-    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0},
-    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1},
-    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 1},
-    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 1, 0},
+                                          /* U, C, R, P, Y, E */
+    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0},
+    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0},
+    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 1},
+    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 1, 1},
+    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 1, 0, 1},
+    /* E: */ [BLOCK_JOB_STATUS_CONCLUDED] = {1, 0, 0, 0, 0, 0},
 };
 
 enum BlockJobVerb {
@@ -63,13 +64,13 @@ enum BlockJobVerb {
 };
 
 bool BlockJobVerb[BLOCK_JOB_VERB__MAX][BLOCK_JOB_STATUS__MAX] = {
-                                          /* U, C, R, P, Y */
-    [BLOCK_JOB_VERB_CANCEL]               = {0, 1, 1, 1, 1},
-    [BLOCK_JOB_VERB_PAUSE]                = {0, 1, 1, 1, 1},
-    [BLOCK_JOB_VERB_RESUME]               = {0, 0, 0, 1, 0},
-    [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1},
-    [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1},
-    [BLOCK_JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0},
+                                          /* U, C, R, P, Y, E */
+    [BLOCK_JOB_VERB_CANCEL]               = {0, 1, 1, 1, 1, 0},
+    [BLOCK_JOB_VERB_PAUSE]                = {0, 1, 1, 1, 1, 0},
+    [BLOCK_JOB_VERB_RESUME]               = {0, 0, 0, 1, 0, 0},
+    [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 0},
+    [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0},
+    [BLOCK_JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0, 1},
 };
 
 static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
@@ -108,6 +109,7 @@ static void __attribute__((__constructor__)) block_job_init(void)
 
 static void block_job_event_cancelled(BlockJob *job);
 static void block_job_event_completed(BlockJob *job, const char *msg);
+static void block_job_event_concluded(BlockJob *job);
 static void block_job_enter_cond(BlockJob *job, bool(*fn)(BlockJob *job));
 
 /* Transactional group of block jobs */
@@ -412,6 +414,8 @@ static void block_job_completed_single(BlockJob *job)
         QLIST_REMOVE(job, txn_list);
         block_job_txn_unref(job->txn);
     }
+
+    block_job_event_concluded(job);
     block_job_unref(job);
 }
 
@@ -592,10 +596,14 @@ void block_job_dismiss(BlockJob **jobptr, Error **errp)
                    "\'manual\': true, and so cannot be dismissed as it will "
                    "clean up after itself automatically", job->id);
         return;
+    } else if (job->status != BLOCK_JOB_STATUS_CONCLUDED) {
+        error_setg(errp, "The active block job '%s', status: '%s', has not yet "
+                         "concluded, and cannot be dismissed yet",
+                   job->id,
+                   qapi_enum_lookup(&BlockJobStatus_lookup, job->status));
+        return;
     }
 
-    error_setg(errp, "unimplemented");
-
     block_job_do_dismiss(job);
     *jobptr = NULL;
 }
@@ -622,7 +630,9 @@ void block_job_user_resume(BlockJob *job)
 
 void block_job_cancel(BlockJob *job)
 {
-    if (block_job_started(job)) {
+    if (job->status == BLOCK_JOB_STATUS_CONCLUDED) {
+        return;
+    } else if (block_job_started(job)) {
         block_job_cancel_async(job);
         block_job_enter(job);
     } else {
@@ -724,6 +734,14 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
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
@@ -814,6 +832,12 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
             return NULL;
         }
     }
+
+    /* Hang on to an extra reference on behalf of the QMP monitor */
+    if (job->manual) {
+        block_job_ref(job);
+    }
+
     return job;
 }
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 32aefa5a27..f27c7054d2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -965,7 +965,8 @@
 # Since: 2.12
 ##
 { 'enum': 'BlockJobStatus',
-  'data': ['undefined', 'created', 'running', 'paused', 'ready'] }
+  'data': ['undefined', 'created', 'running', 'paused', 'ready',
+           'concluded' ] }
 
 ##
 # @BlockJobInfo:
@@ -2206,8 +2207,9 @@
 # QEMU 2.12+ job lifetime management semantics.
 #
 # This command will refuse to operate on any job that has not yet reached
-# its terminal state. "cancel" or "complete" will still need to be used as
-# appropriate.
+# its terminal state, BLOCK_JOB_STATUS_CONCLUDED. For jobs that make use of
+# BLOCK_JOB_READY event, block-job-cancel or block-job-complete will still need
+# to be used as appropriate.
 #
 # @id: The job identifier.
 #
-- 
2.14.3
