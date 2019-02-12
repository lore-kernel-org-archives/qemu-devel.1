Received: from eggs.gnu.org ([209.51.188.92]:49782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ95-0002nK-IP
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ8o-0001vJ-3o
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:58:07 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:43767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtQ8m-0001d1-CY
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:57:53 -0500
Received: by mail-pl1-x633.google.com with SMTP id f90so680279plb.10
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:57:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 20:57:07 -0800
Message-Id: <20190212045721.28041-11-richard.henderson@linaro.org>
In-Reply-To: <20190212045721.28041-1-richard.henderson@linaro.org>
References: <20190212045721.28041-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 10/24] target/hppa: Convert conditional branches
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

Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c  | 221 +++++++++++++++++----------------------
 target/hppa/insns.decode |  30 ++++++
 2 files changed, 124 insertions(+), 127 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 2f4a50e113..7bdb900130 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -303,6 +303,13 @@ static int ma_to_m(int val)
     return val & 2 ? (val & 1 ? -1 : 1) : 0;
 }
 
+/* Used for branch targets.  */
+static int expand_shl2(int val)
+{
+    return val << 2;
+}
+
+
 /* Include the auto-generated decoder.  */
 #include "decode.inc.c"
 
@@ -870,14 +877,6 @@ static inline unsigned assemble_sr3(uint32_t insn)
     return s2 * 4 + s0;
 }
 
