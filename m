Received: from eggs.gnu.org ([2001:4830:134:3::10]:41826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cYaws-0002fk-Lp
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cYawr-0005W5-KN
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:06:26 -0500
From: vijay.kilari@gmail.com
Date: Tue, 31 Jan 2017 21:35:49 +0530
Message-Id: <1485878749-5641-5-git-send-email-vijay.kilari@gmail.com>
In-Reply-To: <1485878749-5641-1-git-send-email-vijay.kilari@gmail.com>
References: <1485878749-5641-1-git-send-email-vijay.kilari@gmail.com>
Subject: [Qemu-devel] [PATCH v7 4/4] hw/intc/arm_gicv3_kvm: Reset GICv3 cpu
 interface registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, peter.maydell@linaro.org, christoffer.dall@linaro.org, eric.auger@redhat.com
Cc: p.fedin@samsung.com, marc.zyngier@arm.com, qemu-devel@nongnu.org, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>

Reset CPU interface registers of GICv3 when CPU is reset.
For this, ARMCPRegInfo struct is registered with one ICC
register whose resetfn is called when cpu is reset.

All the ICC registers are reset under one single register
reset function instead of calling resetfn for each ICC
register.

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
---
 hw/intc/arm_gicv3_kvm.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index f91e0ac..c3f38aa 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -604,6 +604,39 @@ static void kvm_arm_gicv3_get(GICv3State *s)
     }
 }
 
+static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    ARMCPU *cpu;
+    GICv3State *s;
+    GICv3CPUState *c;
+
+    c = (GICv3CPUState *)env->gicv3state;
+    if (!c || !c->cpu || !c->gic) {
+        return;
+    }
+
+    s = c->gic;
+    if (!s) {
+        return;
+    }
+
+    cpu = ARM_CPU(c->cpu);
+    /* Initialize to actual HW supported configuration */
+    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
+                      KVM_VGIC_ATTR(ICC_CTLR_EL1, cpu->mp_affinity),
+                      &c->icc_ctlr_el1[GICV3_NS], false);
+
+    c->icc_ctlr_el1[GICV3_S] = c->icc_ctlr_el1[GICV3_NS];
+    c->icc_pmr_el1 = 0;
+    c->icc_bpr[GICV3_G0] = GIC_MIN_BPR;
+    c->icc_bpr[GICV3_G1] = GIC_MIN_BPR;
+    c->icc_bpr[GICV3_G1NS] = GIC_MIN_BPR;
+
+    c->icc_sre_el1 = 0x7;
+    memset(c->icc_apr, 0, sizeof(c->icc_apr));
+    memset(c->icc_igrpen, 0, sizeof(c->icc_igrpen));
+}
+
 static void kvm_arm_gicv3_reset(DeviceState *dev)
 {
     GICv3State *s = ARM_GICV3_COMMON(dev);
@@ -621,6 +654,41 @@ static void kvm_arm_gicv3_reset(DeviceState *dev)
     kvm_arm_gicv3_put(s);
 }
 
+static uint64_t icc_cp_reg_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return 0;
+}
+
+static void icc_cp_reg_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                          uint64_t value)
+{
+    return;
+}
+
+/*
+ * CPU interface registers of GIC needs to be reset on CPU reset.
+ * For the calling arm_gicv3_icc_reset() on CPU reset, we register
+ * below ARMCPRegInfo. As we reset the whole cpu interface under single
+ * register reset, we define only one register of CPU interface instead
+ * of defining all the registers.
+ */
+static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
+    { .name = "ICC_CTLR_EL1", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 12, .opc2 = 4,
+      .type = ARM_CP_NO_RAW,
+      .access = PL1_RW,
+      .readfn = icc_cp_reg_read,
+      .writefn = icc_cp_reg_write,
+      /*
+       * We hang the whole cpu interface reset routine off here
+       * rather than parcelling it out into one little function
+       * per register
+       */
+      .resetfn = arm_gicv3_icc_reset,
+    },
+    REGINFO_SENTINEL
+};
+
 static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 {
     GICv3State *s = KVM_ARM_GICV3(dev);
@@ -650,6 +718,7 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 
         /* Store GICv3CPUState in CPUARMState gicv3state pointer */
         env->gicv3state = (void *)&s->cpu[i];
+        define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
     }
 
     /* Try to create the device via the device control API */
-- 
1.9.1
