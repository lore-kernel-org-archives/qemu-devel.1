Received: from eggs.gnu.org ([2001:4830:134:3::10]:41999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en99L-0000GB-4I
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:32:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en99J-0000op-Gs
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:31:59 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:45792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en99J-0000oi-8n
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:31:57 -0500
Received: by mail-pl0-x241.google.com with SMTP id p5so3525982plo.12
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 12:31:57 -0800 (PST)
Received: from cloudburst.twiddle.net ([50.0.192.64])
	by smtp.gmail.com with ESMTPSA id
	y7sm48203797pfe.26.2018.02.17.12.31.54 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 17 Feb 2018 12:31:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 12:31:25 -0800
Message-Id: <20180217203132.31780-13-richard.henderson@linaro.org>
In-Reply-To: <20180217203132.31780-1-richard.henderson@linaro.org>
References: <20180217203132.31780-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c  | 125 ++++++++++++-----------------------------------
 target/hppa/insns.decode |  34 ++++++++++++-
 2 files changed, 63 insertions(+), 96 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e01a28c70c..5df5b8dba4 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -901,15 +901,6 @@ static target_sreg assemble_16a(uint32_t insn)
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
@@ -920,15 +911,6 @@ static target_sreg assemble_21(uint32_t insn)
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
@@ -3549,11 +3531,8 @@ static void trans_depwi_sar(DisasContext *ctx, arg_depwi_sar *a, uint32_t insn)
     tcg_temp_free(i);
 }
 
-static void trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
+static void trans_be(DisasContext *ctx, arg_be *a, uint32_t insn)
 {
-    unsigned n = extract32(insn, 1, 1);
-    unsigned b = extract32(insn, 21, 5);
-    target_sreg disp = assemble_17(insn);
     TCGv_reg tmp;
 
 #ifdef CONFIG_USER_ONLY
@@ -3565,29 +3544,28 @@ static void trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
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
-    do_ibranch(ctx, tmp, is_l ? 31 : 0, n);
+    do_ibranch(ctx, tmp, a->l, a->n);
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
@@ -3599,7 +3577,7 @@ static void trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
         }
         tcg_gen_mov_reg(cpu_iaoq_b, tmp);
         tcg_gen_mov_i64(cpu_iasq_b, new_spc);
-        nullify_set(ctx, n);
+        nullify_set(ctx, a->n);
     }
     tcg_temp_free_i64(new_spc);
     tcg_gen_lookup_and_goto_ptr();
@@ -3608,21 +3586,14 @@ static void trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
 #endif
 }
 
