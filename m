Received: from eggs.gnu.org ([2001:4830:134:3::10]:53607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrL-0002Oy-36
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrI-0000Br-RL
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:06 -0500
From: John Snow <jsnow@redhat.com>
Date: Sat, 10 Mar 2018 03:27:39 -0500
Message-Id: <20180310082746.24198-15-jsnow@redhat.com>
In-Reply-To: <20180310082746.24198-1-jsnow@redhat.com>
References: <20180310082746.24198-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 14/21] blockjobs: add block_job_txn_apply
 function
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

Simply apply a function transaction-wide.
A few more uses of this in forthcoming patches.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 0c64fadc6d..7e03824751 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -487,6 +487,19 @@ static void block_job_cancel_async(BlockJob *job)
     job->cancelled = true;
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
 static int block_job_finish_sync(BlockJob *job,
                                  void (*finish)(BlockJob *, Error **errp),
                                  Error **errp)
@@ -565,9 +578,8 @@ static void block_job_completed_txn_abort(BlockJob *job)
 
 static void block_job_completed_txn_success(BlockJob *job)
 {
-    AioContext *ctx;
     BlockJobTxn *txn = job->txn;
-    BlockJob *other_job, *next;
+    BlockJob *other_job;
     /*
      * Successful completion, see if there are other running jobs in this
      * txn.
@@ -576,15 +588,10 @@ static void block_job_completed_txn_success(BlockJob *job)
         if (!other_job->completed) {
             return;
         }
-    }
-    /* We are the last completed job, commit the transaction. */
-    QLIST_FOREACH_SAFE(other_job, &txn->jobs, txn_list, next) {
-        ctx = blk_get_aio_context(other_job->blk);
-        aio_context_acquire(ctx);
         assert(other_job->ret == 0);
-        block_job_completed_single(other_job);
-        aio_context_release(ctx);
     }
+    /* We are the last completed job, commit the transaction. */
+    block_job_txn_apply(txn, block_job_completed_single);
 }
 
 /* Assumes the block_job_mutex is held */
-- 
2.14.3
