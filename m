Received: from eggs.gnu.org ([2001:4830:134:3::10]:54524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTX-0005xQ-L8
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTW-00045H-02
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:19 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dTUTV-00040L-LX
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:17 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jul 2017 15:42:50 +0100
Message-Id: <1499438577-7674-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
References: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 04/11] memory: Rename memory_region_init_rom()
 and _rom_device() to _nomigrate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Rename memory_region_init_rom() to memory_region_init_rom_nomigrate()
and memory_region_init_rom_device() to
memory_region_init_rom_device_nomigrate().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memory.h   | 40 ++++++++++++++++++++++++----------------
 hw/arm/aspeed.c         |  2 +-
 hw/arm/fsl-imx25.c      |  4 ++--
 hw/arm/fsl-imx31.c      |  4 ++--
 hw/arm/fsl-imx6.c       |  4 ++--
 hw/block/pflash_cfi01.c |  2 +-
 hw/block/pflash_cfi02.c |  2 +-
 hw/mips/boston.c        |  2 +-
 hw/pci/pci.c            |  2 +-
 memory.c                | 24 ++++++++++++------------
 10 files changed, 47 insertions(+), 39 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 2ef3e4f..d1c6443 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -568,12 +568,16 @@ void memory_region_init_alias(MemoryRegion *mr,
                               uint64_t size);
 
 /**
- * memory_region_init_rom: Initialize a ROM memory region.
+ * memory_region_init_rom_nomigrate: Initialize a ROM memory region.
  *
- * This has the same effect as calling memory_region_init_ram()
+ * This has the same effect as calling memory_region_init_ram_nomigrate()
  * and then marking the resulting region read-only with
  * memory_region_set_readonly().
  *
+ * Note that this function does not do anything to cause the data in the
+ * RAM side of the memory region to be migrated; that is the responsibility
+ * of the caller.
+ *
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
  * @name: Region name, becomes part of RAMBlock name used in migration stream
@@ -581,15 +585,19 @@ void memory_region_init_alias(MemoryRegion *mr,
  * @size: size of the region.
  * @errp: pointer to Error*, to store an error if it happens.
  */
-void memory_region_init_rom(MemoryRegion *mr,
-                            struct Object *owner,
-                            const char *name,
-                            uint64_t size,
-                            Error **errp);
+void memory_region_init_rom_nomigrate(MemoryRegion *mr,
+                                      struct Object *owner,
+                                      const char *name,
+                                      uint64_t size,
+                                      Error **errp);
 
 /**
- * memory_region_init_rom_device:  Initialize a ROM memory region.  Writes are
- *                                 handled via callbacks.
+ * memory_region_init_rom_device_nomigrate:  Initialize a ROM memory region.
+ *                                 Writes are handled via callbacks.
+ *
+ * Note that this function does not do anything to cause the data in the
+ * RAM side of the memory region to be migrated; that is the responsibility
+ * of the caller.
  *
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
@@ -599,13 +607,13 @@ void memory_region_init_rom(MemoryRegion *mr,
  * @size: size of the region.
  * @errp: pointer to Error*, to store an error if it happens.
  */
-void memory_region_init_rom_device(MemoryRegion *mr,
-                                   struct Object *owner,
-                                   const MemoryRegionOps *ops,
-                                   void *opaque,
-                                   const char *name,
-                                   uint64_t size,
-                                   Error **errp);
+void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
+                                             struct Object *owner,
+                                             const MemoryRegionOps *ops,
+                                             void *opaque,
+                                             const char *name,
+                                             uint64_t size,
+                                             Error **errp);
 
 /**
  * memory_region_init_reservation: Initialize a memory region that reserves
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index db3f6d2..0c5635f 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -216,7 +216,7 @@ static void aspeed_board_init(MachineState *machine,
          * SoC and 128MB for the AST2500 SoC, which is twice as big as
          * needed by the flash modules of the Aspeed machines.
          */
-        memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
+        memory_region_init_rom_nomigrate(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
                                fl->size, &error_abort);
         memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
                                     boot_rom);
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 0455c2b..cebe0ec 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -249,7 +249,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     }
 
     /* initialize 2 x 16 KB ROM */
