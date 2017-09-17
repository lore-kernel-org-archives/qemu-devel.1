Received: from eggs.gnu.org ([2001:4830:134:3::10]:52808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb9C-0008CB-Vt
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb98-0008My-EO
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:06:14 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:48982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dtb98-0008MO-1x
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:06:10 -0400
Received: by mail-oi0-x236.google.com with SMTP id v66so3689009oig.5
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 08:06:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 17 Sep 2017 08:05:35 -0700
Message-Id: <20170917150535.8284-18-richard.henderson@linaro.org>
In-Reply-To: <20170917150535.8284-1-richard.henderson@linaro.org>
References: <20170917150535.8284-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 17/17] tcg/mips: Fully convert tcg_target_op_def
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.inc.c | 324 ++++++++++++++++++++++++----------------------
 1 file changed, 170 insertions(+), 154 deletions(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 1c09ec7d5b..ce4030602f 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -2163,166 +2163,182 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
-static const TCGTargetOpDef mips_op_defs[] = {
-    { INDEX_op_exit_tb, { } },
-    { INDEX_op_goto_tb, { } },
-    { INDEX_op_br, { } },
-    { INDEX_op_goto_ptr, { "r" } },
-
-    { INDEX_op_ld8u_i32, { "r", "r" } },
-    { INDEX_op_ld8s_i32, { "r", "r" } },
-    { INDEX_op_ld16u_i32, { "r", "r" } },
-    { INDEX_op_ld16s_i32, { "r", "r" } },
-    { INDEX_op_ld_i32, { "r", "r" } },
-    { INDEX_op_st8_i32, { "rZ", "r" } },
-    { INDEX_op_st16_i32, { "rZ", "r" } },
-    { INDEX_op_st_i32, { "rZ", "r" } },
-
-    { INDEX_op_add_i32, { "r", "rZ", "rJ" } },
-    { INDEX_op_mul_i32, { "r", "rZ", "rZ" } },
-#if !use_mips32r6_instructions
-    { INDEX_op_muls2_i32, { "r", "r", "rZ", "rZ" } },
-    { INDEX_op_mulu2_i32, { "r", "r", "rZ", "rZ" } },
-#endif
-    { INDEX_op_mulsh_i32, { "r", "rZ", "rZ" } },
-    { INDEX_op_muluh_i32, { "r", "rZ", "rZ" } },
-    { INDEX_op_div_i32, { "r", "rZ", "rZ" } },
-    { INDEX_op_divu_i32, { "r", "rZ", "rZ" } },
-    { INDEX_op_rem_i32, { "r", "rZ", "rZ" } },
-    { INDEX_op_remu_i32, { "r", "rZ", "rZ" } },
-    { INDEX_op_sub_i32, { "r", "rZ", "rN" } },
-
-    { INDEX_op_and_i32, { "r", "rZ", "rIK" } },
-    { INDEX_op_nor_i32, { "r", "rZ", "rZ" } },
-    { INDEX_op_not_i32, { "r", "rZ" } },
-    { INDEX_op_or_i32, { "r", "rZ", "rIZ" } },
-    { INDEX_op_xor_i32, { "r", "rZ", "rIZ" } },
-
-    { INDEX_op_shl_i32, { "r", "rZ", "ri" } },
-    { INDEX_op_shr_i32, { "r", "rZ", "ri" } },
-    { INDEX_op_sar_i32, { "r", "rZ", "ri" } },
-    { INDEX_op_rotr_i32, { "r", "rZ", "ri" } },
-    { INDEX_op_rotl_i32, { "r", "rZ", "ri" } },
-    { INDEX_op_clz_i32,  { "r", "r", "rWZ" } },
-
-    { INDEX_op_bswap16_i32, { "r", "r" } },
-    { INDEX_op_bswap32_i32, { "r", "r" } },
-
-    { INDEX_op_ext8s_i32, { "r", "rZ" } },
-    { INDEX_op_ext16s_i32, { "r", "rZ" } },
-
-    { INDEX_op_deposit_i32, { "r", "0", "rZ" } },
-    { INDEX_op_extract_i32, { "r", "r" } },
-
-    { INDEX_op_brcond_i32, { "rZ", "rZ" } },
-#if use_mips32r6_instructions
-    { INDEX_op_movcond_i32, { "r", "rZ", "rZ", "rZ", "rZ" } },
-#else
-    { INDEX_op_movcond_i32, { "r", "rZ", "rZ", "rZ", "0" } },
-#endif
-    { INDEX_op_setcond_i32, { "r", "rZ", "rZ" } },
+static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
+{
+    static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
+    static const TCGTargetOpDef r_r = { .args_ct_str = { "r", "r" } };
+    static const TCGTargetOpDef r_L = { .args_ct_str = { "r", "L" } };
+    static const TCGTargetOpDef rZ_r = { .args_ct_str = { "rZ", "r" } };
+    static const TCGTargetOpDef SZ_S = { .args_ct_str = { "SZ", "S" } };
+    static const TCGTargetOpDef rZ_rZ = { .args_ct_str = { "rZ", "rZ" } };
+    static const TCGTargetOpDef r_r_L = { .args_ct_str = { "r", "r", "L" } };
+    static const TCGTargetOpDef r_L_L = { .args_ct_str = { "r", "L", "L" } };
+    static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
+    static const TCGTargetOpDef r_r_rI = { .args_ct_str = { "r", "r", "rI" } };
+    static const TCGTargetOpDef r_r_rJ = { .args_ct_str = { "r", "r", "rJ" } };
+    static const TCGTargetOpDef SZ_S_S = { .args_ct_str = { "SZ", "S", "S" } };
+    static const TCGTargetOpDef SZ_SZ_S
+        = { .args_ct_str = { "SZ", "SZ", "S" } };
+    static const TCGTargetOpDef SZ_SZ_S_S
+        = { .args_ct_str = { "SZ", "SZ", "S", "S" } };
+    static const TCGTargetOpDef r_rZ_rN
+        = { .args_ct_str = { "r", "rZ", "rN" } };
+    static const TCGTargetOpDef r_rZ_rZ
+        = { .args_ct_str = { "r", "rZ", "rZ" } };
+    static const TCGTargetOpDef r_r_rIK
+        = { .args_ct_str = { "r", "r", "rIK" } };
+    static const TCGTargetOpDef r_r_rWZ
+        = { .args_ct_str = { "r", "r", "rWZ" } };
+    static const TCGTargetOpDef r_r_r_r
+        = { .args_ct_str = { "r", "r", "r", "r" } };
+    static const TCGTargetOpDef r_r_L_L
+        = { .args_ct_str = { "r", "r", "L", "L" } };
+    static const TCGTargetOpDef dep
+        = { .args_ct_str = { "r", "0", "rZ" } };
+    static const TCGTargetOpDef movc
+        = { .args_ct_str = { "r", "rZ", "rZ", "rZ", "0" } };
+    static const TCGTargetOpDef movc_r6
+        = { .args_ct_str = { "r", "rZ", "rZ", "rZ", "rZ" } };
+    static const TCGTargetOpDef add2
+        = { .args_ct_str = { "r", "r", "rZ", "rZ", "rN", "rN" } };
+    static const TCGTargetOpDef br2
+        = { .args_ct_str = { "rZ", "rZ", "rZ", "rZ" } };
+    static const TCGTargetOpDef setc2
+        = { .args_ct_str = { "r", "rZ", "rZ", "rZ", "rZ" } };
+
+    switch (op) {
+    case INDEX_op_goto_ptr:
+        return &r;
 
-#if TCG_TARGET_REG_BITS == 32
-    { INDEX_op_add2_i32, { "r", "r", "rZ", "rZ", "rN", "rN" } },
-    { INDEX_op_sub2_i32, { "r", "r", "rZ", "rZ", "rN", "rN" } },
-    { INDEX_op_setcond2_i32, { "r", "rZ", "rZ", "rZ", "rZ" } },
-    { INDEX_op_brcond2_i32, { "rZ", "rZ", "rZ", "rZ" } },
-#endif
+    case INDEX_op_ld8u_i32:
+    case INDEX_op_ld8s_i32:
+    case INDEX_op_ld16u_i32:
+    case INDEX_op_ld16s_i32:
+    case INDEX_op_ld_i32:
+    case INDEX_op_not_i32:
+    case INDEX_op_bswap16_i32:
+    case INDEX_op_bswap32_i32:
+    case INDEX_op_ext8s_i32:
+    case INDEX_op_ext16s_i32:
+    case INDEX_op_extract_i32:
+    case INDEX_op_ld8u_i64:
+    case INDEX_op_ld8s_i64:
+    case INDEX_op_ld16u_i64:
+    case INDEX_op_ld16s_i64:
+    case INDEX_op_ld32s_i64:
+    case INDEX_op_ld32u_i64:
+    case INDEX_op_ld_i64:
+    case INDEX_op_not_i64:
+    case INDEX_op_bswap16_i64:
+    case INDEX_op_bswap32_i64:
+    case INDEX_op_bswap64_i64:
+    case INDEX_op_ext8s_i64:
+    case INDEX_op_ext16s_i64:
+    case INDEX_op_ext32s_i64:
+    case INDEX_op_ext32u_i64:
+    case INDEX_op_ext_i32_i64:
+    case INDEX_op_extu_i32_i64:
+    case INDEX_op_extrl_i64_i32:
+    case INDEX_op_extrh_i64_i32:
+    case INDEX_op_extract_i64:
+        return &r_r;
 
-#if TCG_TARGET_REG_BITS == 64
-    { INDEX_op_ld8u_i64, { "r", "r" } },
-    { INDEX_op_ld8s_i64, { "r", "r" } },
-    { INDEX_op_ld16u_i64, { "r", "r" } },
-    { INDEX_op_ld16s_i64, { "r", "r" } },
-    { INDEX_op_ld32s_i64, { "r", "r" } },
-    { INDEX_op_ld32u_i64, { "r", "r" } },
-    { INDEX_op_ld_i64, { "r", "r" } },
-    { INDEX_op_st8_i64, { "rZ", "r" } },
-    { INDEX_op_st16_i64, { "rZ", "r" } },
-    { INDEX_op_st32_i64, { "rZ", "r" } },
-    { INDEX_op_st_i64, { "rZ", "r" } },
-
-    { INDEX_op_add_i64, { "r", "rZ", "rJ" } },
-    { INDEX_op_mul_i64, { "r", "rZ", "rZ" } },
-#if !use_mips32r6_instructions
-    { INDEX_op_muls2_i64, { "r", "r", "rZ", "rZ" } },
-    { INDEX_op_mulu2_i64, { "r", "r", "rZ", "rZ" } },
-#endif
-    { INDEX_op_mulsh_i64, { "r", "rZ", "rZ" } },
-    { INDEX_op_muluh_i64, { "r", "rZ", "rZ" } },
-    { INDEX_op_div_i64, { "r", "rZ", "rZ" } },
-    { INDEX_op_divu_i64, { "r", "rZ", "rZ" } },
-    { INDEX_op_rem_i64, { "r", "rZ", "rZ" } },
-    { INDEX_op_remu_i64, { "r", "rZ", "rZ" } },
-    { INDEX_op_sub_i64, { "r", "rZ", "rN" } },
-
-    { INDEX_op_and_i64, { "r", "rZ", "rIK" } },
-    { INDEX_op_nor_i64, { "r", "rZ", "rZ" } },
-    { INDEX_op_not_i64, { "r", "rZ" } },
-    { INDEX_op_or_i64, { "r", "rZ", "rI" } },
-    { INDEX_op_xor_i64, { "r", "rZ", "rI" } },
-
-    { INDEX_op_shl_i64, { "r", "rZ", "ri" } },
-    { INDEX_op_shr_i64, { "r", "rZ", "ri" } },
-    { INDEX_op_sar_i64, { "r", "rZ", "ri" } },
-    { INDEX_op_rotr_i64, { "r", "rZ", "ri" } },
-    { INDEX_op_rotl_i64, { "r", "rZ", "ri" } },
-    { INDEX_op_clz_i64,  { "r", "r", "rWZ" } },
-
-    { INDEX_op_bswap16_i64, { "r", "r" } },
-    { INDEX_op_bswap32_i64, { "r", "r" } },
-    { INDEX_op_bswap64_i64, { "r", "r" } },
-
-    { INDEX_op_ext8s_i64, { "r", "rZ" } },
-    { INDEX_op_ext16s_i64, { "r", "rZ" } },
-    { INDEX_op_ext32s_i64, { "r", "rZ" } },
-    { INDEX_op_ext32u_i64, { "r", "rZ" } },
-    { INDEX_op_ext_i32_i64, { "r", "rZ" } },
-    { INDEX_op_extu_i32_i64, { "r", "rZ" } },
-    { INDEX_op_extrl_i64_i32, { "r", "rZ" } },
-    { INDEX_op_extrh_i64_i32, { "r", "rZ" } },
-
-    { INDEX_op_deposit_i64, { "r", "0", "rZ" } },
-    { INDEX_op_extract_i64, { "r", "r" } },
-
-    { INDEX_op_brcond_i64, { "rZ", "rZ" } },
-#if use_mips32r6_instructions
-    { INDEX_op_movcond_i64, { "r", "rZ", "rZ", "rZ", "rZ" } },
-#else
-    { INDEX_op_movcond_i64, { "r", "rZ", "rZ", "rZ", "0" } },
-#endif
-    { INDEX_op_setcond_i64, { "r", "rZ", "rZ" } },
-
-    { INDEX_op_qemu_ld_i32, { "r", "LZ" } },
-    { INDEX_op_qemu_st_i32, { "SZ", "SZ" } },
-    { INDEX_op_qemu_ld_i64, { "r", "LZ" } },
-    { INDEX_op_qemu_st_i64, { "SZ", "SZ" } },
-#elif TARGET_LONG_BITS == 32
-    { INDEX_op_qemu_ld_i32, { "r", "LZ" } },
-    { INDEX_op_qemu_st_i32, { "SZ", "SZ" } },
-    { INDEX_op_qemu_ld_i64, { "r", "r", "LZ" } },
-    { INDEX_op_qemu_st_i64, { "SZ", "SZ", "SZ" } },
-#else
-    { INDEX_op_qemu_ld_i32, { "r", "LZ", "LZ" } },
-    { INDEX_op_qemu_st_i32, { "SZ", "SZ", "SZ" } },
-    { INDEX_op_qemu_ld_i64, { "r", "r", "LZ", "LZ" } },
-    { INDEX_op_qemu_st_i64, { "SZ", "SZ", "SZ", "SZ" } },
-#endif
+    case INDEX_op_st8_i32:
+    case INDEX_op_st16_i32:
+    case INDEX_op_st_i32:
+    case INDEX_op_st8_i64:
+    case INDEX_op_st16_i64:
+    case INDEX_op_st32_i64:
+    case INDEX_op_st_i64:
+        return &rZ_r;
 
-    { INDEX_op_mb, { } },
-    { -1 },
-};
+    case INDEX_op_add_i32:
+    case INDEX_op_add_i64:
+        return &r_r_rJ;
+    case INDEX_op_sub_i32:
+    case INDEX_op_sub_i64:
+        return &r_rZ_rN;
+    case INDEX_op_mul_i32:
+    case INDEX_op_mulsh_i32:
+    case INDEX_op_muluh_i32:
+    case INDEX_op_div_i32:
+    case INDEX_op_divu_i32:
+    case INDEX_op_rem_i32:
+    case INDEX_op_remu_i32:
+    case INDEX_op_nor_i32:
+    case INDEX_op_setcond_i32:
+    case INDEX_op_mul_i64:
+    case INDEX_op_mulsh_i64:
+    case INDEX_op_muluh_i64:
+    case INDEX_op_div_i64:
+    case INDEX_op_divu_i64:
+    case INDEX_op_rem_i64:
+    case INDEX_op_remu_i64:
+    case INDEX_op_nor_i64:
+    case INDEX_op_setcond_i64:
+        return &r_rZ_rZ;
+    case INDEX_op_muls2_i32:
+    case INDEX_op_mulu2_i32:
+    case INDEX_op_muls2_i64:
+    case INDEX_op_mulu2_i64:
+        return &r_r_r_r;
+    case INDEX_op_and_i32:
+    case INDEX_op_and_i64:
+        return &r_r_rIK;
+    case INDEX_op_or_i32:
+    case INDEX_op_xor_i32:
+    case INDEX_op_or_i64:
+    case INDEX_op_xor_i64:
+        return &r_r_rI;
+    case INDEX_op_shl_i32:
+    case INDEX_op_shr_i32:
+    case INDEX_op_sar_i32:
+    case INDEX_op_rotr_i32:
+    case INDEX_op_rotl_i32:
+    case INDEX_op_shl_i64:
+    case INDEX_op_shr_i64:
+    case INDEX_op_sar_i64:
+    case INDEX_op_rotr_i64:
+    case INDEX_op_rotl_i64:
+        return &r_r_ri;
+    case INDEX_op_clz_i32:
+    case INDEX_op_clz_i64:
+        return &r_r_rWZ;
 
-static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
-{
-    int i, n = ARRAY_SIZE(mips_op_defs);
+    case INDEX_op_deposit_i32:
+    case INDEX_op_deposit_i64:
+        return &dep;
+    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond_i64:
+        return &rZ_rZ;
+    case INDEX_op_movcond_i32:
+    case INDEX_op_movcond_i64:
+        return use_mips32r6_instructions ? &movc_r6 : &movc;
 
-    for (i = 0; i < n; ++i) {
-        if (mips_op_defs[i].op == op) {
-            return &mips_op_defs[i];
-        }
+    case INDEX_op_add2_i32:
+    case INDEX_op_sub2_i32:
+        return &add2;
+    case INDEX_op_setcond2_i32:
+        return &setc2;
+    case INDEX_op_brcond2_i32:
+        return &br2;
+
+    case INDEX_op_qemu_ld_i32:
+        return (TCG_TARGET_REG_BITS == 64 || TARGET_LONG_BITS == 32
+                ? &r_L : &r_L_L);
+    case INDEX_op_qemu_st_i32:
+        return (TCG_TARGET_REG_BITS == 64 || TARGET_LONG_BITS == 32
+                ? &SZ_S : &SZ_S_S);
+    case INDEX_op_qemu_ld_i64:
+        return (TCG_TARGET_REG_BITS == 64 ? &r_L
+                : TARGET_LONG_BITS == 32 ? &r_r_L : &r_r_L_L);
+    case INDEX_op_qemu_st_i64:
+        return (TCG_TARGET_REG_BITS == 64 ? &SZ_S
+                : TARGET_LONG_BITS == 32 ? &SZ_SZ_S : &SZ_SZ_S_S);
+
+    default:
+        return NULL;
     }
-    return NULL;
 }
 
 static int tcg_target_callee_save_regs[] = {
-- 
2.13.5
