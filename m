Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EFCC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF6B20825
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF6B20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkEBf-0003WL-Hj
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 17:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDz3-0000IX-H9; Sat, 13 Jun 2020 17:46:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3711 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDz0-0003ZU-Mh; Sat, 13 Jun 2020 17:46:37 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id DF420C054C62182343E8;
 Sun, 14 Jun 2020 05:46:31 +0800 (CST)
Received: from A190218597.china.huawei.com (10.47.30.60) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sun, 14 Jun 2020 05:46:22 +0800
From: Salil Mehta <salil.mehta@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH RFC 22/22] arm/cpuhp: Add support of *unrealize* ARMCPU during
 vcpu hot-unplug
Date: Sat, 13 Jun 2020 22:36:29 +0100
Message-ID: <20200613213629.21984-23-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20200613213629.21984-1-salil.mehta@huawei.com>
References: <20200613213629.21984-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.30.60]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=salil.mehta@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 17:44:30
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

During vcpu hot-unplug ARM cpu unrealization shall happen which should do away
with all the vcpu thread creations, allocations, registrations which happened
as part of the realization process of the ARM cpu. This change introduces the
ARM cpu unrealize function taking care of exactly that.

Note, initialized vcpus are not destroyed at host KVM but are rather parked in
the QEMU/KVM layer. These are later reused once vcpu is hotplugged again.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 exec.c                  | 24 ++++++++++++
 gdbstub.c               | 13 +++++++
 include/exec/exec-all.h |  8 ++++
 include/exec/gdbstub.h  |  1 +
 include/hw/core/cpu.h   |  2 +
 target/arm/cpu-qom.h    |  3 ++
 target/arm/cpu.c        | 86 +++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.h        | 13 +++++++
 target/arm/helper.c     | 31 +++++++++++++++
 target/arm/internals.h  |  1 +
 target/arm/kvm64.c      |  7 +++-
 11 files changed, 188 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index a0bf9d61c8..7e808affdf 100644
--- a/exec.c
+++ b/exec.c
@@ -869,6 +869,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
 
     if (!cpu->cpu_ases) {
         cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
+        cpu->cpu_ases_ref_count = cpu->num_ases;
     }
 
     newas = &cpu->cpu_ases[asidx];
@@ -881,6 +882,29 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
     }
 }
 
+void cpu_address_space_destroy(CPUState *cpu, int asidx)
+{
+    CPUAddressSpace *cpuas;
+
+    assert(asidx < cpu->num_ases);
+    assert(asidx == 0 || !kvm_enabled());
+    assert(cpu->cpu_ases);
+
+    cpuas = &cpu->cpu_ases[asidx];
+    if (tcg_enabled()) {
+        memory_listener_unregister(&cpuas->tcg_as_listener);
+    }
+
+    address_space_destroy(cpuas->as);
+
+    if(cpu->cpu_ases_ref_count == 1) {
+        g_free(cpu->cpu_ases);
+        cpu->cpu_ases = NULL;
+    }
+
+    cpu->cpu_ases_ref_count--;
+}
+
 AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
 {
     /* Return the AddressSpace corresponding to the specified index */
diff --git a/gdbstub.c b/gdbstub.c
index 6950fd243f..e960268d15 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -982,6 +982,19 @@ void gdb_register_coprocessor(CPUState *cpu,
     }
 }
 
+void gdb_unregister_coprocessor_all(CPUState *cpu)
+{
+    GDBRegisterState *s, *p;
+
+    p = cpu->gdb_regs;
+    while (p) {
+        s = p;
+        p = p->next;
+        g_free(s);
+    }
+    cpu->gdb_regs = NULL;
+}
+
 #ifndef CONFIG_USER_ONLY
 /* Translate GDB watchpoint type to a flags value for cpu_watchpoint_* */
 static inline int xlat_gdb_type(CPUState *cpu, int gdbtype)
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 8792bea07a..44420c144d 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -115,6 +115,14 @@ void cpu_reloading_memory_map(void);
  */
 void cpu_address_space_init(CPUState *cpu, int asidx,
                             const char *prefix, MemoryRegion *mr);
+/**
+ * cpu_address_space_destroy:
+ * @cpu: CPU for which address space needs to be destroyed
+ * @asidx: integer index of this address space
+ *
+ * Note that with KVM only one address space is supported.
+ */
+void cpu_address_space_destroy(CPUState *cpu, int asidx);
 #endif
 
 #if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 94d8f83e92..db2336d0df 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -73,6 +73,7 @@ typedef int (*gdb_set_reg_cb)(CPUArchState *env, uint8_t *buf, int reg);
 void gdb_register_coprocessor(CPUState *cpu,
                               gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
                               int num_regs, const char *xml, int g_pos);
