Received: from eggs.gnu.org ([2001:4830:134:3::10]:37760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsZNl-0003cF-Jl
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsZNj-0006J5-BR
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:01:01 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:53421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsZNj-0006Ia-3V
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:00:59 -0400
Received: by mail-pg0-x232.google.com with SMTP id j70so150681pgc.10
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 12:00:58 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-103-167.tukw.qwest.net.
	[97.126.103.167]) by smtp.gmail.com with ESMTPSA id
	m24sm32941520pfj.28.2017.09.14.12.00.56 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 14 Sep 2017 12:00:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Sep 2017 12:00:51 -0700
Message-Id: <20170914190053.27625-3-richard.henderson@linaro.org>
In-Reply-To: <20170914190053.27625-1-richard.henderson@linaro.org>
References: <20170914190053.27625-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/4] tcg/ppc: Fully convert tcg_target_op_def
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 321 +++++++++++++++++++++++++----------------------
 1 file changed, 168 insertions(+), 153 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 8ffc7a7205..879885b68b 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -2596,166 +2596,181 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
     }
 }
 
-static const TCGTargetOpDef ppc_op_defs[] = {
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
-
-    { INDEX_op_st8_i32, { "r", "r" } },
-    { INDEX_op_st16_i32, { "r", "r" } },
-    { INDEX_op_st_i32, { "r", "r" } },
-
-    { INDEX_op_add_i32, { "r", "r", "ri" } },
-    { INDEX_op_mul_i32, { "r", "r", "rI" } },
-    { INDEX_op_div_i32, { "r", "r", "r" } },
-    { INDEX_op_divu_i32, { "r", "r", "r" } },
-    { INDEX_op_sub_i32, { "r", "rI", "ri" } },
-    { INDEX_op_and_i32, { "r", "r", "ri" } },
-    { INDEX_op_or_i32, { "r", "r", "ri" } },
-    { INDEX_op_xor_i32, { "r", "r", "ri" } },
-    { INDEX_op_andc_i32, { "r", "r", "ri" } },
-    { INDEX_op_orc_i32, { "r", "r", "ri" } },
-    { INDEX_op_eqv_i32, { "r", "r", "ri" } },
-    { INDEX_op_nand_i32, { "r", "r", "r" } },
-    { INDEX_op_nor_i32, { "r", "r", "r" } },
-    { INDEX_op_clz_i32, { "r", "r", "rZW" } },
-    { INDEX_op_ctz_i32, { "r", "r", "rZW" } },
-    { INDEX_op_ctpop_i32, { "r", "r" } },
-
-    { INDEX_op_shl_i32, { "r", "r", "ri" } },
-    { INDEX_op_shr_i32, { "r", "r", "ri" } },
-    { INDEX_op_sar_i32, { "r", "r", "ri" } },
-    { INDEX_op_rotl_i32, { "r", "r", "ri" } },
-    { INDEX_op_rotr_i32, { "r", "r", "ri" } },
-
-    { INDEX_op_neg_i32, { "r", "r" } },
-    { INDEX_op_not_i32, { "r", "r" } },
-    { INDEX_op_ext8s_i32, { "r", "r" } },
-    { INDEX_op_ext16s_i32, { "r", "r" } },
-    { INDEX_op_bswap16_i32, { "r", "r" } },
-    { INDEX_op_bswap32_i32, { "r", "r" } },
-
-    { INDEX_op_brcond_i32, { "r", "ri" } },
-    { INDEX_op_setcond_i32, { "r", "r", "ri" } },
-    { INDEX_op_movcond_i32, { "r", "r", "ri", "rZ", "rZ" } },
-
-    { INDEX_op_deposit_i32, { "r", "0", "rZ" } },
-    { INDEX_op_extract_i32, { "r", "r" } },
-
-    { INDEX_op_muluh_i32, { "r", "r", "r" } },
-    { INDEX_op_mulsh_i32, { "r", "r", "r" } },
-
-#if TCG_TARGET_REG_BITS == 64
-    { INDEX_op_ld8u_i64, { "r", "r" } },
-    { INDEX_op_ld8s_i64, { "r", "r" } },
-    { INDEX_op_ld16u_i64, { "r", "r" } },
-    { INDEX_op_ld16s_i64, { "r", "r" } },
-    { INDEX_op_ld32u_i64, { "r", "r" } },
-    { INDEX_op_ld32s_i64, { "r", "r" } },
-    { INDEX_op_ld_i64, { "r", "r" } },
-
-    { INDEX_op_st8_i64, { "r", "r" } },
-    { INDEX_op_st16_i64, { "r", "r" } },
-    { INDEX_op_st32_i64, { "r", "r" } },
-    { INDEX_op_st_i64, { "r", "r" } },
-
-    { INDEX_op_add_i64, { "r", "r", "rT" } },
-    { INDEX_op_sub_i64, { "r", "rI", "rT" } },
-    { INDEX_op_and_i64, { "r", "r", "ri" } },
-    { INDEX_op_or_i64, { "r", "r", "rU" } },
-    { INDEX_op_xor_i64, { "r", "r", "rU" } },
-    { INDEX_op_andc_i64, { "r", "r", "ri" } },
-    { INDEX_op_orc_i64, { "r", "r", "r" } },
-    { INDEX_op_eqv_i64, { "r", "r", "r" } },
-    { INDEX_op_nand_i64, { "r", "r", "r" } },
-    { INDEX_op_nor_i64, { "r", "r", "r" } },
-    { INDEX_op_clz_i64, { "r", "r", "rZW" } },
-    { INDEX_op_ctz_i64, { "r", "r", "rZW" } },
-    { INDEX_op_ctpop_i64, { "r", "r" } },
-
-    { INDEX_op_shl_i64, { "r", "r", "ri" } },
-    { INDEX_op_shr_i64, { "r", "r", "ri" } },
-    { INDEX_op_sar_i64, { "r", "r", "ri" } },
-    { INDEX_op_rotl_i64, { "r", "r", "ri" } },
-    { INDEX_op_rotr_i64, { "r", "r", "ri" } },
-
-    { INDEX_op_mul_i64, { "r", "r", "rI" } },
-    { INDEX_op_div_i64, { "r", "r", "r" } },
-    { INDEX_op_divu_i64, { "r", "r", "r" } },
-
-    { INDEX_op_neg_i64, { "r", "r" } },
-    { INDEX_op_not_i64, { "r", "r" } },
-    { INDEX_op_ext8s_i64, { "r", "r" } },
-    { INDEX_op_ext16s_i64, { "r", "r" } },
-    { INDEX_op_ext32s_i64, { "r", "r" } },
-    { INDEX_op_ext_i32_i64, { "r", "r" } },
-    { INDEX_op_extu_i32_i64, { "r", "r" } },
-    { INDEX_op_bswap16_i64, { "r", "r" } },
-    { INDEX_op_bswap32_i64, { "r", "r" } },
-    { INDEX_op_bswap64_i64, { "r", "r" } },
-
-    { INDEX_op_brcond_i64, { "r", "ri" } },
-    { INDEX_op_setcond_i64, { "r", "r", "ri" } },
-    { INDEX_op_movcond_i64, { "r", "r", "ri", "rZ", "rZ" } },
-
-    { INDEX_op_deposit_i64, { "r", "0", "rZ" } },
-    { INDEX_op_extract_i64, { "r", "r" } },
-
-    { INDEX_op_mulsh_i64, { "r", "r", "r" } },
-    { INDEX_op_muluh_i64, { "r", "r", "r" } },
-#endif
+static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
+{
+    static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
+    static const TCGTargetOpDef r_r = { .args_ct_str = { "r", "r" } };
+    static const TCGTargetOpDef r_L = { .args_ct_str = { "r", "L" } };
+    static const TCGTargetOpDef S_S = { .args_ct_str = { "S", "S" } };
+    static const TCGTargetOpDef r_ri = { .args_ct_str = { "r", "ri" } };
+    static const TCGTargetOpDef r_r_r = { .args_ct_str = { "r", "r", "r" } };
+    static const TCGTargetOpDef r_L_L = { .args_ct_str = { "r", "L", "L" } };
+    static const TCGTargetOpDef L_L_L = { .args_ct_str = { "L", "L", "L" } };
+    static const TCGTargetOpDef S_S_S = { .args_ct_str = { "S", "S", "S" } };
+    static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
+    static const TCGTargetOpDef r_r_rI = { .args_ct_str = { "r", "r", "rI" } };
+    static const TCGTargetOpDef r_r_rT = { .args_ct_str = { "r", "r", "rT" } };
+    static const TCGTargetOpDef r_r_rU = { .args_ct_str = { "r", "r", "rU" } };
+    static const TCGTargetOpDef r_rI_ri
+        = { .args_ct_str = { "r", "rI", "ri" } };
+    static const TCGTargetOpDef r_rI_rT
+        = { .args_ct_str = { "r", "rI", "rT" } };
+    static const TCGTargetOpDef r_r_rZW
+        = { .args_ct_str = { "r", "r", "rZW" } };
+    static const TCGTargetOpDef L_L_L_L
+        = { .args_ct_str = { "L", "L", "L", "L" } };
+    static const TCGTargetOpDef S_S_S_S
+        = { .args_ct_str = { "S", "S", "S", "S" } };
+    static const TCGTargetOpDef movc
+        = { .args_ct_str = { "r", "r", "ri", "rZ", "rZ" } };
+    static const TCGTargetOpDef dep
+        = { .args_ct_str = { "r", "0", "rZ" } };
+    static const TCGTargetOpDef br2
+        = { .args_ct_str = { "r", "r", "ri", "ri" } };
+    static const TCGTargetOpDef setc2
+        = { .args_ct_str = { "r", "r", "r", "ri", "ri" } };
+    static const TCGTargetOpDef add2
+        = { .args_ct_str = { "r", "r", "r", "r", "rI", "rZM" } };
+    static const TCGTargetOpDef sub2
+        = { .args_ct_str = { "r", "r", "rI", "rZM", "r", "r" } };
+
+    switch (op) {
+    case INDEX_op_goto_ptr:
+        return &r;
 
-#if TCG_TARGET_REG_BITS == 32
-    { INDEX_op_brcond2_i32, { "r", "r", "ri", "ri" } },
-    { INDEX_op_setcond2_i32, { "r", "r", "r", "ri", "ri" } },
-#endif
+    case INDEX_op_ld8u_i32:
+    case INDEX_op_ld8s_i32:
+    case INDEX_op_ld16u_i32:
+    case INDEX_op_ld16s_i32:
+    case INDEX_op_ld_i32:
+    case INDEX_op_st8_i32:
+    case INDEX_op_st16_i32:
+    case INDEX_op_st_i32:
+    case INDEX_op_ctpop_i32:
+    case INDEX_op_neg_i32:
+    case INDEX_op_not_i32:
+    case INDEX_op_ext8s_i32:
+    case INDEX_op_ext16s_i32:
+    case INDEX_op_bswap16_i32:
+    case INDEX_op_bswap32_i32:
+    case INDEX_op_extract_i32:
+    case INDEX_op_ld8u_i64:
+    case INDEX_op_ld8s_i64:
+    case INDEX_op_ld16u_i64:
+    case INDEX_op_ld16s_i64:
+    case INDEX_op_ld32u_i64:
+    case INDEX_op_ld32s_i64:
+    case INDEX_op_ld_i64:
+    case INDEX_op_st8_i64:
+    case INDEX_op_st16_i64:
+    case INDEX_op_st32_i64:
+    case INDEX_op_st_i64:
+    case INDEX_op_ctpop_i64:
+    case INDEX_op_neg_i64:
+    case INDEX_op_not_i64:
+    case INDEX_op_ext8s_i64:
+    case INDEX_op_ext16s_i64:
+    case INDEX_op_ext32s_i64:
+    case INDEX_op_ext_i32_i64:
+    case INDEX_op_extu_i32_i64:
+    case INDEX_op_bswap16_i64:
+    case INDEX_op_bswap32_i64:
+    case INDEX_op_bswap64_i64:
+    case INDEX_op_extract_i64:
+        return &r_r;
 
-#if TCG_TARGET_REG_BITS == 64
-    { INDEX_op_add2_i64, { "r", "r", "r", "r", "rI", "rZM" } },
-    { INDEX_op_sub2_i64, { "r", "r", "rI", "rZM", "r", "r" } },
-#else
-    { INDEX_op_add2_i32, { "r", "r", "r", "r", "rI", "rZM" } },
-    { INDEX_op_sub2_i32, { "r", "r", "rI", "rZM", "r", "r" } },
-#endif
+    case INDEX_op_add_i32:
+    case INDEX_op_and_i32:
+    case INDEX_op_or_i32:
+    case INDEX_op_xor_i32:
+    case INDEX_op_andc_i32:
+    case INDEX_op_orc_i32:
+    case INDEX_op_eqv_i32:
+    case INDEX_op_shl_i32:
+    case INDEX_op_shr_i32:
+    case INDEX_op_sar_i32:
+    case INDEX_op_rotl_i32:
+    case INDEX_op_rotr_i32:
+    case INDEX_op_setcond_i32:
+    case INDEX_op_and_i64:
+    case INDEX_op_andc_i64:
+    case INDEX_op_shl_i64:
+    case INDEX_op_shr_i64:
+    case INDEX_op_sar_i64:
+    case INDEX_op_rotl_i64:
+    case INDEX_op_rotr_i64:
+    case INDEX_op_setcond_i64:
+        return &r_r_ri;
+    case INDEX_op_mul_i32:
+    case INDEX_op_mul_i64:
+        return &r_r_rI;
+    case INDEX_op_div_i32:
+    case INDEX_op_divu_i32:
+    case INDEX_op_nand_i32:
+    case INDEX_op_nor_i32:
+    case INDEX_op_muluh_i32:
+    case INDEX_op_mulsh_i32:
+    case INDEX_op_orc_i64:
+    case INDEX_op_eqv_i64:
+    case INDEX_op_nand_i64:
+    case INDEX_op_nor_i64:
+    case INDEX_op_div_i64:
+    case INDEX_op_divu_i64:
+    case INDEX_op_mulsh_i64:
+    case INDEX_op_muluh_i64:
+        return &r_r_r;
+    case INDEX_op_sub_i32:
+        return &r_rI_ri;
+    case INDEX_op_add_i64:
+        return &r_r_rT;
+    case INDEX_op_or_i64:
+    case INDEX_op_xor_i64:
+        return &r_r_rU;
+    case INDEX_op_sub_i64:
+        return &r_rI_rT;
+    case INDEX_op_clz_i32:
+    case INDEX_op_ctz_i32:
+    case INDEX_op_clz_i64:
+    case INDEX_op_ctz_i64:
+        return &r_r_rZW;
 
-#if TCG_TARGET_REG_BITS == 64
-    { INDEX_op_qemu_ld_i32, { "r", "L" } },
-    { INDEX_op_qemu_st_i32, { "S", "S" } },
-    { INDEX_op_qemu_ld_i64, { "r", "L" } },
-    { INDEX_op_qemu_st_i64, { "S", "S" } },
-#elif TARGET_LONG_BITS == 32
-    { INDEX_op_qemu_ld_i32, { "r", "L" } },
-    { INDEX_op_qemu_st_i32, { "S", "S" } },
-    { INDEX_op_qemu_ld_i64, { "L", "L", "L" } },
-    { INDEX_op_qemu_st_i64, { "S", "S", "S" } },
-#else
-    { INDEX_op_qemu_ld_i32, { "r", "L", "L" } },
-    { INDEX_op_qemu_st_i32, { "S", "S", "S" } },
-    { INDEX_op_qemu_ld_i64, { "L", "L", "L", "L" } },
-    { INDEX_op_qemu_st_i64, { "S", "S", "S", "S" } },
-#endif
+    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond_i64:
+        return &r_ri;
 
-    { INDEX_op_mb, { } },
-    { -1 },
-};
+    case INDEX_op_movcond_i32:
+    case INDEX_op_movcond_i64:
+        return &movc;
+    case INDEX_op_deposit_i32:
+    case INDEX_op_deposit_i64:
+        return &dep;
+    case INDEX_op_brcond2_i32:
+        return &br2;
+    case INDEX_op_setcond2_i32:
+        return &setc2;
+    case INDEX_op_add2_i64:
+    case INDEX_op_add2_i32:
+        return &add2;
+    case INDEX_op_sub2_i64:
+    case INDEX_op_sub2_i32:
+        return &sub2;
 
-static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
-{
-    int i, n = ARRAY_SIZE(ppc_op_defs);
+    case INDEX_op_qemu_ld_i32:
+        return (TCG_TARGET_REG_BITS == 64 || TARGET_LONG_BITS == 32
+                ? &r_L : &r_L_L);
+    case INDEX_op_qemu_st_i32:
+        return (TCG_TARGET_REG_BITS == 64 || TARGET_LONG_BITS == 32
+                ? &S_S : &S_S_S);
+    case INDEX_op_qemu_ld_i64:
+        return (TCG_TARGET_REG_BITS == 64 ? &r_L
+                : TARGET_LONG_BITS == 32 ? &L_L_L : &L_L_L_L);
+    case INDEX_op_qemu_st_i64:
+        return (TCG_TARGET_REG_BITS == 64 ? &S_S
+                : TARGET_LONG_BITS == 32 ? &S_S_S : &S_S_S_S);
 
-    for (i = 0; i < n; ++i) {
-        if (ppc_op_defs[i].op == op) {
-            return &ppc_op_defs[i];
-        }
+    default:
+        return NULL;
     }
-    return NULL;
 }
 
 static void tcg_target_init(TCGContext *s)
-- 
2.13.5
