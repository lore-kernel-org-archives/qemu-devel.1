Received: from eggs.gnu.org ([209.51.188.92]:58389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griGL-0007c6-M7
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griGI-0001YK-JP
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:37 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1griGI-0001T7-77
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:34 -0500
Received: by mail-wr1-x443.google.com with SMTP id q1so1231731wrp.7
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 03:54:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Feb 2019 11:53:53 +0000
Message-Id: <20190207115400.647-13-richard.henderson@linaro.org>
In-Reply-To: <20190207115400.647-1-richard.henderson@linaro.org>
References: <20190207115400.647-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 12/19] target/hppa: Convert direct and indirect
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, svens@stackframe.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c  | 131 +++++++++------------------------------
 target/hppa/insns.decode |  34 +++++++++-
 2 files changed, 63 insertions(+), 102 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 83d898212e..26b5cd205b 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -895,15 +895,6 @@ static target_sreg assemble_16a(uint32_t insn)
     return x << 2;
 }
 
-static target_sreg assemble_17(uint32_t insn)
-{
-    target_ureg x = -(target_ureg)(insn & 1);
-    x = (x <<  5) | extract32(insn, 16, 5);
-    x = (x <<  1) | extract32(insn, 2, 1);
-    x = (x << 10) | extract32(insn, 3, 10);
-    return x << 2;
-}
-
 static target_sreg assemble_21(uint32_t insn)
 {
     target_ureg x = -(target_ureg)(insn & 1);
@@ -914,15 +905,6 @@ static target_sreg assemble_21(uint32_t insn)
     return x << 11;
 }
 
-static target_sreg assemble_22(uint32_t insn)
-{
-    target_ureg x = -(target_ureg)(insn & 1);
-    x = (x << 10) | extract32(insn, 16, 10);
-    x = (x <<  1) | extract32(insn, 2, 1);
-    x = (x << 10) | extract32(insn, 3, 10);
-    return x << 2;
-}
-
 /* The parisc documentation describes only the general interpretation of
    the conditions, without describing their exact implementation.  The
    interpretations do not stand up well when considering ADD,C and SUB,B.
@@ -3546,11 +3528,8 @@ static bool trans_depwi_sar(DisasContext *ctx, arg_depwi_sar *a)
     return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, load_const(ctx, a->i));
 }
 
-static bool trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
+static bool trans_be(DisasContext *ctx, arg_be *a)
 {
-    unsigned n = extract32(insn, 1, 1);
-    unsigned b = extract32(insn, 21, 5);
-    target_sreg disp = assemble_17(insn);
     TCGv_reg tmp;
 
 #ifdef CONFIG_USER_ONLY
@@ -3562,29 +3541,28 @@ static bool trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
     /* Since we don't implement spaces, just branch.  Do notice the special
        case of "be disp(*,r0)" using a direct branch to disp, so that we can
        goto_tb to the TB containing the syscall.  */
-    if (b == 0) {
-        return do_dbranch(ctx, disp, is_l ? 31 : 0, n);
+    if (a->b == 0) {
+        return do_dbranch(ctx, a->disp, a->l, a->n);
     }
 #else
-    int sp = assemble_sr3(insn);
     nullify_over(ctx);
 #endif
 
     tmp = get_temp(ctx);
-    tcg_gen_addi_reg(tmp, load_gpr(ctx, b), disp);
+    tcg_gen_addi_reg(tmp, load_gpr(ctx, a->b), a->disp);
     tmp = do_ibranch_priv(ctx, tmp);
 
 #ifdef CONFIG_USER_ONLY
-    return do_ibranch(ctx, tmp, is_l ? 31 : 0, n);
+    return do_ibranch(ctx, tmp, a->l, a->n);
 #else
     TCGv_i64 new_spc = tcg_temp_new_i64();
 
-    load_spr(ctx, new_spc, sp);
-    if (is_l) {
+    load_spr(ctx, new_spc, a->sp);
+    if (a->l) {
         copy_iaoq_entry(cpu_gr[31], ctx->iaoq_n, ctx->iaoq_n_var);
         tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_f);
     }
-    if (n && use_nullify_skip(ctx)) {
+    if (a->n && use_nullify_skip(ctx)) {
         tcg_gen_mov_reg(cpu_iaoq_f, tmp);
         tcg_gen_addi_reg(cpu_iaoq_b, cpu_iaoq_f, 4);
         tcg_gen_mov_i64(cpu_iasq_f, new_spc);
@@ -3596,7 +3574,7 @@ static bool trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
         }
         tcg_gen_mov_reg(cpu_iaoq_b, tmp);
         tcg_gen_mov_i64(cpu_iasq_b, new_spc);
-        nullify_set(ctx, n);
+        nullify_set(ctx, a->n);
     }
     tcg_temp_free_i64(new_spc);
     tcg_gen_lookup_and_goto_ptr();
@@ -3605,22 +3583,14 @@ static bool trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
 #endif
 }
 
