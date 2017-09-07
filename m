Received: from eggs.gnu.org ([2001:4830:134:3::10]:52153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5U3-000369-GA
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5Ty-0008DF-Jc
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:15 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:37895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq5Ty-0008C0-BN
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:10 -0400
Received: by mail-pg0-x22c.google.com with SMTP id v66so1788427pgb.5
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 15:41:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 15:40:38 -0700
Message-Id: <20170907224051.21518-11-richard.henderson@linaro.org>
In-Reply-To: <20170907224051.21518-1-richard.henderson@linaro.org>
References: <20170907224051.21518-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 10/23] tcg/s390: Use constant pool for xori
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

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/s390/tcg-target.inc.c | 77 ++++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 83fac71c31..b0b34fa5ab 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -39,11 +39,9 @@
 
 #define TCG_CT_CONST_S16   0x100
 #define TCG_CT_CONST_S32   0x200
-#define TCG_CT_CONST_NN16  0x400
-#define TCG_CT_CONST_NN32  0x800
-#define TCG_CT_CONST_U31   0x1000
-#define TCG_CT_CONST_S33   0x2000
-#define TCG_CT_CONST_ZERO  0x4000
+#define TCG_CT_CONST_U31   0x400
+#define TCG_CT_CONST_S33   0x800
+#define TCG_CT_CONST_ZERO  0x1000
 
 /* Several places within the instruction set 0 means "no register"
    rather than TCG_REG_R0.  */
