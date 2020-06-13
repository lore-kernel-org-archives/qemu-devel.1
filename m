Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1174CC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:53:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB5220792
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB5220792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkE5k-0003fE-28
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 17:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDyi-0007v9-Os; Sat, 13 Jun 2020 17:46:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44728 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDyg-0003UX-5l; Sat, 13 Jun 2020 17:46:16 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A0730870F7F55669E4BE;
 Sun, 14 Jun 2020 05:46:11 +0800 (CST)
Received: from A190218597.china.huawei.com (10.47.30.60) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sun, 14 Jun 2020 05:46:04 +0800
From: Salil Mehta <salil.mehta@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH RFC 19/22] arm/cpuhp: Changes required to (re)init the vcpu
 register info
Date: Sat, 13 Jun 2020 22:36:26 +0100
Message-ID: <20200613213629.21984-20-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20200613213629.21984-1-salil.mehta@huawei.com>
References: <20200613213629.21984-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.30.60]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=salil.mehta@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 17:44:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, sudeep.holla@arm.com,
 gshan@redhat.com, mst@redhat.com, jiakernel2@gmail.com, maz@kernel.org,
 zhukeqian1@huawei.com, david@redhat.com, richard.henderson@linaro.org,
 linuxarm@huawei.com, eric.auger@redhat.com, james.morse@arm.com,
 catalin.marinas@arm.com, imammedo@redhat.com,
 Salil Mehta <salil.mehta@huawei.com>, pbonzini@redhat.com,
 mehta.salil.lnk@gmail.com, maran.wilson@oracle.com, will@kernel.org,
 wangxiongfeng2@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VCPU register info needs to be re-initialized each time vcpu is hot-plugged.
This has to be done both for emulation/TCG and KVM case. This is done in
context to the GIC update notification for any vcpu hot-(un)plug events. This
change adds that support and re-factors existing to maximize the code re-use.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/intc/arm_gicv3.c                |   1 +
 hw/intc/arm_gicv3_common.c         |   6 +-
 hw/intc/arm_gicv3_cpuif.c          | 134 ++++++++++++++++-------------
 hw/intc/arm_gicv3_kvm.c            |   7 +-
 hw/intc/gicv3_internal.h           |   1 +
 include/hw/intc/arm_gicv3_common.h |   1 +
 6 files changed, 86 insertions(+), 64 deletions(-)

diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 66eaa97198..86f2f4cca7 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -396,6 +396,7 @@ static void arm_gicv3_class_init(ObjectClass *klass, void *data)
     ARMGICv3Class *agc = ARM_GICV3_CLASS(klass);
 
     agcc->post_load = arm_gicv3_post_load;
