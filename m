Received: from eggs.gnu.org ([2001:4830:134:3::10]:48215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1duDI8-0001Ip-Ce
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1duDI7-0001fB-07
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:50:00 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 19 Sep 2017 09:46:44 +0200
Message-Id: <1505807208-9063-13-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1505807208-9063-1-git-send-email-eric.auger@redhat.com>
References: <1505807208-9063-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v4 12/16] hw/arm/virt: Add virtio-iommu to the
 virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com, linuc.decode@gmail.com

The specific virtio-mmio node is inconditionally added on
machine init while the binding between this latter and the
PCIe host bridge is done on machine init done notifier, only
if -device virtio-iommu-device was added to the qemu command
line.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
---
 hw/arm/virt.c         | 92 +++++++++++++++++++++++++++++++++++++++++++++++----
 include/hw/arm/virt.h |  4 +++
 2 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9737a5f..f057d7a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -52,6 +52,7 @@
 #include "hw/arm/fdt.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/virtio/virtio-iommu.h"
 #include "kvm_arm.h"
 #include "hw/smbios/smbios.h"
 #include "qapi/visitor.h"
@@ -139,6 +140,7 @@ static const MemMapEntry a15memmap[] = {
     [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
     [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
     [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
+    [VIRT_IOMMU] =              { 0x09050000, 0x00000200 },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
@@ -159,6 +161,7 @@ static const int a15irqmap[] = {
     [VIRT_SECURE_UART] = 8,
     [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
+    [VIRT_IOMMU] = 74,
     [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
 };
 
@@ -999,7 +1002,81 @@ static void create_pcie_irq_map(const VirtMachineState *vms,
                            0x7           /* PCI irq */);
 }
 
-static void create_pcie(const VirtMachineState *vms, qemu_irq *pic)
+static int bind_virtio_iommu_device(Object *obj, void *opaque)
+{
+    VirtMachineState *vms = (VirtMachineState *)opaque;
+    struct arm_boot_info *info = &vms->bootinfo;
+    int dtb_size;
+    void *fdt = info->get_dtb(info, &dtb_size);
+    Object *dev;
+
+    dev = object_dynamic_cast(obj, TYPE_VIRTIO_IOMMU);
+
+    if (!dev) {
+        /* Container, traverse it for children */
+        return object_child_foreach(obj, bind_virtio_iommu_device, opaque);
+    }
+
+    qemu_fdt_setprop_cells(fdt, vms->pcie_host_nodename, "iommu-map",
+                           0x0, vms->iommu_phandle, 0x0, 0x10000);
+
+    return true;
+}
+
+static
+void virtio_iommu_notifier(Notifier *notifier, void *data)
+{
+    VirtMachineState *vms = container_of(notifier, VirtMachineState,
+                                         virtio_iommu_done);
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+    Object *container;
+
+
+    if (vmc->no_iommu) {
+        return;
+    }
+
+    container = container_get(qdev_get_machine(), "/peripheral");
+    bind_virtio_iommu_device(container, vms);
+    container = container_get(qdev_get_machine(), "/peripheral-anon");
+    bind_virtio_iommu_device(container, vms);
+}
+
+static void create_virtio_iommu(VirtMachineState *vms, qemu_irq *pic)
+{
+    char *smmu;
+    const char compat[] = "virtio,mmio";
+    int irq =  vms->irqmap[VIRT_IOMMU];
+    hwaddr base = vms->memmap[VIRT_IOMMU].base;
+    hwaddr size = vms->memmap[VIRT_IOMMU].size;
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+
+    if (vmc->no_iommu) {
+        return;
+    }
+
+    vms->iommu_phandle = qemu_fdt_alloc_phandle(vms->fdt);
+
+    sysbus_create_simple("virtio-mmio", base, pic[irq]);
+
+    smmu = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
+    qemu_fdt_add_subnode(vms->fdt, smmu);
+    qemu_fdt_setprop(vms->fdt, smmu, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(vms->fdt, smmu, "reg", 2, base, 2, size);
+
+    qemu_fdt_setprop_cells(vms->fdt, smmu, "interrupts",
+            GIC_FDT_IRQ_TYPE_SPI, irq, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
+
+    qemu_fdt_setprop(vms->fdt, smmu, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop_cell(vms->fdt, smmu, "#iommu-cells", 1);
+    qemu_fdt_setprop_cell(vms->fdt, smmu, "phandle", vms->iommu_phandle);
+    g_free(smmu);
+
+    vms->virtio_iommu_done.notify = virtio_iommu_notifier;
+    qemu_add_machine_init_done_notifier(&vms->virtio_iommu_done);
+}
+
+static void create_pcie(VirtMachineState *vms, qemu_irq *pic)
 {
     hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
     hwaddr size_mmio = vms->memmap[VIRT_PCIE_MMIO].size;
@@ -1073,7 +1150,8 @@ static void create_pcie(const VirtMachineState *vms, qemu_irq *pic)
         }
     }
 
-    nodename = g_strdup_printf("/pcie@%" PRIx64, base);
+    vms->pcie_host_nodename = g_strdup_printf("/pcie@%" PRIx64, base);
+    nodename = vms->pcie_host_nodename;
     qemu_fdt_add_subnode(vms->fdt, nodename);
     qemu_fdt_setprop_string(vms->fdt, nodename,
                             "compatible", "pci-host-ecam-generic");
@@ -1112,7 +1190,6 @@ static void create_pcie(const VirtMachineState *vms, qemu_irq *pic)
     qemu_fdt_setprop_cell(vms->fdt, nodename, "#interrupt-cells", 1);
     create_pcie_irq_map(vms, vms->gic_phandle, irq, nodename);
 
-    g_free(nodename);
 }
 
 static void create_platform_bus(VirtMachineState *vms, qemu_irq *pic)
@@ -1457,16 +1534,16 @@ static void machvirt_init(MachineState *machine)
 
     create_rtc(vms, pic);
 
-    create_pcie(vms, pic);
-
-    create_gpio(vms, pic);
-
     /* Create mmio transports, so the user can create virtio backends
      * (which will be automatically plugged in to the transports). If
      * no backend is created the transport will just sit harmlessly idle.
      */
     create_virtio_devices(vms, pic);
 
+    create_pcie(vms, pic);
+
+    create_gpio(vms, pic);
+
     vms->fw_cfg = create_fw_cfg(vms, &address_space_memory);
     rom_set_fw(vms->fw_cfg);
 
@@ -1491,6 +1568,7 @@ static void machvirt_init(MachineState *machine)
      * Notifiers are executed in registration reverse order.
      */
     create_platform_bus(vms, pic);
+    create_virtio_iommu(vms, pic);
 }
 
 static bool virt_get_secure(Object *obj, Error **errp)
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index ff27551..e00fa65 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -59,6 +59,7 @@ enum {
     VIRT_GIC_V2M,
     VIRT_GIC_ITS,
     VIRT_GIC_REDIST,
+    VIRT_IOMMU,
     VIRT_UART,
     VIRT_MMIO,
     VIRT_RTC,
@@ -91,6 +92,7 @@ typedef struct {
 typedef struct {
     MachineState parent;
     Notifier machine_done;
+    Notifier virtio_iommu_done;
     FWCfgState *fw_cfg;
     bool secure;
     bool highmem;
@@ -106,6 +108,8 @@ typedef struct {
     uint32_t clock_phandle;
     uint32_t gic_phandle;
     uint32_t msi_phandle;
+    uint32_t iommu_phandle;
+    char *pcie_host_nodename;
     int psci_conduit;
 } VirtMachineState;
 
-- 
2.5.5
