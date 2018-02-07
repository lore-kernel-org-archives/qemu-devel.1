Received: from eggs.gnu.org ([2001:4830:134:3::10]:37541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejYdL-0007QF-2B
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejYdG-00051z-DJ
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:07 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:40543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejYdG-00051M-58
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:02 -0500
Received: by mail-pg0-x241.google.com with SMTP id g2so896296pgn.7
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 14:56:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  7 Feb 2018 14:55:32 -0800
Message-Id: <20180207225540.31698-13-richard.henderson@linaro.org>
In-Reply-To: <20180207225540.31698-1-richard.henderson@linaro.org>
References: <20180207225540.31698-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/20] target/arm: Use vector infrastructure for
 aa64 add/sub/logic
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 200 +++++++++++++++++++++++++++++----------------
 1 file changed, 128 insertions(+), 72 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index eed64c73e5..5a4e62ae0f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "tcg-op.h"
+#include "tcg-op-gvec.h"
 #include "qemu/log.h"
 #include "arm_ldst.h"
 #include "translate.h"
@@ -84,6 +85,10 @@ typedef void CryptoTwoOpFn(TCGv_ptr, TCGv_ptr);
 typedef void CryptoThreeOpIntFn(TCGv_ptr, TCGv_ptr, TCGv_i32);
 typedef void CryptoThreeOpFn(TCGv_ptr, TCGv_ptr, TCGv_ptr);
 
+/* Note that the gvec expanders operate on offsets + sizes.  */
+typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
+                        uint32_t, uint32_t, uint32_t);
+
 /* initialize TCG globals.  */
 void a64_translate_init(void)
 {
@@ -548,6 +553,14 @@ static TCGv_ptr vec_full_reg_ptr(DisasContext *s, int regno)
     return ret;
 }
 
+/* Return the byte size of the "whole" vector register, VL / 8.  */
+static inline int vec_full_reg_size(DisasContext *s)
+{
+    /* FIXME SVE: We should put the composite ZCR_EL* value into tb->flags.
+       In the meantime this is just the AdvSIMD length of 128.  */
+    return 128 / 8;
+}
+
 /* Return the offset into CPUARMState of a slice (from
  * the least significant end) of FP register Qn (ie
  * Dn, Sn, Hn or Bn).
@@ -618,6 +631,23 @@ static TCGv_ptr get_fpstatus_ptr(void)
     return statusptr;
 }
 
+/* Expand a 3-operand AdvSIMD vector operation using an expander function.  */
+static void gen_gvec_fn3(DisasContext *s, bool is_q, int rd, int rn, int rm,
+                         GVecGen3Fn *gvec_fn, int vece)
+{
+    gvec_fn(vece, vec_full_reg_offset(s, rd), vec_full_reg_offset(s, rn),
+            vec_full_reg_offset(s, rm), is_q ? 16 : 8, vec_full_reg_size(s));
+}
+
+/* Expand a 3-operand AdvSIMD vector operation using an op descriptor.  */
+static void gen_gvec_op3(DisasContext *s, bool is_q, int rd,
+                         int rn, int rm, const GVecGen3 *gvec_op)
+{
+    tcg_gen_gvec_3(vec_full_reg_offset(s, rd), vec_full_reg_offset(s, rn),
+                   vec_full_reg_offset(s, rm), is_q ? 16 : 8,
+                   vec_full_reg_size(s), gvec_op);
+}
+
 /* Set ZF and NF based on a 64 bit result. This is alas fiddlier
  * than the 32 bit equivalent.
  */
@@ -9072,85 +9102,111 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
     }
 }
 
