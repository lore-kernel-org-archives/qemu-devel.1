Received: from eggs.gnu.org ([2001:4830:134:3::10]:46362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dEKqh-0002dX-W1
	for qemu-devel@nongnu.org; Fri, 26 May 2017 15:24:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dEKqh-00060f-16
	for qemu-devel@nongnu.org; Fri, 26 May 2017 15:24:36 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri, 26 May 2017 15:24:02 -0400
Message-Id: <20170526192404.32186-11-jcody@redhat.com>
In-Reply-To: <20170526192404.32186-1-jcody@redhat.com>
References: <20170526192404.32186-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 10/12] blockjob: reorganize
 block_job_completed_txn_abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

This splits the part that touches job states from the part that invokes
callbacks.  It will make the code simpler to understand once job states will
be protected by a different mutex than the AioContext lock.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20170508141310.8674-11-pbonzini@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 blockjob.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index c6ae07d..9a97c73 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -300,6 +300,8 @@ void block_job_start(BlockJob *job)
 
 static void block_job_completed_single(BlockJob *job)
 {
+    assert(job->completed);
+
     if (!job->ret) {
         if (job->driver->commit) {
             job->driver->commit(job);
@@ -361,7 +363,9 @@ static int block_job_finish_sync(BlockJob *job,
 
     block_job_ref(job);
 
-    finish(job, &local_err);
+    if (finish) {
+        finish(job, &local_err);
+    }
     if (local_err) {
         error_propagate(errp, local_err);
         block_job_unref(job);
@@ -385,7 +389,7 @@ static void block_job_completed_txn_abort(BlockJob *job)
 {
     AioContext *ctx;
     BlockJobTxn *txn = job->txn;
-    BlockJob *other_job, *next;
+    BlockJob *other_job;
 
     if (txn->aborting) {
         /*
@@ -394,29 +398,34 @@ static void block_job_completed_txn_abort(BlockJob *job)
         return;
     }
     txn->aborting = true;
+    block_job_txn_ref(txn);
+
     /* We are the first failed job. Cancel other jobs. */
     QLIST_FOREACH(other_job, &txn->jobs, txn_list) {
         ctx = blk_get_aio_context(other_job->blk);
         aio_context_acquire(ctx);
     }
+
+    /* Other jobs are effectively cancelled by us, set the status for
+     * them; this job, however, may or may not be cancelled, depending
+     * on the caller, so leave it. */
     QLIST_FOREACH(other_job, &txn->jobs, txn_list) {
-        if (other_job == job || other_job->completed) {
-            /* Other jobs are "effectively" cancelled by us, set the status for
-             * them; this job, however, may or may not be cancelled, depending
-             * on the caller, so leave it. */
-            if (other_job != job) {
-                block_job_cancel_async(other_job);
-            }
-            continue;
+        if (other_job != job) {
+            block_job_cancel_async(other_job);
         }
-        block_job_cancel_sync(other_job);
-        assert(other_job->completed);
     }
-    QLIST_FOREACH_SAFE(other_job, &txn->jobs, txn_list, next) {
+    while (!QLIST_EMPTY(&txn->jobs)) {
+        other_job = QLIST_FIRST(&txn->jobs);
         ctx = blk_get_aio_context(other_job->blk);
+        if (!other_job->completed) {
+            assert(other_job->cancelled);
+            block_job_finish_sync(other_job, NULL, NULL);
+        }
         block_job_completed_single(other_job);
         aio_context_release(ctx);
     }
+
+    block_job_txn_unref(txn);
 }
 
 static void block_job_completed_txn_success(BlockJob *job)
-- 
2.9.3
