Received: from eggs.gnu.org ([2001:4830:134:3::10]:43648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUTZ3-0006zE-3L
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUTZ1-0000c9-Jv
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:24:49 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 20 Jan 2017 15:23:10 +0800
Message-Id: <20170120072310.8009-17-famz@redhat.com>
In-Reply-To: <20170120072310.8009-1-famz@redhat.com>
References: <20170120072310.8009-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v11 16/16] tests: Add test-image-lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, eblake@redhat.com

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/Makefile.include   |   2 +
 tests/test-image-lock.c  | 200 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/test-replication.c |   6 +-
 3 files changed, 205 insertions(+), 3 deletions(-)
 create mode 100644 tests/test-image-lock.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 96f5970..7718a9b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -55,6 +55,7 @@ check-unit-y += tests/test-hbitmap$(EXESUF)
 gcov-files-test-hbitmap-y = blockjob.c
 check-unit-y += tests/test-blockjob$(EXESUF)
 check-unit-y += tests/test-blockjob-txn$(EXESUF)
+check-unit-y += tests/test-image-lock$(EXESUF)
 check-unit-y += tests/test-x86-cpuid$(EXESUF)
 # all code tested by test-x86-cpuid is inside topology.h
 gcov-files-test-x86-cpuid-y =
@@ -516,6 +517,7 @@ tests/test-aio$(EXESUF): tests/test-aio.o $(test-block-obj-y)
 tests/test-throttle$(EXESUF): tests/test-throttle.o $(test-block-obj-y)
 tests/test-blockjob$(EXESUF): tests/test-blockjob.o $(test-block-obj-y) $(test-util-obj-y)
 tests/test-blockjob-txn$(EXESUF): tests/test-blockjob-txn.o $(test-block-obj-y) $(test-util-obj-y)
+tests/test-image-lock$(EXESUF): tests/test-image-lock.o $(test-block-obj-y) $(libqos-obj-y)
 tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
 tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
 tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y)
