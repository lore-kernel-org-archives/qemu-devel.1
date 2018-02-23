Received: from eggs.gnu.org ([2001:4830:134:3::10]:55268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8L-0005q2-2E
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8H-0005qe-Ts
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:09 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 23 Feb 2018 18:51:31 -0500
Message-Id: <20180223235142.21501-11-jsnow@redhat.com>
In-Reply-To: <20180223235142.21501-1-jsnow@redhat.com>
References: <20180223235142.21501-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v4 10/21] blockjobs: add NULL state
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
             |CREATED+------------------+
             +--+----+                  |
                |                       |
             +--v----+     +------+     |
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
 blockjob.c           | 35 +++++++++++++++++------------------
 qapi/block-core.json |  5 ++++-
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 93b0a36306..7b5c4063cf 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -44,24 +44,25 @@ static QemuMutex block_job_mutex;
 
 /* BlockJob State Transition Table */
 bool BlockJobSTT[BLOCK_JOB_STATUS__MAX][BLOCK_JOB_STATUS__MAX] = {
-                                          /* U, C, R, P, Y, S, X, E */
-    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0, 0},
-    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 0, 0},
-    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0, 1, 1},
-    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0, 0, 0},
-    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1, 1, 1},
-    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0, 0, 0},
-    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 0, 1},
-    /* E: */ [BLOCK_JOB_STATUS_CONCLUDED] = {0, 0, 0, 0, 0, 0, 0, 0},
+                                          /* U, C, R, P, Y, S, X, E, N */
+    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0, 0, 0, 0},
+    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0, 0, 0, 1},
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
@@ -423,6 +424,7 @@ static void block_job_completed_single(BlockJob *job)
     QLIST_REMOVE(job, txn_list);
     block_job_txn_unref(job->txn);
     block_job_event_concluded(job);
+    block_job_state_transition(job, BLOCK_JOB_STATUS_NULL);
     block_job_unref(job);
 }
 
@@ -734,9 +736,6 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
 
 static void block_job_event_concluded(BlockJob *job)
 {
-    if (block_job_is_internal(job) || !job->manual) {
-        return;
-    }
     block_job_state_transition(job, BLOCK_JOB_STATUS_CONCLUDED);
 }
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index aeb9b1937b..578c0c91ca 100644
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
