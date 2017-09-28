Received: from eggs.gnu.org ([2001:4830:134:3::10]:53482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfZi-0004VU-0B
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfZd-0003QO-RW
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfZd-0003QB-GC
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:21 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:36:54 +0200
Message-Id: <20170928203708.9376-17-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 16/30] s390x/kvm: factor out SIGP code into
 sigp.c
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
List-ID: <qemu-devel.nongnu.org>

We want to use the same code base for TCG, so let's cleanly factor it
out.

The sigp mutex is currently not really needed, as everything is
protected by the iothread mutex. But this could change later, so leave
it in place and initialize it properly from common code.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c |   3 +
 target/s390x/Makefile.objs |   1 +
 target/s390x/cpu.c         |   8 -
 target/s390x/cpu.h         |   6 +-
 target/s390x/internal.h    |   4 +
 target/s390x/kvm-stub.c    |   5 -
 target/s390x/kvm.c         | 349 +-----------------------------------------
 target/s390x/kvm_s390x.h   |   1 -
 target/s390x/sigp.c        | 366 +++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/trace-events  |   4 +-
 10 files changed, 388 insertions(+), 359 deletions(-)
 create mode 100644 target/s390x/sigp.c

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index c747b22d66..d188ce17ba 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -265,6 +265,9 @@ static void ccw_init(MachineState *machine)
     /* init CPUs (incl. CPU model) early so s390_has_feature() works */
     s390_init_cpus(machine);
 
+    /* init the SIGP facility */
+    s390_init_sigp();
+
     /* get a BUS */
     css_bus = virtual_css_bus_init();
     s390_init_ipl_dev(machine->kernel_filename, machine->kernel_cmdline,
diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index c88ac81e84..31932de9cf 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -2,6 +2,7 @@ obj-y += cpu.o cpu_models.o cpu_features.o gdbstub.o interrupt.o helper.o
 obj-$(CONFIG_TCG) += translate.o cc_helper.o excp_helper.o fpu_helper.o
 obj-$(CONFIG_TCG) += int_helper.o mem_helper.o misc_helper.o crypto_helper.o
 obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o mmu_helper.o diag.o
+obj-$(CONFIG_SOFTMMU) += sigp.o
 obj-$(CONFIG_KVM) += kvm.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index a0b139056f..e27827afb3 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -386,14 +386,6 @@ void s390_cmma_reset(void)
     }
 }
 
-int s390_cpu_restart(S390CPU *cpu)
-{
-    if (kvm_enabled()) {
-        return kvm_s390_cpu_restart(cpu);
-    }
-    return -ENOSYS;
-}
-
 int s390_get_memslot_count(void)
 {
     if (kvm_enabled()) {
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 6ae0c7dfc8..f94d7f96e0 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -676,7 +676,6 @@ bool s390_get_squash_mcss(void);
 int s390_get_memslot_count(void);
 int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit);
 void s390_cmma_reset(void);
-int s390_cpu_restart(S390CPU *cpu);
 void s390_enable_css_support(S390CPU *cpu);
 int s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch_id,
                                 int vq, bool assign);
@@ -730,6 +729,11 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
         s390_cpu_virt_mem_rw(cpu, laddr, ar, NULL, len, true)
 
 
+/* sigp.c */
+int s390_cpu_restart(S390CPU *cpu);
+void s390_init_sigp(void);
+
+
 /* outside of target/s390x/ */
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
 
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index fb8ff6b078..d6ab45add4 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -415,4 +415,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3);
 /* translate.c */
 void s390x_translate_init(void);
 
+
+/* sigp.c */
+int handle_sigp(CPUS390XState *env, uint8_t order, uint64_t r1, uint64_t r3);
+
 #endif /* S390X_INTERNAL_H */
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
index 18b53b2ad6..861b4dedf6 100644
--- a/target/s390x/kvm-stub.c
+++ b/target/s390x/kvm-stub.c
@@ -83,11 +83,6 @@ int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
     return -ENOSYS;
 }
 
