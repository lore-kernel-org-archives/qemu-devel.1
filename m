Received: from eggs.gnu.org ([2001:4830:134:3::10]:47254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7p-0002q7-D2
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7o-0002U1-4E
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:37 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Sep 2018 14:52:17 +0200
Message-Id: <20180913125217.23173-18-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-1-kwolf@redhat.com>
References: <20180913125217.23173-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 17/17] test-bdrv-drain: AIO_WAIT_WHILE() in
 job .commit/.abort
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

This adds tests for calling AIO_WAIT_WHILE() in the .commit and .abort
callbacks. Both reasons why .abort could be called for a single job are
tested: Either .run or .prepare could return an error.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-drain.c | 116 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 104 insertions(+), 12 deletions(-)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index e105c0ae84..bbc56a055f 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -784,6 +784,8 @@ static void test_iothread_drain_subtree(void)
 
 typedef struct TestBlockJob {
     BlockJob common;
+    int run_ret;
+    int prepare_ret;
     bool should_complete;
 } TestBlockJob;
 
@@ -793,7 +795,23 @@ static int test_job_prepare(Job *job)
 
     /* Provoke an AIO_WAIT_WHILE() call to verify there is no deadlock */
     blk_flush(s->common.blk);
-    return 0;
+    return s->prepare_ret;
+}
+
+static void test_job_commit(Job *job)
+{
+    TestBlockJob *s = container_of(job, TestBlockJob, common.job);
+
+    /* Provoke an AIO_WAIT_WHILE() call to verify there is no deadlock */
+    blk_flush(s->common.blk);
+}
+
+static void test_job_abort(Job *job)
+{
+    TestBlockJob *s = container_of(job, TestBlockJob, common.job);
+
+    /* Provoke an AIO_WAIT_WHILE() call to verify there is no deadlock */
+    blk_flush(s->common.blk);
 }
 
 static int coroutine_fn test_job_run(Job *job, Error **errp)
@@ -809,7 +827,7 @@ static int coroutine_fn test_job_run(Job *job, Error **errp)
         job_pause_point(&s->common.job);
     }
 
-    return 0;
+    return s->run_ret;
 }
 
 static void test_job_complete(Job *job, Error **errp)
@@ -827,14 +845,24 @@ BlockJobDriver test_job_driver = {
         .run            = test_job_run,
         .complete       = test_job_complete,
         .prepare        = test_job_prepare,
+        .commit         = test_job_commit,
+        .abort          = test_job_abort,
     },
 };
 
