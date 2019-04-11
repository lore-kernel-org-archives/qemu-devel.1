Received: from eggs.gnu.org ([209.51.188.92]:51841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEaBb-0001Ga-Nd
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:56:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEaBZ-0005lB-Pd
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:56:15 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 11 Apr 2019 15:56:01 +0200
Message-Id: <20190411135602.21725-2-armbru@redhat.com>
In-Reply-To: <20190411135602.21725-1-armbru@redhat.com>
References: <20190411135602.21725-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] pflash_cfi01: New
 pflash_cfi01_legacy_drive()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Factored out of pc_system_firmware_init() so the next commit can reuse
it in hw/arm/virt.c.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/block/pflash_cfi01.c  | 30 ++++++++++++++++++++++++++++++
 hw/i386/pc_sysfw.c       | 19 ++-----------------
 include/hw/block/flash.h |  1 +
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 16dfae14b8..eba01b1447 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -44,9 +44,12 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
+#include "qemu/error-report.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
+#include "qemu/option.h"
 #include "hw/sysbus.h"
+#include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
 
@@ -968,6 +971,33 @@ MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl)
     return &fl->mem;
 }
 
+/*
+ * Handle -drive if=pflash for machines that use machine properties.
+ * Map unit#i (0 < i <= @ndev) to @dev[i]'s property "drive".
+ */
+void pflash_cfi01_legacy_drive(PFlashCFI01 *dev[], int ndev)
+{
+    int i;
+    DriveInfo *dinfo;
+    Location loc;
+
+    for (i = 0; i < ndev; i++) {
+        dinfo = drive_get(IF_PFLASH, 0, i);
+        if (!dinfo) {
+            continue;
+        }
+        loc_push_none(&loc);
+        qemu_opts_loc_restore(dinfo->opts);
+        if (dev[i]->blk) {
+            error_report("clashes with -machine");
+            exit(1);
+        }
+        qdev_prop_set_drive(DEVICE(dev[i]), "drive",
+                            blk_by_legacy_dinfo(dinfo), &error_fatal);
+        loc_pop(&loc);
+    }
+}
+
 static void postload_update_cb(void *opaque, int running, RunState state)
 {
     PFlashCFI01 *pfl = opaque;
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index c628540774..d58e47184c 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -269,32 +269,17 @@ void pc_system_firmware_init(PCMachineState *pcms,
 {
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     int i;
-    DriveInfo *pflash_drv;
     BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
-    Location loc;
 
     if (!pcmc->pci_enabled) {
         old_pc_system_rom_init(rom_memory, true);
         return;
     }
 
-    /* Map legacy -drive if=pflash to machine properties */
+    pflash_cfi01_legacy_drive(pcms->flash, ARRAY_SIZE(pcms->flash));
+
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
         pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
-        pflash_drv = drive_get(IF_PFLASH, 0, i);
-        if (!pflash_drv) {
-            continue;
-        }
-        loc_push_none(&loc);
-        qemu_opts_loc_restore(pflash_drv->opts);
-        if (pflash_blk[i]) {
-            error_report("clashes with -machine");
-            exit(1);
-        }
-        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
-        qdev_prop_set_drive(DEVICE(pcms->flash[i]),
-                            "drive", pflash_blk[i], &error_fatal);
-        loc_pop(&loc);
     }
 
     /* Reject gaps */
diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index a0f488732a..f6a68c2a4c 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -24,6 +24,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
                                    int be);
 BlockBackend *pflash_cfi01_get_blk(PFlashCFI01 *fl);
 MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl);
+void pflash_cfi01_legacy_drive(PFlashCFI01 *dev[], int ndev);
 
 /* pflash_cfi02.c */
 
-- 
2.17.2
