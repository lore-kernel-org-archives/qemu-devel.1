Received: from eggs.gnu.org ([2001:4830:134:3::10]:34326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoV-0004cp-5v
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoU-0001XY-5o
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d0qoT-0001XD-VK
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:34 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3F032D8E8E
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 14:42:32 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-118-57.ams2.redhat.com
	[10.36.118.57] (may be forged))
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v3JEgK5K001048
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 10:42:32 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Apr 2017 16:42:19 +0200
Message-Id: <20170419144219.20371-12-pbonzini@redhat.com>
In-Reply-To: <20170419144219.20371-1-pbonzini@redhat.com>
References: <20170419144219.20371-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 11/11] blockjob: use deferred_to_main_loop to
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
index e8b6247..295478d 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -771,7 +771,14 @@ void block_job_resume_all(void)
 
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
         bdrv_coroutine_enter(blk_bs(job->blk), job->co);
     }
 }
@@ -899,7 +906,6 @@ static void block_job_defer_to_main_loop_bh(void *opaque)
         aio_context_acquire(aio_context);
     }
 
-    data->job->deferred_to_main_loop = false;
     data->fn(data->job, data->opaque);
 
     if (aio_context != data->aio_context) {
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index cbf984b..a9751a7 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -241,7 +241,8 @@ typedef void BlockJobDeferToMainLoopFn(BlockJob *job, void *opaque);
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
