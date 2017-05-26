Received: from eggs.gnu.org ([2001:4830:134:3::10]:46367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dEKqi-0002dj-6v
	for qemu-devel@nongnu.org; Fri, 26 May 2017 15:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dEKqh-00060k-2B
	for qemu-devel@nongnu.org; Fri, 26 May 2017 15:24:36 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri, 26 May 2017 15:24:03 -0400
Message-Id: <20170526192404.32186-12-jcody@redhat.com>
In-Reply-To: <20170526192404.32186-1-jcody@redhat.com>
References: <20170526192404.32186-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 11/12] blockjob: use deferred_to_main_loop to
 indicate the coroutine has ended
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

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

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20170508141310.8674-12-pbonzini@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 blockjob.c                   | 10 ++++++++--
 include/block/blockjob_int.h |  3 ++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 9a97c73..a0d7e29 100644
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
index 4f2d2ac..f13ad05 100644
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
