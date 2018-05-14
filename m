Received: from eggs.gnu.org ([2001:4830:134:3::10]:55321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILwC-000472-LO
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILwB-0008Kd-CC
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:27:24 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fILwB-0008K8-43
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:27:23 -0400
Received: by mail-pf0-x241.google.com with SMTP id x9-v6so6682068pfm.2
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 15:27:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 May 2018 15:27:04 -0700
Message-Id: <20180514222714.7982-4-richard.henderson@linaro.org>
In-Reply-To: <20180514222714.7982-1-richard.henderson@linaro.org>
References: <20180514222714.7982-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 03/13] target/openrisc: Convert branch insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, peter.maydell@linaro.org

Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c  | 150 +++++++++++++++++------------------
 target/openrisc/insns.decode |  12 +++
 2 files changed, 84 insertions(+), 78 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index a4b67f94c5..3a02a1d688 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -193,52 +193,6 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
     }
 }
 
-static void gen_jump(DisasContext *dc, int32_t n26, uint32_t reg, uint32_t op0)
-{
-    target_ulong tmp_pc = dc->base.pc_next + n26 * 4;
-
-    switch (op0) {
-    case 0x00:     /* l.j */
-        tcg_gen_movi_tl(jmp_pc, tmp_pc);
-        break;
-    case 0x01:     /* l.jal */
-        tcg_gen_movi_tl(cpu_R[9], dc->base.pc_next + 8);
-        /* Optimize jal being used to load the PC for PIC.  */
-        if (tmp_pc == dc->base.pc_next + 8) {
-            return;
-        }
-        tcg_gen_movi_tl(jmp_pc, tmp_pc);
-        break;
-    case 0x03:     /* l.bnf */
-    case 0x04:     /* l.bf  */
-        {
-            TCGv t_next = tcg_const_tl(dc->base.pc_next + 8);
-            TCGv t_true = tcg_const_tl(tmp_pc);
-            TCGv t_zero = tcg_const_tl(0);
-
-            tcg_gen_movcond_tl(op0 == 0x03 ? TCG_COND_EQ : TCG_COND_NE,
-                               jmp_pc, cpu_sr_f, t_zero, t_true, t_next);
-
-            tcg_temp_free(t_next);
-            tcg_temp_free(t_true);
-            tcg_temp_free(t_zero);
-        }
-        break;
-    case 0x11:     /* l.jr */
-        tcg_gen_mov_tl(jmp_pc, cpu_R[reg]);
-        break;
-    case 0x12:     /* l.jalr */
-        tcg_gen_movi_tl(cpu_R[9], (dc->base.pc_next + 8));
-        tcg_gen_mov_tl(jmp_pc, cpu_R[reg]);
-        break;
-    default:
-        gen_illegal_exception(dc);
-        break;
-    }
-
-    dc->delayed_branch = 2;
-}
-
 static void gen_ove_cy(DisasContext *dc)
 {
     if (dc->tb_flags & SR_OVE) {
@@ -713,12 +667,83 @@ static void dec_calc(DisasContext *dc, uint32_t insn)
     gen_illegal_exception(dc);
 }
 
+static bool trans_l_j(DisasContext *dc, arg_l_j *a, uint32_t insn)
+{
+    target_ulong tmp_pc = dc->base.pc_next + a->n * 4;
+
+    LOG_DIS("l.j %d\n", a->n);
+    tcg_gen_movi_tl(jmp_pc, tmp_pc);
+    dc->delayed_branch = 2;
+    return true;
+}
+
+static bool trans_l_jal(DisasContext *dc, arg_l_jal *a, uint32_t insn)
+{
+    target_ulong tmp_pc = dc->base.pc_next + a->n * 4;
+    target_ulong ret_pc = dc->base.pc_next + 8;
+
+    LOG_DIS("l.jal %d\n", a->n);
+    tcg_gen_movi_tl(cpu_R[9], ret_pc);
+    /* Optimize jal being used to load the PC for PIC.  */
+    if (tmp_pc != ret_pc) {
+        tcg_gen_movi_tl(jmp_pc, tmp_pc);
+        dc->delayed_branch = 2;
+    }
+    return true;
+}
+
+static void do_bf(DisasContext *dc, arg_l_bf *a, TCGCond cond)
+{
+    target_ulong tmp_pc = dc->base.pc_next + a->n * 4;
+    TCGv t_next = tcg_const_tl(dc->base.pc_next + 8);
+    TCGv t_true = tcg_const_tl(tmp_pc);
+    TCGv t_zero = tcg_const_tl(0);
+
+    tcg_gen_movcond_tl(cond, jmp_pc, cpu_sr_f, t_zero, t_true, t_next);
+
+    tcg_temp_free(t_next);
+    tcg_temp_free(t_true);
+    tcg_temp_free(t_zero);
+    dc->delayed_branch = 2;
+}
+
+static bool trans_l_bf(DisasContext *dc, arg_l_bf *a, uint32_t insn)
+{
+    LOG_DIS("l.bf %d\n", a->n);
+    do_bf(dc, a, TCG_COND_NE);
+    return true;
+}
+
+static bool trans_l_bnf(DisasContext *dc, arg_l_bf *a, uint32_t insn)
+{
+    LOG_DIS("l.bnf %d\n", a->n);
+    do_bf(dc, a, TCG_COND_EQ);
+    return true;
+}
+
+static bool trans_l_jr(DisasContext *dc, arg_l_jr *a, uint32_t insn)
+{
+    LOG_DIS("l.jr r%d\n", a->b);
+    tcg_gen_mov_tl(jmp_pc, cpu_R[a->b]);
+    dc->delayed_branch = 2;
+    return true;
+}
+
+static bool trans_l_jalr(DisasContext *dc, arg_l_jalr *a, uint32_t insn)
+{
+    LOG_DIS("l.jalr r%d\n", a->b);
+    tcg_gen_mov_tl(jmp_pc, cpu_R[a->b]);
+    tcg_gen_movi_tl(cpu_R[9], dc->base.pc_next + 8);
+    dc->delayed_branch = 2;
+    return true;
+}
+
 static void dec_misc(DisasContext *dc, uint32_t insn)
 {
     uint32_t op0, op1;
     uint32_t ra, rb, rd;
     uint32_t L6, K5, K16, K5_11;
-    int32_t I16, I5_11, N26;
+    int32_t I16, I5_11;
     TCGMemOp mop;
     TCGv t0;
 
@@ -731,31 +756,10 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
     K5 = extract32(insn, 0, 5);
     K16 = extract32(insn, 0, 16);
     I16 = (int16_t)K16;
-    N26 = sextract32(insn, 0, 26);
     K5_11 = (extract32(insn, 21, 5) << 11) | extract32(insn, 0, 11);
     I5_11 = (int16_t)K5_11;
 
     switch (op0) {
-    case 0x00:    /* l.j */
-        LOG_DIS("l.j %d\n", N26);
-        gen_jump(dc, N26, 0, op0);
-        break;
-
-    case 0x01:    /* l.jal */
-        LOG_DIS("l.jal %d\n", N26);
-        gen_jump(dc, N26, 0, op0);
-        break;
-
-    case 0x03:    /* l.bnf */
-        LOG_DIS("l.bnf %d\n", N26);
-        gen_jump(dc, N26, 0, op0);
-        break;
-
-    case 0x04:    /* l.bf */
-        LOG_DIS("l.bf %d\n", N26);
-        gen_jump(dc, N26, 0, op0);
-        break;
-
     case 0x05:
         switch (op1) {
         case 0x01:    /* l.nop */
@@ -768,16 +772,6 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
         }
         break;
 
-    case 0x11:    /* l.jr */
-        LOG_DIS("l.jr r%d\n", rb);
-         gen_jump(dc, 0, rb, op0);
-         break;
-
-    case 0x12:    /* l.jalr */
-        LOG_DIS("l.jalr r%d\n", rb);
-        gen_jump(dc, 0, rb, op0);
-        break;
-
     case 0x13:    /* l.maci */
         LOG_DIS("l.maci r%d, %d\n", ra, I16);
         t0 = tcg_const_tl(I16);
diff --git a/target/openrisc/insns.decode b/target/openrisc/insns.decode
index 47d31afc5b..8d35011eab 100644
--- a/target/openrisc/insns.decode
+++ b/target/openrisc/insns.decode
@@ -26,3 +26,15 @@ l_trap          001000 0100000000 k:16
 l_msync         001000 1000000000 00000000 00000000
 l_psync         001000 1010000000 00000000 00000000
 l_csync         001000 1100000000 00000000 00000000
+
+####
+# Branch Instructions
+####
+
+l_j             000000 n:s26
+l_jal           000001 n:s26
+l_bnf           000011 n:s26
+l_bf            000100 n:s26
+
+l_jr            010001 ---------- b:5 -----------
+l_jalr          010010 ---------- b:5 -----------
-- 
2.17.0
