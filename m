Received: from eggs.gnu.org ([2001:4830:134:3::10]:52649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1fvyNb-00083H-Mp
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 01:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1fvyBt-0001FI-K0
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 01:11:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37020 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1fvyBt-0001BM-BP
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 01:11:21 -0400
From: Wei Huang <wei@redhat.com>
Date: Sat,  1 Sep 2018 01:11:14 -0400
Message-Id: <1535778675-32170-4-git-send-email-wei@redhat.com>
In-Reply-To: <1535778675-32170-1-git-send-email-wei@redhat.com>
References: <1535778675-32170-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH V8 3/4] tests/migration: Add migration-test
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, lvivier@redhat.com, drjones@redhat.com, dgilbert@redhat.com, quintela@redhat.com, wei@redhat.com

This patch moves the settings related migration-test from the
migration-test.c file to a new header file.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 tests/migration-test.c           | 28 ++++++++++++++++++----------
 tests/migration/migration-test.h | 21 +++++++++++++++++++++
 2 files changed, 39 insertions(+), 10 deletions(-)
 create mode 100644 tests/migration/migration-test.h

diff --git a/tests/migration-test.c b/tests/migration-test.c
index c4d79e9..bf60fa0 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -21,11 +21,13 @@
 #include "chardev/char.h"
 #include "sysemu/sysemu.h"
 
+#include "migration/migration-test.h"
+
 /* TODO actually test the results and get rid of this */
 #define qtest_qmp_discard_response(...) qobject_unref(qtest_qmp(__VA_ARGS__))
 
-const unsigned start_address = 1024 * 1024;
-const unsigned end_address = 100 * 1024 * 1024;
+unsigned start_address;
+unsigned end_address;
 bool got_stop;
 static bool uffd_feature_thread_id;
 
@@ -80,8 +82,8 @@ static bool ufd_version_check(void)
 
 static const char *tmpfs;
 
-/* A simple PC boot sector that modifies memory (1-100MB) quickly
- * outputting a 'B' every so often if it's still running.
+/* The boot file modifies memory area in [start_address, end_address)
+ * repeatedly. It outputs a 'B' at a fixed rate while it's still running.
  */
 #include "tests/migration/x86_64/x86-a-b-bootblock.h"
 
@@ -270,11 +272,11 @@ static void wait_for_migration_pass(QTestState *who)
 static void check_guests_ram(QTestState *who)
 {
     /* Our ASM test will have been incrementing one byte from each page from
-     * 1MB to <100MB in order.
-     * This gives us a constraint that any page's byte should be equal or less
-     * than the previous pages byte (mod 256); and they should all be equal
-     * except for one transition at the point where we meet the incrementer.
-     * (We're running this with the guest stopped).
+     * start_address to < end_address in order. This gives us a constraint
+     * that any page's byte should be equal or less than the previous pages
+     * byte (mod 256); and they should all be equal except for one transition
+     * at the point where we meet the incrementer. (We're running this with
+     * the guest stopped).
      */
     unsigned address;
     uint8_t first_byte;
@@ -285,7 +287,8 @@ static void check_guests_ram(QTestState *who)
     qtest_memread(who, start_address, &first_byte, 1);
     last_byte = first_byte;
 
-    for (address = start_address + 4096; address < end_address; address += 4096)
+    for (address = start_address + TEST_MEM_PAGE_SIZE; address < end_address;
+         address += TEST_MEM_PAGE_SIZE)
     {
         uint8_t b;
         qtest_memread(who, address, &b, 1);
@@ -437,6 +440,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                   " -drive file=%s,format=raw"
                                   " -incoming %s",
                                   accel, tmpfs, bootpath, uri);
+        start_address = X86_TEST_MEM_START;
+        end_address = X86_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") == 0) {
         cmd_src = g_strdup_printf("-machine accel=%s -m 256M"
                                   " -name source,debug-threads=on"
@@ -451,6 +456,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                   " -serial file:%s/dest_serial"
                                   " -incoming %s",
                                   accel, tmpfs, uri);
+
+        start_address = PPC_TEST_MEM_START;
+        end_address = PPC_TEST_MEM_END;
     } else {
         g_assert_not_reached();
     }
diff --git a/tests/migration/migration-test.h b/tests/migration/migration-test.h
new file mode 100644
index 0000000..c4c0c52
--- /dev/null
+++ b/tests/migration/migration-test.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2018 Red Hat, Inc. and/or its affiliates
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef _TEST_MIGRATION_H_
+#define _TEST_MIGRATION_H_
+
+/* Common */
+#define TEST_MEM_PAGE_SIZE 4096
+
+/* x86 */
+#define X86_TEST_MEM_START (1 * 1024 * 1024)
+#define X86_TEST_MEM_END   (100 * 1024 * 1024)
+
+/* PPC */
+#define PPC_TEST_MEM_START (1 * 1024 * 1024)
+#define PPC_TEST_MEM_END   (100 * 1024 * 1024)
+
+#endif /* _TEST_MIGRATION_H_ */
-- 
1.8.3.1
