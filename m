Received: from eggs.gnu.org ([2001:4830:134:3::10]:37365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFs8-00014G-O1
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFs7-0008SS-EM
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:36 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 26 Jan 2018 21:05:10 -0500
Message-Id: <20180127020515.27137-10-jsnow@redhat.com>
In-Reply-To: <20180127020515.27137-1-jsnow@redhat.com>
References: <20180127020515.27137-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v3 09/14] blockjobs: add prepare callback
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

Some jobs, upon finalization, may need to perform some work that can
still fail. If these jobs are part of a transaction, it's important
that these callbacks fail the entire transaction.

Thus, we allow for a new callback in addition to commit/abort/clean
that allows us the opportunity to have fairly late-breaking failures
in the transactional process.

The expected flow is as such:

- All jobs in a transaction converge to the WAITING state
  (added in a forthcoming commit)
- All jobs prepare to call either commit/abort
- If any job fails, is canceled, or fails preparation, all jobs
  call their .abort callback.
- All jobs enter the PENDING state, awaiting manual intervention
  (also added in a forthcoming commit)
- block-job-finalize is issued by the user/management layer
- All jobs call their commit callbacks.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c                   | 35 ++++++++++++++++++++++++++++++++++-
 include/block/blockjob.h     |  3 +++
 include/block/blockjob_int.h | 10 ++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/blockjob.c b/blockjob.c
index 1b169a0814..e52b4c4ce0 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -376,9 +376,21 @@ void block_job_start(BlockJob *job)
     bdrv_coroutine_enter(blk_bs(job->blk), job->co);
 }
 
+static int block_job_prepare(BlockJob *job)
+{
+    if (job->prepared) {
+        return job->ret;
+    }
+    job->prepared = true;
+    if (job->ret == 0 && job->driver->prepare) {
+        job->ret = job->driver->prepare(job);
+    }
+    return job->ret;
+}
+
 static void block_job_commit(BlockJob *job)
 {
-    assert(!job->ret);
+    assert(!job->ret && job->prepared);
     if (job->driver->commit) {
         job->driver->commit(job);
     }
@@ -408,6 +420,9 @@ static void block_job_completed_single(BlockJob *job)
         job->ret = -ECANCELED;
     }
 
+    /* NB: updates job->ret, only if not called on this job yet */
+    block_job_prepare(job);
+
     if (!job->ret) {
         block_job_commit(job);
     } else {
@@ -545,6 +560,8 @@ static void block_job_completed_txn_success(BlockJob *job)
     AioContext *ctx;
     BlockJobTxn *txn = job->txn;
     BlockJob *other_job, *next;
+    int rc = 0;
+
     /*
      * Successful completion, see if there are other running jobs in this
      * txn.
@@ -554,6 +571,22 @@ static void block_job_completed_txn_success(BlockJob *job)
             return;
         }
     }
+
+    /* Jobs may require some prep-work to complete without failure */
+    QLIST_FOREACH_SAFE(other_job, &txn->jobs, txn_list, next) {
+        ctx = blk_get_aio_context(other_job->blk);
+        aio_context_acquire(ctx);
+        assert(other_job->ret == 0);
+        rc = block_job_prepare(job);
+        aio_context_release(ctx);
+
+        /* This job failed. Cancel this transaction */
+        if (rc) {
+            block_job_completed_txn_abort(other_job);
+            return;
+        }
+    }
+
     /* We are the last completed job, commit the transaction. */
     QLIST_FOREACH_SAFE(other_job, &txn->jobs, txn_list, next) {
         ctx = blk_get_aio_context(other_job->blk);
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 7c71dc0ca7..5f73fc8831 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -150,6 +150,9 @@ typedef struct BlockJob {
      */
     BlockJobStatus status;
 
+    /* Job has made preparations to call either commit or abort */
+    bool prepared;
+
     /** Non-NULL if this job is part of a transaction */
     BlockJobTxn *txn;
     QLIST_ENTRY(BlockJob) txn_list;
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index a24c3f90e5..689d1bc659 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -53,6 +53,16 @@ struct BlockJobDriver {
      */
     void (*complete)(BlockJob *job, Error **errp);
 
+    /**
+     * If the callback is not NULL, prepare will be invoked when all the jobs
+     * belonging to the same transaction complete; or upon this job's completion
+     * if it is not in a transaction.
+     *
+     * This callback will not be invoked if the job has already failed.
+     * If it fails, abort and then clean will be called.
+     */
+    int (*prepare)(BlockJob *job);
+
     /**
      * If the callback is not NULL, it will be invoked when all the jobs
      * belonging to the same transaction complete; or upon this job's
-- 
2.14.3
