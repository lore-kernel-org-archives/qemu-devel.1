Received: from eggs.gnu.org ([2001:4830:134:3::10]:59252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmd6-0001Kh-Ma
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmd5-0004Yd-6G
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:24 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:33 +0100
Message-Id: <20180313161803.1814-12-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 11/41] blockjobs: add block_job_dismiss
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

For jobs that have reached their CONCLUDED state, prior to having their
last reference put down (meaning jobs that have completed successfully,
unsuccessfully, or have been canceled), allow the user to dismiss the
job's lingering status report via block-job-dismiss.

This gives management APIs the chance to conclusively determine if a job
failed or succeeded, even if the event broadcast was missed.

Note: block_job_do_dismiss and block_job_decommission happen to do
exactly the same thing, but they're called from different semantic
contexts, so both aliases are kept to improve readability.

Note 2: Don't worry about the 0x04 flag definition for AUTO_DISMISS, she
has a friend coming in a future patch to fill the hole where 0x02 is.

Verbs:
Dismiss: operates on CONCLUDED jobs only.
Signed-off-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json     | 24 +++++++++++++++++++++++-
 include/block/blockjob.h | 14 ++++++++++++++
 blockdev.c               | 14 ++++++++++++++
 blockjob.c               | 26 ++++++++++++++++++++++++--
 block/trace-events       |  1 +
 5 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4b777fc46f..fb577d45f8 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -970,10 +970,12 @@
 #
 # @complete: see @block-job-complete
 #
+# @dismiss: see @block-job-dismiss
+#
 # Since: 2.12
 ##
 { 'enum': 'BlockJobVerb',
-  'data': ['cancel', 'pause', 'resume', 'set-speed', 'complete' ] }
+  'data': ['cancel', 'pause', 'resume', 'set-speed', 'complete', 'dismiss' ] }
 
 ##
 # @BlockJobStatus:
@@ -2244,6 +2246,26 @@
 { 'command': 'block-job-complete', 'data': { 'device': 'str' } }
 
 ##
+# @block-job-dismiss:
+#
+# For jobs that have already concluded, remove them from the block-job-query
+# list. This command only needs to be run for jobs which were started with
+# QEMU 2.12+ job lifetime management semantics.
+#
+# This command will refuse to operate on any job that has not yet reached
+# its terminal state, BLOCK_JOB_STATUS_CONCLUDED. For jobs that make use of
+# BLOCK_JOB_READY event, block-job-cancel or block-job-complete will still need
+# to be used as appropriate.
+#
+# @id: The job identifier.
+#
+# Returns: Nothing on success
+#
+# Since: 2.12
+##
+{ 'command': 'block-job-dismiss', 'data': { 'id': 'str' } }
+
+##
 # @BlockdevDiscardOptions:
 #
 # Determines how to handle discard requests.
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index df0a9773d1..c535829b46 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -142,6 +142,9 @@ typedef struct BlockJob {
     /** Current state; See @BlockJobStatus for details. */
     BlockJobStatus status;
 
+    /** True if this job should automatically dismiss itself */
+    bool auto_dismiss;
+
     BlockJobTxn *txn;
     QLIST_ENTRY(BlockJob) txn_list;
 } BlockJob;
