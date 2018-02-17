Received: from eggs.gnu.org ([2001:4830:134:3::10]:42009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en99M-0000HL-B9
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en99K-0000pL-Sk
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:32:00 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:46280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en99K-0000p5-KG
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:31:58 -0500
Received: by mail-pf0-x241.google.com with SMTP id z24so654787pfh.13
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 12:31:58 -0800 (PST)
Received: from cloudburst.twiddle.net ([50.0.192.64])
	by smtp.gmail.com with ESMTPSA id
	y7sm48203797pfe.26.2018.02.17.12.31.55 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 17 Feb 2018 12:31:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 12:31:26 -0800
Message-Id: <20180217203132.31780-14-richard.henderson@linaro.org>
In-Reply-To: <20180217203132.31780-1-richard.henderson@linaro.org>
References: <20180217203132.31780-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 13/19] target/hppa: Convert arithmetic
 immediate insns
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
 target/hppa/translate.c  | 168 +++++++++++++++++++++--------------------------
 target/hppa/insns.decode |  21 ++++++
 2 files changed, 96 insertions(+), 93 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 5df5b8dba4..51bd9016ab 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -321,6 +321,12 @@ static int expand_shl2(int val)
     return val << 2;
 }
 
+/* Used for assemble_21.  */
+static int expand_shl11(int val)
+{
+    return val << 11;
+}
+
 
 /* Include the auto-generated decoder.  */
 #include "decode.inc.c"
@@ -901,16 +907,6 @@ static target_sreg assemble_16a(uint32_t insn)
     return x << 2;
 }
 
