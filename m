Received: from eggs.gnu.org ([2001:4830:134:3::10]:37266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFs4-0000t7-IY
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFs2-0008Nv-L0
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:32 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 26 Jan 2018 21:05:06 -0500
Message-Id: <20180127020515.27137-6-jsnow@redhat.com>
In-Reply-To: <20180127020515.27137-1-jsnow@redhat.com>
References: <20180127020515.27137-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v3 05/14] blockjobs: add block_job_dismiss
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

For jobs that have reached their terminal state, prior to having their
last reference put down (meaning jobs that have completed successfully,
unsuccessfully, or have been canceled), allow the user to dismiss the
job's lingering status report via block-job-dismiss.

This gives management APIs the chance to conclusively determine if a job
failed or succeeded, even if the event broadcast was missed.

Note that jobs do not yet linger in any such state, they are freed
immediately upon reaching this previously-unnamed state. such a state is
added immediately in the next commit.

Valid objects:
Concluded: (added in a future commit); dismisses the concluded job.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/trace-events       |  1 +
 blockdev.c               | 14 ++++++++++++++
 blockjob.c               | 30 ++++++++++++++++++++++++++++++
 include/block/blockjob.h |  9 +++++++++
 qapi/block-core.json     | 19 +++++++++++++++++++
 5 files changed, 73 insertions(+)

diff --git a/block/trace-events b/block/trace-events
index 11c8d5f590..8f61566770 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -46,6 +46,7 @@ qmp_block_job_cancel(void *job) "job %p"
 qmp_block_job_pause(void *job) "job %p"
 qmp_block_job_resume(void *job) "job %p"
 qmp_block_job_complete(void *job) "job %p"
+qmp_block_job_dismiss(void *job) "job %p"
 qmp_block_stream(void *bs, void *job) "bs %p job %p"
 
 # block/file-win32.c
diff --git a/blockdev.c b/blockdev.c
index 2c0773bba7..5e8edff322 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3849,6 +3849,20 @@ void qmp_block_job_complete(const char *device, Error **errp)
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
index ea216aca5e..5531f5c2ab 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -58,6 +58,7 @@ enum BlockJobVerb {
     BLOCK_JOB_VERB_RESUME,
     BLOCK_JOB_VERB_SET_SPEED,
     BLOCK_JOB_VERB_COMPLETE,
+    BLOCK_JOB_VERB_DISMISS,
     BLOCK_JOB_VERB__MAX
 };
 
@@ -68,6 +69,7 @@ bool BlockJobVerb[BLOCK_JOB_VERB__MAX][BLOCK_JOB_STATUS__MAX] = {
     [BLOCK_JOB_VERB_RESUME]               = {0, 0, 0, 1, 0},
     [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1},
     [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1},
+    [BLOCK_JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0},
 };
 
 static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
@@ -426,6 +428,13 @@ static void block_job_cancel_async(BlockJob *job)
     job->cancelled = true;
 }
 
+static void block_job_do_dismiss(BlockJob *job)
+{
+    assert(job && job->manual == true);
+    block_job_state_transition(job, BLOCK_JOB_STATUS_UNDEFINED);
+    block_job_unref(job);
+}
+
 static int block_job_finish_sync(BlockJob *job,
                                  void (*finish)(BlockJob *, Error **errp),
                                  Error **errp)
@@ -455,6 +464,9 @@ static int block_job_finish_sync(BlockJob *job,
         aio_poll(qemu_get_aio_context(), true);
     }
     ret = (job->cancelled && job->ret == 0) ? -ECANCELED : job->ret;
+    if (job->manual) {
+        block_job_do_dismiss(job);
+    }
     block_job_unref(job);
     return ret;
 }
@@ -570,6 +582,24 @@ void block_job_complete(BlockJob *job, Error **errp)
     job->driver->complete(job, errp);
 }
 
+void block_job_dismiss(BlockJob **jobptr, Error **errp)
+{
+    BlockJob *job = *jobptr;
+    /* similarly to _complete, this is QMP-interface only. */
+    assert(job->id);
+    if (!job->manual) {
+        error_setg(errp, "The active block job '%s' was not started with "
+                   "\'manual\': true, and so cannot be dismissed as it will "
+                   "clean up after itself automatically", job->id);
+        return;
+    }
+
+    error_setg(errp, "unimplemented");
+
+    block_job_do_dismiss(job);
+    *jobptr = NULL;
+}
+
 void block_job_user_pause(BlockJob *job)
 {
     job->user_paused = true;
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index d8e7df7e6e..7c71dc0ca7 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -241,6 +241,15 @@ void block_job_cancel(BlockJob *job);
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
index eac89754c1..32aefa5a27 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2198,6 +2198,25 @@
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
+# its terminal state. "cancel" or "complete" will still need to be used as
+# appropriate.
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
