Received: from eggs.gnu.org ([2001:4830:134:3::10]:55457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8R-0005yp-Bj
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8P-000668-Ia
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:15 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 23 Feb 2018 18:51:32 -0500
Message-Id: <20180223235142.21501-12-jsnow@redhat.com>
In-Reply-To: <20180223235142.21501-1-jsnow@redhat.com>
References: <20180223235142.21501-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v4 11/21] blockjobs: add block_job_dismiss
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

For jobs that have reached their CONCLUDED state, prior to having their
last reference put down (meaning jobs that have completed successfully,
unsuccessfully, or have been canceled), allow the user to dismiss the
job's lingering status report via block-job-dismiss.

This gives management APIs the chance to conclusively determine if a job
failed or succeeded, even if the event broadcast was missed.

Note that jobs do not yet linger in any such state, they are freed
immediately upon reaching this previously-unnamed state. such a state is
added immediately in the next commit.

Verbs:
Dismiss: operates on CONCLUDED jobs only.
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/trace-events       |  1 +
 blockdev.c               | 14 ++++++++++++++
 blockjob.c               | 34 ++++++++++++++++++++++++++++++++--
 include/block/blockjob.h |  9 +++++++++
 qapi/block-core.json     | 24 +++++++++++++++++++++++-
 5 files changed, 79 insertions(+), 3 deletions(-)

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
diff --git a/blockdev.c b/blockdev.c
index cba935a0a6..3180130782 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3852,6 +3852,20 @@ void qmp_block_job_complete(const char *device, Error **errp)
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
index 7b5c4063cf..4d29391673 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -63,6 +63,7 @@ bool BlockJobVerbTable[BLOCK_JOB_VERB__MAX][BLOCK_JOB_STATUS__MAX] = {
     [BLOCK_JOB_VERB_RESUME]               = {0, 1, 1, 1, 1, 1, 0, 0, 0},
     [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 1, 0, 0, 0},
     [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0, 0, 0, 0},
+    [BLOCK_JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0, 0, 0, 1, 0},
 };
 
 static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
@@ -424,7 +425,6 @@ static void block_job_completed_single(BlockJob *job)
     QLIST_REMOVE(job, txn_list);
     block_job_txn_unref(job->txn);
     block_job_event_concluded(job);
-    block_job_state_transition(job, BLOCK_JOB_STATUS_NULL);
     block_job_unref(job);
 }
 
@@ -441,6 +441,13 @@ static void block_job_cancel_async(BlockJob *job)
     job->cancelled = true;
 }
 
+static void block_job_do_dismiss(BlockJob *job)
+{
+    assert(job);
+    block_job_state_transition(job, BLOCK_JOB_STATUS_NULL);
+    block_job_unref(job);
+}
+
 static int block_job_finish_sync(BlockJob *job,
                                  void (*finish)(BlockJob *, Error **errp),
                                  Error **errp)
@@ -590,6 +597,19 @@ void block_job_complete(BlockJob *job, Error **errp)
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
@@ -626,7 +646,7 @@ void block_job_user_resume(BlockJob *job, Error **errp)
 void block_job_cancel(BlockJob *job)
 {
     if (job->status == BLOCK_JOB_STATUS_CONCLUDED) {
-        return;
+        block_job_do_dismiss(job);
     } else if (block_job_started(job)) {
         block_job_cancel_async(job);
         block_job_enter(job);
@@ -737,6 +757,10 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
 static void block_job_event_concluded(BlockJob *job)
 {
     block_job_state_transition(job, BLOCK_JOB_STATUS_CONCLUDED);
+    /* for pre-2.12 style jobs, automatically destroy */
+    if (!job->manual) {
+        block_job_do_dismiss(job);
+    }
 }
 
 /*
@@ -841,6 +865,9 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
         block_job_txn_add_job(txn, job);
     }
 
+    /* For the expanded job control STM, grab an extra
+     * reference for finalize() to put down */
+    block_job_ref(job);
     return job;
 }
 
@@ -859,6 +886,9 @@ void block_job_pause_all(void)
 
 void block_job_early_fail(BlockJob *job)
 {
+    /* One for creation, one for finalize() */
+    assert(job->status == BLOCK_JOB_STATUS_CREATED);
+    block_job_unref(job);
     block_job_unref(job);
 }
 
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 403a168073..9bb0be1b13 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -245,6 +245,15 @@ void block_job_cancel(BlockJob *job);
  */
 void block_job_complete(BlockJob *job, Error **errp);
 
+/**
+ * block_job_dismiss:
+ * @job: The job to be dismissed.
+ * @errp: Error object.
+ *
+ * Remove a concluded job from the query list.
+ */
+void block_job_dismiss(BlockJob **job, Error **errp);
+
 /**
  * block_job_query:
  * @job: The job to get information about.
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 578c0c91ca..b42796a6a0 100644
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
@@ -2243,6 +2245,26 @@
 ##
 { 'command': 'block-job-complete', 'data': { 'device': 'str' } }
 
+##
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
 ##
 # @BlockdevDiscardOptions:
 #
-- 
2.14.3
