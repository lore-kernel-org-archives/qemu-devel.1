Received: from eggs.gnu.org ([2001:4830:134:3::10]:52775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb9A-0008AG-Pq
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb96-0008KZ-FF
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:06:12 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:45117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dtb96-0008KK-7v
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:06:08 -0400
Received: by mail-oi0-x22b.google.com with SMTP id z73so3685856oia.2
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 08:06:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 17 Sep 2017 08:05:34 -0700
Message-Id: <20170917150535.8284-17-richard.henderson@linaro.org>
In-Reply-To: <20170917150535.8284-1-richard.henderson@linaro.org>
References: <20170917150535.8284-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 16/17] tcg/sparc: Fully convert tcg_target_op_def
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
 tcg/sparc/tcg-target.inc.c | 239 ++++++++++++++++++++++++++-------------------
 1 file changed, 137 insertions(+), 102 deletions(-)

diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 1da4debbaf..bc673bd8c6 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -1632,112 +1632,147 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
-static const TCGTargetOpDef sparc_op_defs[] = {
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
-    { INDEX_op_mul_i32, { "r", "rZ", "rJ" } },
-    { INDEX_op_div_i32, { "r", "rZ", "rJ" } },
-    { INDEX_op_divu_i32, { "r", "rZ", "rJ" } },
-    { INDEX_op_sub_i32, { "r", "rZ", "rJ" } },
-    { INDEX_op_and_i32, { "r", "rZ", "rJ" } },
-    { INDEX_op_andc_i32, { "r", "rZ", "rJ" } },
-    { INDEX_op_or_i32, { "r", "rZ", "rJ" } },
-    { INDEX_op_orc_i32, { "r", "rZ", "rJ" } },
-    { INDEX_op_xor_i32, { "r", "rZ", "rJ" } },
-
-    { INDEX_op_shl_i32, { "r", "rZ", "rJ" } },
-    { INDEX_op_shr_i32, { "r", "rZ", "rJ" } },
-    { INDEX_op_sar_i32, { "r", "rZ", "rJ" } },
-
-    { INDEX_op_neg_i32, { "r", "rJ" } },
-    { INDEX_op_not_i32, { "r", "rJ" } },
-
-    { INDEX_op_brcond_i32, { "rZ", "rJ" } },
-    { INDEX_op_setcond_i32, { "r", "rZ", "rJ" } },
-    { INDEX_op_movcond_i32, { "r", "rZ", "rJ", "rI", "0" } },
-
-    { INDEX_op_add2_i32, { "r", "r", "rZ", "rZ", "rJ", "rJ" } },
-    { INDEX_op_sub2_i32, { "r", "r", "rZ", "rZ", "rJ", "rJ" } },
-    { INDEX_op_mulu2_i32, { "r", "r", "rZ", "rJ" } },
-    { INDEX_op_muls2_i32, { "r", "r", "rZ", "rJ" } },
-
-    { INDEX_op_ld8u_i64, { "R", "r" } },
-    { INDEX_op_ld8s_i64, { "R", "r" } },
-    { INDEX_op_ld16u_i64, { "R", "r" } },
-    { INDEX_op_ld16s_i64, { "R", "r" } },
-    { INDEX_op_ld32u_i64, { "R", "r" } },
-    { INDEX_op_ld32s_i64, { "R", "r" } },
-    { INDEX_op_ld_i64, { "R", "r" } },
-    { INDEX_op_st8_i64, { "RZ", "r" } },
-    { INDEX_op_st16_i64, { "RZ", "r" } },
-    { INDEX_op_st32_i64, { "RZ", "r" } },
-    { INDEX_op_st_i64, { "RZ", "r" } },
-
-    { INDEX_op_add_i64, { "R", "RZ", "RJ" } },
-    { INDEX_op_mul_i64, { "R", "RZ", "RJ" } },
-    { INDEX_op_div_i64, { "R", "RZ", "RJ" } },
-    { INDEX_op_divu_i64, { "R", "RZ", "RJ" } },
-    { INDEX_op_sub_i64, { "R", "RZ", "RJ" } },
-    { INDEX_op_and_i64, { "R", "RZ", "RJ" } },
-    { INDEX_op_andc_i64, { "R", "RZ", "RJ" } },
-    { INDEX_op_or_i64, { "R", "RZ", "RJ" } },
-    { INDEX_op_orc_i64, { "R", "RZ", "RJ" } },
-    { INDEX_op_xor_i64, { "R", "RZ", "RJ" } },
-
-    { INDEX_op_shl_i64, { "R", "RZ", "RJ" } },
-    { INDEX_op_shr_i64, { "R", "RZ", "RJ" } },
-    { INDEX_op_sar_i64, { "R", "RZ", "RJ" } },
-
-    { INDEX_op_neg_i64, { "R", "RJ" } },
-    { INDEX_op_not_i64, { "R", "RJ" } },
-
-    { INDEX_op_ext32s_i64, { "R", "R" } },
-    { INDEX_op_ext32u_i64, { "R", "R" } },
-    { INDEX_op_ext_i32_i64, { "R", "r" } },
-    { INDEX_op_extu_i32_i64, { "R", "r" } },
-    { INDEX_op_extrl_i64_i32,  { "r", "R" } },
-    { INDEX_op_extrh_i64_i32,  { "r", "R" } },
-
-    { INDEX_op_brcond_i64, { "RZ", "RJ" } },
-    { INDEX_op_setcond_i64, { "R", "RZ", "RJ" } },
-    { INDEX_op_movcond_i64, { "R", "RZ", "RJ", "RI", "0" } },
-
-    { INDEX_op_add2_i64, { "R", "R", "RZ", "RZ", "RJ", "RI" } },
-    { INDEX_op_sub2_i64, { "R", "R", "RZ", "RZ", "RJ", "RI" } },
-    { INDEX_op_muluh_i64, { "R", "RZ", "RZ" } },
-
-    { INDEX_op_qemu_ld_i32, { "r", "A" } },
-    { INDEX_op_qemu_ld_i64, { "R", "A" } },
-    { INDEX_op_qemu_st_i32, { "sZ", "A" } },
-    { INDEX_op_qemu_st_i64, { "SZ", "A" } },
-
-    { INDEX_op_mb, { } },
-    { -1 },
-};
-
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
-    int i, n = ARRAY_SIZE(sparc_op_defs);
+    static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
+    static const TCGTargetOpDef r_r = { .args_ct_str = { "r", "r" } };
+    static const TCGTargetOpDef R_r = { .args_ct_str = { "R", "r" } };
+    static const TCGTargetOpDef r_R = { .args_ct_str = { "r", "R" } };
+    static const TCGTargetOpDef R_R = { .args_ct_str = { "R", "R" } };
+    static const TCGTargetOpDef r_A = { .args_ct_str = { "r", "A" } };
+    static const TCGTargetOpDef R_A = { .args_ct_str = { "R", "A" } };
+    static const TCGTargetOpDef rZ_r = { .args_ct_str = { "rZ", "r" } };
+    static const TCGTargetOpDef RZ_r = { .args_ct_str = { "RZ", "r" } };
+    static const TCGTargetOpDef sZ_A = { .args_ct_str = { "sZ", "A" } };
+    static const TCGTargetOpDef SZ_A = { .args_ct_str = { "SZ", "A" } };
+    static const TCGTargetOpDef rZ_rJ = { .args_ct_str = { "rZ", "rJ" } };
+    static const TCGTargetOpDef RZ_RJ = { .args_ct_str = { "RZ", "RJ" } };
+    static const TCGTargetOpDef R_R_R = { .args_ct_str = { "R", "R", "R" } };
+    static const TCGTargetOpDef r_rZ_rJ
+        = { .args_ct_str = { "r", "rZ", "rJ" } };
+    static const TCGTargetOpDef R_RZ_RJ
+        = { .args_ct_str = { "R", "RZ", "RJ" } };
+    static const TCGTargetOpDef r_r_rZ_rJ
+        = { .args_ct_str = { "r", "r", "rZ", "rJ" } };
+    static const TCGTargetOpDef movc_32
+        = { .args_ct_str = { "r", "rZ", "rJ", "rI", "0" } };
+    static const TCGTargetOpDef movc_64
+        = { .args_ct_str = { "R", "RZ", "RJ", "RI", "0" } };
+    static const TCGTargetOpDef add2_32
+        = { .args_ct_str = { "r", "r", "rZ", "rZ", "rJ", "rJ" } };
+    static const TCGTargetOpDef add2_64
+        = { .args_ct_str = { "R", "R", "RZ", "RZ", "RJ", "RI" } };
+
+    switch (op) {
+    case INDEX_op_goto_ptr:
+        return &r;
 
-    for (i = 0; i < n; ++i) {
-        if (sparc_op_defs[i].op == op) {
-            return &sparc_op_defs[i];
-        }
+    case INDEX_op_ld8u_i32:
+    case INDEX_op_ld8s_i32:
+    case INDEX_op_ld16u_i32:
+    case INDEX_op_ld16s_i32:
+    case INDEX_op_ld_i32:
+    case INDEX_op_neg_i32:
+    case INDEX_op_not_i32:
+        return &r_r;
+
+    case INDEX_op_st8_i32:
+    case INDEX_op_st16_i32:
+    case INDEX_op_st_i32:
+        return &rZ_r;
+
+    case INDEX_op_add_i32:
+    case INDEX_op_mul_i32:
+    case INDEX_op_div_i32:
+    case INDEX_op_divu_i32:
+    case INDEX_op_sub_i32:
+    case INDEX_op_and_i32:
+    case INDEX_op_andc_i32:
+    case INDEX_op_or_i32:
+    case INDEX_op_orc_i32:
+    case INDEX_op_xor_i32:
+    case INDEX_op_shl_i32:
+    case INDEX_op_shr_i32:
+    case INDEX_op_sar_i32:
+    case INDEX_op_setcond_i32:
+        return &r_rZ_rJ;
+
+    case INDEX_op_brcond_i32:
+        return &rZ_rJ;
+    case INDEX_op_movcond_i32:
+        return &movc_32;
+    case INDEX_op_add2_i32:
+    case INDEX_op_sub2_i32:
+        return &add2_32;
+    case INDEX_op_mulu2_i32:
+    case INDEX_op_muls2_i32:
+        return &r_r_rZ_rJ;
+
+    case INDEX_op_ld8u_i64:
+    case INDEX_op_ld8s_i64:
+    case INDEX_op_ld16u_i64:
+    case INDEX_op_ld16s_i64:
+    case INDEX_op_ld32u_i64:
+    case INDEX_op_ld32s_i64:
+    case INDEX_op_ld_i64:
+    case INDEX_op_ext_i32_i64:
+    case INDEX_op_extu_i32_i64:
+        return &R_r;
+
+    case INDEX_op_st8_i64:
+    case INDEX_op_st16_i64:
+    case INDEX_op_st32_i64:
+    case INDEX_op_st_i64:
+        return &RZ_r;
+
+    case INDEX_op_add_i64:
+    case INDEX_op_mul_i64:
+    case INDEX_op_div_i64:
+    case INDEX_op_divu_i64:
+    case INDEX_op_sub_i64:
+    case INDEX_op_and_i64:
+    case INDEX_op_andc_i64:
+    case INDEX_op_or_i64:
+    case INDEX_op_orc_i64:
+    case INDEX_op_xor_i64:
+    case INDEX_op_shl_i64:
+    case INDEX_op_shr_i64:
+    case INDEX_op_sar_i64:
+    case INDEX_op_setcond_i64:
+        return &R_RZ_RJ;
+
+    case INDEX_op_neg_i64:
+    case INDEX_op_not_i64:
+    case INDEX_op_ext32s_i64:
+    case INDEX_op_ext32u_i64:
+        return &R_R;
+
+    case INDEX_op_extrl_i64_i32:
+    case INDEX_op_extrh_i64_i32:
+        return &r_R;
+
+    case INDEX_op_brcond_i64:
+        return &RZ_RJ;
+    case INDEX_op_movcond_i64:
+        return &movc_64;
+    case INDEX_op_add2_i64:
+    case INDEX_op_sub2_i64:
+        return &add2_64;
+    case INDEX_op_muluh_i64:
+        return &R_R_R;
+
+    case INDEX_op_qemu_ld_i32:
+        return &r_A;
+    case INDEX_op_qemu_ld_i64:
+        return &R_A;
+    case INDEX_op_qemu_st_i32:
+        return &sZ_A;
+    case INDEX_op_qemu_st_i64:
+        return &SZ_A;
+
+    default:
+        return NULL;
     }
-    return NULL;
 }
 
 static void tcg_target_init(TCGContext *s)
-- 
2.13.5
