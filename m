Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDE0C7619B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12972067D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12972067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3b9d-0008E6-MD
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 02:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b33-0004UH-9U
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b30-0000dH-5D
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:33 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45544 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xuyandong2@huawei.com>)
 id 1j3b2r-0000Ot-JZ; Mon, 17 Feb 2020 02:42:22 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 6A3993AAADE75E5B0609;
 Mon, 17 Feb 2020 15:42:19 +0800 (CST)
Received: from localhost (10.175.124.177) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 15:42:11 +0800
From: Xu Yandong <xuyandong2@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH RFC 13/16] hw/arm: move shared fdt related functions to arm.c
 and export them
Date: Mon, 17 Feb 2020 02:51:25 -0500
Message-ID: <1581925888-103620-14-git-send-email-xuyandong2@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
References: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.177]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: zhang.zhanghailiang@huawei.com, slp@redhat.com,
 Xu Yandong <xuyandong2@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move fdt related functions that will be shared between VIRT and
non-VIRT machine types to arm.c.

Signed-off-by: Xu Yandong <xuyandong2@huawei.com>
---
 hw/arm/arm.c         | 226 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/virt.c        | 238 +------------------------------------------
 include/hw/arm/arm.h |   8 ++
 3 files changed, 238 insertions(+), 234 deletions(-)

diff --git a/hw/arm/arm.c b/hw/arm/arm.c
index 6751c6a624..4bffee0f37 100644
--- a/hw/arm/arm.c
+++ b/hw/arm/arm.c
@@ -39,6 +39,232 @@
 #include "hw/intc/arm_gic.h"
 #include "kvm_arm.h"
 
