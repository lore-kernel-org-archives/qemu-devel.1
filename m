Received: from eggs.gnu.org ([2001:4830:134:3::10]:42639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1df8lh-0001GX-El
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 13:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1df8lg-0002eQ-3f
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 13:58:13 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  8 Aug 2017 13:57:11 -0400
Message-Id: <20170808175711.12203-5-jsnow@redhat.com>
In-Reply-To: <20170808175711.12203-1-jsnow@redhat.com>
References: <20170808175711.12203-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] block-backend: test flush op on empty
 backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, pjp@redhat.com, John Snow <jsnow@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/Makefile.include     |  2 ++
 tests/test-block-backend.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 tests/test-block-backend.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index eb4895f..153494b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -56,6 +56,7 @@ check-unit-y += tests/test-hbitmap$(EXESUF)
 gcov-files-test-hbitmap-y = blockjob.c
 check-unit-y += tests/test-blockjob$(EXESUF)
 check-unit-y += tests/test-blockjob-txn$(EXESUF)
+check-unit-y += tests/test-block-backend$(EXESUF)
 check-unit-y += tests/test-x86-cpuid$(EXESUF)
 # all code tested by test-x86-cpuid is inside topology.h
 gcov-files-test-x86-cpuid-y =
@@ -556,6 +557,7 @@ tests/test-aio-multithread$(EXESUF): tests/test-aio-multithread.o $(test-block-o
 tests/test-throttle$(EXESUF): tests/test-throttle.o $(test-block-obj-y)
 tests/test-blockjob$(EXESUF): tests/test-blockjob.o $(test-block-obj-y) $(test-util-obj-y)
 tests/test-blockjob-txn$(EXESUF): tests/test-blockjob-txn.o $(test-block-obj-y) $(test-util-obj-y)
+tests/test-block-backend$(EXESUF): tests/test-block-backend.o $(test-block-obj-y) $(test-util-obj-y)
 tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
 tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
 tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
diff --git a/tests/test-block-backend.c b/tests/test-block-backend.c
new file mode 100644
index 0000000..5348781
--- /dev/null
+++ b/tests/test-block-backend.c
@@ -0,0 +1,62 @@
+/*
+ * BlockBackend tests
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
+static void test_drain_aio_error_flush_cb(void *opaque, int ret)
+{
+    bool *completed = opaque;
+
+    g_assert(ret == -ENOMEDIUM);
+    *completed = true;
+}
+
+static void test_drain_aio_error(void)
+{
+    BlockBackend *blk = blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    BlockAIOCB *acb;
+    bool completed = false;
+
+    acb = blk_aio_flush(blk, test_drain_aio_error_flush_cb, &completed);
+    g_assert(acb != NULL);
+    g_assert(completed == false);
+
+    blk_drain(blk);
+    g_assert(completed == true);
+}
+
+int main(int argc, char **argv)
+{
+    bdrv_init();
+    qemu_init_main_loop(&error_abort);
+
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_func("/block-backend/drain_aio_error", test_drain_aio_error);
+
+    return g_test_run();
+}
-- 
2.9.4
