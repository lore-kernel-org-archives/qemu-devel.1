Received: from eggs.gnu.org ([2001:4830:134:3::10]:53118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0mAx-0004zV-QD
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0mAw-00068a-Qw
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:45:27 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 19 Apr 2017 17:43:56 +0800
Message-Id: <20170419094356.19826-17-famz@redhat.com>
In-Reply-To: <20170419094356.19826-1-famz@redhat.com>
References: <20170419094356.19826-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 16/16] tests: Add test case for
 BLK_PERM_AIO_CONTEXT_CHANGE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/Makefile.include |  2 ++
 tests/test-blk-perm.c  | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 tests/test-blk-perm.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f3de81f..b38e090 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -56,6 +56,7 @@ gcov-files-test-thread-pool-y = thread-pool.c
 gcov-files-test-hbitmap-y = util/hbitmap.c
 check-unit-y += tests/test-hbitmap$(EXESUF)
 gcov-files-test-hbitmap-y = blockjob.c
+check-unit-y += tests/test-blk-perm$(EXESUF)
 check-unit-y += tests/test-blockjob$(EXESUF)
 check-unit-y += tests/test-blockjob-txn$(EXESUF)
 check-unit-y += tests/test-x86-cpuid$(EXESUF)
@@ -543,6 +544,7 @@ tests/test-coroutine$(EXESUF): tests/test-coroutine.o $(test-block-obj-y)
 tests/test-aio$(EXESUF): tests/test-aio.o $(test-block-obj-y)
 tests/test-aio-multithread$(EXESUF): tests/test-aio-multithread.o $(test-block-obj-y)
 tests/test-throttle$(EXESUF): tests/test-throttle.o $(test-block-obj-y)
+tests/test-blk-perm$(EXESUF): tests/test-blk-perm.o $(test-block-obj-y)
 tests/test-blockjob$(EXESUF): tests/test-blockjob.o $(test-block-obj-y) $(test-util-obj-y)
 tests/test-blockjob-txn$(EXESUF): tests/test-blockjob-txn.o $(test-block-obj-y) $(test-util-obj-y)
 tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
diff --git a/tests/test-blk-perm.c b/tests/test-blk-perm.c
new file mode 100644
index 0000000..d6129ab
--- /dev/null
+++ b/tests/test-blk-perm.c
@@ -0,0 +1,59 @@
+/*
+ * Block permission tests
+ *
+ * Copyright Red Hat, Inc. 2017
+ *
+ * Authors:
+ *  Fam Zheng <famz@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "sysemu/block-backend.h"
+
+static void test_aio_context_success(void)
+{
+    BlockBackend *blk1 = blk_new(BLK_PERM_AIO_CONTEXT_CHANGE, BLK_PERM_ALL);
+    BlockBackend *blk2 = blk_new(BLK_PERM_AIO_CONTEXT_CHANGE, BLK_PERM_ALL);
+    BlockDriverState *bs = bdrv_open("null-co://", NULL, NULL, 0, &error_abort);
+
+    blk_insert_bs(blk1, bs, &error_abort);
+    blk_insert_bs(blk2, bs, &error_abort);
+
+    blk_unref(blk1);
+    blk_unref(blk2);
+    bdrv_unref(bs);
+}
+
+static void test_aio_context_failure(void)
+{
+    Error *local_err = NULL;
+    BlockBackend *blk1 = blk_new(BLK_PERM_AIO_CONTEXT_CHANGE,
+                                 BLK_PERM_ALL & ~BLK_PERM_AIO_CONTEXT_CHANGE);
+    BlockBackend *blk2 = blk_new(BLK_PERM_AIO_CONTEXT_CHANGE, BLK_PERM_ALL);
+    BlockDriverState *bs = bdrv_open("null-co://", NULL, NULL, 0, &error_abort);
+
+    blk_insert_bs(blk1, bs, &error_abort);
+    blk_insert_bs(blk2, bs, &local_err);
+
+    g_assert_nonnull(local_err);
+
+    blk_unref(blk1);
+    blk_unref(blk2);
+    bdrv_unref(bs);
+}
+
+int main(int argc, char **argv)
+{
+    bdrv_init();
+    qemu_init_main_loop(&error_abort);
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/block/perm/aio-context/success",
+                    test_aio_context_success);
+    g_test_add_func("/block/perm/aio-context/failure",
+                    test_aio_context_failure);
+    return g_test_run();
+}
-- 
2.9.3
