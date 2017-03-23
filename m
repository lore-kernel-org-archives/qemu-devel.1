Received: from eggs.gnu.org ([2001:4830:134:3::10]:53927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6i7-0005Uy-WE
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6i6-0002TR-SV
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cr6i6-0002TE-Jm
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:42 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E6587AEA4
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 17:39:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Mar 2017 18:39:27 +0100
Message-Id: <20170323173928.14439-10-pbonzini@redhat.com>
In-Reply-To: <20170323173928.14439-1-pbonzini@redhat.com>
References: <20170323173928.14439-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 09/10] blockjob: reorganize
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
Cc: jcody@redhat.com, jsnow@redhat.com

This splits the part that touches job states from the part that invokes
callbacks.  It will be a bit simpler to understand once job states will
be protected by a different mutex than the AioContext lock.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 blockjob.c | 165 ++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 88 insertions(+), 77 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 093962b..3fa2885 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -76,6 +76,39 @@ BlockJob *block_job_get(const char *id)
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
@@ -336,6 +369,8 @@ void block_job_start(BlockJob *job)
 
 static void block_job_completed_single(BlockJob *job)
 {
+    assert(job->completed);
+
     if (!job->ret) {
         if (job->driver->commit) {
             job->driver->commit(job);
@@ -376,14 +411,49 @@ static void block_job_completed_single(BlockJob *job)
 static void block_job_cancel_async(BlockJob *job)
 {
     job->cancelled = true;
-    block_job_iostatus_reset(job);
+    if (!job->completed) {
+        block_job_iostatus_reset(job);
+    }
+}
+
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
+    if (finish) {
+        finish(job, &local_err);
+    }
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
 }
 
 static void block_job_completed_txn_abort(BlockJob *job)
 {
     AioContext *ctx;
     BlockJobTxn *txn = job->txn;
-    BlockJob *other_job, *next;
+    BlockJob *other_job;
 
     if (txn->aborting) {
         /*
@@ -392,29 +462,34 @@ static void block_job_completed_txn_abort(BlockJob *job)
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
+    /* Other jobs are "effectively" cancelled by us, set the status for
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
@@ -502,37 +577,6 @@ void block_job_cancel(BlockJob *job)
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
@@ -856,36 +900,3 @@ void block_job_defer_to_main_loop(BlockJob *job,
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
