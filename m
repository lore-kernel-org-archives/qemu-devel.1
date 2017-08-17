Received: from eggs.gnu.org ([2001:4830:134:3::10]:44460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diTn1-0004so-0O
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diTmz-0000nM-1m
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:01:23 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:33446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1diTmy-0000lm-Qa
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:01:20 -0400
Received: by mail-pg0-x235.google.com with SMTP id t3so23902992pgt.0
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 16:01:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 17 Aug 2017 16:01:08 -0700
Message-Id: <20170817230114.3655-3-richard.henderson@linaro.org>
In-Reply-To: <20170817230114.3655-1-richard.henderson@linaro.org>
References: <20170817230114.3655-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/8] target/arm: Use generic vector
 infrastructure for aa64 add/sub/logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 137 ++++++++++++++++++++++++++++-----------------
 1 file changed, 87 insertions(+), 50 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2200e25be0..025354f983 100644
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
@@ -82,6 +83,7 @@ typedef void NeonGenTwoDoubleOPFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
 typedef void NeonGenOneOpFn(TCGv_i64, TCGv_i64);
 typedef void CryptoTwoOpEnvFn(TCGv_ptr, TCGv_i32, TCGv_i32);
 typedef void CryptoThreeOpEnvFn(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32);
+typedef void GVecGenTwoFn(uint32_t, uint32_t, uint32_t, uint32_t, uint32_t);
 
 /* initialize TCG globals.  */
 void a64_translate_init(void)
@@ -537,6 +539,21 @@ static inline int vec_reg_offset(DisasContext *s, int regno,
     return offs;
 }
 
+/* Return the offset info CPUARMState of the "whole" vector register Qn.  */
+static inline int vec_full_reg_offset(DisasContext *s, int regno)
+{
+    assert_fp_access_checked(s);
+    return offsetof(CPUARMState, vfp.regs[regno * 2]);
+}
+
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
@@ -9042,11 +9059,38 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
     bool is_q = extract32(insn, 30, 1);
     TCGv_i64 tcg_op1, tcg_op2, tcg_res[2];
     int pass;
+    GVecGenTwoFn *gvec_op;
 
     if (!fp_access_check(s)) {
         return;
     }
 
+    switch (size + 4 * is_u) {
+    case 0: /* AND */
+        gvec_op = tcg_gen_gvec_and8;
+        goto do_gvec;
+    case 1: /* BIC */
+        gvec_op = tcg_gen_gvec_andc8;
+        goto do_gvec;
+    case 2: /* ORR */
+        gvec_op = tcg_gen_gvec_or8;
+        goto do_gvec;
+    case 3: /* ORN */
+        gvec_op = tcg_gen_gvec_orc8;
+        goto do_gvec;
+    case 4: /* EOR */
+        gvec_op = tcg_gen_gvec_xor8;
+        goto do_gvec;
+    do_gvec:
+        gvec_op(vec_full_reg_offset(s, rd),
+                vec_full_reg_offset(s, rn),
+                vec_full_reg_offset(s, rm),
+                is_q ? 16 : 8, vec_full_reg_size(s));
+        return;
+    }
+
+    /* Note that we've now eliminated all !is_u.  */
+
     tcg_op1 = tcg_temp_new_i64();
     tcg_op2 = tcg_temp_new_i64();
     tcg_res[0] = tcg_temp_new_i64();
@@ -9056,47 +9100,27 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
         read_vec_element(s, tcg_op1, rn, pass, MO_64);
         read_vec_element(s, tcg_op2, rm, pass, MO_64);
 
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
+        /* B* ops need res loaded to operate on */
+        read_vec_element(s, tcg_res[pass], rd, pass, MO_64);
 
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
+        switch (size) {
+        case 1: /* BSL bitwise select */
+            tcg_gen_xor_i64(tcg_op1, tcg_op1, tcg_op2);
+            tcg_gen_and_i64(tcg_op1, tcg_op1, tcg_res[pass]);
+            tcg_gen_xor_i64(tcg_res[pass], tcg_op2, tcg_op1);
+            break;
+        case 2: /* BIT, bitwise insert if true */
+            tcg_gen_xor_i64(tcg_op1, tcg_op1, tcg_res[pass]);
+            tcg_gen_and_i64(tcg_op1, tcg_op1, tcg_op2);
+            tcg_gen_xor_i64(tcg_res[pass], tcg_res[pass], tcg_op1);
+            break;
+        case 3: /* BIF, bitwise insert if false */
+            tcg_gen_xor_i64(tcg_op1, tcg_op1, tcg_res[pass]);
+            tcg_gen_andc_i64(tcg_op1, tcg_op1, tcg_op2);
+            tcg_gen_xor_i64(tcg_res[pass], tcg_res[pass], tcg_op1);
+            break;
+        default:
+            g_assert_not_reached();
         }
     }
 
@@ -9370,6 +9394,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     int pass;
+    GVecGenTwoFn *gvec_op;
 
     switch (opcode) {
     case 0x13: /* MUL, PMUL */
@@ -9409,6 +9434,28 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
         return;
     }
 
+    switch (opcode) {
+    case 0x10: /* ADD, SUB */
+        {
+            static GVecGenTwoFn * const fns[4][2] = {
+                { tcg_gen_gvec_add8, tcg_gen_gvec_sub8 },
+                { tcg_gen_gvec_add16, tcg_gen_gvec_sub16 },
+                { tcg_gen_gvec_add32, tcg_gen_gvec_sub32 },
+                { tcg_gen_gvec_add64, tcg_gen_gvec_sub64 },
+            };
+            gvec_op = fns[size][u];
+            goto do_gvec;
+        }
+        break;
+
+    do_gvec:
+        gvec_op(vec_full_reg_offset(s, rd),
+                vec_full_reg_offset(s, rn),
+                vec_full_reg_offset(s, rm),
+                is_q ? 16 : 8, vec_full_reg_size(s));
+        return;
+    }
+
     if (size == 3) {
         assert(is_q);
         for (pass = 0; pass < 2; pass++) {
@@ -9581,16 +9628,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
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
2.13.5
