Received: from eggs.gnu.org ([2001:4830:134:3::10]:57327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6l-0005oU-Df
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6g-0002Ur-4l
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:31 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 22 Dec 2017 16:18:31 +0100
Message-Id: <20171222151846.28110-21-kwolf@redhat.com>
In-Reply-To: <20171222151846.28110-1-kwolf@redhat.com>
References: <20171222151846.28110-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL v3 20/35] test-bdrv-drain: Test callback for
 bdrv_drain
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

The existing test is for bdrv_drain_all_begin/end() only. Generalise the
test case so that it can be run for the other variants as well. At the
moment this is only bdrv_drain_begin/end(), but in a while, we'll add
another one.

Also, add a backing file to the test node to test whether the operations
work recursively.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-drain.c | 69 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 0e567e34ba..3a3eef0f87 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -71,6 +71,8 @@ static BlockDriver bdrv_test = {
 
     .bdrv_co_drain_begin    = bdrv_test_co_drain_begin,
     .bdrv_co_drain_end      = bdrv_test_co_drain_end,
+
+    .bdrv_child_perm        = bdrv_format_default_perms,
 };
 
 static void aio_ret_cb(void *opaque, int ret)
@@ -79,11 +81,34 @@ static void aio_ret_cb(void *opaque, int ret)
     *aio_ret = ret;
 }
 
-static void test_drv_cb_drain_all(void)
+enum drain_type {
+    BDRV_DRAIN_ALL,
+    BDRV_DRAIN,
+};
+
+static void do_drain_begin(enum drain_type drain_type, BlockDriverState *bs)
+{
+    switch (drain_type) {
+    case BDRV_DRAIN_ALL:        bdrv_drain_all_begin(); break;
+    case BDRV_DRAIN:            bdrv_drained_begin(bs); break;
+    default:                    g_assert_not_reached();
+    }
+}
+
+static void do_drain_end(enum drain_type drain_type, BlockDriverState *bs)
+{
+    switch (drain_type) {
+    case BDRV_DRAIN_ALL:        bdrv_drain_all_end(); break;
+    case BDRV_DRAIN:            bdrv_drained_end(bs); break;
+    default:                    g_assert_not_reached();
+    }
+}
+
+static void test_drv_cb_common(enum drain_type drain_type, bool recursive)
 {
     BlockBackend *blk;
-    BlockDriverState *bs;
-    BDRVTestState *s;
+    BlockDriverState *bs, *backing;
+    BDRVTestState *s, *backing_s;
     BlockAIOCB *acb;
     int aio_ret;
 
@@ -100,12 +125,23 @@ static void test_drv_cb_drain_all(void)
     s = bs->opaque;
     blk_insert_bs(blk, bs, &error_abort);
 
+    backing = bdrv_new_open_driver(&bdrv_test, "backing", 0, &error_abort);
+    backing_s = backing->opaque;
+    bdrv_set_backing_hd(bs, backing, &error_abort);
+
     /* Simple bdrv_drain_all_begin/end pair, check that CBs are called */
     g_assert_cmpint(s->drain_count, ==, 0);
-    bdrv_drain_all_begin();
+    g_assert_cmpint(backing_s->drain_count, ==, 0);
+
+    do_drain_begin(drain_type, bs);
+
     g_assert_cmpint(s->drain_count, ==, 1);
-    bdrv_drain_all_end();
+    g_assert_cmpint(backing_s->drain_count, ==, !!recursive);
+
+    do_drain_end(drain_type, bs);
+
     g_assert_cmpint(s->drain_count, ==, 0);
+    g_assert_cmpint(backing_s->drain_count, ==, 0);
 
     /* Now do the same while a request is pending */
     aio_ret = -EINPROGRESS;
@@ -114,16 +150,34 @@ static void test_drv_cb_drain_all(void)
     g_assert_cmpint(aio_ret, ==, -EINPROGRESS);
 
     g_assert_cmpint(s->drain_count, ==, 0);
-    bdrv_drain_all_begin();
+    g_assert_cmpint(backing_s->drain_count, ==, 0);
+
+    do_drain_begin(drain_type, bs);
+
     g_assert_cmpint(aio_ret, ==, 0);
     g_assert_cmpint(s->drain_count, ==, 1);
-    bdrv_drain_all_end();
+    g_assert_cmpint(backing_s->drain_count, ==, !!recursive);
+
+    do_drain_end(drain_type, bs);
+
     g_assert_cmpint(s->drain_count, ==, 0);
+    g_assert_cmpint(backing_s->drain_count, ==, 0);
 
+    bdrv_unref(backing);
     bdrv_unref(bs);
     blk_unref(blk);
 }
 
+static void test_drv_cb_drain_all(void)
+{
+    test_drv_cb_common(BDRV_DRAIN_ALL, true);
+}
+
+static void test_drv_cb_drain(void)
+{
+    test_drv_cb_common(BDRV_DRAIN, false);
+}
+
 int main(int argc, char **argv)
 {
     bdrv_init();
@@ -132,6 +186,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     g_test_add_func("/bdrv-drain/driver-cb/drain_all", test_drv_cb_drain_all);
+    g_test_add_func("/bdrv-drain/driver-cb/drain", test_drv_cb_drain);
 
     return g_test_run();
 }
-- 
2.13.6
