Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DFAC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1570B20789
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1570B20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkE1k-00048Y-D1
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 17:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDxV-0005jW-I3; Sat, 13 Jun 2020 17:45:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43436 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDxS-000380-Eh; Sat, 13 Jun 2020 17:45:01 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 883C7821393FE162372F;
 Sun, 14 Jun 2020 05:44:55 +0800 (CST)
Received: from A190218597.china.huawei.com (10.47.30.60) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sun, 14 Jun 2020 05:44:47 +0800
From: Salil Mehta <salil.mehta@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH RFC 06/22] arm/cpuhp: Changes to pre-size GIC with possible
 vcpus @machine init
Date: Sat, 13 Jun 2020 22:36:13 +0100
Message-ID: <20200613213629.21984-7-salil.mehta@huawei.com>
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

GIC needs to be pre-sized with possible vcpus at the initialization time. This
is necessary because Memory regions and resources associated with GICC/GICR
etc cannot be changed (add/del/modified) after VM has inited. Also, GIC_TYPER
needs to be initialized with mp_affinity and cpu interface number association.
This cannot be changed after GIC has initialized.

Once all the cpu interfaces of the GIC has been inited it needs to be ensured
that any updations to the GICC during reset only takes place for the present
vcpus and not the disabled ones. Therefore, proper checks are required at
various places.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c              | 18 +++++++++---------
 hw/intc/arm_gicv3_common.c |  8 ++++++--
 hw/intc/arm_gicv3_cpuif.c  |  6 ++++++
 hw/intc/arm_gicv3_kvm.c    | 29 ++++++++++++++++++++++++++---
 include/hw/arm/virt.h      |  2 +-
 5 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8040473d30..9e55b20685 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -628,19 +628,19 @@ static void create_v2m(VirtMachineState *vms)
 
 static void create_gic(VirtMachineState *vms)
 {
-    MachineState *ms = MACHINE(vms);
     /* We create a standalone GIC */
     SysBusDevice *gicbusdev;
     const char *gictype;
     int type = vms->gic_version, i;
-    unsigned int smp_cpus = ms->smp.cpus;
+    unsigned int max_cpus = vms->max_cpus;
+    unsigned int smp_cpus = vms->smp_cpus;
     uint32_t nb_redist_regions = 0;
 
     gictype = (type == 3) ? gicv3_class_name() : gic_class_name();
 
     vms->gic = qdev_create(NULL, gictype);
     qdev_prop_set_uint32(vms->gic, "revision", type);
-    qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
+    qdev_prop_set_uint32(vms->gic, "num-cpu", max_cpus);
     /* Note that the num-irq property counts both internal and external
      * interrupts; there are always 32 of the former (mandated by GIC spec).
      */
@@ -652,7 +652,7 @@ static void create_gic(VirtMachineState *vms)
     if (type == 3) {
         uint32_t redist0_capacity =
                     vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
-        uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
+        uint32_t redist0_count = MIN(max_cpus, redist0_capacity);
 
         nb_redist_regions = virt_gicv3_redist_region_count(vms);
 
@@ -665,7 +665,7 @@ static void create_gic(VirtMachineState *vms)
                     vms->memmap[VIRT_HIGH_GIC_REDIST2].size / GICV3_REDIST_SIZE;
 
             qdev_prop_set_uint32(vms->gic, "redist-region-count[1]",
-                MIN(smp_cpus - redist0_count, redist1_capacity));
+                MIN(max_cpus - redist0_count, redist1_capacity));
         }
     } else {
         if (!kvm_irqchip_in_kernel()) {
@@ -722,7 +722,7 @@ static void create_gic(VirtMachineState *vms)
         } else if (vms->virt) {
             qemu_irq irq = qdev_get_gpio_in(vms->gic,
                                             ppibase + ARCH_GIC_MAINT_IRQ);
-            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
+            sysbus_connect_irq(gicbusdev, i + 4 * max_cpus, irq);
         }
 
         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
@@ -730,11 +730,11 @@ static void create_gic(VirtMachineState *vms)
                                                      + VIRTUAL_PMU_IRQ));
 
         sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
