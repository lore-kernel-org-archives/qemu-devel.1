Received: from eggs.gnu.org ([2001:4830:134:3::10]:46740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUDC-0007vD-0N
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUDA-0004xe-J8
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:25 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:32821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVUDA-0004xU-Eg
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:24 -0500
Received: by mail-qt0-x243.google.com with SMTP id n13so14087770qtc.0
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 18:18:24 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun, 22 Jan 2017 18:17:45 -0800
Message-Id: <20170123021748.13170-24-rth@twiddle.net>
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 23/26] target-hppa: Implement shifts and deposits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/hppa/translate.c | 309 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 309 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 14fe4bb..093a65e 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1719,6 +1719,311 @@ static ExitStatus trans_movb(DisasContext *ctx, uint32_t insn, bool is_imm)
     return do_cbranch(ctx, disp, n, &cond);
 }
 
+static ExitStatus trans_shrpw_sar(DisasContext *ctx, uint32_t insn,
+                                 const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    unsigned c = extract32(insn, 13, 3);
+    unsigned r1 = extract32(insn, 16, 5);
+    unsigned r2 = extract32(insn, 21, 5);
+    TCGv dest;
+
+    if (c) {
+        nullify_over(ctx);
+    }
+
+    dest = dest_gpr(ctx, rt);
+    if (r1 == 0) {
+        tcg_gen_ext32u_tl(dest, load_gpr(ctx, r2));
+        tcg_gen_shr_tl(dest, dest, cpu_sar);
+    } else if (r1 == r2) {
+        TCGv_i32 t32 = tcg_temp_new_i32();
+        tcg_gen_trunc_tl_i32(t32, load_gpr(ctx, r2));
+        tcg_gen_rotr_i32(t32, t32, cpu_sar);
+        tcg_gen_extu_i32_tl(dest, t32);
+        tcg_temp_free_i32(t32);
+    } else {
+        TCGv_i64 t = tcg_temp_new_i64();
+        TCGv_i64 s = tcg_temp_new_i64();
+
+        tcg_gen_concat_tl_i64(t, load_gpr(ctx, r2), load_gpr(ctx, r1));
+        tcg_gen_extu_tl_i64(s, cpu_sar);
+        tcg_gen_shr_i64(t, t, s);
+        tcg_gen_trunc_i64_tl(dest, t);
+
+        tcg_temp_free_i64(t);
+        tcg_temp_free_i64(s);
+    }
+    save_gpr(ctx, rt, dest);
+
+    /* Install the new nullification.  */
+    cond_free(&ctx->null_cond);
+    if (c) {
+        ctx->null_cond = do_sed_cond(c, dest);
+    }
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus trans_shrpw_imm(DisasContext *ctx, uint32_t insn,
+                                  const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    unsigned cpos = extract32(insn, 5, 5);
+    unsigned c = extract32(insn, 13, 3);
+    unsigned r1 = extract32(insn, 16, 5);
+    unsigned r2 = extract32(insn, 21, 5);
+    unsigned sa = 31 - cpos;
+    TCGv dest, t2;
+
+    if (c) {
+        nullify_over(ctx);
+    }
+
+    dest = dest_gpr(ctx, rt);
+    t2 = load_gpr(ctx, r2);
+    if (r1 == r2) {
+        TCGv_i32 t32 = tcg_temp_new_i32();
+        tcg_gen_trunc_tl_i32(t32, t2);
+        tcg_gen_rotri_i32(t32, t32, sa);
+        tcg_gen_extu_i32_tl(dest, t32);
+        tcg_temp_free_i32(t32);
+    } else if (r1 == 0) {
+        tcg_gen_extract_tl(dest, t2, sa, 32 - sa);
+    } else {
+        TCGv t0 = tcg_temp_new();
+        tcg_gen_extract_tl(t0, t2, sa, 32 - sa);
+        tcg_gen_deposit_tl(dest, t0, cpu_gr[r1], 32 - sa, sa);
+        tcg_temp_free(t0);
+    }
+    save_gpr(ctx, rt, dest);
+
+    /* Install the new nullification.  */
+    cond_free(&ctx->null_cond);
+    if (c) {
+        ctx->null_cond = do_sed_cond(c, dest);
+    }
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus trans_extrw_sar(DisasContext *ctx, uint32_t insn,
+                                  const DisasInsn *di)
+{
+    unsigned clen = extract32(insn, 0, 5);
+    unsigned is_se = extract32(insn, 10, 1);
+    unsigned c = extract32(insn, 13, 3);
+    unsigned rt = extract32(insn, 16, 5);
+    unsigned rr = extract32(insn, 21, 5);
+    unsigned len = 32 - clen;
+    TCGv dest, src, tmp;
+
+    if (c) {
+        nullify_over(ctx);
+    }
+
+    dest = dest_gpr(ctx, rt);
+    src = load_gpr(ctx, rr);
+    tmp = tcg_temp_new();
+
+    /* Recall that SAR is using big-endian bit numbering.  */
+    tcg_gen_xori_tl(tmp, cpu_sar, TARGET_LONG_BITS - 1);
+    if (is_se) {
+        tcg_gen_sar_tl(dest, src, tmp);
+        tcg_gen_sextract_tl(dest, dest, 0, len);
+    } else {
+        tcg_gen_shr_tl(dest, src, tmp);
+        tcg_gen_extract_tl(dest, dest, 0, len);
+    }
+    tcg_temp_free(tmp);
+    save_gpr(ctx, rt, dest);
+
+    /* Install the new nullification.  */
+    cond_free(&ctx->null_cond);
+    if (c) {
+        ctx->null_cond = do_sed_cond(c, dest);
+    }
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus trans_extrw_imm(DisasContext *ctx, uint32_t insn,
+                                  const DisasInsn *di)
+{
+    unsigned clen = extract32(insn, 0, 5);
+    unsigned pos = extract32(insn, 5, 5);
+    unsigned is_se = extract32(insn, 10, 1);
+    unsigned c = extract32(insn, 13, 3);
+    unsigned rt = extract32(insn, 16, 5);
+    unsigned rr = extract32(insn, 21, 5);
+    unsigned len = 32 - clen;
+    unsigned cpos = 31 - pos;
+    TCGv dest, src;
+
+    if (c) {
+        nullify_over(ctx);
+    }
+
+    dest = dest_gpr(ctx, rt);
+    src = load_gpr(ctx, rr);
+    if (is_se) {
+        tcg_gen_sextract_tl(dest, src, cpos, len);
+    } else {
+        tcg_gen_extract_tl(dest, src, cpos, len);
+    }
+    save_gpr(ctx, rt, dest);
+
+    /* Install the new nullification.  */
+    cond_free(&ctx->null_cond);
+    if (c) {
+        ctx->null_cond = do_sed_cond(c, dest);
+    }
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static const DisasInsn table_sh_ex[] = {
+    { 0xd0000000u, 0xfc001fe0u, trans_shrpw_sar },
+    { 0xd0000800u, 0xfc001c00u, trans_shrpw_imm },
+    { 0xd0001000u, 0xfc001be0u, trans_extrw_sar },
+    { 0xd0001800u, 0xfc001800u, trans_extrw_imm },
+};
+
+static ExitStatus trans_depw_imm_c(DisasContext *ctx, uint32_t insn,
+                                   const DisasInsn *di)
+{
+    unsigned clen = extract32(insn, 0, 5);
+    unsigned cpos = extract32(insn, 5, 5);
+    unsigned nz = extract32(insn, 10, 1);
+    unsigned c = extract32(insn, 13, 3);
+    target_long val = low_sextract(insn, 16, 5);
+    unsigned rt = extract32(insn, 21, 5);
+    unsigned len = 32 - clen;
+    target_long mask0, mask1;
+    TCGv dest;
+
+    if (c) {
+        nullify_over(ctx);
+    }
+    if (cpos + len > 32) {
+        len = 32 - cpos;
+    }
+
+    dest = dest_gpr(ctx, rt);
+    mask0 = deposit64(0, cpos, len, val);
+    mask1 = deposit64(-1, cpos, len, val);
+
+    if (nz) {
+        TCGv src = load_gpr(ctx, rt);
+        if (mask1 != -1) {
+            tcg_gen_andi_tl(dest, src, mask1);
+            src = dest;
+        }
+        tcg_gen_ori_tl(dest, src, mask0);
+    } else {
+        tcg_gen_movi_tl(dest, mask0);
+    }
+    save_gpr(ctx, rt, dest);
+
+    /* Install the new nullification.  */
+    cond_free(&ctx->null_cond);
+    if (c) {
+        ctx->null_cond = do_sed_cond(c, dest);
+    }
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus trans_depw_imm(DisasContext *ctx, uint32_t insn,
+                                 const DisasInsn *di)
+{
+    unsigned clen = extract32(insn, 0, 5);
+    unsigned cpos = extract32(insn, 5, 5);
+    unsigned nz = extract32(insn, 10, 1);
+    unsigned c = extract32(insn, 13, 3);
+    unsigned rr = extract32(insn, 16, 5);
+    unsigned rt = extract32(insn, 21, 5);
+    unsigned rs = nz ? rt : 0;
+    unsigned len = 32 - clen;
+    TCGv dest, val;
+
+    if (c) {
+        nullify_over(ctx);
+    }
+    if (cpos + len > 32) {
+        len = 32 - cpos;
+    }
+
+    dest = dest_gpr(ctx, rt);
+    val = load_gpr(ctx, rr);
+    if (rs == 0) {
+        tcg_gen_deposit_z_tl(dest, val, cpos, len);
+    } else {
+        tcg_gen_deposit_tl(dest, cpu_gr[rs], val, cpos, len);
+    }
+    save_gpr(ctx, rt, dest);
+
+    /* Install the new nullification.  */
+    cond_free(&ctx->null_cond);
+    if (c) {
+        ctx->null_cond = do_sed_cond(c, dest);
+    }
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus trans_depw_sar(DisasContext *ctx, uint32_t insn,
+                                 const DisasInsn *di)
+{
+    unsigned clen = extract32(insn, 0, 5);
+    unsigned nz = extract32(insn, 10, 1);
+    unsigned i = extract32(insn, 12, 1);
+    unsigned c = extract32(insn, 13, 3);
+    unsigned rt = extract32(insn, 21, 5);
+    unsigned rs = nz ? rt : 0;
+    unsigned len = 32 - clen;
+    TCGv val, mask, tmp, shift, dest;
+    unsigned msb = 1U << (len - 1);
+
+    if (c) {
+        nullify_over(ctx);
+    }
+
+    if (i) {
+        val = load_const(ctx, low_sextract(insn, 16, 5));
+    } else {
+        val = load_gpr(ctx, extract32(insn, 16, 5));
+    }
+    dest = dest_gpr(ctx, rt);
+    shift = tcg_temp_new();
+    tmp = tcg_temp_new();
+
+    /* Convert big-endian bit numbering in SAR to left-shift.  */
+    tcg_gen_xori_tl(shift, cpu_sar, TARGET_LONG_BITS - 1);
+
+    mask = tcg_const_tl(msb + (msb - 1));
+    tcg_gen_and_tl(tmp, val, mask);
+    if (rs) {
+        tcg_gen_shl_tl(mask, mask, shift);
+        tcg_gen_shl_tl(tmp, tmp, shift);
+        tcg_gen_andc_tl(dest, cpu_gr[rs], mask);
+        tcg_gen_or_tl(dest, dest, tmp);
+    } else {
+        tcg_gen_shl_tl(dest, tmp, shift);
+    }
+    tcg_temp_free(shift);
+    tcg_temp_free(mask);
+    tcg_temp_free(tmp);
+    save_gpr(ctx, rt, dest);
+
+    /* Install the new nullification.  */
+    cond_free(&ctx->null_cond);
+    if (c) {
+        ctx->null_cond = do_sed_cond(c, dest);
+    }
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static const DisasInsn table_depw[] = {
+    { 0xd4000000u, 0xfc000be0u, trans_depw_sar },
+    { 0xd4000800u, 0xfc001800u, trans_depw_imm },
+    { 0xd4001800u, 0xfc001800u, trans_depw_imm_c },
+};
+
 static ExitStatus trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
 {
     unsigned n = extract32(insn, 1, 1);
@@ -1874,6 +2179,10 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         return trans_movb(ctx, insn, false);
     case 0x33:
         return trans_movb(ctx, insn, true);
+    case 0x34:
+        return translate_table(ctx, insn, table_sh_ex);
+    case 0x35:
+        return translate_table(ctx, insn, table_depw);
     case 0x38:
         return trans_be(ctx, insn, false);
     case 0x39:
-- 
2.9.3