@@ -234,6 +232,7 @@ typedef enum S390Opcode {
     RXY_STRVG   = 0xe32f,
     RXY_STRVH   = 0xe33f,
     RXY_STY     = 0xe350,
+    RXY_XG      = 0xe382,
 
     RX_A        = 0x5a,
     RX_C        = 0x59,
@@ -424,12 +423,6 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     case 'J':
         ct->ct |= TCG_CT_CONST_S32;
         break;
-    case 'N':
-        ct->ct |= TCG_CT_CONST_NN16;
-        break;
-    case 'M':
-        ct->ct |= TCG_CT_CONST_NN32;
-        break;
     case 'C':
         /* ??? We have no insight here into whether the comparison is
            signed or unsigned.  The COMPARE IMMEDIATE insn uses a 32-bit
@@ -474,10 +467,6 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
         return val == (int32_t)val;
     } else if (ct & TCG_CT_CONST_S33) {
         return val >= -0xffffffffll && val <= 0xffffffffll;
-    } else if (ct & TCG_CT_CONST_NN16) {
-        return !(val < 0 && val == (int16_t)val);
-    } else if (ct & TCG_CT_CONST_NN32) {
-        return !(val < 0 && val == (int32_t)val);
     } else if (ct & TCG_CT_CONST_U31) {
         return val >= 0 && val <= 0x7fffffff;
     } else if (ct & TCG_CT_CONST_ZERO) {
@@ -1062,14 +1051,40 @@ static void tgen_ori(TCGContext *s, TCGType type, TCGReg dest, uint64_t val)
     }
 }
 
-static void tgen64_xori(TCGContext *s, TCGReg dest, tcg_target_ulong val)
+static void tgen_xori(TCGContext *s, TCGType type, TCGReg dest, uint64_t val)
 {
-    /* Perform the xor by parts.  */
-    if (val & 0xffffffff) {
-        tcg_out_insn(s, RIL, XILF, dest, val);
+    /* Try all 48-bit insns that can perform it in one go.  */
+    if (s390_facilities & FACILITY_EXT_IMM) {
+        if ((val & 0xffffffff00000000ull) == 0) {
+            tcg_out_insn(s, RIL, XILF, dest, val);
+            return;
+        }
+        if ((val & 0x00000000ffffffffull) == 0) {
+            tcg_out_insn(s, RIL, XIHF, dest, val >> 32);
+            return;
+        }
     }
-    if (val > 0xffffffff) {
-        tcg_out_insn(s, RIL, XIHF, dest, val >> 31 >> 1);
+
+    /* Use the constant pool if USE_REG_TB, but not for small constants.  */
+    if (maybe_out_small_movi(s, type, TCG_TMP0, val)) {
+        if (type == TCG_TYPE_I32) {
+            tcg_out_insn(s, RR, XR, dest, TCG_TMP0);
+        } else {
+            tcg_out_insn(s, RRE, XGR, dest, TCG_TMP0);
+        }
+    } else if (USE_REG_TB) {
+        tcg_out_insn(s, RXY, XG, dest, TCG_REG_TB, TCG_REG_NONE, 0);
+        new_pool_label(s, val, R_390_20, s->code_ptr - 2,
+                       -(intptr_t)s->code_gen_ptr);
+    } else {
+        /* Perform the xor by parts.  */
+        tcg_debug_assert(s390_facilities & FACILITY_EXT_IMM);
+        if (val & 0xffffffff) {
+            tcg_out_insn(s, RIL, XILF, dest, val);
+        }
+        if (val > 0xffffffff) {
+            tcg_out_insn(s, RIL, XIHF, dest, val >> 32);
+        }
     }
 }
 
@@ -1889,7 +1904,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
         if (const_args[2]) {
             tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tgen64_xori(s, a0, a2);
+            tgen_xori(s, TCG_TYPE_I32, a0, a2);
         } else if (a0 == a1) {
             tcg_out_insn(s, RR, XR, args[0], args[2]);
         } else {
@@ -2121,7 +2136,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
             tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen64_xori(s, a0, a2);
+            tgen_xori(s, TCG_TYPE_I64, a0, a2);
         } else if (a0 == a1) {
             tcg_out_insn(s, RRE, XGR, a0, a2);
         } else {
@@ -2313,12 +2328,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef r_rC = { .args_ct_str = { "r", "rC" } };
     static const TCGTargetOpDef r_rZ = { .args_ct_str = { "r", "rZ" } };
     static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
-    static const TCGTargetOpDef r_r_rM = { .args_ct_str = { "r", "r", "rM" } };
-    static const TCGTargetOpDef r_0_r = { .args_ct_str = { "r", "0", "r" } };
     static const TCGTargetOpDef r_0_ri = { .args_ct_str = { "r", "0", "ri" } };
     static const TCGTargetOpDef r_0_rI = { .args_ct_str = { "r", "0", "rI" } };
     static const TCGTargetOpDef r_0_rJ = { .args_ct_str = { "r", "0", "rJ" } };
-    static const TCGTargetOpDef r_0_rM = { .args_ct_str = { "r", "0", "rM" } };
     static const TCGTargetOpDef a2_r
         = { .args_ct_str = { "r", "r", "0", "1", "r", "r" } };
     static const TCGTargetOpDef a2_ri
@@ -2360,6 +2372,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_and_i64:
     case INDEX_op_or_i32:
     case INDEX_op_or_i64:
+    case INDEX_op_xor_i32:
+    case INDEX_op_xor_i64:
         return (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_ri : &r_0_ri);
 
     case INDEX_op_mul_i32:
@@ -2370,17 +2384,6 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_mul_i64:
         return (s390_facilities & FACILITY_GEN_INST_EXT ? &r_0_rJ : &r_0_rI);
 
-    case INDEX_op_xor_i32:
-        /* Without EXT_IMM, no immediates are supported.  Otherwise,
-           rejecting certain negative ranges leads to smaller code.  */
-        return (s390_facilities & FACILITY_EXT_IMM
-                ? (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_ri : &r_0_ri)
-                : &r_0_r);
-    case INDEX_op_xor_i64:
-        return (s390_facilities & FACILITY_EXT_IMM
-                ? (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_rM : &r_0_rM)
-                : &r_0_r);
-
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
-- 
2.13.5
