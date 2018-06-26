Received: from eggs.gnu.org ([2001:4830:134:3::10]:56280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fXuTC-0007xa-JZ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 16:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fXuTA-00072d-QJ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 16:21:46 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 26 Jun 2018 22:21:31 +0200
Message-Id: <1530044492-24921-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1530044492-24921-1-git-send-email-eric.auger@redhat.com>
References: <1530044492-24921-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/3] hw/arm/virt: Silence dtc /intc warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, crosthwaite.peter@gmail.com, agraf@suse.de

When running dtc on the guest /proc/device-tree we get the
following warnings: "Warning (unit_address_vs_reg): Node <name>
has a reg or ranges property, but no unit name", with name:
/intc, /intc/its, /intc/v2m.

Nodes should have a name in the form <name>[@<unit-address>] where
unit-address is the primary address used to access the device, listed
in the node's reg property. This fix seems to make dtc happy.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 63 ++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 742f68a..6cce282 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -369,58 +369,72 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
 
 static void fdt_add_its_gic_node(VirtMachineState *vms)
 {
+    char *nodename;
+
     vms->msi_phandle = qemu_fdt_alloc_phandle(vms->fdt);
-    qemu_fdt_add_subnode(vms->fdt, "/intc/its");
-    qemu_fdt_setprop_string(vms->fdt, "/intc/its", "compatible",
+    nodename = g_strdup_printf("/intc/its@%" PRIx64,
+                               vms->memmap[VIRT_GIC_ITS].base);
+    qemu_fdt_add_subnode(vms->fdt, nodename);
+    qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
                             "arm,gic-v3-its");
-    qemu_fdt_setprop(vms->fdt, "/intc/its", "msi-controller", NULL, 0);
-    qemu_fdt_setprop_sized_cells(vms->fdt, "/intc/its", "reg",
+    qemu_fdt_setprop(vms->fdt, nodename, "msi-controller", NULL, 0);
+    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
                                  2, vms->memmap[VIRT_GIC_ITS].base,
                                  2, vms->memmap[VIRT_GIC_ITS].size);
-    qemu_fdt_setprop_cell(vms->fdt, "/intc/its", "phandle", vms->msi_phandle);
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle", vms->msi_phandle);
+    g_free(nodename);
 }
 
 static void fdt_add_v2m_gic_node(VirtMachineState *vms)
 {
+    char *nodename;
+
+    nodename = g_strdup_printf("/intc/v2m@%" PRIx64,
+                               vms->memmap[VIRT_GIC_V2M].base);
     vms->msi_phandle = qemu_fdt_alloc_phandle(vms->fdt);
-    qemu_fdt_add_subnode(vms->fdt, "/intc/v2m");
-    qemu_fdt_setprop_string(vms->fdt, "/intc/v2m", "compatible",
+    qemu_fdt_add_subnode(vms->fdt, nodename);
+    qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
                             "arm,gic-v2m-frame");
-    qemu_fdt_setprop(vms->fdt, "/intc/v2m", "msi-controller", NULL, 0);
-    qemu_fdt_setprop_sized_cells(vms->fdt, "/intc/v2m", "reg",
+    qemu_fdt_setprop(vms->fdt, nodename, "msi-controller", NULL, 0);
+    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
                                  2, vms->memmap[VIRT_GIC_V2M].base,
                                  2, vms->memmap[VIRT_GIC_V2M].size);
-    qemu_fdt_setprop_cell(vms->fdt, "/intc/v2m", "phandle", vms->msi_phandle);
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle", vms->msi_phandle);
+    g_free(nodename);
 }
 
 static void fdt_add_gic_node(VirtMachineState *vms)
 {
+    char *nodename;
+
     vms->gic_phandle = qemu_fdt_alloc_phandle(vms->fdt);
     qemu_fdt_setprop_cell(vms->fdt, "/", "interrupt-parent", vms->gic_phandle);
 
-    qemu_fdt_add_subnode(vms->fdt, "/intc");
-    qemu_fdt_setprop_cell(vms->fdt, "/intc", "#interrupt-cells", 3);
-    qemu_fdt_setprop(vms->fdt, "/intc", "interrupt-controller", NULL, 0);
-    qemu_fdt_setprop_cell(vms->fdt, "/intc", "#address-cells", 0x2);
-    qemu_fdt_setprop_cell(vms->fdt, "/intc", "#size-cells", 0x2);
-    qemu_fdt_setprop(vms->fdt, "/intc", "ranges", NULL, 0);
+    nodename = g_strdup_printf("/intc@%" PRIx64,
+                               vms->memmap[VIRT_GIC_DIST].base);
+    qemu_fdt_add_subnode(vms->fdt, nodename);
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "#interrupt-cells", 3);
+    qemu_fdt_setprop(vms->fdt, nodename, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "#address-cells", 0x2);
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "#size-cells", 0x2);
+    qemu_fdt_setprop(vms->fdt, nodename, "ranges", NULL, 0);
     if (vms->gic_version == 3) {
         int nb_redist_regions = virt_gicv3_redist_region_count(vms);
 
-        qemu_fdt_setprop_string(vms->fdt, "/intc", "compatible",
+        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
                                 "arm,gic-v3");
 
-        qemu_fdt_setprop_cell(vms->fdt, "/intc",
+        qemu_fdt_setprop_cell(vms->fdt, nodename,
                               "#redistributor-regions", nb_redist_regions);
 
         if (nb_redist_regions == 1) {
-            qemu_fdt_setprop_sized_cells(vms->fdt, "/intc", "reg",
+            qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
                                          2, vms->memmap[VIRT_GIC_DIST].base,
                                          2, vms->memmap[VIRT_GIC_DIST].size,
                                          2, vms->memmap[VIRT_GIC_REDIST].base,
                                          2, vms->memmap[VIRT_GIC_REDIST].size);
         } else {
-            qemu_fdt_setprop_sized_cells(vms->fdt, "/intc", "reg",
+            qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
                                          2, vms->memmap[VIRT_GIC_DIST].base,
                                          2, vms->memmap[VIRT_GIC_DIST].size,
                                          2, vms->memmap[VIRT_GIC_REDIST].base,
@@ -430,22 +444,23 @@ static void fdt_add_gic_node(VirtMachineState *vms)
         }
 
         if (vms->virt) {
-            qemu_fdt_setprop_cells(vms->fdt, "/intc", "interrupts",
+            qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
                                    GIC_FDT_IRQ_TYPE_PPI, ARCH_GICV3_MAINT_IRQ,
                                    GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         }
     } else {
         /* 'cortex-a15-gic' means 'GIC v2' */
-        qemu_fdt_setprop_string(vms->fdt, "/intc", "compatible",
+        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
                                 "arm,cortex-a15-gic");
-        qemu_fdt_setprop_sized_cells(vms->fdt, "/intc", "reg",
+        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
                                       2, vms->memmap[VIRT_GIC_DIST].base,
                                       2, vms->memmap[VIRT_GIC_DIST].size,
                                       2, vms->memmap[VIRT_GIC_CPU].base,
                                       2, vms->memmap[VIRT_GIC_CPU].size);
     }
 
-    qemu_fdt_setprop_cell(vms->fdt, "/intc", "phandle", vms->gic_phandle);
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle", vms->gic_phandle);
+    g_free(nodename);
 }
 
 static void fdt_add_pmu_nodes(const VirtMachineState *vms)
-- 
2.5.5
