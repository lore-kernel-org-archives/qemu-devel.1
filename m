Received: from eggs.gnu.org ([2001:4830:134:3::10]:45868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f0pOS-0003MJ-8E
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f0pOM-0006md-7k
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:16:08 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 27 Mar 2018 16:15:20 +0200
Message-Id: <1522160122-10744-7-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
References: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 6/8] hw/arm/virt: Allow GICv3 DT node with
 multiple redistributor regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: drjones@redhat.com, wei@redhat.com, marc.zyngier@arm.com, cdall@kernel.org, zhaoshenglong@huawei.com

This patch adds the GICState handle in the virtual machine state and
allows to create a GIC device tree node advertising multiple redistributor
regions.

There is one range per distributor region following the GIC distributor.
Please refer to kernel documentation for further details:
Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c         | 32 +++++++++++++++++++++++++++-----
 include/hw/arm/virt.h |  2 ++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0eef6aa..8258f6f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -401,13 +401,34 @@ static void fdt_add_gic_node(VirtMachineState *vms)
     qemu_fdt_setprop_cell(vms->fdt, "/intc", "#size-cells", 0x2);
     qemu_fdt_setprop(vms->fdt, "/intc", "ranges", NULL, 0);
     if (vms->gic_version == 3) {
+        GICv3State *s = (GICv3State *)vms->gic;
+        uint64_t num_reg_values;
+        uint64_t *regs;
+        int r;
+
         qemu_fdt_setprop_string(vms->fdt, "/intc", "compatible",
                                 "arm,gic-v3");
-        qemu_fdt_setprop_sized_cells(vms->fdt, "/intc", "reg",
-                                     2, vms->memmap[VIRT_GIC_DIST].base,
-                                     2, vms->memmap[VIRT_GIC_DIST].size,
-                                     2, vms->memmap[VIRT_GIC_REDIST].base,
-                                     2, vms->memmap[VIRT_GIC_REDIST].size);
+
+        num_reg_values =  4 * (s->nb_redist_regions + 1);
+        regs = g_new0(uint64_t, num_reg_values);
+        qemu_fdt_setprop_cell(vms->fdt, "/intc", "#redistributor-regions",
+                              s->nb_redist_regions);
+        regs[0] = 2;
+        regs[1] = vms->memmap[VIRT_GIC_DIST].base;
+        regs[2] = 2;
+        regs[3] = vms->memmap[VIRT_GIC_DIST].size;
+
+        for (r = 1; r <= s->nb_redist_regions; r++) {
+            regs[4 * r] = 2;
+            regs[4 * r  + 1] = s->redist_region[r - 1].base;
+            regs[4 * r  + 2] = 2;
+            /* count redistributors of 2 x 64kB pages */
+            regs[4 * r  + 3] = (uint64_t)s->redist_region[r - 1].count << 17;
+        }
+        qemu_fdt_setprop_sized_cells_from_array(vms->fdt, "/intc", "reg",
+                                                num_reg_values / 2, regs);
+        g_free(regs);
+
         if (vms->virt) {
             qemu_fdt_setprop_cells(vms->fdt, "/intc", "interrupts",
                                    GIC_FDT_IRQ_TYPE_PPI, ARCH_GICV3_MAINT_IRQ,
@@ -513,6 +534,7 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
     gictype = (type == 3) ? gicv3_class_name() : gic_class_name();
 
     gicdev = qdev_create(NULL, gictype);
+    vms->gic = (GICState *)gicdev;
     qdev_prop_set_uint32(gicdev, "revision", type);
     qdev_prop_set_uint32(gicdev, "num-cpu", smp_cpus);
     /* Note that the num-irq property counts both internal and external
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index ba0c1a4..d168291 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -35,6 +35,7 @@
 #include "qemu/notify.h"
 #include "hw/boards.h"
 #include "hw/arm/arm.h"
+#include "hw/intc/arm_gic_common.h"
 
 #define NUM_GICV2M_SPIS       64
 #define NUM_VIRTIO_TRANSPORTS 32
@@ -92,6 +93,7 @@ typedef struct {
     MachineState parent;
     Notifier machine_done;
     FWCfgState *fw_cfg;
+    GICState *gic;
     bool secure;
     bool highmem;
     bool its;
-- 
2.5.5
