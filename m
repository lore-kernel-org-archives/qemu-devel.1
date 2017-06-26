Received: from eggs.gnu.org ([2001:4830:134:3::10]:50051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dPbaj-0003LP-BN
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 17:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dPbai-0005t3-2Q
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 17:30:41 -0400
From: Alexander Graf <agraf@suse.de>
Date: Mon, 26 Jun 2017 23:30:56 +0200
Message-Id: <1498512656-75289-1-git-send-email-agraf@suse.de>
Subject: [Qemu-devel] [PATCH] ARM: KVM: Enable in-kernel timers with user
 space gic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, cdall@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

When running with KVM enabled, you can choose between emulating the
gic in kernel or user space. If the kernel supports in-kernel virtualization
of the interrupt controller, it will default to that. If not, if will
default to user space emulation.

Unfortunately when running in user mode gic emulation, we miss out on
interrupt events which are only available from kernel space, such as the timer.
This patch leverages the new kernel/user space pending line synchronization for
timer events. It does not handle PMU events yet.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 accel/kvm/kvm-all.c    |  5 +++++
 accel/stubs/kvm-stub.c |  5 +++++
 hw/intc/arm_gic.c      |  7 +++++++
 include/sysemu/kvm.h   | 11 +++++++++++
 target/arm/cpu.h       |  3 +++
 target/arm/kvm.c       | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 80 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 75feffa..ade32ea 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2285,6 +2285,11 @@ int kvm_has_intx_set_mask(void)
     return kvm_state->intx_set_mask;
 }
 
+bool kvm_arm_supports_user_irq(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_ARM_USER_IRQ);
+}
+
 #ifdef KVM_CAP_SET_GUEST_DEBUG
 struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu,
                                                  target_ulong pc)
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index ef0c734..3965c52 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -155,4 +155,9 @@ void kvm_init_cpu_signals(CPUState *cpu)
 {
     abort();
 }
+
+bool kvm_arm_supports_user_irq(void)
+{
+    return false;
+}
 #endif
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index b305d90..4ffd905 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -25,6 +25,7 @@
 #include "qom/cpu.h"
 #include "qemu/log.h"
 #include "trace.h"
+#include "sysemu/kvm.h"
 
 /* #define DEBUG_GIC */
 
@@ -1412,6 +1413,12 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (kvm_enabled() && !kvm_arm_supports_user_irq()) {
+            error_setg(errp, "KVM with user space irqchip only works when the "
+                             "host kernel supports KVM_CAP_ARM_USER_IRQ");
+            return;
+    }
+
     /* This creates distributor and main CPU interface (s->cpuiomem[0]) */
     gic_init_irqs_and_mmio(s, gic_set_irq, gic_ops);
 
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 1e91613..9f11fc0 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -227,6 +227,17 @@ int kvm_init_vcpu(CPUState *cpu);
 int kvm_cpu_exec(CPUState *cpu);
 int kvm_destroy_vcpu(CPUState *cpu);
 
+/**
+ * kvm_arm_supports_user_irq
+ *
+ * Not all KVM implementations support notifications for kernel generated
+ * interrupt events to user space. This function indicates whether the current
+ * KVM implementation does support them.
+ *
+ * Returns: true if KVM supports using kernel generated IRQs from user space
+ */
+bool kvm_arm_supports_user_irq(void);
+
 #ifdef NEED_CPU_H
 #include "cpu.h"
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 16a1e59..88ec3ee 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -706,6 +706,9 @@ struct ARMCPU {
     void *el_change_hook_opaque;
 
     int32_t node_id; /* NUMA node this CPU belongs to */
+
+    /* Used to synchronize KVM and QEMU timer levels */
+    uint8_t device_irq_level;
 };
 
 static inline ARMCPU *arm_env_get_cpu(CPUARMState *env)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 4555468..29ee72d 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -174,6 +174,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
      */
     kvm_async_interrupts_allowed = true;
 
+    /*
+     * PSCI wakes up secondary cores, so we always need to
+     * have vCPUs waiting in kernel space
+     */
+    kvm_halt_in_kernel_allowed = true;
+
     cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
 
     type_register_static(&host_arm_cpu_type_info);
@@ -528,6 +534,49 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
 
 MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
 {
+    ARMCPU *cpu;
+    uint32_t switched_level;
+
+    if (kvm_irqchip_in_kernel()) {
+        /*
+         * We only need to sync timer states with user-space interrupt
+         * controllers, so return early and save cycles if we don't.
+         */
+        return MEMTXATTRS_UNSPECIFIED;
+    }
+
+    cpu = ARM_CPU(cs);
+
+    /* Synchronize our internal timer irq lines with the kvm ones */
+    if (run->s.regs.device_irq_level != cpu->device_irq_level) {
+        switched_level = cpu->device_irq_level ^ run->s.regs.device_irq_level;
+
+        qemu_mutex_lock_iothread();
+
+        if (switched_level & KVM_ARM_DEV_EL1_VTIMER) {
+            qemu_set_irq(cpu->gt_timer_outputs[GTIMER_VIRT],
+                         run->s.regs.device_irq_level & KVM_ARM_DEV_EL1_VTIMER);
+            switched_level &= ~KVM_ARM_DEV_EL1_VTIMER;
+        }
+
+        if (switched_level & KVM_ARM_DEV_EL1_PTIMER) {
+            qemu_set_irq(cpu->gt_timer_outputs[GTIMER_PHYS],
+                         run->s.regs.device_irq_level & KVM_ARM_DEV_EL1_PTIMER);
+            switched_level &= ~KVM_ARM_DEV_EL1_PTIMER;
+        }
+
+        /* XXX PMU IRQ is missing */
+
+        if (switched_level) {
+            qemu_log_mask(LOG_UNIMP, "%s: unhandled device IRQ %x\n",
+                          __func__, switched_level);
+        }
+
+        /* We also mark unknown levels as processed to not waste cycles */
+        cpu->device_irq_level = run->s.regs.device_irq_level;
+        qemu_mutex_unlock_iothread();
+    }
+
     return MEMTXATTRS_UNSPECIFIED;
 }
 
-- 
1.8.5.6
