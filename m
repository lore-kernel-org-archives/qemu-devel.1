Received: from eggs.gnu.org ([2001:4830:134:3::10]:38949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1calL7-0001MC-7f
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 10:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1calL5-0002AJ-CC
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 10:36:25 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1calL5-00029d-37
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 10:36:23 -0500
Received: by mail-wr0-x231.google.com with SMTP id o16so23978403wra.1
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 07:36:22 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  6 Feb 2017 15:31:10 +0000
Message-Id: <20170206153113.27729-21-alex.bennee@linaro.org>
In-Reply-To: <20170206153113.27729-1-alex.bennee@linaro.org>
References: <20170206153113.27729-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v10 20/23] target-arm/powerctl: defer cpu reset
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
---
 target/arm/arm-powerctl.c | 192 ++++++++++++++++++++++++++++++----------------
 target/arm/arm-powerctl.h |   2 +
 target/arm/cpu.h          |  10 ++-
 3 files changed, 139 insertions(+), 65 deletions(-)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index fbb7a15daa..bf14740852 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -48,11 +48,93 @@ CPUState *arm_get_cpu_by_id(uint64_t id)
     return NULL;
 }
 
+struct cpu_on_info {
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
+    struct cpu_on_info *info = (struct cpu_on_info *) data.host_ptr;
+    bool old_powering_on;
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
+    atomic_mb_set(&target_cpu->powered_off, false);
+    old_powering_on = atomic_cmpxchg(&target_cpu->powering_on, true, false);
+    assert(old_powering_on);
+}
+
 int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
                    uint32_t target_el, bool target_aa64)
 {
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
+    struct cpu_on_info *info;
 
     DPRINTF("cpu %" PRId64 " (EL %d, %s) @ 0x%" PRIx64 " with R0 = 0x%" PRIx64
             "\n", cpuid, target_el, target_aa64 ? "aarch64" : "aarch32", entry,
@@ -77,7 +159,7 @@ int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
     }
 
     target_cpu = ARM_CPU(target_cpu_state);
-    if (!target_cpu->powered_off) {
+    if (!atomic_mb_read(&target_cpu->powered_off)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "[ARM]%s: CPU %" PRId64 " is already on\n",
                       __func__, cpuid);
@@ -109,69 +191,45 @@ int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
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
+    if (atomic_cmpxchg(&target_cpu->powering_on, false, true)) {
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
+    info = g_new(struct cpu_on_info, 1);
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
+    atomic_mb_set(&target_cpu->powered_off, true);
+    target_cpu_state->halted = 1;
+    target_cpu_state->exception_index = EXCP_HLT;
+}
+
 int arm_set_cpu_off(uint64_t cpuid)
 {
     CPUState *target_cpu_state;
@@ -185,22 +243,27 @@ int arm_set_cpu_off(uint64_t cpuid)
         return QEMU_ARM_POWERCTL_INVALID_PARAM;
     }
     target_cpu = ARM_CPU(target_cpu_state);
-    if (target_cpu->powered_off) {
+    if (atomic_mb_read(&target_cpu->powered_off)) {
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
@@ -221,8 +284,9 @@ int arm_reset_cpu(uint64_t cpuid)
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
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 39bff86daf..b8f82d5d20 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -582,8 +582,16 @@ struct ARMCPU {
 
     /* Should CPU start in PSCI powered-off state? */
     bool start_powered_off;
-    /* CPU currently in PSCI powered-off state */
+    /* CPU PSCI state.
+     *
+     * For TCG these can be cross-vCPU accesses and should be done
+     * atomically to avoid races.
+     *
+     *  - powered_off indicates the vCPU state
+     *  - powering_on true if the vCPU has had a CPU_ON but not yet up
+     */
     bool powered_off;
+    bool powering_on;  /* PSCI ON_PENDING */
     /* CPU has virtualization extension */
     bool has_el2;
     /* CPU has security extension */
-- 
2.11.0
