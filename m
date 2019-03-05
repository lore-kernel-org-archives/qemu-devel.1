Received: from eggs.gnu.org ([209.51.188.92]:54634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHb-0001dF-VS
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHa-0000wW-Sh
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:11 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:40766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DHa-0000va-HW
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:10 -0500
Received: by mail-wr1-x42a.google.com with SMTP id q1so10263477wrp.7
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:51:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id 2sm10071495wrg.89.2019.03.05.08.51.08
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Mar 2019 08:51:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 16:50:42 +0000
Message-Id: <20190305165051.26860-14-peter.maydell@linaro.org>
In-Reply-To: <20190305165051.26860-1-peter.maydell@linaro.org>
References: <20190305165051.26860-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/22] hw/arm/virt: Rename highmem IO regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

In preparation for a split of the memory map into a static
part and a dynamic part floating after the RAM, let's rename the
regions located after the RAM

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20190304101339.25970-3-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h    |  8 ++++----
 hw/arm/virt-acpi-build.c | 10 ++++++----
 hw/arm/virt.c            | 33 ++++++++++++++++++---------------
 3 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 4cc57a7ef62..a27086d524c 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -64,7 +64,7 @@ enum {
     VIRT_GIC_VCPU,
     VIRT_GIC_ITS,
     VIRT_GIC_REDIST,
-    VIRT_GIC_REDIST2,
+    VIRT_HIGH_GIC_REDIST2,
     VIRT_SMMU,
     VIRT_UART,
     VIRT_MMIO,
@@ -74,9 +74,9 @@ enum {
     VIRT_PCIE_MMIO,
     VIRT_PCIE_PIO,
     VIRT_PCIE_ECAM,
-    VIRT_PCIE_ECAM_HIGH,
+    VIRT_HIGH_PCIE_ECAM,
     VIRT_PLATFORM_BUS,
-    VIRT_PCIE_MMIO_HIGH,
+    VIRT_HIGH_PCIE_MMIO,
     VIRT_GPIO,
     VIRT_SECURE_UART,
     VIRT_SECURE_MEM,
@@ -128,7 +128,7 @@ typedef struct {
     int psci_conduit;
 } VirtMachineState;
 
-#define VIRT_ECAM_ID(high) (high ? VIRT_PCIE_ECAM_HIGH : VIRT_PCIE_ECAM)
+#define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
 
 #define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("virt")
 #define VIRT_MACHINE(obj) \
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 04b62c714d9..d7e2e4885b8 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -229,8 +229,8 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
                      size_pio));
 
     if (use_highmem) {
-        hwaddr base_mmio_high = memmap[VIRT_PCIE_MMIO_HIGH].base;
-        hwaddr size_mmio_high = memmap[VIRT_PCIE_MMIO_HIGH].size;
+        hwaddr base_mmio_high = memmap[VIRT_HIGH_PCIE_MMIO].base;
+        hwaddr size_mmio_high = memmap[VIRT_HIGH_PCIE_MMIO].size;
 
         aml_append(rbuf,
             aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
@@ -663,8 +663,10 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             gicr = acpi_data_push(table_data, sizeof(*gicr));
             gicr->type = ACPI_APIC_GENERIC_REDISTRIBUTOR;
             gicr->length = sizeof(*gicr);
-            gicr->base_address = cpu_to_le64(memmap[VIRT_GIC_REDIST2].base);
-            gicr->range_length = cpu_to_le32(memmap[VIRT_GIC_REDIST2].size);
+            gicr->base_address =
+                cpu_to_le64(memmap[VIRT_HIGH_GIC_REDIST2].base);
+            gicr->range_length =
+                cpu_to_le32(memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
         if (its_class_name() && !vmc->no_its) {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 99c2b6e60d7..892bae4f3a7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -150,10 +150,10 @@ static const MemMapEntry a15memmap[] = {
     [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
     [VIRT_MEM] =                { 0x40000000, RAMLIMIT_BYTES },
     /* Additional 64 MB redist region (can contain up to 512 redistributors) */
-    [VIRT_GIC_REDIST2] =        { 0x4000000000ULL, 0x4000000 },
-    [VIRT_PCIE_ECAM_HIGH] =     { 0x4010000000ULL, 0x10000000 },
+    [VIRT_HIGH_GIC_REDIST2] =   { 0x4000000000ULL, 0x4000000 },
+    [VIRT_HIGH_PCIE_ECAM] =     { 0x4010000000ULL, 0x10000000 },
     /* Second PCIe window, 512GB wide at the 512GB boundary */
-    [VIRT_PCIE_MMIO_HIGH] =   { 0x8000000000ULL, 0x8000000000ULL },
+    [VIRT_HIGH_PCIE_MMIO] =     { 0x8000000000ULL, 0x8000000000ULL },
 };
 
 static const int a15irqmap[] = {
@@ -431,12 +431,12 @@ static void fdt_add_gic_node(VirtMachineState *vms)
                                          2, vms->memmap[VIRT_GIC_REDIST].size);
         } else {
             qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
-                                         2, vms->memmap[VIRT_GIC_DIST].base,
-                                         2, vms->memmap[VIRT_GIC_DIST].size,
-                                         2, vms->memmap[VIRT_GIC_REDIST].base,
-                                         2, vms->memmap[VIRT_GIC_REDIST].size,
-                                         2, vms->memmap[VIRT_GIC_REDIST2].base,
-                                         2, vms->memmap[VIRT_GIC_REDIST2].size);
+                                 2, vms->memmap[VIRT_GIC_DIST].base,
+                                 2, vms->memmap[VIRT_GIC_DIST].size,
+                                 2, vms->memmap[VIRT_GIC_REDIST].base,
+                                 2, vms->memmap[VIRT_GIC_REDIST].size,
+                                 2, vms->memmap[VIRT_HIGH_GIC_REDIST2].base,
+                                 2, vms->memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
         if (vms->virt) {
@@ -584,7 +584,7 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
 
         if (nb_redist_regions == 2) {
             uint32_t redist1_capacity =
-                        vms->memmap[VIRT_GIC_REDIST2].size / GICV3_REDIST_SIZE;
+                    vms->memmap[VIRT_HIGH_GIC_REDIST2].size / GICV3_REDIST_SIZE;
 
             qdev_prop_set_uint32(gicdev, "redist-region-count[1]",
                 MIN(smp_cpus - redist0_count, redist1_capacity));
@@ -601,7 +601,8 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
     if (type == 3) {
         sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_REDIST].base);
         if (nb_redist_regions == 2) {
-            sysbus_mmio_map(gicbusdev, 2, vms->memmap[VIRT_GIC_REDIST2].base);
+            sysbus_mmio_map(gicbusdev, 2,
+                            vms->memmap[VIRT_HIGH_GIC_REDIST2].base);
         }
     } else {
         sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_CPU].base);
@@ -1088,8 +1089,8 @@ static void create_pcie(VirtMachineState *vms, qemu_irq *pic)
 {
     hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
     hwaddr size_mmio = vms->memmap[VIRT_PCIE_MMIO].size;
-    hwaddr base_mmio_high = vms->memmap[VIRT_PCIE_MMIO_HIGH].base;
-    hwaddr size_mmio_high = vms->memmap[VIRT_PCIE_MMIO_HIGH].size;
+    hwaddr base_mmio_high = vms->memmap[VIRT_HIGH_PCIE_MMIO].base;
+    hwaddr size_mmio_high = vms->memmap[VIRT_HIGH_PCIE_MMIO].size;
     hwaddr base_pio = vms->memmap[VIRT_PCIE_PIO].base;
     hwaddr size_pio = vms->memmap[VIRT_PCIE_PIO].size;
     hwaddr base_ecam, size_ecam;
@@ -1417,8 +1418,10 @@ static void machvirt_init(MachineState *machine)
      * many redistributors we can fit into the memory map.
      */
     if (vms->gic_version == 3) {
-        virt_max_cpus = vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
-        virt_max_cpus += vms->memmap[VIRT_GIC_REDIST2].size / GICV3_REDIST_SIZE;
+        virt_max_cpus =
+            vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
+        virt_max_cpus +=
+            vms->memmap[VIRT_HIGH_GIC_REDIST2].size / GICV3_REDIST_SIZE;
     } else {
         virt_max_cpus = GIC_NCPU;
     }
-- 
2.20.1