-static bool trans_bl(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_bl(DisasContext *ctx, arg_bl *a)
 {
-    unsigned n = extract32(insn, 1, 1);
-    unsigned link = extract32(insn, 21, 5);
-    target_sreg disp = assemble_17(insn);
-
-    do_dbranch(ctx, iaoq_dest(ctx, disp), link, n);
-    return true;
+    return do_dbranch(ctx, iaoq_dest(ctx, a->disp), a->l, a->n);
 }
 
-static bool trans_b_gate(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
 {
-    unsigned n = extract32(insn, 1, 1);
-    unsigned link = extract32(insn, 21, 5);
-    target_sreg disp = assemble_17(insn);
-    target_ureg dest = iaoq_dest(ctx, disp);
+    target_ureg dest = iaoq_dest(ctx, a->disp);
 
     /* Make sure the caller hasn't done something weird with the queue.
      * ??? This is not quite the same as the PSW[B] bit, which would be
@@ -3659,65 +3629,44 @@ static bool trans_b_gate(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     }
 #endif
 
-    do_dbranch(ctx, dest, link, n);
-    return true;
+    return do_dbranch(ctx, dest, a->l, a->n);
 }
 
-static bool trans_bl_long(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_blr(DisasContext *ctx, arg_blr *a)
 {
-    unsigned n = extract32(insn, 1, 1);
-    target_sreg disp = assemble_22(insn);
-
-    do_dbranch(ctx, iaoq_dest(ctx, disp), 2, n);
-    return true;
-}
-
-static bool trans_blr(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
-{
-    unsigned n = extract32(insn, 1, 1);
-    unsigned rx = extract32(insn, 16, 5);
-    unsigned link = extract32(insn, 21, 5);
     TCGv_reg tmp = get_temp(ctx);
 
-    tcg_gen_shli_reg(tmp, load_gpr(ctx, rx), 3);
+    tcg_gen_shli_reg(tmp, load_gpr(ctx, a->x), 3);
     tcg_gen_addi_reg(tmp, tmp, ctx->iaoq_f + 8);
     /* The computation here never changes privilege level.  */
-    do_ibranch(ctx, tmp, link, n);
-    return true;
+    return do_ibranch(ctx, tmp, a->l, a->n);
 }
 
-static bool trans_bv(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_bv(DisasContext *ctx, arg_bv *a)
 {
-    unsigned n = extract32(insn, 1, 1);
-    unsigned rx = extract32(insn, 16, 5);
-    unsigned rb = extract32(insn, 21, 5);
     TCGv_reg dest;
 
-    if (rx == 0) {
-        dest = load_gpr(ctx, rb);
+    if (a->x == 0) {
+        dest = load_gpr(ctx, a->b);
     } else {
         dest = get_temp(ctx);
-        tcg_gen_shli_reg(dest, load_gpr(ctx, rx), 3);
-        tcg_gen_add_reg(dest, dest, load_gpr(ctx, rb));
+        tcg_gen_shli_reg(dest, load_gpr(ctx, a->x), 3);
+        tcg_gen_add_reg(dest, dest, load_gpr(ctx, a->b));
     }
     dest = do_ibranch_priv(ctx, dest);
-    do_ibranch(ctx, dest, 0, n);
-    return true;
+    return do_ibranch(ctx, dest, 0, a->n);
 }
 
-static bool trans_bve(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_bve(DisasContext *ctx, arg_bve *a)
 {
-    unsigned n = extract32(insn, 1, 1);
-    unsigned rb = extract32(insn, 21, 5);
-    unsigned link = extract32(insn, 13, 1) ? 2 : 0;
     TCGv_reg dest;
 
 #ifdef CONFIG_USER_ONLY
-    dest = do_ibranch_priv(ctx, load_gpr(ctx, rb));
-    do_ibranch(ctx, dest, link, n);
+    dest = do_ibranch_priv(ctx, load_gpr(ctx, a->b));
+    return do_ibranch(ctx, dest, a->l, a->n);
 #else
     nullify_over(ctx);
-    dest = do_ibranch_priv(ctx, load_gpr(ctx, rb));
+    dest = do_ibranch_priv(ctx, load_gpr(ctx, a->b));
 
     copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
     if (ctx->iaoq_b == -1) {
@@ -3725,26 +3674,16 @@ static bool trans_bve(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     }
     copy_iaoq_entry(cpu_iaoq_b, -1, dest);
     tcg_gen_mov_i64(cpu_iasq_b, space_select(ctx, 0, dest));
-    if (link) {
-        copy_iaoq_entry(cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
+    if (a->l) {
+        copy_iaoq_entry(cpu_gr[a->l], ctx->iaoq_n, ctx->iaoq_n_var);
     }
-    nullify_set(ctx, n);
+    nullify_set(ctx, a->n);
     tcg_gen_lookup_and_goto_ptr();
     ctx->base.is_jmp = DISAS_NORETURN;
     return nullify_end(ctx);
 #endif
-    return true;
 }
 
-static const DisasInsn table_branch[] = {
-    { 0xe8000000u, 0xfc006000u, trans_bl }, /* B,L and B,L,PUSH */
-    { 0xe800a000u, 0xfc00e000u, trans_bl_long },
-    { 0xe8004000u, 0xfc00fffdu, trans_blr },
-    { 0xe800c000u, 0xfc00fffdu, trans_bv },
-    { 0xe800d000u, 0xfc00dffcu, trans_bve },
-    { 0xe8002000u, 0xfc00e000u, trans_b_gate },
-};
-
 static bool trans_fop_wew_0c(DisasContext *ctx, uint32_t insn,
                              const DisasInsn *di)
 {
@@ -4422,16 +4361,6 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
         translate_table(ctx, insn, table_fp_fused);
         return;
 
-    case 0x38:
-        trans_be(ctx, insn, false);
-        return;
-    case 0x39:
-        trans_be(ctx, insn, true);
-        return;
-    case 0x3A:
-        translate_table(ctx, insn, table_branch);
-        return;
-
     case 0x04: /* spopn */
     case 0x05: /* diag */
     case 0x0F: /* product specific */
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 987cb8738b..09e3f288a7 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -24,7 +24,9 @@
 %assemble_sr3   13:1 14:2
 %assemble_sr3x  13:1 14:2 !function=expand_sr3x
 
-%assemble_12    0:s1 2:1 3:10  !function=expand_shl2
+%assemble_12    0:s1 2:1 3:10        !function=expand_shl2
+%assemble_17    0:s1 16:5 2:1 3:10   !function=expand_shl2
+%assemble_22    0:s1 16:10 2:1 3:10  !function=expand_shl2
 
 %sm_imm         16:10 !function=expand_sm_imm
 
@@ -210,3 +212,33 @@ depw_sar        110101 t:5 r:5   c:3 00 nz:1 00000  clen:5
 depw_imm        110101 t:5 r:5   c:3 01 nz:1 cpos:5 clen:5
 depwi_sar       110101 t:5 ..... c:3 10 nz:1 00000  clen:5      i=%im5_16
 depwi_imm       110101 t:5 ..... c:3 11 nz:1 cpos:5 clen:5      i=%im5_16
+
+####
+# Branch External
+####
+
+&be             b l n disp sp
+@be             ...... b:5 ..... ... ........... n:1 .  \
+                &be disp=%assemble_17 sp=%assemble_sr3
+
+be              111000 ..... ..... ... ........... . .  @be l=0
+be              111001 ..... ..... ... ........... . .  @be l=31
+
+####
+# Branch
+####
+
+&bl             l n disp
+@bl             ...... l:5 ..... ... ........... n:1 .  &bl disp=%assemble_17
+
+# B,L and B,L,PUSH
+bl              111010 ..... ..... 000 ........... .   .        @bl
+bl              111010 ..... ..... 100 ........... .   .        @bl
+# B,L (long displacement)
+bl              111010 ..... ..... 101 ........... n:1 .        &bl l=2 \
+                disp=%assemble_22
+b_gate          111010 ..... ..... 001 ........... .   .        @bl
+blr             111010 l:5   x:5   010 00000000000 n:1 0
+bv              111010 b:5   x:5   110 00000000000 n:1 0
+bve             111010 b:5   00000 110 10000000000 n:1 -        l=0
+bve             111010 b:5   00000 111 10000000000 n:1 -        l=2
-- 
2.17.2
