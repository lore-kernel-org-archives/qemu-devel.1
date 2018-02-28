Received: from eggs.gnu.org ([2001:4830:134:3::10]:35445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7Rt-0003FK-MU
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7Rs-0006FM-1k
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:33 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:36214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er7Rr-0006Eq-QL
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:31 -0500
Received: by mail-pl0-x243.google.com with SMTP id 61-v6so2126122plf.3
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 11:31:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 28 Feb 2018 11:31:11 -0800
Message-Id: <20180228193125.20577-3-richard.henderson@linaro.org>
In-Reply-To: <20180228193125.20577-1-richard.henderson@linaro.org>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 02/16] target/arm: Refactor
 disas_simd_indexed decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Include the U bit in the switches rather than testing separately.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.14.3
