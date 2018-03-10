Received: from eggs.gnu.org ([2001:4830:134:3::10]:53774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrP-0002Uk-MG
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrO-0000FJ-2p
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:11 -0500
From: John Snow <jsnow@redhat.com>
Date: Sat, 10 Mar 2018 03:27:43 -0500
Message-Id: <20180310082746.24198-19-jsnow@redhat.com>
In-Reply-To: <20180310082746.24198-1-jsnow@redhat.com>
References: <20180310082746.24198-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 18/21] blockjobs: add block-job-finalize
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

Instead of automatically transitioning from PENDING to CONCLUDED, gate
the .prepare() and .commit() phases behind an explicit acknowledgement
provided by the QMP monitor if auto_finalize = false has been requested.

This allows us to perform graph changes in prepare and/or commit so that
graph changes do not occur autonomously without knowledge of the
controlling management layer.

Transactions that have reached the "PENDING" state together can all be
moved to invoke their finalization methods by issuing block_job_finalize
to any one job in the transaction.

Jobs in a transaction with mixed job->auto_finalize settings will all
remain stuck in the "PENDING" state, as if the entire transaction was
specified with auto_finalize = false. Jobs that specified
auto_finalize = true, however, will still not emit the PENDING event.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/trace-events       |  1 +
 blockdev.c               | 14 +++++++++++
 blockjob.c               | 60 +++++++++++++++++++++++++++++++++++-------------
 include/block/blockjob.h | 17 ++++++++++++++
 qapi/block-core.json     | 23 ++++++++++++++++++-
 5 files changed, 98 insertions(+), 17 deletions(-)

diff --git a/block/trace-events b/block/trace-events
index 5e531e0310..a81b66ff36 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -51,6 +51,7 @@ qmp_block_job_cancel(void *job) "job %p"
 qmp_block_job_pause(void *job) "job %p"
 qmp_block_job_resume(void *job) "job %p"
 qmp_block_job_complete(void *job) "job %p"
+qmp_block_job_finalize(void *job) "job %p"
 qmp_block_job_dismiss(void *job) "job %p"
 qmp_block_stream(void *bs, void *job) "bs %p job %p"
 
diff --git a/blockdev.c b/blockdev.c
index 9900cbc7dd..efd3ab2e99 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3853,6 +3853,20 @@ void qmp_block_job_complete(const char *device, Error **errp)
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
index 3880a89678..4b73cb0263 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -65,6 +65,7 @@ bool BlockJobVerbTable[BLOCK_JOB_VERB__MAX][BLOCK_JOB_STATUS__MAX] = {
     [BLOCK_JOB_VERB_RESUME]               = {0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0},
     [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0},
     [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
+    [BLOCK_JOB_VERB_FINALIZE]             = {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
     [BLOCK_JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
 };
 
@@ -449,7 +450,7 @@ static void block_job_clean(BlockJob *job)
     }
 }
 
-static int block_job_completed_single(BlockJob *job)
+static int block_job_finalize_single(BlockJob *job)
 {
     assert(job->completed);
 
@@ -590,18 +591,36 @@ static void block_job_completed_txn_abort(BlockJob *job)
             assert(other_job->cancelled);
             block_job_finish_sync(other_job, NULL, NULL);
         }
-        block_job_completed_single(other_job);
+        block_job_finalize_single(other_job);
         aio_context_release(ctx);
     }
 
     block_job_txn_unref(txn);
 }
 
+static int block_job_needs_finalize(BlockJob *job)
+{
+    return !job->auto_finalize;
+}
+
+static void block_job_do_finalize(BlockJob *job)
+{
+    int rc;
+    assert(job && job->txn);
+
+    /* prepare the transaction to complete */
+    rc = block_job_txn_apply(job->txn, block_job_prepare, true);
+    if (rc) {
+        block_job_completed_txn_abort(job);
+    } else {
+        block_job_txn_apply(job->txn, block_job_finalize_single, true);
+    }
+}
+
 static void block_job_completed_txn_success(BlockJob *job)
 {
     BlockJobTxn *txn = job->txn;
     BlockJob *other_job;
-    int rc = 0;
 
     block_job_state_transition(job, BLOCK_JOB_STATUS_WAITING);
 
@@ -616,16 +635,12 @@ static void block_job_completed_txn_success(BlockJob *job)
         assert(other_job->ret == 0);
     }
 
-    /* Jobs may require some prep-work to complete without failure */
-    rc = block_job_txn_apply(txn, block_job_prepare, true);
-    if (rc) {
-        block_job_completed_txn_abort(job);
-        return;
-    }
-
-    /* We are the last completed job, commit the transaction. */
     block_job_txn_apply(txn, block_job_event_pending, false);
-    block_job_txn_apply(txn, block_job_completed_single, true);
+
+    /* If no jobs need manual finalization, automatically do so */
+    if (block_job_txn_apply(txn, block_job_needs_finalize, false) == 0) {
+        block_job_do_finalize(job);
+    }
 }
 
 /* Assumes the block_job_mutex is held */
@@ -677,6 +692,15 @@ void block_job_complete(BlockJob *job, Error **errp)
     job->driver->complete(job, errp);
 }
 
+void block_job_finalize(BlockJob *job, Error **errp)
+{
+    assert(job && job->id && job->txn);
+    if (block_job_apply_verb(job, BLOCK_JOB_VERB_FINALIZE, errp)) {
+        return;
+    }
+    block_job_do_finalize(job);
+}
+
 void block_job_dismiss(BlockJob **jobptr, Error **errp)
 {
     BlockJob *job = *jobptr;
@@ -727,11 +751,15 @@ void block_job_cancel(BlockJob *job)
 {
     if (job->status == BLOCK_JOB_STATUS_CONCLUDED) {
         block_job_do_dismiss(job);
-    } else if (block_job_started(job)) {
-        block_job_cancel_async(job);
-        block_job_enter(job);
-    } else {
+        return;
+    }
+    block_job_cancel_async(job);
+    if (!block_job_started(job)) {
         block_job_completed(job, -ECANCELED);
+    } else if (job->deferred_to_main_loop) {
+        block_job_completed_txn_abort(job);
+    } else {
+        block_job_enter(job);
     }
 }
 
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 7c8d51effa..978274ed2b 100644
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
index 73584ff3f5..961c4a3d0c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -972,10 +972,13 @@
 #
 # @dismiss: see @block-job-dismiss
 #
+# @finalize: see @block-job-finalize
+#
 # Since: 2.12
 ##
 { 'enum': 'BlockJobVerb',
-  'data': ['cancel', 'pause', 'resume', 'set-speed', 'complete', 'dismiss' ] }
+  'data': ['cancel', 'pause', 'resume', 'set-speed', 'complete', 'dismiss',
+           'finalize' ] }
 
 ##
 # @BlockJobStatus:
@@ -2274,6 +2277,24 @@
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
