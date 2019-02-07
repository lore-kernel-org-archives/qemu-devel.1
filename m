Received: from eggs.gnu.org ([209.51.188.92]:58274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griGH-0007Yh-35
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griGB-0001Vt-Dw
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:29 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1griG7-0001Sy-Qi
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:25 -0500
Received: by mail-wr1-x42d.google.com with SMTP id a16so11268342wrv.0
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 03:54:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Feb 2019 11:53:52 +0000
Message-Id: <20190207115400.647-12-richard.henderson@linaro.org>
In-Reply-To: <20190207115400.647-1-richard.henderson@linaro.org>
References: <20190207115400.647-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 11/19] target/hppa: Convert shift, extract,
 deposit insns
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
 target/hppa/translate.c  | 215 ++++++++++++++-------------------------
 target/hppa/insns.decode |  15 +++
 2 files changed, 94 insertions(+), 136 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 7bdb900130..83d898212e 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3292,26 +3292,21 @@ static bool trans_movbi(DisasContext *ctx, arg_movbi *a)
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
-static bool trans_shrpw_sar(DisasContext *ctx, uint32_t insn,
-                            const DisasInsn *di)
+static bool trans_shrpw_sar(DisasContext *ctx, arg_shrpw_sar *a)
 {
-    unsigned rt = extract32(insn, 0, 5);
-    unsigned c = extract32(insn, 13, 3);
-    unsigned r1 = extract32(insn, 16, 5);
-    unsigned r2 = extract32(insn, 21, 5);
     TCGv_reg dest;
 
-    if (c) {
+    if (a->c) {
         nullify_over(ctx);
     }
 
-    dest = dest_gpr(ctx, rt);
-    if (r1 == 0) {
-        tcg_gen_ext32u_reg(dest, load_gpr(ctx, r2));
+    dest = dest_gpr(ctx, a->t);
+    if (a->r1 == 0) {
+        tcg_gen_ext32u_reg(dest, load_gpr(ctx, a->r2));
         tcg_gen_shr_reg(dest, dest, cpu_sar);
-    } else if (r1 == r2) {
+    } else if (a->r1 == a->r2) {
         TCGv_i32 t32 = tcg_temp_new_i32();
-        tcg_gen_trunc_reg_i32(t32, load_gpr(ctx, r2));
+        tcg_gen_trunc_reg_i32(t32, load_gpr(ctx, a->r2));
         tcg_gen_rotr_i32(t32, t32, cpu_sar);
         tcg_gen_extu_i32_reg(dest, t32);
         tcg_temp_free_i32(t32);
@@ -3319,7 +3314,7 @@ static bool trans_shrpw_sar(DisasContext *ctx, uint32_t insn,
         TCGv_i64 t = tcg_temp_new_i64();
         TCGv_i64 s = tcg_temp_new_i64();
 
-        tcg_gen_concat_reg_i64(t, load_gpr(ctx, r2), load_gpr(ctx, r1));
+        tcg_gen_concat_reg_i64(t, load_gpr(ctx, a->r2), load_gpr(ctx, a->r1));
         tcg_gen_extu_reg_i64(s, cpu_sar);
         tcg_gen_shr_i64(t, t, s);
         tcg_gen_trunc_i64_reg(dest, t);
@@ -3327,79 +3322,67 @@ static bool trans_shrpw_sar(DisasContext *ctx, uint32_t insn,
         tcg_temp_free_i64(t);
         tcg_temp_free_i64(s);
     }
-    save_gpr(ctx, rt, dest);
+    save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
-    if (c) {
-        ctx->null_cond = do_sed_cond(c, dest);
+    if (a->c) {
+        ctx->null_cond = do_sed_cond(a->c, dest);
     }
     return nullify_end(ctx);
 }
 
-static bool trans_shrpw_imm(DisasContext *ctx, uint32_t insn,
-                            const DisasInsn *di)
+static bool trans_shrpw_imm(DisasContext *ctx, arg_shrpw_imm *a)
 {
-    unsigned rt = extract32(insn, 0, 5);
-    unsigned cpos = extract32(insn, 5, 5);
-    unsigned c = extract32(insn, 13, 3);
-    unsigned r1 = extract32(insn, 16, 5);
-    unsigned r2 = extract32(insn, 21, 5);
-    unsigned sa = 31 - cpos;
+    unsigned sa = 31 - a->cpos;
     TCGv_reg dest, t2;
 
-    if (c) {
+    if (a->c) {
         nullify_over(ctx);
     }
 
-    dest = dest_gpr(ctx, rt);
-    t2 = load_gpr(ctx, r2);
-    if (r1 == r2) {
+    dest = dest_gpr(ctx, a->t);
+    t2 = load_gpr(ctx, a->r2);
+    if (a->r1 == a->r2) {
         TCGv_i32 t32 = tcg_temp_new_i32();
         tcg_gen_trunc_reg_i32(t32, t2);
         tcg_gen_rotri_i32(t32, t32, sa);
         tcg_gen_extu_i32_reg(dest, t32);
         tcg_temp_free_i32(t32);
-    } else if (r1 == 0) {
+    } else if (a->r1 == 0) {
         tcg_gen_extract_reg(dest, t2, sa, 32 - sa);
     } else {
         TCGv_reg t0 = tcg_temp_new();
         tcg_gen_extract_reg(t0, t2, sa, 32 - sa);
-        tcg_gen_deposit_reg(dest, t0, cpu_gr[r1], 32 - sa, sa);
+        tcg_gen_deposit_reg(dest, t0, cpu_gr[a->r1], 32 - sa, sa);
         tcg_temp_free(t0);
     }
-    save_gpr(ctx, rt, dest);
+    save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
-    if (c) {
-        ctx->null_cond = do_sed_cond(c, dest);
+    if (a->c) {
+        ctx->null_cond = do_sed_cond(a->c, dest);
     }
     return nullify_end(ctx);
 }
 
-static bool trans_extrw_sar(DisasContext *ctx, uint32_t insn,
-                            const DisasInsn *di)
+static bool trans_extrw_sar(DisasContext *ctx, arg_extrw_sar *a)
 {
-    unsigned clen = extract32(insn, 0, 5);
-    unsigned is_se = extract32(insn, 10, 1);
-    unsigned c = extract32(insn, 13, 3);
-    unsigned rt = extract32(insn, 16, 5);
-    unsigned rr = extract32(insn, 21, 5);
-    unsigned len = 32 - clen;
+    unsigned len = 32 - a->clen;
     TCGv_reg dest, src, tmp;
 
-    if (c) {
+    if (a->c) {
         nullify_over(ctx);
     }
 
-    dest = dest_gpr(ctx, rt);
-    src = load_gpr(ctx, rr);
+    dest = dest_gpr(ctx, a->t);
+    src = load_gpr(ctx, a->r);
     tmp = tcg_temp_new();
 
     /* Recall that SAR is using big-endian bit numbering.  */
     tcg_gen_xori_reg(tmp, cpu_sar, TARGET_REGISTER_BITS - 1);
-    if (is_se) {
+    if (a->se) {
         tcg_gen_sar_reg(dest, src, tmp);
         tcg_gen_sextract_reg(dest, dest, 0, len);
     } else {
@@ -3407,83 +3390,62 @@ static bool trans_extrw_sar(DisasContext *ctx, uint32_t insn,
         tcg_gen_extract_reg(dest, dest, 0, len);
     }
     tcg_temp_free(tmp);
-    save_gpr(ctx, rt, dest);
+    save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
-    if (c) {
-        ctx->null_cond = do_sed_cond(c, dest);
+    if (a->c) {
+        ctx->null_cond = do_sed_cond(a->c, dest);
     }
     return nullify_end(ctx);
 }
 
-static bool trans_extrw_imm(DisasContext *ctx, uint32_t insn,
-                            const DisasInsn *di)
+static bool trans_extrw_imm(DisasContext *ctx, arg_extrw_imm *a)
 {
-    unsigned clen = extract32(insn, 0, 5);
-    unsigned pos = extract32(insn, 5, 5);
-    unsigned is_se = extract32(insn, 10, 1);
-    unsigned c = extract32(insn, 13, 3);
-    unsigned rt = extract32(insn, 16, 5);
-    unsigned rr = extract32(insn, 21, 5);
-    unsigned len = 32 - clen;
-    unsigned cpos = 31 - pos;
+    unsigned len = 32 - a->clen;
+    unsigned cpos = 31 - a->pos;
     TCGv_reg dest, src;
 
-    if (c) {
+    if (a->c) {
         nullify_over(ctx);
     }
 
-    dest = dest_gpr(ctx, rt);
-    src = load_gpr(ctx, rr);
-    if (is_se) {
+    dest = dest_gpr(ctx, a->t);
+    src = load_gpr(ctx, a->r);
+    if (a->se) {
         tcg_gen_sextract_reg(dest, src, cpos, len);
     } else {
         tcg_gen_extract_reg(dest, src, cpos, len);
     }
-    save_gpr(ctx, rt, dest);
+    save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
-    if (c) {
-        ctx->null_cond = do_sed_cond(c, dest);
+    if (a->c) {
+        ctx->null_cond = do_sed_cond(a->c, dest);
     }
     return nullify_end(ctx);
 }
 
-static const DisasInsn table_sh_ex[] = {
-    { 0xd0000000u, 0xfc001fe0u, trans_shrpw_sar },
-    { 0xd0000800u, 0xfc001c00u, trans_shrpw_imm },
-    { 0xd0001000u, 0xfc001be0u, trans_extrw_sar },
-    { 0xd0001800u, 0xfc001800u, trans_extrw_imm },
-};
-
-static bool trans_depw_imm_c(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
+static bool trans_depwi_imm(DisasContext *ctx, arg_depwi_imm *a)
 {
-    unsigned clen = extract32(insn, 0, 5);
-    unsigned cpos = extract32(insn, 5, 5);
-    unsigned nz = extract32(insn, 10, 1);
-    unsigned c = extract32(insn, 13, 3);
-    target_sreg val = low_sextract(insn, 16, 5);
-    unsigned rt = extract32(insn, 21, 5);
-    unsigned len = 32 - clen;
+    unsigned len = 32 - a->clen;
     target_sreg mask0, mask1;
     TCGv_reg dest;
 
-    if (c) {
+    if (a->c) {
         nullify_over(ctx);
     }
-    if (cpos + len > 32) {
-        len = 32 - cpos;
+    if (a->cpos + len > 32) {
+        len = 32 - a->cpos;
     }
 
-    dest = dest_gpr(ctx, rt);
-    mask0 = deposit64(0, cpos, len, val);
-    mask1 = deposit64(-1, cpos, len, val);
+    dest = dest_gpr(ctx, a->t);
+    mask0 = deposit64(0, a->cpos, len, a->i);
+    mask1 = deposit64(-1, a->cpos, len, a->i);
 
-    if (nz) {
-        TCGv_reg src = load_gpr(ctx, rt);
+    if (a->nz) {
+        TCGv_reg src = load_gpr(ctx, a->t);
         if (mask1 != -1) {
             tcg_gen_andi_reg(dest, src, mask1);
             src = dest;
@@ -3492,75 +3454,58 @@ static bool trans_depw_imm_c(DisasContext *ctx, uint32_t insn,
     } else {
         tcg_gen_movi_reg(dest, mask0);
     }
-    save_gpr(ctx, rt, dest);
+    save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
-    if (c) {
-        ctx->null_cond = do_sed_cond(c, dest);
+    if (a->c) {
+        ctx->null_cond = do_sed_cond(a->c, dest);
     }
     return nullify_end(ctx);
 }
 
-static bool trans_depw_imm(DisasContext *ctx, uint32_t insn,
-                           const DisasInsn *di)
+static bool trans_depw_imm(DisasContext *ctx, arg_depw_imm *a)
 {
-    unsigned clen = extract32(insn, 0, 5);
-    unsigned cpos = extract32(insn, 5, 5);
-    unsigned nz = extract32(insn, 10, 1);
-    unsigned c = extract32(insn, 13, 3);
-    unsigned rr = extract32(insn, 16, 5);
-    unsigned rt = extract32(insn, 21, 5);
-    unsigned rs = nz ? rt : 0;
-    unsigned len = 32 - clen;
+    unsigned rs = a->nz ? a->t : 0;
+    unsigned len = 32 - a->clen;
     TCGv_reg dest, val;
 
-    if (c) {
+    if (a->c) {
         nullify_over(ctx);
     }
-    if (cpos + len > 32) {
-        len = 32 - cpos;
+    if (a->cpos + len > 32) {
+        len = 32 - a->cpos;
     }
 
-    dest = dest_gpr(ctx, rt);
-    val = load_gpr(ctx, rr);
+    dest = dest_gpr(ctx, a->t);
+    val = load_gpr(ctx, a->r);
     if (rs == 0) {
-        tcg_gen_deposit_z_reg(dest, val, cpos, len);
+        tcg_gen_deposit_z_reg(dest, val, a->cpos, len);
     } else {
-        tcg_gen_deposit_reg(dest, cpu_gr[rs], val, cpos, len);
+        tcg_gen_deposit_reg(dest, cpu_gr[rs], val, a->cpos, len);
     }
-    save_gpr(ctx, rt, dest);
+    save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
-    if (c) {
-        ctx->null_cond = do_sed_cond(c, dest);
+    if (a->c) {
+        ctx->null_cond = do_sed_cond(a->c, dest);
     }
     return nullify_end(ctx);
 }
 
-static bool trans_depw_sar(DisasContext *ctx, uint32_t insn,
-                           const DisasInsn *di)
+static bool do_depw_sar(DisasContext *ctx, unsigned rt, unsigned c,
+                        unsigned nz, unsigned clen, TCGv_reg val)
 {
-    unsigned clen = extract32(insn, 0, 5);
-    unsigned nz = extract32(insn, 10, 1);
-    unsigned i = extract32(insn, 12, 1);
-    unsigned c = extract32(insn, 13, 3);
-    unsigned rt = extract32(insn, 21, 5);
     unsigned rs = nz ? rt : 0;
     unsigned len = 32 - clen;
-    TCGv_reg val, mask, tmp, shift, dest;
+    TCGv_reg mask, tmp, shift, dest;
     unsigned msb = 1U << (len - 1);
 
     if (c) {
         nullify_over(ctx);
     }
 
-    if (i) {
-        val = load_const(ctx, low_sextract(insn, 16, 5));
-    } else {
-        val = load_gpr(ctx, extract32(insn, 16, 5));
-    }
     dest = dest_gpr(ctx, rt);
     shift = tcg_temp_new();
     tmp = tcg_temp_new();
@@ -3591,11 +3536,15 @@ static bool trans_depw_sar(DisasContext *ctx, uint32_t insn,
     return nullify_end(ctx);
 }
 
-static const DisasInsn table_depw[] = {
-    { 0xd4000000u, 0xfc000be0u, trans_depw_sar },
-    { 0xd4000800u, 0xfc001800u, trans_depw_imm },
-    { 0xd4001800u, 0xfc001800u, trans_depw_imm_c },
-};
+static bool trans_depw_sar(DisasContext *ctx, arg_depw_sar *a)
+{
+    return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, load_gpr(ctx, a->r));
+}
+
+static bool trans_depwi_sar(DisasContext *ctx, arg_depwi_sar *a)
+{
+    return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, load_const(ctx, a->i));
+}
 
 static bool trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
 {
@@ -4473,12 +4422,6 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
         translate_table(ctx, insn, table_fp_fused);
         return;
 
-    case 0x34:
-        translate_table(ctx, insn, table_sh_ex);
-        return;
-    case 0x35:
-        translate_table(ctx, insn, table_depw);
-        return;
     case 0x38:
         trans_be(ctx, insn, false);
         return;
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index e891fbfac5..987cb8738b 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -195,3 +195,18 @@ addb            101000 ..... ..... ... ........... . .  @rrb_cf f=0
 addb            101010 ..... ..... ... ........... . .  @rrb_cf f=1
 addbi           101001 ..... ..... ... ........... . .  @rib_cf f=0
 addbi           101011 ..... ..... ... ........... . .  @rib_cf f=1
+
+####
+# Shift, Extract, Deposit
+####
+
+shrpw_sar       110100 r2:5 r1:5 c:3 00 0    00000  t:5
+shrpw_imm       110100 r2:5 r1:5 c:3 01 0    cpos:5 t:5
+
+extrw_sar       110100 r:5  t:5  c:3 10 se:1 00000  clen:5
+extrw_imm       110100 r:5  t:5  c:3 11 se:1 pos:5  clen:5
+
+depw_sar        110101 t:5 r:5   c:3 00 nz:1 00000  clen:5
+depw_imm        110101 t:5 r:5   c:3 01 nz:1 cpos:5 clen:5
+depwi_sar       110101 t:5 ..... c:3 10 nz:1 00000  clen:5      i=%im5_16
+depwi_imm       110101 t:5 ..... c:3 11 nz:1 cpos:5 clen:5      i=%im5_16
-- 
2.17.2
