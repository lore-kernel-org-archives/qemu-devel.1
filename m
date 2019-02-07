Received: from eggs.gnu.org ([209.51.188.92]:58220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griG0-0007FT-2j
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griFy-0001RC-4J
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:16 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1griFx-0001QZ-PH
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:14 -0500
Received: by mail-wr1-x442.google.com with SMTP id a16so11268079wrv.0
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 03:54:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Feb 2019 11:53:48 +0000
Message-Id: <20190207115400.647-8-richard.henderson@linaro.org>
In-Reply-To: <20190207115400.647-1-richard.henderson@linaro.org>
References: <20190207115400.647-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 07/19] target/hppa: Convert arithmetic/logical
 insns
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
 target/hppa/translate.c  | 326 ++++++++++++++++++---------------------
 target/hppa/insns.decode |  42 +++++
 2 files changed, 195 insertions(+), 173 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 961b890153..6c7d301904 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1217,6 +1217,20 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     ctx->null_cond = cond;
 }
 
+static bool do_add_reg(DisasContext *ctx, arg_rrr_cf_sh *a,
+                       bool is_l, bool is_tsv, bool is_tc, bool is_c)
+{
+    TCGv_reg tcg_r1, tcg_r2;
+
+    if (a->cf) {
+        nullify_over(ctx);
+    }
+    tcg_r1 = load_gpr(ctx, a->r1);
+    tcg_r2 = load_gpr(ctx, a->r2);
+    do_add(ctx, a->t, tcg_r1, tcg_r2, a->sh, is_l, is_tsv, is_tc, is_c, a->cf);
+    return nullify_end(ctx);
+}
+
 static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
                    TCGv_reg in2, bool is_tsv, bool is_b,
                    bool is_tc, unsigned cf)
@@ -1283,6 +1297,20 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     ctx->null_cond = cond;
 }
 
+static bool do_sub_reg(DisasContext *ctx, arg_rrr_cf *a,
+                       bool is_tsv, bool is_b, bool is_tc)
+{
+    TCGv_reg tcg_r1, tcg_r2;
+
+    if (a->cf) {
+        nullify_over(ctx);
+    }
+    tcg_r1 = load_gpr(ctx, a->r1);
+    tcg_r2 = load_gpr(ctx, a->r2);
+    do_sub(ctx, a->t, tcg_r1, tcg_r2, is_tsv, is_b, is_tc, a->cf);
+    return nullify_end(ctx);
+}
+
 static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
                       TCGv_reg in2, unsigned cf)
 {
@@ -1328,6 +1356,20 @@ static void do_log(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     }
 }
 
+static bool do_log_reg(DisasContext *ctx, arg_rrr_cf *a,
+                       void (*fn)(TCGv_reg, TCGv_reg, TCGv_reg))
+{
+    TCGv_reg tcg_r1, tcg_r2;
+
+    if (a->cf) {
+        nullify_over(ctx);
+    }
+    tcg_r1 = load_gpr(ctx, a->r1);
+    tcg_r2 = load_gpr(ctx, a->r2);
+    do_log(ctx, a->t, tcg_r1, tcg_r2, a->cf, fn);
+    return nullify_end(ctx);
+}
+
 static void do_unit(DisasContext *ctx, unsigned rt, TCGv_reg in1,
                     TCGv_reg in2, unsigned cf, bool is_tc,
                     void (*fn)(TCGv_reg, TCGv_reg, TCGv_reg))
@@ -2463,117 +2505,78 @@ static bool trans_lci(DisasContext *ctx, arg_lci *a)
     return true;
 }
 
