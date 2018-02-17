Received: from eggs.gnu.org ([2001:4830:134:3::10]:41976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en99H-0000Ch-VL
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:31:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en99G-0000no-EQ
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:31:55 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:37397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en99G-0000nc-6j
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:31:54 -0500
Received: by mail-pl0-x243.google.com with SMTP id ay8so3540862plb.4
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 12:31:54 -0800 (PST)
Received: from cloudburst.twiddle.net ([50.0.192.64])
	by smtp.gmail.com with ESMTPSA id
	y7sm48203797pfe.26.2018.02.17.12.31.51 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 17 Feb 2018 12:31:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 12:31:23 -0800
Message-Id: <20180217203132.31780-11-richard.henderson@linaro.org>
In-Reply-To: <20180217203132.31780-1-richard.henderson@linaro.org>
References: <20180217203132.31780-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 10/19] target/hppa: Convert conditional branches
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
 target/hppa/translate.c  | 188 ++++++++++++++++++++---------------------------
 target/hppa/insns.decode |  30 ++++++++
 2 files changed, 110 insertions(+), 108 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 1cfdbf6296..361a20b733 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -315,6 +315,13 @@ static int ma_to_m(int val)
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
 
@@ -876,14 +883,6 @@ static inline unsigned assemble_sr3(uint32_t insn)
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
@@ -3156,24 +3155,12 @@ static void trans_copr_dw(DisasContext *ctx, uint32_t insn)
     }
 }
 
-static void trans_cmpb(DisasContext *ctx, uint32_t insn,
-                       bool is_true, bool is_imm, bool is_dw)
+static void do_cmpb(DisasContext *ctx, unsigned r, TCGv_reg in1,
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
 
@@ -3184,28 +3171,28 @@ static void trans_cmpb(DisasContext *ctx, uint32_t insn,
         sv = do_sub_sv(ctx, dest, in1, in2);
     }
 
-    cond = do_sub_cond(cf, dest, in1, in2, sv);
+    cond = do_sub_cond(c * 2 + f, dest, in1, in2, sv);
     do_cbranch(ctx, disp, n, &cond);
 }
 
-static void trans_addb(DisasContext *ctx, uint32_t insn,
-                       bool is_true, bool is_imm)
+static void trans_cmpb(DisasContext *ctx, arg_cmpb *a, uint32_t insn)
 {
-    target_sreg disp = assemble_12(insn) * 4;
-    unsigned n = extract32(insn, 1, 1);
-    unsigned c = extract32(insn, 13, 3);
-    unsigned r = extract32(insn, 21, 5);
-    unsigned cf = c * 2 + !is_true;
-    TCGv_reg dest, in1, in2, sv, cb_msb;
+    nullify_over(ctx);
+    do_cmpb(ctx, a->r2, load_gpr(ctx, a->r1), a->c, a->f, a->n, a->disp);
+}
+
+static void trans_cmpbi(DisasContext *ctx, arg_cmpbi *a, uint32_t insn)
+{
+    nullify_over(ctx);
+    do_cmpb(ctx, a->r, load_const(ctx, a->i), a->c, a->f, a->n, a->disp);
+}
+
+static void do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
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
@@ -3226,59 +3213,84 @@ static void trans_addb(DisasContext *ctx, uint32_t insn,
         break;
     }
 
-    cond = do_cond(cf, dest, cb_msb, sv);
+    cond = do_cond(c * 2 + f, dest, cb_msb, sv);
     do_cbranch(ctx, disp, n, &cond);
 }
 
