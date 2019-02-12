Received: from eggs.gnu.org ([209.51.188.92]:49786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ95-0002nO-JE
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ8q-00021j-G2
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:58:07 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtQ8m-0001nd-Qf
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:57:55 -0500
Received: by mail-pf1-x444.google.com with SMTP id j3so677251pfi.12
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:57:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 20:57:19 -0800
Message-Id: <20190212045721.28041-23-richard.henderson@linaro.org>
In-Reply-To: <20190212045721.28041-1-richard.henderson@linaro.org>
References: <20190212045721.28041-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 22/24] target/hppa: Fix addition '</<='
 conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Sven Schnelle <svens@stackframe.org>

From: Sven Schnelle <svens@stackframe.org>

These conditions include the signed overflow bit.  See page 5-3
of the Parisc 1.1 Architecture Reference Manual for details.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
[rth: More changes for c == 3, to compute (N^V)|Z properly.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 95 +++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 37 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index aae5714235..026ba5cb3e 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -452,15 +452,19 @@ static DisasCond cond_make_n(void)
     };
 }
 
+static DisasCond cond_make_0_tmp(TCGCond c, TCGv_reg a0)
+{
+    assert (c != TCG_COND_NEVER && c != TCG_COND_ALWAYS);
+    return (DisasCond){
+        .c = c, .a0 = a0, .a1_is_0 = true
+    };
+}
+
 static DisasCond cond_make_0(TCGCond c, TCGv_reg a0)
 {
-    DisasCond r = { .c = c, .a1 = NULL, .a1_is_0 = true };
-
-    assert (c != TCG_COND_NEVER && c != TCG_COND_ALWAYS);
-    r.a0 = tcg_temp_new();
-    tcg_gen_mov_reg(r.a0, a0);
-
-    return r;
+    TCGv_reg tmp = tcg_temp_new();
+    tcg_gen_mov_reg(tmp, a0);
+    return cond_make_0_tmp(c, tmp);
 }
 
 static DisasCond cond_make(TCGCond c, TCGv_reg a0, TCGv_reg a1)
@@ -849,12 +853,20 @@ static void gen_goto_tb(DisasContext *ctx, int which,
     }
 }
 
-/* The parisc documentation describes only the general interpretation of
-   the conditions, without describing their exact implementation.  The
-   interpretations do not stand up well when considering ADD,C and SUB,B.
-   However, considering the Addition, Subtraction and Logical conditions
-   as a whole it would appear that these relations are similar to what
-   a traditional NZCV set of flags would produce.  */
+static bool cond_need_sv(int c)
+{
+    return c == 2 || c == 3 || c == 6;
+}
+
+static bool cond_need_cb(int c)
+{
+    return c == 4 || c == 5;
+}
+
+/*
+ * Compute conditional for arithmetic.  See Page 5-3, Table 5-1, of
+ * the Parisc 1.1 Architecture Reference Manual for details.
+ */
 
 static DisasCond do_cond(unsigned cf, TCGv_reg res,
                          TCGv_reg cb_msb, TCGv_reg sv)
