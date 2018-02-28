Received: from eggs.gnu.org ([2001:4830:134:3::10]:40682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1er63o-0001ts-P8
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1er63n-0002AY-2m
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:02:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1er63m-00029K-Qx
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:02:34 -0500
From: Wei Huang <wei@redhat.com>
Date: Wed, 28 Feb 2018 12:02:14 -0600
Message-Id: <20180228180215.25470-4-wei@redhat.com>
In-Reply-To: <20180228180215.25470-1-wei@redhat.com>
References: <20180228180215.25470-1-wei@redhat.com>
Subject: [Qemu-devel] [PATCH V7 3/4] tests/migration: Add migration-test
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
Cc: dgilbert@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, drjones@redhat.com

This patch moves the settings related migration-test from the
migration-test.c file to a seperate header file. It also renames the
x86-a-b-bootblock.s file extension from .s to .S, allowing gcc
pre-processor to include the C-style header file correctly.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 tests/migration-test.c                             | 34 +++++++++++++---------
 tests/migration/Makefile                           |  4 +--
 tests/migration/migration-test.h                   | 22 ++++++++++++++
 .../{x86-a-b-bootblock.s => x86-a-b-bootblock.S}   |  7 +++--
 tests/migration/x86-a-b-bootblock.h                |  2 +-
 5 files changed, 49 insertions(+), 20 deletions(-)
 create mode 100644 tests/migration/migration-test.h
 rename tests/migration/{x86-a-b-bootblock.s => x86-a-b-bootblock.S} (94%)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 74f9361bdd..12c04a9648 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -21,10 +21,10 @@
 #include "sysemu/sysemu.h"
 #include "hw/nvram/chrp_nvram.h"
 
-#define MIN_NVRAM_SIZE 8192 /* from spapr_nvram.c */
+#include "migration/migration-test.h"
 
-const unsigned start_address = 1024 * 1024;
-const unsigned end_address = 100 * 1024 * 1024;
+unsigned start_address;
+unsigned end_address;
 bool got_stop;
 
 #if defined(__linux__)
@@ -77,8 +77,8 @@ static bool ufd_version_check(void)
 
 static const char *tmpfs;
 
-/* A simple PC boot sector that modifies memory (1-100MB) quickly
- * outputting a 'B' every so often if it's still running.
+/* The boot file modifies memory area in [start_address, end_address)
+ * repeatedly. It outputs a 'B' at a fixed rate while it's still running.
  */
 #include "tests/migration/x86-a-b-bootblock.h"
 
@@ -104,9 +104,8 @@ static void init_bootfile_ppc(const char *bootpath)
     memcpy(header->name, "common", 6);
     chrp_nvram_finish_partition(header, MIN_NVRAM_SIZE);
 
-    /* FW_MAX_SIZE is 4MB, but slof.bin is only 900KB,
-     * so let's modify memory between 1MB and 100MB
-     * to do like PC bootsector
+    /* FW_MAX_SIZE is 4MB, but slof.bin is only 900KB. So it is OK to modify
+     * memory between start_address and end_address like PC bootsector does.
      */
 
     sprintf(buf + 16,
@@ -263,11 +262,11 @@ static void wait_for_migration_pass(QTestState *who)
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
@@ -278,7 +277,8 @@ static void check_guests_ram(QTestState *who)
     qtest_memread(who, start_address, &first_byte, 1);
     last_byte = first_byte;
 
-    for (address = start_address + 4096; address < end_address; address += 4096)
+    for (address = start_address + TEST_MEM_PAGE_SIZE; address < end_address;
+         address += TEST_MEM_PAGE_SIZE)
     {
         uint8_t b;
         qtest_memread(who, address, &b, 1);
@@ -404,6 +404,9 @@ static void test_migrate_start(QTestState **from, QTestState **to,
                                   " -drive file=%s,format=raw"
                                   " -incoming %s",
                                   accel, tmpfs, bootpath, uri);
+
+        start_address = X86_TEST_MEM_START;
+        end_address = X86_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") == 0) {
 
         /* On ppc64, the test only works with kvm-hv, but not with kvm-pr */
@@ -421,6 +424,9 @@ static void test_migrate_start(QTestState **from, QTestState **to,
                                   " -serial file:%s/dest_serial"
                                   " -incoming %s",
                                   accel, tmpfs, uri);
+
+        start_address = PPC_TEST_MEM_START;
+        end_address = PPC_TEST_MEM_END;
     } else {
         g_assert_not_reached();
     }
diff --git a/tests/migration/Makefile b/tests/migration/Makefile
index 8fbedaa8b8..013b8d1f44 100644
--- a/tests/migration/Makefile
+++ b/tests/migration/Makefile
@@ -25,8 +25,8 @@ include $(SRC_PATH)/rules.mak
 
 x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
 
-x86-a-b-bootblock.h: x86-a-b-bootblock.s
-	$(x86_64_cross_prefix)as --32 -march=i486 $< -o x86.o
+x86-a-b-bootblock.h: x86-a-b-bootblock.S
+	$(x86_64_cross_prefix)gcc -m32 -march=i486 -c $< -o x86.o
 	$(x86_64_cross_prefix)objcopy -O binary x86.o x86.boot
 	dd if=x86.boot of=x86.bootsect bs=256 count=2 skip=124
 	echo "$$__note" > $@
diff --git a/tests/migration/migration-test.h b/tests/migration/migration-test.h
new file mode 100644
index 0000000000..06c46a2fe0
--- /dev/null
+++ b/tests/migration/migration-test.h
@@ -0,0 +1,22 @@
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
+#define MIN_NVRAM_SIZE 8192 /* from spapr_nvram.c */
+
+#endif /* _TEST_MIGRATION_H_ */
diff --git a/tests/migration/x86-a-b-bootblock.s b/tests/migration/x86-a-b-bootblock.S
similarity index 94%
rename from tests/migration/x86-a-b-bootblock.s
rename to tests/migration/x86-a-b-bootblock.S
index 98dbfab084..a4da995a89 100644
--- a/tests/migration/x86-a-b-bootblock.s
+++ b/tests/migration/x86-a-b-bootblock.S
@@ -12,6 +12,7 @@
 #
 # Author: dgilbert@redhat.com
 
+#include "migration-test.h"
 
 .code16
 .org 0x7c00
@@ -45,11 +46,11 @@ start:             # at 0x7c00 ?
         mov $0, %bl
 mainloop:
         # Start from 1MB
-        mov $(1024*1024),%eax
+        mov $X86_TEST_MEM_START,%eax
 innerloop:
         incb (%eax)
-        add $4096,%eax
-        cmp $(100*1024*1024),%eax
+        add $TEST_MEM_PAGE_SIZE,%eax
+        cmp $X86_TEST_MEM_END,%eax
         jl innerloop
 
         inc %bl
diff --git a/tests/migration/x86-a-b-bootblock.h b/tests/migration/x86-a-b-bootblock.h
index 9e8e2e028b..44e4b99506 100644
--- a/tests/migration/x86-a-b-bootblock.h
+++ b/tests/migration/x86-a-b-bootblock.h
@@ -1,5 +1,5 @@
 /* This file is automatically generated from
- * tests/migration/x86-a-b-bootblock.s, edit that and then run
+ * tests/migration/x86-a-b-bootblock.S, edit that and then run
  * "make x86-a-b-bootblock.h" inside tests/migration to update,
  * and then remember to send both in your patch submission.
  */
-- 
2.14.3
