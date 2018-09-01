Received: from eggs.gnu.org ([2001:4830:134:3::10]:52649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1fvyNV-00083H-Gr
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 01:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1fvyBt-0001FZ-KJ
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 01:11:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58952 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1fvyBt-0001Ba-Bq
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 01:11:21 -0400
From: Wei Huang <wei@redhat.com>
Date: Sat,  1 Sep 2018 01:11:15 -0400
Message-Id: <1535778675-32170-5-git-send-email-wei@redhat.com>
In-Reply-To: <1535778675-32170-1-git-send-email-wei@redhat.com>
References: <1535778675-32170-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH V8 4/4] tests: Add migration test for aarch64
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

This patch adds migration test support for aarch64. The test code, which
implements the same functionality as x86, is booted as a kernel in qemu.
Here are the design choices we make for aarch64:

 * We choose this -kernel approach because aarch64 QEMU doesn't provide a
   built-in fw like x86 does. So instead of relying on a boot loader, we
   use -kernel approach for aarch64.
 * The serial output is sent to PL011 directly.
 * The physical memory base for mach-virt machine is 0x40000000. We change
   the start_address and end_address for aarch64.

In addition to providing the binary, this patch also includes the source
code and the build script in tests/migration/aarch64. So users can change
the source and/or re-compile the binary as they wish.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 tests/Makefile.include                       |  1 +
 tests/migration-test.c                       | 38 ++++++++++++--
 tests/migration/Makefile                     |  2 +-
 tests/migration/aarch64/Makefile             | 20 ++++++++
 tests/migration/aarch64/aarch64-a-b-kernel.S | 75 ++++++++++++++++++++++++++++
 tests/migration/aarch64/aarch64-a-b-kernel.h | 19 +++++++
 tests/migration/migration-test.h             |  9 ++++
 7 files changed, 159 insertions(+), 5 deletions(-)
 create mode 100644 tests/migration/aarch64/Makefile
 create mode 100644 tests/migration/aarch64/aarch64-a-b-kernel.S
 create mode 100644 tests/migration/aarch64/aarch64-a-b-kernel.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 87c81d1..fab8fb9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -390,6 +390,7 @@ check-qtest-arm-y += tests/hexloader-test$(EXESUF)
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
 check-qtest-aarch64-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
 check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
+check-qtest-aarch64-y += tests/migration-test$(EXESUF)
 
 check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
 
diff --git a/tests/migration-test.c b/tests/migration-test.c
index bf60fa0..9df7bce 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -34,6 +34,7 @@ static bool uffd_feature_thread_id;
 #if defined(__linux__)
 #include <sys/syscall.h>
 #include <sys/vfs.h>
+#include <sys/utsname.h>
 #endif
 
 #if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
@@ -86,12 +87,13 @@ static const char *tmpfs;
  * repeatedly. It outputs a 'B' at a fixed rate while it's still running.
  */
 #include "tests/migration/x86_64/x86-a-b-bootblock.h"
+#include "tests/migration/aarch64/aarch64-a-b-kernel.h"
 
-static void init_bootfile_x86(const char *bootpath)
+static void init_bootfile(const char *bootpath, void *content)
 {
     FILE *bootfile = fopen(bootpath, "wb");
 
-    g_assert_cmpint(fwrite(x86_bootsect, 512, 1, bootfile), ==, 1);
+    g_assert_cmpint(fwrite(content, 512, 1, bootfile), ==, 1);
     fclose(bootfile);
 }
 
@@ -428,7 +430,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     got_stop = false;
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        init_bootfile_x86(bootpath);
+        init_bootfile(bootpath, x86_bootsect);
         cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
                                   " -name source,debug-threads=on"
                                   " -serial file:%s/src_serial"
@@ -459,6 +461,34 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 
         start_address = PPC_TEST_MEM_START;
         end_address = PPC_TEST_MEM_END;
