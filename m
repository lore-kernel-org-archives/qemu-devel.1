Received: from eggs.gnu.org ([2001:4830:134:3::10]:49460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmnQe-0002Qj-Ce
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmnQc-0001Tn-TK
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:48:08 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:38035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmnQc-0001TR-M5
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:48:06 -0400
Received: by mail-pg0-x22e.google.com with SMTP id b8so13996915pgn.5
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 13:48:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 29 Aug 2017 13:47:53 -0700
Message-Id: <20170829204759.6853-3-richard.henderson@linaro.org>
In-Reply-To: <20170829204759.6853-1-richard.henderson@linaro.org>
References: <20170829204759.6853-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/8] tcg/s390: Merge cmpi facilities check to
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, agraf@suse.de, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/s390/tcg-target.inc.c | 68 +++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index d34649eb13..e075b4844a 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -41,7 +41,7 @@
 #define TCG_CT_CONST_MULI  0x100
 #define TCG_CT_CONST_ORI   0x200
 #define TCG_CT_CONST_XORI  0x400
-#define TCG_CT_CONST_CMPI  0x800
+#define TCG_CT_CONST_U31   0x800
 #define TCG_CT_CONST_ADLI  0x1000
 #define TCG_CT_CONST_ZERO  0x2000
 
@@ -398,7 +398,18 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         ct->ct |= TCG_CT_CONST_XORI;
         break;
     case 'C':
-        ct->ct |= TCG_CT_CONST_CMPI;
+        /* ??? We have no insight here into whether the comparison is
+           signed or unsigned.  The COMPARE IMMEDIATE insn uses a 32-bit
+           signed immediate, and the COMPARE LOGICAL IMMEDIATE insn uses
+           a 32-bit unsigned immediate.  If we were to use the (semi)
+           obvious "val == (int32_t)val" we would be enabling unsigned
+           comparisons vs very large numbers.  The only solution is to
+           take the intersection of the ranges.  */
+        /* ??? Another possible solution is to simply lie and allow all
+           constants here and force the out-of-range values into a temp
+           register in tgen_cmp when we have knowledge of the actual
+           comparison code in use.  */
+        ct->ct |= TCG_CT_CONST_U31;
         break;
     case 'Z':
         ct->ct |= TCG_CT_CONST_ZERO;
@@ -463,35 +474,6 @@ static int tcg_match_xori(TCGType type, tcg_target_long val)
     return 1;
 }
 
-/* Imediates to be used with comparisons.  */
-
-static int tcg_match_cmpi(TCGType type, tcg_target_long val)
-{
-    if (s390_facilities & FACILITY_EXT_IMM) {
-        /* The COMPARE IMMEDIATE instruction is available.  */
-        if (type == TCG_TYPE_I32) {
-            /* We have a 32-bit immediate and can compare against anything.  */
-            return 1;
-        } else {
-            /* ??? We have no insight here into whether the comparison is
-               signed or unsigned.  The COMPARE IMMEDIATE insn uses a 32-bit
-               signed immediate, and the COMPARE LOGICAL IMMEDIATE insn uses
-               a 32-bit unsigned immediate.  If we were to use the (semi)
-               obvious "val == (int32_t)val" we would be enabling unsigned
-               comparisons vs very large numbers.  The only solution is to
-               take the intersection of the ranges.  */
-            /* ??? Another possible solution is to simply lie and allow all
-               constants here and force the out-of-range values into a temp
-               register in tgen_cmp when we have knowledge of the actual
-               comparison code in use.  */
-            return val >= 0 && val <= 0x7fffffff;
-        }
-    } else {
-        /* Only the LOAD AND TEST instruction is available.  */
-        return val == 0;
-    }
-}
-
 /* Immediates to be used with add2/sub2.  */
 
 static int tcg_match_add2i(TCGType type, tcg_target_long val)
@@ -537,8 +519,8 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
         return tcg_match_ori(type, val);
     } else if (ct & TCG_CT_CONST_XORI) {
         return tcg_match_xori(type, val);
-    } else if (ct & TCG_CT_CONST_CMPI) {
-        return tcg_match_cmpi(type, val);
+    } else if (ct & TCG_CT_CONST_U31) {
+        return val >= 0 && val <= 0x7fffffff;
     } else if (ct & TCG_CT_CONST_ZERO) {
         return val == 0;
     }
@@ -2252,7 +2234,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef r_r = { .args_ct_str = { "r", "r" } };
     static const TCGTargetOpDef r_L = { .args_ct_str = { "r", "L" } };
     static const TCGTargetOpDef L_L = { .args_ct_str = { "L", "L" } };
+    static const TCGTargetOpDef r_ri = { .args_ct_str = { "r", "ri" } };
     static const TCGTargetOpDef r_rC = { .args_ct_str = { "r", "rC" } };
+    static const TCGTargetOpDef r_rZ = { .args_ct_str = { "r", "rZ" } };
     static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
     static const TCGTargetOpDef r_0_ri = { .args_ct_str = { "r", "0", "ri" } };
     static const TCGTargetOpDef r_0_rK = { .args_ct_str = { "r", "0", "rK" } };
@@ -2320,8 +2304,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &r_r_ri;
 
     case INDEX_op_brcond_i32:
+        /* Without EXT_IMM, only the LOAD AND TEST insn is available.  */
+        return (s390_facilities & FACILITY_EXT_IMM ? &r_ri : &r_rZ);
     case INDEX_op_brcond_i64:
-        return &r_rC;
+        return (s390_facilities & FACILITY_EXT_IMM ? &r_rC : &r_rZ);
 
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
@@ -2366,16 +2352,22 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
         {
-            static const TCGTargetOpDef setc
+            /* Without EXT_IMM, only the LOAD AND TEST insn is available.  */
+            static const TCGTargetOpDef setc_z
+                = { .args_ct_str = { "r", "r", "rZ" } };
+            static const TCGTargetOpDef setc_c
                 = { .args_ct_str = { "r", "r", "rC" } };
-            return &setc;
+            return (s390_facilities & FACILITY_EXT_IMM ? &setc_c : &setc_z);
         }
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         {
-            static const TCGTargetOpDef movc
+            /* Without EXT_IMM, only the LOAD AND TEST insn is available.  */
+            static const TCGTargetOpDef movc_z
+                = { .args_ct_str = { "r", "r", "rZ", "r", "0" } };
+            static const TCGTargetOpDef movc_c
                 = { .args_ct_str = { "r", "r", "rC", "r", "0" } };
-            return &movc;
+            return (s390_facilities & FACILITY_EXT_IMM ? &movc_c : &movc_z);
         }
     case INDEX_op_div2_i32:
     case INDEX_op_div2_i64:
-- 
2.13.5
