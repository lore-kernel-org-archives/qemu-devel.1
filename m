Received: from eggs.gnu.org ([2001:4830:134:3::10]:37437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFsB-0001B0-4d
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFs9-0008UW-J3
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:39 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 26 Jan 2018 21:05:13 -0500
Message-Id: <20180127020515.27137-13-jsnow@redhat.com>
In-Reply-To: <20180127020515.27137-1-jsnow@redhat.com>
References: <20180127020515.27137-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v3 12/14] blockjobs: add block-job-finalize
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/trace-events       |  1 +
 blockdev.c               | 14 ++++++++++
 blockjob.c               | 72 +++++++++++++++++++++++++++++++++++++++---------
 include/block/blockjob.h | 17 ++++++++++++
 qapi/block-core.json     | 18 ++++++++++++
 5 files changed, 109 insertions(+), 13 deletions(-)

diff --git a/block/trace-events b/block/trace-events
index 8f61566770..d3be349489 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -46,6 +46,7 @@ qmp_block_job_cancel(void *job) "job %p"
 qmp_block_job_pause(void *job) "job %p"
 qmp_block_job_resume(void *job) "job %p"
 qmp_block_job_complete(void *job) "job %p"
+qmp_block_job_finalize(void *job) "job %p"
 qmp_block_job_dismiss(void *job) "job %p"
 qmp_block_stream(void *bs, void *job) "bs %p job %p"
 
diff --git a/blockdev.c b/blockdev.c
index 5e8edff322..d387ef6ec0 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3849,6 +3849,20 @@ void qmp_block_job_complete(const char *device, Error **errp)
     aio_context_release(aio_context);
 }
 
+void qmp_block_job_finalize(const char *id, Error **errp)
+{
+    AioContext *aio_context;
+    BlockJob *job = find_block_job(id, &aio_context, errp);
+
+    if (!job) {
+        return;
+    }
+
+    trace_qmp_block_job_finalize(job);
+    block_job_finalize(job, errp);
+    aio_context_release(aio_context);
+}
+
 void qmp_block_job_dismiss(const char *id, Error **errp)
 {
     AioContext *aio_context;
diff --git a/blockjob.c b/blockjob.c
index d31b65273c..b8d6dd3bb4 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -61,6 +61,7 @@ enum BlockJobVerb {
     BLOCK_JOB_VERB_RESUME,
     BLOCK_JOB_VERB_SET_SPEED,
     BLOCK_JOB_VERB_COMPLETE,
+    BLOCK_JOB_VERB_FINALIZE,
     BLOCK_JOB_VERB_DISMISS,
     BLOCK_JOB_VERB__MAX
 };
@@ -72,6 +73,7 @@ bool BlockJobVerb[BLOCK_JOB_VERB__MAX][BLOCK_JOB_STATUS__MAX] = {
     [BLOCK_JOB_VERB_RESUME]               = {0, 0, 0, 1, 0, 0, 0, 0},
     [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 0, 0, 0},
     [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0, 0, 0},
+    [BLOCK_JOB_VERB_FINALIZE]             = {0, 0, 0, 0, 0, 0, 1, 0},
     [BLOCK_JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0, 0, 0, 1},
 };
 
@@ -459,6 +461,15 @@ static void block_job_completed_single(BlockJob *job)
     block_job_unref(job);
 }
 
+static void block_job_await_finalization(BlockJob *job)
+{
+    if (!job->manual) {
+        block_job_completed_single(job);
+    } else {
+        block_job_event_pending(job);
+    }
+}
+
 static void block_job_cancel_async(BlockJob *job)
 {
     if (job->iostatus != BLOCK_DEVICE_IO_STATUS_OK) {
@@ -558,6 +569,19 @@ static void block_job_completed_txn_abort(BlockJob *job)
     block_job_txn_unref(txn);
 }
 
+static void block_job_txn_apply(BlockJobTxn *txn, void fn(BlockJob *))
+{
+    AioContext *ctx;
+    BlockJob *job, *next;
+
+    QLIST_FOREACH_SAFE(job, &txn->jobs, txn_list, next) {
+        ctx = blk_get_aio_context(job->blk);
+        aio_context_acquire(ctx);
+        fn(job);
+        aio_context_release(ctx);
+    }
+}
+
 static void block_job_completed_txn_success(BlockJob *job)
 {
     AioContext *ctx;
@@ -590,14 +614,9 @@ static void block_job_completed_txn_success(BlockJob *job)
         }
     }
 