diff --git a/tests/test-image-lock.c b/tests/test-image-lock.c
new file mode 100644
index 0000000..df86ff0
--- /dev/null
+++ b/tests/test-image-lock.c
@@ -0,0 +1,200 @@
+/*
+ * Image lock tests
+ *
+ * Copyright 2016 Red Hat, Inc.
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
+#include "qemu/error-report.h"
+#include "qapi/qmp/qbool.h"
+#include "sysemu/block-backend.h"
+
+#define DEBUG_IMAGE_LOCK_TEST 0
+#define DPRINTF(...) do { \
+        if (DEBUG_IMAGE_LOCK_TEST) { \
+            printf(__VA_ARGS__); \
+        } \
+    } while (0)
+
+#define TEST_IMAGE_SIZE 4096
+static char test_image[] = "/tmp/qtest.XXXXXX";
+static int test_image_fd;
+
+static BlockBackend *open_test_image(int flags, bool disable_lock)
+{
+    QDict *opts = qdict_new();
+
+    qdict_set_default_str(opts, "filename", test_image);
+    qdict_set_default_str(opts, "driver", "file");
+    if (disable_lock) {
+        qdict_put(opts, "disable-lock", qbool_from_bool(true));
+    }
+
+    return blk_new_open(NULL, NULL, opts, flags | BDRV_O_ALLOW_RDWR, NULL);
+}
+
+#define RW true
+#define RO false
+#define SHARE true
+#define EXCLU false
+
+static struct CompatData {
+    bool write_1;
+    bool share_1;
+    bool write_2;
+    bool share_2;
+    bool compatible;
+} compat_data[] = {
+    /* Write 1, Share 1, Write 2, Share 2, Compatible. */
+    { RO,       SHARE,   RO,      SHARE,   true,  },
+    { RO,       SHARE,   RO,      EXCLU,   true,  },
+    { RO,       SHARE,   RW,      SHARE,   true,  },
+    { RO,       SHARE,   RW,      EXCLU,   true,  },
+
+    { RO,       EXCLU,   RO,      EXCLU,   true,  },
+    { RO,       EXCLU,   RW,      SHARE,   false, },
+    { RO,       EXCLU,   RW,      EXCLU,   false, },
+
+    { RW,       SHARE,   RW,      SHARE,   true, },
+    { RW,       SHARE,   RW,      EXCLU,   false, },
+
+    { RW,       EXCLU,   RW,      EXCLU,   false, },
+};
+
+/* Test one combination scenario.
+ *
+ * @flags1: The flags of the first blk.
+ * @flags2: The flags of the second blk.
+ * @disable1: The value for raw-posix disable-lock option of the first blk.
+ * @disable2: The value for raw-posix disable-lock option of the second blk.
+ * @from_reopen: Whether or not the first blk should get flags1 from a reopen.
+ * @initial: The source flags from which the blk1 is reopened, only
+ *                effective if @from_reopen is true.
+ */
+static void do_test_compat_one(int flags1, int flags2,
+                               bool disable1, bool disable2,
+                               bool from_reopen, int initial_flags,
+                               bool compatible)
+{
+    BlockBackend *blk1, *blk2;
+
+    DPRINTF("\n===\ndo test compat one\n");
+    DPRINTF("flags %x %x\n", flags1, flags2);
+    DPRINTF("disable %d %d\n", disable1, disable2);
+    DPRINTF("from reopen %d, initial flags %d\n", from_reopen, initial_flags);
+    DPRINTF("compatible %d\n", compatible);
+    if (!from_reopen) {
+        blk1 = open_test_image(flags1, disable1);
+    } else {
+        int ret;
+        blk1 = open_test_image(initial_flags, disable1);
+        BlockReopenQueue *rq = NULL;
+
+        rq = bdrv_reopen_queue(rq, blk_bs(blk1), NULL, flags1);
+        ret = bdrv_reopen_multiple(blk_get_aio_context(blk1), rq, &error_abort);
+        g_assert_cmpint(ret, ==, 0);
+    }
+    g_assert_nonnull(blk1);
+    g_assert_cmphex(blk_get_flags(blk1) & (BDRV_O_SHARE_RW | BDRV_O_RDWR),
+                    ==, flags1);
+    blk2 = open_test_image(flags2, disable2);
+    if (compatible) {
+        g_assert_nonnull(blk2);
+    } else {
+        g_assert_null(blk2);
+    }
+    blk_unref(blk1);
+    blk_unref(blk2);
+}
+
+static void do_test_compat(bool test_disable, bool from_reopen,
+                           int initial_flags)
+{
+    int i;
+    int flags1, flags2;
+
+    for (i = 0; i < ARRAY_SIZE(compat_data); i++) {
+        struct CompatData *data = &compat_data[i];
+        bool compat = data->compatible;
+
+        flags1 = (data->write_1 ? BDRV_O_RDWR : 0) |
+                 (data->share_1 ? BDRV_O_SHARE_RW : 0);
+        flags2 = (data->write_2 ? BDRV_O_RDWR : 0) |
+                 (data->share_2 ? BDRV_O_SHARE_RW : 0);
+        if (!test_disable) {
+            do_test_compat_one(flags1, flags2, false, false,
+                               from_reopen, initial_flags, compat);
+
+            do_test_compat_one(flags2, flags1, false, false,
+                               from_reopen, initial_flags, compat);
+        } else {
+            compat = true;
+            do_test_compat_one(flags1, flags2, true, false,
+                               from_reopen, initial_flags, compat);
+            do_test_compat_one(flags1, flags2, false, true,
+                               from_reopen, initial_flags, compat);
+            do_test_compat_one(flags2, flags1, true, false,
+                               from_reopen, initial_flags, compat);
+            do_test_compat_one(flags2, flags1, false, true,
+                               from_reopen, initial_flags, compat);
+            do_test_compat_one(flags1, flags2, true, true,
+                               from_reopen, initial_flags, compat);
+        }
+    }
+}
+
+static void test_compat(void)
+{
+    do_test_compat(false, false, 0);
+}
+
+static void test_compat_after_reopen(void)
+{
+    do_test_compat(false, true, 0);
+    do_test_compat(false, true, BDRV_O_SHARE_RW);
+    do_test_compat(false, true, BDRV_O_RDWR);
+    do_test_compat(false, true, BDRV_O_RDWR | BDRV_O_SHARE_RW);
+}
+
+static void test_0bytefile(void)
+{
+    ftruncate(test_image_fd, 0);
+    do_test_compat(false, false, 0);
+}
+
+static void test_disable(void)
+{
+    do_test_compat(true, false, 0);
+    do_test_compat(true, true, 0);
+    do_test_compat(true, true, BDRV_O_SHARE_RW);
+    do_test_compat(true, true, BDRV_O_RDWR);
+    do_test_compat(true, true, BDRV_O_RDWR | BDRV_O_SHARE_RW);
+}
+
+int main(int argc, char **argv)
+{
+    int r;
+    test_image_fd = mkstemp(test_image);
+
+    qemu_init_main_loop(&error_fatal);
+    bdrv_init();
+
+    g_assert(test_image_fd >= 0);
+    ftruncate(test_image_fd, TEST_IMAGE_SIZE);
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/image-lock/compat", test_compat);
+    g_test_add_func("/image-lock/compat_after_reopen", test_compat_after_reopen);
+    g_test_add_func("/image-lock/compat_0bytefile", test_0bytefile);
+    g_test_add_func("/image-lock/disable", test_disable);
+    aio_context_acquire(qemu_get_aio_context());
+    r = g_test_run();
+    aio_context_release(qemu_get_aio_context());
+    return r;
+}
diff --git a/tests/test-replication.c b/tests/test-replication.c
index 5bede49..5fb69d2 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -312,7 +312,7 @@ static BlockBackend *start_secondary(void)
 
     /* add s_local_disk and forge S_LOCAL_DISK_ID */
     cmdline = g_strdup_printf("file.filename=%s,driver=qcow2,"
-                              "file.file.disable-lock=on",
+                              "file.disable-lock=on",
                               s_local_disk);
     opts = qemu_opts_parse_noisily(&qemu_drive_opts, cmdline, false);
     g_free(cmdline);
@@ -334,10 +334,10 @@ static BlockBackend *start_secondary(void)
     /* add S_(ACTIVE/HIDDEN)_DISK and forge S_ID */
     cmdline = g_strdup_printf("driver=replication,mode=secondary,top-id=%s,"
                               "file.driver=qcow2,file.file.filename=%s,"
-                              "file.file.disable-lock=on",
+                              "file.file.disable-lock=on,"
                               "file.backing.driver=qcow2,"
                               "file.backing.file.filename=%s,"
-                              "file.backing.file.disable-lock=on",
+                              "file.backing.file.disable-lock=on,"
                               "file.backing.backing=%s"
                               , S_ID, s_active_disk, s_hidden_disk
                               , S_LOCAL_DISK_ID);
-- 
2.9.3