+    } else if (strcmp(arch, "aarch64") == 0) {
+        struct utsname utsname;
+
+        /* kvm and tcg need different cpu and gic-version configs */
+        if (access("/dev/kvm", F_OK) == 0 && uname(&utsname) == 0 &&
+            strcmp(utsname.machine, "aarch64") == 0) {
+            accel = "kvm";
+        } else {
+            accel = "tcg";
+        }
+
+        init_bootfile(bootpath, aarch64_kernel);
+        cmd_src = g_strdup_printf("-machine virt,accel=%s,gic-version=max "
+                                  "-name vmsource,debug-threads=on -cpu max "
+                                  "-m 150M -serial file:%s/src_serial "
+                                  "-kernel %s ",
+                                  accel, tmpfs, bootpath);
+        cmd_dst = g_strdup_printf("-machine virt,accel=%s,gic-version=max "
+                                  "-name vmdest,debug-threads=on -cpu max "
+                                  "-m 150M -serial file:%s/dest_serial "
+                                  "-kernel %s "
+                                  "-incoming %s ",
+                                  accel, tmpfs, bootpath, uri);
+
+        start_address = ARM_TEST_MEM_START;
+        end_address = ARM_TEST_MEM_END;
+
+        g_assert(sizeof(aarch64_kernel) <= ARM_TEST_MAX_KERNEL_SIZE);
     } else {
         g_assert_not_reached();
     }
