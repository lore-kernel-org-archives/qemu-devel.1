Received: from eggs.gnu.org ([2001:4830:134:3::10]:47244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7o-0002pE-LN
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7n-0002Tk-Py
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:36 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Sep 2018 14:52:16 +0200
Message-Id: <20180913125217.23173-17-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-1-kwolf@redhat.com>
References: <20180913125217.23173-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 16/17] job: Avoid deadlocks in
 job_completed_txn_abort()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

Amongst others, job_finalize_single() calls the .prepare/.commit/.abort
callbacks of the individual job driver. Recently, their use was adapted
for all block jobs so that they involve code calling AIO_WAIT_WHILE()
now. Such code must be called under the AioContext lock for the
respective job, but without holding any other AioContext lock.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 job.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/job.c b/job.c
index 00a1cd128d..0b021867da 100644
--- a/job.c
+++ b/job.c
@@ -718,6 +718,7 @@ static void job_cancel_async(Job *job, bool force)
 
 static void job_completed_txn_abort(Job *job)
 {
+    AioContext *outer_ctx = job->aio_context;
     AioContext *ctx;
     JobTxn *txn = job->txn;
     Job *other_job;
@@ -731,23 +732,26 @@ static void job_completed_txn_abort(Job *job)
     txn->aborting = true;
     job_txn_ref(txn);
 
-    /* We are the first failed job. Cancel other jobs. */
-    QLIST_FOREACH(other_job, &txn->jobs, txn_list) {
-        ctx = other_job->aio_context;
-        aio_context_acquire(ctx);
-    }
+    /* We can only hold the single job's AioContext lock while calling
+     * job_finalize_single() because the finalization callbacks can involve
+     * calls of AIO_WAIT_WHILE(), which could deadlock otherwise. */
+    aio_context_release(outer_ctx);
 
     /* Other jobs are effectively cancelled by us, set the status for
      * them; this job, however, may or may not be cancelled, depending
      * on the caller, so leave it. */
     QLIST_FOREACH(other_job, &txn->jobs, txn_list) {
         if (other_job != job) {
+            ctx = other_job->aio_context;
+            aio_context_acquire(ctx);
             job_cancel_async(other_job, false);
+            aio_context_release(ctx);
         }
     }
     while (!QLIST_EMPTY(&txn->jobs)) {
         other_job = QLIST_FIRST(&txn->jobs);
         ctx = other_job->aio_context;
+        aio_context_acquire(ctx);
         if (!job_is_completed(other_job)) {
             assert(job_is_cancelled(other_job));
             job_finish_sync(other_job, NULL, NULL);
@@ -756,6 +760,8 @@ static void job_completed_txn_abort(Job *job)
         aio_context_release(ctx);
     }
 
+    aio_context_acquire(outer_ctx);
+
     job_txn_unref(txn);
 }
 
-- 
2.13.6
