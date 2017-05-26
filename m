Received: from eggs.gnu.org ([2001:4830:134:3::10]:45409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhlcindy@gmail.com>) id 1dEBR5-0002eA-NR
	for qemu-devel@nongnu.org; Fri, 26 May 2017 05:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhlcindy@gmail.com>) id 1dEBR4-0005Xk-MI
	for qemu-devel@nongnu.org; Fri, 26 May 2017 05:21:31 -0400
From: Li Zhang <zhlcindy@gmail.com>
Date: Fri, 26 May 2017 17:21:06 +0800
Message-Id: <1495790468-23862-2-git-send-email-zhlcindy@gmail.com>
In-Reply-To: <1495790468-23862-1-git-send-email-zhlcindy@gmail.com>
References: <1495790468-23862-1-git-send-email-zhlcindy@gmail.com>
Subject: [Qemu-devel] [PATCH 1/3] arm/virt: Refine fdt_add_cpu_nodes code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Li Zhang <li.zhang@hxt-semitech.com>

From: Li Zhang <li.zhang@hxt-semitech.com>

Refind fdt_add_cpu_nodes code and add a new function fdt_add_cpu_node,
which can be called by hot_add_cpu function.

Signed-off-by: Li Zhang <li.zhang@hxt-semitech.com>
---
 hw/arm/virt.c | 106 +++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 61 insertions(+), 45 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c7c8159..73c3cf7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -334,68 +334,84 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
                        GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL2_IRQ, irqflags);
 }
 
-static void fdt_add_cpu_nodes(const VirtMachineState *vms)
+/*
+ * From Documentation/devicetree/bindings/arm/cpus.txt
+ *  On ARM v8 64-bit systems value should be set to 2,
+ *  that corresponds to the MPIDR_EL1 register size.
+ *  If MPIDR_EL1[63:32] value is equal to 0 on all CPUs
+ *  in the system, #address-cells can be set to 1, since
+ *  MPIDR_EL1[63:32] bits are not used for CPUs
+ *  identification.
+ *
+ *  Here we actually don't know whether our system is 32- or 64-bit one.
+ *  The simplest way to go is to examine affinity IDs of all our CPUs. If
+ *  at least one of them has Aff3 populated, we set #address-cells to 2.
+ */
+
+static int fdt_get_addr_cells(const VirtMachineState *vms)
 {
     int cpu;
     int addr_cells = 1;
-    const MachineState *ms = MACHINE(vms);
 
-    /*
-     * From Documentation/devicetree/bindings/arm/cpus.txt
-     *  On ARM v8 64-bit systems value should be set to 2,
-     *  that corresponds to the MPIDR_EL1 register size.
-     *  If MPIDR_EL1[63:32] value is equal to 0 on all CPUs
-     *  in the system, #address-cells can be set to 1, since
-     *  MPIDR_EL1[63:32] bits are not used for CPUs
-     *  identification.
-     *
-     *  Here we actually don't know whether our system is 32- or 64-bit one.
-     *  The simplest way to go is to examine affinity IDs of all our CPUs. If
-     *  at least one of them has Aff3 populated, we set #address-cells to 2.
-     */
     for (cpu = 0; cpu < vms->smp_cpus; cpu++) {
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
-
         if (armcpu->mp_affinity & ARM_AFF3_MASK) {
             addr_cells = 2;
             break;
         }
     }
+    return addr_cells;
+}
 
-    qemu_fdt_add_subnode(vms->fdt, "/cpus");
-    qemu_fdt_setprop_cell(vms->fdt, "/cpus", "#address-cells", addr_cells);
-    qemu_fdt_setprop_cell(vms->fdt, "/cpus", "#size-cells", 0x0);
 
-    for (cpu = vms->smp_cpus - 1; cpu >= 0; cpu--) {
-        char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
-        ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
-        CPUState *cs = CPU(armcpu);
+static void fdt_add_cpu_node(const VirtMachineState *vms, int cpu)
+{
+    char *nodename;
+    int addr_cells = fdt_get_addr_cells(vms);
+    const MachineState *ms = MACHINE(vms);
+    ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
+    CPUState *cs = CPU(armcpu);
 
-        qemu_fdt_add_subnode(vms->fdt, nodename);
-        qemu_fdt_setprop_string(vms->fdt, nodename, "device_type", "cpu");
-        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
-                                    armcpu->dtb_compatible);
-
-        if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED
-            && vms->smp_cpus > 1) {
-            qemu_fdt_setprop_string(vms->fdt, nodename,
-                                        "enable-method", "psci");
-        }
+    if (cpu < 0 || cpu >= max_cpus) {
+        error_report("Invalid cpu index.");
+        return;
+    }
 
-        if (addr_cells == 2) {
-            qemu_fdt_setprop_u64(vms->fdt, nodename, "reg",
-                                 armcpu->mp_affinity);
-        } else {
-            qemu_fdt_setprop_cell(vms->fdt, nodename, "reg",
-                                  armcpu->mp_affinity);
-        }
+    nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
 
-        if (ms->possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
-            qemu_fdt_setprop_cell(vms->fdt, nodename, "numa-node-id",
-                ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
-        }
+    qemu_fdt_add_subnode(vms->fdt, nodename);
+    qemu_fdt_setprop_string(vms->fdt, nodename, "device_type", "cpu");
+    qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
+                            armcpu->dtb_compatible);
+    if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED) {
+        qemu_fdt_setprop_string(vms->fdt, nodename, "enable-method", "psci");
+    }
 
-        g_free(nodename);
+    if (addr_cells == 2) {
+        qemu_fdt_setprop_u64(vms->fdt, nodename, "reg", armcpu->mp_affinity);
+    } else {
+        qemu_fdt_setprop_cell(vms->fdt, nodename, "reg", armcpu->mp_affinity);
+    }
+
+    if (ms->possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
+        qemu_fdt_setprop_cell(vms->fdt, nodename, "numa-node-id",
+            ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
+    }
+
+    g_free(nodename);
+}
+
+static void fdt_add_cpu_nodes(const VirtMachineState *vms)
+{
+    int cpu;
+    int addr_cells = fdt_get_addr_cells(vms);
+
+    qemu_fdt_add_subnode(vms->fdt, "/cpus");
+    qemu_fdt_setprop_cell(vms->fdt, "/cpus", "#address-cells", addr_cells);
+    qemu_fdt_setprop_cell(vms->fdt, "/cpus", "#size-cells", 0x0);
+
+    for (cpu = vms->smp_cpus - 1; cpu >= 0; cpu--) {
+        fdt_add_cpu_node(vms, cpu);
     }
 }
 
-- 
2.7.4
