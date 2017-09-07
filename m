Received: from eggs.gnu.org ([2001:4830:134:3::10]:54124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1tK-00008v-Pw
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1tF-0000TY-LZ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:51:06 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:33554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq1tF-0000T1-D7
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:51:01 -0400
Received: by mail-pg0-x230.google.com with SMTP id t3so1010855pgt.0
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:51:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 11:50:53 -0700
Message-Id: <20170907185057.23421-2-richard.henderson@linaro.org>
In-Reply-To: <20170907185057.23421-1-richard.henderson@linaro.org>
References: <20170907185057.23421-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 1/5] target/sh4: Use cmpxchg for movco when
 parallel_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

As for other targets, cmpxchg isn't quite right for ll/sc,
suffering from an ABA race, but is sufficient to implement
portable atomic operations.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/main.c      | 19 +++++++++---
 target/sh4/cpu.h       |  4 ++-
 target/sh4/helper.c    |  1 +
 target/sh4/translate.c | 81 ++++++++++++++++++++++++++++++++++++--------------
 4 files changed, 78 insertions(+), 27 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 03666ef657..22b3bdafc5 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -2665,6 +2665,8 @@ void cpu_loop(CPUSH4State *env)
     target_siginfo_t info;
 
     while (1) {
+        bool arch_interrupt = true;
+
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
@@ -2696,13 +2698,14 @@ void cpu_loop(CPUSH4State *env)
                 int sig;
 
                 sig = gdb_handlesig(cs, TARGET_SIGTRAP);
-                if (sig)
-                  {
+                if (sig) {
                     info.si_signo = sig;
                     info.si_errno = 0;
                     info.si_code = TARGET_TRAP_BRKPT;
                     queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                  }
+                } else {
+                    arch_interrupt = false;
+                }
             }
             break;
 	case 0xa0:
@@ -2713,9 +2716,9 @@ void cpu_loop(CPUSH4State *env)
             info._sifields._sigfault._addr = env->tea;
             queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
 	    break;
-
         case EXCP_ATOMIC:
             cpu_exec_step_atomic(cs);
+            arch_interrupt = false;
             break;
         default:
             printf ("Unhandled trap: 0x%x\n", trapnr);
@@ -2723,6 +2726,14 @@ void cpu_loop(CPUSH4State *env)
             exit(EXIT_FAILURE);
         }
         process_pending_signals (env);
