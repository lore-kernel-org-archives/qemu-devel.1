Received: from eggs.gnu.org ([209.51.188.92]:58280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griGH-0007Z6-Gt
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griGD-0001WE-Ad
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:31 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1griGA-0001Tu-IU
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:27 -0500
Received: by mail-wr1-x443.google.com with SMTP id z18so10469401wrh.2
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 03:54:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Feb 2019 11:53:55 +0000
Message-Id: <20190207115400.647-15-richard.henderson@linaro.org>
In-Reply-To: <20190207115400.647-1-richard.henderson@linaro.org>
References: <20190207115400.647-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 14/19] target/hppa: Convert offset memory insns
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
 target/hppa/translate.c  | 215 +++++++++------------------------------
 target/hppa/insns.decode |  49 +++++++++
 2 files changed, 99 insertions(+), 165 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 7e4a65e0d5..4ce65bcc61 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -303,12 +303,29 @@ static int ma_to_m(int val)
     return val & 2 ? (val & 1 ? -1 : 1) : 0;
 }
 
-/* Used for branch targets.  */
+/* Convert the sign of the displacement to a pre or post-modify.  */
+static int pos_to_m(int val)
+{
+    return val ? 1 : -1;
+}
+
+static int neg_to_m(int val)
+{
+    return val ? -1 : 1;
+}
+
+/* Used for branch targets and fp memory ops.  */
 static int expand_shl2(int val)
 {
     return val << 2;
 }
 
+/* Used for fp memory ops.  */
+static int expand_shl3(int val)
+{
+    return val << 3;
+}
+
 /* Used for assemble_21.  */
 static int expand_shl11(int val)
 {
@@ -883,24 +900,6 @@ static inline unsigned assemble_sr3(uint32_t insn)
     return s2 * 4 + s0;
 }
 
