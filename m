Received: from eggs.gnu.org ([2001:4830:134:3::10]:44458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e73UC-0000YI-Ds
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e73UB-00057h-Bf
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:59:32 -0400
Date: Tue, 24 Oct 2017 10:59:24 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1710241055160.574@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PATCH v3] fix WFI/WFE length in syndrome register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, sstabellini@kernel.org

WFI/E are often, but not always, 4 bytes long. When they are, we need to
set ARM_EL_IL_SHIFT in the syndrome register.

Pass the instruction length to HELPER(wfi), use it to decrement pc
appropriately and to pass an is_16bit flag to syn_wfx, which sets
ARM_EL_IL_SHIFT if needed.

Set dc->insn in both arm_tr_translate_insn and thumb_tr_translate_insn.

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>

---

Changes in v3:
- free tmp
- wfi on aarch64 is always 4 bytes
- set dc->insn in arm_tr_translate_insn and thumb_tr_translate_insn
- also check for dc->thumb in arm_tr_tb_stop

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 2cf6f74..439d228 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -48,7 +48,7 @@ DEF_HELPER_FLAGS_3(sel_flags, TCG_CALL_NO_RWG_SE,
 DEF_HELPER_2(exception_internal, void, env, i32)
 DEF_HELPER_4(exception_with_syndrome, void, env, i32, i32, i32)
 DEF_HELPER_1(setend, void, env)
-DEF_HELPER_1(wfi, void, env)
+DEF_HELPER_2(wfi, void, env, i32)
 DEF_HELPER_1(wfe, void, env)
 DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 5a5af38..6792df2 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -428,9 +428,10 @@ static inline uint32_t syn_breakpoint(int same_el)
         | ARM_EL_IL | 0x22;
 }
 
-static inline uint32_t syn_wfx(int cv, int cond, int ti)
+static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
 {
     return (EC_WFX_TRAP << ARM_EL_EC_SHIFT) |
+           (is_16bit ? 0 : (1 << ARM_EL_IL_SHIFT)) |
            (cv << 24) | (cond << 20) | ti;
 }
 
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 045c312..30039c5 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -463,7 +463,7 @@ static inline int check_wfx_trap(CPUARMState *env, bool is_wfe)
     return 0;
 }
 
-void HELPER(wfi)(CPUARMState *env)
+void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
 {
     CPUState *cs = CPU(arm_env_get_cpu(env));
     int target_el = check_wfx_trap(env, false);
@@ -476,8 +476,9 @@ void HELPER(wfi)(CPUARMState *env)
     }
 
     if (target_el) {
-        env->pc -= 4;
-        raise_exception(env, EXCP_UDEF, syn_wfx(1, 0xe, 0), target_el);
+        env->pc -= insn_len;
+        raise_exception(env, EXCP_UDEF, syn_wfx(1, 0xe, 0, insn_len == 2),
+                        target_el);
     }
 
     cs->exception_index = EXCP_HLT;
diff --git a/target/arm/psci.c b/target/arm/psci.c
index fc34b26..eb7b88e 100644
--- a/target/arm/psci.c
+++ b/target/arm/psci.c
@@ -189,7 +189,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
         } else {
             env->regs[0] = 0;
         }
-        helper_wfi(env);
+        helper_wfi(env, 4);
         break;
     case QEMU_PSCI_0_1_FN_MIGRATE:
     case QEMU_PSCI_0_2_FN_MIGRATE:
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index a39b9d3..aba9436 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11380,17 +11380,21 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             gen_helper_yield(cpu_env);
             break;
         case DISAS_WFI:
+        {
+            TCGv_i32 tmp = tcg_const_i32(4);
             /* This is a special case because we don't want to just halt the CPU
              * if trying to debug across a WFI.
              */
             gen_a64_set_pc_im(dc->pc);
-            gen_helper_wfi(cpu_env);
+            gen_helper_wfi(cpu_env, tmp);
+            tcg_temp_free_i32(tmp);
             /* The helper doesn't necessarily throw an exception, but we
              * must go back to the main loop to check for interrupts anyway.
              */
             tcg_gen_exit_tb(0);
             break;
         }
+        }
     }
 
     /* Functions above can change dc->pc, so re-align db->pc_next */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4da1a4c..0a7b67c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12124,6 +12124,7 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     }
 
     insn = arm_ldl_code(env, dc->pc, dc->sctlr_b);
+    dc->insn = insn;
     dc->pc += 4;
     disas_arm_insn(dc, insn);
 
@@ -12191,6 +12192,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     }
 
     insn = arm_lduw_code(env, dc->pc, dc->sctlr_b);
+    dc->insn = insn;
     is_16bit = thumb_insn_is_16bit(dc, insn);
     dc->pc += 2;
     if (!is_16bit) {
@@ -12325,12 +12327,17 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             /* nothing more to generate */
             break;
         case DISAS_WFI:
-            gen_helper_wfi(cpu_env);
+        {
+            TCGv_i32 tmp = tcg_const_i32((dc->thumb &&
+                                          !(dc->insn & (1U << 31))) ? 2 : 4);
+            gen_helper_wfi(cpu_env, tmp);
+            tcg_temp_free_i32(tmp);
             /* The helper doesn't necessarily throw an exception, but we
              * must go back to the main loop to check for interrupts anyway.
              */
             tcg_gen_exit_tb(0);
             break;
+        }
         case DISAS_WFE:
             gen_helper_wfe(cpu_env);
             break;