-static void trans_bl(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static void trans_bl(DisasContext *ctx, arg_bl *a, uint32_t insn)
 {
-    unsigned n = extract32(insn, 1, 1);
-    unsigned link = extract32(insn, 21, 5);
-    target_sreg disp = assemble_17(insn);
-
-    do_dbranch(ctx, iaoq_dest(ctx, disp), link, n);
+    do_dbranch(ctx, iaoq_dest(ctx, a->disp), a->l, a->n);
 }
 
-static void trans_b_gate(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static void trans_b_gate(DisasContext *ctx, arg_b_gate *a, uint32_t insn)
 {
-    unsigned n = extract32(insn, 1, 1);
-    unsigned link = extract32(insn, 21, 5);
-    target_sreg disp = assemble_17(insn);
-    target_ureg dest = iaoq_dest(ctx, disp);
+    target_ureg dest = iaoq_dest(ctx, a->disp);
 
     /* Make sure the caller hasn't done something weird with the queue.
      * ??? This is not quite the same as the PSW[B] bit, which would be
@@ -3661,61 +3632,44 @@ static void trans_b_gate(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     }
 #endif
 
-    do_dbranch(ctx, dest, link, n);
+    do_dbranch(ctx, dest, a->l, a->n);
 }
 
-static void trans_bl_long(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static void trans_blr(DisasContext *ctx, arg_blr *a, uint32_t insn)
 {
-    unsigned n = extract32(insn, 1, 1);
-    target_sreg disp = assemble_22(insn);
-
-    do_dbranch(ctx, iaoq_dest(ctx, disp), 2, n);
-}
-
-static void trans_blr(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
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
+    do_ibranch(ctx, tmp, a->l, a->n);
 }
 
-static void trans_bv(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static void trans_bv(DisasContext *ctx, arg_bv *a, uint32_t insn)
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
+    do_ibranch(ctx, dest, 0, a->n);
 }
 
-static void trans_bve(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static void trans_bve(DisasContext *ctx, arg_bve *a, uint32_t insn)
 {
-    unsigned n = extract32(insn, 1, 1);
-    unsigned rb = extract32(insn, 21, 5);
-    unsigned link = extract32(insn, 13, 1) ? 2 : 0;
     TCGv_reg dest;
 
 #ifdef CONFIG_USER_ONLY
-    dest = do_ibranch_priv(ctx, load_gpr(ctx, rb));
-    do_ibranch(ctx, dest, link, n);
+    dest = do_ibranch_priv(ctx, load_gpr(ctx, a->b));
+    do_ibranch(ctx, dest, a->l, a->n);
 #else
     nullify_over(ctx);
-    dest = do_ibranch_priv(ctx, load_gpr(ctx, rb));
+    dest = do_ibranch_priv(ctx, load_gpr(ctx, a->b));
 
     copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
     if (ctx->iaoq_b == -1) {
@@ -3723,25 +3677,16 @@ static void trans_bve(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
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
     nullify_end(ctx);
 #endif
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
 static void trans_fop_wew_0c(DisasContext *ctx, uint32_t insn,
                              const DisasInsn *di)
 {
@@ -4408,16 +4353,6 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
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
index ed0b5fe9d7..3bd19f8a28 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -24,7 +24,9 @@
 %assemble_sr3	13:1 14:2
 %assemble_sr3x	13:1 14:2 !function=expand_sr3x
 
-%assemble_12	0:s1 2:1 3:10  !function=expand_shl2
+%assemble_12	0:s1 2:1 3:10        !function=expand_shl2
+%assemble_17	0:s1 16:5 2:1 3:10   !function=expand_shl2
+%assemble_22	0:s1 16:10 2:1 3:10  !function=expand_shl2
 
 %sm_imm		16:10 !function=expand_sm_imm
 
@@ -208,3 +210,33 @@ depw_sar	110101 t:5 r:5   c:3 00 nz:1 00000  clen:5
 depw_imm	110101 t:5 r:5   c:3 01 nz:1 cpos:5 clen:5
 depwi_sar	110101 t:5 ..... c:3 10 nz:1 00000  clen:5	i=%im5_16
 depwi_imm	110101 t:5 ..... c:3 11 nz:1 cpos:5 clen:5	i=%im5_16
+
+####
+# Branch External
+####
+
+&be		b l n disp sp
+@be		...... b:5 ..... ... ........... n:1 .	\
+		&be disp=%assemble_17 sp=%assemble_sr3
+
+be		111000 ..... ..... ... ........... . .	@be l=0
+be		111001 ..... ..... ... ........... . .  @be l=31
+
+####
+# Branch
+####
+
+&bl		l n disp
+@bl		...... l:5 ..... ... ........... n:1 .  &bl disp=%assemble_17
+
+# B,L and B,L,PUSH
+bl		111010 ..... ..... 000 ........... .   .	@bl
+bl		111010 ..... ..... 100 ........... .   .	@bl
+# B,L (long displacement)
+bl		111010 ..... ..... 101 ........... n:1 .	&bl l=2 \
+		disp=%assemble_22
+b_gate		111010 ..... ..... 001 ........... .   .	@bl
+blr		111010 l:5   x:5   010 00000000000 n:1 0
+bv		111010 b:5   x:5   110 00000000000 n:1 0
+bve		111010 b:5   00000 110 10000000000 n:1 -	l=0
+bve		111010 b:5   00000 111 10000000000 n:1 -	l=2
-- 
2.14.3