+    agcc->init_cpu_reginfo = gicv3_init_cpu_reginfo;
     device_class_set_parent_realize(dc, arm_gic_realize, &agc->parent_realize);
 }
 
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index f6b7b359cb..01e4aba4f1 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -330,6 +330,7 @@ static void arm_gicv3_cpu_update_notifier(Notifier * notifier, void * data)
 {
     VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
     GICv3State *s = ARM_GICV3_COMMON(vms->gic);
+    ARMGICv3CommonClass *c = ARM_GICV3_COMMON_GET_CLASS(s);
     CPUState *cpu = (CPUState *)data;
     int gic_cpuif_num;
 
@@ -351,7 +352,10 @@ static void arm_gicv3_cpu_update_notifier(Notifier * notifier, void * data)
     gicv3_set_gicv3state(cpu, &s->cpu[gic_cpuif_num]);
     gicv3_set_cpustate(&s->cpu[gic_cpuif_num], cpu);
 
-    /* TODO: initialize the registers info for this newly added cpu */
+    /* initialize the registers info for this newly added cpu */
+    if (c->init_cpu_reginfo) {
+        c->init_cpu_reginfo(cpu);
+    }
 }
 
 static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index b3aa5979ca..1126fffa55 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -2605,6 +2605,74 @@ static const ARMCPRegInfo gicv3_cpuif_ich_apxr23_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+void gicv3_init_cpu_reginfo(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    GICv3CPUState *gcs = icc_cs_from_env(&cpu->env);
+
+    /* Note that we can't just use the GICv3CPUState as an opaque pointer
+     * in define_arm_cp_regs_with_opaque(), because when we're called back
+     * it might be with code translated by CPU 0 but run by CPU 1, in
+     * which case we'd get the wrong value.
+     * So instead we define the regs with no ri->opaque info, and
+     * get back to the GICv3CPUState from the CPUARMState.
+     */
+    define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
+    if (arm_feature(&cpu->env, ARM_FEATURE_EL2)
+        && cpu->gic_num_lrs) {
+        int j;
+
+        gcs->maintenance_irq = cpu->gicv3_maintenance_interrupt;
+
+        gcs->num_list_regs = cpu->gic_num_lrs;
+        gcs->vpribits = cpu->gic_vpribits;
+        gcs->vprebits = cpu->gic_vprebits;
+
+        /* Check against architectural constraints: getting these
+         * wrong would be a bug in the CPU code defining these,
+         * and the implementation relies on them holding.
+         */
+        g_assert(gcs->vprebits <= gcs->vpribits);
+        g_assert(gcs->vprebits >= 5 && gcs->vprebits <= 7);
+        g_assert(gcs->vpribits >= 5 && gcs->vpribits <= 8);
+
+        define_arm_cp_regs(cpu, gicv3_cpuif_hcr_reginfo);
+
+        for (j = 0; j < gcs->num_list_regs; j++) {
+            /* Note that the AArch64 LRs are 64-bit; the AArch32 LRs
+             * are split into two cp15 regs, LR (the low part, with the
+             * same encoding as the AArch64 LR) and LRC (the high part).
+             */
+            ARMCPRegInfo lr_regset[] = {
+                { .name = "ICH_LRn_EL2", .state = ARM_CP_STATE_BOTH,
+                  .opc0 = 3, .opc1 = 4, .crn = 12,
+                  .crm = 12 + (j >> 3), .opc2 = j & 7,
+                  .type = ARM_CP_IO | ARM_CP_NO_RAW,
+                  .access = PL2_RW,
+                  .readfn = ich_lr_read,
+                  .writefn = ich_lr_write,
+                },
+                { .name = "ICH_LRCn_EL2", .state = ARM_CP_STATE_AA32,
+                  .cp = 15, .opc1 = 4, .crn = 12,
+                  .crm = 14 + (j >> 3), .opc2 = j & 7,
+                  .type = ARM_CP_IO | ARM_CP_NO_RAW,
+                  .access = PL2_RW,
+                  .readfn = ich_lr_read,
+                  .writefn = ich_lr_write,
+                },
+                REGINFO_SENTINEL
+            };
+            define_arm_cp_regs(cpu, lr_regset);
+        }
+        if (gcs->vprebits >= 6) {
+            define_arm_cp_regs(cpu, gicv3_cpuif_ich_apxr1_reginfo);
+        }
+        if (gcs->vprebits == 7) {
+            define_arm_cp_regs(cpu, gicv3_cpuif_ich_apxr23_reginfo);
+        }
+    }
+}
+
 static void gicv3_cpuif_el_change_hook(ARMCPU *cpu, void *opaque)
 {
     GICv3CPUState *cs = opaque;
@@ -2621,69 +2689,11 @@ void gicv3_init_cpuif(GICv3State *s)
 
     for (i = 0; i < s->num_cpu; i++) {
         ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
-        GICv3CPUState *cs = &s->cpu[i];
-
-        /* Note that we can't just use the GICv3CPUState as an opaque pointer
-         * in define_arm_cp_regs_with_opaque(), because when we're called back
-         * it might be with code translated by CPU 0 but run by CPU 1, in
-         * which case we'd get the wrong value.
-         * So instead we define the regs with no ri->opaque info, and
-         * get back to the GICv3CPUState from the CPUARMState.
-         */
-        define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
-        if (arm_feature(&cpu->env, ARM_FEATURE_EL2)
-            && cpu->gic_num_lrs) {
-            int j;
 
-            cs->maintenance_irq = cpu->gicv3_maintenance_interrupt;
-
-            cs->num_list_regs = cpu->gic_num_lrs;
-            cs->vpribits = cpu->gic_vpribits;
-            cs->vprebits = cpu->gic_vprebits;
-
-            /* Check against architectural constraints: getting these
-             * wrong would be a bug in the CPU code defining these,
-             * and the implementation relies on them holding.
-             */
-            g_assert(cs->vprebits <= cs->vpribits);
-            g_assert(cs->vprebits >= 5 && cs->vprebits <= 7);
-            g_assert(cs->vpribits >= 5 && cs->vpribits <= 8);
-
-            define_arm_cp_regs(cpu, gicv3_cpuif_hcr_reginfo);
-
-            for (j = 0; j < cs->num_list_regs; j++) {
-                /* Note that the AArch64 LRs are 64-bit; the AArch32 LRs
-                 * are split into two cp15 regs, LR (the low part, with the
-                 * same encoding as the AArch64 LR) and LRC (the high part).
-                 */
-                ARMCPRegInfo lr_regset[] = {
-                    { .name = "ICH_LRn_EL2", .state = ARM_CP_STATE_BOTH,
-                      .opc0 = 3, .opc1 = 4, .crn = 12,
-                      .crm = 12 + (j >> 3), .opc2 = j & 7,
-                      .type = ARM_CP_IO | ARM_CP_NO_RAW,
-                      .access = PL2_RW,
-                      .readfn = ich_lr_read,
-                      .writefn = ich_lr_write,
-                    },
-                    { .name = "ICH_LRCn_EL2", .state = ARM_CP_STATE_AA32,
-                      .cp = 15, .opc1 = 4, .crn = 12,
-                      .crm = 14 + (j >> 3), .opc2 = j & 7,
-                      .type = ARM_CP_IO | ARM_CP_NO_RAW,
-                      .access = PL2_RW,
-                      .readfn = ich_lr_read,
-                      .writefn = ich_lr_write,
-                    },
-                    REGINFO_SENTINEL
-                };
-                define_arm_cp_regs(cpu, lr_regset);
-            }
-            if (cs->vprebits >= 6) {
-                define_arm_cp_regs(cpu, gicv3_cpuif_ich_apxr1_reginfo);
-            }
-            if (cs->vprebits == 7) {
-                define_arm_cp_regs(cpu, gicv3_cpuif_ich_apxr23_reginfo);
-            }
+        if (qemu_present_cpu(CPU(cpu))) {
+            GICv3CPUState *cs = icc_cs_from_env(&cpu->env);
+            gicv3_init_cpu_reginfo(CPU(cpu));
+            arm_register_el_change_hook(cpu, gicv3_cpuif_el_change_hook, cs);
         }
-        arm_register_el_change_hook(cpu, gicv3_cpuif_el_change_hook, cs);
     }
 }
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 7fe000e53c..8d19af3974 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -781,6 +781,10 @@ static void vm_change_state_handler(void *opaque, int running,
     }
 }
 
