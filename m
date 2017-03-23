Received: from eggs.gnu.org ([2001:4830:134:3::10]:53957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6i8-0005Vt-T0
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6i8-0002U0-47
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cr6i7-0002Th-UH
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:44 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB5D77AEA1
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 17:39:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Mar 2017 18:39:28 +0100
Message-Id: <20170323173928.14439-11-pbonzini@redhat.com>
In-Reply-To: <20170323173928.14439-1-pbonzini@redhat.com>
References: <20170323173928.14439-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 10/10] blockjob: use deferred_to_main_loop to
 indicate the coroutine has ended
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

All block jobs are using block_job_defer_to_main_loop as the final
step just before the coroutine terminates.  At this point,
block_job_enter should do nothing, but currently it restarts
the freed coroutine.

Now, the job->co states should probably be changed to an enum
(e.g. BEFORE_START, STARTED, YIELDED, COMPLETED) subsuming
block_job_started, job->deferred_to_main_loop and job->busy.
For now, this patch eliminates the problematic reenter by
removing the reset of job->deferred_to_main_loop (which served
no purpose, as far as I could see) and checking the flag in
block_job_enter.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 blockjob.c                   | 10 ++++++++--
 include/block/blockjob_int.h |  3 ++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 3fa2885..2d80dae 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -750,7 +750,14 @@ void block_job_resume_all(void)
 
 void block_job_enter(BlockJob *job)
 {
-    if (job->co && !job->busy) {
+    if (!block_job_started(job)) {
+        return;
+    }
+    if (job->deferred_to_main_loop) {
+        return;
+    }
+
+    if (!job->busy) {
         qemu_coroutine_enter(job->co);
     }
 }
@@ -874,7 +881,6 @@ static void block_job_defer_to_main_loop_bh(void *opaque)
         aio_context_acquire(aio_context);
     }
 
-    data->job->deferred_to_main_loop = false;
     data->fn(data->job, data->opaque);
 
     if (aio_context != data->aio_context) {
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 97ffc43..4d287ba 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -227,7 +227,8 @@ typedef void BlockJobDeferToMainLoopFn(BlockJob *job, void *opaque);
  * @fn: The function to run in the main loop
  * @opaque: The opaque value that is passed to @fn
  *
- * Execute a given function in the main loop with the BlockDriverState
+ * This function must be called by the main job coroutine just before it
+ * returns.  @fn is executed in the main loop with the BlockDriverState
  * AioContext acquired.  Block jobs must call bdrv_unref(), bdrv_close(), and
  * anything that uses bdrv_drain_all() in the main loop.
  *
-- 
2.9.3
