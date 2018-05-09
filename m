Received: from eggs.gnu.org ([2001:4830:134:3::10]:52438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwO-0005ek-PP
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwN-0002L2-Gb
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:27:44 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  9 May 2018 18:26:18 +0200
Message-Id: <20180509162637.15575-24-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-1-kwolf@redhat.com>
References: <20180509162637.15575-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 23/42] blockjob: Split block_job_event_pending()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

block_job_event_pending() doesn't only send a QMP event, but it also
transitions to the PENDING state. Split the function so that we get one
part only sending the event (like other block_job_event_* functions) and
another part than does the state transition.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockjob.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 4cfedbe791..de9a789e29 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -38,7 +38,7 @@
 
 static void block_job_event_cancelled(BlockJob *job);
 static void block_job_event_completed(BlockJob *job, const char *msg);
-static int block_job_event_pending(BlockJob *job);
+static void block_job_event_pending(BlockJob *job);
 
 /* Transactional group of block jobs */
 struct BlockJobTxn {
@@ -501,6 +501,15 @@ static void block_job_do_finalize(BlockJob *job)
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
@@ -519,7 +528,7 @@ static void block_job_completed_txn_success(BlockJob *job)
         assert(other_job->ret == 0);
     }
 
-    block_job_txn_apply(txn, block_job_event_pending, false);
+    block_job_txn_apply(txn, block_job_transition_to_pending, false);
 
     /* If no jobs need manual finalization, automatically do so */
     if (block_job_txn_apply(txn, block_job_needs_finalize, false) == 0) {
@@ -734,15 +743,15 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
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
