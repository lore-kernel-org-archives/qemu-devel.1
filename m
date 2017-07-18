Received: from eggs.gnu.org ([2001:4830:134:3::10]:49513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYic-000631-LN
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYiY-0004Ot-I6
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:42 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYiY-0004ON-CN
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:38 -0400
Received: by mail-qk0-x243.google.com with SMTP id q66so3779211qki.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:03:38 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:26 -1000
Message-Id: <20170718200255.31647-2-rth@twiddle.net>
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
References: <20170718200255.31647-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 01/30] target/sh4: Use cmpxchg for movco
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net

As for other targets, cmpxchg isn't quite right for ll/sc,
suffering from an ABA race, but is sufficient to implement
portable atomic operations.

Signed-off-by: Richard Henderson <rth@twiddle.net>

---
V2: Clear lock_addr in rte, do_interrupt, syscall entry, & signal delivery.
    Fix movli to tollerate overlap between R0 and REG(B11_8).
---
 target/sh4/cpu.h       |  3 ++-
 linux-user/main.c      |  1 +
 linux-user/signal.c    |  2 ++
 target/sh4/helper.c    |  2 +-
 target/sh4/translate.c | 72 +++++++++++++++++++++++++++++---------------------
 5 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index ffb9168..b15116e 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -169,7 +169,8 @@ typedef struct CPUSH4State {
     tlb_t itlb[ITLB_SIZE];	/* instruction translation table */
     tlb_t utlb[UTLB_SIZE];	/* unified translation table */
 
-    uint32_t ldst;
+    uint32_t lock_addr;
+    uint32_t lock_value;
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
diff --git a/linux-user/main.c b/linux-user/main.c
index ad03c9e..30f0ae1 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -2673,6 +2673,7 @@ void cpu_loop(CPUSH4State *env)
         switch (trapnr) {
         case 0x160:
             env->pc += 2;
+            env->lock_addr = -1;
             ret = do_syscall(env,
                              env->gregs[3],
                              env->gregs[4],
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 3d18d1b..ddfd75c 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -3566,6 +3566,7 @@ static void setup_frame(int sig, struct target_sigaction *ka,
     regs->gregs[5] = 0;
     regs->gregs[6] = frame_addr += offsetof(typeof(*frame), sc);
     regs->pc = (unsigned long) ka->_sa_handler;
+    regs->lock_addr = -1;
 
     unlock_user_struct(frame, frame_addr, 1);
     return;
@@ -3626,6 +3627,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     regs->gregs[5] = frame_addr + offsetof(typeof(*frame), info);
     regs->gregs[6] = frame_addr + offsetof(typeof(*frame), uc);
     regs->pc = (unsigned long) ka->_sa_handler;
+    regs->lock_addr = -1;
 
     unlock_user_struct(frame, frame_addr, 1);
     return;
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 28d93c2..df7c000 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -87,7 +87,6 @@ void superh_cpu_do_interrupt(CPUState *cs)
     int do_exp, irq_vector = cs->exception_index;
 
     /* prioritize exceptions over interrupts */
-
     do_exp = cs->exception_index != -1;
     do_irq = do_irq && (cs->exception_index == -1);
 
@@ -171,6 +170,7 @@ void superh_cpu_do_interrupt(CPUState *cs)
     env->spc = env->pc;
     env->sgr = env->gregs[15];
     env->sr |= (1u << SR_BL) | (1u << SR_MD) | (1u << SR_RB);
+    env->lock_addr = -1;
 
     if (env->flags & DELAY_SLOT_MASK) {
         /* Branch instruction should be executed again before delay slot. */
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 4c3512f..45f7661 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -68,7 +68,8 @@ static TCGv cpu_gregs[24];
 static TCGv cpu_sr, cpu_sr_m, cpu_sr_q, cpu_sr_t;
 static TCGv cpu_pc, cpu_ssr, cpu_spc, cpu_gbr;
 static TCGv cpu_vbr, cpu_sgr, cpu_dbr, cpu_mach, cpu_macl;
-static TCGv cpu_pr, cpu_fpscr, cpu_fpul, cpu_ldst;
+static TCGv cpu_pr, cpu_fpscr, cpu_fpul;
+static TCGv cpu_lock_addr, cpu_lock_value;
 static TCGv cpu_fregs[32];
 
 /* internal register indexes */
@@ -151,8 +152,12 @@ void sh4_translate_init(void)
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
@@ -430,6 +435,7 @@ static void _decode_opc(DisasContext * ctx)
 	CHECK_NOT_DELAY_SLOT
         gen_write_sr(cpu_ssr);
 	tcg_gen_mov_i32(cpu_delayed_pc, cpu_spc);
+        tcg_gen_movi_i32(cpu_lock_addr, -1);
         ctx->envflags |= DELAY_SLOT_RTE;
 	ctx->delayed_pc = (uint32_t) - 1;
         ctx->bstate = BS_STOP;
@@ -1527,35 +1533,41 @@ static void _decode_opc(DisasContext * ctx)
         tcg_gen_mov_i32(REG(B11_8), cpu_sr_t);
 	return;
     case 0x0073:
-        /* MOVCO.L
-	       LDST -> T
-               If (T == 1) R0 -> (Rn)
-               0 -> LDST
-        */
+        /* MOVCO.L: if (lock still held) R0 -> (Rn), T=1; else T=0.
+           Approximate "lock still held" with a comparison of address
+           from the MOVLI insn and a cmpxchg with the value read.  */
         if (ctx->features & SH_FEATURE_SH4A) {
-            TCGLabel *label = gen_new_label();
-            tcg_gen_mov_i32(cpu_sr_t, cpu_ldst);
-	    tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_ldst, 0, label);
-            tcg_gen_qemu_st_i32(REG(0), REG(B11_8), ctx->memidx, MO_TEUL);
-	    gen_set_label(label);
-	    tcg_gen_movi_i32(cpu_ldst, 0);
-	    return;
-	} else
-	    break;
+            TCGLabel *fail = gen_new_label();
+            TCGLabel *done = gen_new_label();
+
+            tcg_gen_brcond_i32(TCG_COND_NE, REG(B11_8), cpu_lock_addr, fail);
+
+            tcg_gen_atomic_cmpxchg_i32(cpu_sr_t, REG(B11_8), cpu_lock_value,
+                                       REG(0), ctx->memidx, MO_TEUL);
+            tcg_gen_setcond_i32(TCG_COND_EQ, cpu_sr_t,
+                                cpu_sr_t, cpu_lock_value);
+            tcg_gen_br(done);
+
+            gen_set_label(fail);
+            tcg_gen_movi_i32(cpu_sr_t, 0);
+
+            gen_set_label(done);
+            tcg_gen_movi_i32(cpu_lock_addr, -1);
+            return;
+        } else {
+            break;
+        }
     case 0x0063:
-        /* MOVLI.L @Rm,R0
-               1 -> LDST
-               (Rm) -> R0
-               When interrupt/exception
-               occurred 0 -> LDST
-        */
-	if (ctx->features & SH_FEATURE_SH4A) {
-	    tcg_gen_movi_i32(cpu_ldst, 0);
-            tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx, MO_TESL);
-	    tcg_gen_movi_i32(cpu_ldst, 1);
-	    return;
-	} else
-	    break;
+        /* MOVLI.L @Rm -> R0, and remember the address and value loaded.  */
+        if (ctx->features & SH_FEATURE_SH4A) {
+            tcg_gen_qemu_ld_i32(cpu_lock_value, REG(B11_8),
+                                ctx->memidx, MO_TESL);
+            tcg_gen_mov_i32(cpu_lock_addr, REG(B11_8));
+            tcg_gen_mov_i32(REG(0), cpu_lock_value);
+            return;
+        } else {
+            break;
+        }
     case 0x0093:		/* ocbi @Rn */
 	{
             gen_helper_ocbi(cpu_env, REG(B11_8));
-- 
2.9.4
