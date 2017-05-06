Received: from eggs.gnu.org ([2001:4830:134:3::10]:50910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6xfh-00030b-2i
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6xff-0003vd-1N
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:14:45 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:40004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d6xfe-0003uH-Q5
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:14:42 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sat,  6 May 2017 13:14:21 +0200
Message-Id: <20170506111431.12548-5-aurelien@aurel32.net>
In-Reply-To: <20170506111431.12548-1-aurelien@aurel32.net>
References: <20170506111431.12548-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v2 04/14] target/sh4: move DELAY_SLOT_TRUE flag
 into a separate global
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

Instead of using one bit of the env flags to store the condition of the
next delay slot, use a separate global. It simplifies reading and
writing the flags variable and also removes some confusion between
ctx->envflags and env->flags.

Note that the global is first transfered to a temp in order to be
able to discard the global before the brcond.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/cpu.h       | 10 ++--------
 target/sh4/helper.c    |  2 +-
 target/sh4/translate.c | 22 +++++++++++++---------
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index da8d15f1b9..faab3012f9 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -92,13 +92,6 @@
 
 #define DELAY_SLOT             (1 << 0)
 #define DELAY_SLOT_CONDITIONAL (1 << 1)
-#define DELAY_SLOT_TRUE        (1 << 2)
-/* The dynamic value of the DELAY_SLOT_TRUE flag determines whether the jump
- * after the delay slot should be taken or not. It is calculated from SR_T.
- *
- * It is unclear if it is permitted to modify the SR_T flag in a delay slot.
- * The use of DELAY_SLOT_TRUE flag makes us accept such SR_T modification.
- */
 
 typedef struct tlb_t {
     uint32_t vpn;		/* virtual page number */
@@ -148,7 +141,8 @@ typedef struct CPUSH4State {
     uint32_t sgr;		/* saved global register 15 */
     uint32_t dbr;		/* debug base register */
     uint32_t pc;		/* program counter */
-    uint32_t delayed_pc;	/* target of delayed jump */
+    uint32_t delayed_pc;        /* target of delayed branch */
+    uint32_t delayed_cond;      /* condition of delayed branch */
     uint32_t mach;		/* multiply and accumulate high */
     uint32_t macl;		/* multiply and accumulate low */
     uint32_t pr;		/* procedure register */
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 71bb49a670..8f8ce81401 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -168,7 +168,7 @@ void superh_cpu_do_interrupt(CPUState *cs)
         /* Branch instruction should be executed again before delay slot. */
 	env->spc -= 2;
 	/* Clear flags for exception/interrupt routine. */
-	env->flags &= ~(DELAY_SLOT | DELAY_SLOT_CONDITIONAL | DELAY_SLOT_TRUE);
+        env->flags &= ~(DELAY_SLOT | DELAY_SLOT_CONDITIONAL);
     }
 
     if (do_exp) {
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index d84a7a2e6e..2e29936ad8 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -72,7 +72,7 @@ static TCGv cpu_pr, cpu_fpscr, cpu_fpul, cpu_ldst;
 static TCGv cpu_fregs[32];
 
 /* internal register indexes */
-static TCGv cpu_flags, cpu_delayed_pc;
+static TCGv cpu_flags, cpu_delayed_pc, cpu_delayed_cond;
 
 #include "exec/gen-icount.h"
 
@@ -147,6 +147,10 @@ void sh4_translate_init(void)
     cpu_delayed_pc = tcg_global_mem_new_i32(cpu_env,
 					    offsetof(CPUSH4State, delayed_pc),
 					    "_delayed_pc_");
+    cpu_delayed_cond = tcg_global_mem_new_i32(cpu_env,
+                                              offsetof(CPUSH4State,
+                                                       delayed_cond),
+                                              "_delayed_cond_");
     cpu_ldst = tcg_global_mem_new_i32(cpu_env,
 				      offsetof(CPUSH4State, ldst), "_ldst_");
 
@@ -252,11 +256,12 @@ static void gen_jump(DisasContext * ctx)
 
 static inline void gen_branch_slot(uint32_t delayed_pc, int t)
 {
-    TCGLabel *label = gen_new_label();
     tcg_gen_movi_i32(cpu_delayed_pc, delayed_pc);
-    tcg_gen_brcondi_i32(t ? TCG_COND_EQ : TCG_COND_NE, cpu_sr_t, 0, label);
-    tcg_gen_ori_i32(cpu_flags, cpu_flags, DELAY_SLOT_TRUE);
-    gen_set_label(label);
+    if (t) {
+        tcg_gen_mov_i32(cpu_delayed_cond, cpu_sr_t);
+    } else {
+        tcg_gen_xori_i32(cpu_delayed_cond, cpu_sr_t, 1);
+    }
 }
 
 /* Immediate conditional jump (bt or bf) */
@@ -278,18 +283,17 @@ static void gen_delayed_conditional_jump(DisasContext * ctx)
 
     l1 = gen_new_label();
     ds = tcg_temp_new();
-    tcg_gen_andi_i32(ds, cpu_flags, DELAY_SLOT_TRUE);
+    tcg_gen_mov_i32(ds, cpu_delayed_cond);
+    tcg_gen_discard_i32(cpu_delayed_cond);
     tcg_gen_brcondi_i32(TCG_COND_NE, ds, 0, l1);
     gen_goto_tb(ctx, 1, ctx->pc + 2);
     gen_set_label(l1);
-    tcg_gen_andi_i32(cpu_flags, cpu_flags, ~DELAY_SLOT_TRUE);
     gen_jump(ctx);
 }
 
 static inline void gen_store_flags(uint32_t flags)
 {
-    tcg_gen_andi_i32(cpu_flags, cpu_flags, DELAY_SLOT_TRUE);
-    tcg_gen_ori_i32(cpu_flags, cpu_flags, flags);
+    tcg_gen_movi_i32(cpu_flags, flags);
 }
 
 static inline void gen_load_fpr64(TCGv_i64 t, int reg)
-- 
2.11.0
