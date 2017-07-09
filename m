Received: from eggs.gnu.org ([2001:4830:134:3::10]:58706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dUJBq-0001pm-Q6
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dUJBp-0005pR-LY
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:52:26 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Sun,  9 Jul 2017 22:51:28 +0200
Message-Id: <1499633493-19865-4-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1499633493-19865-1-git-send-email-eric.auger@redhat.com>
References: <1499633493-19865-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v5 3/8] hw/arm/virt: Add SMMUv3 to the virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, alex.williamson@redhat.com, prem.mallappa@gmail.com
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mohun106@gmail.com, tcain@qti.qualcomm.com, bharat.bhushan@nxp.com, tn@semihalf.com, mst@redhat.com, will.deacon@arm.com, jean-philippe.brucker@arm.com, robin.murphy@arm.com, peterx@redhat.com, edgar.iglesias@gmail.com

From: Prem Mallappa <prem.mallappa@broadcom.com>

Add code to instantiate an smmu-v3 in mach-virt. A new boolean flag
is introduced in VirtMachineState to allow this instantiation. It
is currently false.

Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v4 -> v5:
- add dma-coherent property

v2 -> v3:
- vbi was removed. Use vms instead
- migrate to new smmu binding format (iommu-map)
- don't use appendprop anymore
- add vms->smmu and guard instantiation with this latter
- interrupts type changed to edge
---
 hw/arm/virt.c         | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h |  4 ++++
 2 files changed, 63 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 010f724..d3848ae 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -56,6 +56,7 @@
 #include "hw/smbios/smbios.h"
 #include "qapi/visitor.h"
 #include "standard-headers/linux/input.h"
+#include "hw/arm/smmuv3.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -139,6 +140,7 @@ static const MemMapEntry a15memmap[] = {
     [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
     [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
     [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
+    [VIRT_SMMU] =               { 0x09050000, 0x00020000 }, /* 128K, needed */
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
@@ -159,6 +161,7 @@ static const int a15irqmap[] = {
     [VIRT_SECURE_UART] = 8,
     [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
+    [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
     [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
 };
 
@@ -991,6 +994,53 @@ static void create_pcie_irq_map(const VirtMachineState *vms,
                            0x7           /* PCI irq */);
 }
 
+static void alloc_smmu_phandle(VirtMachineState *vms)
+{
+    if (vms->smmu && !vms->smmu_phandle) {
+        vms->smmu_phandle = qemu_fdt_alloc_phandle(vms->fdt);
+    }
+}
+
+static void create_smmu(const VirtMachineState *vms, qemu_irq *pic)
+{
+    char *smmu;
+    const char compat[] = "arm,smmu-v3";
+    int irq =  vms->irqmap[VIRT_SMMU];
+    hwaddr base = vms->memmap[VIRT_SMMU].base;
+    hwaddr size = vms->memmap[VIRT_SMMU].size;
+    const char irq_names[] = "eventq\0priq\0cmdq-sync\0gerror";
+
+    if (!vms->smmu) {
+        return;
+    }
+
+    sysbus_create_varargs("smmuv3", base, pic[irq], pic[irq + 1],
+                          pic[irq + 2], pic[irq + 3], NULL);
+
+    smmu = g_strdup_printf("/smmuv3@%" PRIx64, base);
+    qemu_fdt_add_subnode(vms->fdt, smmu);
+    qemu_fdt_setprop(vms->fdt, smmu, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(vms->fdt, smmu, "reg", 2, base, 2, size);
+
+    qemu_fdt_setprop_cells(vms->fdt, smmu, "interrupts",
+            GIC_FDT_IRQ_TYPE_SPI, irq    , GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            GIC_FDT_IRQ_TYPE_SPI, irq + 1, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            GIC_FDT_IRQ_TYPE_SPI, irq + 2, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            GIC_FDT_IRQ_TYPE_SPI, irq + 3, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
+
+    qemu_fdt_setprop(vms->fdt, smmu, "interrupt-names", irq_names,
+                     sizeof(irq_names));
+
+    qemu_fdt_setprop_cell(vms->fdt, smmu, "clocks", vms->clock_phandle);
+    qemu_fdt_setprop_string(vms->fdt, smmu, "clock-names", "apb_pclk");
+    qemu_fdt_setprop(vms->fdt, smmu, "dma-coherent", NULL, 0);
+
+    qemu_fdt_setprop_cell(vms->fdt, smmu, "#iommu-cells", 1);
+
+    qemu_fdt_setprop_cell(vms->fdt, smmu, "phandle", vms->smmu_phandle);
+    g_free(smmu);
+}
+
 static void create_pcie(const VirtMachineState *vms, qemu_irq *pic)
 {
     hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
@@ -1103,6 +1153,11 @@ static void create_pcie(const VirtMachineState *vms, qemu_irq *pic)
     qemu_fdt_setprop_cell(vms->fdt, nodename, "#interrupt-cells", 1);
     create_pcie_irq_map(vms, vms->gic_phandle, irq, nodename);
 
+    if (vms->smmu) {
+        qemu_fdt_setprop_cells(vms->fdt, nodename, "iommu-map",
+                               0x0, vms->smmu_phandle, 0x0, 0x10000);
+    }
+
     g_free(nodename);
 }
 
@@ -1448,8 +1503,12 @@ static void machvirt_init(MachineState *machine)
 
     create_rtc(vms, pic);
 
+    alloc_smmu_phandle(vms);
+
     create_pcie(vms, pic);
 
+    create_smmu(vms, pic);
+
     create_gpio(vms, pic);
 
     /* Create mmio transports, so the user can create virtio backends
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 33b0ff3..164a531 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -38,6 +38,7 @@
 
 #define NUM_GICV2M_SPIS       64
 #define NUM_VIRTIO_TRANSPORTS 32
+#define NUM_SMMU_IRQS          4
 
 #define ARCH_GICV3_MAINT_IRQ  9
 
@@ -59,6 +60,7 @@ enum {
     VIRT_GIC_V2M,
     VIRT_GIC_ITS,
     VIRT_GIC_REDIST,
+    VIRT_SMMU,
     VIRT_UART,
     VIRT_MMIO,
     VIRT_RTC,
@@ -95,6 +97,7 @@ typedef struct {
     bool highmem;
     bool its;
     bool virt;
+    bool smmu;
     int32_t gic_version;
     struct arm_boot_info bootinfo;
     const MemMapEntry *memmap;
@@ -105,6 +108,7 @@ typedef struct {
     uint32_t clock_phandle;
     uint32_t gic_phandle;
     uint32_t msi_phandle;
+    uint32_t smmu_phandle;
     int psci_conduit;
 } VirtMachineState;
 
-- 
2.5.5
