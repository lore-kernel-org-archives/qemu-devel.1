Received: from eggs.gnu.org ([2001:4830:134:3::10]:52071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebUNG-0000U0-B4
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebUNC-0008NO-MQ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:46:10 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:39642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebUNC-0008M2-Ef
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:46:06 -0500
Received: by mail-pf0-x242.google.com with SMTP id e11so9976601pff.6
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 08:46:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Jan 2018 08:45:57 -0800
Message-Id: <20180116164600.7480-2-richard.henderson@linaro.org>
In-Reply-To: <20180116164600.7480-1-richard.henderson@linaro.org>
References: <20180116164600.7480-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v2 1/4] tcg/arm: Fix double-word comparisons
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

The code sequence we were generating was only good for unsigned
comparisons.  For signed comparisions, use the sequence from gcc.

Fixes booting of ppc64 firmware, with a patch changing the code
sequence for ppc comparisons.

Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.inc.c | 86 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 26 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 98a12535a5..d7b09e8e0c 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1103,6 +1103,56 @@ static inline void tcg_out_mb(TCGContext *s, TCGArg a0)
     }
 }
 
+static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
+                            const int *const_args)
+{
+    TCGReg al = args[0];
+    TCGReg ah = args[1];
+    TCGArg bl = args[2];
+    TCGArg bh = args[3];
+    TCGCond cond = args[4];
+    int const_bl = const_args[2];
+    int const_bh = const_args[3];
+
+    switch (cond) {
+    case TCG_COND_EQ:
+    case TCG_COND_NE:
+    case TCG_COND_LTU:
+    case TCG_COND_LEU:
+    case TCG_COND_GTU:
+    case TCG_COND_GEU:
+        /* We perform a conditional comparision.  If the high half is
+           equal, then overwrite the flags with the comparison of the
+           low half.  The resulting flags cover the whole.  */
+        tcg_out_dat_rI(s, COND_AL, ARITH_CMP, 0, ah, bh, const_bh);
+        tcg_out_dat_rI(s, COND_EQ, ARITH_CMP, 0, al, bl, const_bl);
+        return cond;
+
+    case TCG_COND_LT:
+    case TCG_COND_GE:
+        /* We perform a double-word subtraction and examine the result.
+           We do not actually need the result of the subtract, so the
+           low part "subtract" is a compare.  For the high half we have
+           no choice but to compute into a temporary.  */
+        tcg_out_dat_rI(s, COND_AL, ARITH_CMP, 0, al, bl, const_bl);
+        tcg_out_dat_rI(s, COND_AL, ARITH_SBC | TO_CPSR,
+                       TCG_REG_TMP, ah, bh, const_bh);
+        return cond;
+
+    case TCG_COND_LE:
+    case TCG_COND_GT:
+        /* Similar, but with swapped arguments, via reversed subtract.  */
+        tcg_out_dat_rI(s, COND_AL, ARITH_RSB | TO_CPSR,
+                       TCG_REG_TMP, al, bl, const_bl);
+        tcg_out_dat_rI(s, COND_AL, ARITH_RSC | TO_CPSR,
+                       TCG_REG_TMP, ah, bh, const_bh);
+        return tcg_swap_cond(cond);
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 #ifdef CONFIG_SOFTMMU
 #include "tcg-ldst.inc.c"
 
@@ -1964,22 +2014,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_goto_label(s, tcg_cond_to_arm_cond[args[2]],
                            arg_label(args[3]));
         break;
-    case INDEX_op_brcond2_i32:
-        /* The resulting conditions are:
-         * TCG_COND_EQ    -->  a0 == a2 && a1 == a3,
-         * TCG_COND_NE    --> (a0 != a2 && a1 == a3) ||  a1 != a3,
-         * TCG_COND_LT(U) --> (a0 <  a2 && a1 == a3) ||  a1 <  a3,
-         * TCG_COND_GE(U) --> (a0 >= a2 && a1 == a3) || (a1 >= a3 && a1 != a3),
-         * TCG_COND_LE(U) --> (a0 <= a2 && a1 == a3) || (a1 <= a3 && a1 != a3),
-         * TCG_COND_GT(U) --> (a0 >  a2 && a1 == a3) ||  a1 >  a3,
-         */
-        tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0,
-                        args[1], args[3], const_args[3]);
-        tcg_out_dat_rIN(s, COND_EQ, ARITH_CMP, ARITH_CMN, 0,
-                        args[0], args[2], const_args[2]);
-        tcg_out_goto_label(s, tcg_cond_to_arm_cond[args[4]],
-                           arg_label(args[5]));
-        break;
     case INDEX_op_setcond_i32:
         tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0,
                         args[1], args[2], const_args[2]);
@@ -1988,15 +2022,15 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(args[3])],
                         ARITH_MOV, args[0], 0, 0);
         break;
+
+    case INDEX_op_brcond2_i32:
+        c = tcg_out_cmp2(s, args, const_args);
+        tcg_out_goto_label(s, tcg_cond_to_arm_cond[c], arg_label(args[5]));
+        break;
     case INDEX_op_setcond2_i32:
-        /* See brcond2_i32 comment */
-        tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0,
-                        args[2], args[4], const_args[4]);
-        tcg_out_dat_rIN(s, COND_EQ, ARITH_CMP, ARITH_CMN, 0,
-                        args[1], args[3], const_args[3]);
-        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[args[5]],
-                        ARITH_MOV, args[0], 0, 1);
-        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(args[5])],
+        c = tcg_out_cmp2(s, args + 1, const_args + 1);
+        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[c], ARITH_MOV, args[0], 0, 1);
+        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(c)],
                         ARITH_MOV, args[0], 0, 0);
         break;
 
@@ -2093,9 +2127,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef sub2
         = { .args_ct_str = { "r", "r", "rI", "rI", "rIN", "rIK" } };
     static const TCGTargetOpDef br2
-        = { .args_ct_str = { "r", "r", "rIN", "rIN" } };
+        = { .args_ct_str = { "r", "r", "rI", "rI" } };
     static const TCGTargetOpDef setc2
-        = { .args_ct_str = { "r", "r", "r", "rIN", "rIN" } };
+        = { .args_ct_str = { "r", "r", "r", "rI", "rI" } };
 
     switch (op) {
     case INDEX_op_goto_ptr:
-- 
2.14.3
