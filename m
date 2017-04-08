Received: from eggs.gnu.org ([2001:4830:134:3::10]:35459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cwePp-0002YQ-K1
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cwePo-0007xZ-6D
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:39:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:37867)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cwePn-0007wz-Sf
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:39:44 -0400
From: Anthony Xu <anthony.xu@intel.com>
Date: Fri,  7 Apr 2017 17:45:36 -0700
Message-Id: <1491612336-31066-5-git-send-email-anthony.xu@intel.com>
In-Reply-To: <1491612336-31066-1-git-send-email-anthony.xu@intel.com>
References: <1491612336-31066-1-git-send-email-anthony.xu@intel.com>
Subject: [Qemu-devel] [PATCH 4/4] pam: setup pc.bios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, Anthony Xu <anthony.xu@intel.com>

when pam is disabled, set pc.bios and isa.bios region as writeable,
and add isa.bios to system memory region.

Signed-off-by: Anthony Xu <anthony.xu@intel.com>
---
 hw/i386/pc.c         |  2 +-
 hw/i386/pc_sysfw.c   | 30 +++++++++++++++++++++---------
 include/hw/i386/pc.h |  4 +++-
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 455f7fe..3e23f58 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1443,7 +1443,7 @@ void pc_memory_init(PCMachineState *pcms,
     }
 
     /* Initialize PC system firmware */
-    pc_system_firmware_init(rom_memory, !pcmc->pci_enabled);
+    pc_system_firmware_init(system_memory, rom_memory, !pcmc->pci_enabled);
 
     if (pcms->pam) {
         MemoryRegion *option_rom_mr = g_malloc(sizeof(*option_rom_mr));
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index f915ad0..e5ac615 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -173,7 +173,8 @@ static void pc_system_flash_init(MemoryRegion *rom_memory)
     }
 }
 
-static void old_pc_system_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
+static void old_pc_system_rom_init(MemoryRegion *system_memory,
+                                   MemoryRegion *rom_memory, bool isapc_ram_fw)
 {
     char *filename;
     MemoryRegion *bios, *isa_bios;
@@ -197,8 +198,11 @@ static void old_pc_system_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
     bios = g_malloc(sizeof(*bios));
     memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
     vmstate_register_ram_global(bios);
-    if (!isapc_ram_fw) {
-        memory_region_set_readonly(bios, true);
+    if (PC_MACHINE(current_machine)->pam) {
+        /* if PAM is disabled, set it as readwrite */
+        if (!isapc_ram_fw) {
+            memory_region_set_readonly(bios, true);
+        }
     }
     ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
     if (ret != 0) {
@@ -216,21 +220,29 @@ static void old_pc_system_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
     isa_bios = g_malloc(sizeof(*isa_bios));
     memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
                              bios_size - isa_bios_size, isa_bios_size);
-    memory_region_add_subregion_overlap(rom_memory,
+    if (PC_MACHINE(current_machine)->pam) {
+        memory_region_add_subregion_overlap(rom_memory,
+                                        0x100000 - isa_bios_size,
+                                        isa_bios,
+                                        1);
+        if (!isapc_ram_fw) {
+            memory_region_set_readonly(isa_bios, true);
+        }
+    } else {
+        /* if PAM is disabed, add isa-bios to system memory region */
+        memory_region_add_subregion_overlap(system_memory,
                                         0x100000 - isa_bios_size,
                                         isa_bios,
                                         1);
-    if (!isapc_ram_fw) {
-        memory_region_set_readonly(isa_bios, true);
     }
-
     /* map all the bios at the top of memory */
     memory_region_add_subregion(rom_memory,
                                 (uint32_t)(-bios_size),
                                 bios);
 }
 
-void pc_system_firmware_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
+void pc_system_firmware_init(MemoryRegion *system_memory,
+                             MemoryRegion *rom_memory, bool isapc_ram_fw)
 {
     DriveInfo *pflash_drv;
 
@@ -238,7 +250,7 @@ void pc_system_firmware_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
 
     if (isapc_ram_fw || pflash_drv == NULL) {
         /* When a pflash drive is not found, use rom-mode */
-        old_pc_system_rom_init(rom_memory, isapc_ram_fw);
+        old_pc_system_rom_init(system_memory, rom_memory, isapc_ram_fw);
         return;
     }
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 05f4df5..eb5b853 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -354,7 +354,9 @@ static inline bool isa_ne2000_init(ISABus *bus, int base, int irq, NICInfo *nd)
 }
 
 /* pc_sysfw.c */
-void pc_system_firmware_init(MemoryRegion *rom_memory,
+
+void pc_system_firmware_init(MemoryRegion *system_memory,
+                             MemoryRegion *rom_memory,
                              bool isapc_ram_fw);
 
 /* pvpanic.c */
-- 
1.8.3.1
