Received: from eggs.gnu.org ([2001:4830:134:3::10]:35586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VC-0006as-W5
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VB-0003T7-6V
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:02 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8VA-0003S7-UQ
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:01 -0500
Received: by mail-pf0-x244.google.com with SMTP id 127so31459134pfg.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:19:00 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:18:00 -0800
Message-Id: <20170111021820.24416-46-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 45/65] tcg/i386: Fuly convert tcg_target_op_def
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

Use a switch instead of searching a table.  Share constraints between
32-bit and 64-bit, when at all possible.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/i386/tcg-target.inc.c | 340 +++++++++++++++++++++++++++-------------------
 1 file changed, 198 insertions(+), 142 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index aa5a248..e497bef 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -237,13 +237,13 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         break;
 
     case 'e':
-        ct->ct |= TCG_CT_CONST_S32;
+        ct->ct |= (type == TCG_TYPE_I32 ? TCG_CT_CONST : TCG_CT_CONST_S32);
         break;
     case 'Z':
-        ct->ct |= TCG_CT_CONST_U32;
+        ct->ct |= (type == TCG_TYPE_I32 ? TCG_CT_CONST : TCG_CT_CONST_U32);
         break;
     case 'I':
-        ct->ct |= TCG_CT_CONST_I32;
+        ct->ct |= (type == TCG_TYPE_I32 ? TCG_CT_CONST : TCG_CT_CONST_I32);
         break;
 
     default:
@@ -2188,152 +2188,208 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
 #undef OP_32_64
 }
 
