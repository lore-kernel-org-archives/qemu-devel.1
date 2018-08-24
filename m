Received: from eggs.gnu.org ([2001:4830:134:3::10]:56184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ft24x-00042N-JB
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 22:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ft24w-0001YD-Sn
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 22:44:03 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 24 Aug 2018 10:43:42 +0800
Message-Id: <20180824024342.749-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2] job: Fix nested aio_poll() hanging in
 job_txn_apply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, Jeff Cody <jcody@redhat.com>, mreitz@redhat.com, pbonzini@redhat.com, eblake@redhat.com

All callers have acquired ctx already. Doing that again results in
aio_poll() hang. This fixes the problem that a BDRV_POLL_WHILE() in the
callback cannot make progress because ctx is recursively locked, for
example, when drive-backup finishes.

There are two callers of job_finalize():

    fam@lemon:~/work/qemu [master]$ git grep -w -A1 '^\s*job_finalize'
    blockdev.c:    job_finalize(&job->job, errp);
    blockdev.c-    aio_context_release(aio_context);
    --
    job-qmp.c:    job_finalize(job, errp);
    job-qmp.c-    aio_context_release(aio_context);
    --
    tests/test-blockjob.c:    job_finalize(&job->job, &error_abort);
    tests/test-blockjob.c-    assert(job->job.status == JOB_STATUS_CONCLUDED);

Ignoring the test, it's easy to see both callers to job_finalize (and
job_do_finalize) have acquired the context.

Cc: qemu-stable@nongnu.org
Reported-by: Gu Nini <ngu@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>

---

v2: Add Eric's r-b and some more details in commit message.
---
 job.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/job.c b/job.c
index e36ebaafd8..a3bec7fb22 100644
--- a/job.c
+++ b/job.c
@@ -136,21 +136,13 @@ static void job_txn_del_job(Job *job)
     }
 }
 
-static int job_txn_apply(JobTxn *txn, int fn(Job *), bool lock)
+static int job_txn_apply(JobTxn *txn, int fn(Job *))
 {
-    AioContext *ctx;
     Job *job, *next;
     int rc = 0;
 
     QLIST_FOREACH_SAFE(job, &txn->jobs, txn_list, next) {
-        if (lock) {
-            ctx = job->aio_context;
-            aio_context_acquire(ctx);
-        }
         rc = fn(job);
-        if (lock) {
-            aio_context_release(ctx);
-        }
         if (rc) {
             break;
         }
@@ -807,11 +799,11 @@ static void job_do_finalize(Job *job)
     assert(job && job->txn);
 
     /* prepare the transaction to complete */
-    rc = job_txn_apply(job->txn, job_prepare, true);
+    rc = job_txn_apply(job->txn, job_prepare);
     if (rc) {
         job_completed_txn_abort(job);
     } else {
-        job_txn_apply(job->txn, job_finalize_single, true);
+        job_txn_apply(job->txn, job_finalize_single);
     }
 }
 
@@ -857,10 +849,10 @@ static void job_completed_txn_success(Job *job)
         assert(other_job->ret == 0);
     }
 
-    job_txn_apply(txn, job_transition_to_pending, false);
+    job_txn_apply(txn, job_transition_to_pending);
 
     /* If no jobs need manual finalization, automatically do so */
-    if (job_txn_apply(txn, job_needs_finalize, false) == 0) {
+    if (job_txn_apply(txn, job_needs_finalize) == 0) {
         job_do_finalize(job);
     }
 }
-- 
2.17.1
