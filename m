Received: from eggs.gnu.org ([2001:4830:134:3::10]:58669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fmlun-0006fg-72
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 16:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fmlum-00075p-09
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 16:15:41 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  6 Aug 2018 22:14:42 +0200
Message-Id: <1533586484-5737-15-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1533586484-5737-1-git-send-email-eric.auger@redhat.com>
References: <1533586484-5737-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v7 14/16] hw/arm/virt: Add virtio-iommu to the
 virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com, linuc.decode@gmail.com

Both the virtio-iommu device and its dedicated mmio
transport get instantiated when requested.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v6 -> v7:
- align to the smmu instantiation code

v4 -> v5:
- VirtMachineClass no_iommu added in this patch
- Use object_resolve_path_type
---
 hw/arm/virt.c         | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/hw/arm/virt.h |  1 +
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 281ddcd..dd3cc71 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -29,6 +29,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "monitor/qdev.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/arm/arm.h"
@@ -59,6 +60,7 @@
 #include "qapi/visitor.h"
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
+#include "hw/virtio/virtio-iommu.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -141,6 +143,7 @@ static const MemMapEntry a15memmap[] = {
     [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
     [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
     [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
+    [VIRT_VIRTIO_IOMMU] =       { 0x09070000, 0x00000200 },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
@@ -165,6 +168,7 @@ static const int a15irqmap[] = {
     [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
     [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
+    [VIRT_VIRTIO_IOMMU] = 75,
     [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
 };
 
@@ -1047,6 +1051,42 @@ static void create_smmu(const VirtMachineState *vms, qemu_irq *pic,
     g_free(node);
 }
 
+static void create_virtio_iommu(VirtMachineState *vms, qemu_irq *pic,
+                                PCIBus *bus)
+{
+    const char compat[] = "virtio,mmio";
+    int irq =  vms->irqmap[VIRT_VIRTIO_IOMMU];
+    hwaddr base = vms->memmap[VIRT_VIRTIO_IOMMU].base;
+    hwaddr size = vms->memmap[VIRT_VIRTIO_IOMMU].size;
+    DeviceState *dev;
+    BusState *virtio_bus;
+    char *node;
+
+    sysbus_create_simple("virtio-mmio", base, pic[irq]);
+
+    virtio_bus = qbus_find_recursive(sysbus_get_default(), NULL, "virtio-bus");
+    dev = DEVICE(object_new("virtio-iommu-device"));
+    qdev_set_parent_bus(dev, virtio_bus);
+    object_property_set_link(OBJECT(dev), OBJECT(bus), "primary-bus",
+                             &error_abort);
+    object_property_set_bool(OBJECT(dev), false, "msi_bypass", &error_fatal);
+    object_property_set_bool(OBJECT(dev), true, "realized", &error_abort);
+
+    node = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
+    qemu_fdt_add_subnode(vms->fdt, node);
+    qemu_fdt_setprop(vms->fdt, node, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(vms->fdt, node, "reg", 2, base, 2, size);
+
+    qemu_fdt_setprop_cells(vms->fdt, node, "interrupts",
+            GIC_FDT_IRQ_TYPE_SPI, irq, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
+
+    qemu_fdt_setprop(vms->fdt, node, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop_cell(vms->fdt, node, "#iommu-cells", 1);
+    qemu_fdt_setprop_cell(vms->fdt, node, "phandle", vms->iommu_phandle);
+    g_free(node);
+}
+
+
 static void create_pcie(VirtMachineState *vms, qemu_irq *pic)
 {
     hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
@@ -1167,7 +1207,16 @@ static void create_pcie(VirtMachineState *vms, qemu_irq *pic)
     if (vms->iommu) {
         vms->iommu_phandle = qemu_fdt_alloc_phandle(vms->fdt);
 
-        create_smmu(vms, pic, pci->bus);
+        switch (vms->iommu) {
+        case VIRT_IOMMU_SMMUV3:
+            create_smmu(vms, pic, pci->bus);
+            break;
+        case VIRT_IOMMU_VIRTIO:
+            create_virtio_iommu(vms, pic, pci->bus);
+            break;
+        default:
+            g_assert_not_reached();
+        }
 
         qemu_fdt_setprop_cells(vms->fdt, nodename, "iommu-map",
                                0x0, vms->iommu_phandle, 0x0, 0x10000);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 9a870cc..837c135 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -64,6 +64,7 @@ enum {
     VIRT_GIC_REDIST,
     VIRT_GIC_REDIST2,
     VIRT_SMMU,
+    VIRT_VIRTIO_IOMMU,
     VIRT_UART,
     VIRT_MMIO,
     VIRT_RTC,
-- 
2.5.5