-    memory_region_init_rom(&s->rom[0], NULL,
+    memory_region_init_rom_nomigrate(&s->rom[0], NULL,
                            "imx25.rom0", FSL_IMX25_ROM0_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
@@ -257,7 +257,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX25_ROM0_ADDR,
                                 &s->rom[0]);
-    memory_region_init_rom(&s->rom[1], NULL,
+    memory_region_init_rom_nomigrate(&s->rom[1], NULL,
                            "imx25.rom1", FSL_IMX25_ROM1_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 35ad1e7..6c2823a 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -219,7 +219,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
     }
 
     /* On a real system, the first 16k is a `secure boot rom' */
-    memory_region_init_rom(&s->secure_rom, NULL, "imx31.secure_rom",
+    memory_region_init_rom_nomigrate(&s->secure_rom, NULL, "imx31.secure_rom",
                            FSL_IMX31_SECURE_ROM_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
@@ -229,7 +229,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
                                 &s->secure_rom);
 
     /* There is also a 16k ROM */
-    memory_region_init_rom(&s->rom, NULL, "imx31.rom",
+    memory_region_init_rom_nomigrate(&s->rom, NULL, "imx31.rom",
                            FSL_IMX31_ROM_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 7234950..e00b2f9 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -399,7 +399,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                         FSL_IMX6_ENET_MAC_1588_IRQ));
 
     /* ROM memory */
-    memory_region_init_rom(&s->rom, NULL, "imx6.rom",
+    memory_region_init_rom_nomigrate(&s->rom, NULL, "imx6.rom",
                            FSL_IMX6_ROM_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
@@ -409,7 +409,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                 &s->rom);
 
     /* CAAM memory */
-    memory_region_init_rom(&s->caam, NULL, "imx6.caam",
+    memory_region_init_rom_nomigrate(&s->caam, NULL, "imx6.caam",
                            FSL_IMX6_CAAM_MEM_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 594d4cf..c044b56 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -743,7 +743,7 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
         return NULL;
 #endif
 
-    memory_region_init_rom_device(
+    memory_region_init_rom_device_nomigrate(
         &pfl->mem, OBJECT(dev),
         &pflash_cfi01_ops,
         pfl,
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index e6c5c6c..a08b09b 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -621,7 +621,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
         return NULL;
 #endif
 
-    memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl), pfl->be ?
+    memory_region_init_rom_device_nomigrate(&pfl->orig_mem, OBJECT(pfl), pfl->be ?
                                   &pflash_cfi02_ops_be : &pflash_cfi02_ops_le,
                                   pfl, pfl->name, chip_len, &local_err);
     if (local_err) {
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index a4677f7..5946174 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -484,7 +484,7 @@ static void boston_mach_init(MachineState *machine)
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->cps), 0, 0, 1);
 
     flash =  g_new(MemoryRegion, 1);
-    memory_region_init_rom_device(flash, NULL, &boston_flash_ops, s,
+    memory_region_init_rom_device_nomigrate(flash, NULL, &boston_flash_ops, s,
                                   "boston.flash", 128 * M_BYTE, &err);
     memory_region_add_subregion_overlap(sys_mem, 0x18000000, flash, 0);
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0c6f74a..e73279a 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2235,7 +2235,7 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
         snprintf(name, sizeof(name), "%s.rom", object_get_typename(OBJECT(pdev)));
     }
     pdev->has_rom = true;
-    memory_region_init_rom(&pdev->rom, OBJECT(pdev), name, size, &error_fatal);
+    memory_region_init_rom_nomigrate(&pdev->rom, OBJECT(pdev), name, size, &error_fatal);
     vmstate_register_ram(&pdev->rom, &pdev->qdev);
     ptr = memory_region_get_ram_ptr(&pdev->rom);
     load_image(path, ptr);
diff --git a/memory.c b/memory.c
index 9267745..5653d3c 100644
--- a/memory.c
+++ b/memory.c
@@ -1458,11 +1458,11 @@ void memory_region_init_alias(MemoryRegion *mr,
     mr->alias_offset = offset;
 }
 
-void memory_region_init_rom(MemoryRegion *mr,
-                            struct Object *owner,
-                            const char *name,
-                            uint64_t size,
-                            Error **errp)
+void memory_region_init_rom_nomigrate(MemoryRegion *mr,
+                                      struct Object *owner,
+                                      const char *name,
+                                      uint64_t size,
+                                      Error **errp)
 {
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
@@ -1473,13 +1473,13 @@ void memory_region_init_rom(MemoryRegion *mr,
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
 }
 
-void memory_region_init_rom_device(MemoryRegion *mr,
-                                   Object *owner,
-                                   const MemoryRegionOps *ops,
-                                   void *opaque,
-                                   const char *name,
-                                   uint64_t size,
-                                   Error **errp)
+void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
+                                             Object *owner,
+                                             const MemoryRegionOps *ops,
+                                             void *opaque,
+                                             const char *name,
+                                             uint64_t size,
+                                             Error **errp)
 {
     assert(ops);
     memory_region_init(mr, owner, name, size);
-- 
2.7.4