+
+        /* Most of the traps imply an exception or interrupt, which
+           implies an REI instruction has been executed.  Which means
+           that LDST (aka LOK_ADDR) should be cleared.  But there are
+           a few exceptions for traps internal to QEMU.  */
+        if (arch_interrupt) {
+            env->lock_addr = -1;
+        }
     }
 }
 #endif
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 79f85d3365..603614a2d8 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -184,7 +184,9 @@ typedef struct CPUSH4State {
     tlb_t itlb[ITLB_SIZE];	/* instruction translation table */
     tlb_t utlb[UTLB_SIZE];	/* unified translation table */
 
-    uint32_t ldst;
+    /* LDST = LOCK_ADDR != -1.  */
+    uint32_t lock_addr;
+    uint32_t lock_value;
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 28d93c2543..680b583e53 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -171,6 +171,7 @@ void superh_cpu_do_interrupt(CPUState *cs)
     env->spc = env->pc;
     env->sgr = env->gregs[15];
     env->sr |= (1u << SR_BL) | (1u << SR_MD) | (1u << SR_RB);
+    env->lock_addr = -1;
 
     if (env->flags & DELAY_SLOT_MASK) {
         /* Branch instruction should be executed again before delay slot. */
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 10191073b2..4365b21624 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -70,7 +70,8 @@ static TCGv cpu_gregs[32];
 static TCGv cpu_sr, cpu_sr_m, cpu_sr_q, cpu_sr_t;
 static TCGv cpu_pc, cpu_ssr, cpu_spc, cpu_gbr;
 static TCGv cpu_vbr, cpu_sgr, cpu_dbr, cpu_mach, cpu_macl;
-static TCGv cpu_pr, cpu_fpscr, cpu_fpul, cpu_ldst;
+static TCGv cpu_pr, cpu_fpscr, cpu_fpul;
+static TCGv cpu_lock_addr, cpu_lock_value;
 static TCGv cpu_fregs[32];
 
 /* internal register indexes */
@@ -156,8 +157,12 @@ void sh4_translate_init(void)
                                               offsetof(CPUSH4State,
                                                        delayed_cond),
                                               "_delayed_cond_");
-    cpu_ldst = tcg_global_mem_new_i32(cpu_env,
-				      offsetof(CPUSH4State, ldst), "_ldst_");
+    cpu_lock_addr = tcg_global_mem_new_i32(cpu_env,
+				           offsetof(CPUSH4State, lock_addr),
+                                           "_lock_addr_");
+    cpu_lock_value = tcg_global_mem_new_i32(cpu_env,
+				            offsetof(CPUSH4State, lock_value),
+                                            "_lock_value_");
 
     for (i = 0; i < 32; i++)
         cpu_fregs[i] = tcg_global_mem_new_i32(cpu_env,
@@ -1558,31 +1563,63 @@ static void _decode_opc(DisasContext * ctx)
 	return;
     case 0x0073:
         /* MOVCO.L
-	       LDST -> T
-               If (T == 1) R0 -> (Rn)
-               0 -> LDST
-        */
+         *     LDST -> T
+         *     If (T == 1) R0 -> (Rn)
+         *     0 -> LDST
+         *
+         * The above description doesn't work in a parallel context.
+         * Since we currently support no smp boards, this implies user-mode.
+         * But we can still support the official mechanism while user-mode
+         * is single-threaded.  */
         CHECK_SH4A
         {
-            TCGLabel *label = gen_new_label();
-            tcg_gen_mov_i32(cpu_sr_t, cpu_ldst);
-	    tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_ldst, 0, label);
-            tcg_gen_qemu_st_i32(REG(0), REG(B11_8), ctx->memidx, MO_TEUL);
-	    gen_set_label(label);
-	    tcg_gen_movi_i32(cpu_ldst, 0);
-	    return;
+            TCGLabel *fail = gen_new_label();
+            TCGLabel *done = gen_new_label();
+
+            if (parallel_cpus) {
+                TCGv tmp;
+
+                tcg_gen_brcond_i32(TCG_COND_NE, REG(B11_8), cpu_lock_addr, fail);
+                tmp = tcg_temp_new();
+                tcg_gen_atomic_cmpxchg_i32(tmp, REG(B11_8), cpu_lock_value,
+                                           REG(0), ctx->memidx, MO_TEUL);
+                tcg_gen_setcond_i32(TCG_COND_EQ, cpu_sr_t, tmp, cpu_lock_value);
+                tcg_temp_free(tmp);
+            } else {
+                tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_lock_addr, -1, fail);
+                tcg_gen_qemu_st_i32(REG(0), REG(B11_8), ctx->memidx, MO_TEUL);
+                tcg_gen_movi_i32(cpu_sr_t, 1);
+            }
+            tcg_gen_br(done);
+
+            gen_set_label(fail);
+            tcg_gen_movi_i32(cpu_sr_t, 0);
+
+            gen_set_label(done);
+            tcg_gen_movi_i32(cpu_lock_addr, -1);
         }
+        return;
     case 0x0063:
         /* MOVLI.L @Rm,R0
-               1 -> LDST
-               (Rm) -> R0
-               When interrupt/exception
-               occurred 0 -> LDST
-        */
+         *     1 -> LDST
+         *     (Rm) -> R0
+         *     When interrupt/exception
+         *     occurred 0 -> LDST
+         *
+         * In a parallel context, we must also save the loaded value
+         * for use with the cmpxchg that we'll use with movco.l.  */
         CHECK_SH4A
-        tcg_gen_movi_i32(cpu_ldst, 0);
-        tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx, MO_TESL);
-        tcg_gen_movi_i32(cpu_ldst, 1);
+        if (parallel_cpus) {
+            TCGv tmp = tcg_temp_new();
+            tcg_gen_mov_i32(tmp, REG(B11_8));
+            tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx, MO_TESL);
+            tcg_gen_mov_i32(cpu_lock_value, REG(0));
+            tcg_gen_mov_i32(cpu_lock_addr, tmp);
+            tcg_temp_free(tmp);
+        } else {
+            tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx, MO_TESL);
+            tcg_gen_movi_i32(cpu_lock_addr, 0);
+        }
         return;
     case 0x0093:		/* ocbi @Rn */
 	{
-- 
2.13.5