+static void kvm_gicv3_init_cpu_reginfo(CPUState *cs)
+{
+    define_arm_cp_regs(ARM_CPU(cs), gicv3_cpuif_reginfo);
+}
 
 static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 {
@@ -813,7 +817,7 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < s->num_cpu; i++) {
         CPUState *cs = qemu_get_cpu(i);
         if (qemu_present_cpu(cs))
-            define_arm_cp_regs(ARM_CPU(cs), gicv3_cpuif_reginfo);
+            kvm_gicv3_init_cpu_reginfo(cs);
     }
 
     /* Try to create the device via the device control API */
@@ -902,6 +906,7 @@ static void kvm_arm_gicv3_class_init(ObjectClass *klass, void *data)
 
     agcc->pre_save = kvm_arm_gicv3_get;
     agcc->post_load = kvm_arm_gicv3_put;
+    agcc->init_cpu_reginfo = kvm_gicv3_init_cpu_reginfo;
     device_class_set_parent_realize(dc, kvm_arm_gicv3_realize,
                                     &kgc->parent_realize);
     device_class_set_parent_reset(dc, kvm_arm_gicv3_reset, &kgc->parent_reset);
diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index 6e14a7a6cd..66eec3c3fc 100644
--- a/hw/intc/gicv3_internal.h
+++ b/hw/intc/gicv3_internal.h
@@ -298,6 +298,7 @@ void gicv3_dist_set_irq(GICv3State *s, int irq, int level);
 void gicv3_redist_set_irq(GICv3CPUState *cs, int irq, int level);
 void gicv3_redist_send_sgi(GICv3CPUState *cs, int grp, int irq, bool ns);
 void gicv3_init_cpuif(GICv3State *s);
+void gicv3_init_cpu_reginfo(CPUState *cs);
 
 /**
  * gicv3_cpuif_update:
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index b51f74c728..4d1cbc66db 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -294,6 +294,7 @@ typedef struct ARMGICv3CommonClass {
 
     void (*pre_save)(GICv3State *s);
     void (*post_load)(GICv3State *s);
+    void (*init_cpu_reginfo)(CPUState *cs);
 } ARMGICv3CommonClass;
 
 void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
-- 
2.17.1