-int kvm_s390_cpu_restart(S390CPU *cpu)
-{
-    return -ENOSYS;
-}
-
 void kvm_s390_cmma_reset(void)
 {
 }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index fbbdca23b2..1174e249ab 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -135,8 +135,6 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
 
-static QemuMutex qemu_sigp_mutex;
-
 static int cap_sync_regs;
 static int cap_async_pf;
 static int cap_mem_op;
@@ -316,8 +314,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
     /* The AIS enablement happens in the flic realize */
 
-    qemu_mutex_init(&qemu_sigp_mutex);
-
     return 0;
 }
 
@@ -1471,355 +1467,22 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
     return r;
 }
 
-typedef struct SigpInfo {
-    uint64_t param;
-    int cc;
-    uint64_t *status_reg;
-} SigpInfo;
-
-static void set_sigp_status(SigpInfo *si, uint64_t status)
-{
-    *si->status_reg &= 0xffffffff00000000ULL;
-    *si->status_reg |= status;
-    si->cc = SIGP_CC_STATUS_STORED;
-}
-
-static void sigp_start(CPUState *cs, run_on_cpu_data arg)
-{
-    S390CPU *cpu = S390_CPU(cs);
-    SigpInfo *si = arg.host_ptr;
-
-    if (s390_cpu_get_state(cpu) != CPU_STATE_STOPPED) {
-        si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
-        return;
-    }
-
-    s390_cpu_set_state(CPU_STATE_OPERATING, cpu);
-    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
-}
-
-static void sigp_stop(CPUState *cs, run_on_cpu_data arg)
-{
-    S390CPU *cpu = S390_CPU(cs);
-    SigpInfo *si = arg.host_ptr;
-
-    if (s390_cpu_get_state(cpu) != CPU_STATE_OPERATING) {
-        si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
-        return;
-    }
-
-    /* disabled wait - sleeping in user space */
-    if (cs->halted) {
-        s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
-    } else {
-        /* execute the stop function */
-        cpu->env.sigp_order = SIGP_STOP;
-        cpu_inject_stop(cpu);
-    }
-    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
-}
-
-static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
-{
-    S390CPU *cpu = S390_CPU(cs);
-    SigpInfo *si = arg.host_ptr;
-
-    /* disabled wait - sleeping in user space */
-    if (s390_cpu_get_state(cpu) == CPU_STATE_OPERATING && cs->halted) {
-        s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
-    }
-
-    switch (s390_cpu_get_state(cpu)) {
-    case CPU_STATE_OPERATING:
-        cpu->env.sigp_order = SIGP_STOP_STORE_STATUS;
-        cpu_inject_stop(cpu);
-        /* store will be performed when handling the stop intercept */
-        break;
-    case CPU_STATE_STOPPED:
-        /* already stopped, just store the status */
-        cpu_synchronize_state(cs);
-        s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
-        break;
-    }
-    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
-}
-
-static void sigp_store_status_at_address(CPUState *cs, run_on_cpu_data arg)
-{
-    S390CPU *cpu = S390_CPU(cs);
-    SigpInfo *si = arg.host_ptr;
-    uint32_t address = si->param & 0x7ffffe00u;
-
-    /* cpu has to be stopped */
-    if (s390_cpu_get_state(cpu) != CPU_STATE_STOPPED) {
-        set_sigp_status(si, SIGP_STAT_INCORRECT_STATE);
-        return;
-    }
-
-    cpu_synchronize_state(cs);
-
-    if (s390_store_status(cpu, address, false)) {
-        set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
-        return;
-    }
-    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
-}
-
-#define ADTL_SAVE_LC_MASK  0xfUL
-static void sigp_store_adtl_status(CPUState *cs, run_on_cpu_data arg)
-{
-    S390CPU *cpu = S390_CPU(cs);
-    SigpInfo *si = arg.host_ptr;
-    uint8_t lc = si->param & ADTL_SAVE_LC_MASK;
-    hwaddr addr = si->param & ~ADTL_SAVE_LC_MASK;
-    hwaddr len = 1UL << (lc ? lc : 10);
-
-    if (!s390_has_feat(S390_FEAT_VECTOR) &&
-        !s390_has_feat(S390_FEAT_GUARDED_STORAGE)) {
-        set_sigp_status(si, SIGP_STAT_INVALID_ORDER);
-        return;
-    }
-
-    /* cpu has to be stopped */
-    if (s390_cpu_get_state(cpu) != CPU_STATE_STOPPED) {
-        set_sigp_status(si, SIGP_STAT_INCORRECT_STATE);
-        return;
-    }
-
-    /* address must be aligned to length */
-    if (addr & (len - 1)) {
-        set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
-        return;
-    }
-
-    /* no GS: only lc == 0 is valid */
-    if (!s390_has_feat(S390_FEAT_GUARDED_STORAGE) &&
-        lc != 0) {
-        set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
-        return;
-    }
-
-    /* GS: 0, 10, 11, 12 are valid */
-    if (s390_has_feat(S390_FEAT_GUARDED_STORAGE) &&
-        lc != 0 &&
-        lc != 10 &&
-        lc != 11 &&
-        lc != 12) {
-        set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
-        return;
-    }
-
-    cpu_synchronize_state(cs);
-
-    if (s390_store_adtl_status(cpu, addr, len)) {
-        set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
-        return;
-    }
-    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
-}
-
-static void sigp_restart(CPUState *cs, run_on_cpu_data arg)
-{
-    S390CPU *cpu = S390_CPU(cs);
-    SigpInfo *si = arg.host_ptr;
-
-    switch (s390_cpu_get_state(cpu)) {
-    case CPU_STATE_STOPPED:
-        /* the restart irq has to be delivered prior to any other pending irq */
-        cpu_synchronize_state(cs);
-        do_restart_interrupt(&cpu->env);
-        s390_cpu_set_state(CPU_STATE_OPERATING, cpu);
-        break;
-    case CPU_STATE_OPERATING:
-        cpu_inject_restart(cpu);
-        break;
-    }
-    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
-}
-
-int kvm_s390_cpu_restart(S390CPU *cpu)
-{
-    SigpInfo si = {};
-
-    run_on_cpu(CPU(cpu), sigp_restart, RUN_ON_CPU_HOST_PTR(&si));
-    return 0;
-}
-
-static void sigp_initial_cpu_reset(CPUState *cs, run_on_cpu_data arg)
-{
-    S390CPU *cpu = S390_CPU(cs);
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
-    SigpInfo *si = arg.host_ptr;
-
-    cpu_synchronize_state(cs);
-    scc->initial_cpu_reset(cs);
-    cpu_synchronize_post_reset(cs);
-    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
-}
-
-static void sigp_cpu_reset(CPUState *cs, run_on_cpu_data arg)
-{
-    S390CPU *cpu = S390_CPU(cs);
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
-    SigpInfo *si = arg.host_ptr;
-
-    cpu_synchronize_state(cs);
-    scc->cpu_reset(cs);
-    cpu_synchronize_post_reset(cs);
-    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
-}
-
-static void sigp_set_prefix(CPUState *cs, run_on_cpu_data arg)
-{
-    S390CPU *cpu = S390_CPU(cs);
-    SigpInfo *si = arg.host_ptr;
-    uint32_t addr = si->param & 0x7fffe000u;
-
-    cpu_synchronize_state(cs);
-
-    if (!address_space_access_valid(&address_space_memory, addr,
-                                    sizeof(struct LowCore), false)) {
-        set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
-        return;
-    }
-
-    /* cpu has to be stopped */
-    if (s390_cpu_get_state(cpu) != CPU_STATE_STOPPED) {
-        set_sigp_status(si, SIGP_STAT_INCORRECT_STATE);
-        return;
-    }
-
-    cpu->env.psa = addr;
-    cpu_synchronize_post_init(cs);
-    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
-}
-
-static int handle_sigp_single_dst(S390CPU *dst_cpu, uint8_t order,
-                                  uint64_t param, uint64_t *status_reg)
-{
-    SigpInfo si = {
-        .param = param,
-        .status_reg = status_reg,
-    };
-
-    /* cpu available? */
-    if (dst_cpu == NULL) {
-        return SIGP_CC_NOT_OPERATIONAL;
-    }
-
-    /* only resets can break pending orders */
-    if (dst_cpu->env.sigp_order != 0 &&
-        order != SIGP_CPU_RESET &&
-        order != SIGP_INITIAL_CPU_RESET) {
-        return SIGP_CC_BUSY;
-    }
-
-    switch (order) {
-    case SIGP_START:
-        run_on_cpu(CPU(dst_cpu), sigp_start, RUN_ON_CPU_HOST_PTR(&si));
-        break;
-    case SIGP_STOP:
-        run_on_cpu(CPU(dst_cpu), sigp_stop, RUN_ON_CPU_HOST_PTR(&si));
-        break;
-    case SIGP_RESTART:
-        run_on_cpu(CPU(dst_cpu), sigp_restart, RUN_ON_CPU_HOST_PTR(&si));
-        break;
-    case SIGP_STOP_STORE_STATUS:
-        run_on_cpu(CPU(dst_cpu), sigp_stop_and_store_status, RUN_ON_CPU_HOST_PTR(&si));
-        break;
-    case SIGP_STORE_STATUS_ADDR:
-        run_on_cpu(CPU(dst_cpu), sigp_store_status_at_address, RUN_ON_CPU_HOST_PTR(&si));
-        break;
-    case SIGP_STORE_ADTL_STATUS:
-        run_on_cpu(CPU(dst_cpu), sigp_store_adtl_status, RUN_ON_CPU_HOST_PTR(&si));
-        break;
-    case SIGP_SET_PREFIX:
-        run_on_cpu(CPU(dst_cpu), sigp_set_prefix, RUN_ON_CPU_HOST_PTR(&si));
-        break;
-    case SIGP_INITIAL_CPU_RESET:
-        run_on_cpu(CPU(dst_cpu), sigp_initial_cpu_reset, RUN_ON_CPU_HOST_PTR(&si));
-        break;
-    case SIGP_CPU_RESET:
-        run_on_cpu(CPU(dst_cpu), sigp_cpu_reset, RUN_ON_CPU_HOST_PTR(&si));
-        break;
-    default:
-        set_sigp_status(&si, SIGP_STAT_INVALID_ORDER);
-    }
-
-    return si.cc;
-}
-
-static int sigp_set_architecture(S390CPU *cpu, uint32_t param,
-                                 uint64_t *status_reg)
-{
-    CPUState *cur_cs;
-    S390CPU *cur_cpu;
-    bool all_stopped = true;
-
-    CPU_FOREACH(cur_cs) {
-        cur_cpu = S390_CPU(cur_cs);
-
-        if (cur_cpu == cpu) {
-            continue;
-        }
-        if (s390_cpu_get_state(cur_cpu) != CPU_STATE_STOPPED) {
-            all_stopped = false;
-        }
-    }
-
-    *status_reg &= 0xffffffff00000000ULL;
-
-    /* Reject set arch order, with czam we're always in z/Arch mode. */
-    *status_reg |= (all_stopped ? SIGP_STAT_INVALID_PARAMETER :
-                    SIGP_STAT_INCORRECT_STATE);
-    return SIGP_CC_STATUS_STORED;
-}
-
-static int handle_sigp(S390CPU *cpu, uint8_t ipa1, uint32_t ipb)
+static int kvm_s390_handle_sigp(S390CPU *cpu, uint8_t ipa1, uint32_t ipb)
 {
     CPUS390XState *env = &cpu->env;
     const uint8_t r1 = ipa1 >> 4;
     const uint8_t r3 = ipa1 & 0x0f;
     int ret;
     uint8_t order;
-    uint64_t *status_reg;
-    uint64_t param;
-    S390CPU *dst_cpu = NULL;
 
     cpu_synchronize_state(CPU(cpu));
 
     /* get order code */
-    order = decode_basedisp_rs(env, ipb, NULL)
-        & SIGP_ORDER_MASK;
-    status_reg = &env->regs[r1];
-    param = (r1 % 2) ? env->regs[r1] : env->regs[r1 + 1];
+    order = decode_basedisp_rs(env, ipb, NULL) & SIGP_ORDER_MASK;
 
-    if (qemu_mutex_trylock(&qemu_sigp_mutex)) {
-        ret = SIGP_CC_BUSY;
-        goto out;
-    }
-
-    switch (order) {
-    case SIGP_SET_ARCH:
-        ret = sigp_set_architecture(cpu, param, status_reg);
-        break;
-    default:
-        /* all other sigp orders target a single vcpu */
-        dst_cpu = s390_cpu_addr2state(env->regs[r3]);
-        ret = handle_sigp_single_dst(dst_cpu, order, param, status_reg);
-    }
-    qemu_mutex_unlock(&qemu_sigp_mutex);
-
-out:
-    trace_kvm_sigp_finished(order, CPU(cpu)->cpu_index,
-                            dst_cpu ? CPU(dst_cpu)->cpu_index : -1, ret);
-
-    if (ret >= 0) {
-        setcc(cpu, ret);
-        return 0;
-    }
-
-    return ret;
+    ret = handle_sigp(env, order, r1, r3);
+    setcc(cpu, ret);
+    return 0;
 }
 
 static int handle_instruction(S390CPU *cpu, struct kvm_run *run)