-    /* We are the last completed job, commit the transaction. */
-    QLIST_FOREACH_SAFE(other_job, &txn->jobs, txn_list, next) {
-        ctx = blk_get_aio_context(other_job->blk);
-        aio_context_acquire(ctx);
-        assert(other_job->ret == 0);
-        block_job_completed_single(other_job);
-        aio_context_release(ctx);
-    }
+    /* We are the last completed job, either commit the transaction
+     * or prepare for finalization via user intervention. */
+    block_job_txn_apply(txn, block_job_await_finalization);
 }
 
 /* Assumes the block_job_mutex is held */
@@ -606,6 +625,15 @@ static bool block_job_timer_pending(BlockJob *job)
     return timer_pending(&job->sleep_timer);
 }
 
+static void block_job_txn_completed(BlockJob *job, int ret)
+{
+    if (ret < 0 || block_job_is_cancelled(job)) {
+        block_job_completed_txn_abort(job);
+    } else {
+        block_job_completed_txn_success(job);
+    }
+}
+
 void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
 {
     Error *local_err = NULL;
@@ -644,6 +672,27 @@ void block_job_complete(BlockJob *job, Error **errp)
     job->driver->complete(job, errp);
 }
 
+void block_job_finalize(BlockJob *job, Error **errp)
+{
+    assert(job->id);
+    if (!job->manual) {
+        error_setg(errp, "The block job '%s' was not started with "
+                   "\'manual\': true, and so cannot be finalized as it will"
+                   "do so automatically upon finishing its task", job->id);
+        return;
+    } else if (job->status != BLOCK_JOB_STATUS_PENDING) {
+        error_setg(errp, "The active block job '%s' is not yet awaiting "
+                   "finalization and cannot be finalized", job->id);
+        return;
+    }
+
+    if (!job->txn) {
+        block_job_completed_single(job);
+    } else {
+        block_job_txn_apply(job->txn, block_job_completed_single);
+    }
+}
+
 void block_job_dismiss(BlockJob **jobptr, Error **errp)
 {
     BlockJob *job = *jobptr;
@@ -807,7 +856,6 @@ static void block_job_event_waiting(BlockJob *job)
                                       &error_abort);
 }
 
-__attribute__((__unused__)) /* FIXME */
 static void block_job_event_pending(BlockJob *job)
 {
     if (block_job_is_internal(job) || !job->manual) {
@@ -952,12 +1000,10 @@ void block_job_completed(BlockJob *job, int ret)
     job->completed = true;
     job->ret = ret;
     if (!job->txn) {
-        block_job_completed_single(job);
-    } else if (ret < 0 || block_job_is_cancelled(job)) {
-        block_job_completed_txn_abort(job);
+        block_job_await_finalization(job);
     } else {
         block_job_event_waiting(job);
-        block_job_completed_txn_success(job);
+        block_job_txn_completed(job, ret);
     }
 }
 
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 5f73fc8831..188853ca77 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -244,6 +244,23 @@ void block_job_cancel(BlockJob *job);
  */
 void block_job_complete(BlockJob *job, Error **errp);
 
+
+/**
+ * block_job_finalize:
+ * @job: The job to fully commit and finish.
+ * @errp: Error object.
+ *
+ * For jobs that have finished their work and are pending
+ * awaiting explicit acknowledgement to commit their work,
+ * This will commit that work.
+ *
+ * FIXME: Make the below statement universally true:
+ * For jobs that support the manual workflow mode, all graph
+ * changes that occur as a result will occur after this command
+ * and before a successful reply.
+ */
+void block_job_finalize(BlockJob *job, Error **errp);
+
 /**
  * block_job_dismiss:
  * @job: The job to be dismissed.
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1f2eb39810..bd4458bf57 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2219,6 +2219,24 @@
 ##
 { 'command': 'block-job-dismiss', 'data': { 'id': 'str' } }
 
+##
+# @block-job-finalize:
+#
+# Once a job that has manual=true reaches the pending state, it can be
+# instructed to finalize any graph changes and do any necessary cleanup
+# via this command.
+# For jobs in a transaction, instructing one job to finalize will force
+# ALL jobs in the transaction to finalize, so it is only necessary to instruct
+# a single member job to finalize.
+#
+# @id: The job identifier.
+#
+# Returns: Nothing on success
+#
+# Since: 2.12
+##
+{ 'command': 'block-job-finalize', 'data': { 'id': 'str' } }
+
 ##
 # @BlockdevDiscardOptions:
 #
-- 
2.14.3