-        sysbus_connect_irq(gicbusdev, i + smp_cpus,
+        sysbus_connect_irq(gicbusdev, i + max_cpus,
                            qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
-        sysbus_connect_irq(gicbusdev, i + 2 * smp_cpus,
+        sysbus_connect_irq(gicbusdev, i + 2 * max_cpus,
                            qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
-        sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
+        sysbus_connect_irq(gicbusdev, i + 3 * max_cpus,
                            qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
     }
 
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 58ef65f589..bfa514444a 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -348,11 +348,15 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
     s->cpu = g_new0(GICv3CPUState, s->num_cpu);
 
     for (i = 0; i < s->num_cpu; i++) {
-        CPUState *cpu = qemu_get_cpu(i);
+        CPUState *cpu = qemu_get_possible_cpu(i);
         uint64_t cpu_affid;
         int last;
 
-        s->cpu[i].cpu = cpu;
+        if (qemu_present_cpu(cpu))
+            s->cpu[i].cpu = cpu;
+        else
+            s->cpu[i].cpu = NULL;
+
         s->cpu[i].gic = s;
         /* Store GICv3CPUState in CPUARMState gicv3state pointer */
         gicv3_set_gicv3state(cpu, &s->cpu[i]);
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 08e000e33c..90d8b0118e 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -779,6 +779,9 @@ void gicv3_cpuif_update(GICv3CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs->cpu);
     CPUARMState *env = &cpu->env;
 
+    if (!qemu_present_cpu(cs->cpu))
+        return;
+
     g_assert(qemu_mutex_iothread_locked());
 
     trace_gicv3_cpuif_update(gicv3_redist_affid(cs), cs->hppi.irq,
@@ -1654,6 +1657,9 @@ static void icc_generate_sgi(CPUARMState *env, GICv3CPUState *cs,
     for (i = 0; i < s->num_cpu; i++) {
         GICv3CPUState *ocs = &s->cpu[i];
 
+        if (!qemu_present_cpu(ocs->cpu))
+            continue;
+
         if (irm) {
             /* IRM == 1 : route to all CPUs except self */
             if (cs == ocs) {
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index ca43bf87ca..7fe000e53c 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -25,6 +25,7 @@
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "sysemu/cpus.h"
 #include "sysemu/kvm.h"
 #include "sysemu/runstate.h"
 #include "kvm_arm.h"
@@ -458,6 +459,17 @@ static void kvm_arm_gicv3_put(GICv3State *s)
         GICv3CPUState *c = &s->cpu[ncpu];
         int num_pri_bits;
 
+        /*
+         * To support hotplug of vcpus we need to make sure all gic cpuif/GICC
+         * are initialized at machvirt init time. Once the init is done we
+         * release the ARMCPU object for disabled vcpus but this leg could hit
+         * during reset of GICC later as well i.e. after init has happened and
+         * all of the cases we want to make sure we dont acess the GICC for
+         * the disabled VCPUs.
+         */
+        if (!qemu_present_cpu(c->cpu))
+            continue;
+
         kvm_gicc_access(s, ICC_SRE_EL1, ncpu, &c->icc_sre_el1, true);
         kvm_gicc_access(s, ICC_CTLR_EL1, ncpu,
                         &c->icc_ctlr_el1[GICV3_NS], true);
@@ -677,10 +689,21 @@ static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
         return;
     }
 
+    /*
+     * This shall be called even when vcpu is being hotplugged and other vcpus
+     * might be running. Host kernel KVM code to handle device access of IOCTLs
+     * KVM_{GET|SET}_DEVICE_ATTR might fail due to inability to grab vcpu locks
+     * for all the vcpus. Hence, we need to pause all vcpus to facilitate
+     * locking within host.
+     */
+    if (!qemu_present_cpu(c->cpu))
+        pause_all_vcpus();
     /* Initialize to actual HW supported configuration */
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
                       KVM_VGIC_ATTR(ICC_CTLR_EL1, c->gicr_typer),
                       &c->icc_ctlr_el1[GICV3_NS], false, &error_abort);
+    if (!qemu_present_cpu(c->cpu))
+        resume_all_vcpus();
 
     c->icc_ctlr_el1[GICV3_S] = c->icc_ctlr_el1[GICV3_NS];
 }
@@ -788,9 +811,9 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
     }
 
     for (i = 0; i < s->num_cpu; i++) {
-        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
-
-        define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
+        CPUState *cs = qemu_get_cpu(i);
+        if (qemu_present_cpu(cs))
+            define_arm_cp_regs(ARM_CPU(cs), gicv3_cpuif_reginfo);
     }
 
     /* Try to create the device via the device control API */
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 5b8ba64ec2..38a9cad168 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -178,7 +178,7 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
 
     assert(vms->gic_version == VIRT_GIC_VERSION_3);
 
-    return vms->smp_cpus > redist0_capacity ? 2 : 1;
+    return vms->max_cpus > redist0_capacity ? 2 : 1;
 }
 
 #endif /* QEMU_ARM_VIRT_H */
-- 
2.17.1



