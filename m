Received: from eggs.gnu.org ([2001:4830:134:3::10]:49856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcz-0003Rg-VO
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcy-00059c-PH
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:26 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWLcy-00051P-Bh
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:24 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLct-0003sa-F6
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:57:19 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:56:53 +0100
Message-Id: <20180622125713.15303-9-peter.maydell@linaro.org>
In-Reply-To: <20180622125713.15303-1-peter.maydell@linaro.org>
References: <20180622125713.15303-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 08/28] hw/arm/virt: GICv3 DT node with one or
 two redistributor regions
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

This patch allows the creation of a GICv3 node with 1 or 2
redistributor regions depending on the number of smu_cpus.
The second redistributor region is located just after the
existing RAM region, at 256GB and contains up to up to 512 vcpus.

Please refer to kernel documentation for further node details:
Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 1529072910-16156-6-git-send-email-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h | 14 ++++++++++++++
 hw/arm/virt.c         | 29 ++++++++++++++++++++++++-----
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 4ac7ef6a374..308156f0cdf 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -35,6 +35,8 @@
 #include "qemu/notify.h"
 #include "hw/boards.h"
 #include "hw/arm/arm.h"
+#include "sysemu/kvm.h"
+#include "hw/intc/arm_gicv3_common.h"
 
 #define NUM_GICV2M_SPIS       64
 #define NUM_VIRTIO_TRANSPORTS 32
@@ -60,6 +62,7 @@ enum {
     VIRT_GIC_V2M,
     VIRT_GIC_ITS,
     VIRT_GIC_REDIST,
+    VIRT_GIC_REDIST2,
     VIRT_SMMU,
     VIRT_UART,
     VIRT_MMIO,
@@ -130,4 +133,15 @@ typedef struct {
 
 void virt_acpi_setup(VirtMachineState *vms);
 
+/* Return the number of used redistributor regions  */
+static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
+{
+    uint32_t redist0_capacity =
+                vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
+
+    assert(vms->gic_version == 3);
+
+    return vms->smp_cpus > redist0_capacity ? 2 : 1;
+}
+
 #endif /* QEMU_ARM_VIRT_H */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index de189c72960..e5e7606946f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -149,6 +149,8 @@ static const MemMapEntry a15memmap[] = {
     [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
     [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
     [VIRT_MEM] =                { 0x40000000, RAMLIMIT_BYTES },
+    /* Additional 64 MB redist region (can contain up to 512 redistributors) */
+    [VIRT_GIC_REDIST2] =        { 0x4000000000ULL, 0x4000000 },
     /* Second PCIe window, 512GB wide at the 512GB boundary */
     [VIRT_PCIE_MMIO_HIGH] =   { 0x8000000000ULL, 0x8000000000ULL },
 };
@@ -402,13 +404,30 @@ static void fdt_add_gic_node(VirtMachineState *vms)
     qemu_fdt_setprop_cell(vms->fdt, "/intc", "#size-cells", 0x2);
     qemu_fdt_setprop(vms->fdt, "/intc", "ranges", NULL, 0);
     if (vms->gic_version == 3) {
+        int nb_redist_regions = virt_gicv3_redist_region_count(vms);
+
         qemu_fdt_setprop_string(vms->fdt, "/intc", "compatible",
                                 "arm,gic-v3");
-        qemu_fdt_setprop_sized_cells(vms->fdt, "/intc", "reg",
-                                     2, vms->memmap[VIRT_GIC_DIST].base,
-                                     2, vms->memmap[VIRT_GIC_DIST].size,
-                                     2, vms->memmap[VIRT_GIC_REDIST].base,
-                                     2, vms->memmap[VIRT_GIC_REDIST].size);
+
+        qemu_fdt_setprop_cell(vms->fdt, "/intc",
+                              "#redistributor-regions", nb_redist_regions);
+
+        if (nb_redist_regions == 1) {
+            qemu_fdt_setprop_sized_cells(vms->fdt, "/intc", "reg",
+                                         2, vms->memmap[VIRT_GIC_DIST].base,
+                                         2, vms->memmap[VIRT_GIC_DIST].size,
+                                         2, vms->memmap[VIRT_GIC_REDIST].base,
+                                         2, vms->memmap[VIRT_GIC_REDIST].size);
+        } else {
+            qemu_fdt_setprop_sized_cells(vms->fdt, "/intc", "reg",
+                                         2, vms->memmap[VIRT_GIC_DIST].base,
+                                         2, vms->memmap[VIRT_GIC_DIST].size,
+                                         2, vms->memmap[VIRT_GIC_REDIST].base,
+                                         2, vms->memmap[VIRT_GIC_REDIST].size,
+                                         2, vms->memmap[VIRT_GIC_REDIST2].base,
+                                         2, vms->memmap[VIRT_GIC_REDIST2].size);
+        }
+
         if (vms->virt) {
             qemu_fdt_setprop_cells(vms->fdt, "/intc", "interrupts",
                                    GIC_FDT_IRQ_TYPE_PPI, ARCH_GICV3_MAINT_IRQ,
-- 
2.17.1