@@ -1847,7 +1510,7 @@ static int handle_instruction(S390CPU *cpu, struct kvm_run *run)
         r = handle_diag(cpu, run, run->s390_sieic.ipb);
         break;
     case IPA0_SIGP:
-        r = handle_sigp(cpu, ipa1, run->s390_sieic.ipb);
+        r = kvm_s390_handle_sigp(cpu, ipa1, run->s390_sieic.ipb);
         break;
     }
 
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index fd03cd662a..33906a893b 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -33,7 +33,6 @@ int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_clock);
 void kvm_s390_enable_css_support(S390CPU *cpu);
 int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
                                     int vq, bool assign);
-int kvm_s390_cpu_restart(S390CPU *cpu);
 int kvm_s390_get_memslot_count(void);
 int kvm_s390_cmma_active(void);
 void kvm_s390_cmma_reset(void);
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
new file mode 100644
index 0000000000..4813123aad
--- /dev/null
+++ b/target/s390x/sigp.c
@@ -0,0 +1,366 @@
+/*
+ * s390x SIGP instruction handling
+ *
+ * Copyright (c) 2009 Alexander Graf <agraf@suse.de>
+ * Copyright IBM Corp. 2012
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "internal.h"
+#include "sysemu/hw_accel.h"
+#include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
+#include "trace.h"
+
+QemuMutex qemu_sigp_mutex;
+
+typedef struct SigpInfo {
+    uint64_t param;
+    int cc;
+    uint64_t *status_reg;
+} SigpInfo;
+
+static void set_sigp_status(SigpInfo *si, uint64_t status)
+{
+    *si->status_reg &= 0xffffffff00000000ULL;
+    *si->status_reg |= status;
+    si->cc = SIGP_CC_STATUS_STORED;
+}
+
+static void sigp_start(CPUState *cs, run_on_cpu_data arg)
+{
+    S390CPU *cpu = S390_CPU(cs);
+    SigpInfo *si = arg.host_ptr;
+
+    if (s390_cpu_get_state(cpu) != CPU_STATE_STOPPED) {
+        si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+        return;
+    }
+
+    s390_cpu_set_state(CPU_STATE_OPERATING, cpu);
+    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+}
+
+static void sigp_stop(CPUState *cs, run_on_cpu_data arg)
+{
+    S390CPU *cpu = S390_CPU(cs);
+    SigpInfo *si = arg.host_ptr;
+
+    if (s390_cpu_get_state(cpu) != CPU_STATE_OPERATING) {
+        si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+        return;
+    }
+
+    /* disabled wait - sleeping in user space */
+    if (cs->halted) {
+        s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
+    } else {
+        /* execute the stop function */
+        cpu->env.sigp_order = SIGP_STOP;
+        cpu_inject_stop(cpu);
+    }
+    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+}
+
+static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
+{
+    S390CPU *cpu = S390_CPU(cs);
+    SigpInfo *si = arg.host_ptr;
+
+    /* disabled wait - sleeping in user space */
+    if (s390_cpu_get_state(cpu) == CPU_STATE_OPERATING && cs->halted) {
+        s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
+    }
+
+    switch (s390_cpu_get_state(cpu)) {
+    case CPU_STATE_OPERATING:
+        cpu->env.sigp_order = SIGP_STOP_STORE_STATUS;
+        cpu_inject_stop(cpu);
+        /* store will be performed when handling the stop intercept */
+        break;
+    case CPU_STATE_STOPPED:
+        /* already stopped, just store the status */
+        cpu_synchronize_state(cs);
+        s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
+        break;
+    }
+    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+}
+
+static void sigp_store_status_at_address(CPUState *cs, run_on_cpu_data arg)
+{
+    S390CPU *cpu = S390_CPU(cs);
+    SigpInfo *si = arg.host_ptr;
+    uint32_t address = si->param & 0x7ffffe00u;
+
+    /* cpu has to be stopped */
+    if (s390_cpu_get_state(cpu) != CPU_STATE_STOPPED) {
+        set_sigp_status(si, SIGP_STAT_INCORRECT_STATE);
+        return;
+    }
+
+    cpu_synchronize_state(cs);
+
+    if (s390_store_status(cpu, address, false)) {
+        set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
+        return;
+    }
+    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+}
+
+#define ADTL_SAVE_LC_MASK  0xfUL
+static void sigp_store_adtl_status(CPUState *cs, run_on_cpu_data arg)
+{
+    S390CPU *cpu = S390_CPU(cs);
+    SigpInfo *si = arg.host_ptr;
+    uint8_t lc = si->param & ADTL_SAVE_LC_MASK;
+    hwaddr addr = si->param & ~ADTL_SAVE_LC_MASK;
+    hwaddr len = 1UL << (lc ? lc : 10);
+
+    if (!s390_has_feat(S390_FEAT_VECTOR) &&
+        !s390_has_feat(S390_FEAT_GUARDED_STORAGE)) {
+        set_sigp_status(si, SIGP_STAT_INVALID_ORDER);
+        return;
+    }
+
+    /* cpu has to be stopped */
+    if (s390_cpu_get_state(cpu) != CPU_STATE_STOPPED) {
+        set_sigp_status(si, SIGP_STAT_INCORRECT_STATE);
+        return;
+    }
+
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
+        set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
+        return;
+    }
+
+    cpu_synchronize_state(cs);
+
+    if (s390_store_adtl_status(cpu, addr, len)) {
+        set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
+        return;
+    }
+    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+}
+
+static void sigp_restart(CPUState *cs, run_on_cpu_data arg)
+{
+    S390CPU *cpu = S390_CPU(cs);
+    SigpInfo *si = arg.host_ptr;
+
+    switch (s390_cpu_get_state(cpu)) {
+    case CPU_STATE_STOPPED:
+        /* the restart irq has to be delivered prior to any other pending irq */
+        cpu_synchronize_state(cs);
+        do_restart_interrupt(&cpu->env);
+        s390_cpu_set_state(CPU_STATE_OPERATING, cpu);
+        break;
+    case CPU_STATE_OPERATING:
+        cpu_inject_restart(cpu);
+        break;
+    }
+    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+}
+
+static void sigp_initial_cpu_reset(CPUState *cs, run_on_cpu_data arg)
+{
+    S390CPU *cpu = S390_CPU(cs);
+    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
+    SigpInfo *si = arg.host_ptr;
+
+    cpu_synchronize_state(cs);
+    scc->initial_cpu_reset(cs);
+    cpu_synchronize_post_reset(cs);
+    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+}
+
+static void sigp_cpu_reset(CPUState *cs, run_on_cpu_data arg)
+{
+    S390CPU *cpu = S390_CPU(cs);
+    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
+    SigpInfo *si = arg.host_ptr;
+
+    cpu_synchronize_state(cs);
+    scc->cpu_reset(cs);
+    cpu_synchronize_post_reset(cs);
+    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+}
+
+static void sigp_set_prefix(CPUState *cs, run_on_cpu_data arg)
+{
+    S390CPU *cpu = S390_CPU(cs);
+    SigpInfo *si = arg.host_ptr;
+    uint32_t addr = si->param & 0x7fffe000u;
+
+    cpu_synchronize_state(cs);
+
+    if (!address_space_access_valid(&address_space_memory, addr,
+                                    sizeof(struct LowCore), false)) {
+        set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
+        return;
+    }
+
+    /* cpu has to be stopped */
+    if (s390_cpu_get_state(cpu) != CPU_STATE_STOPPED) {
+        set_sigp_status(si, SIGP_STAT_INCORRECT_STATE);
+        return;
+    }
+
+    cpu->env.psa = addr;
+    cpu_synchronize_post_init(cs);
+    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+}
+
+static int handle_sigp_single_dst(S390CPU *dst_cpu, uint8_t order,
+                                  uint64_t param, uint64_t *status_reg)
+{
+    SigpInfo si = {
+        .param = param,
+        .status_reg = status_reg,
+    };
+
+    /* cpu available? */
+    if (dst_cpu == NULL) {
+        return SIGP_CC_NOT_OPERATIONAL;
+    }
+
+    /* only resets can break pending orders */
+    if (dst_cpu->env.sigp_order != 0 &&
+        order != SIGP_CPU_RESET &&
+        order != SIGP_INITIAL_CPU_RESET) {
+        return SIGP_CC_BUSY;
+    }
+
+    switch (order) {
+    case SIGP_START:
+        run_on_cpu(CPU(dst_cpu), sigp_start, RUN_ON_CPU_HOST_PTR(&si));
+        break;
+    case SIGP_STOP:
+        run_on_cpu(CPU(dst_cpu), sigp_stop, RUN_ON_CPU_HOST_PTR(&si));
+        break;
+    case SIGP_RESTART:
+        run_on_cpu(CPU(dst_cpu), sigp_restart, RUN_ON_CPU_HOST_PTR(&si));
+        break;
+    case SIGP_STOP_STORE_STATUS:
+        run_on_cpu(CPU(dst_cpu), sigp_stop_and_store_status, RUN_ON_CPU_HOST_PTR(&si));
+        break;
+    case SIGP_STORE_STATUS_ADDR:
+        run_on_cpu(CPU(dst_cpu), sigp_store_status_at_address, RUN_ON_CPU_HOST_PTR(&si));
+        break;
+    case SIGP_STORE_ADTL_STATUS:
+        run_on_cpu(CPU(dst_cpu), sigp_store_adtl_status, RUN_ON_CPU_HOST_PTR(&si));
+        break;
+    case SIGP_SET_PREFIX:
+        run_on_cpu(CPU(dst_cpu), sigp_set_prefix, RUN_ON_CPU_HOST_PTR(&si));
+        break;
+    case SIGP_INITIAL_CPU_RESET:
+        run_on_cpu(CPU(dst_cpu), sigp_initial_cpu_reset, RUN_ON_CPU_HOST_PTR(&si));
+        break;
+    case SIGP_CPU_RESET:
+        run_on_cpu(CPU(dst_cpu), sigp_cpu_reset, RUN_ON_CPU_HOST_PTR(&si));
+        break;
+    default:
+        set_sigp_status(&si, SIGP_STAT_INVALID_ORDER);
+    }
+
+    return si.cc;
+}
+
+static int sigp_set_architecture(S390CPU *cpu, uint32_t param,
+                                 uint64_t *status_reg)
+{
+    CPUState *cur_cs;
+    S390CPU *cur_cpu;
+    bool all_stopped = true;
+
+    CPU_FOREACH(cur_cs) {
+        cur_cpu = S390_CPU(cur_cs);
+
+        if (cur_cpu == cpu) {
+            continue;
+        }
+        if (s390_cpu_get_state(cur_cpu) != CPU_STATE_STOPPED) {
+            all_stopped = false;
+        }
+    }
+
+    *status_reg &= 0xffffffff00000000ULL;
+
+    /* Reject set arch order, with czam we're always in z/Arch mode. */
+    *status_reg |= (all_stopped ? SIGP_STAT_INVALID_PARAMETER :
+                    SIGP_STAT_INCORRECT_STATE);
+    return SIGP_CC_STATUS_STORED;
+}
+
+int handle_sigp(CPUS390XState *env, uint8_t order, uint64_t r1, uint64_t r3)
+{
+    uint64_t *status_reg = &env->regs[r1];
+    uint64_t param = (r1 % 2) ? env->regs[r1] : env->regs[r1 + 1];
+    S390CPU *cpu = s390_env_get_cpu(env);
+    S390CPU *dst_cpu = NULL;
+    int ret;
+
+    if (qemu_mutex_trylock(&qemu_sigp_mutex)) {
+        ret = SIGP_CC_BUSY;
+        goto out;
+    }
+
+    switch (order) {
+    case SIGP_SET_ARCH:
+        ret = sigp_set_architecture(cpu, param, status_reg);
+        break;
+    default:
+        /* all other sigp orders target a single vcpu */
+        dst_cpu = s390_cpu_addr2state(env->regs[r3]);
+        ret = handle_sigp_single_dst(dst_cpu, order, param, status_reg);
+    }
+    qemu_mutex_unlock(&qemu_sigp_mutex);
+
+out:
+    trace_sigp_finished(order, CPU(cpu)->cpu_index,
+                        dst_cpu ? CPU(dst_cpu)->cpu_index : -1, ret);
+    g_assert(ret >= 0);
+
+    return ret;
+}
+
+int s390_cpu_restart(S390CPU *cpu)
+{
+    SigpInfo si = {};
+
+    if (tcg_enabled()) {
+        /* FIXME TCG */
+        return -ENOSYS;
+    }
+
+    run_on_cpu(CPU(cpu), sigp_restart, RUN_ON_CPU_HOST_PTR(&si));
+    return 0;
+}
+
+void s390_init_sigp(void)
+{
+    qemu_mutex_init(&qemu_sigp_mutex);
+}
diff --git a/target/s390x/trace-events b/target/s390x/trace-events
index 4d871f5087..a84e316e49 100644
--- a/target/s390x/trace-events
+++ b/target/s390x/trace-events
@@ -14,9 +14,11 @@ ioinst_chsc_cmd(uint16_t cmd, uint16_t len) "IOINST: chsc command 0x%04x, len 0x
 kvm_enable_cmma(int rc) "CMMA: enabling with result code %d"
 kvm_clear_cmma(int rc) "CMMA: clearing with result code %d"
 kvm_failed_cpu_state_set(int cpu_index, uint8_t state, const char *msg) "Warning: Unable to set cpu %d state %" PRIu8 " to KVM: %s"
-kvm_sigp_finished(uint8_t order, int cpu_index, int dst_index, int cc) "SIGP: Finished order %u on cpu %d -> cpu %d with cc=%d"
 
 # target/s390x/cpu.c
 cpu_set_state(int cpu_index, uint8_t state) "setting cpu %d state to %" PRIu8
 cpu_halt(int cpu_index) "halting cpu %d"
 cpu_unhalt(int cpu_index) "unhalting cpu %d"
+
+# target/s390x/sigp.c
+sigp_finished(uint8_t order, int cpu_index, int dst_index, int cc) "SIGP: Finished order %u on cpu %d -> cpu %d with cc=%d"
-- 
2.13.5
