Received: from eggs.gnu.org ([2001:4830:134:3::10]:34586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eZk2g-00050M-GA
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eZk2f-00006y-D6
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:05:42 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:45697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eZk2f-00006B-2z
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:05:41 -0500
Received: by mail-lf0-x244.google.com with SMTP id y71so3974204lfd.12
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 13:05:40 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 11 Jan 2018 13:04:59 -0800
Message-Id: <1515704703-10347-6-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1515704703-10347-1-git-send-email-jcmvbkbc@gmail.com>
References: <1515704703-10347-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 5/9] hw/xtensa/xtfpga: extract flash
 configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Extract flash configuration into a separate structure to make it easier
to share between MMU and noMMU configurations.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 hw/xtensa/xtfpga.c | 66 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 40e16baa7c34..53bd61fb96df 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -46,11 +46,15 @@
 #include "bootparam.h"
 #include "xtensa_memory.h"
 
+typedef struct XtfpgaFlashDesc {
+    hwaddr base;
+    size_t size;
+    size_t boot_base;
+    size_t sector_size;
+} XtfpgaFlashDesc;
+
 typedef struct XtfpgaBoardDesc {
-    hwaddr flash_base;
-    size_t flash_size;
-    size_t flash_boot_base;
-    size_t flash_sector_size;
+    const XtfpgaFlashDesc *flash;
     size_t sram_size;
 } XtfpgaBoardDesc;
 
@@ -164,14 +168,14 @@ static pflash_t *xtfpga_flash_init(MemoryRegion *address_space,
     qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo),
                         &error_abort);
     qdev_prop_set_uint32(dev, "num-blocks",
-                         board->flash_size / board->flash_sector_size);
-    qdev_prop_set_uint64(dev, "sector-length", board->flash_sector_size);
+                         board->flash->size / board->flash->sector_size);
+    qdev_prop_set_uint64(dev, "sector-length", board->flash->sector_size);
     qdev_prop_set_uint8(dev, "width", 2);
     qdev_prop_set_bit(dev, "big-endian", be);
     qdev_prop_set_string(dev, "name", "xtfpga.io.flash");
     qdev_init_nofail(dev);
     s = SYS_BUS_DEVICE(dev);
-    memory_region_add_subregion(address_space, board->flash_base,
+    memory_region_add_subregion(address_space, board->flash->base,
                                 sysbus_mmio_get_region(s, 0));
     return OBJECT_CHECK(pflash_t, (dev), "cfi.pflash01");
 }
@@ -421,12 +425,12 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
             MemoryRegion *flash_io = g_malloc(sizeof(*flash_io));
             uint32_t size = env->config->sysrom.location[0].size;
 
-            if (board->flash_size - board->flash_boot_base < size) {
-                size = board->flash_size - board->flash_boot_base;
+            if (board->flash->size - board->flash->boot_base < size) {
+                size = board->flash->size - board->flash->boot_base;
             }
 
             memory_region_init_alias(flash_io, NULL, "xtfpga.flash",
-                                     flash_mr, board->flash_boot_base, size);
+                                     flash_mr, board->flash->boot_base, size);
             memory_region_add_subregion(system_memory,
                                         env->config->sysrom.location[0].addr,
                                         flash_io);
@@ -437,46 +441,62 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     }
 }
 
+static const XtfpgaFlashDesc lx60_flash = {
+    .base = 0x08000000,
+    .size = 0x00400000,
+    .sector_size = 0x10000,
+};
+
 static void xtfpga_lx60_init(MachineState *machine)
 {
     static const XtfpgaBoardDesc lx60_board = {
-        .flash_base = 0x08000000,
-        .flash_size = 0x00400000,
-        .flash_sector_size = 0x10000,
+        .flash = &lx60_flash,
         .sram_size = 0x20000,
     };
     xtfpga_init(&lx60_board, machine);
 }
 
+static const XtfpgaFlashDesc lx200_flash = {
+    .base = 0x08000000,
+    .size = 0x01000000,
+    .sector_size = 0x20000,
+};
+
 static void xtfpga_lx200_init(MachineState *machine)
 {
     static const XtfpgaBoardDesc lx200_board = {
-        .flash_base = 0x08000000,
-        .flash_size = 0x01000000,
-        .flash_sector_size = 0x20000,
+        .flash = &lx200_flash,
         .sram_size = 0x2000000,
     };
     xtfpga_init(&lx200_board, machine);
 }
 
+static const XtfpgaFlashDesc ml605_flash = {
+    .base = 0x08000000,
+    .size = 0x01000000,
+    .sector_size = 0x20000,
+};
+
 static void xtfpga_ml605_init(MachineState *machine)
 {
     static const XtfpgaBoardDesc ml605_board = {
-        .flash_base = 0x08000000,
-        .flash_size = 0x01000000,
-        .flash_sector_size = 0x20000,
+        .flash = &ml605_flash,
         .sram_size = 0x2000000,
     };
     xtfpga_init(&ml605_board, machine);
 }
 
+static const XtfpgaFlashDesc kc705_flash = {
+    .base = 0x00000000,
+    .size = 0x08000000,
+    .boot_base = 0x06000000,
+    .sector_size = 0x20000,
+};
+
 static void xtfpga_kc705_init(MachineState *machine)
 {
     static const XtfpgaBoardDesc kc705_board = {
-        .flash_base = 0x00000000,
-        .flash_size = 0x08000000,
-        .flash_boot_base = 0x06000000,
-        .flash_sector_size = 0x20000,
+        .flash = &kc705_flash,
         .sram_size = 0x2000000,
     };
     xtfpga_init(&kc705_board, machine);
-- 
2.1.4
