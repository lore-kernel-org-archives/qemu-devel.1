Received: from eggs.gnu.org ([2001:4830:134:3::10]:50969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVy2L-0003Nf-G0
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVy2I-0003Rn-8h
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:41:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43536
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVy2I-0003RJ-2m
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:41:26 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EAceao044141
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 06:41:24 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bprvvr0a0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 06:41:24 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 11:41:22 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 12:41:05 +0200
In-Reply-To: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500028867-134709-39-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 38/40] s390x/kvm: enable guarded storage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Fan Zhang <zhangfan@linux.vnet.ibm.com>

Introduce guarded storage support for KVM guests on s390.
We need to enable the capability, extend machine check validity,
sigp store-additional-status-at-address, and migration.

The feature is fenced for older machine type versions.

Signed-off-by: Fan Zhang <zhangfan@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c         | 18 ++++++++++
 include/hw/s390x/s390-virtio-ccw.h |  3 ++
 target/s390x/cpu.h                 |  7 ++++
 target/s390x/kvm.c                 | 71 ++++++++++++++++++++++++++++++++------
 target/s390x/machine.c             | 17 +++++++++
 5 files changed, 106 insertions(+), 10 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 657a45f..ce3921e 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -211,6 +211,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     s390mc->ri_allowed = true;
     s390mc->cpu_model_allowed = true;
     s390mc->css_migration_enabled = true;
+    s390mc->gs_allowed = true;
     mc->init = ccw_init;
     mc->reset = s390_machine_reset;
     mc->hot_add_cpu = s390_hot_add_cpu;
@@ -288,6 +289,22 @@ bool cpu_model_allowed(void)
     return get_machine_class()->cpu_model_allowed;
 }
 
+bool gs_allowed(void)
+{
+    if (kvm_enabled()) {
+        MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+        if (object_class_dynamic_cast(OBJECT_CLASS(mc),
+                                      TYPE_S390_CCW_MACHINE)) {
+            S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
+
+            return s390mc->gs_allowed;
+        }
+        /* Make sure the "none" machine can have gs */
+        return true;
+    }
+    return false;
+}
+
 static char *machine_get_loadparm(Object *obj, Error **errp)
 {
     S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
@@ -515,6 +532,7 @@ static void ccw_machine_2_9_class_options(MachineClass *mc)
 {
     S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
 
+    s390mc->gs_allowed = false;
     ccw_machine_2_10_class_options(mc);
     SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_9);
     s390mc->css_migration_enabled = false;
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index ab88d49..41a9d28 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -40,12 +40,15 @@ typedef struct S390CcwMachineClass {
     bool ri_allowed;
     bool cpu_model_allowed;
     bool css_migration_enabled;
+    bool gs_allowed;
 } S390CcwMachineClass;
 
 /* runtime-instrumentation allowed by the machine */
 bool ri_allowed(void);
 /* cpu model allowed by the machine */
 bool cpu_model_allowed(void);
+/* guarded-storage allowed by the machine */
+bool gs_allowed(void);
 
 /**
  * Returns true if (vmstate based) migration of the channel subsystem
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 8ab75c0..7732d01 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -89,6 +89,7 @@ typedef struct CPUS390XState {
     CPU_DoubleU vregs[32][2];  /* vector registers */
     uint32_t aregs[16];    /* access registers */
     uint8_t riccb[64];     /* runtime instrumentation control */
+    uint64_t gscb[4];      /* guarded storage control */
 
     /* Fields up to this point are not cleared by initial CPU reset */
     struct {} start_initial_reset_fields;
@@ -1166,6 +1167,7 @@ int kvm_s390_set_mem_limit(KVMState *s, uint64_t new_limit, uint64_t *hw_limit);
 void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
 int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
 int kvm_s390_get_ri(void);
+int kvm_s390_get_gs(void);
 void kvm_s390_crypto_reset(void);
 #else
 static inline void kvm_s390_io_interrupt(uint16_t subchannel_id,
@@ -1220,6 +1222,10 @@ static inline int kvm_s390_get_ri(void)
 {
     return 0;
 }
+static inline int kvm_s390_get_gs(void)
+{
+    return 0;
+}
 static inline void kvm_s390_crypto_reset(void)
 {
 }
@@ -1328,6 +1334,7 @@ static inline bool s390_get_squash_mcss(void)
 #define MCIC_VB_CR 0x0000000400000000ULL
 #define MCIC_VB_ST 0x0000000100000000ULL
 #define MCIC_VB_AR 0x0000000040000000ULL
+#define MCIC_VB_GS 0x0000000008000000ULL
 #define MCIC_VB_PR 0x0000000000200000ULL
 #define MCIC_VB_FC 0x0000000000100000ULL
 #define MCIC_VB_CT 0x0000000000020000ULL
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index c773bd6..831492f 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -139,6 +139,7 @@ static int cap_async_pf;
 static int cap_mem_op;
 static int cap_s390_irq;
 static int cap_ri;
+static int cap_gs;
 
 static int active_cmma;
 
@@ -301,6 +302,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
             cap_ri = 1;
         }
     }
+    if (gs_allowed()) {
+        if (kvm_vm_enable_cap(s, KVM_CAP_S390_GS, 0) == 0) {
+            cap_gs = 1;
+        }
+    }
 
     /* Try to enable AIS facility */
     kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
@@ -472,6 +478,11 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         }
     }
 
+    if (can_sync_regs(cs, KVM_SYNC_GSCB)) {
+        memcpy(cs->kvm_run->s.regs.gscb, env->gscb, 32);
+        cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_GSCB;
+    }
+
     /* Finally the prefix */
     if (can_sync_regs(cs, KVM_SYNC_PREFIX)) {
         cs->kvm_run->s.regs.prefix = env->psa;
@@ -578,6 +589,10 @@ int kvm_arch_get_registers(CPUState *cs)
         memcpy(env->riccb, cs->kvm_run->s.regs.riccb, 64);
     }
 
