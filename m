Received: from eggs.gnu.org ([2001:4830:134:3::10]:38081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro0D-0001ok-EQ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro0B-00076n-Ar
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:33 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:36711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dro0B-00075S-0P
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:31 -0400
Received: by mail-pf0-x22e.google.com with SMTP id e199so19405543pfh.3
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:25:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Sep 2017 09:25:07 -0700
Message-Id: <20170912162513.21694-11-richard.henderson@linaro.org>
In-Reply-To: <20170912162513.21694-1-richard.henderson@linaro.org>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 10/16] tcg/aarch64: Fully convert
 tcg_target_op_def
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
 tcg/aarch64/tcg-target.inc.c | 282 +++++++++++++++++++++++--------------------
 1 file changed, 151 insertions(+), 131 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index c2f3812214..1ff32e43f5 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1786,141 +1786,161 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 #undef REG0
 }
 
-static const TCGTargetOpDef aarch64_op_defs[] = {
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
-    { INDEX_op_ld8u_i64, { "r", "r" } },
-    { INDEX_op_ld8s_i64, { "r", "r" } },
-    { INDEX_op_ld16u_i64, { "r", "r" } },
-    { INDEX_op_ld16s_i64, { "r", "r" } },
-    { INDEX_op_ld32u_i64, { "r", "r" } },
-    { INDEX_op_ld32s_i64, { "r", "r" } },
-    { INDEX_op_ld_i64, { "r", "r" } },
-
-    { INDEX_op_st8_i32, { "rZ", "r" } },
-    { INDEX_op_st16_i32, { "rZ", "r" } },
-    { INDEX_op_st_i32, { "rZ", "r" } },
-    { INDEX_op_st8_i64, { "rZ", "r" } },
-    { INDEX_op_st16_i64, { "rZ", "r" } },
-    { INDEX_op_st32_i64, { "rZ", "r" } },
-    { INDEX_op_st_i64, { "rZ", "r" } },
-
-    { INDEX_op_add_i32, { "r", "r", "rA" } },
-    { INDEX_op_add_i64, { "r", "r", "rA" } },
-    { INDEX_op_sub_i32, { "r", "r", "rA" } },
-    { INDEX_op_sub_i64, { "r", "r", "rA" } },
-    { INDEX_op_mul_i32, { "r", "r", "r" } },
-    { INDEX_op_mul_i64, { "r", "r", "r" } },
-    { INDEX_op_div_i32, { "r", "r", "r" } },
-    { INDEX_op_div_i64, { "r", "r", "r" } },
-    { INDEX_op_divu_i32, { "r", "r", "r" } },
-    { INDEX_op_divu_i64, { "r", "r", "r" } },
-    { INDEX_op_rem_i32, { "r", "r", "r" } },
-    { INDEX_op_rem_i64, { "r", "r", "r" } },
-    { INDEX_op_remu_i32, { "r", "r", "r" } },
-    { INDEX_op_remu_i64, { "r", "r", "r" } },
-    { INDEX_op_and_i32, { "r", "r", "rL" } },
-    { INDEX_op_and_i64, { "r", "r", "rL" } },
-    { INDEX_op_or_i32, { "r", "r", "rL" } },
-    { INDEX_op_or_i64, { "r", "r", "rL" } },
-    { INDEX_op_xor_i32, { "r", "r", "rL" } },
-    { INDEX_op_xor_i64, { "r", "r", "rL" } },
-    { INDEX_op_andc_i32, { "r", "r", "rL" } },
-    { INDEX_op_andc_i64, { "r", "r", "rL" } },
-    { INDEX_op_orc_i32, { "r", "r", "rL" } },
-    { INDEX_op_orc_i64, { "r", "r", "rL" } },
-    { INDEX_op_eqv_i32, { "r", "r", "rL" } },
-    { INDEX_op_eqv_i64, { "r", "r", "rL" } },
-
-    { INDEX_op_neg_i32, { "r", "r" } },
-    { INDEX_op_neg_i64, { "r", "r" } },
-    { INDEX_op_not_i32, { "r", "r" } },
-    { INDEX_op_not_i64, { "r", "r" } },
-
-    { INDEX_op_shl_i32, { "r", "r", "ri" } },
-    { INDEX_op_shr_i32, { "r", "r", "ri" } },
-    { INDEX_op_sar_i32, { "r", "r", "ri" } },
-    { INDEX_op_rotl_i32, { "r", "r", "ri" } },
-    { INDEX_op_rotr_i32, { "r", "r", "ri" } },
-    { INDEX_op_clz_i32, { "r", "r", "rAL" } },
-    { INDEX_op_ctz_i32, { "r", "r", "rAL" } },
-    { INDEX_op_shl_i64, { "r", "r", "ri" } },
-    { INDEX_op_shr_i64, { "r", "r", "ri" } },
-    { INDEX_op_sar_i64, { "r", "r", "ri" } },
-    { INDEX_op_rotl_i64, { "r", "r", "ri" } },
-    { INDEX_op_rotr_i64, { "r", "r", "ri" } },
-    { INDEX_op_clz_i64, { "r", "r", "rAL" } },
-    { INDEX_op_ctz_i64, { "r", "r", "rAL" } },
-
-    { INDEX_op_brcond_i32, { "r", "rA" } },
-    { INDEX_op_brcond_i64, { "r", "rA" } },
-    { INDEX_op_setcond_i32, { "r", "r", "rA" } },
-    { INDEX_op_setcond_i64, { "r", "r", "rA" } },
-    { INDEX_op_movcond_i32, { "r", "r", "rA", "rZ", "rZ" } },
-    { INDEX_op_movcond_i64, { "r", "r", "rA", "rZ", "rZ" } },
-
-    { INDEX_op_qemu_ld_i32, { "r", "l" } },
-    { INDEX_op_qemu_ld_i64, { "r", "l" } },
-    { INDEX_op_qemu_st_i32, { "lZ", "l" } },
-    { INDEX_op_qemu_st_i64, { "lZ", "l" } },
-
-    { INDEX_op_bswap16_i32, { "r", "r" } },
-    { INDEX_op_bswap32_i32, { "r", "r" } },
-    { INDEX_op_bswap16_i64, { "r", "r" } },
-    { INDEX_op_bswap32_i64, { "r", "r" } },
-    { INDEX_op_bswap64_i64, { "r", "r" } },
-
-    { INDEX_op_ext8s_i32, { "r", "r" } },
-    { INDEX_op_ext16s_i32, { "r", "r" } },
-    { INDEX_op_ext8u_i32, { "r", "r" } },
-    { INDEX_op_ext16u_i32, { "r", "r" } },
-
-    { INDEX_op_ext8s_i64, { "r", "r" } },
-    { INDEX_op_ext16s_i64, { "r", "r" } },
-    { INDEX_op_ext32s_i64, { "r", "r" } },
-    { INDEX_op_ext8u_i64, { "r", "r" } },
-    { INDEX_op_ext16u_i64, { "r", "r" } },
-    { INDEX_op_ext32u_i64, { "r", "r" } },
-    { INDEX_op_ext_i32_i64, { "r", "r" } },
-    { INDEX_op_extu_i32_i64, { "r", "r" } },
-
-    { INDEX_op_deposit_i32, { "r", "0", "rZ" } },
-    { INDEX_op_deposit_i64, { "r", "0", "rZ" } },
-    { INDEX_op_extract_i32, { "r", "r" } },
-    { INDEX_op_extract_i64, { "r", "r" } },
-    { INDEX_op_sextract_i32, { "r", "r" } },
-    { INDEX_op_sextract_i64, { "r", "r" } },
-
-    { INDEX_op_add2_i32, { "r", "r", "rZ", "rZ", "rA", "rMZ" } },
-    { INDEX_op_add2_i64, { "r", "r", "rZ", "rZ", "rA", "rMZ" } },
-    { INDEX_op_sub2_i32, { "r", "r", "rZ", "rZ", "rA", "rMZ" } },
-    { INDEX_op_sub2_i64, { "r", "r", "rZ", "rZ", "rA", "rMZ" } },
-
-    { INDEX_op_muluh_i64, { "r", "r", "r" } },
-    { INDEX_op_mulsh_i64, { "r", "r", "r" } },
-
-    { INDEX_op_mb, { } },
-    { -1 },
-};
-
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
-    int i, n = ARRAY_SIZE(aarch64_op_defs);
+    static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
+    static const TCGTargetOpDef r_r = { .args_ct_str = { "r", "r" } };
+    static const TCGTargetOpDef r_l = { .args_ct_str = { "r", "l" } };
+    static const TCGTargetOpDef r_rA = { .args_ct_str = { "r", "rA" } };
+    static const TCGTargetOpDef rZ_r = { .args_ct_str = { "rZ", "r" } };
+    static const TCGTargetOpDef lZ_l = { .args_ct_str = { "lZ", "l" } };
+    static const TCGTargetOpDef r_r_r = { .args_ct_str = { "r", "r", "r" } };
+    static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
+    static const TCGTargetOpDef r_r_rA = { .args_ct_str = { "r", "r", "rA" } };
+    static const TCGTargetOpDef r_r_rL = { .args_ct_str = { "r", "r", "rL" } };
+    static const TCGTargetOpDef r_r_rAL
+        = { .args_ct_str = { "r", "r", "rAL" } };
+    static const TCGTargetOpDef dep
+        = { .args_ct_str = { "r", "0", "rZ" } };
+    static const TCGTargetOpDef movc
+        = { .args_ct_str = { "r", "r", "rA", "rZ", "rZ" } };
+    static const TCGTargetOpDef add2
+        = { .args_ct_str = { "r", "r", "rZ", "rZ", "rA", "rMZ" } };
+
+    switch (op) {
+    case INDEX_op_goto_ptr:
+        return &r;
 
-    for (i = 0; i < n; ++i) {
-        if (aarch64_op_defs[i].op == op) {
-            return &aarch64_op_defs[i];
-        }
+    case INDEX_op_ld8u_i32:
+    case INDEX_op_ld8s_i32:
+    case INDEX_op_ld16u_i32:
+    case INDEX_op_ld16s_i32:
+    case INDEX_op_ld_i32:
+    case INDEX_op_ld8u_i64:
+    case INDEX_op_ld8s_i64:
+    case INDEX_op_ld16u_i64:
+    case INDEX_op_ld16s_i64:
+    case INDEX_op_ld32u_i64:
+    case INDEX_op_ld32s_i64:
+    case INDEX_op_ld_i64:
+    case INDEX_op_neg_i32:
+    case INDEX_op_neg_i64:
+    case INDEX_op_not_i32:
+    case INDEX_op_not_i64:
+    case INDEX_op_bswap16_i32:
+    case INDEX_op_bswap32_i32:
+    case INDEX_op_bswap16_i64:
+    case INDEX_op_bswap32_i64:
+    case INDEX_op_bswap64_i64:
+    case INDEX_op_ext8s_i32:
+    case INDEX_op_ext16s_i32:
+    case INDEX_op_ext8u_i32:
+    case INDEX_op_ext16u_i32:
+    case INDEX_op_ext8s_i64:
+    case INDEX_op_ext16s_i64:
+    case INDEX_op_ext32s_i64:
+    case INDEX_op_ext8u_i64:
+    case INDEX_op_ext16u_i64:
+    case INDEX_op_ext32u_i64:
+    case INDEX_op_ext_i32_i64:
+    case INDEX_op_extu_i32_i64:
+    case INDEX_op_extract_i32:
+    case INDEX_op_extract_i64:
+    case INDEX_op_sextract_i32:
+    case INDEX_op_sextract_i64:
+        return &r_r;
+
+    case INDEX_op_st8_i32:
+    case INDEX_op_st16_i32:
+    case INDEX_op_st_i32:
+    case INDEX_op_st8_i64:
+    case INDEX_op_st16_i64:
+    case INDEX_op_st32_i64:
+    case INDEX_op_st_i64:
+        return &rZ_r;
+
+    case INDEX_op_add_i32:
+    case INDEX_op_add_i64:
+    case INDEX_op_sub_i32:
+    case INDEX_op_sub_i64:
+    case INDEX_op_setcond_i32:
+    case INDEX_op_setcond_i64:
+        return &r_r_rA;
+
+    case INDEX_op_mul_i32:
+    case INDEX_op_mul_i64:
+    case INDEX_op_div_i32:
+    case INDEX_op_div_i64:
+    case INDEX_op_divu_i32:
+    case INDEX_op_divu_i64:
+    case INDEX_op_rem_i32:
+    case INDEX_op_rem_i64:
+    case INDEX_op_remu_i32:
+    case INDEX_op_remu_i64:
+    case INDEX_op_muluh_i64:
+    case INDEX_op_mulsh_i64:
+        return &r_r_r;
+
+    case INDEX_op_and_i32:
+    case INDEX_op_and_i64:
+    case INDEX_op_or_i32:
+    case INDEX_op_or_i64:
+    case INDEX_op_xor_i32:
+    case INDEX_op_xor_i64:
+    case INDEX_op_andc_i32:
+    case INDEX_op_andc_i64:
+    case INDEX_op_orc_i32:
+    case INDEX_op_orc_i64:
+    case INDEX_op_eqv_i32:
+    case INDEX_op_eqv_i64:
+        return &r_r_rL;
+
+    case INDEX_op_shl_i32:
+    case INDEX_op_shr_i32:
+    case INDEX_op_sar_i32:
+    case INDEX_op_rotl_i32:
+    case INDEX_op_rotr_i32:
+    case INDEX_op_shl_i64:
+    case INDEX_op_shr_i64:
+    case INDEX_op_sar_i64:
+    case INDEX_op_rotl_i64:
+    case INDEX_op_rotr_i64:
+        return &r_r_ri;
+
+    case INDEX_op_clz_i32:
+    case INDEX_op_ctz_i32:
+    case INDEX_op_clz_i64:
+    case INDEX_op_ctz_i64:
+        return &r_r_rAL;
+
+    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond_i64:
+        return &r_rA;
+
+    case INDEX_op_movcond_i32:
+    case INDEX_op_movcond_i64:
+        return &movc;
+
+    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_ld_i64:
+        return &r_l;
+    case INDEX_op_qemu_st_i32:
+    case INDEX_op_qemu_st_i64:
+        return &lZ_l;
+
+    case INDEX_op_deposit_i32:
+    case INDEX_op_deposit_i64:
+        return &dep;
+
+    case INDEX_op_add2_i32:
+    case INDEX_op_add2_i64:
+    case INDEX_op_sub2_i32:
+    case INDEX_op_sub2_i64:
+        return &add2;
+
+    default:
+        return NULL;
     }
-    return NULL;
 }
 
 static void tcg_target_init(TCGContext *s)
-- 
2.13.5
