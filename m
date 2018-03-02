Received: from eggs.gnu.org ([2001:4830:134:3::10]:43518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWk-00033M-By
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWi-0004xR-9a
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:01 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWh-0004wk-VW
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:00 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWh-0001OX-2q
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:59 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:26 +0000
Message-Id: <20180302110640.28004-26-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 25/39] target/arm: Refactor disas_simd_indexed
 decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Include the U bit in the switches rather than testing separately.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180228193125.20577-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 129 +++++++++++++++++++++------------------------
 1 file changed, 61 insertions(+), 68 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 32811dc8b0..fc928b61f6 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11787,49 +11787,39 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     int index;
     TCGv_ptr fpst;
 
-    switch (opcode) {
-    case 0x0: /* MLA */
-    case 0x4: /* MLS */
-        if (!u || is_scalar) {
+    switch (16 * u + opcode) {
+    case 0x08: /* MUL */
+    case 0x10: /* MLA */
+    case 0x14: /* MLS */
+        if (is_scalar) {
             unallocated_encoding(s);
             return;
         }
         break;
-    case 0x2: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
-    case 0x6: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
-    case 0xa: /* SMULL, SMULL2, UMULL, UMULL2 */
+    case 0x02: /* SMLAL, SMLAL2 */
+    case 0x12: /* UMLAL, UMLAL2 */
+    case 0x06: /* SMLSL, SMLSL2 */
+    case 0x16: /* UMLSL, UMLSL2 */
+    case 0x0a: /* SMULL, SMULL2 */
+    case 0x1a: /* UMULL, UMULL2 */
         if (is_scalar) {
             unallocated_encoding(s);
             return;
         }
         is_long = true;
         break;
-    case 0x3: /* SQDMLAL, SQDMLAL2 */
-    case 0x7: /* SQDMLSL, SQDMLSL2 */
-    case 0xb: /* SQDMULL, SQDMULL2 */
+    case 0x03: /* SQDMLAL, SQDMLAL2 */
+    case 0x07: /* SQDMLSL, SQDMLSL2 */
+    case 0x0b: /* SQDMULL, SQDMULL2 */
         is_long = true;
-        /* fall through */
-    case 0xc: /* SQDMULH */
-    case 0xd: /* SQRDMULH */
-        if (u) {
-            unallocated_encoding(s);
-            return;
-        }
         break;
-    case 0x8: /* MUL */
-        if (u || is_scalar) {
-            unallocated_encoding(s);
-            return;
-        }
+    case 0x0c: /* SQDMULH */
+    case 0x0d: /* SQRDMULH */
         break;
-    case 0x1: /* FMLA */
-    case 0x5: /* FMLS */
-        if (u) {
-            unallocated_encoding(s);
-            return;
-        }
-        /* fall through */
-    case 0x9: /* FMUL, FMULX */
+    case 0x01: /* FMLA */
+    case 0x05: /* FMLS */
+    case 0x09: /* FMUL */
+    case 0x19: /* FMULX */
         if (size == 1) {
             unallocated_encoding(s);
             return;
@@ -11909,21 +11899,20 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
 
             read_vec_element(s, tcg_op, rn, pass, MO_64);
 
-            switch (opcode) {
-            case 0x5: /* FMLS */
+            switch (16 * u + opcode) {
+            case 0x05: /* FMLS */
                 /* As usual for ARM, separate negation for fused multiply-add */
                 gen_helper_vfp_negd(tcg_op, tcg_op);
                 /* fall through */
-            case 0x1: /* FMLA */
+            case 0x01: /* FMLA */
                 read_vec_element(s, tcg_res, rd, pass, MO_64);
                 gen_helper_vfp_muladdd(tcg_res, tcg_op, tcg_idx, tcg_res, fpst);
                 break;
-            case 0x9: /* FMUL, FMULX */
-                if (u) {
-                    gen_helper_vfp_mulxd(tcg_res, tcg_op, tcg_idx, fpst);
-                } else {
-                    gen_helper_vfp_muld(tcg_res, tcg_op, tcg_idx, fpst);
-                }
+            case 0x09: /* FMUL */
+                gen_helper_vfp_muld(tcg_res, tcg_op, tcg_idx, fpst);
+                break;
+            case 0x19: /* FMULX */
+                gen_helper_vfp_mulxd(tcg_res, tcg_op, tcg_idx, fpst);
                 break;
             default:
                 g_assert_not_reached();
@@ -11966,10 +11955,10 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
 
             read_vec_element_i32(s, tcg_op, rn, pass, is_scalar ? size : MO_32);
 
-            switch (opcode) {
-            case 0x0: /* MLA */
-            case 0x4: /* MLS */
-            case 0x8: /* MUL */
+            switch (16 * u + opcode) {
+            case 0x08: /* MUL */
+            case 0x10: /* MLA */
+            case 0x14: /* MLS */
             {
                 static NeonGenTwoOpFn * const fns[2][2] = {
                     { gen_helper_neon_add_u16, gen_helper_neon_sub_u16 },
@@ -11991,8 +11980,8 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                 genfn(tcg_res, tcg_op, tcg_res);
                 break;
             }
-            case 0x5: /* FMLS */
-            case 0x1: /* FMLA */
+            case 0x05: /* FMLS */
+            case 0x01: /* FMLA */
                 read_vec_element_i32(s, tcg_res, rd, pass,
                                      is_scalar ? size : MO_32);
                 switch (size) {
@@ -12023,39 +12012,43 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                     g_assert_not_reached();
                 }
                 break;
-            case 0x9: /* FMUL, FMULX */
+            case 0x09: /* FMUL */
                 switch (size) {
                 case 1:
-                    if (u) {
-                        if (is_scalar) {
-                            gen_helper_advsimd_mulxh(tcg_res, tcg_op,
-                                                     tcg_idx, fpst);
-                        } else {
-                            gen_helper_advsimd_mulx2h(tcg_res, tcg_op,
-                                                      tcg_idx, fpst);
-                        }
+                    if (is_scalar) {
+                        gen_helper_advsimd_mulh(tcg_res, tcg_op,
+                                                tcg_idx, fpst);
                     } else {
-                        if (is_scalar) {
-                            gen_helper_advsimd_mulh(tcg_res, tcg_op,
-                                                    tcg_idx, fpst);
-                        } else {
-                            gen_helper_advsimd_mul2h(tcg_res, tcg_op,
-                                                     tcg_idx, fpst);
-                        }
+                        gen_helper_advsimd_mul2h(tcg_res, tcg_op,
+                                                 tcg_idx, fpst);
                     }
                     break;
                 case 2:
-                    if (u) {
-                        gen_helper_vfp_mulxs(tcg_res, tcg_op, tcg_idx, fpst);
-                    } else {
-                        gen_helper_vfp_muls(tcg_res, tcg_op, tcg_idx, fpst);
-                    }
+                    gen_helper_vfp_muls(tcg_res, tcg_op, tcg_idx, fpst);
                     break;
                 default:
                     g_assert_not_reached();
                 }
                 break;
-            case 0xc: /* SQDMULH */
+            case 0x19: /* FMULX */
+                switch (size) {
+                case 1:
+                    if (is_scalar) {
+                        gen_helper_advsimd_mulxh(tcg_res, tcg_op,
+                                                 tcg_idx, fpst);
+                    } else {
+                        gen_helper_advsimd_mulx2h(tcg_res, tcg_op,
+                                                  tcg_idx, fpst);
+                    }
+                    break;
+                case 2:
+                    gen_helper_vfp_mulxs(tcg_res, tcg_op, tcg_idx, fpst);
+                    break;
+                default:
+                    g_assert_not_reached();
+                }
+                break;
+            case 0x0c: /* SQDMULH */
                 if (size == 1) {
                     gen_helper_neon_qdmulh_s16(tcg_res, cpu_env,
                                                tcg_op, tcg_idx);
@@ -12064,7 +12057,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                                                tcg_op, tcg_idx);
                 }
                 break;
-            case 0xd: /* SQRDMULH */
+            case 0x0d: /* SQRDMULH */
                 if (size == 1) {
                     gen_helper_neon_qrdmulh_s16(tcg_res, cpu_env,
                                                 tcg_op, tcg_idx);
-- 
2.16.2
