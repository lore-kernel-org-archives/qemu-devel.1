Received: from eggs.gnu.org ([2001:4830:134:3::10]:38917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUG9V-0007hR-8O
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUG9T-0007uf-Au
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:33 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cUG9T-0007uF-2O
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:31 -0500
Received: by mail-wm0-x235.google.com with SMTP id c206so2828763wme.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:05:30 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Jan 2017 17:04:59 +0000
Message-Id: <20170119170507.16185-20-alex.bennee@linaro.org>
In-Reply-To: <20170119170507.16185-1-alex.bennee@linaro.org>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 19/27] target-arm/powerctl: defer cpu reset
 work to CPU context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

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
---
 target/arm/arm-powerctl.c | 146 ++++++++++++++++++++++++++++------------------
 1 file changed, 88 insertions(+), 58 deletions(-)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index fbb7a15daa..082788e3a4 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -48,11 +48,87 @@ CPUState *arm_get_cpu_by_id(uint64_t id)
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
+
+    /* Initialize the cpu we are turning on */
+    cpu_reset(target_cpu_state);
+    target_cpu->powered_off = false;
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
+    g_free(info);
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
@@ -109,64 +185,18 @@ int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
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
-    }
-
-    /* Start the new CPU at the requested address */
-    cpu_set_pc(target_cpu_state, entry);
-
-    qemu_cpu_kick(target_cpu_state);
+    /* To avoid racing with a CPU we are just kicking off we do the
+     * final bit of preparation for the work in the target CPUs
+     * context.
+     */
+    info = g_new(struct cpu_on_info, 1);
+    info->entry = entry;
+    info->context_id = context_id;
+    info->target_el = target_el;
+    info->target_aa64 = target_aa64;
+
+    async_run_on_cpu(target_cpu_state, arm_set_cpu_on_async_work,
+                     RUN_ON_CPU_HOST_PTR(info));
 
     /* We are good to go */
     return QEMU_ARM_POWERCTL_RET_SUCCESS;
-- 
2.11.0
