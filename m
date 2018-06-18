Received: from eggs.gnu.org ([2001:4830:134:3::10]:57281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5I-0003NG-Ur
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5H-0004W3-Ja
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:00 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:38562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fUz5H-0004Tb-BK
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:40:59 -0400
Received: by mail-pg0-x22d.google.com with SMTP id c9-v6so7927136pgf.5
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 11:40:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Jun 2018 08:40:28 -1000
Message-Id: <20180618184046.6270-5-richard.henderson@linaro.org>
In-Reply-To: <20180618184046.6270-1-richard.henderson@linaro.org>
References: <20180618184046.6270-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 04/22] target/openrisc: Link more
 translation blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

Track direct jumps via dc->jmp_pc_imm.  Use that in
preference to jmp_pc when possible.  Emit goto_tb in
that case, and lookup_and_goto_tb otherwise.

Reviewed-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 82 +++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 36 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 5c0c9dee09..422f22d7f8 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -42,13 +42,16 @@
 
 /* is_jmp field values */
 #define DISAS_EXIT    DISAS_TARGET_0  /* force exit to main loop */
-#define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
+#define DISAS_JUMP    DISAS_TARGET_1  /* exit via jmp_pc/jmp_pc_imm */
 
 typedef struct DisasContext {
     DisasContextBase base;
     uint32_t mem_idx;
     uint32_t tb_flags;
     uint32_t delayed_branch;
+
+    /* If not -1, jmp_pc contains this value and so is a direct jump.  */
+    target_ulong jmp_pc_imm;
 } DisasContext;
 
 /* Include the auto-generated decoder.  */
@@ -164,34 +167,6 @@ static void check_ov64s(DisasContext *dc)
         }                               \
     } while (0)
 
-static inline bool use_goto_tb(DisasContext *dc, target_ulong dest)
-{
-    if (unlikely(dc->base.singlestep_enabled)) {
-        return false;
-    }
-
-#ifndef CONFIG_USER_ONLY
-    return (dc->base.tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
-#else
-    return true;
-#endif
-}
-
-static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
-{
-    if (use_goto_tb(dc, dest)) {
-        tcg_gen_movi_tl(cpu_pc, dest);
-        tcg_gen_goto_tb(n);
-        tcg_gen_exit_tb(dc->base.tb, n);
-    } else {
-        tcg_gen_movi_tl(cpu_pc, dest);
-        if (dc->base.singlestep_enabled) {
-            gen_exception(dc, EXCP_DEBUG);
-        }
-        tcg_gen_exit_tb(NULL, 0);
-    }
-}
-
 static void gen_ove_cy(DisasContext *dc)
 {
     if (dc->tb_flags & SR_OVE) {
@@ -655,6 +630,7 @@ static bool trans_l_j(DisasContext *dc, arg_l_j *a, uint32_t insn)
 
     LOG_DIS("l.j %d\n", a->n);
     tcg_gen_movi_tl(jmp_pc, tmp_pc);
+    dc->jmp_pc_imm = tmp_pc;
     dc->delayed_branch = 2;
     return true;
 }
@@ -669,6 +645,7 @@ static bool trans_l_jal(DisasContext *dc, arg_l_jal *a, uint32_t insn)
     /* Optimize jal being used to load the PC for PIC.  */
     if (tmp_pc != ret_pc) {
         tcg_gen_movi_tl(jmp_pc, tmp_pc);
+        dc->jmp_pc_imm = tmp_pc;
         dc->delayed_branch = 2;
     }
     return true;
@@ -1381,6 +1358,8 @@ static void openrisc_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
     dc->mem_idx = cpu_mmu_index(env, false);
     dc->tb_flags = dc->base.tb->flags;
     dc->delayed_branch = (dc->tb_flags & TB_FLAGS_DFLAG) != 0;
+    dc->jmp_pc_imm = -1;
+
     bound = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
     dc->base.max_insns = MIN(dc->base.max_insns, bound);
 }
@@ -1437,10 +1416,7 @@ static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     if (dc->delayed_branch) {
         dc->delayed_branch--;
         if (!dc->delayed_branch) {
-            tcg_gen_mov_tl(cpu_pc, jmp_pc);
-            tcg_gen_discard_tl(jmp_pc);
-            dc->base.is_jmp = DISAS_UPDATE;
-            return;
+            dc->base.is_jmp = DISAS_JUMP;
         }
     }
 }
@@ -1448,22 +1424,56 @@ static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
+    target_ulong jmp_dest;
 
     /* If we have already exited the TB, nothing following has effect.  */
     if (dc->base.is_jmp == DISAS_NORETURN) {
         return;
     }
 
+    /* Adjust the delayed branch state for the next TB.  */
     if ((dc->tb_flags & TB_FLAGS_DFLAG ? 1 : 0) != (dc->delayed_branch != 0)) {
         tcg_gen_movi_i32(cpu_dflag, dc->delayed_branch != 0);
     }
 
-    tcg_gen_movi_tl(cpu_ppc, dc->base.pc_next - 4);
+    /* For DISAS_TOO_MANY, jump to the next insn.  */
+    jmp_dest = dc->base.pc_next;
+    tcg_gen_movi_tl(cpu_ppc, jmp_dest - 4);
+
     switch (dc->base.is_jmp) {
+    case DISAS_JUMP:
+        jmp_dest = dc->jmp_pc_imm;
+        if (jmp_dest == -1) {
+            /* The jump destination is indirect/computed; use jmp_pc.  */
+            tcg_gen_mov_tl(cpu_pc, jmp_pc);
+            tcg_gen_discard_tl(jmp_pc);
+            if (unlikely(dc->base.singlestep_enabled)) {
+                gen_exception(dc, EXCP_DEBUG);
+            } else {
+                tcg_gen_lookup_and_goto_ptr();
+            }
+            break;
+        }
+        /* The jump destination is direct; use jmp_pc_imm.
+           However, we will have stored into jmp_pc as well;
+           we know now that it wasn't needed.  */
+        tcg_gen_discard_tl(jmp_pc);
+        /* fallthru */
+
     case DISAS_TOO_MANY:
-        gen_goto_tb(dc, 0, dc->base.pc_next);
+        if (unlikely(dc->base.singlestep_enabled)) {
+            tcg_gen_movi_tl(cpu_pc, jmp_dest);
+            gen_exception(dc, EXCP_DEBUG);
+        } else if ((dc->base.pc_first ^ jmp_dest) & TARGET_PAGE_MASK) {
+            tcg_gen_movi_tl(cpu_pc, jmp_dest);
+            tcg_gen_lookup_and_goto_ptr();
+        } else {
+            tcg_gen_goto_tb(0);
+            tcg_gen_movi_tl(cpu_pc, jmp_dest);
+            tcg_gen_exit_tb(dc->base.tb, 0);
+        }
         break;
-    case DISAS_UPDATE:
+
     case DISAS_EXIT:
         if (unlikely(dc->base.singlestep_enabled)) {
             gen_exception(dc, EXCP_DEBUG);
-- 
2.17.1