-static target_sreg assemble_12(uint32_t insn)
-{
-    target_ureg x = -(target_ureg)(insn & 1);
-    x = (x <<  1) | extract32(insn, 2, 1);
-    x = (x << 10) | extract32(insn, 3, 10);
-    return x;
-}
-
 static target_sreg assemble_16(uint32_t insn)
 {
     /* Take the name from PA2.0, which produces a 16-bit number
@@ -1773,7 +1772,7 @@ static void do_fop_dedd(DisasContext *ctx, unsigned rt,
 
 /* Emit an unconditional branch to a direct target, which may or may not
    have already had nullification handled.  */
-static void do_dbranch(DisasContext *ctx, target_ureg dest,
+static bool do_dbranch(DisasContext *ctx, target_ureg dest,
                        unsigned link, bool is_n)
 {
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
@@ -1805,11 +1804,12 @@ static void do_dbranch(DisasContext *ctx, target_ureg dest,
         gen_goto_tb(ctx, 1, ctx->iaoq_b, ctx->iaoq_n);
         ctx->base.is_jmp = DISAS_NORETURN;
     }
+    return true;
 }
 
 /* Emit a conditional branch to a direct target.  If the branch itself
    is nullified, we should have already used nullify_over.  */
-static void do_cbranch(DisasContext *ctx, target_sreg disp, bool is_n,
+static bool do_cbranch(DisasContext *ctx, target_sreg disp, bool is_n,
                        DisasCond *cond)
 {
     target_ureg dest = iaoq_dest(ctx, disp);
@@ -1821,12 +1821,10 @@ static void do_cbranch(DisasContext *ctx, target_sreg disp, bool is_n,
 
     /* Handle TRUE and NEVER as direct branches.  */
     if (c == TCG_COND_ALWAYS) {
-        do_dbranch(ctx, dest, 0, is_n && disp >= 0);
-        return;
+        return do_dbranch(ctx, dest, 0, is_n && disp >= 0);
     }
     if (c == TCG_COND_NEVER) {
-        do_dbranch(ctx, ctx->iaoq_n, 0, is_n && disp < 0);
-        return;
+        return do_dbranch(ctx, ctx->iaoq_n, 0, is_n && disp < 0);
     }
 
     taken = gen_new_label();
@@ -1873,11 +1871,12 @@ static void do_cbranch(DisasContext *ctx, target_sreg disp, bool is_n,
     } else {
         ctx->base.is_jmp = DISAS_NORETURN;
     }
+    return true;
 }
 
 /* Emit an unconditional branch to an indirect target.  This handles
    nullification of the branch itself.  */
-static void do_ibranch(DisasContext *ctx, TCGv_reg dest,
+static bool do_ibranch(DisasContext *ctx, TCGv_reg dest,
                        unsigned link, bool is_n)
 {
     TCGv_reg a0, a1, next, tmp;
@@ -1897,7 +1896,7 @@ static void do_ibranch(DisasContext *ctx, TCGv_reg dest,
                 tcg_gen_addi_reg(cpu_iaoq_b, next, 4);
                 nullify_set(ctx, 0);
                 ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
-                return;
+                return true;
             }
             ctx->null_cond.c = TCG_COND_ALWAYS;
         }
@@ -1924,7 +1923,7 @@ static void do_ibranch(DisasContext *ctx, TCGv_reg dest,
             tcg_gen_movi_reg(cpu_gr[link], ctx->iaoq_n);
         }
         tcg_gen_lookup_and_goto_ptr();
-        nullify_end(ctx);
+        return nullify_end(ctx);
     } else {
         cond_prep(&ctx->null_cond);
         c = ctx->null_cond.c;
@@ -1955,6 +1954,7 @@ static void do_ibranch(DisasContext *ctx, TCGv_reg dest,
             cond_free(&ctx->null_cond);
         }
     }
+    return true;
 }
 
 /* Implement
@@ -3154,24 +3154,12 @@ static bool trans_copr_dw(DisasContext *ctx, uint32_t insn)
     return true;
 }
 
-static bool trans_cmpb(DisasContext *ctx, uint32_t insn,
-                       bool is_true, bool is_imm, bool is_dw)
+static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_reg in1,
+                    unsigned c, unsigned f, unsigned n, int disp)
 {
-    target_sreg disp = assemble_12(insn) * 4;
-    unsigned n = extract32(insn, 1, 1);
-    unsigned c = extract32(insn, 13, 3);
-    unsigned r = extract32(insn, 21, 5);
-    unsigned cf = c * 2 + !is_true;
-    TCGv_reg dest, in1, in2, sv;
+    TCGv_reg dest, in2, sv;
     DisasCond cond;
 
-    nullify_over(ctx);
-
-    if (is_imm) {
-        in1 = load_const(ctx, low_sextract(insn, 16, 5));
-    } else {
-        in1 = load_gpr(ctx, extract32(insn, 16, 5));
-    }
     in2 = load_gpr(ctx, r);
     dest = get_temp(ctx);
 
@@ -3182,29 +3170,28 @@ static bool trans_cmpb(DisasContext *ctx, uint32_t insn,
         sv = do_sub_sv(ctx, dest, in1, in2);
     }
 
-    cond = do_sub_cond(cf, dest, in1, in2, sv);
-    do_cbranch(ctx, disp, n, &cond);
-    return true;
+    cond = do_sub_cond(c * 2 + f, dest, in1, in2, sv);
+    return do_cbranch(ctx, disp, n, &cond);
 }
 
-static bool trans_addb(DisasContext *ctx, uint32_t insn,
-                       bool is_true, bool is_imm)
+static bool trans_cmpb(DisasContext *ctx, arg_cmpb *a)
 {
-    target_sreg disp = assemble_12(insn) * 4;
-    unsigned n = extract32(insn, 1, 1);
-    unsigned c = extract32(insn, 13, 3);
-    unsigned r = extract32(insn, 21, 5);
-    unsigned cf = c * 2 + !is_true;
-    TCGv_reg dest, in1, in2, sv, cb_msb;
+    nullify_over(ctx);
+    return do_cmpb(ctx, a->r2, load_gpr(ctx, a->r1), a->c, a->f, a->n, a->disp);
+}
+
+static bool trans_cmpbi(DisasContext *ctx, arg_cmpbi *a)
+{
+    nullify_over(ctx);
+    return do_cmpb(ctx, a->r, load_const(ctx, a->i), a->c, a->f, a->n, a->disp);
+}
+
+static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
+                    unsigned c, unsigned f, unsigned n, int disp)
+{
+    TCGv_reg dest, in2, sv, cb_msb;
     DisasCond cond;
 
-    nullify_over(ctx);
-
-    if (is_imm) {
-        in1 = load_const(ctx, low_sextract(insn, 16, 5));
-    } else {
-        in1 = load_gpr(ctx, extract32(insn, 16, 5));
-    }
     in2 = load_gpr(ctx, r);
     dest = dest_gpr(ctx, r);
     sv = NULL;
@@ -3225,62 +3212,84 @@ static bool trans_addb(DisasContext *ctx, uint32_t insn,
         break;
     }
 
-    cond = do_cond(cf, dest, cb_msb, sv);
-    do_cbranch(ctx, disp, n, &cond);
-    return true;
+    cond = do_cond(c * 2 + f, dest, cb_msb, sv);
+    return do_cbranch(ctx, disp, n, &cond);
 }
 
-static bool trans_bb(DisasContext *ctx, uint32_t insn)
+static bool trans_addb(DisasContext *ctx, arg_addb *a)
+{
+    nullify_over(ctx);
+    return do_addb(ctx, a->r2, load_gpr(ctx, a->r1), a->c, a->f, a->n, a->disp);
+}
+
+static bool trans_addbi(DisasContext *ctx, arg_addbi *a)
+{
+    nullify_over(ctx);
+    return do_addb(ctx, a->r, load_const(ctx, a->i), a->c, a->f, a->n, a->disp);
+}
+
+static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
 {
-    target_sreg disp = assemble_12(insn) * 4;
-    unsigned n = extract32(insn, 1, 1);
-    unsigned c = extract32(insn, 15, 1);
-    unsigned r = extract32(insn, 16, 5);
-    unsigned p = extract32(insn, 21, 5);
-    unsigned i = extract32(insn, 26, 1);
     TCGv_reg tmp, tcg_r;
     DisasCond cond;
 
     nullify_over(ctx);
 
     tmp = tcg_temp_new();
-    tcg_r = load_gpr(ctx, r);
-    if (i) {
-        tcg_gen_shli_reg(tmp, tcg_r, p);
-    } else {
-        tcg_gen_shl_reg(tmp, tcg_r, cpu_sar);
-    }
+    tcg_r = load_gpr(ctx, a->r);
+    tcg_gen_shl_reg(tmp, tcg_r, cpu_sar);
 
-    cond = cond_make_0(c ? TCG_COND_GE : TCG_COND_LT, tmp);
+    cond = cond_make_0(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
     tcg_temp_free(tmp);
-    do_cbranch(ctx, disp, n, &cond);
-    return true;
+    return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
-static bool trans_movb(DisasContext *ctx, uint32_t insn, bool is_imm)
+static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
+{
+    TCGv_reg tmp, tcg_r;
+    DisasCond cond;
+
+    nullify_over(ctx);
+
+    tmp = tcg_temp_new();
+    tcg_r = load_gpr(ctx, a->r);
+    tcg_gen_shli_reg(tmp, tcg_r, a->p);
+
+    cond = cond_make_0(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
+    tcg_temp_free(tmp);
+    return do_cbranch(ctx, a->disp, a->n, &cond);
+}
+
+static bool trans_movb(DisasContext *ctx, arg_movb *a)
 {
-    target_sreg disp = assemble_12(insn) * 4;
-    unsigned n = extract32(insn, 1, 1);
-    unsigned c = extract32(insn, 13, 3);
-    unsigned t = extract32(insn, 16, 5);
-    unsigned r = extract32(insn, 21, 5);
     TCGv_reg dest;
     DisasCond cond;
 
     nullify_over(ctx);
 
-    dest = dest_gpr(ctx, r);
-    if (is_imm) {
-        tcg_gen_movi_reg(dest, low_sextract(t, 0, 5));
-    } else if (t == 0) {
+    dest = dest_gpr(ctx, a->r2);
+    if (a->r1 == 0) {
         tcg_gen_movi_reg(dest, 0);
     } else {
-        tcg_gen_mov_reg(dest, cpu_gr[t]);
+        tcg_gen_mov_reg(dest, cpu_gr[a->r1]);
     }
 
-    cond = do_sed_cond(c, dest);
-    do_cbranch(ctx, disp, n, &cond);
-    return true;
+    cond = do_sed_cond(a->c, dest);
+    return do_cbranch(ctx, a->disp, a->n, &cond);
+}
+
+static bool trans_movbi(DisasContext *ctx, arg_movbi *a)
+{
+    TCGv_reg dest;
+    DisasCond cond;
+
+    nullify_over(ctx);
+
+    dest = dest_gpr(ctx, a->r);
+    tcg_gen_movi_reg(dest, a->i);
+
+    cond = do_sed_cond(a->c, dest);
+    return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
 static bool trans_shrpw_sar(DisasContext *ctx, uint32_t insn,
@@ -3605,8 +3614,7 @@ static bool trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
        case of "be disp(*,r0)" using a direct branch to disp, so that we can
        goto_tb to the TB containing the syscall.  */
     if (b == 0) {
-        do_dbranch(ctx, disp, is_l ? 31 : 0, n);
-        return true;
+        return do_dbranch(ctx, disp, is_l ? 31 : 0, n);
     }
 #else
     int sp = assemble_sr3(insn);
@@ -3618,7 +3626,7 @@ static bool trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
     tmp = do_ibranch_priv(ctx, tmp);
 
 #ifdef CONFIG_USER_ONLY
-    do_ibranch(ctx, tmp, is_l ? 31 : 0, n);
+    return do_ibranch(ctx, tmp, is_l ? 31 : 0, n);
 #else
     TCGv_i64 new_spc = tcg_temp_new_i64();
 
@@ -3646,7 +3654,6 @@ static bool trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
     ctx->base.is_jmp = DISAS_NORETURN;
     return nullify_end(ctx);
 #endif
-    return true;
 }
 
 static bool trans_bl(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
@@ -4452,39 +4459,12 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
         trans_store_w(ctx, insn);
         return;
 
-    case 0x20:
-        trans_cmpb(ctx, insn, true, false, false);
-        return;
-    case 0x21:
-        trans_cmpb(ctx, insn, true, true, false);
-        return;
-    case 0x22:
-        trans_cmpb(ctx, insn, false, false, false);
-        return;
-    case 0x23:
-        trans_cmpb(ctx, insn, false, true, false);
-        return;
     case 0x24:
         trans_cmpiclr(ctx, insn);
         return;
     case 0x25:
         trans_subi(ctx, insn);
         return;
-    case 0x27:
-        trans_cmpb(ctx, insn, true, false, true);
-        return;
-    case 0x28:
-        trans_addb(ctx, insn, true, false);
-        return;
-    case 0x29:
-        trans_addb(ctx, insn, true, true);
-        return;
-    case 0x2A:
-        trans_addb(ctx, insn, false, false);
-        return;
-    case 0x2B:
-        trans_addb(ctx, insn, false, true);
-        return;
     case 0x2C:
     case 0x2D:
         trans_addi(ctx, insn);
@@ -4492,20 +4472,7 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
     case 0x2E:
         translate_table(ctx, insn, table_fp_fused);
         return;
-    case 0x2F:
-        trans_cmpb(ctx, insn, false, false, true);
-        return;
 
-    case 0x30:
-    case 0x31:
-        trans_bb(ctx, insn);
-        return;
-    case 0x32:
-        trans_movb(ctx, insn, false);
-        return;
-    case 0x33:
-        trans_movb(ctx, insn, true);
-        return;
     case 0x34:
         translate_table(ctx, insn, table_sh_ex);
         return;
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 16a999b05f..e891fbfac5 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -24,6 +24,8 @@
 %assemble_sr3   13:1 14:2
 %assemble_sr3x  13:1 14:2 !function=expand_sr3x
 
+%assemble_12    0:s1 2:1 3:10  !function=expand_shl2
+
 %sm_imm         16:10 !function=expand_sm_imm
 
 %im5_0          0:s1 1:4
@@ -41,6 +43,9 @@
 &rrr_cf         t r1 r2 cf
 &rrr_cf_sh      t r1 r2 cf sh
 
+&rrb_c_f        disp n c f r1 r2
+&rib_c_f        disp n c f r i
+
 ####
 # Format definitions
 ####
@@ -50,6 +55,11 @@
 @rrr_cf_sh      ...... r2:5 r1:5 cf:4 .... sh:2 . t:5   &rrr_cf_sh
 @rrr_cf_sh0     ...... r2:5 r1:5 cf:4 ....... t:5       &rrr_cf_sh sh=0
 
+@rrb_cf         ...... r2:5 r1:5 c:3 ........... n:1 .  \
+                &rrb_c_f disp=%assemble_12
+@rib_cf         ...... r:5 ..... c:3 ........... n:1 .  \
+                &rib_c_f disp=%assemble_12 i=%im5_16
+
 ####
 # System
 ####
@@ -165,3 +175,23 @@ fmpyadd_f       000110 ..... ..... ..... ..... 0 .....  @mpyadd
 fmpyadd_d       000110 ..... ..... ..... ..... 1 .....  @mpyadd
 fmpysub_f       100110 ..... ..... ..... ..... 0 .....  @mpyadd
 fmpysub_d       100110 ..... ..... ..... ..... 1 .....  @mpyadd
+
+####
+# Conditional Branches
+####
+
+bb_sar          110000 00000 r:5 c:1 10 ........... n:1 .  disp=%assemble_12
+bb_imm          110001 p:5   r:5 c:1 10 ........... n:1 .  disp=%assemble_12
+
+movb            110010 ..... ..... ... ........... . .  @rrb_cf f=0
+movbi           110011 ..... ..... ... ........... . .  @rib_cf f=0
+
+cmpb            100000 ..... ..... ... ........... . .  @rrb_cf f=0
+cmpb            100010 ..... ..... ... ........... . .  @rrb_cf f=1
+cmpbi           100001 ..... ..... ... ........... . .  @rib_cf f=0
+cmpbi           100011 ..... ..... ... ........... . .  @rib_cf f=1
+
+addb            101000 ..... ..... ... ........... . .  @rrb_cf f=0
+addb            101010 ..... ..... ... ........... . .  @rrb_cf f=1
+addbi           101001 ..... ..... ... ........... . .  @rib_cf f=0
+addbi           101011 ..... ..... ... ........... . .  @rib_cf f=1
-- 
2.17.2
