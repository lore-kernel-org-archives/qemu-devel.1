Received: from eggs.gnu.org ([2001:4830:134:3::10]:37963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpgK-0006zK-9p
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpgG-0004JT-9S
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:24:36 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  1 Sep 2017 19:21:20 +0200
Message-Id: <1504286483-23327-18-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v7 17/20] hw/arm/sysbus-fdt: Allow smmuv3
 dynamic instantiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com, alex.williamson@redhat.com
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mohun106@gmail.com, tcain@qti.qualcomm.com, bharat.bhushan@nxp.com, tn@semihalf.com, mst@redhat.com, will.deacon@arm.com, jean-philippe.brucker@arm.com, robin.murphy@arm.com, peterx@redhat.com, edgar.iglesias@gmail.com, wtownsen@redhat.com

This patch adds a node creation function for the smmuv3. Using
"-device smmuv3" it is now possible to get the iommu instantiated
on ARM VIRT machine. The node creation function handles the creation
of the smmuv3 node and also add the iommu-map property on the generic
PCI host controller node.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3.c     |   2 +
 hw/arm/sysbus-fdt.c | 110 ++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 96 insertions(+), 16 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c43bd93..9c8640f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1121,6 +1121,8 @@ static void smmuv3_class_init(ObjectClass *klass, void *data)
     dc->reset   = smmu_reset;
     dc->vmsd    = &vmstate_smmuv3;
     dc->realize = smmu_realize;
+    /* Supported by TYPE_VIRT_MACHINE */
+    dc->user_creatable = true;
 }
 
 static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index f8c4909..9bbfbde 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -36,6 +36,7 @@
 #include "hw/vfio/vfio-platform.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
 #include "hw/vfio/vfio-amd-xgbe.h"
+#include "hw/arm/smmuv3.h"
 #include "hw/arm/virt.h"
 #include "hw/arm/fdt.h"
 
@@ -126,6 +127,31 @@ static HostProperty clock_copied_properties[] = {
     {"clock-output-names", true},
 };
 
+static char *fdt_get_node_path(void *fdt, int phandle)
+{
+    char *node_path = NULL;
+    int ret, node_offset, path_len = 16;;
+
+    node_offset = fdt_node_offset_by_phandle(fdt, phandle);
+    if (node_offset <= 0) {
+        error_setg(&error_fatal,
+                   "not able to locate clock handle %d in device tree",
+                   phandle);
+    }
+
+    node_path = g_malloc(path_len);
+    while ((ret = fdt_get_path(fdt, node_offset, node_path, path_len))
+            == -FDT_ERR_NOSPACE) {
+        path_len += 16;
+        node_path = g_realloc(node_path, path_len);
+    }
+    if (ret < 0) {
+        g_free(node_path);
+        node_path = NULL;
+    }
+    return node_path;
+}
+
 /**
  * fdt_build_clock_node
  *
@@ -142,24 +168,12 @@ static void fdt_build_clock_node(void *host_fdt, void *guest_fdt,
                                 uint32_t host_phandle,
                                 uint32_t guest_phandle)
 {
-    char *node_path = NULL;
-    char *nodename;
+    char *node_path, *nodename;
     const void *r;
-    int ret, node_offset, prop_len, path_len = 16;
+    int prop_len;
 
-    node_offset = fdt_node_offset_by_phandle(host_fdt, host_phandle);
-    if (node_offset <= 0) {
-        error_setg(&error_fatal,
-                   "not able to locate clock handle %d in host device tree",
-                   host_phandle);
-    }
-    node_path = g_malloc(path_len);
-    while ((ret = fdt_get_path(host_fdt, node_offset, node_path, path_len))
-            == -FDT_ERR_NOSPACE) {
-        path_len += 16;
-        node_path = g_realloc(node_path, path_len);
-    }
-    if (ret < 0) {
+    node_path = fdt_get_node_path(host_fdt, host_phandle);
+    if (!node_path) {
         error_setg(&error_fatal,
                    "not able to retrieve node path for clock handle %d",
                    host_phandle);
@@ -416,6 +430,69 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
     return 0;
 }
 
+static int add_smmuv3_fdt_node(SysBusDevice *sbdev, void *opaque)
+{
+    const char irq_names[] = "eventq\0priq\0cmdq-sync\0gerror";
+    const char compat[] = "arm,smmu-v3";
+    uint32_t reg_attr[2], irq_attr[12], smmu_phandle;
+    uint64_t mmio_base, irq_number;
+    PlatformBusFDTData *data = opaque;
+    const char *parent_node = data->pbus_node_name;
+    PlatformBusDevice *pbus = data->pbus;
+    VirtMachineState *vms = data->vms;
+    void *guest_fdt = data->fdt;
+    char *nodename, *node_path;
+    int i;
+
+    mmio_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    nodename = g_strdup_printf("%s/%s@%" PRIx64, parent_node,
+                               "smmuv3", mmio_base);
+    qemu_fdt_add_subnode(guest_fdt, nodename);
+
+    qemu_fdt_setprop(guest_fdt, nodename, "compatible", compat, sizeof(compat));
+
+    reg_attr[0] = cpu_to_be32(mmio_base);
+    reg_attr[1] = cpu_to_be32(0x20000);
+    qemu_fdt_setprop(guest_fdt, nodename, "reg",
+                     reg_attr, 2 * sizeof(uint32_t));
+
+    for (i = 0; i < 4; i++) {
+        irq_number = platform_bus_get_irqn(pbus, sbdev , i) + data->irq_start;
+        irq_attr[3 * i] = cpu_to_be32(GIC_FDT_IRQ_TYPE_SPI);
+        irq_attr[3 * i + 1] = cpu_to_be32(irq_number);
+        irq_attr[3 * i + 2] = cpu_to_be32(GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
+    }
+    qemu_fdt_setprop(guest_fdt, nodename, "interrupts",
+                     irq_attr, 4 * 3 * sizeof(uint32_t));
+    qemu_fdt_setprop(guest_fdt, nodename, "interrupt-names", irq_names,
+                     sizeof(irq_names));
+
+    qemu_fdt_setprop_cell(guest_fdt, nodename, "clocks", vms->clock_phandle);
+    qemu_fdt_setprop_string(guest_fdt, nodename, "clock-names", "apb_pclk");
+    qemu_fdt_setprop(guest_fdt, nodename, "dma-coherent", NULL, 0);
+
+    qemu_fdt_setprop_cell(guest_fdt, nodename, "#iommu-cells", 1);
+
+    smmu_phandle = qemu_fdt_alloc_phandle(vms->fdt);
+
+    qemu_fdt_setprop_cell(guest_fdt, nodename, "phandle", smmu_phandle);
+
+    node_path = fdt_get_node_path(guest_fdt, vms->pcihost_phandle);
+    if (!node_path) {
+        error_setg(&error_fatal,
+                   "not able to retrieve node path for pci ctlr phandle %d",
+                   vms->pcihost_phandle);
+    }
+
+    qemu_fdt_setprop_cells(guest_fdt, node_path, "iommu-map",
+                     0x0, smmu_phandle, 0x0, 0x10000);
+
+    g_free(nodename);
+    g_free(node_path);
+
+    return 0;
+}
+
 #endif /* CONFIG_LINUX */
 
 /* list of supported dynamic sysbus devices */
@@ -423,6 +500,7 @@ static const NodeCreationPair add_fdt_node_functions[] = {
 #ifdef CONFIG_LINUX
     {TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node},
     {TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node},
+    {TYPE_SMMU_V3_DEV, add_smmuv3_fdt_node},
 #endif
     {"", NULL}, /* last element */
 };
-- 
2.5.5