+void gdb_unregister_coprocessor_all(CPUState *cpu);
 
 /*
  * The GDB remote protocol transfers values in target byte order. As
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index d9cae71ea5..851f03dd83 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -379,6 +379,7 @@ struct CPUState {
     struct qemu_work_item *queued_work_first, *queued_work_last;
 
     CPUAddressSpace *cpu_ases;
+    int cpu_ases_ref_count;
     int num_ases;
     AddressSpace *as;
     MemoryRegion *memory;
@@ -410,6 +411,7 @@ struct CPUState {
     int kvm_fd;
     struct KVMState *kvm_state;
     struct kvm_run *kvm_run;
+    VMChangeStateEntry *vmcse;
 
     /* Used for events with 'vcpu' and *without* the 'disabled' properties */
     DECLARE_BITMAP(trace_dstate_delayed, CPU_TRACE_DSTATE_MAX_EVENTS);
diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 56395b87f6..d943683551 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -58,6 +58,7 @@ typedef struct ARMCPUClass {
 
     const ARMCPUInfo *info;
     DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
     DeviceReset parent_reset;
 } ARMCPUClass;
 
@@ -76,7 +77,9 @@ typedef struct AArch64CPUClass {
 } AArch64CPUClass;
 
 void register_cp_regs_for_features(ARMCPU *cpu);
+void unregister_cp_regs_for_features(ARMCPU *cpu);
 void init_cpreg_list(ARMCPU *cpu);
+void destroy_cpreg_list(ARMCPU *cpu);
 
 /* Callback functions for the generic timer's timers. */
 void arm_gt_ptimer_cb(void *opaque);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 0c9f5f970e..dac42c418d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -92,6 +92,16 @@ void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
     QLIST_INSERT_HEAD(&cpu->pre_el_change_hooks, entry, node);
 }
 
+void arm_unregister_pre_el_change_hooks(ARMCPU *cpu)
+{
+    ARMELChangeHook *entry, *next;
+
+    QLIST_FOREACH_SAFE(entry, &cpu->pre_el_change_hooks, node, next) {
+        QLIST_REMOVE(entry, node);
+        g_free(entry);
+    }
+}
+
 void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
                                  void *opaque)
 {
@@ -103,6 +113,16 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
     QLIST_INSERT_HEAD(&cpu->el_change_hooks, entry, node);
 }
 
+void arm_unregister_el_change_hooks(ARMCPU *cpu)
+{
+    ARMELChangeHook *entry, *next;
+
+    QLIST_FOREACH_SAFE(entry, &cpu->el_change_hooks, node, next) {
+        QLIST_REMOVE(entry, node);
+        g_free(entry);
+    }
+}
+
 static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
 {
     /* Reset a single ARMCPRegInfo register */
@@ -1765,6 +1785,70 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     acc->parent_realize(dev, errp);
 }
 
+static void arm_cpu_unrealizefn(DeviceState *dev)
+{
+    ARMCPUClass *acc = ARM_CPU_GET_CLASS(dev);
+    ARMCPU *cpu = ARM_CPU(dev);
+    CPUARMState *env = &cpu->env;
+    CPUState *cs = CPU(dev);
+
+    /* rock 'n' un-roll, whatever happened in the arm_cpu_realizefn cleanly */
+    if (cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+        cpu_address_space_destroy(cs, ARMASIdx_S);
+    }
+    cpu_address_space_destroy(cs, ARMASIdx_NS);
+
+    destroy_cpreg_list(cpu);
+    arm_cpu_unregister_gdb_regs(cpu);
+    unregister_cp_regs_for_features(cpu);
+
+    if (cpu->sau_sregion && arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+           g_free(env->sau.rbar);
+           g_free(env->sau.rlar);
+    }
+
+    if (arm_feature(env, ARM_FEATURE_PMSA) &&
+        arm_feature(env, ARM_FEATURE_V7) &&
+        cpu->pmsav7_dregion) {
+        if (arm_feature(env, ARM_FEATURE_V8)) {
+            g_free(env->pmsav8.rbar[M_REG_NS]);
+            g_free(env->pmsav8.rlar[M_REG_NS]);
+            if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+                g_free(env->pmsav8.rbar[M_REG_S]);
+                g_free(env->pmsav8.rlar[M_REG_S]);
+            }
+        } else {
+            g_free(env->pmsav7.drbar);
+            g_free(env->pmsav7.drsr);
+            g_free(env->pmsav7.dracr);
+        }
+    }
+
+    if (arm_feature(env, ARM_FEATURE_PMU)) {
+        if (!kvm_enabled()) {
+            arm_unregister_pre_el_change_hooks(cpu);
+            arm_unregister_el_change_hooks(cpu);
+        }
+
+#ifndef CONFIG_USER_ONLY
+        if (cpu->pmu_timer) {
+            timer_del(cpu->pmu_timer);
+        }
+#endif
+    }
+
+    cpu_remove_sync(CPU(dev));
+    acc->parent_unrealize(dev);
+
+#ifndef CONFIG_USER_ONLY
+    timer_del(cpu->gt_timer[GTIMER_PHYS]);
+    timer_del(cpu->gt_timer[GTIMER_VIRT]);
+    timer_del(cpu->gt_timer[GTIMER_HYP]);
+    timer_del(cpu->gt_timer[GTIMER_SEC]);
+    timer_del(cpu->gt_timer[GTIMER_HYPVIRT]);
+#endif
+}
+
 static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
