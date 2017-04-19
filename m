Received: from eggs.gnu.org ([2001:4830:134:3::10]:34306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoU-0004bY-35
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoT-0001XB-B5
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d0qoT-0001Wl-1a
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:33 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F37E315567
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 14:42:31 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-118-57.ams2.redhat.com
	[10.36.118.57] (may be forged))
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v3JEgK5J001048
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 10:42:31 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Apr 2017 16:42:18 +0200
Message-Id: <20170419144219.20371-11-pbonzini@redhat.com>
In-Reply-To: <20170419144219.20371-1-pbonzini@redhat.com>
References: <20170419144219.20371-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 10/11] blockjob: reorganize
 block_job_completed_txn_abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This splits the part that touches job states from the part that invokes
callbacks.  It will make the code simpler to understand once job states will
be protected by a different mutex than the AioContext lock.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 blockjob.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 5d70d25..e8b6247 100644
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
