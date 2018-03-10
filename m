Received: from eggs.gnu.org ([2001:4830:134:3::10]:53676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrM-0002R9-Rk
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrK-0000D6-7R
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:08 -0500
From: John Snow <jsnow@redhat.com>
Date: Sat, 10 Mar 2018 03:27:40 -0500
Message-Id: <20180310082746.24198-16-jsnow@redhat.com>
In-Reply-To: <20180310082746.24198-1-jsnow@redhat.com>
References: <20180310082746.24198-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 15/21] blockjobs: add prepare callback
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

Some jobs upon finalization may need to perform some work that can
still fail. If these jobs are part of a transaction, it's important
that these callbacks fail the entire transaction.

We allow for a new callback in addition to commit/abort/clean that
allows us the opportunity to have fairly late-breaking failures
in the transactional process.

The expected flow is:

- All jobs in a transaction converge to the PENDING state,
  added in a forthcoming commit.
- Upon being finalized, either automatically or explicitly
  by the user, jobs prepare to complete.
- If any job fails preparation, all jobs call .abort.
- Otherwise, they succeed and call .commit.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c                   | 30 +++++++++++++++++++++++++++---
 include/block/blockjob_int.h | 10 ++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 7e03824751..1395d8eed1 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -415,6 +415,14 @@ static void block_job_update_rc(BlockJob *job)
     }
 }
 
+static int block_job_prepare(BlockJob *job)
+{
+    if (job->ret == 0 && job->driver->prepare) {
+        job->ret = job->driver->prepare(job);
+    }
+    return job->ret;
+}
+
 static void block_job_commit(BlockJob *job)
 {
     assert(!job->ret);
@@ -438,7 +446,7 @@ static void block_job_clean(BlockJob *job)
     }
 }
 
-static void block_job_completed_single(BlockJob *job)
+static int block_job_completed_single(BlockJob *job)
 {
     assert(job->completed);
 
@@ -472,6 +480,7 @@ static void block_job_completed_single(BlockJob *job)
     QLIST_REMOVE(job, txn_list);
     block_job_txn_unref(job->txn);
     block_job_conclude(job);
+    return 0;
 }
 
 static void block_job_cancel_async(BlockJob *job)
@@ -487,17 +496,22 @@ static void block_job_cancel_async(BlockJob *job)
     job->cancelled = true;
 }
 
-static void block_job_txn_apply(BlockJobTxn *txn, void fn(BlockJob *))
+static int block_job_txn_apply(BlockJobTxn *txn, int fn(BlockJob *))
 {
     AioContext *ctx;
     BlockJob *job, *next;
+    int rc;
 
     QLIST_FOREACH_SAFE(job, &txn->jobs, txn_list, next) {
         ctx = blk_get_aio_context(job->blk);
         aio_context_acquire(ctx);
-        fn(job);
+        rc = fn(job);
         aio_context_release(ctx);
+        if (rc) {
+            break;
+        }
     }
+    return rc;
 }
 
 static int block_job_finish_sync(BlockJob *job,
@@ -580,6 +594,8 @@ static void block_job_completed_txn_success(BlockJob *job)
 {
     BlockJobTxn *txn = job->txn;
     BlockJob *other_job;
+    int rc = 0;
+
     /*
      * Successful completion, see if there are other running jobs in this
      * txn.
@@ -590,6 +606,14 @@ static void block_job_completed_txn_success(BlockJob *job)
         }
         assert(other_job->ret == 0);
     }
+
+    /* Jobs may require some prep-work to complete without failure */
+    rc = block_job_txn_apply(txn, block_job_prepare);
+    if (rc) {
+        block_job_completed_txn_abort(job);
+        return;
+    }
+
     /* We are the last completed job, commit the transaction. */
     block_job_txn_apply(txn, block_job_completed_single);
 }
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 259d49b32a..642adce68b 100644
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