@@ -2145,6 +2229,8 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
 
     device_class_set_parent_realize(dc, arm_cpu_realizefn,
                                     &acc->parent_realize);
+    device_class_set_parent_unrealize(dc, arm_cpu_unrealizefn,
+				      &acc->parent_unrealize);
 
     device_class_set_props(dc, arm_cpu_properties);
     device_class_set_parent_reset(dc, arm_cpu_reset, &acc->parent_reset);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5c4991156e..a8e7cb9fb1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3337,6 +3337,13 @@ static inline AddressSpace *arm_addressspace(CPUState *cs, MemTxAttrs attrs)
  */
 void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
                                  void *opaque);
+/**
+ * arm_unregister_pre_el_change_hook:
+ * unregister all pre EL change hook functions. Generally called during
+ * unrealize'ing leg
+ */
+void arm_unregister_pre_el_change_hooks(ARMCPU *cpu);
+
 /**
  * arm_register_el_change_hook:
  * Register a hook function which will be called immediately after this
@@ -3349,6 +3356,12 @@ void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
  */
 void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook, void
         *opaque);
+/**
+ * arm_unregister_el_change_hook:
+ * unregister all EL change hook functions.  Generally called during
+ * unrealize'ing leg
+ */
+void arm_unregister_el_change_hooks(ARMCPU *cpu);
 
 /**
  * arm_rebuild_hflags:
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 972a766730..dc4100ea89 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -502,6 +502,19 @@ void init_cpreg_list(ARMCPU *cpu)
     g_list_free(keys);
 }
 
+void destroy_cpreg_list(ARMCPU *cpu)
+{
+    assert(cpu->cpreg_indexes);
+    assert(cpu->cpreg_values);
+    assert(cpu->cpreg_vmstate_indexes);
+    assert(cpu->cpreg_vmstate_values);
+
+    g_free(cpu->cpreg_indexes);
+    g_free(cpu->cpreg_values);
+    g_free(cpu->cpreg_vmstate_indexes);
+    g_free(cpu->cpreg_vmstate_values);
+}
+
 /*
  * Some registers are not accessible from AArch32 EL3 if SCR.NS == 0.
  */
@@ -7981,6 +7994,18 @@ void register_cp_regs_for_features(ARMCPU *cpu)
 #endif
 }
 
+void unregister_cp_regs_for_features(ARMCPU *cpu)
+{
+    CPUARMState *env = &cpu->env;
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        /* M profile has no coprocessor registers */
+        return;
+    }
+
+    /* empty it all. unregister all the coprocessor registers */
+    g_hash_table_remove_all(cpu->cp_regs);
+}
+
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
@@ -8019,6 +8044,12 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
 
 }
 
+void arm_cpu_unregister_gdb_regs(ARMCPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+    gdb_unregister_coprocessor_all(cs);
+}
+
 /* Sort alphabetically by type name, except for "any". */
 static gint arm_cpu_list_compare(gconstpointer a, gconstpointer b)
 {
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4bdbc3a8ac..8ece9e09f5 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -169,6 +169,7 @@ static inline int r14_bank_number(int mode)
 }
 
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
+void arm_cpu_unregister_gdb_regs(ARMCPU *cpu);
 void arm_translate_init(void);
 
 enum arm_fprounding {
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index f09ed9f4df..b6df17912e 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -775,7 +775,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return -EINVAL;
     }
 
-    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cs);
+    if (qemu_present_cpu(cs))
+        cs->vmcse = qemu_add_vm_change_state_handler(kvm_arm_vm_state_change,
+                                                     cs);
 
     /* Determine init features for this CPU */
     memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
@@ -840,6 +842,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
 int kvm_arch_destroy_vcpu(CPUState *cs)
 {
+    if (qemu_present_cpu(cs))
+        qemu_del_vm_change_state_handler(cs->vmcse);
+
     return 0;
 }
 
-- 
2.17.1



