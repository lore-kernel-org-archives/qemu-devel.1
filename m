Received: from eggs.gnu.org ([2001:4830:134:3::10]:44882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAgaa-0004vv-S1
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAgaU-0001dM-TA
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:25:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gAgaU-0001Uo-Bl
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:25:34 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 11 Oct 2018 20:25:07 +0100
Message-Id: <20181011192513.63634-2-dgilbert@redhat.com>
In-Reply-To: <20181011192513.63634-1-dgilbert@redhat.com>
References: <20181011192513.63634-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/7] tests: Add migration test for aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: wei@redhat.com, thuth@redhat.com, i.maximets@samsung.com, den@openvz.org

From: Wei Huang <wei@redhat.com>

This patch adds migration test support for aarch64. The test code, which
implements the same functionality as x86, is booted as a kernel in qemu.
Here are the design choices we make for aarch64:

 * We choose this -kernel approach because aarch64 QEMU doesn't provide a
   built-in fw like x86 does. So instead of relying on a boot loader, we
   use -kernel approach for aarch64.
 * The serial output is sent to PL011 directly.
 * The physical memory base for mach-virt machine is 0x40000000. We chang=
e
   the start_address and end_address for aarch64.

In addition to providing the binary, this patch also includes the source
code and the build script in tests/migration/aarch64. So users can change
the source and/or re-compile the binary as they wish.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Wei Huang <wei@redhat.com>
Message-Id: <1538669326-28135-1-git-send-email-wei@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/Makefile.include               |  1 +
 tests/migration-test.c               | 27 ++++++++--
 tests/migration/Makefile             |  2 +-
 tests/migration/aarch64/Makefile     | 18 +++++++
 tests/migration/aarch64/a-b-kernel.S | 75 ++++++++++++++++++++++++++++
 tests/migration/aarch64/a-b-kernel.h | 18 +++++++
 tests/migration/migration-test.h     |  9 ++++
 7 files changed, 145 insertions(+), 5 deletions(-)
 create mode 100644 tests/migration/aarch64/Makefile
 create mode 100644 tests/migration/aarch64/a-b-kernel.S
 create mode 100644 tests/migration/aarch64/a-b-kernel.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8264af64a8..9324a8be6b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -402,6 +402,7 @@ check-qtest-arm-y +=3D tests/hexloader-test$(EXESUF)
 check-qtest-aarch64-y =3D tests/numa-test$(EXESUF)
 check-qtest-aarch64-$(CONFIG_SDHCI) +=3D tests/sdhci-test$(EXESUF)
 check-qtest-aarch64-y +=3D tests/boot-serial-test$(EXESUF)
+check-qtest-aarch64-y +=3D tests/migration-test$(EXESUF)
=20
 check-qtest-microblazeel-y =3D $(check-qtest-microblaze-y)
=20
diff --git a/tests/migration-test.c b/tests/migration-test.c
index 20f38f1930..5bdc0bd519 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -86,12 +86,13 @@ static const char *tmpfs;
  * repeatedly. It outputs a 'B' at a fixed rate while it's still running=
.
  */
 #include "tests/migration/i386/a-b-bootblock.h"
+#include "tests/migration/aarch64/a-b-kernel.h"
=20
-static void init_bootfile_x86(const char *bootpath)
+static void init_bootfile(const char *bootpath, void *content)
 {
     FILE *bootfile =3D fopen(bootpath, "wb");
=20
-    g_assert_cmpint(fwrite(x86_bootsect, 512, 1, bootfile), =3D=3D, 1);
+    g_assert_cmpint(fwrite(content, 512, 1, bootfile), =3D=3D, 1);
     fclose(bootfile);
 }
=20
@@ -428,7 +429,7 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
     got_stop =3D false;
