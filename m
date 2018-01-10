Received: from eggs.gnu.org ([2001:4830:134:3::10]:44834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eZ96b-0003By-Bz
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 00:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eZ96X-0006N8-AE
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 00:39:17 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:43817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1eZ96X-0006MS-3H
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 00:39:13 -0500
Received: by mail-pl0-x243.google.com with SMTP id z5so6675358plo.10
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 21:39:12 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  9 Jan 2018 21:39:08 -0800
Message-Id: <1515562748-32287-1-git-send-email-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH] tcg/arm: Fix double-word comparisons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, david@gibson.dropbear.id.au, pbonzini@redhat.com, mdroth@linux.vnet.ibm.com

The code sequence we were generating was only good for unsigned
comparisons.  For signed comparisions, use the sequence from gcc.

Fixes booting of ppc64 firmware, with a patch changing the code
sequence for ppc comparisons.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/arm/tcg-target.inc.c | 112 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 80 insertions(+), 32 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 98a1253..b9890c8 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -239,10 +239,11 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
     }
 }
 
-#define TCG_CT_CONST_ARM  0x100
-#define TCG_CT_CONST_INV  0x200
-#define TCG_CT_CONST_NEG  0x400
-#define TCG_CT_CONST_ZERO 0x800
+#define TCG_CT_CONST_ARM     0x0100
+#define TCG_CT_CONST_INV     0x0200
+#define TCG_CT_CONST_NEG     0x0400
+#define TCG_CT_CONST_INVNEG  0x0800
+#define TCG_CT_CONST_ZERO    0x1000
 
 /* parse target specific constraints */
 static const char *target_parse_constraint(TCGArgConstraint *ct,
@@ -258,6 +259,9 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     case 'N': /* The gcc constraint letter is L, already used here.  */
         ct->ct |= TCG_CT_CONST_NEG;
         break;
+    case 'M':
+        ct->ct |= TCG_CT_CONST_INVNEG;
+        break;
     case 'Z':
         ct->ct |= TCG_CT_CONST_ZERO;
         break;
@@ -351,8 +355,7 @@ static inline int check_fit_imm(uint32_t imm)
 static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
                                          const TCGArgConstraint *arg_ct)
 {
-    int ct;
-    ct = arg_ct->ct;
+    int ct = arg_ct->ct;
     if (ct & TCG_CT_CONST) {
         return 1;
     } else if ((ct & TCG_CT_CONST_ARM) && check_fit_imm(val)) {
@@ -361,6 +364,9 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
         return 1;
     } else if ((ct & TCG_CT_CONST_NEG) && check_fit_imm(-val)) {
         return 1;
+    } else if ((ct & TCG_CT_CONST_INVNEG)
+               && check_fit_imm(~val) && check_fit_imm(-val)) {
+        return 1;
     } else if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
         return 1;
     } else {
@@ -1103,6 +1109,64 @@ static inline void tcg_out_mb(TCGContext *s, TCGArg a0)
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
+        tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0, ah, bh, const_bh);
+        tcg_out_dat_rIN(s, COND_EQ, ARITH_CMP, ARITH_CMN, 0, al, bl, const_bl);
+        return cond;
+
+    case TCG_COND_LT:
+    case TCG_COND_GE:
+        /* We perform a double-word subtraction and examine the result.
+           We do not actually need the result of the subtract, so the
+           low part "subtract" is a compare.  For the high half we have
+           no choice but to compute into a temporary.  */
+        tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0, al, bl, const_bl);
+        tcg_out_dat_rIK(s, COND_AL, ARITH_SBC | TO_CPSR, ARITH_ADC | TO_CPSR,
+                        TCG_REG_TMP, ah, bh, const_bh);
+        return cond;
+
+    case TCG_COND_LE:
+    case TCG_COND_GT:
+        /* Similar, but with swapped arguments.  And of course we must
+           force the immediates into a register.  */
+        if (const_bl) {
+            tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_TMP, bl);
+            bl = TCG_REG_TMP;
+        }
+        tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0, bl, al, 0);
+        if (const_bh) {
+            tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_TMP, bh);
+            bh = TCG_REG_TMP;
+        }
+        tcg_out_dat_rIK(s, COND_AL, ARITH_SBC | TO_CPSR, ARITH_ADC | TO_CPSR,
+                        TCG_REG_TMP, bh, ah, 0);
+        return tcg_swap_cond(cond);
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 #ifdef CONFIG_SOFTMMU
 #include "tcg-ldst.inc.c"
 
@@ -1964,22 +2028,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
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
@@ -1988,15 +2036,15 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
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
 
@@ -2093,9 +2141,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef sub2
         = { .args_ct_str = { "r", "r", "rI", "rI", "rIN", "rIK" } };
     static const TCGTargetOpDef br2
-        = { .args_ct_str = { "r", "r", "rIN", "rIN" } };
+        = { .args_ct_str = { "r", "r", "rIM", "rIM" } };
     static const TCGTargetOpDef setc2
-        = { .args_ct_str = { "r", "r", "r", "rIN", "rIN" } };
+        = { .args_ct_str = { "r", "r", "r", "rIM", "rIM" } };
 
     switch (op) {
     case INDEX_op_goto_ptr:
-- 
1.8.3.1
