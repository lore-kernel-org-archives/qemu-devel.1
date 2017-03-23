Received: from eggs.gnu.org ([2001:4830:134:3::10]:53861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6i2-0005Qz-LU
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6i1-0002Rh-Gz
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cr6i1-0002RP-7O
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:37 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3CD232560
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 17:39:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Mar 2017 18:39:23 +0100
Message-Id: <20170323173928.14439-6-pbonzini@redhat.com>
In-Reply-To: <20170323173928.14439-1-pbonzini@redhat.com>
References: <20170323173928.14439-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 05/10] blockjob: separate monitor and blockjob
 APIs
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

We already have different locking policies for APIs called by the monitor
and the block job.  Monitor APIs need consistency across block_job_get
and the actual operation (e.g. block_job_set_speed), so currently there
are explicit aio_context_acquire/release calls in blockdev.c.

When a block job needs to do something instead it doesn't care about locking,
because the whole coroutine runs under the AioContext lock.  When moving
away from the AioContext lock, the monitor will have to call new
block_job_lock/unlock APIs, while blockjob APIs will take care of this
for the users.

In preparation for that, keep all the blockjob APIs together in the
blockjob.c file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 blockjob.c | 206 +++++++++++++++++++++++++++++++------------------------------
 1 file changed, 105 insertions(+), 101 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index caca718..c5f1d19 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -334,11 +334,6 @@ void block_job_start(BlockJob *job)
     qemu_coroutine_enter(job->co);
 }
 
-void block_job_fail(BlockJob *job)
-{
-    block_job_unref(job);
-}
-
 static void block_job_completed_single(BlockJob *job)
 {
     if (!job->ret) {
@@ -440,21 +435,6 @@ static void block_job_completed_txn_success(BlockJob *job)
     }
 }
 
-void block_job_completed(BlockJob *job, int ret)
-{
-    assert(blk_bs(job->blk)->job == job);
-    assert(!job->completed);
-    job->completed = true;
-    job->ret = ret;
-    if (!job->txn) {
-        block_job_completed_single(job);
-    } else if (ret < 0 || block_job_is_cancelled(job)) {
-        block_job_completed_txn_abort(job);
-    } else {
-        block_job_completed_txn_success(job);
-    }
-}
-
 void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
 {
     Error *local_err = NULL;
@@ -492,44 +472,11 @@ void block_job_user_pause(BlockJob *job)
     block_job_pause(job);
 }
 
-static bool block_job_should_pause(BlockJob *job)
-{
-    return job->pause_count > 0;
-}
-
 bool block_job_user_paused(BlockJob *job)
 {
     return job->user_paused;
 }
 
-void coroutine_fn block_job_pause_point(BlockJob *job)
-{
-    assert(job && block_job_started(job));
-
-    if (!block_job_should_pause(job)) {
-        return;
-    }
-    if (block_job_is_cancelled(job)) {
-        return;
-    }
-
-    if (job->driver->pause) {
-        job->driver->pause(job);
-    }
-
-    if (block_job_should_pause(job) && !block_job_is_cancelled(job)) {
-        job->paused = true;
-        job->busy = false;
-        qemu_coroutine_yield(); /* wait for block_job_resume() */
-        job->busy = true;
-        job->paused = false;
-    }
-
-    if (job->driver->resume) {
-        job->driver->resume(job);
-    }
-}
-
 void block_job_user_resume(BlockJob *job)
 {
     if (job && job->user_paused && job->pause_count > 0) {
@@ -538,13 +485,6 @@ void block_job_user_resume(BlockJob *job)
     }
 }
 
-void block_job_enter(BlockJob *job)
-{
-    if (job->co && !job->busy) {
-        qemu_coroutine_enter(job->co);
-    }
-}
-
 void block_job_cancel(BlockJob *job)
 {
     if (block_job_started(job)) {
@@ -556,11 +496,6 @@ void block_job_cancel(BlockJob *job)
     }
 }
 
-bool block_job_is_cancelled(BlockJob *job)
-{
-    return job->cancelled;
-}
-
 void block_job_iostatus_reset(BlockJob *job)
 {
     job->iostatus = BLOCK_DEVICE_IO_STATUS_OK;
@@ -628,42 +563,6 @@ int block_job_complete_sync(BlockJob *job, Error **errp)
     return block_job_finish_sync(job, &block_job_complete, errp);
 }
 
