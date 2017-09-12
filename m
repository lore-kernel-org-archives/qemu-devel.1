Received: from eggs.gnu.org ([2001:4830:134:3::10]:38057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro0C-0001nm-Hf
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro08-00073U-67
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:32 -0400
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:35938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dro07-000738-Th
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:28 -0400
Received: by mail-pg0-x234.google.com with SMTP id i130so14869833pgc.3
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:25:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Sep 2017 09:25:05 -0700
Message-Id: <20170912162513.21694-9-richard.henderson@linaro.org>
In-Reply-To: <20170912162513.21694-1-richard.henderson@linaro.org>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 08/16] target/arm: Use vector infrastructure
 for aa64 add/sub/logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, f4bug@amsat.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 137 ++++++++++++++++++++++++++++-----------------
 1 file changed, 87 insertions(+), 50 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 9017e30510..d01a180fba 100644
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
@@ -9047,11 +9064,38 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
     bool is_q = extract32(insn, 30, 1);
     TCGv_i64 tcg_op1, tcg_op2, tcg_res[2];
     int pass;
+    GVecGenTwoFn *gvec_op;
 
     if (!fp_access_check(s)) {
         return;
     }
 
+    switch (size + 4 * is_u) {
+    case 0: /* AND */
+        gvec_op = tcg_gen_gvec_and;
+        goto do_gvec;
+    case 1: /* BIC */
+        gvec_op = tcg_gen_gvec_andc;
+        goto do_gvec;
+    case 2: /* ORR */
+        gvec_op = tcg_gen_gvec_or;
+        goto do_gvec;
+    case 3: /* ORN */
+        gvec_op = tcg_gen_gvec_orc;
+        goto do_gvec;
+    case 4: /* EOR */
+        gvec_op = tcg_gen_gvec_xor;
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
@@ -9061,47 +9105,27 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
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
 
@@ -9375,6 +9399,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     int pass;
+    GVecGenTwoFn *gvec_op;
 
     switch (opcode) {
     case 0x13: /* MUL, PMUL */
@@ -9414,6 +9439,28 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
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
@@ -9586,16 +9633,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
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