-static target_sreg assemble_21(uint32_t insn)
-{
-    target_ureg x = -(target_ureg)(insn & 1);
-    x = (x << 11) | extract32(insn, 1, 11);
-    x = (x <<  2) | extract32(insn, 14, 2);
-    x = (x <<  5) | extract32(insn, 16, 5);
-    x = (x <<  2) | extract32(insn, 12, 2);
-    return x << 11;
-}
-
 /* The parisc documentation describes only the general interpretation of
    the conditions, without describing their exact implementation.  The
    interpretations do not stand up well when considering ADD,C and SUB,B.
@@ -1225,6 +1221,20 @@ static void do_add_reg(DisasContext *ctx, arg_rrr_cf_sh *a,
     nullify_end(ctx);
 }
 
+static void do_add_imm(DisasContext *ctx, arg_rri_cf *a,
+                       bool is_tsv, bool is_tc)
+{
+    TCGv_reg tcg_im, tcg_r2;
+
+    if (a->cf) {
+        nullify_over(ctx);
+    }
+    tcg_im = load_const(ctx, a->i);
+    tcg_r2 = load_gpr(ctx, a->r);
+    do_add(ctx, a->t, tcg_im, tcg_r2, 0, 0, is_tsv, is_tc, 0, a->cf);
+    nullify_end(ctx);
+}
+
 static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
                    TCGv_reg in2, bool is_tsv, bool is_b,
                    bool is_tc, unsigned cf)
@@ -1305,6 +1315,19 @@ static void do_sub_reg(DisasContext *ctx, arg_rrr_cf *a,
     nullify_end(ctx);
 }
 
+static void do_sub_imm(DisasContext *ctx, arg_rri_cf *a, bool is_tsv)
+{
+    TCGv_reg tcg_im, tcg_r2;
+
+    if (a->cf) {
+        nullify_over(ctx);
+    }
+    tcg_im = load_const(ctx, a->i);
+    tcg_r2 = load_gpr(ctx, a->r);
+    do_sub(ctx, a->t, tcg_im, tcg_r2, is_tsv, 0, 0, a->cf);
+    nullify_end(ctx);
+}
+
 static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
                       TCGv_reg in2, unsigned cf)
 {
@@ -2770,62 +2793,47 @@ static void trans_ds(DisasContext *ctx, arg_rrr_cf *a, uint32_t insn)
     nullify_end(ctx);
 }
 
-static void trans_addi(DisasContext *ctx, uint32_t insn)
+static void trans_addi(DisasContext *ctx, arg_rri_cf *a, uint32_t insn)
 {
-    target_sreg im = low_sextract(insn, 0, 11);
-    unsigned e1 = extract32(insn, 11, 1);
-    unsigned cf = extract32(insn, 12, 4);
-    unsigned rt = extract32(insn, 16, 5);
-    unsigned r2 = extract32(insn, 21, 5);
-    unsigned o1 = extract32(insn, 26, 1);
-    TCGv_reg tcg_im, tcg_r2;
-
-    if (cf) {
-        nullify_over(ctx);
-    }
-
-    tcg_im = load_const(ctx, im);
-    tcg_r2 = load_gpr(ctx, r2);
-    do_add(ctx, rt, tcg_im, tcg_r2, 0, false, e1, !o1, false, cf);
-
-    nullify_end(ctx);
+    do_add_imm(ctx, a, false, false);
 }
 
-static void trans_subi(DisasContext *ctx, uint32_t insn)
+static void trans_addi_tsv(DisasContext *ctx, arg_rri_cf *a, uint32_t insn)
 {
-    target_sreg im = low_sextract(insn, 0, 11);
-    unsigned e1 = extract32(insn, 11, 1);
-    unsigned cf = extract32(insn, 12, 4);
-    unsigned rt = extract32(insn, 16, 5);
-    unsigned r2 = extract32(insn, 21, 5);
-    TCGv_reg tcg_im, tcg_r2;
-
-    if (cf) {
-        nullify_over(ctx);
-    }
-
-    tcg_im = load_const(ctx, im);
-    tcg_r2 = load_gpr(ctx, r2);
-    do_sub(ctx, rt, tcg_im, tcg_r2, e1, false, false, cf);
-
-    nullify_end(ctx);
+    do_add_imm(ctx, a, true, false);
 }
 
-static void trans_cmpiclr(DisasContext *ctx, uint32_t insn)
+static void trans_addi_tc(DisasContext *ctx, arg_rri_cf *a, uint32_t insn)
+{
+    do_add_imm(ctx, a, false, true);
+}
+
+static void trans_addi_tc_tsv(DisasContext *ctx, arg_rri_cf *a, uint32_t insn)
+{
+    do_add_imm(ctx, a, true, true);
+}
+
+static void trans_subi(DisasContext *ctx, arg_rri_cf *a, uint32_t insn)
+{
+    do_sub_imm(ctx, a, false);
+}
+
+static void trans_subi_tsv(DisasContext *ctx, arg_rri_cf *a, uint32_t insn)
+{
+    do_sub_imm(ctx, a, true);
+}
+
+static void trans_cmpiclr(DisasContext *ctx, arg_rri_cf *a, uint32_t insn)
 {
-    target_sreg im = low_sextract(insn, 0, 11);
-    unsigned cf = extract32(insn, 12, 4);
-    unsigned rt = extract32(insn, 16, 5);
-    unsigned r2 = extract32(insn, 21, 5);
     TCGv_reg tcg_im, tcg_r2;
 
-    if (cf) {
+    if (a->cf) {
         nullify_over(ctx);
     }
 
-    tcg_im = load_const(ctx, im);
-    tcg_r2 = load_gpr(ctx, r2);
-    do_cmpclr(ctx, rt, tcg_im, tcg_r2, cf);
+    tcg_im = load_const(ctx, a->i);
+    tcg_r2 = load_gpr(ctx, a->r);
+    do_cmpclr(ctx, a->t, tcg_im, tcg_r2, a->cf);
 
     nullify_end(ctx);
 }
@@ -2921,44 +2929,37 @@ static void trans_sta(DisasContext *ctx, arg_ldst *a, uint32_t insn)
     ctx->mmu_idx = hold_mmu_idx;
 }
 
-static void trans_ldil(DisasContext *ctx, uint32_t insn)
+static void trans_ldil(DisasContext *ctx, arg_ldil *a, uint32_t insn)
 {
-    unsigned rt = extract32(insn, 21, 5);
-    target_sreg i = assemble_21(insn);
-    TCGv_reg tcg_rt = dest_gpr(ctx, rt);
+    TCGv_reg tcg_rt = dest_gpr(ctx, a->t);
 
-    tcg_gen_movi_reg(tcg_rt, i);
-    save_gpr(ctx, rt, tcg_rt);
+    tcg_gen_movi_reg(tcg_rt, a->i);
+    save_gpr(ctx, a->t, tcg_rt);
     cond_free(&ctx->null_cond);
 }
 
-static void trans_addil(DisasContext *ctx, uint32_t insn)
+static void trans_addil(DisasContext *ctx, arg_addil *a, uint32_t insn)
 {
-    unsigned rt = extract32(insn, 21, 5);
-    target_sreg i = assemble_21(insn);
-    TCGv_reg tcg_rt = load_gpr(ctx, rt);
+    TCGv_reg tcg_rt = load_gpr(ctx, a->r);
     TCGv_reg tcg_r1 = dest_gpr(ctx, 1);
 
-    tcg_gen_addi_reg(tcg_r1, tcg_rt, i);
+    tcg_gen_addi_reg(tcg_r1, tcg_rt, a->i);
     save_gpr(ctx, 1, tcg_r1);
     cond_free(&ctx->null_cond);
 }
 
-static void trans_ldo(DisasContext *ctx, uint32_t insn)
+static void trans_ldo(DisasContext *ctx, arg_ldo *a, uint32_t insn)
 {
-    unsigned rb = extract32(insn, 21, 5);
-    unsigned rt = extract32(insn, 16, 5);
-    target_sreg i = assemble_16(insn);
-    TCGv_reg tcg_rt = dest_gpr(ctx, rt);
+    TCGv_reg tcg_rt = dest_gpr(ctx, a->t);
 
     /* Special case rb == 0, for the LDI pseudo-op.
        The COPY pseudo-op is handled for free within tcg_gen_addi_tl.  */