-static const TCGTargetOpDef x86_op_defs[] = {
-    { INDEX_op_exit_tb, { } },
-    { INDEX_op_goto_tb, { } },
-    { INDEX_op_br, { } },
-    { INDEX_op_ld8u_i32, { "r", "r" } },
-    { INDEX_op_ld8s_i32, { "r", "r" } },
-    { INDEX_op_ld16u_i32, { "r", "r" } },
-    { INDEX_op_ld16s_i32, { "r", "r" } },
-    { INDEX_op_ld_i32, { "r", "r" } },
-    { INDEX_op_st8_i32, { "qi", "r" } },
-    { INDEX_op_st16_i32, { "ri", "r" } },
-    { INDEX_op_st_i32, { "ri", "r" } },
-
-    { INDEX_op_add_i32, { "r", "r", "ri" } },
-    { INDEX_op_sub_i32, { "r", "0", "ri" } },
-    { INDEX_op_mul_i32, { "r", "0", "ri" } },
-    { INDEX_op_div2_i32, { "a", "d", "0", "1", "r" } },
-    { INDEX_op_divu2_i32, { "a", "d", "0", "1", "r" } },
-    { INDEX_op_and_i32, { "r", "0", "ri" } },
-    { INDEX_op_or_i32, { "r", "0", "ri" } },
-    { INDEX_op_xor_i32, { "r", "0", "ri" } },
-    { INDEX_op_andc_i32, { "r", "r", "ri" } },
-
-    { INDEX_op_shl_i32, { "r", "0", "Ci" } },
-    { INDEX_op_shr_i32, { "r", "0", "Ci" } },
-    { INDEX_op_sar_i32, { "r", "0", "Ci" } },
-    { INDEX_op_rotl_i32, { "r", "0", "ci" } },
-    { INDEX_op_rotr_i32, { "r", "0", "ci" } },
-
-    { INDEX_op_brcond_i32, { "r", "ri" } },
-
-    { INDEX_op_bswap16_i32, { "r", "0" } },
-    { INDEX_op_bswap32_i32, { "r", "0" } },
-
-    { INDEX_op_neg_i32, { "r", "0" } },
-
-    { INDEX_op_not_i32, { "r", "0" } },
-
-    { INDEX_op_ext8s_i32, { "r", "q" } },
-    { INDEX_op_ext16s_i32, { "r", "r" } },
-    { INDEX_op_ext8u_i32, { "r", "q" } },
-    { INDEX_op_ext16u_i32, { "r", "r" } },
-
-    { INDEX_op_setcond_i32, { "q", "r", "ri" } },
-
-    { INDEX_op_deposit_i32, { "Q", "0", "Q" } },
-    { INDEX_op_extract_i32, { "r", "r" } },
-    { INDEX_op_sextract_i32, { "r", "r" } },
-
-    { INDEX_op_movcond_i32, { "r", "r", "ri", "r", "0" } },
+static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
+{
+    static const TCGTargetOpDef ri_r = { .args_ct_str = { "ri", "r" } };
+    static const TCGTargetOpDef re_r = { .args_ct_str = { "re", "r" } };
+    static const TCGTargetOpDef qi_r = { .args_ct_str = { "qi", "r" } };
+    static const TCGTargetOpDef r_r = { .args_ct_str = { "r", "r" } };
+    static const TCGTargetOpDef r_q = { .args_ct_str = { "r", "q" } };
+    static const TCGTargetOpDef r_re = { .args_ct_str = { "r", "re" } };
+    static const TCGTargetOpDef r_0 = { .args_ct_str = { "r", "0" } };
+    static const TCGTargetOpDef r_r_re = { .args_ct_str = { "r", "r", "re" } };
+    static const TCGTargetOpDef r_0_re = { .args_ct_str = { "r", "0", "re" } };
+    static const TCGTargetOpDef r_0_Ci = { .args_ct_str = { "r", "0", "Ci" } };
+    static const TCGTargetOpDef r_0_ci = { .args_ct_str = { "r", "0", "ci" } };
+    static const TCGTargetOpDef r_L = { .args_ct_str = { "r", "L" } };
+    static const TCGTargetOpDef L_L = { .args_ct_str = { "L", "L" } };
+    static const TCGTargetOpDef r_L_L = { .args_ct_str = { "r", "L", "L" } };
+    static const TCGTargetOpDef r_r_L = { .args_ct_str = { "r", "r", "L" } };
+    static const TCGTargetOpDef L_L_L = { .args_ct_str = { "L", "L", "L" } };
+    static const TCGTargetOpDef r_r_L_L
+        = { .args_ct_str = { "r", "r", "L", "L" } };
+    static const TCGTargetOpDef L_L_L_L
+        = { .args_ct_str = { "L", "L", "L", "L" } };
+
+    switch (op) {
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
+        return &r_r;
 
-    { INDEX_op_mulu2_i32, { "a", "d", "a", "r" } },
-    { INDEX_op_muls2_i32, { "a", "d", "a", "r" } },
-    { INDEX_op_add2_i32, { "r", "r", "0", "1", "ri", "ri" } },
-    { INDEX_op_sub2_i32, { "r", "r", "0", "1", "ri", "ri" } },
+    case INDEX_op_st8_i32:
+    case INDEX_op_st8_i64:
+        return &qi_r;
+    case INDEX_op_st16_i32:
+    case INDEX_op_st16_i64:
+    case INDEX_op_st_i32:
+    case INDEX_op_st32_i64:
+        return &ri_r;
+    case INDEX_op_st_i64:
+        return &re_r;
+
+    case INDEX_op_add_i32:
+    case INDEX_op_add_i64:
+        return &r_r_re;
+    case INDEX_op_sub_i32:
+    case INDEX_op_sub_i64:
+    case INDEX_op_mul_i32:
+    case INDEX_op_mul_i64:
+    case INDEX_op_or_i32:
+    case INDEX_op_or_i64:
+    case INDEX_op_xor_i32:
+    case INDEX_op_xor_i64:
+        return &r_0_re;
+
+    case INDEX_op_and_i32:
+    case INDEX_op_and_i64:
+        {
+            static const TCGTargetOpDef and
+                = { .args_ct_str = { "r", "0", "reZ" } };
+            return &and;
+        }
+        break;
+    case INDEX_op_andc_i32:
+    case INDEX_op_andc_i64:
+        {
+            static const TCGTargetOpDef andc
+                = { .args_ct_str = { "r", "r", "rI" } };
+            return &andc;
+        }
+        break;
 
-    { INDEX_op_mb, { } },
+    case INDEX_op_shl_i32:
+    case INDEX_op_shl_i64:
+    case INDEX_op_shr_i32:
+    case INDEX_op_shr_i64:
+    case INDEX_op_sar_i32:
+    case INDEX_op_sar_i64:
+        return &r_0_Ci;
+    case INDEX_op_rotl_i32:
+    case INDEX_op_rotl_i64:
+    case INDEX_op_rotr_i32:
+    case INDEX_op_rotr_i64:
+        return &r_0_ci;
 
-#if TCG_TARGET_REG_BITS == 32
-    { INDEX_op_brcond2_i32, { "r", "r", "ri", "ri" } },
-    { INDEX_op_setcond2_i32, { "r", "r", "r", "ri", "ri" } },
-#else
-    { INDEX_op_ld8u_i64, { "r", "r" } },
-    { INDEX_op_ld8s_i64, { "r", "r" } },
-    { INDEX_op_ld16u_i64, { "r", "r" } },
-    { INDEX_op_ld16s_i64, { "r", "r" } },
-    { INDEX_op_ld32u_i64, { "r", "r" } },
-    { INDEX_op_ld32s_i64, { "r", "r" } },
-    { INDEX_op_ld_i64, { "r", "r" } },
-    { INDEX_op_st8_i64, { "ri", "r" } },
-    { INDEX_op_st16_i64, { "ri", "r" } },
-    { INDEX_op_st32_i64, { "ri", "r" } },
-    { INDEX_op_st_i64, { "re", "r" } },
-
-    { INDEX_op_add_i64, { "r", "r", "re" } },
-    { INDEX_op_mul_i64, { "r", "0", "re" } },
-    { INDEX_op_div2_i64, { "a", "d", "0", "1", "r" } },
-    { INDEX_op_divu2_i64, { "a", "d", "0", "1", "r" } },
-    { INDEX_op_sub_i64, { "r", "0", "re" } },
-    { INDEX_op_and_i64, { "r", "0", "reZ" } },
-    { INDEX_op_or_i64, { "r", "0", "re" } },
-    { INDEX_op_xor_i64, { "r", "0", "re" } },
-    { INDEX_op_andc_i64, { "r", "r", "rI" } },
-
-    { INDEX_op_shl_i64, { "r", "0", "Ci" } },
-    { INDEX_op_shr_i64, { "r", "0", "Ci" } },
-    { INDEX_op_sar_i64, { "r", "0", "Ci" } },
-    { INDEX_op_rotl_i64, { "r", "0", "ci" } },
-    { INDEX_op_rotr_i64, { "r", "0", "ci" } },
-
-    { INDEX_op_brcond_i64, { "r", "re" } },
-    { INDEX_op_setcond_i64, { "r", "r", "re" } },
-
-    { INDEX_op_bswap16_i64, { "r", "0" } },
-    { INDEX_op_bswap32_i64, { "r", "0" } },
-    { INDEX_op_bswap64_i64, { "r", "0" } },
-    { INDEX_op_neg_i64, { "r", "0" } },
-    { INDEX_op_not_i64, { "r", "0" } },
-
-    { INDEX_op_ext8s_i64, { "r", "r" } },
-    { INDEX_op_ext16s_i64, { "r", "r" } },
-    { INDEX_op_ext32s_i64, { "r", "r" } },
-    { INDEX_op_ext8u_i64, { "r", "r" } },
-    { INDEX_op_ext16u_i64, { "r", "r" } },
-    { INDEX_op_ext32u_i64, { "r", "r" } },
-
-    { INDEX_op_ext_i32_i64, { "r", "r" } },
-    { INDEX_op_extu_i32_i64, { "r", "r" } },
-
-    { INDEX_op_deposit_i64, { "Q", "0", "Q" } },
-    { INDEX_op_extract_i64, { "r", "r" } },
-    { INDEX_op_movcond_i64, { "r", "r", "re", "r", "0" } },
-
-    { INDEX_op_mulu2_i64, { "a", "d", "a", "r" } },
-    { INDEX_op_muls2_i64, { "a", "d", "a", "r" } },
-    { INDEX_op_add2_i64, { "r", "r", "0", "1", "re", "re" } },
-    { INDEX_op_sub2_i64, { "r", "r", "0", "1", "re", "re" } },
-#endif
+    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond_i64:
+        return &r_re;
 
-#if TCG_TARGET_REG_BITS == 64
-    { INDEX_op_qemu_ld_i32, { "r", "L" } },
-    { INDEX_op_qemu_st_i32, { "L", "L" } },
-    { INDEX_op_qemu_ld_i64, { "r", "L" } },
-    { INDEX_op_qemu_st_i64, { "L", "L" } },
-#elif TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
-    { INDEX_op_qemu_ld_i32, { "r", "L" } },
-    { INDEX_op_qemu_st_i32, { "L", "L" } },
-    { INDEX_op_qemu_ld_i64, { "r", "r", "L" } },
-    { INDEX_op_qemu_st_i64, { "L", "L", "L" } },
-#else
-    { INDEX_op_qemu_ld_i32, { "r", "L", "L" } },
-    { INDEX_op_qemu_st_i32, { "L", "L", "L" } },
-    { INDEX_op_qemu_ld_i64, { "r", "r", "L", "L" } },
-    { INDEX_op_qemu_st_i64, { "L", "L", "L", "L" } },
-#endif
-    { -1 },
-};
+    case INDEX_op_bswap16_i32:
+    case INDEX_op_bswap16_i64:
+    case INDEX_op_bswap32_i32:
+    case INDEX_op_bswap32_i64:
+    case INDEX_op_bswap64_i64:
+    case INDEX_op_neg_i32:
+    case INDEX_op_neg_i64:
+    case INDEX_op_not_i32:
+    case INDEX_op_not_i64:
+        return &r_0;
+
+    case INDEX_op_ext8s_i32:
+    case INDEX_op_ext8s_i64:
+    case INDEX_op_ext8u_i32:
+    case INDEX_op_ext8u_i64:
+        return &r_q;
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
+    case INDEX_op_sextract_i32:
+        return &r_r;
+
+    case INDEX_op_deposit_i32:
+    case INDEX_op_deposit_i64:
+        {
+            static const TCGTargetOpDef dep
+                = { .args_ct_str = { "Q", "0", "Q" } };
+            return &dep;
+        }
+    case INDEX_op_setcond_i32:
+    case INDEX_op_setcond_i64:
+        {
+            static const TCGTargetOpDef setc
+                = { .args_ct_str = { "q", "r", "re" } };
+            return &setc;
+        }
+    case INDEX_op_movcond_i32:
+    case INDEX_op_movcond_i64:
+        {
+            static const TCGTargetOpDef movc
+                = { .args_ct_str = { "r", "r", "re", "r", "0" } };
+            return &movc;
+        }
+    case INDEX_op_div2_i32:
+    case INDEX_op_div2_i64:
+    case INDEX_op_divu2_i32:
+    case INDEX_op_divu2_i64:
+        {
+            static const TCGTargetOpDef div2
+                = { .args_ct_str = { "a", "d", "0", "1", "r" } };
+            return &div2;
+        }
+    case INDEX_op_mulu2_i32:
+    case INDEX_op_mulu2_i64:
+    case INDEX_op_muls2_i32:
+    case INDEX_op_muls2_i64:
+        {
+            static const TCGTargetOpDef mul2
+                = { .args_ct_str = { "a", "d", "a", "r" } };
+            return &mul2;
+        }
+    case INDEX_op_add2_i32:
+    case INDEX_op_add2_i64:
+    case INDEX_op_sub2_i32:
+    case INDEX_op_sub2_i64:
+        {
+            static const TCGTargetOpDef arith2
+                = { .args_ct_str = { "r", "r", "0", "1", "re", "re" } };
+            return &arith2;
+        }
 
-static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
-{
-    int i, n = ARRAY_SIZE(x86_op_defs);
+    case INDEX_op_qemu_ld_i32:
+        return TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &r_L : &r_L_L;
+    case INDEX_op_qemu_st_i32:
+        return TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &L_L : &L_L_L;
+    case INDEX_op_qemu_ld_i64:
+        return (TCG_TARGET_REG_BITS == 64 ? &r_L
+                : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &r_r_L
+                : &r_r_L_L);
+    case INDEX_op_qemu_st_i64:
+        return (TCG_TARGET_REG_BITS == 64 ? &L_L
+                : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &L_L_L
+                : &L_L_L_L);
 
-    for (i = 0; i < n; ++i) {
-        if (x86_op_defs[i].op == op) {
-            return &x86_op_defs[i];
+    case INDEX_op_brcond2_i32:
+        {
+            static const TCGTargetOpDef b2
+                = { .args_ct_str = { "r", "r", "ri", "ri" } };
+            return &b2;
+        }
+    case INDEX_op_setcond2_i32:
+        {
+            static const TCGTargetOpDef s2
+                = { .args_ct_str = { "r", "r", "r", "ri", "ri" } };
+            return &s2;
         }
+
+    default:
+        break;
     }
     return NULL;
 }
-- 
2.9.3
