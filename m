Received: from eggs.gnu.org ([2001:4830:134:3::10]:40052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpbeT-0005Za-W2
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpbeP-0000N1-85
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:50:02 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:38097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpbeP-0000Mk-2i
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:49:57 -0400
Received: by mail-pg0-x22d.google.com with SMTP id v66so15523204pgb.5
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 07:49:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 07:49:36 -0700
Message-Id: <20170906144940.30880-11-richard.henderson@linaro.org>
In-Reply-To: <20170906144940.30880-1-richard.henderson@linaro.org>
References: <20170906144940.30880-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 10/14] tcg/s390: Merge add2i facilities check to
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
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/s390/tcg-target.inc.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index ff3f644f8e..6b08ccea6d 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -43,7 +43,7 @@
 #define TCG_CT_CONST_ORI   0x400
 #define TCG_CT_CONST_XORI  0x800
 #define TCG_CT_CONST_U31   0x1000
-#define TCG_CT_CONST_ADLI  0x2000
+#define TCG_CT_CONST_S33   0x2000
 #define TCG_CT_CONST_ZERO  0x4000
 
 /* Several places within the instruction set 0 means "no register"
@@ -387,7 +387,7 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         tcg_regset_set_reg(ct->u.regs, TCG_REG_R3);
         break;
     case 'A':
-        ct->ct |= TCG_CT_CONST_ADLI;
+        ct->ct |= TCG_CT_CONST_S33;
         break;
     case 'I':
         ct->ct |= TCG_CT_CONST_S16;
@@ -478,20 +478,6 @@ static int tcg_match_xori(TCGType type, tcg_target_long val)
     return 1;
 }
 
-/* Immediates to be used with add2/sub2.  */
-
-static int tcg_match_add2i(TCGType type, tcg_target_long val)
-{
-    if (s390_facilities & FACILITY_EXT_IMM) {
-        if (type == TCG_TYPE_I32) {
-            return 1;
-        } else if (val >= -0xffffffffll && val <= 0xffffffffll) {
-            return 1;
-        }
-    }
-    return 0;
-}
-
 /* Test if a constant matches the constraint. */
 static int tcg_target_const_match(tcg_target_long val, TCGType type,
                                   const TCGArgConstraint *arg_ct)
@@ -511,8 +497,8 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
         return val == (int16_t)val;
     } else if (ct & TCG_CT_CONST_S32) {
         return val == (int32_t)val;
-    } else if (ct & TCG_CT_CONST_ADLI) {
-        return tcg_match_add2i(type, val);
+    } else if (ct & TCG_CT_CONST_S33) {
+        return val >= -0xffffffffll && val <= 0xffffffffll;
     } else if (ct & TCG_CT_CONST_ORI) {
         return tcg_match_ori(type, val);
     } else if (ct & TCG_CT_CONST_XORI) {
@@ -2241,6 +2227,12 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef r_0_rJ = { .args_ct_str = { "r", "0", "rJ" } };
     static const TCGTargetOpDef r_0_rO = { .args_ct_str = { "r", "0", "rO" } };
     static const TCGTargetOpDef r_0_rX = { .args_ct_str = { "r", "0", "rX" } };
+    static const TCGTargetOpDef a2_r
+        = { .args_ct_str = { "r", "r", "0", "1", "r", "r" } };
+    static const TCGTargetOpDef a2_ri
+        = { .args_ct_str = { "r", "r", "0", "1", "ri", "r" } };
+    static const TCGTargetOpDef a2_rA
+        = { .args_ct_str = { "r", "r", "0", "1", "rA", "r" } };
 
     switch (op) {
     case INDEX_op_goto_ptr:
@@ -2389,15 +2381,13 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
                 = { .args_ct_str = { "b", "a", "0", "r" } };
             return &mul2;
         }
+
     case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
+        return (s390_facilities & FACILITY_EXT_IMM ? &a2_ri : &a2_r);
+    case INDEX_op_add2_i64:
     case INDEX_op_sub2_i64:
-        {
-            static const TCGTargetOpDef arith2
-                = { .args_ct_str = { "r", "r", "0", "1", "rA", "r" } };
-            return &arith2;
-        }
+        return (s390_facilities & FACILITY_EXT_IMM ? &a2_rA : &a2_r);
 
     default:
         break;
-- 
2.13.5