+static void gen_bsl_i64(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
+{
+    tcg_gen_xor_i64(rn, rn, rm);
+    tcg_gen_and_i64(rn, rn, rd);
+    tcg_gen_xor_i64(rd, rm, rn);
+}
+
+static void gen_bit_i64(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
+{
+    tcg_gen_xor_i64(rn, rn, rd);
+    tcg_gen_and_i64(rn, rn, rm);
+    tcg_gen_xor_i64(rd, rd, rn);
+}
+
+static void gen_bif_i64(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
+{
+    tcg_gen_xor_i64(rn, rn, rd);
+    tcg_gen_andc_i64(rn, rn, rm);
+    tcg_gen_xor_i64(rd, rd, rn);
+}
+
+static void gen_bsl_vec(unsigned vece, TCGv_vec rd, TCGv_vec rn, TCGv_vec rm)
+{
+    tcg_gen_xor_vec(vece, rn, rn, rm);
+    tcg_gen_and_vec(vece, rn, rn, rd);
+    tcg_gen_xor_vec(vece, rd, rm, rn);
+}
+
+static void gen_bit_vec(unsigned vece, TCGv_vec rd, TCGv_vec rn, TCGv_vec rm)
+{
+    tcg_gen_xor_vec(vece, rn, rn, rd);
+    tcg_gen_and_vec(vece, rn, rn, rm);
+    tcg_gen_xor_vec(vece, rd, rd, rn);
+}
+
+static void gen_bif_vec(unsigned vece, TCGv_vec rd, TCGv_vec rn, TCGv_vec rm)
+{
+    tcg_gen_xor_vec(vece, rn, rn, rd);
+    tcg_gen_andc_vec(vece, rn, rn, rm);
+    tcg_gen_xor_vec(vece, rd, rd, rn);
+}
+
 /* Logic op (opcode == 3) subgroup of C3.6.16. */
 static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
 {
+    static const GVecGen3 bsl_op = {
+        .fni8 = gen_bsl_i64,
+        .fniv = gen_bsl_vec,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .load_dest = true
+    };
+    static const GVecGen3 bit_op = {
+        .fni8 = gen_bit_i64,
+        .fniv = gen_bit_vec,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .load_dest = true
+    };
+    static const GVecGen3 bif_op = {
+        .fni8 = gen_bif_i64,
+        .fniv = gen_bif_vec,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .load_dest = true
+    };
+
     int rd = extract32(insn, 0, 5);
     int rn = extract32(insn, 5, 5);
     int rm = extract32(insn, 16, 5);
     int size = extract32(insn, 22, 2);
     bool is_u = extract32(insn, 29, 1);
     bool is_q = extract32(insn, 30, 1);
-    TCGv_i64 tcg_op1, tcg_op2, tcg_res[2];
-    int pass;
 
     if (!fp_access_check(s)) {
         return;
     }
 
-    tcg_op1 = tcg_temp_new_i64();
-    tcg_op2 = tcg_temp_new_i64();
-    tcg_res[0] = tcg_temp_new_i64();
-    tcg_res[1] = tcg_temp_new_i64();
-
-    for (pass = 0; pass < (is_q ? 2 : 1); pass++) {
-        read_vec_element(s, tcg_op1, rn, pass, MO_64);
-        read_vec_element(s, tcg_op2, rm, pass, MO_64);
-
-        if (!is_u) {
-            switch (size) {
-            case 0: /* AND */
-                tcg_gen_and_i64(tcg_res[pass], tcg_op1, tcg_op2);
-                break;
-            case 1: /* BIC */
-                tcg_gen_andc_i64(tcg_res[pass], tcg_op1, tcg_op2);
-                break;
-            case 2: /* ORR */
-                tcg_gen_or_i64(tcg_res[pass], tcg_op1, tcg_op2);
-                break;
-            case 3: /* ORN */
-                tcg_gen_orc_i64(tcg_res[pass], tcg_op1, tcg_op2);
-                break;
-            }
-        } else {
-            if (size != 0) {
-                /* B* ops need res loaded to operate on */
-                read_vec_element(s, tcg_res[pass], rd, pass, MO_64);
-            }
+    switch (size + 4 * is_u) {
+    case 0: /* AND */
+        gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_and, 0);
+        return;
+    case 1: /* BIC */
+        gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_andc, 0);
+        return;
+    case 2: /* ORR */
+        gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_or, 0);
+        return;
+    case 3: /* ORN */
+        gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_orc, 0);
+        return;
+    case 4: /* EOR */
+        gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_xor, 0);
+        return;
 
-            switch (size) {
-            case 0: /* EOR */
-                tcg_gen_xor_i64(tcg_res[pass], tcg_op1, tcg_op2);
-                break;
-            case 1: /* BSL bitwise select */
-                tcg_gen_xor_i64(tcg_op1, tcg_op1, tcg_op2);
-                tcg_gen_and_i64(tcg_op1, tcg_op1, tcg_res[pass]);
-                tcg_gen_xor_i64(tcg_res[pass], tcg_op2, tcg_op1);
-                break;
-            case 2: /* BIT, bitwise insert if true */
-                tcg_gen_xor_i64(tcg_op1, tcg_op1, tcg_res[pass]);
-                tcg_gen_and_i64(tcg_op1, tcg_op1, tcg_op2);
-                tcg_gen_xor_i64(tcg_res[pass], tcg_res[pass], tcg_op1);
-                break;
-            case 3: /* BIF, bitwise insert if false */
-                tcg_gen_xor_i64(tcg_op1, tcg_op1, tcg_res[pass]);
-                tcg_gen_andc_i64(tcg_op1, tcg_op1, tcg_op2);
-                tcg_gen_xor_i64(tcg_res[pass], tcg_res[pass], tcg_op1);
-                break;
-            }
-        }
-    }
+    case 5: /* BSL bitwise select */
+        gen_gvec_op3(s, is_q, rd, rn, rm, &bsl_op);
+        return;
+    case 6: /* BIT, bitwise insert if true */
+        gen_gvec_op3(s, is_q, rd, rn, rm, &bit_op);
+        return;
+    case 7: /* BIF, bitwise insert if false */
+        gen_gvec_op3(s, is_q, rd, rn, rm, &bif_op);
+        return;
 
-    write_vec_element(s, tcg_res[0], rd, 0, MO_64);
-    if (!is_q) {
-        tcg_gen_movi_i64(tcg_res[1], 0);
+    default:
+        g_assert_not_reached();
     }
-    write_vec_element(s, tcg_res[1], rd, 1, MO_64);
-
-    tcg_temp_free_i64(tcg_op1);
-    tcg_temp_free_i64(tcg_op2);
-    tcg_temp_free_i64(tcg_res[0]);
-    tcg_temp_free_i64(tcg_res[1]);
 }
 
 /* Helper functions for 32 bit comparisons */
@@ -9450,6 +9506,16 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
         return;
     }
 
+    switch (opcode) {
+    case 0x10: /* ADD, SUB */
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_sub, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_add, size);
+        }
+        return;
+    }
+
     if (size == 3) {
         assert(is_q);
         for (pass = 0; pass < 2; pass++) {
@@ -9622,16 +9688,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genfn = fns[size][u];
                 break;
             }
-            case 0x10: /* ADD, SUB */
-            {
-                static NeonGenTwoOpFn * const fns[3][2] = {
-                    { gen_helper_neon_add_u8, gen_helper_neon_sub_u8 },
-                    { gen_helper_neon_add_u16, gen_helper_neon_sub_u16 },
-                    { tcg_gen_add_i32, tcg_gen_sub_i32 },
-                };
-                genfn = fns[size][u];
-                break;
-            }
             case 0x11: /* CMTST, CMEQ */
             {
                 static NeonGenTwoOpFn * const fns[3][2] = {
-- 
2.14.3