-    if (rb == 0) {
-        tcg_gen_movi_reg(tcg_rt, i);
+    if (a->b == 0) {
+        tcg_gen_movi_reg(tcg_rt, a->i);
     } else {
-        tcg_gen_addi_reg(tcg_rt, cpu_gr[rb], i);
+        tcg_gen_addi_reg(tcg_rt, cpu_gr[a->b], a->i);
     }
-    save_gpr(ctx, rt, tcg_rt);
+    save_gpr(ctx, a->t, tcg_rt);
     cond_free(&ctx->null_cond);
 }
 
@@ -4280,24 +4281,15 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
 
     opc = extract32(insn, 26, 6);
     switch (opc) {
-    case 0x08:
-        trans_ldil(ctx, insn);
-        return;
     case 0x09:
         trans_copr_w(ctx, insn);
         return;
-    case 0x0A:
-        trans_addil(ctx, insn);
-        return;
     case 0x0B:
         trans_copr_dw(ctx, insn);
         return;
     case 0x0C:
         translate_table(ctx, insn, table_float_0c);
         return;
-    case 0x0D:
-        trans_ldo(ctx, insn);
-        return;
     case 0x0E:
         translate_table(ctx, insn, table_float_0e);
         return;
@@ -4339,16 +4331,6 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
         trans_store_w(ctx, insn);
         return;
 
-    case 0x24:
-        trans_cmpiclr(ctx, insn);
-        return;
-    case 0x25:
-        trans_subi(ctx, insn);
-        return;
-    case 0x2C:
-    case 0x2D:
-        trans_addi(ctx, insn);
-        return;
     case 0x2E:
         translate_table(ctx, insn, table_fp_fused);
         return;
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 3bd19f8a28..7d8b6e8b58 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -28,6 +28,11 @@
 %assemble_17	0:s1 16:5 2:1 3:10   !function=expand_shl2
 %assemble_22	0:s1 16:10 2:1 3:10  !function=expand_shl2
 
+%assemble_21	0:s1 1:11 14:2 16:5 12:2  !function=expand_shl11
+
+%lowsign_11	0:s1 1:10
+%lowsign_14	0:s1 1:13
+
 %sm_imm		16:10 !function=expand_sm_imm
 
 %im5_0		0:s1 1:4
@@ -43,6 +48,7 @@
 
 &rrr_cf		t r1 r2 cf
 &rrr_cf_sh	t r1 r2 cf sh
+&rri_cf		t r i cf
 
 &rrb_c_f	disp n c f r1 r2
 &rib_c_f	disp n c f r i
@@ -54,6 +60,7 @@
 @rrr_cf		...... r2:5 r1:5 cf:4 ....... t:5	&rrr_cf
 @rrr_cf_sh	...... r2:5 r1:5 cf:4 .... sh:2 . t:5	&rrr_cf_sh
 @rrr_cf_sh0	...... r2:5 r1:5 cf:4 ....... t:5	&rrr_cf_sh sh=0
+@rri_cf		...... r:5  t:5  cf:4 . ...........	&rri_cf i=%lowsign_11
 
 @rrb_cf		...... r2:5 r1:5 c:3 ........... n:1 .	\
 		&rrb_c_f disp=%assemble_12
@@ -144,6 +151,20 @@ sub_tsv_tc	000010 ..... ..... .... 110011 0 .....	@rrr_cf
 sub_b		000010 ..... ..... .... 010100 0 .....	@rrr_cf
 sub_b_tsv	000010 ..... ..... .... 110100 0 .....	@rrr_cf
 
+ldil		001000 t:5 .....................	i=%assemble_21
+addil		001010 r:5 .....................	i=%assemble_21
+ldo		001101 b:5 t:5 -- ..............	i=%lowsign_14
+
+addi		101101 ..... ..... .... 0 ...........	@rri_cf
+addi_tsv	101101 ..... ..... .... 1 ...........	@rri_cf
+addi_tc		101100 ..... ..... .... 0 ...........	@rri_cf
+addi_tc_tsv	101100 ..... ..... .... 1 ...........	@rri_cf
+
+subi		100101 ..... ..... .... 0 ...........	@rri_cf
+subi_tsv	100101 ..... ..... .... 1 ...........	@rri_cf
+
+cmpiclr		100100 ..... ..... .... 0 ...........	@rri_cf
+
 ####
 # Index Mem
 ####
-- 
2.14.3
