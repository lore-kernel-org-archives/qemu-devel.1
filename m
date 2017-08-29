Received: from eggs.gnu.org ([2001:4830:134:3::10]:49514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmnQj-0002TK-7x
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmnQh-0001VY-Po
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:48:13 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:33569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmnQh-0001VD-H9
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:48:11 -0400
Received: by mail-pg0-x22a.google.com with SMTP id t3so14084237pgt.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 13:48:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 29 Aug 2017 13:47:56 -0700
Message-Id: <20170829204759.6853-6-richard.henderson@linaro.org>
In-Reply-To: <20170829204759.6853-1-richard.henderson@linaro.org>
References: <20170829204759.6853-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 5/8] tcg/s390: Merge ori+xori facilities check
 to tcg_target_op_def
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
 tcg/s390/tcg-target.inc.c | 101 +++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 68 deletions(-)

diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 6b08ccea6d..5414c9d879 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -40,8 +40,8 @@
 
 #define TCG_CT_CONST_S16   0x100
 #define TCG_CT_CONST_S32   0x200
-#define TCG_CT_CONST_ORI   0x400
-#define TCG_CT_CONST_XORI  0x800
+#define TCG_CT_CONST_NN16  0x400
+#define TCG_CT_CONST_NN32  0x800
 #define TCG_CT_CONST_U31   0x1000
 #define TCG_CT_CONST_S33   0x2000
 #define TCG_CT_CONST_ZERO  0x4000
@@ -395,11 +395,11 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     case 'J':
         ct->ct |= TCG_CT_CONST_S32;
         break;
-    case 'O':
-        ct->ct |= TCG_CT_CONST_ORI;
+    case 'N':
+        ct->ct |= TCG_CT_CONST_NN16;
         break;
-    case 'X':
-        ct->ct |= TCG_CT_CONST_XORI;
+    case 'M':
+        ct->ct |= TCG_CT_CONST_NN32;
         break;
     case 'C':
         /* ??? We have no insight here into whether the comparison is
@@ -424,60 +424,6 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     return ct_str;
 }
 
-/* Immediates to be used with logical OR.  This is an optimization only,
-   since a full 64-bit immediate OR can always be performed with 4 sequential
-   OI[LH][LH] instructions.  What we're looking for is immediates that we
-   can load efficiently, and the immediate load plus the reg-reg OR is
-   smaller than the sequential OI's.  */
-
-static int tcg_match_ori(TCGType type, tcg_target_long val)
-{
-    if (s390_facilities & FACILITY_EXT_IMM) {
-        if (type == TCG_TYPE_I32) {
-            /* All 32-bit ORs can be performed with 1 48-bit insn.  */
-            return 1;
-        }
-    }
-
-    /* Look for negative values.  These are best to load with LGHI.  */
-    if (val < 0) {
-        if (val == (int16_t)val) {
-            return 0;
-        }
-        if (s390_facilities & FACILITY_EXT_IMM) {
-            if (val == (int32_t)val) {
-                return 0;
-            }
-        }
-    }
-
-    return 1;
-}
-
-/* Immediates to be used with logical XOR.  This is almost, but not quite,
-   only an optimization.  XOR with immediate is only supported with the
-   extended-immediate facility.  That said, there are a few patterns for
-   which it is better to load the value into a register first.  */
-
-static int tcg_match_xori(TCGType type, tcg_target_long val)
-{
-    if ((s390_facilities & FACILITY_EXT_IMM) == 0) {
-        return 0;
-    }
-
-    if (type == TCG_TYPE_I32) {
-        /* All 32-bit XORs can be performed with 1 48-bit insn.  */
-        return 1;
-    }
-
-    /* Look for negative values.  These are best to load with LGHI.  */
-    if (val < 0 && val == (int32_t)val) {
-        return 0;
-    }
-
-    return 1;
-}
-
 /* Test if a constant matches the constraint. */
 static int tcg_target_const_match(tcg_target_long val, TCGType type,
                                   const TCGArgConstraint *arg_ct)
@@ -499,10 +445,10 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
         return val == (int32_t)val;
     } else if (ct & TCG_CT_CONST_S33) {
         return val >= -0xffffffffll && val <= 0xffffffffll;
-    } else if (ct & TCG_CT_CONST_ORI) {
-        return tcg_match_ori(type, val);
-    } else if (ct & TCG_CT_CONST_XORI) {
-        return tcg_match_xori(type, val);
+    } else if (ct & TCG_CT_CONST_NN16) {
+        return !(val < 0 && val == (int16_t)val);
+    } else if (ct & TCG_CT_CONST_NN32) {
+        return !(val < 0 && val == (int32_t)val);
     } else if (ct & TCG_CT_CONST_U31) {
         return val >= 0 && val <= 0x7fffffff;
     } else if (ct & TCG_CT_CONST_ZERO) {
@@ -2222,11 +2168,12 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef r_rC = { .args_ct_str = { "r", "rC" } };
     static const TCGTargetOpDef r_rZ = { .args_ct_str = { "r", "rZ" } };
     static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
+    static const TCGTargetOpDef r_0_r = { .args_ct_str = { "r", "0", "r" } };
     static const TCGTargetOpDef r_0_ri = { .args_ct_str = { "r", "0", "ri" } };
     static const TCGTargetOpDef r_0_rI = { .args_ct_str = { "r", "0", "rI" } };
     static const TCGTargetOpDef r_0_rJ = { .args_ct_str = { "r", "0", "rJ" } };
-    static const TCGTargetOpDef r_0_rO = { .args_ct_str = { "r", "0", "rO" } };
-    static const TCGTargetOpDef r_0_rX = { .args_ct_str = { "r", "0", "rX" } };
+    static const TCGTargetOpDef r_0_rN = { .args_ct_str = { "r", "0", "rN" } };
+    static const TCGTargetOpDef r_0_rM = { .args_ct_str = { "r", "0", "rM" } };
     static const TCGTargetOpDef a2_r
         = { .args_ct_str = { "r", "r", "0", "1", "r", "r" } };
     static const TCGTargetOpDef a2_ri
@@ -2275,11 +2222,29 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return (s390_facilities & FACILITY_GEN_INST_EXT ? &r_0_rJ : &r_0_rI);
 
     case INDEX_op_or_i32:
+        /* The use of [iNM] constraints are optimization only, since a full
+           64-bit immediate OR can always be performed with 4 sequential
+           OI[LH][LH] instructions.  By rejecting certain negative ranges,
+           the immediate load plus the reg-reg OR is smaller.  */
+        return (s390_facilities & FACILITY_EXT_IMM
+                ? &r_0_ri
+                : &r_0_rN);
     case INDEX_op_or_i64:
-        return &r_0_rO;
+        return (s390_facilities & FACILITY_EXT_IMM
+                ? &r_0_rM
+                : &r_0_rN);
+
     case INDEX_op_xor_i32:
+        /* Without EXT_IMM, no immediates are supported.  Otherwise,
+           rejecting certain negative ranges leads to smaller code.  */
+        return (s390_facilities & FACILITY_EXT_IMM
+                ? &r_0_ri
+                : &r_0_r);
     case INDEX_op_xor_i64:
-        return &r_0_rX;
+        return (s390_facilities & FACILITY_EXT_IMM
+                ? &r_0_rM
+                : &r_0_r);
+
     case INDEX_op_and_i32:
     case INDEX_op_and_i64:
         return &r_0_ri;
-- 
2.13.5
