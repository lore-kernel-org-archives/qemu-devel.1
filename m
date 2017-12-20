Received: from eggs.gnu.org ([2001:4830:134:3::10]:55778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eReI4-0004cz-Iq
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:20:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eReHy-0006K2-Dd
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:20:08 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 20 Dec 2017 14:19:31 +0100
Message-Id: <20171220131939.27543-7-kwolf@redhat.com>
In-Reply-To: <20171220131939.27543-1-kwolf@redhat.com>
References: <20171220131939.27543-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/14] test-bdrv-drain: Test BlockDriver
 callbacks for drain
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

This adds a test case that the BlockDriver callbacks for drain are
called in bdrv_drained_all_begin/end(), and that both of them are called
exactly once.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/test-bdrv-drain.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include  |   2 +
 2 files changed, 139 insertions(+)
 create mode 100644 tests/test-bdrv-drain.c

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
new file mode 100644
index 0000000000..67541438c1
--- /dev/null
+++ b/tests/test-bdrv-drain.c
@@ -0,0 +1,137 @@
+/*
+ * Block node draining tests
+ *
+ * Copyright (c) 2017 Kevin Wolf <kwolf@redhat.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "block/block.h"
+#include "sysemu/block-backend.h"
+#include "qapi/error.h"
+
+typedef struct BDRVTestState {
+    int drain_count;
+} BDRVTestState;
+
+static void coroutine_fn bdrv_test_co_drain_begin(BlockDriverState *bs)
+{
+    BDRVTestState *s = bs->opaque;
+    s->drain_count++;
+}
+
+static void coroutine_fn bdrv_test_co_drain_end(BlockDriverState *bs)
+{
+    BDRVTestState *s = bs->opaque;
+    s->drain_count--;
+}
+
+static void bdrv_test_close(BlockDriverState *bs)
+{
+    BDRVTestState *s = bs->opaque;
+    g_assert_cmpint(s->drain_count, >, 0);
+}
+
+static int coroutine_fn bdrv_test_co_preadv(BlockDriverState *bs,
+                                            uint64_t offset, uint64_t bytes,
+                                            QEMUIOVector *qiov, int flags)
+{
+    /* We want this request to stay until the polling loop in drain waits for
+     * it to complete. We need to sleep a while as bdrv_drain_invoke() comes
+     * first and polls its result, too, but it shouldn't accidentally complete
+     * this request yet. */
+    co_aio_sleep_ns(qemu_get_aio_context(), QEMU_CLOCK_REALTIME, 100000);
+
+    return 0;
+}
+
+static BlockDriver bdrv_test = {
+    .format_name            = "test",
+    .instance_size          = sizeof(BDRVTestState),
+
+    .bdrv_close             = bdrv_test_close,
+    .bdrv_co_preadv         = bdrv_test_co_preadv,
+
+    .bdrv_co_drain_begin    = bdrv_test_co_drain_begin,
+    .bdrv_co_drain_end      = bdrv_test_co_drain_end,
+};
+
+static void aio_ret_cb(void *opaque, int ret)
+{
+    int *aio_ret = opaque;
+    *aio_ret = ret;
+}
+
+static void test_drv_cb_drain_all(void)
+{
+    BlockBackend *blk;
+    BlockDriverState *bs;
+    BDRVTestState *s;
+    BlockAIOCB *acb;
+    int aio_ret;
+
+    QEMUIOVector qiov;
+    struct iovec iov = {
+        .iov_base = NULL,
+        .iov_len = 0,
+    };
+    qemu_iovec_init_external(&qiov, &iov, 1);
+
+    blk = blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    bs = bdrv_new_open_driver(&bdrv_test, "test-node", BDRV_O_RDWR,
+                              &error_abort);
+    s = bs->opaque;
+    blk_insert_bs(blk, bs, &error_abort);
+
+    /* Simple bdrv_drain_all_begin/end pair, check that CBs are called */
+    g_assert_cmpint(s->drain_count, ==, 0);
+    bdrv_drain_all_begin();
+    g_assert_cmpint(s->drain_count, ==, 1);
+    bdrv_drain_all_end();
+    g_assert_cmpint(s->drain_count, ==, 0);
+
+    /* Now do the same while a request is pending */
+    aio_ret = -EINPROGRESS;
+    acb = blk_aio_preadv(blk, 0, &qiov, 0, aio_ret_cb, &aio_ret);
+    g_assert(acb != NULL);
+    g_assert_cmpint(aio_ret, ==, -EINPROGRESS);
+
+    g_assert_cmpint(s->drain_count, ==, 0);
+    bdrv_drain_all_begin();
+    g_assert_cmpint(aio_ret, ==, 0);
+    g_assert_cmpint(s->drain_count, ==, 1);
+    bdrv_drain_all_end();
+    g_assert_cmpint(s->drain_count, ==, 0);
+
+    bdrv_unref(bs);
+    blk_unref(blk);
+}
+
+int main(int argc, char **argv)
+{
+    bdrv_init();
+    qemu_init_main_loop(&error_abort);
+
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_func("/bdrv-drain/driver-cb/drain_all", test_drv_cb_drain_all);
+
+    return g_test_run();
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index b4bcc872f2..b8b0f2b3f7 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -80,6 +80,7 @@ gcov-files-test-thread-pool-y = thread-pool.c
 gcov-files-test-hbitmap-y = util/hbitmap.c
 check-unit-y += tests/test-hbitmap$(EXESUF)
 gcov-files-test-hbitmap-y = blockjob.c
+check-unit-y += tests/test-bdrv-drain$(EXESUF)
 check-unit-y += tests/test-blockjob$(EXESUF)
 check-unit-y += tests/test-blockjob-txn$(EXESUF)
 check-unit-y += tests/test-x86-cpuid$(EXESUF)
@@ -592,6 +593,7 @@ tests/test-coroutine$(EXESUF): tests/test-coroutine.o $(test-block-obj-y)
 tests/test-aio$(EXESUF): tests/test-aio.o $(test-block-obj-y)
 tests/test-aio-multithread$(EXESUF): tests/test-aio-multithread.o $(test-block-obj-y)
 tests/test-throttle$(EXESUF): tests/test-throttle.o $(test-block-obj-y)
+tests/test-bdrv-drain$(EXESUF): tests/test-bdrv-drain.o $(test-block-obj-y) $(test-util-obj-y)
 tests/test-blockjob$(EXESUF): tests/test-blockjob.o $(test-block-obj-y) $(test-util-obj-y)
 tests/test-blockjob-txn$(EXESUF): tests/test-blockjob-txn.o $(test-block-obj-y) $(test-util-obj-y)
 tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
-- 
2.13.6
