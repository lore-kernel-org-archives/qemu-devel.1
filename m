Received: from eggs.gnu.org ([2001:4830:134:3::10]:52125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5U2-00034f-10
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5Tw-0008AU-UJ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:14 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:36680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq5Tw-00089a-Mf
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:08 -0400
Received: by mail-pg0-x236.google.com with SMTP id m9so1818296pgd.3
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 15:41:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 15:40:37 -0700
Message-Id: <20170907224051.21518-10-richard.henderson@linaro.org>
In-Reply-To: <20170907224051.21518-1-richard.henderson@linaro.org>
References: <20170907224051.21518-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 09/23] tcg/s390: Use constant pool for ori
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
 tcg/s390/tcg-target.inc.c | 74 ++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 40 deletions(-)

diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 4be57c5765..83fac71c31 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -225,6 +225,7 @@ typedef enum S390Opcode {
     RXY_LRVH    = 0xe31f,
     RXY_LY      = 0xe358,
     RXY_NG      = 0xe380,
+    RXY_OG      = 0xe381,
     RXY_STCY    = 0xe372,
     RXY_STG     = 0xe324,
     RXY_STHY    = 0xe370,
@@ -1004,55 +1005,60 @@ static void tgen_andi(TCGContext *s, TCGType type, TCGReg dest, uint64_t val)
     }
 }
 
-static void tgen64_ori(TCGContext *s, TCGReg dest, tcg_target_ulong val)
+static void tgen_ori(TCGContext *s, TCGType type, TCGReg dest, uint64_t val)
 {
     static const S390Opcode oi_insns[4] = {
         RI_OILL, RI_OILH, RI_OIHL, RI_OIHH
     };
-    static const S390Opcode nif_insns[2] = {
+    static const S390Opcode oif_insns[2] = {
         RIL_OILF, RIL_OIHF
     };
 
     int i;
 
     /* Look for no-op.  */
-    if (val == 0) {
+    if (unlikely(val == 0)) {
         return;
     }
 
-    if (s390_facilities & FACILITY_EXT_IMM) {
-        /* Try all 32-bit insns that can perform it in one go.  */
-        for (i = 0; i < 4; i++) {
-            tcg_target_ulong mask = (0xffffull << i*16);
-            if ((val & mask) != 0 && (val & ~mask) == 0) {
-                tcg_out_insn_RI(s, oi_insns[i], dest, val >> i*16);
-                return;
-            }
+    /* Try all 32-bit insns that can perform it in one go.  */
+    for (i = 0; i < 4; i++) {
+        tcg_target_ulong mask = (0xffffull << i*16);
+        if ((val & mask) != 0 && (val & ~mask) == 0) {
+            tcg_out_insn_RI(s, oi_insns[i], dest, val >> i*16);
+            return;
         }
+    }
 
-        /* Try all 48-bit insns that can perform it in one go.  */
+    /* Try all 48-bit insns that can perform it in one go.  */
+    if (s390_facilities & FACILITY_EXT_IMM) {
         for (i = 0; i < 2; i++) {
             tcg_target_ulong mask = (0xffffffffull << i*32);
             if ((val & mask) != 0 && (val & ~mask) == 0) {
-                tcg_out_insn_RIL(s, nif_insns[i], dest, val >> i*32);
+                tcg_out_insn_RIL(s, oif_insns[i], dest, val >> i*32);
                 return;
             }
         }
+    }
 
+    /* Use the constant pool if USE_REG_TB, but not for small constants.  */
+    if (maybe_out_small_movi(s, type, TCG_TMP0, val)) {
+        if (type == TCG_TYPE_I32) {
+            tcg_out_insn(s, RR, OR, dest, TCG_TMP0);
+        } else {
+            tcg_out_insn(s, RRE, OGR, dest, TCG_TMP0);
+        }
+    } else if (USE_REG_TB) {
+        tcg_out_insn(s, RXY, OG, dest, TCG_REG_TB, TCG_REG_NONE, 0);
+        new_pool_label(s, val, R_390_20, s->code_ptr - 2,
+                       -(intptr_t)s->code_gen_ptr);
+    } else {
         /* Perform the OR via sequential modifications to the high and
            low parts.  Do this via recursion to handle 16-bit vs 32-bit
            masks in each half.  */
-        tgen64_ori(s, dest, val & 0x00000000ffffffffull);
-        tgen64_ori(s, dest, val & 0xffffffff00000000ull);
-    } else {
-        /* With no extended-immediate facility, we don't need to be so
-           clever.  Just iterate over the insns and mask in the constant.  */
-        for (i = 0; i < 4; i++) {
-            tcg_target_ulong mask = (0xffffull << i*16);
-            if ((val & mask) != 0) {
-                tcg_out_insn_RI(s, oi_insns[i], dest, val >> i*16);
-            }
-        }
+        tcg_debug_assert(s390_facilities & FACILITY_EXT_IMM);
+        tgen_ori(s, type, dest, val & 0x00000000ffffffffull);
+        tgen_ori(s, type, dest, val & 0xffffffff00000000ull);
     }
 }
 
@@ -1872,7 +1878,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
         if (const_args[2]) {
             tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tgen64_ori(s, a0, a2);
+            tgen_ori(s, TCG_TYPE_I32, a0, a2);
         } else if (a0 == a1) {
             tcg_out_insn(s, RR, OR, a0, a2);
         } else {
@@ -2104,7 +2110,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
             tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen64_ori(s, a0, a2);
+            tgen_ori(s, TCG_TYPE_I64, a0, a2);
         } else if (a0 == a1) {
             tcg_out_insn(s, RRE, OGR, a0, a2);
         } else {
@@ -2312,7 +2318,6 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef r_0_ri = { .args_ct_str = { "r", "0", "ri" } };
     static const TCGTargetOpDef r_0_rI = { .args_ct_str = { "r", "0", "rI" } };
     static const TCGTargetOpDef r_0_rJ = { .args_ct_str = { "r", "0", "rJ" } };
-    static const TCGTargetOpDef r_0_rN = { .args_ct_str = { "r", "0", "rN" } };
     static const TCGTargetOpDef r_0_rM = { .args_ct_str = { "r", "0", "rM" } };
     static const TCGTargetOpDef a2_r
         = { .args_ct_str = { "r", "r", "0", "1", "r", "r" } };
@@ -2353,6 +2358,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sub_i64:
     case INDEX_op_and_i32:
     case INDEX_op_and_i64:
+    case INDEX_op_or_i32:
+    case INDEX_op_or_i64:
         return (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_ri : &r_0_ri);
 
     case INDEX_op_mul_i32:
@@ -2363,19 +2370,6 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_mul_i64:
         return (s390_facilities & FACILITY_GEN_INST_EXT ? &r_0_rJ : &r_0_rI);
 
-    case INDEX_op_or_i32:
-        /* The use of [iNM] constraints are optimization only, since a full
-           64-bit immediate OR can always be performed with 4 sequential
-           OI[LH][LH] instructions.  By rejecting certain negative ranges,
-           the immediate load plus the reg-reg OR is smaller.  */
-        return (s390_facilities & FACILITY_EXT_IMM
-                ? (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_ri : &r_0_ri)
-                : &r_0_rN);
-    case INDEX_op_or_i64:
-        return (s390_facilities & FACILITY_EXT_IMM
-                ? (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_rM : &r_0_rM)
-                : &r_0_rN);
-
     case INDEX_op_xor_i32:
         /* Without EXT_IMM, no immediates are supported.  Otherwise,
            rejecting certain negative ranges leads to smaller code.  */
-- 
2.13.5
