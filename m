Received: from eggs.gnu.org ([2001:4830:134:3::10]:60390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.rikalo@rt-rk.com>) id 1ew8CT-0007EJ-RU
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.rikalo@rt-rk.com>) id 1ew8CO-0006lL-S4
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:20:21 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:42233 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.rikalo@rt-rk.com>)
	id 1ew8CO-0006V0-EA
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:20:16 -0400
From: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Date: Wed, 14 Mar 2018 16:17:55 +0100
Message-Id: <1521040675-31054-1-git-send-email-aleksandar.rikalo@rt-rk.com>
Subject: [Qemu-devel] [PATCH] target-mips: Add initrd support for the Boston
 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paul.burton@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Petar Jovanovic <petar.jovanovic@mips.com>, Aleksandar Rikalo <aleksandar.rikalo@mips.com>

From: Aleksandar Rikalo <aleksandar.rikalo@mips.com>

Add support for initial ramdisk loading for the Mips Boston board.

Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@mips.com>
---
 hw/mips/boston.c | 54 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index fb23161..67ca54f 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -30,6 +30,7 @@
 #include "hw/loader-fit.h"
 #include "hw/mips/cps.h"
 #include "hw/mips/cpudevs.h"
+#include "hw/mips/mips.h"
 #include "hw/pci-host/xilinx-pcie.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
@@ -333,10 +334,12 @@ static const void *boston_fdt_filter(void *opaque, const void *fdt_orig,
 {
     BostonState *s = BOSTON(opaque);
     MachineState *machine = s->mach;
-    const char *cmdline;
+    GString *cmdline;
     int err;
     void *fdt;
     size_t fdt_sz, ram_low_sz, ram_high_sz;
+    long initrd_size;
+    ram_addr_t initrd_offset;
 
     fdt_sz = fdt_totalsize(fdt_orig) * 2;
     fdt = g_malloc0(fdt_sz);
@@ -347,20 +350,53 @@ static const void *boston_fdt_filter(void *opaque, const void *fdt_orig,
         return NULL;
     }
 
-    cmdline = (machine->kernel_cmdline && machine->kernel_cmdline[0])
-            ? machine->kernel_cmdline : " ";
-    err = qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
-    if (err < 0) {
-        fprintf(stderr, "couldn't set /chosen/bootargs\n");
-        return NULL;
-    }
-
     ram_low_sz = MIN(256 * M_BYTE, machine->ram_size);
     ram_high_sz = machine->ram_size - ram_low_sz;
     qemu_fdt_setprop_sized_cells(fdt, "/memory@0", "reg",
                                  1, 0x00000000, 1, ram_low_sz,
                                  1, 0x90000000, 1, ram_high_sz);
 
+    cmdline = g_string_new(machine->kernel_cmdline);
+
+    /* load initrd */
+    initrd_offset = 0;
+    if (machine->initrd_filename) {
+        initrd_size = get_image_size(machine->initrd_filename);
+        if (initrd_size > 0) {
+            /* The kernel allocates the bootmap memory in the low memory after
+               the initrd.  It takes at most 128kiB for 2GB RAM and 4kiB
+               pages.  */
+            initrd_offset = (ram_low_sz - initrd_size - 131072
+                             - ~INITRD_PAGE_MASK) & INITRD_PAGE_MASK;
+
+            if ((int64_t)cpu_mips_kseg0_to_phys(NULL, *load_addr + fdt_sz)
+                >= (int64_t)initrd_offset) {
+                error_report("memory too small for initial ram disk '%s'",
+                             machine->initrd_filename);
+                exit(1);
+            }
+
+            initrd_size = load_image_targphys(machine->initrd_filename,
+                                              initrd_offset,
+                                              initrd_size);
+        }
+        if (initrd_size == (target_ulong) -1) {
+            error_report("could not load initial ram disk '%s'",
+                         machine->initrd_filename);
+            exit(1);
+        }
+        g_string_append_printf(cmdline, " rd_start=0x%" PRIx64 " rd_size=%li",
+                               cpu_mips_phys_to_kseg0(NULL, initrd_offset),
+                               initrd_size);
+    }
+
+    err = qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline->str);
+    g_string_free(cmdline, true);
+    if (err < 0) {
+        fprintf(stderr, "couldn't set /chosen/bootargs\n");
+        return NULL;
+    }
+
     fdt = g_realloc(fdt, fdt_totalsize(fdt));
     qemu_fdt_dumpdtb(fdt, fdt_sz);
 
-- 
1.9.1
