Received: from eggs.gnu.org ([2001:4830:134:3::10]:47829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1g0R8i-0003aG-Kf
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1g0R8e-0003P0-2A
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:54:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1g0R8d-0003OL-PV
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:54:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28A8B81DE1
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 12:54:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 13 Sep 2018 14:53:41 +0200
Message-Id: <20180913125343.10912-11-quintela@redhat.com>
In-Reply-To: <20180913125343.10912-1-quintela@redhat.com>
References: <20180913125343.10912-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 10/12] tests/migration: Add migration-test
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Wei Huang <wei@redhat.com>

From: Wei Huang <wei@redhat.com>

This patch moves the settings related migration-test from the
migration-test.c file to a new header file.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Wei Huang <wei@redhat.com>
Message-Id: <1536174934-26022-4-git-send-email-wei@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c           | 28 ++++++++++++++++++----------
 tests/migration/migration-test.h | 21 +++++++++++++++++++++
 2 files changed, 39 insertions(+), 10 deletions(-)
 create mode 100644 tests/migration/migration-test.h

diff --git a/tests/migration-test.c b/tests/migration-test.c
index fe6b41a38d..17c689601f 100644
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
 #include "tests/migration/i386/a-b-bootblock.h"
 
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
index 0000000000..c4c0c526b6
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
2.17.1