+    if (can_sync_regs(cs, KVM_SYNC_GSCB)) {
+        memcpy(env->gscb, cs->kvm_run->s.regs.gscb, 32);
+    }
+
     /* pfault parameters */
     if (can_sync_regs(cs, KVM_SYNC_PFAULT)) {
         env->pfault_token = cs->kvm_run->s.regs.pft;
@@ -1474,22 +1489,28 @@ static void sigp_stop(CPUState *cs, run_on_cpu_data arg)
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
-#define ADTL_SAVE_AREA_SIZE 1024
-static int kvm_s390_store_adtl_status(S390CPU *cpu, hwaddr addr)
+#define ADTL_GS_OFFSET   1024 /* offset of GS data in adtl save area */
+#define ADTL_GS_MIN_SIZE 2048 /* minimal size of adtl save area for GS */
+static int do_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len)
 {
+    hwaddr save = len;
     void *mem;
-    hwaddr len = ADTL_SAVE_AREA_SIZE;
 
-    mem = cpu_physical_memory_map(addr, &len, 1);
+    mem = cpu_physical_memory_map(addr, &save, 1);
     if (!mem) {
         return -EFAULT;
     }
-    if (len != ADTL_SAVE_AREA_SIZE) {
+    if (save != len) {
         cpu_physical_memory_unmap(mem, len, 1, 0);
         return -EFAULT;
     }
 
-    memcpy(mem, &cpu->env.vregs, 512);
+    if (s390_has_feat(S390_FEAT_VECTOR)) {
+        memcpy(mem, &cpu->env.vregs, 512);
+    }
+    if (s390_has_feat(S390_FEAT_GUARDED_STORAGE) && len >= ADTL_GS_MIN_SIZE) {
+        memcpy(mem + ADTL_GS_OFFSET, &cpu->env.gscb, 32);
+    }
 
     cpu_physical_memory_unmap(mem, len, 1, len);
 
@@ -1585,12 +1606,17 @@ static void sigp_store_status_at_address(CPUState *cs, run_on_cpu_data arg)
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
+#define ADTL_SAVE_LC_MASK  0xfUL
 static void sigp_store_adtl_status(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPU *cpu = S390_CPU(cs);
     SigpInfo *si = arg.host_ptr;
+    uint8_t lc = si->param & ADTL_SAVE_LC_MASK;
+    hwaddr addr = si->param & ~ADTL_SAVE_LC_MASK;
+    hwaddr len = 1UL << (lc ? lc : 10);
 
-    if (!s390_has_feat(S390_FEAT_VECTOR)) {
+    if (!s390_has_feat(S390_FEAT_VECTOR) &&
+        !s390_has_feat(S390_FEAT_GUARDED_STORAGE)) {
         set_sigp_status(si, SIGP_STAT_INVALID_ORDER);
         return;
     }
@@ -1601,15 +1627,32 @@ static void sigp_store_adtl_status(CPUState *cs, run_on_cpu_data arg)
         return;
     }
 
-    /* parameter must be aligned to 1024-byte boundary */
-    if (si->param & 0x3ff) {
+    /* address must be aligned to length */
+    if (addr & (len - 1)) {
+        set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
+        return;
+    }
+
+    /* no GS: only lc == 0 is valid */
+    if (!s390_has_feat(S390_FEAT_GUARDED_STORAGE) &&
+        lc != 0) {
+        set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
+        return;
+    }
+
+    /* GS: 0, 10, 11, 12 are valid */
+    if (s390_has_feat(S390_FEAT_GUARDED_STORAGE) &&
+        lc != 0 &&
+        lc != 10 &&
+        lc != 11 &&
+        lc != 12) {
         set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
         return;
     }
 
     cpu_synchronize_state(cs);
 
-    if (kvm_s390_store_adtl_status(cpu, si->param)) {
+    if (do_store_adtl_status(cpu, addr, len)) {
         set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
         return;
     }
@@ -2188,6 +2231,9 @@ static uint64_t build_channel_report_mcic(void)
     if (s390_has_feat(S390_FEAT_VECTOR)) {
         mcic |= MCIC_VB_VR;
     }
+    if (s390_has_feat(S390_FEAT_GUARDED_STORAGE)) {
+        mcic |= MCIC_VB_GS;
+    }
     return mcic;
 }
 
@@ -2253,6 +2299,11 @@ int kvm_s390_get_ri(void)
     return cap_ri;
 }
 
+int kvm_s390_get_gs(void)
+{
+    return cap_gs;
+}
+
 int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
 {
     struct kvm_mp_state mp_state = {};
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index 8f908bb..2dcadfd 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -174,6 +174,22 @@ const VMStateDescription vmstate_exval = {
     }
 };
 
+static bool gscb_needed(void *opaque)
+{
+    return kvm_s390_get_gs();
+}
+
+const VMStateDescription vmstate_gscb = {
+    .name = "cpu/gscb",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = gscb_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(env.gscb, S390CPU, 4),
+        VMSTATE_END_OF_LIST()
+        }
+};
+
 const VMStateDescription vmstate_s390_cpu = {
     .name = "cpu",
     .post_load = cpu_post_load,
@@ -207,6 +223,7 @@ const VMStateDescription vmstate_s390_cpu = {
         &vmstate_vregs,
         &vmstate_riccb,
         &vmstate_exval,
+        &vmstate_gscb,
         NULL
     },
 };
-- 
2.7.4
