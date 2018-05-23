Received: from eggs.gnu.org ([2001:4830:134:3::10]:53015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZE-00020a-96
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZ7-00074j-BV
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:33 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 23 May 2018 15:11:33 +0200
Message-Id: <20180523131155.12359-25-kwolf@redhat.com>
In-Reply-To: <20180523131155.12359-1-kwolf@redhat.com>
References: <20180523131155.12359-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 24/46] blockjob: Split block_job_event_pending()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

block_job_event_pending() doesn't only send a QMP event, but it also
transitions to the PENDING state. Split the function so that we get one
part only sending the event (like other block_job_event_* functions) and
another part that does the state transition.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 blockjob.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index d9d8ff7f5c..b4334fb1bf 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -38,7 +38,7 @@
 
 static void block_job_event_cancelled(BlockJob *job);
 static void block_job_event_completed(BlockJob *job, const char *msg);
-static int block_job_event_pending(BlockJob *job);
+static void block_job_event_pending(BlockJob *job);
 
 /* Transactional group of block jobs */
 struct BlockJobTxn {
@@ -500,6 +500,15 @@ static void block_job_do_finalize(BlockJob *job)
     }
 }
 
+static int block_job_transition_to_pending(BlockJob *job)
+{
+    job_state_transition(&job->job, JOB_STATUS_PENDING);
+    if (!job->job.auto_finalize) {
+        block_job_event_pending(job);
+    }
+    return 0;
+}
+
 static void block_job_completed_txn_success(BlockJob *job)
 {
     BlockJobTxn *txn = job->txn;
@@ -518,7 +527,7 @@ static void block_job_completed_txn_success(BlockJob *job)
         assert(other_job->ret == 0);
     }
 
-    block_job_txn_apply(txn, block_job_event_pending, false);
+    block_job_txn_apply(txn, block_job_transition_to_pending, false);
 
     /* If no jobs need manual finalization, automatically do so */
     if (block_job_txn_apply(txn, block_job_needs_finalize, false) == 0) {
@@ -733,15 +742,15 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
                                         &error_abort);
 }
 
-static int block_job_event_pending(BlockJob *job)
+static void block_job_event_pending(BlockJob *job)
 {
-    job_state_transition(&job->job, JOB_STATUS_PENDING);
-    if (!job->job.auto_finalize && !block_job_is_internal(job)) {
-        qapi_event_send_block_job_pending(job_type(&job->job),
-                                          job->job.id,
-                                          &error_abort);
+    if (block_job_is_internal(job)) {
+        return;
     }
-    return 0;
+
+    qapi_event_send_block_job_pending(job_type(&job->job),
+                                      job->job.id,
+                                      &error_abort);
 }
 
 /*
-- 
2.13.6
