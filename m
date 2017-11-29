Received: from eggs.gnu.org ([2001:4830:134:3::10]:54456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK4GJ-0002u5-Ls
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:27:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK4GI-0007dS-Q8
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:26:59 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 29 Nov 2017 16:26:26 +0100
Message-Id: <20171129152628.14906-9-kwolf@redhat.com>
In-Reply-To: <20171129152628.14906-1-kwolf@redhat.com>
References: <20171129152628.14906-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 08/10] blockjob: introduce block_job_do_yield
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

Hide the clearing of job->busy in a single function, and set it
in block_job_enter.  This lets block_job_do_yield verify that
qemu_coroutine_enter is not used while job->busy = false.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-By: Jeff Cody <jcody@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockjob.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index db9e4fc89a..4d22b7d2fb 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -729,6 +729,15 @@ static bool block_job_should_pause(BlockJob *job)
     return job->pause_count > 0;
 }
 
+static void block_job_do_yield(BlockJob *job)
+{
+    job->busy = false;
+    qemu_coroutine_yield();
+
+    /* Set by block_job_enter before re-entering the coroutine.  */
+    assert(job->busy);
+}
+
 void coroutine_fn block_job_pause_point(BlockJob *job)
 {
     assert(job && block_job_started(job));
@@ -746,9 +755,7 @@ void coroutine_fn block_job_pause_point(BlockJob *job)
 
     if (block_job_should_pause(job) && !block_job_is_cancelled(job)) {
         job->paused = true;
-        job->busy = false;
-        qemu_coroutine_yield(); /* wait for block_job_resume() */
-        job->busy = true;
+        block_job_do_yield(job);
         job->paused = false;
     }
 
@@ -778,9 +785,12 @@ void block_job_enter(BlockJob *job)
         return;
     }
 
-    if (!job->busy) {
-        bdrv_coroutine_enter(blk_bs(job->blk), job->co);
+    if (job->busy) {
+        return;
     }
+
+    job->busy = true;
+    aio_co_wake(job->co);
 }
 
 bool block_job_is_cancelled(BlockJob *job)
@@ -819,11 +829,9 @@ void block_job_yield(BlockJob *job)
         return;
     }
 
-    job->busy = false;
     if (!block_job_should_pause(job)) {
-        qemu_coroutine_yield();
+        block_job_do_yield(job);
     }
-    job->busy = true;
 
     block_job_pause_point(job);
 }
-- 
2.13.6