@@ -545,7 +575,7 @@ static void test_deprecated(void)
 {
     QTestState *from;
 
-    from = qtest_start("");
+    from = qtest_start("-machine none");
 
     deprecated_set_downtime(from, 0.12345);
     deprecated_set_speed(from, 12345);
diff --git a/tests/migration/Makefile b/tests/migration/Makefile
index 1de480e..bbc11cb 100644
--- a/tests/migration/Makefile
+++ b/tests/migration/Makefile
@@ -5,7 +5,7 @@
 # See the COPYING file in the top-level directory.
 #
 
-TARGET_LIST = x86_64
+TARGET_LIST = x86_64 aarch64
 
 SRC_PATH = ../..
 
diff --git a/tests/migration/aarch64/Makefile b/tests/migration/aarch64/Makefile
new file mode 100644
index 0000000..e88e546
--- /dev/null
+++ b/tests/migration/aarch64/Makefile
@@ -0,0 +1,20 @@
+# To specify cross compiler prefix, use CROSS_PREFIX=
+#   > make CROSS_PREFIX=aarch64-linux-gnu-
+
+.PHONY: all clean
+all: aarch64-a-b-kernel.h
+
+aarch64-a-b-kernel.h: aarch64.kernel
+	echo "$$__note" > header.tmp
+	xxd -i $< | sed -e 's/.*int.*//' >> header.tmp
+	mv header.tmp $@
+
+aarch64.kernel: aarch64.elf
+	$(CROSS_PREFIX)objcopy -O binary $< $@
+
+aarch64.elf: aarch64-a-b-kernel.S
+	$(CROSS_PREFIX)gcc -o $@ -nostdlib -Wl,--build-id=none $<
+
+clean:
+	@rm -rf *.kernel *.elf
+
diff --git a/tests/migration/aarch64/aarch64-a-b-kernel.S b/tests/migration/aarch64/aarch64-a-b-kernel.S
new file mode 100644
index 0000000..507af30
--- /dev/null
+++ b/tests/migration/aarch64/aarch64-a-b-kernel.S
@@ -0,0 +1,75 @@
+#
+# Copyright (c) 2018 Red Hat, Inc. and/or its affiliates
+#
+# Author:
+#   Wei Huang <wei@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+#
+# Note: Please make sure the compiler compiles the assembly code below with
+# pc-relative address. Also the branch instructions should use relative
+# addresses only.
+
+#include "../migration-test.h"
+
+.section .text
+
+        .globl  _start
+
+_start:
+        /* disable MMU to use phys mem address */
+        mrs     x0, sctlr_el1
+        bic     x0, x0, #(1<<0)
+        msr     sctlr_el1, x0
+        isb
+
+        /* traverse test memory region */
+        mov     x0, #ARM_TEST_MEM_START
+        mov     x1, #ARM_TEST_MEM_END
+
+        /* output char 'A' to PL011 */
+        mov     w3, 'A'
+        mov     x2, #ARM_MACH_VIRT_UART
+        strb    w3, [x2]
+
+        /* clean up memory */
+        mov     w3, #0
+        mov     x4, x0
+clean:
+        strb    w3, [x4]
+        add     x4, x4, #TEST_MEM_PAGE_SIZE
+        cmp     x4, x1
+        ble     clean
+
+        /* w5 keeps a counter so we can limit the output speed */
+        mov     w5, #0
+
+        /* main body */
+mainloop:
+        mov     x4, x0
+
+innerloop:
+        /* clean cache because el2 might still cache guest data under KVM */
+        dc      civac, x4
+
+        /* increment the first byte of each page by 1 */
+        ldrb    w3, [x4]
+        add     w3, w3, #1
+        and     w3, w3, #0xff
+        strb    w3, [x4]
+
+        add     x4, x4, #TEST_MEM_PAGE_SIZE
+        cmp     x4, x1
+        blt     innerloop
+
+        add     w5, w5, #1
+        and     w5, w5, #0xff
+        cmp     w5, #0
+        bne     mainloop
+
+        /* output char 'B' to PL011 */
+        mov     w3, 'B'
+        strb    w3, [x2]
+
+        b       mainloop
diff --git a/tests/migration/aarch64/aarch64-a-b-kernel.h b/tests/migration/aarch64/aarch64-a-b-kernel.h
new file mode 100644
index 0000000..36e76ff
--- /dev/null
+++ b/tests/migration/aarch64/aarch64-a-b-kernel.h
@@ -0,0 +1,19 @@
+/* This file is automatically generated from the assembly file in
+ * tests/migration/aarch64, edit that and then run "make all"
+ * inside tests/migration to update, and then remember to send both
+ * in your patch submission.
+ */
+unsigned char aarch64_kernel[] = {
+  0x00, 0x10, 0x38, 0xd5, 0x00, 0xf8, 0x7f, 0x92, 0x00, 0x10, 0x18, 0xd5,
+  0xdf, 0x3f, 0x03, 0xd5, 0x00, 0x02, 0xa8, 0xd2, 0x01, 0xc8, 0xa8, 0xd2,
+  0x23, 0x08, 0x80, 0x52, 0x02, 0x20, 0xa1, 0xd2, 0x43, 0x00, 0x00, 0x39,
+  0x03, 0x00, 0x80, 0x52, 0xe4, 0x03, 0x00, 0xaa, 0x83, 0x00, 0x00, 0x39,
+  0x84, 0x04, 0x40, 0x91, 0x9f, 0x00, 0x01, 0xeb, 0xad, 0xff, 0xff, 0x54,
+  0x05, 0x00, 0x80, 0x52, 0xe4, 0x03, 0x00, 0xaa, 0x24, 0x7e, 0x0b, 0xd5,
+  0x83, 0x00, 0x40, 0x39, 0x63, 0x04, 0x00, 0x11, 0x63, 0x1c, 0x00, 0x12,
+  0x83, 0x00, 0x00, 0x39, 0x84, 0x04, 0x40, 0x91, 0x9f, 0x00, 0x01, 0xeb,
+  0x2b, 0xff, 0xff, 0x54, 0xa5, 0x04, 0x00, 0x11, 0xa5, 0x1c, 0x00, 0x12,
+  0xbf, 0x00, 0x00, 0x71, 0x81, 0xfe, 0xff, 0x54, 0x43, 0x08, 0x80, 0x52,
+  0x43, 0x00, 0x00, 0x39, 0xf1, 0xff, 0xff, 0x17
+};
+
diff --git a/tests/migration/migration-test.h b/tests/migration/migration-test.h
index c4c0c52..6939a13 100644
--- a/tests/migration/migration-test.h
+++ b/tests/migration/migration-test.h
@@ -18,4 +18,13 @@
 #define PPC_TEST_MEM_START (1 * 1024 * 1024)
 #define PPC_TEST_MEM_END   (100 * 1024 * 1024)
 
+/* ARM */
+#define ARM_TEST_MEM_START (0x40000000 + 1 * 1024 * 1024)
+#define ARM_TEST_MEM_END   (0x40000000 + 100 * 1024 * 1024)
+#define ARM_MACH_VIRT_UART 0x09000000
+/* AArch64 kernel load address is 0x40080000, and the test memory starts at
+ * 0x40100000. So the maximum allowable kernel size is 512KB.
+ */
+#define ARM_TEST_MAX_KERNEL_SIZE (512 * 1024)
+
 #endif /* _TEST_MIGRATION_H_ */
-- 
1.8.3.1