@@ -151,6 +154,8 @@ typedef enum BlockJobCreateFlags {
     BLOCK_JOB_DEFAULT = 0x00,
     /* BlockJob is not QMP-created and should not send QMP events */
     BLOCK_JOB_INTERNAL = 0x01,
+    /* BlockJob requires manual dismiss step */
+    BLOCK_JOB_MANUAL_DISMISS = 0x04,
 } BlockJobCreateFlags;
 
 /**
@@ -235,6 +240,15 @@ void block_job_cancel(BlockJob *job);
 void block_job_complete(BlockJob *job, Error **errp);
 
 /**
+ * block_job_dismiss:
+ * @job: The job to be dismissed.
+ * @errp: Error object.
+ *
+ * Remove a concluded job from the query list.
+ */
+void block_job_dismiss(BlockJob **job, Error **errp);
+
+/**
  * block_job_query:
  * @job: The job to get information about.
  *
diff --git a/blockdev.c b/blockdev.c
index f70a783803..9900cbc7dd 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3853,6 +3853,20 @@ void qmp_block_job_complete(const char *device, Error **errp)
     aio_context_release(aio_context);
 }
 
+void qmp_block_job_dismiss(const char *id, Error **errp)
+{
+    AioContext *aio_context;
+    BlockJob *job = find_block_job(id, &aio_context, errp);
+
+    if (!job) {
+        return;
+    }
+
+    trace_qmp_block_job_dismiss(job);
+    block_job_dismiss(&job, errp);
+    aio_context_release(aio_context);
+}
+
 void qmp_change_backing_file(const char *device,
                              const char *image_node_name,
                              const char *backing_file,
diff --git a/blockjob.c b/blockjob.c
index 2ef48075b0..59ac4a13c7 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -63,6 +63,7 @@ bool BlockJobVerbTable[BLOCK_JOB_VERB__MAX][BLOCK_JOB_STATUS__MAX] = {
     [BLOCK_JOB_VERB_RESUME]               = {0, 1, 1, 1, 1, 1, 0, 0, 0},
     [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 1, 0, 0, 0},
     [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0, 0, 0, 0},
+    [BLOCK_JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0, 0, 0, 1, 0},
 };
 
 static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
@@ -391,9 +392,17 @@ static void block_job_decommission(BlockJob *job)
     block_job_unref(job);
 }
 
+static void block_job_do_dismiss(BlockJob *job)
+{
+    block_job_decommission(job);
+}
+
 static void block_job_conclude(BlockJob *job)
 {
     block_job_state_transition(job, BLOCK_JOB_STATUS_CONCLUDED);
+    if (job->auto_dismiss || !block_job_started(job)) {
+        block_job_do_dismiss(job);
+    }
 }
 
 static void block_job_completed_single(BlockJob *job)
@@ -437,7 +446,6 @@ static void block_job_completed_single(BlockJob *job)
     QLIST_REMOVE(job, txn_list);
     block_job_txn_unref(job->txn);
     block_job_conclude(job);
-    block_job_decommission(job);
 }
 
 static void block_job_cancel_async(BlockJob *job)
@@ -602,6 +610,19 @@ void block_job_complete(BlockJob *job, Error **errp)
     job->driver->complete(job, errp);
 }
 
+void block_job_dismiss(BlockJob **jobptr, Error **errp)
+{
+    BlockJob *job = *jobptr;
+    /* similarly to _complete, this is QMP-interface only. */
+    assert(job->id);
+    if (block_job_apply_verb(job, BLOCK_JOB_VERB_DISMISS, errp)) {
+        return;
+    }
+
+    block_job_do_dismiss(job);
+    *jobptr = NULL;
+}
+
 void block_job_user_pause(BlockJob *job, Error **errp)
 {
     if (block_job_apply_verb(job, BLOCK_JOB_VERB_PAUSE, errp)) {
@@ -638,7 +659,7 @@ void block_job_user_resume(BlockJob *job, Error **errp)
 void block_job_cancel(BlockJob *job)
 {
     if (job->status == BLOCK_JOB_STATUS_CONCLUDED) {
-        return;
+        block_job_do_dismiss(job);
     } else if (block_job_started(job)) {
         block_job_cancel_async(job);
         block_job_enter(job);
@@ -807,6 +828,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job->paused        = true;
     job->pause_count   = 1;
     job->refcnt        = 1;
+    job->auto_dismiss  = !(flags & BLOCK_JOB_MANUAL_DISMISS);
     block_job_state_transition(job, BLOCK_JOB_STATUS_CREATED);
     aio_timer_init(qemu_get_aio_context(), &job->sleep_timer,
                    QEMU_CLOCK_REALTIME, SCALE_NS,
diff --git a/block/trace-events b/block/trace-events
index 3fe89f7ea6..266afd9e99 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -50,6 +50,7 @@ qmp_block_job_cancel(void *job) "job %p"
 qmp_block_job_pause(void *job) "job %p"
 qmp_block_job_resume(void *job) "job %p"
 qmp_block_job_complete(void *job) "job %p"
+qmp_block_job_dismiss(void *job) "job %p"
 qmp_block_stream(void *bs, void *job) "bs %p job %p"
 
 # block/file-win32.c
-- 
2.13.6
