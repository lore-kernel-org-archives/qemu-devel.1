Received: from eggs.gnu.org ([2001:4830:134:3::10]:53361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fyJQb-0006Gk-0J
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 12:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fyJQU-00048B-4c
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 12:16:11 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Sep 2018 18:15:11 +0200
Message-Id: <20180907161520.26349-6-kwolf@redhat.com>
In-Reply-To: <20180907161520.26349-1-kwolf@redhat.com>
References: <20180907161520.26349-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 05/14] test-bdrv-drain: Test AIO_WAIT_WHILE()
 in completion callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, qemu-devel@nongnu.org

This is a regression test for a deadlock that occurred in block job
completion callbacks (via job_defer_to_main_loop) because the AioContext
lock was taken twice: once in job_finish_sync() and then again in
job_defer_to_main_loop_bh(). This would cause AIO_WAIT_WHILE() to hang.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-drain.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index ab055e85f8..9641a20dd8 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -776,6 +776,11 @@ typedef struct TestBlockJob {
 
 static void test_job_completed(Job *job, void *opaque)
 {
+    TestBlockJob *s = container_of(job, TestBlockJob, common.job);
+
+    /* Provoke an AIO_WAIT_WHILE() call to verify there is no deadlock */
+    blk_flush(s->common.blk);
+
     job_completed(job, 0, NULL);
 }
 
-- 
2.13.6
