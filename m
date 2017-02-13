Received: from eggs.gnu.org ([2001:4830:134:3::10]:55191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdFYx-0003UE-0A
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:17:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdFYu-000427-22
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:16:58 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:35886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cdFYt-00041j-O4
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:16:55 -0500
Received: by mail-wm0-x231.google.com with SMTP id c85so306491316wmi.1
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 04:16:55 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 13 Feb 2017 12:10:13 +0000
Message-Id: <20170213121017.12907-21-alex.bennee@linaro.org>
In-Reply-To: <20170213121017.12907-1-alex.bennee@linaro.org>
References: <20170213121017.12907-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v12 20/24] target-arm/powerctl: defer cpu reset
 work to CPU context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net
Cc: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

When switching a new vCPU on we want to complete a bunch of the setup
work before we start scheduling the vCPU thread. To do this cleanly we
defer vCPU setup to async work which will run the vCPUs execution
context as the thread is woken up. The scheduling of the work will kick
the vCPU awake.

This avoids potential races in MTTCG system emulation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>

---
v7
  - add const to static mode_for_el[] array
  - fix checkpatch long lines
v10
  - use async work for arm_set_cpu_off, arm_reset_cpu as well
  - model ON_PENDING to deal with racing arm_set_cpu_on
v11
  - move to single cpu->power_state protected by BQL
  - bump migration format
v12
  - cpu_on_info -> CpuOnInfo
  - map PSCI_ON/OFF/PENDING to affinity return types to avoid switch
  - maintain backward compatibility in migration stream
---
 target/arm/arm-powerctl.c | 202 +++++++++++++++++++++++++++++++---------------
 target/arm/arm-powerctl.h |   2 +
 target/arm/cpu.c          |   4 +-
 target/arm/cpu.h          |  15 +++-
 target/arm/kvm.c          |   7 +-
 target/arm/machine.c      |  41 +++++++++-
 target/arm/psci.c         |   4 +-
 7 files changed, 201 insertions(+), 74 deletions(-)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index fbb7a15daa..25207cb850 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -14,6 +14,7 @@
 #include "internals.h"
 #include "arm-powerctl.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "exec/exec-all.h"
 
 #ifndef DEBUG_ARM_POWERCTL
@@ -48,11 +49,93 @@ CPUState *arm_get_cpu_by_id(uint64_t id)
     return NULL;
 }
 
+struct CpuOnInfo {
+    uint64_t entry;
+    uint64_t context_id;
+    uint32_t target_el;
+    bool target_aa64;
+};
+
+
+static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
+                                      run_on_cpu_data data)
+{
+    ARMCPU *target_cpu = ARM_CPU(target_cpu_state);
+    struct CpuOnInfo *info = (struct CpuOnInfo *) data.host_ptr;
+
+    /* Initialize the cpu we are turning on */
+    cpu_reset(target_cpu_state);
+    target_cpu_state->halted = 0;
+
+    if (info->target_aa64) {
+        if ((info->target_el < 3) && arm_feature(&target_cpu->env,
+                                                 ARM_FEATURE_EL3)) {
+            /*
+             * As target mode is AArch64, we need to set lower
+             * exception level (the requested level 2) to AArch64
+             */
+            target_cpu->env.cp15.scr_el3 |= SCR_RW;
+        }
+
+        if ((info->target_el < 2) && arm_feature(&target_cpu->env,
+                                                 ARM_FEATURE_EL2)) {
+            /*
+             * As target mode is AArch64, we need to set lower
+             * exception level (the requested level 1) to AArch64
+             */
+            target_cpu->env.cp15.hcr_el2 |= HCR_RW;
+        }
+
+        target_cpu->env.pstate = aarch64_pstate_mode(info->target_el, true);
+    } else {
+        /* We are requested to boot in AArch32 mode */
+        static const uint32_t mode_for_el[] = { 0,
+                                                ARM_CPU_MODE_SVC,
+                                                ARM_CPU_MODE_HYP,
+                                                ARM_CPU_MODE_SVC };
+
+        cpsr_write(&target_cpu->env, mode_for_el[info->target_el], CPSR_M,
+                   CPSRWriteRaw);
+    }
+
+    if (info->target_el == 3) {
+        /* Processor is in secure mode */
+        target_cpu->env.cp15.scr_el3 &= ~SCR_NS;
+    } else {
+        /* Processor is not in secure mode */
+        target_cpu->env.cp15.scr_el3 |= SCR_NS;
+    }
+
+    /* We check if the started CPU is now at the correct level */
+    assert(info->target_el == arm_current_el(&target_cpu->env));
+
+    if (info->target_aa64) {
+        target_cpu->env.xregs[0] = info->context_id;
+        target_cpu->env.thumb = false;
+    } else {
+        target_cpu->env.regs[0] = info->context_id;
+        target_cpu->env.thumb = info->entry & 1;
+        info->entry &= 0xfffffffe;
+    }
+
+    /* Start the new CPU at the requested address */
+    cpu_set_pc(target_cpu_state, info->entry);
+
+    g_free(info);
+
+    /* Finally set the power status */
+    assert(qemu_mutex_iothread_locked());
+    target_cpu->power_state = PSCI_ON;
+}
+
 int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
                    uint32_t target_el, bool target_aa64)
 {
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
+    struct CpuOnInfo *info;
+
+    assert(qemu_mutex_iothread_locked());
 
     DPRINTF("cpu %" PRId64 " (EL %d, %s) @ 0x%" PRIx64 " with R0 = 0x%" PRIx64
             "\n", cpuid, target_el, target_aa64 ? "aarch64" : "aarch32", entry,
@@ -77,7 +160,7 @@ int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
     }
 
     target_cpu = ARM_CPU(target_cpu_state);
-    if (!target_cpu->powered_off) {
+    if (target_cpu->power_state == PSCI_ON) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "[ARM]%s: CPU %" PRId64 " is already on\n",
                       __func__, cpuid);
@@ -109,74 +192,54 @@ int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
         return QEMU_ARM_POWERCTL_INVALID_PARAM;
     }
 
