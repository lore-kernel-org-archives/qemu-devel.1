Received: from eggs.gnu.org ([2001:4830:134:3::10]:50279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKR6-00071b-SB
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKR4-00030e-5C
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 24 Feb 2017 19:17:10 +0100
Message-Id: <1487960230-18054-20-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487960230-18054-1-git-send-email-kwolf@redhat.com>
References: <1487960230-18054-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 19/19] tests: Use opened block node for block
 job tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

blk_insert_bs() and block job related functions will soon require an
opened block node (permission calculations will involve the block
driver), so let our tests be consistent with the real users in this
respect.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/test-blockjob-txn.c | 6 +++++-
 tests/test-blockjob.c     | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index b132e39..f6dfd08 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -96,7 +96,10 @@ static BlockJob *test_block_job_start(unsigned int iterations,
     char job_id[24];
 
     data = g_new0(TestBlockJobCBData, 1);
-    bs = bdrv_new();
+
+    bs = bdrv_open("null-co://", NULL, NULL, 0, &error_abort);
+    g_assert_nonnull(bs);
+
     snprintf(job_id, sizeof(job_id), "job%u", counter++);
     s = block_job_create(job_id, &test_block_job_driver, bs, 0,
                          BLOCK_JOB_DEFAULT, test_block_job_cb,
@@ -242,6 +245,7 @@ static void test_pair_jobs_fail_cancel_race(void)
 int main(int argc, char **argv)
 {
     qemu_init_main_loop(&error_abort);
+    bdrv_init();
 
     g_test_init(&argc, &argv, NULL);
     g_test_add_func("/single/success", test_single_job_success);
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 60b78a3..068c9e4 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -54,7 +54,10 @@ static BlockJob *do_test_id(BlockBackend *blk, const char *id,
 static BlockBackend *create_blk(const char *name)
 {
     BlockBackend *blk = blk_new();
-    BlockDriverState *bs = bdrv_new();
+    BlockDriverState *bs;
+
+    bs = bdrv_open("null-co://", NULL, NULL, 0, &error_abort);
+    g_assert_nonnull(bs);
 
     blk_insert_bs(blk, bs);
     bdrv_unref(bs);
@@ -140,6 +143,7 @@ static void test_job_ids(void)
 int main(int argc, char **argv)
 {
     qemu_init_main_loop(&error_abort);
+    bdrv_init();
 
     g_test_init(&argc, &argv, NULL);
     g_test_add_func("/blockjob/ids", test_job_ids);
-- 
1.8.3.1
