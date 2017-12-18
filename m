Received: from eggs.gnu.org ([2001:4830:134:3::10]:57336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eR45b-0007Ho-3n
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eR45Z-00048E-L8
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:51 -0500
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1eR45Z-0003vU-Bf
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:49 -0500
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 18 Dec 2017 23:40:27 +0100
Message-Id: <20171218224030.26726-4-aurelien@aurel32.net>
In-Reply-To: <20171218224030.26726-1-aurelien@aurel32.net>
References: <20171218224030.26726-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PULL 3/6] target/sh4: Use cmpxchg for movco when
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
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

From: Richard Henderson <rth@twiddle.net>

As for other targets, cmpxchg isn't quite right for ll/sc,
suffering from an ABA race, but is sufficient to implement
portable atomic operations.

Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170907185057.23421-2-richard.henderson@linaro.org>
[aurel32: fix whitespace]
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 linux-user/main.c      | 19 +++++++++---
 target/sh4/cpu.h       |  4 ++-
 target/sh4/helper.c    |  1 +
 target/sh4/translate.c | 82 ++++++++++++++++++++++++++++++++++++--------------
 4 files changed, 79 insertions(+), 27 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 2fd2a143ed..71696ed33d 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -2679,6 +2679,8 @@ void cpu_loop(CPUSH4State *env)
     target_siginfo_t info;
 
     while (1) {
+        bool arch_interrupt = true;
+
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
@@ -2710,13 +2712,14 @@ void cpu_loop(CPUSH4State *env)
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
@@ -2727,9 +2730,9 @@ void cpu_loop(CPUSH4State *env)
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
@@ -2737,6 +2740,14 @@ void cpu_loop(CPUSH4State *env)
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
index 960b46870d..a2c26e0597 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -188,7 +188,9 @@ typedef struct CPUSH4State {
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
index 4a4a5c877e..f7fe1a46d8 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -69,7 +69,8 @@ static TCGv cpu_gregs[32];
 static TCGv cpu_sr, cpu_sr_m, cpu_sr_q, cpu_sr_t;
 static TCGv cpu_pc, cpu_ssr, cpu_spc, cpu_gbr;
 static TCGv cpu_vbr, cpu_sgr, cpu_dbr, cpu_mach, cpu_macl;
-static TCGv cpu_pr, cpu_fpscr, cpu_fpul, cpu_ldst;
+static TCGv cpu_pr, cpu_fpscr, cpu_fpul;
+static TCGv cpu_lock_addr, cpu_lock_value;
 static TCGv cpu_fregs[32];
 
 /* internal register indexes */
@@ -147,8 +148,12 @@ void sh4_translate_init(void)
                                               offsetof(CPUSH4State,
                                                        delayed_cond),
                                               "_delayed_cond_");
-    cpu_ldst = tcg_global_mem_new_i32(cpu_env,
-				      offsetof(CPUSH4State, ldst), "_ldst_");
+    cpu_lock_addr = tcg_global_mem_new_i32(cpu_env,
+                                           offsetof(CPUSH4State, lock_addr),
+                                           "_lock_addr_");
+    cpu_lock_value = tcg_global_mem_new_i32(cpu_env,
+                                            offsetof(CPUSH4State, lock_value),
+                                            "_lock_value_");
 
     for (i = 0; i < 32; i++)
         cpu_fregs[i] = tcg_global_mem_new_i32(cpu_env,
@@ -1549,31 +1554,64 @@ static void _decode_opc(DisasContext * ctx)
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
+            if ((tb_cflags(ctx->tb) & CF_PARALLEL)) {
+                TCGv tmp;
+
+                tcg_gen_brcond_i32(TCG_COND_NE, REG(B11_8),
+                                   cpu_lock_addr, fail);
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
+        if ((tb_cflags(ctx->tb) & CF_PARALLEL)) {
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
2.15.1