-static target_sreg assemble_16(uint32_t insn)
-{
-    /* Take the name from PA2.0, which produces a 16-bit number
-       only with wide mode; otherwise a 14-bit number.  Since we don't
-       implement wide mode, this is always the 14-bit number.  */
-    return low_sextract(insn, 0, 14);
-}
-
-static target_sreg assemble_16a(uint32_t insn)
-{
-    /* Take the name from PA2.0, which produces a 14-bit shifted number
-       only with wide mode; otherwise a 12-bit shifted number.  Since we
-       don't implement wide mode, this is always the 12-bit number.  */
-    target_ureg x = -(target_ureg)(insn & 1);
-    x = (x << 11) | extract32(insn, 2, 11);
-    return x << 2;
-}
-
 /* The parisc documentation describes only the general interpretation of
    the conditions, without describing their exact implementation.  The
    interpretations do not stand up well when considering ADD,C and SUB,B.
@@ -1594,7 +1593,7 @@ static bool do_load(DisasContext *ctx, unsigned rt, unsigned rb,
     return nullify_end(ctx);
 }
 
-static void do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
+static bool do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
                       unsigned rx, int scale, target_sreg disp,
                       unsigned sp, int modify)
 {
@@ -1611,10 +1610,16 @@ static void do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
         gen_helper_loaded_fr0(cpu_env);
     }
 
-    nullify_end(ctx);
+    return nullify_end(ctx);
 }
 
-static void do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
+static bool trans_fldw(DisasContext *ctx, arg_ldst *a)
+{
+    return do_floadw(ctx, a->t, a->b, a->x, a->scale ? 2 : 0,
+                     a->disp, a->sp, a->m);
+}
+
+static bool do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
                       unsigned rx, int scale, target_sreg disp,
                       unsigned sp, int modify)
 {
@@ -1631,7 +1636,13 @@ static void do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
         gen_helper_loaded_fr0(cpu_env);
     }
 
-    nullify_end(ctx);
+    return nullify_end(ctx);
+}
+
+static bool trans_fldd(DisasContext *ctx, arg_ldst *a)
+{
+    return do_floadd(ctx, a->t, a->b, a->x, a->scale ? 3 : 0,
+                     a->disp, a->sp, a->m);
 }
 
 static bool do_store(DisasContext *ctx, unsigned rt, unsigned rb,
@@ -1643,7 +1654,7 @@ static bool do_store(DisasContext *ctx, unsigned rt, unsigned rb,
     return nullify_end(ctx);
 }
 
-static void do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
+static bool do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
                        unsigned rx, int scale, target_sreg disp,
                        unsigned sp, int modify)
 {
@@ -1655,10 +1666,16 @@ static void do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
     do_store_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TEUL);
     tcg_temp_free_i32(tmp);
 
-    nullify_end(ctx);
+    return nullify_end(ctx);
 }
 
-static void do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
+static bool trans_fstw(DisasContext *ctx, arg_ldst *a)
+{
+    return do_fstorew(ctx, a->t, a->b, a->x, a->scale ? 2 : 0,
+                      a->disp, a->sp, a->m);
+}
+
+static bool do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
                        unsigned rx, int scale, target_sreg disp,
                        unsigned sp, int modify)
 {
@@ -1670,7 +1687,13 @@ static void do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
     do_store_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TEQ);
     tcg_temp_free_i64(tmp);
 
-    nullify_end(ctx);
+    return nullify_end(ctx);
+}
+
+static bool trans_fstd(DisasContext *ctx, arg_ldst *a)
+{
+    return do_fstored(ctx, a->t, a->b, a->x, a->scale ? 3 : 0,
+                      a->disp, a->sp, a->m);
 }
 
 static void do_fop_wew(DisasContext *ctx, unsigned rt, unsigned ra,
@@ -2958,107 +2981,6 @@ static bool trans_ldo(DisasContext *ctx, arg_ldo *a)
     return true;
 }
 
-static bool trans_load(DisasContext *ctx, uint32_t insn,
-                       bool is_mod, TCGMemOp mop)
-{
-    unsigned rb = extract32(insn, 21, 5);
-    unsigned rt = extract32(insn, 16, 5);
-    unsigned sp = extract32(insn, 14, 2);
-    target_sreg i = assemble_16(insn);
-
-    do_load(ctx, rt, rb, 0, 0, i, sp, is_mod ? (i < 0 ? -1 : 1) : 0, mop);
-    return true;
-}
-
-static bool trans_load_w(DisasContext *ctx, uint32_t insn)
-{
-    unsigned rb = extract32(insn, 21, 5);
-    unsigned rt = extract32(insn, 16, 5);
-    unsigned sp = extract32(insn, 14, 2);
-    target_sreg i = assemble_16a(insn);
-    unsigned ext2 = extract32(insn, 1, 2);
-
-    switch (ext2) {
-    case 0:
-    case 1:
-        /* FLDW without modification.  */
-        do_floadw(ctx, ext2 * 32 + rt, rb, 0, 0, i, sp, 0);
-        break;
-    case 2:
-        /* LDW with modification.  Note that the sign of I selects
-           post-dec vs pre-inc.  */
-        do_load(ctx, rt, rb, 0, 0, i, sp, (i < 0 ? 1 : -1), MO_TEUL);
-        break;
-    default:
-        return gen_illegal(ctx);
-    }
-    return true;
-}
-
-static bool trans_fload_mod(DisasContext *ctx, uint32_t insn)
-{
-    target_sreg i = assemble_16a(insn);
-    unsigned t1 = extract32(insn, 1, 1);
-    unsigned a = extract32(insn, 2, 1);
-    unsigned sp = extract32(insn, 14, 2);
-    unsigned t0 = extract32(insn, 16, 5);
-    unsigned rb = extract32(insn, 21, 5);
-
-    /* FLDW with modification.  */
-    do_floadw(ctx, t1 * 32 + t0, rb, 0, 0, i, sp, (a ? -1 : 1));
-    return true;
-}
-
-static bool trans_store(DisasContext *ctx, uint32_t insn,
-                        bool is_mod, TCGMemOp mop)
-{
-    unsigned rb = extract32(insn, 21, 5);
-    unsigned rt = extract32(insn, 16, 5);
-    unsigned sp = extract32(insn, 14, 2);
-    target_sreg i = assemble_16(insn);
-
-    do_store(ctx, rt, rb, i, sp, is_mod ? (i < 0 ? -1 : 1) : 0, mop);
-    return true;
-}
-
-static bool trans_store_w(DisasContext *ctx, uint32_t insn)
-{
-    unsigned rb = extract32(insn, 21, 5);
-    unsigned rt = extract32(insn, 16, 5);
-    unsigned sp = extract32(insn, 14, 2);
-    target_sreg i = assemble_16a(insn);
-    unsigned ext2 = extract32(insn, 1, 2);
-
-    switch (ext2) {
-    case 0:
-    case 1:
-        /* FSTW without modification.  */
-        do_fstorew(ctx, ext2 * 32 + rt, rb, 0, 0, i, sp, 0);
-        break;
-    case 2:
-        /* STW with modification.  */
-        do_store(ctx, rt, rb, i, sp, (i < 0 ? 1 : -1), MO_TEUL);
-        break;
-    default:
-        return gen_illegal(ctx);
-    }
-    return true;
-}
-
-static bool trans_fstore_mod(DisasContext *ctx, uint32_t insn)
-{
-    target_sreg i = assemble_16a(insn);
-    unsigned t1 = extract32(insn, 1, 1);
-    unsigned a = extract32(insn, 2, 1);
-    unsigned sp = extract32(insn, 14, 2);
-    unsigned t0 = extract32(insn, 16, 5);
-    unsigned rb = extract32(insn, 21, 5);
-
-    /* FSTW with modification.  */
-    do_fstorew(ctx, t1 * 32 + t0, rb, 0, 0, i, sp, (a ? -1 : 1));
-    return true;
-}
-
 static bool trans_copr_w(DisasContext *ctx, uint32_t insn)
 {
     unsigned t0 = extract32(insn, 0, 5);
@@ -4302,43 +4224,6 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
         translate_table(ctx, insn, table_float_0e);
         return;
 
-    case 0x10:
-        trans_load(ctx, insn, false, MO_UB);
-        return;
-    case 0x11:
-        trans_load(ctx, insn, false, MO_TEUW);
-        return;
-    case 0x12:
-        trans_load(ctx, insn, false, MO_TEUL);
-        return;
-    case 0x13:
-        trans_load(ctx, insn, true, MO_TEUL);
-        return;
-    case 0x16:
-        trans_fload_mod(ctx, insn);
-        return;
-    case 0x17:
-        trans_load_w(ctx, insn);
-        return;
-    case 0x18:
-        trans_store(ctx, insn, false, MO_UB);
-        return;
-    case 0x19:
-        trans_store(ctx, insn, false, MO_TEUW);
-        return;
-    case 0x1A:
-        trans_store(ctx, insn, false, MO_TEUL);
-        return;
-    case 0x1B:
-        trans_store(ctx, insn, true, MO_TEUL);
-        return;
-    case 0x1E:
-        trans_fstore_mod(ctx, insn);
-        return;
-    case 0x1F:
-        trans_store_w(ctx, insn);
-        return;
-
     case 0x2E:
         translate_table(ctx, insn, table_fp_fused);
         return;
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 3e774ae1ad..40b23823d0 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -24,7 +24,9 @@
 %assemble_sr3   13:1 14:2
 %assemble_sr3x  13:1 14:2 !function=expand_sr3x
 
+%assemble_11a   0:s1 4:10            !function=expand_shl3
 %assemble_12    0:s1 2:1 3:10        !function=expand_shl2
+%assemble_12a   0:s1 3:11            !function=expand_shl2
 %assemble_17    0:s1 16:5 2:1 3:10   !function=expand_shl2
 %assemble_22    0:s1 16:10 2:1 3:10  !function=expand_shl2
 
@@ -35,9 +37,15 @@
 
 %sm_imm         16:10 !function=expand_sm_imm
 
+%rm64           1:1 16:5
+
 %im5_0          0:s1 1:4
 %im5_16         16:s1 17:4
 %ma_to_m        5:1 13:1 !function=ma_to_m
+%ma2_to_m       2:2      !function=ma_to_m
+%pos_to_m       0:1      !function=pos_to_m
+%neg_to_m       0:1      !function=neg_to_m
+%a_to_m         2:1      !function=neg_to_m
 
 ####
 # Argument set definitions
@@ -187,6 +195,47 @@ lda             000011 ..... ..... .. . 0 -- 0110      ......   @ldstx size=2
 sta             000011 ..... ..... .. . 1 -- 1110      ......   @stim5 size=2
 stby            000011 b:5 r:5 sp:2 a:1 1 -- 1100 m:1   .....   disp=%im5_0
 
+####
+# Offset Mem
+####
+
+@ldstim14       ...... b:5 t:5 sp:2 ..............      \
+                &ldst disp=%lowsign_14 x=0 scale=0 m=0
+@ldstim14m      ...... b:5 t:5 sp:2 ..............      \
+                &ldst disp=%lowsign_14 x=0 scale=0 m=%neg_to_m
+@ldstim12m      ...... b:5 t:5 sp:2 ..............      \
+                &ldst disp=%assemble_12a x=0 scale=0 m=%pos_to_m
+
+# LDB, LDH, LDW, LDWM
+ld              010000 ..... ..... .. ..............    @ldstim14  size=0
+ld              010001 ..... ..... .. ..............    @ldstim14  size=1
+ld              010010 ..... ..... .. ..............    @ldstim14  size=2
+ld              010011 ..... ..... .. ..............    @ldstim14m size=2
+ld              010111 ..... ..... .. ...........10.    @ldstim12m size=2
+
+# STB, STH, STW, STWM
+st              011000 ..... ..... .. ..............    @ldstim14  size=0
+st              011001 ..... ..... .. ..............    @ldstim14  size=1
+st              011010 ..... ..... .. ..............    @ldstim14  size=2
+st              011011 ..... ..... .. ..............    @ldstim14m size=2
+st              011111 ..... ..... .. ...........10.    @ldstim12m size=2
+
+fldw            010110 b:5 ..... sp:2 ..............    \
+                &ldst disp=%assemble_12a t=%rm64 m=%a_to_m x=0 scale=0 size=2
+fldw            010111 b:5 ..... sp:2 ...........0..    \
+                &ldst disp=%assemble_12a t=%rm64 m=0 x=0 scale=0 size=2
+
+fstw            011110 b:5 ..... sp:2 ..............    \
+                &ldst disp=%assemble_12a t=%rm64 m=%a_to_m x=0 scale=0 size=2
+fstw            011111 b:5 ..... sp:2 ...........0..    \
+                &ldst disp=%assemble_12a t=%rm64 m=0 x=0 scale=0 size=2
+
+fldd            010100 b:5 t:5   sp:2 .......... .. 1 . \
+                &ldst disp=%assemble_11a m=%ma2_to_m x=0 scale=0 size=3
+
+fstd            011100 b:5 t:5   sp:2 .......... .. 1 . \
+                &ldst disp=%assemble_11a m=%ma2_to_m x=0 scale=0 size=3
+
 ####
 # Floating-point Multiply Add
 ####
-- 
2.17.2
