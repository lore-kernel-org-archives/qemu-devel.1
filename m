Received: from eggs.gnu.org ([2001:4830:134:3::10]:48483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpdB-00051G-G1
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpdA-0000rE-DP
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:29 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fGpdA-0000qF-6W
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:28 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd8-0003Wr-Ud
	for qemu-devel@nongnu.org; Thu, 10 May 2018 18:45:26 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 18:45:07 +0100
Message-Id: <20180510174519.11264-10-peter.maydell@linaro.org>
In-Reply-To: <20180510174519.11264-1-peter.maydell@linaro.org>
References: <20180510174519.11264-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 09/21] target/arm: Use new min/max expanders
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

The generic expanders replace nearly identical code in the translator.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180508151437.4232-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 46 ++++++++++++--------------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 6d49f30b4a..60d104cc8a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -6021,15 +6021,18 @@ static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
                 tcg_gen_add_i64(tcg_res, tcg_res, tcg_elt);
                 break;
             case 0x0a: /* SMAXV / UMAXV */
-                tcg_gen_movcond_i64(is_u ? TCG_COND_GEU : TCG_COND_GE,
-                                    tcg_res,
-                                    tcg_res, tcg_elt, tcg_res, tcg_elt);
+                if (is_u) {
+                    tcg_gen_umax_i64(tcg_res, tcg_res, tcg_elt);
+                } else {
+                    tcg_gen_smax_i64(tcg_res, tcg_res, tcg_elt);
+                }
                 break;
             case 0x1a: /* SMINV / UMINV */
-                tcg_gen_movcond_i64(is_u ? TCG_COND_LEU : TCG_COND_LE,
-                                    tcg_res,
-                                    tcg_res, tcg_elt, tcg_res, tcg_elt);
-                break;
+                if (is_u) {
+                    tcg_gen_umin_i64(tcg_res, tcg_res, tcg_elt);
+                } else {
+                    tcg_gen_smin_i64(tcg_res, tcg_res, tcg_elt);
+                }
                 break;
             default:
                 g_assert_not_reached();
@@ -9927,27 +9930,6 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Helper functions for 32 bit comparisons */
-static void gen_max_s32(TCGv_i32 res, TCGv_i32 op1, TCGv_i32 op2)
-{
-    tcg_gen_movcond_i32(TCG_COND_GE, res, op1, op2, op1, op2);
-}
-
-static void gen_max_u32(TCGv_i32 res, TCGv_i32 op1, TCGv_i32 op2)
-{
-    tcg_gen_movcond_i32(TCG_COND_GEU, res, op1, op2, op1, op2);
-}
-
-static void gen_min_s32(TCGv_i32 res, TCGv_i32 op1, TCGv_i32 op2)
-{
-    tcg_gen_movcond_i32(TCG_COND_LE, res, op1, op2, op1, op2);
-}
-
-static void gen_min_u32(TCGv_i32 res, TCGv_i32 op1, TCGv_i32 op2)
-{
-    tcg_gen_movcond_i32(TCG_COND_LEU, res, op1, op2, op1, op2);
-}
-
 /* Pairwise op subgroup of C3.6.16.
  *
  * This is called directly or via the handle_3same_float for float pairwise
@@ -10047,7 +10029,7 @@ static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
                 static NeonGenTwoOpFn * const fns[3][2] = {
                     { gen_helper_neon_pmax_s8, gen_helper_neon_pmax_u8 },
                     { gen_helper_neon_pmax_s16, gen_helper_neon_pmax_u16 },
-                    { gen_max_s32, gen_max_u32 },
+                    { tcg_gen_smax_i32, tcg_gen_umax_i32 },
                 };
                 genfn = fns[size][u];
                 break;
@@ -10057,7 +10039,7 @@ static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
                 static NeonGenTwoOpFn * const fns[3][2] = {
                     { gen_helper_neon_pmin_s8, gen_helper_neon_pmin_u8 },
                     { gen_helper_neon_pmin_s16, gen_helper_neon_pmin_u16 },
-                    { gen_min_s32, gen_min_u32 },
+                    { tcg_gen_smin_i32, tcg_gen_umin_i32 },
                 };
                 genfn = fns[size][u];
                 break;
@@ -10512,7 +10494,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 static NeonGenTwoOpFn * const fns[3][2] = {
                     { gen_helper_neon_max_s8, gen_helper_neon_max_u8 },
                     { gen_helper_neon_max_s16, gen_helper_neon_max_u16 },
-                    { gen_max_s32, gen_max_u32 },
+                    { tcg_gen_smax_i32, tcg_gen_umax_i32 },
                 };
                 genfn = fns[size][u];
                 break;
@@ -10523,7 +10505,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 static NeonGenTwoOpFn * const fns[3][2] = {
                     { gen_helper_neon_min_s8, gen_helper_neon_min_u8 },
                     { gen_helper_neon_min_s16, gen_helper_neon_min_u16 },
-                    { gen_min_s32, gen_min_u32 },
+                    { tcg_gen_smin_i32, tcg_gen_umin_i32 },
                 };
                 genfn = fns[size][u];
                 break;
-- 
2.17.0