@@ -863,17 +875,32 @@ static DisasCond do_cond(unsigned cf, TCGv_reg res,
     TCGv_reg tmp;
 
     switch (cf >> 1) {
-    case 0: /* Never / TR */
+    case 0: /* Never / TR    (0 / 1) */
         cond = cond_make_f();
         break;
     case 1: /* = / <>        (Z / !Z) */
         cond = cond_make_0(TCG_COND_EQ, res);
         break;
-    case 2: /* < / >=        (N / !N) */
-        cond = cond_make_0(TCG_COND_LT, res);
+    case 2: /* < / >=        (N ^ V / !(N ^ V) */
+        tmp = tcg_temp_new();
+        tcg_gen_xor_reg(tmp, res, sv);
+        cond = cond_make_0_tmp(TCG_COND_LT, tmp);
         break;
-    case 3: /* <= / >        (N | Z / !N & !Z) */
-        cond = cond_make_0(TCG_COND_LE, res);
+    case 3: /* <= / >        (N ^ V) | Z / !((N ^ V) | Z) */
+        /*
+         * Simplify:
+         *   (N ^ V) | Z
+         *   ((res < 0) ^ (sv < 0)) | !res
+         *   ((res ^ sv) < 0) | !res
+         *   (~(res ^ sv) >= 0) | !res
+         *   !(~(res ^ sv) >> 31) | !res
+         *   !(~(res ^ sv) >> 31 & res)
+         */
+        tmp = tcg_temp_new();
+        tcg_gen_eqv_reg(tmp, res, sv);
+        tcg_gen_sari_reg(tmp, tmp, TARGET_REGISTER_BITS - 1);
+        tcg_gen_and_reg(tmp, tmp, res);
+        cond = cond_make_0_tmp(TCG_COND_EQ, tmp);
         break;
     case 4: /* NUV / UV      (!C / C) */
         cond = cond_make_0(TCG_COND_EQ, cb_msb);
@@ -882,8 +909,7 @@ static DisasCond do_cond(unsigned cf, TCGv_reg res,
         tmp = tcg_temp_new();
         tcg_gen_neg_reg(tmp, cb_msb);
         tcg_gen_and_reg(tmp, tmp, res);
-        cond = cond_make_0(TCG_COND_EQ, tmp);
-        tcg_temp_free(tmp);
+        cond = cond_make_0_tmp(TCG_COND_EQ, tmp);
         break;
     case 6: /* SV / NSV      (V / !V) */
         cond = cond_make_0(TCG_COND_LT, sv);
@@ -891,8 +917,7 @@ static DisasCond do_cond(unsigned cf, TCGv_reg res,
     case 7: /* OD / EV */
         tmp = tcg_temp_new();
         tcg_gen_andi_reg(tmp, res, 1);
-        cond = cond_make_0(TCG_COND_NE, tmp);
-        tcg_temp_free(tmp);
+        cond = cond_make_0_tmp(TCG_COND_NE, tmp);
         break;
     default:
         g_assert_not_reached();
@@ -930,7 +955,7 @@ static DisasCond do_sub_cond(unsigned cf, TCGv_reg res,
         cond = cond_make(TCG_COND_LEU, in1, in2);
         break;
     default:
-        return do_cond(cf, res, sv, sv);
+        return do_cond(cf, res, NULL, sv);
     }
     if (cf & 1) {
         cond.c = tcg_invert_cond(cond.c);
@@ -1129,7 +1154,7 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
         in1 = tmp;
     }
 
-    if (!is_l || c == 4 || c == 5) {
+    if (!is_l || cond_need_cb(c)) {
         TCGv_reg zero = tcg_const_reg(0);
         cb_msb = get_temp(ctx);
         tcg_gen_add2_reg(dest, cb_msb, in1, zero, in2, zero);
@@ -1151,7 +1176,7 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 
     /* Compute signed overflow if required.  */
     sv = NULL;
-    if (is_tsv || c == 6) {
+    if (is_tsv || cond_need_sv(c)) {
         sv = do_add_sv(ctx, dest, in1, in2);
         if (is_tsv) {
             /* ??? Need to include overflow from shift.  */
@@ -1242,7 +1267,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 
     /* Compute signed overflow if required.  */
     sv = NULL;
-    if (is_tsv || c == 6) {
+    if (is_tsv || cond_need_sv(c)) {
         sv = do_sub_sv(ctx, dest, in1, in2);
         if (is_tsv) {
             gen_helper_tsv(cpu_env, sv);
@@ -1314,7 +1339,7 @@ static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 
     /* Compute signed overflow if required.  */
     sv = NULL;
-    if ((cf >> 1) == 6) {
+    if (cond_need_sv(cf >> 1)) {
         sv = do_sub_sv(ctx, dest, in1, in2);
     }
 
@@ -2781,7 +2806,7 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
     /* Install the new nullification.  */
     if (a->cf) {
         TCGv_reg sv = NULL;
-        if (a->cf >> 1 == 6) {
+        if (cond_need_sv(a->cf >> 1)) {
             /* ??? The lshift is supposed to contribute to overflow.  */
             sv = do_add_sv(ctx, dest, add1, add2);
         }
@@ -2982,7 +3007,7 @@ static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_reg in1,
     tcg_gen_sub_reg(dest, in1, in2);
 
     sv = NULL;
-    if (c == 6) {
+    if (cond_need_sv(c)) {
         sv = do_sub_sv(ctx, dest, in1, in2);
     }
 
@@ -3013,19 +3038,15 @@ static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
     sv = NULL;
     cb_msb = NULL;
 
-    switch (c) {
-    default:
-        tcg_gen_add_reg(dest, in1, in2);
-        break;
-    case 4: case 5:
+    if (cond_need_cb(c)) {
         cb_msb = get_temp(ctx);
         tcg_gen_movi_reg(cb_msb, 0);
         tcg_gen_add2_reg(dest, cb_msb, in1, cb_msb, in2, cb_msb);
-        break;
-    case 6:
+    } else {
         tcg_gen_add_reg(dest, in1, in2);
+    }
+    if (cond_need_sv(c)) {
         sv = do_add_sv(ctx, dest, in1, in2);
-        break;
     }
 
     cond = do_cond(c * 2 + f, dest, cb_msb, sv);
-- 
2.17.2
