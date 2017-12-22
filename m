Received: from eggs.gnu.org ([2001:4830:134:3::10]:57489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6r-0005yd-4i
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6p-0002cq-V2
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:41 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 22 Dec 2017 16:18:34 +0100
Message-Id: <20171222151846.28110-24-kwolf@redhat.com>
In-Reply-To: <20171222151846.28110-1-kwolf@redhat.com>
References: <20171222151846.28110-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL v3 23/35] test-bdrv-drain: Test drain vs. block
 jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

Block jobs must be paused if any of the involved nodes are drained.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-drain.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 323cb0b961..9783768a20 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "block/block.h"
+#include "block/blockjob_int.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
 
@@ -220,6 +221,123 @@ static void test_quiesce_drain(void)
     test_quiesce_common(BDRV_DRAIN, false);
 }
 
+
+typedef struct TestBlockJob {
+    BlockJob common;
+    bool should_complete;
+} TestBlockJob;
+
+static void test_job_completed(BlockJob *job, void *opaque)
+{
+    block_job_completed(job, 0);
+}
+
+static void coroutine_fn test_job_start(void *opaque)
+{
+    TestBlockJob *s = opaque;
+
+    while (!s->should_complete) {
+        block_job_sleep_ns(&s->common, 100000);
+    }
+
+    block_job_defer_to_main_loop(&s->common, test_job_completed, NULL);
+}
+
+static void test_job_complete(BlockJob *job, Error **errp)
+{
+    TestBlockJob *s = container_of(job, TestBlockJob, common);
+    s->should_complete = true;
+}
+
+BlockJobDriver test_job_driver = {
+    .instance_size  = sizeof(TestBlockJob),
+    .start          = test_job_start,
+    .complete       = test_job_complete,
+};
+
+static void test_blockjob_common(enum drain_type drain_type)
+{
+    BlockBackend *blk_src, *blk_target;
+    BlockDriverState *src, *target;
+    BlockJob *job;
+    int ret;
+
+    src = bdrv_new_open_driver(&bdrv_test, "source", BDRV_O_RDWR,
+                               &error_abort);
+    blk_src = blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk_insert_bs(blk_src, src, &error_abort);
+
+    target = bdrv_new_open_driver(&bdrv_test, "target", BDRV_O_RDWR,
+                                  &error_abort);
+    blk_target = blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk_insert_bs(blk_target, target, &error_abort);
+
+    job = block_job_create("job0", &test_job_driver, src, 0, BLK_PERM_ALL, 0,
+                           0, NULL, NULL, &error_abort);
+    block_job_add_bdrv(job, "target", target, 0, BLK_PERM_ALL, &error_abort);
+    block_job_start(job);
+
+    g_assert_cmpint(job->pause_count, ==, 0);
+    g_assert_false(job->paused);
+    g_assert_false(job->busy); /* We're in block_job_sleep_ns() */
+
+    do_drain_begin(drain_type, src);
+
+    if (drain_type == BDRV_DRAIN_ALL) {
+        /* bdrv_drain_all() drains both src and target, and involves an
+         * additional block_job_pause_all() */
+        g_assert_cmpint(job->pause_count, ==, 3);
+    } else {
+        g_assert_cmpint(job->pause_count, ==, 1);
+    }
+    /* XXX We don't wait until the job is actually paused. Is this okay? */
+    /* g_assert_true(job->paused); */
+    g_assert_false(job->busy); /* The job is paused */
+
+    do_drain_end(drain_type, src);
+
+    g_assert_cmpint(job->pause_count, ==, 0);
+    g_assert_false(job->paused);
+    g_assert_false(job->busy); /* We're in block_job_sleep_ns() */
+
+    do_drain_begin(drain_type, target);
+
+    if (drain_type == BDRV_DRAIN_ALL) {
+        /* bdrv_drain_all() drains both src and target, and involves an
+         * additional block_job_pause_all() */
+        g_assert_cmpint(job->pause_count, ==, 3);
+    } else {
+        g_assert_cmpint(job->pause_count, ==, 1);
+    }
+    /* XXX We don't wait until the job is actually paused. Is this okay? */
+    /* g_assert_true(job->paused); */
+    g_assert_false(job->busy); /* The job is paused */
+
+    do_drain_end(drain_type, target);
+
+    g_assert_cmpint(job->pause_count, ==, 0);
+    g_assert_false(job->paused);
+    g_assert_false(job->busy); /* We're in block_job_sleep_ns() */
+
+    ret = block_job_complete_sync(job, &error_abort);
+    g_assert_cmpint(ret, ==, 0);
+
+    blk_unref(blk_src);
+    blk_unref(blk_target);
+    bdrv_unref(src);
+    bdrv_unref(target);
+}
+
+static void test_blockjob_drain_all(void)
+{
+    test_blockjob_common(BDRV_DRAIN_ALL);
+}
+
+static void test_blockjob_drain(void)
+{
+    test_blockjob_common(BDRV_DRAIN);
+}
+
 int main(int argc, char **argv)
 {
     bdrv_init();
@@ -233,5 +351,8 @@ int main(int argc, char **argv)
     g_test_add_func("/bdrv-drain/quiesce/drain_all", test_quiesce_drain_all);
     g_test_add_func("/bdrv-drain/quiesce/drain", test_quiesce_drain);
 
+    g_test_add_func("/bdrv-drain/blockjob/drain_all", test_blockjob_drain_all);
+    g_test_add_func("/bdrv-drain/blockjob/drain", test_blockjob_drain);
+
     return g_test_run();
 }
-- 
2.13.6
