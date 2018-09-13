Received: from eggs.gnu.org ([2001:4830:134:3::10]:46802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7G-0002MT-4y
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7F-0001uD-Br
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:02 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Sep 2018 14:52:07 +0200
Message-Id: <20180913125217.23173-8-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-1-kwolf@redhat.com>
References: <20180913125217.23173-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/17] test-bdrv-drain: Test
 AIO_WAIT_WHILE() in completion callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

This is a regression test for a deadlock that occurred in block job
completion callbacks (via job_defer_to_main_loop) because the AioContext
lock was taken twice: once in job_finish_sync() and then again in
job_defer_to_main_loop_bh(). This would cause AIO_WAIT_WHILE() to hang.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 tests/test-bdrv-drain.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 57da22a096..c3c17b9ff7 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -774,6 +774,15 @@ typedef struct TestBlockJob {
     bool should_complete;
 } TestBlockJob;
 
+static int test_job_prepare(Job *job)
+{
+    TestBlockJob *s = container_of(job, TestBlockJob, common.job);
+
+    /* Provoke an AIO_WAIT_WHILE() call to verify there is no deadlock */
+    blk_flush(s->common.blk);
+    return 0;
+}
+
 static int coroutine_fn test_job_run(Job *job, Error **errp)
 {
     TestBlockJob *s = container_of(job, TestBlockJob, common.job);
@@ -804,6 +813,7 @@ BlockJobDriver test_job_driver = {
         .drain          = block_job_drain,
         .run            = test_job_run,
         .complete       = test_job_complete,
+        .prepare        = test_job_prepare,
     },
 };
 
-- 
2.13.6