+void create_fdt(ArmMachineState *ams)
+{
+    MachineState *ms = MACHINE(ams);
+    int nb_numa_nodes = ms->numa_state->num_nodes;
+    void *fdt = create_device_tree(&ams->fdt_size);
+
+    if (!fdt) {
+        error_report("create_device_tree() failed");
+        exit(1);
+    }
+
+    ams->fdt = fdt;
+
+    /* Header */
+    qemu_fdt_setprop_string(fdt, "/", "compatible", "linux,dummy-virt");
+    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
+    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
+
+    /* /chosen must exist for load_dtb to fill in necessary properties later */
+    qemu_fdt_add_subnode(fdt, "/chosen");
+
+    /* Clock node, for the benefit of the UART. The kernel device tree
+     * binding documentation claims the PL011 node clock properties are
+     * optional but in practice if you omit them the kernel refuses to
+     * probe for the device.
+     */
+    ams->clock_phandle = qemu_fdt_alloc_phandle(fdt);
+    qemu_fdt_add_subnode(fdt, "/apb-pclk");
+    qemu_fdt_setprop_string(fdt, "/apb-pclk", "compatible", "fixed-clock");
+    qemu_fdt_setprop_cell(fdt, "/apb-pclk", "#clock-cells", 0x0);
+    qemu_fdt_setprop_cell(fdt, "/apb-pclk", "clock-frequency", 24000000);
+    qemu_fdt_setprop_string(fdt, "/apb-pclk", "clock-output-names",
+                                "clk24mhz");
+    qemu_fdt_setprop_cell(fdt, "/apb-pclk", "phandle", ams->clock_phandle);
+
+    if (nb_numa_nodes > 0 && ms->numa_state->have_numa_distance) {
+        int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
+        uint32_t *matrix = g_malloc0(size);
+        int idx, i, j;
+
+        for (i = 0; i < nb_numa_nodes; i++) {
+            for (j = 0; j < nb_numa_nodes; j++) {
+                idx = (i * nb_numa_nodes + j) * 3;
+                matrix[idx + 0] = cpu_to_be32(i);
+                matrix[idx + 1] = cpu_to_be32(j);
+                matrix[idx + 2] =
+                    cpu_to_be32(ms->numa_state->nodes[i].distance[j]);
+            }
+        }
+
+        qemu_fdt_add_subnode(fdt, "/distance-map");
+        qemu_fdt_setprop_string(fdt, "/distance-map", "compatible",
+                                "numa-distance-map-v1");
+        qemu_fdt_setprop(fdt, "/distance-map", "distance-matrix",
+                         matrix, size);
+        g_free(matrix);
+    }
+}
+
+void fdt_add_timer_nodes(const ArmMachineState *ams)
+{
+    /* On real hardware these interrupts are level-triggered.
+     * On KVM they were edge-triggered before host kernel version 4.4,
+     * and level-triggered afterwards.
+     * On emulated QEMU they are level-triggered.
+     *
+     * Getting the DTB info about them wrong is awkward for some
+     * guest kernels:
+     *  pre-4.8 ignore the DT and leave the interrupt configured
+     *   with whatever the GIC reset value (or the bootloader) left it at
+     *  4.8 before rc6 honour the incorrect data by programming it back
+     *   into the GIC, causing problems
+     *  4.8rc6 and later ignore the DT and always write "level triggered"
+     *   into the GIC
+     *
+     * For backwards-compatibility, virt-2.8 and earlier will continue
+     * to say these are edge-triggered, but later machines will report
+     * the correct information.
+     */
+    ARMCPU *armcpu;
+    ArmMachineClass *amc = ARM_MACHINE_GET_CLASS(ams);
+    uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
+
+    if (amc->claim_edge_triggered_timers) {
+        irqflags = GIC_FDT_IRQ_FLAGS_EDGE_LO_HI;
+    }
+
+    if (ams->gic_version == 2) {
+        irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
+                             GIC_FDT_IRQ_PPI_CPU_WIDTH,
+                             (1 << ams->smp_cpus) - 1);
+    }
+
+    qemu_fdt_add_subnode(ams->fdt, "/timer");
+
+    armcpu = ARM_CPU(qemu_get_cpu(0));
+    if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
+        const char compat[] = "arm,armv8-timer\0arm,armv7-timer";
+        qemu_fdt_setprop(ams->fdt, "/timer", "compatible",
+                         compat, sizeof(compat));
+    } else {
+        qemu_fdt_setprop_string(ams->fdt, "/timer", "compatible",
+                                "arm,armv7-timer");
+    }
+    qemu_fdt_setprop(ams->fdt, "/timer", "always-on", NULL, 0);
+    qemu_fdt_setprop_cells(ams->fdt, "/timer", "interrupts",
+                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_S_EL1_IRQ, irqflags,
+                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL1_IRQ, irqflags,
+                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_VIRT_IRQ, irqflags,
+                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL2_IRQ, irqflags);
+}
+
+void fdt_add_cpu_nodes(const ArmMachineState *ams)
+{
+    int cpu;
+    int addr_cells = 1;
+    const MachineState *ms = MACHINE(ams);
+
+    /*
+     * From Documentation/devicetree/bindings/arm/cpus.txt
+     *  On ARM v8 64-bit systems value should be set to 2,
+     *  that corresponds to the MPIDR_EL1 register size.
+     *  If MPIDR_EL1[63:32] value is equal to 0 on all CPUs
+     *  in the system, #address-cells can be set to 1, since
+     *  MPIDR_EL1[63:32] bits are not used for CPUs
+     *  identification.
+     *
+     *  Here we actually don't know whether our system is 32- or 64-bit one.
+     *  The simplest way to go is to examine affinity IDs of all our CPUs. If
+     *  at least one of them has Aff3 populated, we set #address-cells to 2.
+     */
+    for (cpu = 0; cpu < ams->smp_cpus; cpu++) {
+        ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
+
+        if (armcpu->mp_affinity & ARM_AFF3_MASK) {
+            addr_cells = 2;
+            break;
+        }
+    }
+
+    qemu_fdt_add_subnode(ams->fdt, "/cpus");
+    qemu_fdt_setprop_cell(ams->fdt, "/cpus", "#address-cells", addr_cells);
+    qemu_fdt_setprop_cell(ams->fdt, "/cpus", "#size-cells", 0x0);
+
+    for (cpu = ams->smp_cpus - 1; cpu >= 0; cpu--) {
+        char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
+        ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
+        CPUState *cs = CPU(armcpu);
+
+        qemu_fdt_add_subnode(ams->fdt, nodename);
+        qemu_fdt_setprop_string(ams->fdt, nodename, "device_type", "cpu");
+        qemu_fdt_setprop_string(ams->fdt, nodename, "compatible",
+                                    armcpu->dtb_compatible);
+
+        if (ams->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED
+            && ams->smp_cpus > 1) {
+            qemu_fdt_setprop_string(ams->fdt, nodename,
+                                        "enable-method", "psci");
+        }
+
+        if (addr_cells == 2) {
+            qemu_fdt_setprop_u64(ams->fdt, nodename, "reg",
+                                 armcpu->mp_affinity);
+        } else {
+            qemu_fdt_setprop_cell(ams->fdt, nodename, "reg",
+                                  armcpu->mp_affinity);
+        }
+
+        if (ms->possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
+            qemu_fdt_setprop_cell(ams->fdt, nodename, "numa-node-id",
+                ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
+        }
+
+        g_free(nodename);
+    }
+}
+
+void fdt_add_gic_node(ArmMachineState *ams)
+{
+    char *nodename;
+
+    ams->gic_phandle = qemu_fdt_alloc_phandle(ams->fdt);
+    qemu_fdt_setprop_cell(ams->fdt, "/", "interrupt-parent", ams->gic_phandle);
+
+    nodename = g_strdup_printf("/intc@%" PRIx64,
+                               ams->memmap[VIRT_GIC_DIST].base);
+    qemu_fdt_add_subnode(ams->fdt, nodename);
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "#interrupt-cells", 3);
+    qemu_fdt_setprop(ams->fdt, nodename, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "#address-cells", 0x2);
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "#size-cells", 0x2);
+    qemu_fdt_setprop(ams->fdt, nodename, "ranges", NULL, 0);
+    if (ams->gic_version == 3) {
+        int nb_redist_regions = virt_gicv3_redist_region_count(ams);
+
+        qemu_fdt_setprop_string(ams->fdt, nodename, "compatible",
+                                "arm,gic-v3");
+
+        qemu_fdt_setprop_cell(ams->fdt, nodename,
+                              "#redistributor-regions", nb_redist_regions);
+
+        if (nb_redist_regions == 1) {
+            qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
+                                         2, ams->memmap[VIRT_GIC_DIST].base,
+                                         2, ams->memmap[VIRT_GIC_DIST].size,
+                                         2, ams->memmap[VIRT_GIC_REDIST].base,
+                                         2, ams->memmap[VIRT_GIC_REDIST].size);
+        } else {
+            qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
+                                 2, ams->memmap[VIRT_GIC_DIST].base,
+                                 2, ams->memmap[VIRT_GIC_DIST].size,
+                                 2, ams->memmap[VIRT_GIC_REDIST].base,
+                                 2, ams->memmap[VIRT_GIC_REDIST].size,
+                                 2, ams->memmap[VIRT_HIGH_GIC_REDIST2].base,
+                                 2, ams->memmap[VIRT_HIGH_GIC_REDIST2].size);
+        }
+    } else {
+        /* 'cortex-a15-gic' means 'GIC v2' */
+        qemu_fdt_setprop_string(ams->fdt, nodename, "compatible",
+                                "arm,cortex-a15-gic");
+    }
+
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "phandle", ams->gic_phandle);
+    g_free(nodename);
+}
+
 void qdev_create_gic(ArmMachineState *ams)
 {
     MachineState *ms = MACHINE(ams);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b3267b873a..11e753906b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -204,186 +204,6 @@ static bool cpu_type_valid(const char *cpu)
     return false;
 }
 