=20
     if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D 0=
) {
-        init_bootfile_x86(bootpath);
+        init_bootfile(bootpath, x86_bootsect);
         cmd_src =3D g_strdup_printf("-machine accel=3D%s -m 150M"
                                   " -name source,debug-threads=3Don"
                                   " -serial file:%s/src_serial"
@@ -459,6 +460,24 @@ static int test_migrate_start(QTestState **from, QTe=
stState **to,
=20
         start_address =3D PPC_TEST_MEM_START;
         end_address =3D PPC_TEST_MEM_END;
+    } else if (strcmp(arch, "aarch64") =3D=3D 0) {
+        init_bootfile(bootpath, aarch64_kernel);
+        cmd_src =3D g_strdup_printf("-machine virt,accel=3D%s,gic-versio=
n=3Dmax "
+                                  "-name vmsource,debug-threads=3Don -cp=
u max "
+                                  "-m 150M -serial file:%s/src_serial "
+                                  "-kernel %s ",
+                                  accel, tmpfs, bootpath);
+        cmd_dst =3D g_strdup_printf("-machine virt,accel=3D%s,gic-versio=
n=3Dmax "
+                                  "-name vmdest,debug-threads=3Don -cpu =
max "
+                                  "-m 150M -serial file:%s/dest_serial "
+                                  "-kernel %s "
+                                  "-incoming %s ",
+                                  accel, tmpfs, bootpath, uri);
+
+        start_address =3D ARM_TEST_MEM_START;
+        end_address =3D ARM_TEST_MEM_END;
+
+        g_assert(sizeof(aarch64_kernel) <=3D ARM_TEST_MAX_KERNEL_SIZE);
     } else {
         g_assert_not_reached();
     }
@@ -545,7 +564,7 @@ static void test_deprecated(void)
 {
     QTestState *from;
=20
-    from =3D qtest_start("");
+    from =3D qtest_start("-machine none");
=20
     deprecated_set_downtime(from, 0.12345);
     deprecated_set_speed(from, 12345);
diff --git a/tests/migration/Makefile b/tests/migration/Makefile
index dc3b551976..91237a84d9 100644
--- a/tests/migration/Makefile
+++ b/tests/migration/Makefile
@@ -5,7 +5,7 @@
 # See the COPYING file in the top-level directory.
 #
=20
-TARGET_LIST =3D i386
+TARGET_LIST =3D i386 aarch64
=20
 SRC_PATH =3D ../..
=20
diff --git a/tests/migration/aarch64/Makefile b/tests/migration/aarch64/M=
akefile
new file mode 100644
index 0000000000..9c4fa18e76
--- /dev/null
+++ b/tests/migration/aarch64/Makefile
@@ -0,0 +1,18 @@
+# To specify cross compiler prefix, use CROSS_PREFIX=3D
+#   $ make CROSS_PREFIX=3Daarch64-linux-gnu-
+
+.PHONY: all clean
+all: a-b-kernel.h
+
+a-b-kernel.h: aarch64.kernel
+	echo "$$__note" > $@
+	xxd -i $< | sed -e 's/.*int.*//' >> $@
+
+aarch64.kernel: aarch64.elf
+	$(CROSS_PREFIX)objcopy -O binary $< $@
+
+aarch64.elf: a-b-kernel.S
+	$(CROSS_PREFIX)gcc -o $@ -nostdlib -Wl,--build-id=3Dnone $<
+
+clean:
+	$(RM) *.kernel *.elf
diff --git a/tests/migration/aarch64/a-b-kernel.S b/tests/migration/aarch=
64/a-b-kernel.S
new file mode 100644
index 0000000000..0225945348
--- /dev/null
+++ b/tests/migration/aarch64/a-b-kernel.S
@@ -0,0 +1,75 @@
+#
+# Copyright (c) 2018 Red Hat, Inc. and/or its affiliates
+#
+# Author:
+#   Wei Huang <wei@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+# See the COPYING file in the top-level directory.
+#
+# Note: Please make sure the compiler compiles the assembly code below w=
ith
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
+        /* increment the first byte of each page by 1 */
+        ldrb    w3, [x4]
+        add     w3, w3, #1
+        and     w3, w3, #0xff
+        strb    w3, [x4]
+
+        /* make sure QEMU user space can see consistent data as MMU is o=
ff */
+        dc      civac, x4
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
diff --git a/tests/migration/aarch64/a-b-kernel.h b/tests/migration/aarch=
64/a-b-kernel.h
new file mode 100644
index 0000000000..0a9b01137e
--- /dev/null
+++ b/tests/migration/aarch64/a-b-kernel.h
@@ -0,0 +1,18 @@
+/* This file is automatically generated from the assembly file in
+ * tests/migration/aarch64. Edit that file and then run "make all"
+ * inside tests/migration to update, and then remember to send both
+ * the header and the assembler differences in your patch submission.
+ */
+unsigned char aarch64_kernel[] =3D {
+  0x00, 0x10, 0x38, 0xd5, 0x00, 0xf8, 0x7f, 0x92, 0x00, 0x10, 0x18, 0xd5=
,
+  0xdf, 0x3f, 0x03, 0xd5, 0x00, 0x02, 0xa8, 0xd2, 0x01, 0xc8, 0xa8, 0xd2=
,
+  0x23, 0x08, 0x80, 0x52, 0x02, 0x20, 0xa1, 0xd2, 0x43, 0x00, 0x00, 0x39=
,
+  0x03, 0x00, 0x80, 0x52, 0xe4, 0x03, 0x00, 0xaa, 0x83, 0x00, 0x00, 0x39=
,
+  0x84, 0x04, 0x40, 0x91, 0x9f, 0x00, 0x01, 0xeb, 0xad, 0xff, 0xff, 0x54=
,
+  0x05, 0x00, 0x80, 0x52, 0xe4, 0x03, 0x00, 0xaa, 0x83, 0x00, 0x40, 0x39=
,
+  0x63, 0x04, 0x00, 0x11, 0x63, 0x1c, 0x00, 0x12, 0x83, 0x00, 0x00, 0x39=
,
+  0x24, 0x7e, 0x0b, 0xd5, 0x84, 0x04, 0x40, 0x91, 0x9f, 0x00, 0x01, 0xeb=
,
+  0x2b, 0xff, 0xff, 0x54, 0xa5, 0x04, 0x00, 0x11, 0xa5, 0x1c, 0x00, 0x12=
,
+  0xbf, 0x00, 0x00, 0x71, 0x81, 0xfe, 0xff, 0x54, 0x43, 0x08, 0x80, 0x52=
,
+  0x43, 0x00, 0x00, 0x39, 0xf1, 0xff, 0xff, 0x17
+};
diff --git a/tests/migration/migration-test.h b/tests/migration/migration=
-test.h
index c4c0c526b6..6939a134c2 100644
--- a/tests/migration/migration-test.h
+++ b/tests/migration/migration-test.h
@@ -18,4 +18,13 @@
 #define PPC_TEST_MEM_START (1 * 1024 * 1024)
 #define PPC_TEST_MEM_END   (100 * 1024 * 1024)
=20
+/* ARM */
+#define ARM_TEST_MEM_START (0x40000000 + 1 * 1024 * 1024)
+#define ARM_TEST_MEM_END   (0x40000000 + 100 * 1024 * 1024)
+#define ARM_MACH_VIRT_UART 0x09000000
+/* AArch64 kernel load address is 0x40080000, and the test memory starts=
 at
+ * 0x40100000. So the maximum allowable kernel size is 512KB.
+ */
+#define ARM_TEST_MAX_KERNEL_SIZE (512 * 1024)
+
 #endif /* _TEST_MIGRATION_H_ */
--=20
2.19.0
