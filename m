Received: from eggs.gnu.org ([2001:4830:134:3::10]:35452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cwePp-0002YL-Hm
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cwePn-0007xO-QI
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:39:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:44873)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cwePn-0007w8-HP
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:39:43 -0400
From: Anthony Xu <anthony.xu@intel.com>
Date: Fri,  7 Apr 2017 17:45:35 -0700
Message-Id: <1491612336-31066-4-git-send-email-anthony.xu@intel.com>
In-Reply-To: <1491612336-31066-1-git-send-email-anthony.xu@intel.com>
References: <1491612336-31066-1-git-send-email-anthony.xu@intel.com>
Subject: [Qemu-devel] [PATCH 3/4] pam: disable pc.rom when pam is disabled
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

pc.rom depends on pam. When pam is disabled, pc.rom is useless

Signed-off-by: Anthony Xu <anthony.xu@intel.com>
---
 hw/i386/pc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9d154c2..455f7fe 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1358,7 +1358,7 @@ void pc_memory_init(PCMachineState *pcms,
                     MemoryRegion **ram_memory)
 {
     int linux_boot, i;
-    MemoryRegion *ram, *option_rom_mr;
+    MemoryRegion *ram;
     MemoryRegion *ram_below_4g, *ram_above_4g;
     FWCfgState *fw_cfg;
     MachineState *machine = MACHINE(pcms);
@@ -1445,15 +1445,16 @@ void pc_memory_init(PCMachineState *pcms,
     /* Initialize PC system firmware */
     pc_system_firmware_init(rom_memory, !pcmc->pci_enabled);
 
-    option_rom_mr = g_malloc(sizeof(*option_rom_mr));
-    memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
+    if (pcms->pam) {
+        MemoryRegion *option_rom_mr = g_malloc(sizeof(*option_rom_mr));
+        memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
                            &error_fatal);
-    vmstate_register_ram_global(option_rom_mr);
-    memory_region_add_subregion_overlap(rom_memory,
+        vmstate_register_ram_global(option_rom_mr);
+        memory_region_add_subregion_overlap(rom_memory,
                                         PC_ROM_MIN_VGA,
                                         option_rom_mr,
                                         1);
-
+    }
     fw_cfg = bochs_bios_init(&address_space_memory, pcms);
 
     rom_set_fw(fw_cfg);
-- 
1.8.3.1