-static void create_fdt(VirtMachineState *vms)
-{
-    MachineState *ms = MACHINE(vms);
-    ArmMachineState *ams = ARM_MACHINE(vms);
-    int nb_numa_nodes = ms->numa_state->num_nodes;
-    void *fdt = create_device_tree(&ams->fdt_size);
-
-    if (!fdt) {
-        error_report("create_device_tree() failed");
-        exit(1);
-    }
-
-    ams->fdt = fdt;
-
-    /* Header */
-    qemu_fdt_setprop_string(fdt, "/", "compatible", "linux,dummy-virt");
-    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
-    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
-
-    /* /chosen must exist for load_dtb to fill in necessary properties later */
-    qemu_fdt_add_subnode(fdt, "/chosen");
-
-    /* Clock node, for the benefit of the UART. The kernel device tree
-     * binding documentation claims the PL011 node clock properties are
-     * optional but in practice if you omit them the kernel refuses to
-     * probe for the device.
-     */
-    ams->clock_phandle = qemu_fdt_alloc_phandle(fdt);
-    qemu_fdt_add_subnode(fdt, "/apb-pclk");
-    qemu_fdt_setprop_string(fdt, "/apb-pclk", "compatible", "fixed-clock");
-    qemu_fdt_setprop_cell(fdt, "/apb-pclk", "#clock-cells", 0x0);
-    qemu_fdt_setprop_cell(fdt, "/apb-pclk", "clock-frequency", 24000000);
-    qemu_fdt_setprop_string(fdt, "/apb-pclk", "clock-output-names",
-                                "clk24mhz");
-    qemu_fdt_setprop_cell(fdt, "/apb-pclk", "phandle", ams->clock_phandle);
-
-    if (nb_numa_nodes > 0 && ms->numa_state->have_numa_distance) {
-        int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
-        uint32_t *matrix = g_malloc0(size);
-        int idx, i, j;
-
-        for (i = 0; i < nb_numa_nodes; i++) {
-            for (j = 0; j < nb_numa_nodes; j++) {
-                idx = (i * nb_numa_nodes + j) * 3;
-                matrix[idx + 0] = cpu_to_be32(i);
-                matrix[idx + 1] = cpu_to_be32(j);
-                matrix[idx + 2] =
-                    cpu_to_be32(ms->numa_state->nodes[i].distance[j]);
-            }
-        }
-
-        qemu_fdt_add_subnode(fdt, "/distance-map");
-        qemu_fdt_setprop_string(fdt, "/distance-map", "compatible",
-                                "numa-distance-map-v1");
-        qemu_fdt_setprop(fdt, "/distance-map", "distance-matrix",
-                         matrix, size);
-        g_free(matrix);
-    }
-}
-
-static void fdt_add_timer_nodes(const VirtMachineState *vms)
-{
-    /* On real hardware these interrupts are level-triggered.
-     * On KVM they were edge-triggered before host kernel version 4.4,
-     * and level-triggered afterwards.
-     * On emulated QEMU they are level-triggered.
-     *
-     * Getting the DTB info about them wrong is awkward for some
-     * guest kernels:
-     *  pre-4.8 ignore the DT and leave the interrupt configured
-     *   with whatever the GIC reset value (or the bootloader) left it at
-     *  4.8 before rc6 honour the incorrect data by programming it back
-     *   into the GIC, causing problems
-     *  4.8rc6 and later ignore the DT and always write "level triggered"
-     *   into the GIC
-     *
-     * For backwards-compatibility, virt-2.8 and earlier will continue
-     * to say these are edge-triggered, but later machines will report
-     * the correct information.
-     */
-    ARMCPU *armcpu;
-    ArmMachineState *ams = ARM_MACHINE(vms);
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
-    uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
-
-    if (vmc->claim_edge_triggered_timers) {
-        irqflags = GIC_FDT_IRQ_FLAGS_EDGE_LO_HI;
-    }
-
-    if (ams->gic_version == 2) {
-        irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
-                             GIC_FDT_IRQ_PPI_CPU_WIDTH,
-                             (1 << ams->smp_cpus) - 1);
-    }
-
-    qemu_fdt_add_subnode(ams->fdt, "/timer");
-
-    armcpu = ARM_CPU(qemu_get_cpu(0));
-    if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
-        const char compat[] = "arm,armv8-timer\0arm,armv7-timer";
-        qemu_fdt_setprop(ams->fdt, "/timer", "compatible",
-                         compat, sizeof(compat));
-    } else {
-        qemu_fdt_setprop_string(ams->fdt, "/timer", "compatible",
-                                "arm,armv7-timer");
-    }
-    qemu_fdt_setprop(ams->fdt, "/timer", "always-on", NULL, 0);
-    qemu_fdt_setprop_cells(ams->fdt, "/timer", "interrupts",
-                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_S_EL1_IRQ, irqflags,
-                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL1_IRQ, irqflags,
-                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_VIRT_IRQ, irqflags,
-                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL2_IRQ, irqflags);
-}
-
-static void fdt_add_cpu_nodes(const VirtMachineState *vms)
-{
-    int cpu;
-    int addr_cells = 1;
-    const MachineState *ms = MACHINE(vms);
-    const ArmMachineState *ams = ARM_MACHINE(vms);
-
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
-    for (cpu = 0; cpu < ams->smp_cpus; cpu++) {
-        ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
-
-        if (armcpu->mp_affinity & ARM_AFF3_MASK) {
-            addr_cells = 2;
-            break;
-        }
-    }
-
-    qemu_fdt_add_subnode(ams->fdt, "/cpus");
-    qemu_fdt_setprop_cell(ams->fdt, "/cpus", "#address-cells", addr_cells);
-    qemu_fdt_setprop_cell(ams->fdt, "/cpus", "#size-cells", 0x0);
-
-    for (cpu = ams->smp_cpus - 1; cpu >= 0; cpu--) {
-        char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
-        ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
-        CPUState *cs = CPU(armcpu);
-
-        qemu_fdt_add_subnode(ams->fdt, nodename);
-        qemu_fdt_setprop_string(ams->fdt, nodename, "device_type", "cpu");
-        qemu_fdt_setprop_string(ams->fdt, nodename, "compatible",
-                                    armcpu->dtb_compatible);
-
-        if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED
-            && ams->smp_cpus > 1) {
-            qemu_fdt_setprop_string(ams->fdt, nodename,
-                                        "enable-method", "psci");
-        }
-
-        if (addr_cells == 2) {
-            qemu_fdt_setprop_u64(ams->fdt, nodename, "reg",
-                                 armcpu->mp_affinity);
-        } else {
-            qemu_fdt_setprop_cell(ams->fdt, nodename, "reg",
-                                  armcpu->mp_affinity);
-        }
-
-        if (ms->possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
-            qemu_fdt_setprop_cell(ams->fdt, nodename, "numa-node-id",
-                ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
-        }
-
-        g_free(nodename);
-    }
-}
-
 static void fdt_add_its_gic_node(VirtMachineState *vms)
 {
     char *nodename;
@@ -461,56 +281,6 @@ static void fdt_gic_set_virt_extension(VirtMachineState *vms)
     }
 }
 