-    /* Initialize the cpu we are turning on */
-    cpu_reset(target_cpu_state);
-    target_cpu->powered_off = false;
-    target_cpu_state->halted = 0;
-
-    if (target_aa64) {
-        if ((target_el < 3) && arm_feature(&target_cpu->env, ARM_FEATURE_EL3)) {
-            /*
-             * As target mode is AArch64, we need to set lower
-             * exception level (the requested level 2) to AArch64
-             */
-            target_cpu->env.cp15.scr_el3 |= SCR_RW;
-        }
-
-        if ((target_el < 2) && arm_feature(&target_cpu->env, ARM_FEATURE_EL2)) {
-            /*
-             * As target mode is AArch64, we need to set lower
-             * exception level (the requested level 1) to AArch64
-             */
-            target_cpu->env.cp15.hcr_el2 |= HCR_RW;
-        }
-
-        target_cpu->env.pstate = aarch64_pstate_mode(target_el, true);
-    } else {
-        /* We are requested to boot in AArch32 mode */
-        static uint32_t mode_for_el[] = { 0,
-                                          ARM_CPU_MODE_SVC,
-                                          ARM_CPU_MODE_HYP,
-                                          ARM_CPU_MODE_SVC };
-
-        cpsr_write(&target_cpu->env, mode_for_el[target_el], CPSR_M,
-                   CPSRWriteRaw);
-    }
-
-    if (target_el == 3) {
-        /* Processor is in secure mode */
-        target_cpu->env.cp15.scr_el3 &= ~SCR_NS;
-    } else {
-        /* Processor is not in secure mode */
-        target_cpu->env.cp15.scr_el3 |= SCR_NS;
-    }
-
-    /* We check if the started CPU is now at the correct level */
-    assert(target_el == arm_current_el(&target_cpu->env));
-
-    if (target_aa64) {
-        target_cpu->env.xregs[0] = context_id;
-        target_cpu->env.thumb = false;
-    } else {
-        target_cpu->env.regs[0] = context_id;
-        target_cpu->env.thumb = entry & 1;
-        entry &= 0xfffffffe;
+    /*
+     * If another CPU has powered the target on we are in the state
+     * ON_PENDING and additional attempts to power on the CPU should
+     * fail (see 6.6 Implementation CPU_ON/CPU_OFF races in the PSCI
+     * spec)
+     */
+    if (target_cpu->power_state == PSCI_ON_PENDING) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "[ARM]%s: CPU %" PRId64 " is already powering on\n",
+                      __func__, cpuid);
+        return QEMU_ARM_POWERCTL_ON_PENDING;
     }
 
-    /* Start the new CPU at the requested address */
-    cpu_set_pc(target_cpu_state, entry);
+    /* To avoid racing with a CPU we are just kicking off we do the
+     * final bit of preparation for the work in the target CPUs
+     * context.
+     */
+    info = g_new(struct CpuOnInfo, 1);
+    info->entry = entry;
+    info->context_id = context_id;
+    info->target_el = target_el;
+    info->target_aa64 = target_aa64;
 
-    qemu_cpu_kick(target_cpu_state);
+    async_run_on_cpu(target_cpu_state, arm_set_cpu_on_async_work,
+                     RUN_ON_CPU_HOST_PTR(info));
 
     /* We are good to go */
     return QEMU_ARM_POWERCTL_RET_SUCCESS;
 }
 