-static void test_blockjob_common(enum drain_type drain_type, bool use_iothread)
+enum test_job_result {
+    TEST_JOB_SUCCESS,
+    TEST_JOB_FAIL_RUN,
+    TEST_JOB_FAIL_PREPARE,
+};
+
+static void test_blockjob_common(enum drain_type drain_type, bool use_iothread,
+                                 enum test_job_result result)
 {
     BlockBackend *blk_src, *blk_target;
     BlockDriverState *src, *target;
     BlockJob *job;
+    TestBlockJob *tjob;
     IOThread *iothread = NULL;
     AioContext *ctx;
     int ret;
@@ -858,9 +886,23 @@ static void test_blockjob_common(enum drain_type drain_type, bool use_iothread)
     blk_insert_bs(blk_target, target, &error_abort);
 
     aio_context_acquire(ctx);
-    job = block_job_create("job0", &test_job_driver, NULL, src, 0, BLK_PERM_ALL,
-                           0, 0, NULL, NULL, &error_abort);
+    tjob = block_job_create("job0", &test_job_driver, NULL, src,
+                            0, BLK_PERM_ALL,
+                            0, 0, NULL, NULL, &error_abort);
+    job = &tjob->common;
     block_job_add_bdrv(job, "target", target, 0, BLK_PERM_ALL, &error_abort);
+
+    switch (result) {
+    case TEST_JOB_SUCCESS:
+        break;
+    case TEST_JOB_FAIL_RUN:
+        tjob->run_ret = -EIO;
+        break;
+    case TEST_JOB_FAIL_PREPARE:
+        tjob->prepare_ret = -EIO;
+        break;
+    }
+
     job_start(&job->job);
     aio_context_release(ctx);
 
@@ -918,7 +960,7 @@ static void test_blockjob_common(enum drain_type drain_type, bool use_iothread)
 
     aio_context_acquire(ctx);
     ret = job_complete_sync(&job->job, &error_abort);
-    g_assert_cmpint(ret, ==, 0);
+    g_assert_cmpint(ret, ==, (result == TEST_JOB_SUCCESS ? 0 : -EIO));
 
     if (use_iothread) {
         blk_set_aio_context(blk_src, qemu_get_aio_context());
@@ -937,32 +979,68 @@ static void test_blockjob_common(enum drain_type drain_type, bool use_iothread)
 
 static void test_blockjob_drain_all(void)
 {
-    test_blockjob_common(BDRV_DRAIN_ALL, false);
+    test_blockjob_common(BDRV_DRAIN_ALL, false, TEST_JOB_SUCCESS);
 }
 
 static void test_blockjob_drain(void)
 {
-    test_blockjob_common(BDRV_DRAIN, false);
+    test_blockjob_common(BDRV_DRAIN, false, TEST_JOB_SUCCESS);
 }
 
 static void test_blockjob_drain_subtree(void)
 {
-    test_blockjob_common(BDRV_SUBTREE_DRAIN, false);
+    test_blockjob_common(BDRV_SUBTREE_DRAIN, false, TEST_JOB_SUCCESS);
+}
+
+static void test_blockjob_error_drain_all(void)
+{
+    test_blockjob_common(BDRV_DRAIN_ALL, false, TEST_JOB_FAIL_RUN);
+    test_blockjob_common(BDRV_DRAIN_ALL, false, TEST_JOB_FAIL_PREPARE);
+}
+
+static void test_blockjob_error_drain(void)
+{
+    test_blockjob_common(BDRV_DRAIN, false, TEST_JOB_FAIL_RUN);
+    test_blockjob_common(BDRV_DRAIN, false, TEST_JOB_FAIL_PREPARE);
+}
+
+static void test_blockjob_error_drain_subtree(void)
+{
+    test_blockjob_common(BDRV_SUBTREE_DRAIN, false, TEST_JOB_FAIL_RUN);
+    test_blockjob_common(BDRV_SUBTREE_DRAIN, false, TEST_JOB_FAIL_PREPARE);
 }
 
 static void test_blockjob_iothread_drain_all(void)
 {
-    test_blockjob_common(BDRV_DRAIN_ALL, true);
+    test_blockjob_common(BDRV_DRAIN_ALL, true, TEST_JOB_SUCCESS);
 }
 
 static void test_blockjob_iothread_drain(void)
 {
-    test_blockjob_common(BDRV_DRAIN, true);
+    test_blockjob_common(BDRV_DRAIN, true, TEST_JOB_SUCCESS);
 }
 
 static void test_blockjob_iothread_drain_subtree(void)
 {
-    test_blockjob_common(BDRV_SUBTREE_DRAIN, true);
+    test_blockjob_common(BDRV_SUBTREE_DRAIN, true, TEST_JOB_SUCCESS);
+}
+
+static void test_blockjob_iothread_error_drain_all(void)
+{
+    test_blockjob_common(BDRV_DRAIN_ALL, true, TEST_JOB_FAIL_RUN);
+    test_blockjob_common(BDRV_DRAIN_ALL, true, TEST_JOB_FAIL_PREPARE);
+}
+
+static void test_blockjob_iothread_error_drain(void)
+{
+    test_blockjob_common(BDRV_DRAIN, true, TEST_JOB_FAIL_RUN);
+    test_blockjob_common(BDRV_DRAIN, true, TEST_JOB_FAIL_PREPARE);
+}
+
+static void test_blockjob_iothread_error_drain_subtree(void)
+{
+    test_blockjob_common(BDRV_SUBTREE_DRAIN, true, TEST_JOB_FAIL_RUN);
+    test_blockjob_common(BDRV_SUBTREE_DRAIN, true, TEST_JOB_FAIL_PREPARE);
 }
 
 
@@ -1434,6 +1512,13 @@ int main(int argc, char **argv)
     g_test_add_func("/bdrv-drain/blockjob/drain_subtree",
                     test_blockjob_drain_subtree);
 
+    g_test_add_func("/bdrv-drain/blockjob/error/drain_all",
+                    test_blockjob_error_drain_all);
+    g_test_add_func("/bdrv-drain/blockjob/error/drain",
+                    test_blockjob_error_drain);
+    g_test_add_func("/bdrv-drain/blockjob/error/drain_subtree",
+                    test_blockjob_error_drain_subtree);
+
     g_test_add_func("/bdrv-drain/blockjob/iothread/drain_all",
                     test_blockjob_iothread_drain_all);
     g_test_add_func("/bdrv-drain/blockjob/iothread/drain",
@@ -1441,6 +1526,13 @@ int main(int argc, char **argv)
     g_test_add_func("/bdrv-drain/blockjob/iothread/drain_subtree",
                     test_blockjob_iothread_drain_subtree);
 
+    g_test_add_func("/bdrv-drain/blockjob/iothread/error/drain_all",
+                    test_blockjob_iothread_error_drain_all);
+    g_test_add_func("/bdrv-drain/blockjob/iothread/error/drain",
+                    test_blockjob_iothread_error_drain);
+    g_test_add_func("/bdrv-drain/blockjob/iothread/error/drain_subtree",
+                    test_blockjob_iothread_error_drain_subtree);
+
     g_test_add_func("/bdrv-drain/deletion/drain", test_delete_by_drain);
     g_test_add_func("/bdrv-drain/detach/drain_all", test_detach_by_drain_all);
     g_test_add_func("/bdrv-drain/detach/drain", test_detach_by_drain);
-- 
2.13.6
