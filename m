Received: from eggs.gnu.org ([2001:4830:134:3::10]:45507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEfTR-0007Sk-K7
	for qemu-devel@nongnu.org; Fri, 04 May 2018 14:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEfTQ-00014h-De
	for qemu-devel@nongnu.org; Fri, 04 May 2018 14:30:29 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:40582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEfTQ-00014J-5n
	for qemu-devel@nongnu.org; Fri, 04 May 2018 14:30:28 -0400
Received: by mail-pg0-x241.google.com with SMTP id l2-v6so15967712pgc.7
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 11:30:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  4 May 2018 11:30:13 -0700
Message-Id: <20180504183021.19318-3-richard.henderson@linaro.org>
In-Reply-To: <20180504183021.19318-1-richard.henderson@linaro.org>
References: <20180504183021.19318-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 02/10] target/arm: Use new min/max expanders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

The generic expanders replace nearly identical code in the translator.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 46 ++++++++++++++--------------------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index bff4e13bf6..d916fea3a3 100644
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
@@ -9931,27 +9934,6 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
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
@@ -10051,7 +10033,7 @@ static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
                 static NeonGenTwoOpFn * const fns[3][2] = {
                     { gen_helper_neon_pmax_s8, gen_helper_neon_pmax_u8 },
                     { gen_helper_neon_pmax_s16, gen_helper_neon_pmax_u16 },
-                    { gen_max_s32, gen_max_u32 },
+                    { tcg_gen_smax_i32, tcg_gen_umax_i32 },
                 };
                 genfn = fns[size][u];
                 break;
@@ -10061,7 +10043,7 @@ static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
                 static NeonGenTwoOpFn * const fns[3][2] = {
                     { gen_helper_neon_pmin_s8, gen_helper_neon_pmin_u8 },
                     { gen_helper_neon_pmin_s16, gen_helper_neon_pmin_u16 },
-                    { gen_min_s32, gen_min_u32 },
+                    { tcg_gen_smin_i32, tcg_gen_umin_i32 },
                 };
                 genfn = fns[size][u];
                 break;
@@ -10516,7 +10498,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 static NeonGenTwoOpFn * const fns[3][2] = {
                     { gen_helper_neon_max_s8, gen_helper_neon_max_u8 },
                     { gen_helper_neon_max_s16, gen_helper_neon_max_u16 },
-                    { gen_max_s32, gen_max_u32 },
+                    { tcg_gen_smax_i32, tcg_gen_umax_i32 },
                 };
                 genfn = fns[size][u];
                 break;
@@ -10527,7 +10509,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 static NeonGenTwoOpFn * const fns[3][2] = {
                     { gen_helper_neon_min_s8, gen_helper_neon_min_u8 },
                     { gen_helper_neon_min_s16, gen_helper_neon_min_u16 },
-                    { gen_min_s32, gen_min_u32 },
+                    { tcg_gen_smin_i32, tcg_gen_umin_i32 },
                 };
                 genfn = fns[size][u];
                 break;
-- 
2.14.3