+static void arm_set_cpu_off_async_work(CPUState *target_cpu_state,
+                                       run_on_cpu_data data)
+{
+    ARMCPU *target_cpu = ARM_CPU(target_cpu_state);
+
+    assert(qemu_mutex_iothread_locked());
+    target_cpu->power_state = PSCI_OFF;
+    target_cpu_state->halted = 1;
+    target_cpu_state->exception_index = EXCP_HLT;
+}
+
 int arm_set_cpu_off(uint64_t cpuid)
 {
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
 
+    assert(qemu_mutex_iothread_locked());
+
     DPRINTF("cpu %" PRId64 "\n", cpuid);
 
     /* change to the cpu we are powering up */
@@ -185,27 +248,34 @@ int arm_set_cpu_off(uint64_t cpuid)
         return QEMU_ARM_POWERCTL_INVALID_PARAM;
     }
     target_cpu = ARM_CPU(target_cpu_state);
-    if (target_cpu->powered_off) {
+    if (target_cpu->power_state == PSCI_OFF) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "[ARM]%s: CPU %" PRId64 " is already off\n",
                       __func__, cpuid);
         return QEMU_ARM_POWERCTL_IS_OFF;
     }
 
-    target_cpu->powered_off = true;
-    target_cpu_state->halted = 1;
-    target_cpu_state->exception_index = EXCP_HLT;
-    cpu_loop_exit(target_cpu_state);
-    /* notreached */
+    /* Queue work to run under the target vCPUs context */
+    async_run_on_cpu(target_cpu_state, arm_set_cpu_off_async_work,
+                     RUN_ON_CPU_NULL);
 
     return QEMU_ARM_POWERCTL_RET_SUCCESS;
 }
 
+static void arm_reset_cpu_async_work(CPUState *target_cpu_state,
+                                     run_on_cpu_data data)
+{
+    /* Reset the cpu */
+    cpu_reset(target_cpu_state);
+}
+
 int arm_reset_cpu(uint64_t cpuid)
 {
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
 
+    assert(qemu_mutex_iothread_locked());
+
     DPRINTF("cpu %" PRId64 "\n", cpuid);
 
     /* change to the cpu we are resetting */
@@ -214,15 +284,17 @@ int arm_reset_cpu(uint64_t cpuid)
         return QEMU_ARM_POWERCTL_INVALID_PARAM;
     }
     target_cpu = ARM_CPU(target_cpu_state);
-    if (target_cpu->powered_off) {
+
+    if (target_cpu->power_state == PSCI_OFF) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "[ARM]%s: CPU %" PRId64 " is off\n",
                       __func__, cpuid);
         return QEMU_ARM_POWERCTL_IS_OFF;
     }
 
-    /* Reset the cpu */
-    cpu_reset(target_cpu_state);
+    /* Queue work to run under the target vCPUs context */
+    async_run_on_cpu(target_cpu_state, arm_reset_cpu_async_work,
+                     RUN_ON_CPU_NULL);
 
     return QEMU_ARM_POWERCTL_RET_SUCCESS;
 }
diff --git a/target/arm/arm-powerctl.h b/target/arm/arm-powerctl.h
index 98ee04989b..04353923c0 100644
--- a/target/arm/arm-powerctl.h
+++ b/target/arm/arm-powerctl.h
@@ -17,6 +17,7 @@
 #define QEMU_ARM_POWERCTL_INVALID_PARAM QEMU_PSCI_RET_INVALID_PARAMS
 #define QEMU_ARM_POWERCTL_ALREADY_ON QEMU_PSCI_RET_ALREADY_ON
 #define QEMU_ARM_POWERCTL_IS_OFF QEMU_PSCI_RET_DENIED
