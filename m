Received: from eggs.gnu.org ([209.51.188.92]:35021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu8If-0003DU-F4
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu8Ic-0005cC-M0
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:07:01 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gu8Ic-0005b8-8x
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:06:58 -0500
Received: by mail-pl1-x642.google.com with SMTP id p4so2394178plq.11
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 20:06:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 13 Feb 2019 20:06:50 -0800
Message-Id: <20190214040652.4811-3-richard.henderson@linaro.org>
In-Reply-To: <20190214040652.4811-1-richard.henderson@linaro.org>
References: <20190214040652.4811-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/4] target/arm: Rebuild hflags at el changes
 and MSR writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, cota@braap.org

Now setting, but not relying upon, env->hflags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h     |  1 +
 linux-user/syscall.c       |  1 +
 target/arm/cpu.c           |  1 +
 target/arm/helper-a64.c    |  3 +++
 target/arm/helper.c        |  2 ++
 target/arm/machine.c       |  1 +
 target/arm/op_helper.c     |  1 +
 target/arm/translate-a64.c |  6 +++++-
 target/arm/translate.c     | 14 ++++++++++++--
 9 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 8c1b813364..235f4fafec 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -970,5 +970,6 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
 
 uint32_t rebuild_hflags_a32(CPUARMState *env, int el);
 uint32_t rebuild_hflags_a64(CPUARMState *env, int el);
+void rebuild_hflags_any(CPUARMState *env);
 
 #endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5bbb72f3d5..123f342bdc 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9691,6 +9691,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     aarch64_sve_narrow_vq(env, vq);
                 }
                 env->vfp.zcr_el[1] = vq - 1;
+                arm_rebuild_hflags(env);
                 ret = vq * 16;
             }
             return ret;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index edf6e0e1f1..e4da513eb3 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -390,6 +390,7 @@ static void arm_cpu_reset(CPUState *s)
 
     hw_breakpoint_update_all(cpu);
     hw_watchpoint_update_all(cpu);
+    arm_rebuild_hflags(env);
 }
 
 bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 101fa6d3ea..f51cb75444 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -995,6 +995,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         } else {
             env->regs[15] = new_pc & ~0x3;
         }
+        rebuild_hflags_a32(env, new_el);
         qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
                       "AArch32 EL%d PC 0x%" PRIx32 "\n",
                       cur_el, new_el, env->regs[15]);
@@ -1006,10 +1007,12 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         }
         aarch64_restore_sp(env, new_el);
         env->pc = new_pc;
+        rebuild_hflags_a64(env, new_el);
         qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
                       "AArch64 EL%d PC 0x%" PRIx64 "\n",
                       cur_el, new_el, env->pc);
     }
+
     /*
      * Note that cur_el can never be 0.  If new_el is 0, then
      * el0_a64 is return_to_aa64, else el0_a64 is ignored.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7a77f53ba8..d8249f0eae 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9081,6 +9081,7 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
         env->regs[14] = env->regs[15] + offset;
     }
     env->regs[15] = newpc;
+    env->hflags = rebuild_hflags_a32(env, arm_current_el(env));
 }
 
 static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
@@ -9426,6 +9427,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
 
     pstate_write(env, PSTATE_DAIF | new_mode);
     env->aarch64 = 1;
+    env->hflags = rebuild_hflags_a64(env, new_el);
     aarch64_restore_sp(env, new_el);
 
     env->pc = addr;
diff --git a/target/arm/machine.c b/target/arm/machine.c
index b292549614..61889801dd 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -743,6 +743,7 @@ static int cpu_post_load(void *opaque, int version_id)
     if (!kvm_enabled()) {
         pmu_op_finish(&cpu->env);
     }
+    arm_rebuild_hflags(&cpu->env);
 
     return 0;
 }
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index c998eadfaa..8d459d9a84 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -571,6 +571,7 @@ void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
      */
     env->regs[15] &= (env->thumb ? ~1 : ~3);
 
+    rebuild_hflags_a32(env, arm_current_el(env));
     qemu_mutex_lock_iothread();
     arm_call_el_change_hook(arm_env_get_cpu(env));
     qemu_mutex_unlock_iothread();
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e002251ac6..ad665c1609 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1841,11 +1841,15 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         /* I/O operations must end the TB here (whether read or write) */
         gen_io_end();
         s->base.is_jmp = DISAS_UPDATE;
-    } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
+    }
+    if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
         /* We default to ending the TB on a coprocessor register write,
          * but allow this to be suppressed by the register definition
          * (usually only necessary to work around guest bugs).
          */
+        TCGv_i32 tcg_el = tcg_const_i32(s->current_el);
+        gen_helper_rebuild_hflags_a64(cpu_env, tcg_el);
+        tcg_temp_free_i32(tcg_el);
         s->base.is_jmp = DISAS_UPDATE;
     }
 }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 66cf28c8cb..36842a27b3 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8432,6 +8432,8 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
     ri = get_arm_cp_reginfo(s->cp_regs,
             ENCODE_CP_REG(cpnum, is64, s->ns, crn, crm, opc1, opc2));
     if (ri) {
+        bool need_exit_tb;
+
         /* Check access permissions */
         if (!cp_access_ok(s->current_el, ri, isread)) {
             return 1;
@@ -8604,15 +8606,23 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             }
         }
 
+        need_exit_tb = false;
         if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
             /* I/O operations must end the TB here (whether read or write) */
             gen_io_end();
-            gen_lookup_tb(s);
-        } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
+            need_exit_tb = true;
+        }
+        if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
             /* We default to ending the TB on a coprocessor register write,
              * but allow this to be suppressed by the register definition
              * (usually only necessary to work around guest bugs).
              */
+            TCGv_i32 tcg_el = tcg_const_i32(s->current_el);
+            gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
+            tcg_temp_free_i32(tcg_el);
+            need_exit_tb = true;
+        }
+        if (need_exit_tb) {
             gen_lookup_tb(s);
         }
 
-- 
2.17.1