-static void trans_bb(DisasContext *ctx, uint32_t insn)
+static void trans_addb(DisasContext *ctx, arg_addb *a, uint32_t insn)
+{
+    nullify_over(ctx);
+    do_addb(ctx, a->r2, load_gpr(ctx, a->r1), a->c, a->f, a->n, a->disp);
+}
+
+static void trans_addbi(DisasContext *ctx, arg_addbi *a, uint32_t insn)
+{
+    nullify_over(ctx);
+    do_addb(ctx, a->r, load_const(ctx, a->i), a->c, a->f, a->n, a->disp);
+}
+
+static void trans_bb_sar(DisasContext *ctx, arg_bb_sar *a, uint32_t insn)
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
+    do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
-static void trans_movb(DisasContext *ctx, uint32_t insn, bool is_imm)
+static void trans_bb_imm(DisasContext *ctx, arg_bb_imm *a, uint32_t insn)
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
+    do_cbranch(ctx, a->disp, a->n, &cond);
+}
+
+static void trans_movb(DisasContext *ctx, arg_movb *a, uint32_t insn)
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
+    cond = do_sed_cond(a->c, dest);
+    do_cbranch(ctx, a->disp, a->n, &cond);
+}
+
+static void trans_movbi(DisasContext *ctx, arg_movbi *a, uint32_t insn)
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
+    do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
 static void trans_shrpw_sar(DisasContext *ctx, uint32_t insn,
@@ -4431,39 +4443,12 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
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
@@ -4471,20 +4456,7 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
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
index 5393d30f43..e916dc9d30 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -24,6 +24,8 @@
 %assemble_sr3	13:1 14:2
 %assemble_sr3x	13:1 14:2 !function=expand_sr3x
 
+%assemble_12	0:s1 2:1 3:10  !function=expand_shl2
+
 %sm_imm		16:10 !function=expand_sm_imm
 
 %im5_0		0:s1 1:4
@@ -40,6 +42,9 @@
 &rrr_cf		t r1 r2 cf
 &rrr_cf_sh	t r1 r2 cf sh
 
+&rrb_c_f	disp n c f r1 r2
+&rib_c_f	disp n c f r i
+
 ####
 # Format definitions
 ####
@@ -48,6 +53,11 @@
 @rrr_cf_sh	...... r2:5 r1:5 cf:4 .... sh:2 . t:5	&rrr_cf_sh
 @rrr_cf_sh0	...... r2:5 r1:5 cf:4 ....... t:5	&rrr_cf_sh sh=0
 
+@rrb_cf		...... r2:5 r1:5 c:3 ........... n:1 .	\
+		&rrb_c_f disp=%assemble_12
+@rib_cf		...... r:5 ..... c:3 ........... n:1 .	\
+		&rib_c_f disp=%assemble_12 i=%im5_16
+
 ####
 # System
 ####
@@ -163,3 +173,23 @@ fmpyadd_f	000110 ..... ..... ..... ..... 0 .....	@mpyadd
 fmpyadd_d	000110 ..... ..... ..... ..... 1 .....	@mpyadd
 fmpysub_f	100110 ..... ..... ..... ..... 0 .....	@mpyadd
 fmpysub_d	100110 ..... ..... ..... ..... 1 .....	@mpyadd
+
+####
+# Conditional Branches
+####
+
+bb_sar		110000 00000 r:5 c:1 10 ........... n:1 .  disp=%assemble_12
+bb_imm		110001 p:5   r:5 c:1 10 ........... n:1 .  disp=%assemble_12
+
+movb		110010 ..... ..... ... ........... . .	@rrb_cf f=0
+movbi		110011 ..... ..... ... ........... . .	@rib_cf f=0
+
+cmpb		100000 ..... ..... ... ........... . .	@rrb_cf f=0
+cmpb		100010 ..... ..... ... ........... . .	@rrb_cf f=1
+cmpbi		100001 ..... ..... ... ........... . .	@rib_cf f=0
+cmpbi		100011 ..... ..... ... ........... . .	@rib_cf f=1
+
+addb		101000 ..... ..... ... ........... . .	@rrb_cf f=0
+addb		101010 ..... ..... ... ........... . .	@rrb_cf f=1
+addbi		101001 ..... ..... ... ........... . .	@rib_cf f=0
+addbi		101011 ..... ..... ... ........... . .	@rib_cf f=1
-- 
2.14.3