+#define QEMU_ARM_POWERCTL_ON_PENDING QEMU_PSCI_RET_ON_PENDING
 
 /*
  * arm_get_cpu_by_id:
@@ -43,6 +44,7 @@ CPUState *arm_get_cpu_by_id(uint64_t cpuid);
  * Returns: QEMU_ARM_POWERCTL_RET_SUCCESS on success.
  * QEMU_ARM_POWERCTL_INVALID_PARAM if bad parameters are provided.
  * QEMU_ARM_POWERCTL_ALREADY_ON if the CPU was already started.
+ * QEMU_ARM_POWERCTL_ON_PENDING if the CPU is still powering up
  */
 int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
                    uint32_t target_el, bool target_aa64);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4a069f6985..f7157dc0e5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -45,7 +45,7 @@ static bool arm_cpu_has_work(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
 
-    return !cpu->powered_off
+    return (cpu->power_state != PSCI_OFF)
         && cs->interrupt_request &
         (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
          | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ
@@ -132,7 +132,7 @@ static void arm_cpu_reset(CPUState *s)
     env->vfp.xregs[ARM_VFP_MVFR1] = cpu->mvfr1;
     env->vfp.xregs[ARM_VFP_MVFR2] = cpu->mvfr2;
 
-    cpu->powered_off = cpu->start_powered_off;
+    cpu->power_state = cpu->start_powered_off ? PSCI_OFF : PSCI_ON;
     s->halted = cpu->start_powered_off;
 
     if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0956a54e89..e285ba3b4b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -526,6 +526,15 @@ typedef struct CPUARMState {
  */
 typedef void ARMELChangeHook(ARMCPU *cpu, void *opaque);
 
+
+/* These values map onto the return values for
+ * QEMU_PSCI_0_2_FN_AFFINITY_INFO */
+typedef enum ARMPSCIState {
+    PSCI_OFF = 0,
+    PSCI_ON = 1,
+    PSCI_ON_PENDING = 2
+} ARMPSCIState;
+
 /**
  * ARMCPU:
  * @env: #CPUARMState
@@ -582,8 +591,10 @@ struct ARMCPU {
 
     /* Should CPU start in PSCI powered-off state? */
     bool start_powered_off;
-    /* CPU currently in PSCI powered-off state */
-    bool powered_off;
+
+    /* Current power state, access guarded by BQL */
+    ARMPSCIState power_state;
+
     /* CPU has virtualization extension */
     bool has_el2;
     /* CPU has security extension */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index c00b94e42a..395e986973 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -488,8 +488,8 @@ int kvm_arm_sync_mpstate_to_kvm(ARMCPU *cpu)
 {
     if (cap_has_mp_state) {
         struct kvm_mp_state mp_state = {
-            .mp_state =
-            cpu->powered_off ? KVM_MP_STATE_STOPPED : KVM_MP_STATE_RUNNABLE
+            .mp_state = (cpu->power_state == PSCI_OFF) ?
+            KVM_MP_STATE_STOPPED : KVM_MP_STATE_RUNNABLE
         };
         int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
         if (ret) {
@@ -515,7 +515,8 @@ int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
                     __func__, ret, strerror(-ret));
             abort();
         }
-        cpu->powered_off = (mp_state.mp_state == KVM_MP_STATE_STOPPED);
+        cpu->power_state = (mp_state.mp_state == KVM_MP_STATE_STOPPED) ?
+            PSCI_OFF : PSCI_ON;
     }
 
     return 0;
diff --git a/target/arm/machine.c b/target/arm/machine.c
index fa5ec76090..d8094a840b 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -211,6 +211,38 @@ static const VMStateInfo vmstate_cpsr = {
     .put = put_cpsr,
 };
 
+static int get_power(QEMUFile *f, void *opaque, size_t size,
+                    VMStateField *field)
+{
+    ARMCPU *cpu = opaque;
+    bool powered_off = qemu_get_byte(f);
+    cpu->power_state = powered_off ? PSCI_OFF : PSCI_ON;
+    return 0;
+}
+
+static int put_power(QEMUFile *f, void *opaque, size_t size,
+                    VMStateField *field, QJSON *vmdesc)
+{
+    ARMCPU *cpu = opaque;
+
+    /* Migration should never happen while we transition power states */
+
+    if (cpu->power_state == PSCI_ON ||
+        cpu->power_state == PSCI_OFF) {
+        bool powered_off = (cpu->power_state == PSCI_OFF) ? true : false;
+        qemu_put_byte(f, powered_off);
+        return 0;
+    } else {
+        return 1;
+    }
+}
+
+static const VMStateInfo vmstate_powered_off = {
+    .name = "powered_off",
+    .get = get_power,
+    .put = put_power,
+};
+
 static void cpu_pre_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -329,7 +361,14 @@ const VMStateDescription vmstate_arm_cpu = {
         VMSTATE_UINT64(env.exception.vaddress, ARMCPU),
         VMSTATE_TIMER_PTR(gt_timer[GTIMER_PHYS], ARMCPU),
         VMSTATE_TIMER_PTR(gt_timer[GTIMER_VIRT], ARMCPU),
-        VMSTATE_BOOL(powered_off, ARMCPU),
+        {
+            .name = "power_state",
+            .version_id = 0,
+            .size = sizeof(bool),
+            .info = &vmstate_powered_off,
+            .flags = VMS_SINGLE,
+            .offset = 0,
+        },
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription*[]) {
diff --git a/target/arm/psci.c b/target/arm/psci.c
index 64bf82eea1..ade9fe2ede 100644
--- a/target/arm/psci.c
+++ b/target/arm/psci.c
@@ -127,7 +127,9 @@ void arm_handle_psci_call(ARMCPU *cpu)
                 break;
             }
             target_cpu = ARM_CPU(target_cpu_state);
-            ret = target_cpu->powered_off ? 1 : 0;
+
+            g_assert(qemu_mutex_iothread_locked());
+            ret = target_cpu->power_state;
             break;
         default:
             /* Everything above affinity level 0 is always on. */
-- 
2.11.0