-static void fdt_add_gic_node(VirtMachineState *vms)
-{
-    char *nodename;
-    ArmMachineState *ams = ARM_MACHINE(vms);
-
-    ams->gic_phandle = qemu_fdt_alloc_phandle(ams->fdt);
-    qemu_fdt_setprop_cell(ams->fdt, "/", "interrupt-parent", ams->gic_phandle);
-
-    nodename = g_strdup_printf("/intc@%" PRIx64,
-                               ams->memmap[VIRT_GIC_DIST].base);
-    qemu_fdt_add_subnode(ams->fdt, nodename);
-    qemu_fdt_setprop_cell(ams->fdt, nodename, "#interrupt-cells", 3);
-    qemu_fdt_setprop(ams->fdt, nodename, "interrupt-controller", NULL, 0);
-    qemu_fdt_setprop_cell(ams->fdt, nodename, "#address-cells", 0x2);
-    qemu_fdt_setprop_cell(ams->fdt, nodename, "#size-cells", 0x2);
-    qemu_fdt_setprop(ams->fdt, nodename, "ranges", NULL, 0);
-    if (ams->gic_version == 3) {
-        int nb_redist_regions = virt_gicv3_redist_region_count(ams);
-
-        qemu_fdt_setprop_string(ams->fdt, nodename, "compatible",
-                                "arm,gic-v3");
-
-        qemu_fdt_setprop_cell(ams->fdt, nodename,
-                              "#redistributor-regions", nb_redist_regions);
-
-        if (nb_redist_regions == 1) {
-            qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
-                                         2, ams->memmap[VIRT_GIC_DIST].base,
-                                         2, ams->memmap[VIRT_GIC_DIST].size,
-                                         2, ams->memmap[VIRT_GIC_REDIST].base,
-                                         2, ams->memmap[VIRT_GIC_REDIST].size);
-        } else {
-            qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
-                                 2, ams->memmap[VIRT_GIC_DIST].base,
-                                 2, ams->memmap[VIRT_GIC_DIST].size,
-                                 2, ams->memmap[VIRT_GIC_REDIST].base,
-                                 2, ams->memmap[VIRT_GIC_REDIST].size,
-                                 2, ams->memmap[VIRT_HIGH_GIC_REDIST2].base,
-                                 2, ams->memmap[VIRT_HIGH_GIC_REDIST2].size);
-        }
-    } else {
-        /* 'cortex-a15-gic' means 'GIC v2' */
-        qemu_fdt_setprop_string(ams->fdt, nodename, "compatible",
-                                "arm,cortex-a15-gic");
-    }
-
-    qemu_fdt_setprop_cell(ams->fdt, nodename, "phandle", ams->gic_phandle);
-    g_free(nodename);
-}
-
 static void fdt_add_pmu_nodes(const VirtMachineState *vms)
 {
     CPUState *cpu;
@@ -681,7 +451,7 @@ static void create_gic(VirtMachineState *vms)
 
     init_gic_sysbus(ams);
     set_gic_virt_sysbus(vms);
-    fdt_add_gic_node(vms);
+    fdt_add_gic_node(ams);
     fdt_gic_set_virt_extension(vms);
 
     gic_set_msi_interrupt(vms);
@@ -1470,7 +1240,7 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    create_fdt(vms);
+    create_fdt(ams);
 
     possible_cpus = mc->possible_cpu_arch_ids(machine);
     for (n = 0; n < possible_cpus->len; n++) {
@@ -1536,8 +1306,8 @@ static void machvirt_init(MachineState *machine)
         object_property_set_bool(cpuobj, true, "realized", &error_fatal);
         object_unref(cpuobj);
     }
-    fdt_add_timer_nodes(vms);
-    fdt_add_cpu_nodes(vms);
+    fdt_add_timer_nodes(ams);
+    fdt_add_cpu_nodes(ams);
 
    if (!kvm_enabled()) {
         ARMCPU *cpu = ARM_CPU(first_cpu);
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index 8fec23985e..743a90ba36 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -111,6 +111,14 @@ typedef struct {
 #define ARM_MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(ArmMachineClass, klass, TYPE_ARM_MACHINE)
 
+void create_fdt(ArmMachineState *ams);
+
+void fdt_add_timer_nodes(const ArmMachineState *ams);
+
+void fdt_add_cpu_nodes(const ArmMachineState *ams);
+
+void fdt_add_gic_node(ArmMachineState *ams);
+
 void qdev_create_gic(ArmMachineState *ams);
 
 void init_gic_sysbus(ArmMachineState *ams);
-- 
2.18.1