-static bool trans_add(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_add(DisasContext *ctx, arg_rrr_cf_sh *a)
 {
-    unsigned r2 = extract32(insn, 21, 5);
-    unsigned r1 = extract32(insn, 16, 5);
-    unsigned cf = extract32(insn, 12, 4);
-    unsigned ext = extract32(insn, 8, 4);
-    unsigned shift = extract32(insn, 6, 2);
-    unsigned rt = extract32(insn,  0, 5);
-    TCGv_reg tcg_r1, tcg_r2;
-    bool is_c = false;
-    bool is_l = false;
-    bool is_tc = false;
-    bool is_tsv = false;
-
-    switch (ext) {
-    case 0x6: /* ADD, SHLADD */
-        break;
-    case 0xa: /* ADD,L, SHLADD,L */
-        is_l = true;
-        break;
-    case 0xe: /* ADD,TSV, SHLADD,TSV (1) */
-        is_tsv = true;
-        break;
-    case 0x7: /* ADD,C */
-        is_c = true;
-        break;
-    case 0xf: /* ADD,C,TSV */
-        is_c = is_tsv = true;
-        break;
-    default:
-        return gen_illegal(ctx);
-    }
-
-    if (cf) {
-        nullify_over(ctx);
-    }
-    tcg_r1 = load_gpr(ctx, r1);
-    tcg_r2 = load_gpr(ctx, r2);
-    do_add(ctx, rt, tcg_r1, tcg_r2, shift, is_l, is_tsv, is_tc, is_c, cf);
-    return nullify_end(ctx);
+    return do_add_reg(ctx, a, false, false, false, false);
 }
 
-static bool trans_sub(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_add_l(DisasContext *ctx, arg_rrr_cf_sh *a)
 {
-    unsigned r2 = extract32(insn, 21, 5);
-    unsigned r1 = extract32(insn, 16, 5);
-    unsigned cf = extract32(insn, 12, 4);
-    unsigned ext = extract32(insn, 6, 6);
-    unsigned rt = extract32(insn,  0, 5);
-    TCGv_reg tcg_r1, tcg_r2;
-    bool is_b = false;
-    bool is_tc = false;
-    bool is_tsv = false;
-
-    switch (ext) {
-    case 0x10: /* SUB */
-        break;
-    case 0x30: /* SUB,TSV */
-        is_tsv = true;
-        break;
-    case 0x14: /* SUB,B */
-        is_b = true;
-        break;
-    case 0x34: /* SUB,B,TSV */
-        is_b = is_tsv = true;
-        break;
-    case 0x13: /* SUB,TC */
-        is_tc = true;
-        break;
-    case 0x33: /* SUB,TSV,TC */
-        is_tc = is_tsv = true;
-        break;
-    default:
-        return gen_illegal(ctx);
-    }
-
-    if (cf) {
-        nullify_over(ctx);
-    }
-    tcg_r1 = load_gpr(ctx, r1);
-    tcg_r2 = load_gpr(ctx, r2);
-    do_sub(ctx, rt, tcg_r1, tcg_r2, is_tsv, is_b, is_tc, cf);
-    return nullify_end(ctx);
+    return do_add_reg(ctx, a, true, false, false, false);
 }
 
-static bool trans_log(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_add_tsv(DisasContext *ctx, arg_rrr_cf_sh *a)
 {
-    unsigned r2 = extract32(insn, 21, 5);
-    unsigned r1 = extract32(insn, 16, 5);
-    unsigned cf = extract32(insn, 12, 4);
-    unsigned rt = extract32(insn,  0, 5);
-    TCGv_reg tcg_r1, tcg_r2;
-
-    if (cf) {
-        nullify_over(ctx);
-    }
-    tcg_r1 = load_gpr(ctx, r1);
-    tcg_r2 = load_gpr(ctx, r2);
-    do_log(ctx, rt, tcg_r1, tcg_r2, cf, di->f.ttt);
-    return nullify_end(ctx);
+    return do_add_reg(ctx, a, false, true, false, false);
 }
 
-static bool trans_or(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_add_c(DisasContext *ctx, arg_rrr_cf_sh *a)
 {
-    unsigned r2 = extract32(insn, 21, 5);
-    unsigned r1 = extract32(insn, 16, 5);
-    unsigned cf = extract32(insn, 12, 4);
-    unsigned rt = extract32(insn,  0, 5);
-    TCGv_reg tcg_r1, tcg_r2;
+    return do_add_reg(ctx, a, false, false, false, true);
+}
+
+static bool trans_add_c_tsv(DisasContext *ctx, arg_rrr_cf_sh *a)
+{
+    return do_add_reg(ctx, a, false, true, false, true);
+}
+
+static bool trans_sub(DisasContext *ctx, arg_rrr_cf *a)
+{
+    return do_sub_reg(ctx, a, false, false, false);
+}
+
+static bool trans_sub_tsv(DisasContext *ctx, arg_rrr_cf *a)
+{
+    return do_sub_reg(ctx, a, true, false, false);
+}
+
+static bool trans_sub_tc(DisasContext *ctx, arg_rrr_cf *a)
+{
+    return do_sub_reg(ctx, a, false, false, true);
+}
+
+static bool trans_sub_tsv_tc(DisasContext *ctx, arg_rrr_cf *a)
+{
+    return do_sub_reg(ctx, a, true, false, true);
+}
+
+static bool trans_sub_b(DisasContext *ctx, arg_rrr_cf *a)
+{
+    return do_sub_reg(ctx, a, false, true, false);
+}
+
+static bool trans_sub_b_tsv(DisasContext *ctx, arg_rrr_cf *a)
+{
+    return do_sub_reg(ctx, a, true, true, false);
+}
+
+static bool trans_andcm(DisasContext *ctx, arg_rrr_cf *a)
+{
+    return do_log_reg(ctx, a, tcg_gen_andc_reg);
+}
+
+static bool trans_and(DisasContext *ctx, arg_rrr_cf *a)
+{
+    return do_log_reg(ctx, a, tcg_gen_and_reg);
+}
+
+static bool trans_or(DisasContext *ctx, arg_rrr_cf *a)
+{
+    if (a->cf == 0) {
+        unsigned r2 = a->r2;
+        unsigned r1 = a->r1;
+        unsigned rt = a->t;
 
-    if (cf == 0) {
         if (rt == 0) { /* NOP */
             cond_free(&ctx->null_cond);
             return true;
@@ -2620,76 +2623,67 @@ static bool trans_or(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
         }
 #endif
     }
-
-    if (cf) {
-        nullify_over(ctx);
-    }
-    tcg_r1 = load_gpr(ctx, r1);
-    tcg_r2 = load_gpr(ctx, r2);
-    do_log(ctx, rt, tcg_r1, tcg_r2, cf, tcg_gen_or_reg);
-    return nullify_end(ctx);
+    return do_log_reg(ctx, a, tcg_gen_or_reg);
 }
 
-static bool trans_cmpclr(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_xor(DisasContext *ctx, arg_rrr_cf *a)
+{
+    return do_log_reg(ctx, a, tcg_gen_xor_reg);
+}
+
+static bool trans_cmpclr(DisasContext *ctx, arg_rrr_cf *a)
 {
-    unsigned r2 = extract32(insn, 21, 5);
-    unsigned r1 = extract32(insn, 16, 5);
-    unsigned cf = extract32(insn, 12, 4);
-    unsigned rt = extract32(insn,  0, 5);
     TCGv_reg tcg_r1, tcg_r2;
 
-    if (cf) {
+    if (a->cf) {
         nullify_over(ctx);
     }
-    tcg_r1 = load_gpr(ctx, r1);
-    tcg_r2 = load_gpr(ctx, r2);
-    do_cmpclr(ctx, rt, tcg_r1, tcg_r2, cf);
+    tcg_r1 = load_gpr(ctx, a->r1);
+    tcg_r2 = load_gpr(ctx, a->r2);
+    do_cmpclr(ctx, a->t, tcg_r1, tcg_r2, a->cf);
     return nullify_end(ctx);
 }
 
-static bool trans_uxor(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_uxor(DisasContext *ctx, arg_rrr_cf *a)
 {
-    unsigned r2 = extract32(insn, 21, 5);
-    unsigned r1 = extract32(insn, 16, 5);
-    unsigned cf = extract32(insn, 12, 4);
-    unsigned rt = extract32(insn,  0, 5);
     TCGv_reg tcg_r1, tcg_r2;
 
-    if (cf) {
+    if (a->cf) {
         nullify_over(ctx);
     }
-    tcg_r1 = load_gpr(ctx, r1);
-    tcg_r2 = load_gpr(ctx, r2);
-    do_unit(ctx, rt, tcg_r1, tcg_r2, cf, false, tcg_gen_xor_reg);
+    tcg_r1 = load_gpr(ctx, a->r1);
+    tcg_r2 = load_gpr(ctx, a->r2);
+    do_unit(ctx, a->t, tcg_r1, tcg_r2, a->cf, false, tcg_gen_xor_reg);
     return nullify_end(ctx);
 }
 
-static bool trans_uaddcm(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool do_uaddcm(DisasContext *ctx, arg_rrr_cf *a, bool is_tc)
 {
-    unsigned r2 = extract32(insn, 21, 5);
-    unsigned r1 = extract32(insn, 16, 5);
-    unsigned cf = extract32(insn, 12, 4);
-    unsigned is_tc = extract32(insn, 6, 1);
-    unsigned rt = extract32(insn,  0, 5);
     TCGv_reg tcg_r1, tcg_r2, tmp;
 
-    if (cf) {
+    if (a->cf) {
         nullify_over(ctx);
     }
-    tcg_r1 = load_gpr(ctx, r1);
-    tcg_r2 = load_gpr(ctx, r2);
+    tcg_r1 = load_gpr(ctx, a->r1);
+    tcg_r2 = load_gpr(ctx, a->r2);
     tmp = get_temp(ctx);
     tcg_gen_not_reg(tmp, tcg_r2);
-    do_unit(ctx, rt, tcg_r1, tmp, cf, is_tc, tcg_gen_add_reg);
+    do_unit(ctx, a->t, tcg_r1, tmp, a->cf, is_tc, tcg_gen_add_reg);
     return nullify_end(ctx);
 }
 
-static bool trans_dcor(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_uaddcm(DisasContext *ctx, arg_rrr_cf *a)
+{
+    return do_uaddcm(ctx, a, false);
+}
+
+static bool trans_uaddcm_tc(DisasContext *ctx, arg_rrr_cf *a)
+{
+    return do_uaddcm(ctx, a, true);
+}
+
+static bool do_dcor(DisasContext *ctx, arg_rr_cf *a, bool is_i)
 {
-    unsigned r2 = extract32(insn, 21, 5);
-    unsigned cf = extract32(insn, 12, 4);
-    unsigned is_i = extract32(insn, 6, 1);
-    unsigned rt = extract32(insn,  0, 5);
     TCGv_reg tmp;
 
     nullify_over(ctx);
@@ -2701,24 +2695,29 @@ static bool trans_dcor(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     }
     tcg_gen_andi_reg(tmp, tmp, 0x11111111);
     tcg_gen_muli_reg(tmp, tmp, 6);
-    do_unit(ctx, rt, tmp, load_gpr(ctx, r2), cf, false,
+    do_unit(ctx, a->t, tmp, load_gpr(ctx, a->r), a->cf, false,
             is_i ? tcg_gen_add_reg : tcg_gen_sub_reg);
-
     return nullify_end(ctx);
 }
 
-static bool trans_ds(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_dcor(DisasContext *ctx, arg_rr_cf *a)
+{
+    return do_dcor(ctx, a, false);
+}
+
+static bool trans_dcor_i(DisasContext *ctx, arg_rr_cf *a)
+{
+    return do_dcor(ctx, a, true);
+}
+
+static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
 {
-    unsigned r2 = extract32(insn, 21, 5);
-    unsigned r1 = extract32(insn, 16, 5);
-    unsigned cf = extract32(insn, 12, 4);
-    unsigned rt = extract32(insn,  0, 5);
     TCGv_reg dest, add1, add2, addc, zero, in1, in2;
 
     nullify_over(ctx);
 
-    in1 = load_gpr(ctx, r1);
-    in2 = load_gpr(ctx, r2);
+    in1 = load_gpr(ctx, a->r1);
+    in2 = load_gpr(ctx, a->r2);
 
     add1 = tcg_temp_new();
     add2 = tcg_temp_new();
@@ -2745,7 +2744,7 @@ static bool trans_ds(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     tcg_temp_free(zero);
 
     /* Write back the result register.  */
-    save_gpr(ctx, rt, dest);
+    save_gpr(ctx, a->t, dest);
 
     /* Write back PSW[CB].  */
     tcg_gen_xor_reg(cpu_psw_cb, add1, add2);
@@ -2756,13 +2755,13 @@ static bool trans_ds(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     tcg_gen_xor_reg(cpu_psw_v, cpu_psw_v, in2);
 
     /* Install the new nullification.  */
-    if (cf) {
+    if (a->cf) {
         TCGv_reg sv = NULL;
-        if (cf >> 1 == 6) {
+        if (a->cf >> 1 == 6) {
             /* ??? The lshift is supposed to contribute to overflow.  */
             sv = do_add_sv(ctx, dest, add1, add2);
         }
-        ctx->null_cond = do_cond(cf, dest, cpu_psw_cb_msb, sv);
+        ctx->null_cond = do_cond(a->cf, dest, cpu_psw_cb_msb, sv);
     }
 
     tcg_temp_free(add1);
@@ -2772,22 +2771,6 @@ static bool trans_ds(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     return nullify_end(ctx);
 }
 
-static const DisasInsn table_arith_log[] = {
-    { 0x08000240u, 0xfc000fe0u, trans_or },
-    { 0x08000000u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_andc_reg },
-    { 0x08000200u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_and_reg },
-    { 0x08000280u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_xor_reg },
-    { 0x08000880u, 0xfc000fe0u, trans_cmpclr },
-    { 0x08000380u, 0xfc000fe0u, trans_uxor },
-    { 0x08000980u, 0xfc000fa0u, trans_uaddcm },
-    { 0x08000b80u, 0xfc1f0fa0u, trans_dcor },
-    { 0x08000440u, 0xfc000fe0u, trans_ds },
-    { 0x08000700u, 0xfc0007e0u, trans_add }, /* add */
-    { 0x08000400u, 0xfc0006e0u, trans_sub }, /* sub; sub,b; sub,tsv */
-    { 0x080004c0u, 0xfc0007e0u, trans_sub }, /* sub,tc; sub,tsv,tc */
-    { 0x08000200u, 0xfc000320u, trans_add }, /* shladd */
-};
-
 static bool trans_addi(DisasContext *ctx, uint32_t insn)
 {
     target_sreg im = low_sextract(insn, 0, 11);
@@ -4487,9 +4470,6 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
 
     opc = extract32(insn, 26, 6);
     switch (opc) {
-    case 0x02:
-        translate_table(ctx, insn, table_arith_log);
-        return;
     case 0x03:
         translate_table(ctx, insn, table_index_mem);
         return;
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 41c999eeb8..a576bb1d4d 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -33,6 +33,19 @@
 # All insns that need to form a virtual address should use this set.
 &ldst           t b x disp sp m scale size
 
+&rr_cf          t r cf
+&rrr_cf         t r1 r2 cf
+&rrr_cf_sh      t r1 r2 cf sh
+
+####
+# Format definitions
+####
+
+@rr_cf          ...... r:5 ..... cf:4 ....... t:5       &rr_cf
+@rrr_cf         ...... r2:5 r1:5 cf:4 ....... t:5       &rrr_cf
+@rrr_cf_sh      ...... r2:5 r1:5 cf:4 .... sh:2 . t:5   &rrr_cf_sh
+@rrr_cf_sh0     ...... r2:5 r1:5 cf:4 ....... t:5       &rrr_cf_sh sh=0
+
 ####
 # System
 ####
@@ -87,3 +100,32 @@ lpa             000001 b:5 x:5 sp:2 01001101 m:1 t:5    \
                 &ldst disp=0 scale=0 size=0
 
 lci             000001 ----- ----- -- 01001100 0 t:5
+
+####
+# Arith/Log
+####
+
+andcm           000010 ..... ..... .... 000000 0 .....  @rrr_cf
+and             000010 ..... ..... .... 001000 0 .....  @rrr_cf
+or              000010 ..... ..... .... 001001 0 .....  @rrr_cf
+xor             000010 ..... ..... .... 001010 0 .....  @rrr_cf
+uxor            000010 ..... ..... .... 001110 0 .....  @rrr_cf
+ds              000010 ..... ..... .... 010001 0 .....  @rrr_cf
+cmpclr          000010 ..... ..... .... 100010 0 .....  @rrr_cf
+uaddcm          000010 ..... ..... .... 100110 0 .....  @rrr_cf
+uaddcm_tc       000010 ..... ..... .... 100111 0 .....  @rrr_cf
+dcor            000010 ..... 00000 .... 101110 0 .....  @rr_cf
+dcor_i          000010 ..... 00000 .... 101111 0 .....  @rr_cf
+
+add             000010 ..... ..... .... 0110.. 0 .....  @rrr_cf_sh
+add_l           000010 ..... ..... .... 1010.. 0 .....  @rrr_cf_sh
+add_tsv         000010 ..... ..... .... 1110.. 0 .....  @rrr_cf_sh
+add_c           000010 ..... ..... .... 011100 0 .....  @rrr_cf_sh0
+add_c_tsv       000010 ..... ..... .... 111100 0 .....  @rrr_cf_sh0
+
+sub             000010 ..... ..... .... 010000 0 .....  @rrr_cf
+sub_tsv         000010 ..... ..... .... 110000 0 .....  @rrr_cf
+sub_tc          000010 ..... ..... .... 010011 0 .....  @rrr_cf
+sub_tsv_tc      000010 ..... ..... .... 110011 0 .....  @rrr_cf
+sub_b           000010 ..... ..... .... 010100 0 .....  @rrr_cf
+sub_b_tsv       000010 ..... ..... .... 110100 0 .....  @rrr_cf
-- 
2.17.2
