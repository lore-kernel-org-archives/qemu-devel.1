Received: from eggs.gnu.org ([2001:4830:134:3::10]:39581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eRbj8-0004pg-Vc
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eRbj7-0005IP-7P
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:35:54 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 20 Dec 2017 11:34:03 +0100
Message-Id: <20171220103412.13048-11-kwolf@redhat.com>
In-Reply-To: <20171220103412.13048-1-kwolf@redhat.com>
References: <20171220103412.13048-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 10/19] test-bdrv-drain: Test nested drain
 sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-drain.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 4571137928..ede5cf6e64 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -85,6 +85,7 @@ static void aio_ret_cb(void *opaque, int ret)
 enum drain_type {
     BDRV_DRAIN_ALL,
     BDRV_DRAIN,
+    DRAIN_TYPE_MAX,
 };
 
 static void do_drain_begin(enum drain_type drain_type, BlockDriverState *bs)
@@ -221,6 +222,60 @@ static void test_quiesce_drain(void)
     test_quiesce_common(BDRV_DRAIN, false);
 }
 
+static void test_nested(void)
+{
+    BlockBackend *blk;
+    BlockDriverState *bs, *backing;
+    BDRVTestState *s, *backing_s;
+    enum drain_type outer, inner;
+
+    blk = blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    bs = bdrv_new_open_driver(&bdrv_test, "test-node", BDRV_O_RDWR,
+                              &error_abort);
+    s = bs->opaque;
+    blk_insert_bs(blk, bs, &error_abort);
+
+    backing = bdrv_new_open_driver(&bdrv_test, "backing", 0, &error_abort);
+    backing_s = backing->opaque;
+    bdrv_set_backing_hd(bs, backing, &error_abort);
+
+    for (outer = 0; outer < DRAIN_TYPE_MAX; outer++) {
+        for (inner = 0; inner < DRAIN_TYPE_MAX; inner++) {
+            /* XXX bdrv_drain_all() doesn't increase the quiesce_counter */
+            int bs_quiesce      = (outer != BDRV_DRAIN_ALL) +
+                                  (inner != BDRV_DRAIN_ALL);
+            int backing_quiesce = 0;
+            int backing_cb_cnt  = (outer != BDRV_DRAIN) +
+                                  (inner != BDRV_DRAIN);
+
+            g_assert_cmpint(bs->quiesce_counter, ==, 0);
+            g_assert_cmpint(backing->quiesce_counter, ==, 0);
+            g_assert_cmpint(s->drain_count, ==, 0);
+            g_assert_cmpint(backing_s->drain_count, ==, 0);
+
+            do_drain_begin(outer, bs);
+            do_drain_begin(inner, bs);
+
+            g_assert_cmpint(bs->quiesce_counter, ==, bs_quiesce);
+            g_assert_cmpint(backing->quiesce_counter, ==, backing_quiesce);
+            g_assert_cmpint(s->drain_count, ==, 2);
+            g_assert_cmpint(backing_s->drain_count, ==, backing_cb_cnt);
+
+            do_drain_end(inner, bs);
+            do_drain_end(outer, bs);
+
+            g_assert_cmpint(bs->quiesce_counter, ==, 0);
+            g_assert_cmpint(backing->quiesce_counter, ==, 0);
+            g_assert_cmpint(s->drain_count, ==, 0);
+            g_assert_cmpint(backing_s->drain_count, ==, 0);
+        }
+    }
+
+    bdrv_unref(backing);
+    bdrv_unref(bs);
+    blk_unref(blk);
+}
+
 
 typedef struct TestBlockJob {
     BlockJob common;
@@ -349,6 +404,8 @@ int main(int argc, char **argv)
     g_test_add_func("/bdrv-drain/quiesce/drain_all", test_quiesce_drain_all);
     g_test_add_func("/bdrv-drain/quiesce/drain", test_quiesce_drain);
 
+    g_test_add_func("/bdrv-drain/nested", test_nested);
+
     g_test_add_func("/bdrv-drain/blockjob/drain_all", test_blockjob_drain_all);
     g_test_add_func("/bdrv-drain/blockjob/drain", test_blockjob_drain);
 
-- 
2.13.6
