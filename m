Received: from eggs.gnu.org ([2001:4830:134:3::10]:49462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmnQe-0002Qk-DO
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmnQc-0001Tf-Ou
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:48:08 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:36612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmnQc-0001TK-GI
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:48:06 -0400
Received: by mail-pg0-x233.google.com with SMTP id r133so13990760pgr.3
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 13:48:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 29 Aug 2017 13:47:52 -0700
Message-Id: <20170829204759.6853-2-richard.henderson@linaro.org>
In-Reply-To: <20170829204759.6853-1-richard.henderson@linaro.org>
References: <20170829204759.6853-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/8] tcg/s390: Fully convert tcg_target_op_def
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, agraf@suse.de, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Use a switch instead of searching a table.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/s390/tcg-target.inc.c | 278 +++++++++++++++++++++++++---------------------
 1 file changed, 154 insertions(+), 124 deletions(-)

diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 5d7083e90c..d34649eb13 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -2246,134 +2246,164 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
-static const TCGTargetOpDef s390_op_defs[] = {
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
-    { INDEX_op_st8_i32, { "r", "r" } },
-    { INDEX_op_st16_i32, { "r", "r" } },
-    { INDEX_op_st_i32, { "r", "r" } },
-
-    { INDEX_op_add_i32, { "r", "r", "ri" } },
-    { INDEX_op_sub_i32, { "r", "0", "ri" } },
-    { INDEX_op_mul_i32, { "r", "0", "rK" } },
-
-    { INDEX_op_div2_i32, { "b", "a", "0", "1", "r" } },
-    { INDEX_op_divu2_i32, { "b", "a", "0", "1", "r" } },
-
-    { INDEX_op_and_i32, { "r", "0", "ri" } },
-    { INDEX_op_or_i32, { "r", "0", "rO" } },
-    { INDEX_op_xor_i32, { "r", "0", "rX" } },
-
-    { INDEX_op_neg_i32, { "r", "r" } },
-
-    { INDEX_op_shl_i32, { "r", "0", "ri" } },
-    { INDEX_op_shr_i32, { "r", "0", "ri" } },
-    { INDEX_op_sar_i32, { "r", "0", "ri" } },
-
-    { INDEX_op_rotl_i32, { "r", "r", "ri" } },
-    { INDEX_op_rotr_i32, { "r", "r", "ri" } },
-
-    { INDEX_op_ext8s_i32, { "r", "r" } },
-    { INDEX_op_ext8u_i32, { "r", "r" } },
-    { INDEX_op_ext16s_i32, { "r", "r" } },
-    { INDEX_op_ext16u_i32, { "r", "r" } },
-
-    { INDEX_op_bswap16_i32, { "r", "r" } },
-    { INDEX_op_bswap32_i32, { "r", "r" } },
-
-    { INDEX_op_add2_i32, { "r", "r", "0", "1", "rA", "r" } },
-    { INDEX_op_sub2_i32, { "r", "r", "0", "1", "rA", "r" } },
-
-    { INDEX_op_brcond_i32, { "r", "rC" } },
-    { INDEX_op_setcond_i32, { "r", "r", "rC" } },
-    { INDEX_op_movcond_i32, { "r", "r", "rC", "r", "0" } },
-    { INDEX_op_deposit_i32, { "r", "rZ", "r" } },
-    { INDEX_op_extract_i32, { "r", "r" } },
-
-    { INDEX_op_qemu_ld_i32, { "r", "L" } },
-    { INDEX_op_qemu_ld_i64, { "r", "L" } },
-    { INDEX_op_qemu_st_i32, { "L", "L" } },
-    { INDEX_op_qemu_st_i64, { "L", "L" } },
-
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
-    { INDEX_op_add_i64, { "r", "r", "ri" } },
-    { INDEX_op_sub_i64, { "r", "0", "ri" } },
-    { INDEX_op_mul_i64, { "r", "0", "rK" } },
-
-    { INDEX_op_div2_i64, { "b", "a", "0", "1", "r" } },
-    { INDEX_op_divu2_i64, { "b", "a", "0", "1", "r" } },
-    { INDEX_op_mulu2_i64, { "b", "a", "0", "r" } },
-
-    { INDEX_op_and_i64, { "r", "0", "ri" } },
-    { INDEX_op_or_i64, { "r", "0", "rO" } },
-    { INDEX_op_xor_i64, { "r", "0", "rX" } },
-
-    { INDEX_op_neg_i64, { "r", "r" } },
-
-    { INDEX_op_shl_i64, { "r", "r", "ri" } },
-    { INDEX_op_shr_i64, { "r", "r", "ri" } },
-    { INDEX_op_sar_i64, { "r", "r", "ri" } },
-
-    { INDEX_op_rotl_i64, { "r", "r", "ri" } },
-    { INDEX_op_rotr_i64, { "r", "r", "ri" } },
-
-    { INDEX_op_ext8s_i64, { "r", "r" } },
-    { INDEX_op_ext8u_i64, { "r", "r" } },
-    { INDEX_op_ext16s_i64, { "r", "r" } },
-    { INDEX_op_ext16u_i64, { "r", "r" } },
-    { INDEX_op_ext32s_i64, { "r", "r" } },
-    { INDEX_op_ext32u_i64, { "r", "r" } },
-
-    { INDEX_op_ext_i32_i64, { "r", "r" } },
-    { INDEX_op_extu_i32_i64, { "r", "r" } },
-
-    { INDEX_op_bswap16_i64, { "r", "r" } },
-    { INDEX_op_bswap32_i64, { "r", "r" } },
-    { INDEX_op_bswap64_i64, { "r", "r" } },
-
-    { INDEX_op_clz_i64, { "r", "r", "ri" } },
-
-    { INDEX_op_add2_i64, { "r", "r", "0", "1", "rA", "r" } },
-    { INDEX_op_sub2_i64, { "r", "r", "0", "1", "rA", "r" } },
-
-    { INDEX_op_brcond_i64, { "r", "rC" } },
-    { INDEX_op_setcond_i64, { "r", "r", "rC" } },
-    { INDEX_op_movcond_i64, { "r", "r", "rC", "r", "0" } },
-    { INDEX_op_deposit_i64, { "r", "0", "r" } },
-    { INDEX_op_extract_i64, { "r", "r" } },
-
-    { INDEX_op_mb, { } },
-    { -1 },
-};
-
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
-    int i, n = ARRAY_SIZE(s390_op_defs);
+    static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
+    static const TCGTargetOpDef r_r = { .args_ct_str = { "r", "r" } };
+    static const TCGTargetOpDef r_L = { .args_ct_str = { "r", "L" } };
+    static const TCGTargetOpDef L_L = { .args_ct_str = { "L", "L" } };
+    static const TCGTargetOpDef r_rC = { .args_ct_str = { "r", "rC" } };
+    static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
+    static const TCGTargetOpDef r_0_ri = { .args_ct_str = { "r", "0", "ri" } };
+    static const TCGTargetOpDef r_0_rK = { .args_ct_str = { "r", "0", "rK" } };
+    static const TCGTargetOpDef r_0_rO = { .args_ct_str = { "r", "0", "rO" } };
+    static const TCGTargetOpDef r_0_rX = { .args_ct_str = { "r", "0", "rX" } };
+
+    switch (op) {
+    case INDEX_op_goto_ptr:
+        return &r;
+
+    case INDEX_op_ld8u_i32:
+    case INDEX_op_ld8u_i64:
+    case INDEX_op_ld8s_i32:
+    case INDEX_op_ld8s_i64:
+    case INDEX_op_ld16u_i32:
+    case INDEX_op_ld16u_i64:
+    case INDEX_op_ld16s_i32:
+    case INDEX_op_ld16s_i64:
+    case INDEX_op_ld_i32:
+    case INDEX_op_ld32u_i64:
+    case INDEX_op_ld32s_i64:
+    case INDEX_op_ld_i64:
+    case INDEX_op_st8_i32:
+    case INDEX_op_st8_i64:
+    case INDEX_op_st16_i32:
+    case INDEX_op_st16_i64:
+    case INDEX_op_st_i32:
+    case INDEX_op_st32_i64:
+    case INDEX_op_st_i64:
+        return &r_r;
+
+    case INDEX_op_add_i32:
+    case INDEX_op_add_i64:
+        return &r_r_ri;
+    case INDEX_op_sub_i32:
+    case INDEX_op_sub_i64:
+        return &r_0_ri;
+    case INDEX_op_mul_i32:
+    case INDEX_op_mul_i64:
+        return &r_0_rK;
+    case INDEX_op_or_i32:
+    case INDEX_op_or_i64:
+        return &r_0_rO;
+    case INDEX_op_xor_i32:
+    case INDEX_op_xor_i64:
+        return &r_0_rX;
+    case INDEX_op_and_i32:
+    case INDEX_op_and_i64:
+        return &r_0_ri;
+
+    case INDEX_op_shl_i32:
+    case INDEX_op_shr_i32:
+    case INDEX_op_sar_i32:
+        return &r_0_ri;
+
+    case INDEX_op_shl_i64:
+    case INDEX_op_shr_i64:
+    case INDEX_op_sar_i64:
+        return &r_r_ri;
+
+    case INDEX_op_rotl_i32:
+    case INDEX_op_rotl_i64:
+    case INDEX_op_rotr_i32:
+    case INDEX_op_rotr_i64:
+        return &r_r_ri;
+
+    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond_i64:
+        return &r_rC;
+
+    case INDEX_op_bswap16_i32:
+    case INDEX_op_bswap16_i64:
+    case INDEX_op_bswap32_i32:
+    case INDEX_op_bswap32_i64:
+    case INDEX_op_bswap64_i64:
+    case INDEX_op_neg_i32:
+    case INDEX_op_neg_i64:
+    case INDEX_op_ext8s_i32:
+    case INDEX_op_ext8s_i64:
+    case INDEX_op_ext8u_i32:
+    case INDEX_op_ext8u_i64:
+    case INDEX_op_ext16s_i32:
+    case INDEX_op_ext16s_i64:
+    case INDEX_op_ext16u_i32:
+    case INDEX_op_ext16u_i64:
+    case INDEX_op_ext32s_i64:
+    case INDEX_op_ext32u_i64:
+    case INDEX_op_ext_i32_i64:
+    case INDEX_op_extu_i32_i64:
+    case INDEX_op_extract_i32:
+    case INDEX_op_extract_i64:
+        return &r_r;
+
+    case INDEX_op_clz_i64:
+        return &r_r_ri;
+
+    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_ld_i64:
+        return &r_L;
+    case INDEX_op_qemu_st_i64:
+    case INDEX_op_qemu_st_i32:
+        return &L_L;
 
-    for (i = 0; i < n; ++i) {
-        if (s390_op_defs[i].op == op) {
-            return &s390_op_defs[i];
+    case INDEX_op_deposit_i32:
+    case INDEX_op_deposit_i64:
+        {
+            static const TCGTargetOpDef dep
+                = { .args_ct_str = { "r", "rZ", "r" } };
+            return &dep;
         }
+    case INDEX_op_setcond_i32:
+    case INDEX_op_setcond_i64:
+        {
+            static const TCGTargetOpDef setc
+                = { .args_ct_str = { "r", "r", "rC" } };
+            return &setc;
+        }
+    case INDEX_op_movcond_i32:
+    case INDEX_op_movcond_i64:
+        {
+            static const TCGTargetOpDef movc
+                = { .args_ct_str = { "r", "r", "rC", "r", "0" } };
+            return &movc;
+        }
+    case INDEX_op_div2_i32:
+    case INDEX_op_div2_i64:
+    case INDEX_op_divu2_i32:
+    case INDEX_op_divu2_i64:
+        {
+            static const TCGTargetOpDef div2
+                = { .args_ct_str = { "b", "a", "0", "1", "r" } };
+            return &div2;
+        }
+    case INDEX_op_mulu2_i64:
+        {
+            static const TCGTargetOpDef mul2
+                = { .args_ct_str = { "b", "a", "0", "r" } };
+            return &mul2;
+        }
+    case INDEX_op_add2_i32:
+    case INDEX_op_add2_i64:
+    case INDEX_op_sub2_i32:
+    case INDEX_op_sub2_i64:
+        {
+            static const TCGTargetOpDef arith2
+                = { .args_ct_str = { "r", "r", "0", "1", "rA", "r" } };
+            return &arith2;
+        }
+
+    default:
+        break;
     }
     return NULL;
 }
-- 
2.13.5