-void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns)
-{
-    assert(job->busy);
-
-    /* Check cancellation *before* setting busy = false, too!  */
-    if (block_job_is_cancelled(job)) {
-        return;
-    }
-
-    job->busy = false;
-    if (!block_job_should_pause(job)) {
-        co_aio_sleep_ns(blk_get_aio_context(job->blk), type, ns);
-    }
-    job->busy = true;
-
-    block_job_pause_point(job);
-}
-
-void block_job_yield(BlockJob *job)
-{
-    assert(job->busy);
-
-    /* Check cancellation *before* setting busy = false, too!  */
-    if (block_job_is_cancelled(job)) {
-        return;
-    }
-
-    job->busy = false;
-    if (!block_job_should_pause(job)) {
-        qemu_coroutine_yield();
-    }
-    job->busy = true;
-
-    block_job_pause_point(job);
-}
-
 BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
 {
     BlockJobInfo *info;
@@ -723,6 +622,10 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
                                         &error_abort);
 }
 
+/*
+ * API for block job drivers and the block layer.
+ */
+
 void block_job_pause_all(void)
 {
     BlockJob *job = NULL;
@@ -735,6 +638,59 @@ void block_job_pause_all(void)
     }
 }
 
+void block_job_fail(BlockJob *job)
+{
+    block_job_unref(job);
+}
+
+void block_job_completed(BlockJob *job, int ret)
+{
+    assert(blk_bs(job->blk)->job == job);
+    assert(!job->completed);
+    job->completed = true;
+    job->ret = ret;
+    if (!job->txn) {
+        block_job_completed_single(job);
+    } else if (ret < 0 || block_job_is_cancelled(job)) {
+        block_job_completed_txn_abort(job);
+    } else {
+        block_job_completed_txn_success(job);
+    }
+}
+
+static bool block_job_should_pause(BlockJob *job)
+{
+    return job->pause_count > 0;
+}
+
+void coroutine_fn block_job_pause_point(BlockJob *job)
+{
+    assert(job && block_job_started(job));
+
+    if (!block_job_should_pause(job)) {
+        return;
+    }
+    if (block_job_is_cancelled(job)) {
+        return;
+    }
+
+    if (job->driver->pause) {
+        job->driver->pause(job);
+    }
+
+    if (block_job_should_pause(job) && !block_job_is_cancelled(job)) {
+        job->paused = true;
+        job->busy = false;
+        qemu_coroutine_yield(); /* wait for block_job_resume() */
+        job->busy = true;
+        job->paused = false;
+    }
+
+    if (job->driver->resume) {
+        job->driver->resume(job);
+    }
+}
+
 void block_job_resume_all(void)
 {
     BlockJob *job = NULL;
@@ -747,6 +703,54 @@ void block_job_resume_all(void)
     }
 }
 
+void block_job_enter(BlockJob *job)
+{
+    if (job->co && !job->busy) {
+        qemu_coroutine_enter(job->co);
+    }
+}
+
+bool block_job_is_cancelled(BlockJob *job)
+{
+    return job->cancelled;
+}
+
+void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns)
+{
+    assert(job->busy);
+
+    /* Check cancellation *before* setting busy = false, too!  */
+    if (block_job_is_cancelled(job)) {
+        return;
+    }
+
+    job->busy = false;
+    if (!block_job_should_pause(job)) {
+        co_aio_sleep_ns(blk_get_aio_context(job->blk), type, ns);
+    }
+    job->busy = true;
+
+    block_job_pause_point(job);
+}
+
+void block_job_yield(BlockJob *job)
+{
+    assert(job->busy);
+
+    /* Check cancellation *before* setting busy = false, too!  */
+    if (block_job_is_cancelled(job)) {
+        return;
+    }
+
+    job->busy = false;
+    if (!block_job_should_pause(job)) {
+        qemu_coroutine_yield();
+    }
+    job->busy = true;
+
+    block_job_pause_point(job);
+}
+
 void block_job_event_ready(BlockJob *job)
 {
     job->ready = true;
-- 
2.9.3
