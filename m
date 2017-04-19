Received: from eggs.gnu.org ([2001:4830:134:3::10]:34282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoS-0004Ze-IS
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoR-0001WB-Du
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d0qoR-0001VV-5k
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:31 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 194A880503
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 14:42:30 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-118-57.ams2.redhat.com
	[10.36.118.57] (may be forged))
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v3JEgK5H001048
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 10:42:29 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Apr 2017 16:42:16 +0200
Message-Id: <20170419144219.20371-9-pbonzini@redhat.com>
In-Reply-To: <20170419144219.20371-1-pbonzini@redhat.com>
References: <20170419144219.20371-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 08/11] blockjob: group BlockJob transaction
 functions together
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Yet another pure code movement patch, preparing for the next change.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        v1->v2: split out of block_job_completed_txn_abort patch [John]

 blockjob.c | 128 ++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 1756153..5d70d25 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -91,6 +91,39 @@ BlockJob *block_job_get(const char *id)
     return NULL;
 }
 
+BlockJobTxn *block_job_txn_new(void)
+{
+    BlockJobTxn *txn = g_new0(BlockJobTxn, 1);
+    QLIST_INIT(&txn->jobs);
+    txn->refcnt = 1;
+    return txn;
+}
+
+static void block_job_txn_ref(BlockJobTxn *txn)
+{
+    txn->refcnt++;
+}
+
+void block_job_txn_unref(BlockJobTxn *txn)
+{
+    if (txn && --txn->refcnt == 0) {
+        g_free(txn);
+    }
+}
+
+void block_job_txn_add_job(BlockJobTxn *txn, BlockJob *job)
+{
+    if (!txn) {
+        return;
+    }
+
+    assert(!job->txn);
+    job->txn = txn;
+
+    QLIST_INSERT_HEAD(&txn->jobs, job, txn_list);
+    block_job_txn_ref(txn);
+}
+
 static void block_job_pause(BlockJob *job)
 {
     job->pause_count++;
@@ -317,6 +350,37 @@ static void block_job_cancel_async(BlockJob *job)
     job->cancelled = true;
 }
 
+static int block_job_finish_sync(BlockJob *job,
+                                 void (*finish)(BlockJob *, Error **errp),
+                                 Error **errp)
+{
+    Error *local_err = NULL;
+    int ret;
+
+    assert(blk_bs(job->blk)->job == job);
+
+    block_job_ref(job);
+
+    finish(job, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        block_job_unref(job);
+        return -EBUSY;
+    }
+    /* block_job_drain calls block_job_enter, and it should be enough to
+     * induce progress until the job completes or moves to the main thread.
+    */
+    while (!job->deferred_to_main_loop && !job->completed) {
+        block_job_drain(job);
+    }
+    while (!job->completed) {
+        aio_poll(qemu_get_aio_context(), true);
+    }
+    ret = (job->cancelled && job->ret == 0) ? -ECANCELED : job->ret;
+    block_job_unref(job);
+    return ret;
+}
+
 static void block_job_completed_txn_abort(BlockJob *job)
 {
     AioContext *ctx;
@@ -440,37 +504,6 @@ void block_job_cancel(BlockJob *job)
     }
 }
 
-static int block_job_finish_sync(BlockJob *job,
-                                 void (*finish)(BlockJob *, Error **errp),
-                                 Error **errp)
-{
-    Error *local_err = NULL;
-    int ret;
-
-    assert(blk_bs(job->blk)->job == job);
-
-    block_job_ref(job);
-
-    finish(job, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        block_job_unref(job);
-        return -EBUSY;
-    }
-    /* block_job_drain calls block_job_enter, and it should be enough to
-     * induce progress until the job completes or moves to the main thread.
-    */
-    while (!job->deferred_to_main_loop && !job->completed) {
-        block_job_drain(job);
-    }
-    while (!job->completed) {
-        aio_poll(qemu_get_aio_context(), true);
-    }
-    ret = (job->cancelled && job->ret == 0) ? -ECANCELED : job->ret;
-    block_job_unref(job);
-    return ret;
-}
-
 /* A wrapper around block_job_cancel() taking an Error ** parameter so it may be
  * used with block_job_finish_sync() without the need for (rather nasty)
  * function pointer casts there. */
@@ -883,36 +916,3 @@ void block_job_defer_to_main_loop(BlockJob *job,
     aio_bh_schedule_oneshot(qemu_get_aio_context(),
                             block_job_defer_to_main_loop_bh, data);
 }
-
-BlockJobTxn *block_job_txn_new(void)
-{
-    BlockJobTxn *txn = g_new0(BlockJobTxn, 1);
-    QLIST_INIT(&txn->jobs);
-    txn->refcnt = 1;
-    return txn;
-}
-
-static void block_job_txn_ref(BlockJobTxn *txn)
-{
-    txn->refcnt++;
-}
-
-void block_job_txn_unref(BlockJobTxn *txn)
-{
-    if (txn && --txn->refcnt == 0) {
-        g_free(txn);
-    }
-}
-
-void block_job_txn_add_job(BlockJobTxn *txn, BlockJob *job)
-{
-    if (!txn) {
-        return;
-    }
-
-    assert(!job->txn);
-    job->txn = txn;
-
-    QLIST_INSERT_HEAD(&txn->jobs, job, txn_list);
-    block_job_txn_ref(txn);
-}
-- 
2.9.3
