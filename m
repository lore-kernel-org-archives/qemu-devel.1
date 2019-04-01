Received: from eggs.gnu.org ([209.51.188.92]:40805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44X-0001Jx-2j
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44V-0003NJ-5P
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50602
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44U-0003Ha-Rq
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:23 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1raU095864
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:13 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkswegwck-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:13 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:11 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:10 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-37-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 36/97] job: Fix nested aio_poll() hanging in
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
Cc: qemu-stable@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: Fam Zheng <famz@redhat.com>

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
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 49880165a44f26dc84651858750facdee31f2513)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
