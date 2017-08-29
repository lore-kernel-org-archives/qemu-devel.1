Received: from eggs.gnu.org ([2001:4830:134:3::10]:49529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmnQk-0002V3-Qm
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmnQj-0001Vn-5L
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:48:14 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:36623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmnQi-0001Vd-Sy
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:48:13 -0400
Received: by mail-pg0-x22c.google.com with SMTP id r133so13991517pgr.3
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 13:48:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 29 Aug 2017 13:47:57 -0700
Message-Id: <20170829204759.6853-7-richard.henderson@linaro.org>
In-Reply-To: <20170829204759.6853-1-richard.henderson@linaro.org>
References: <20170829204759.6853-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 6/8] tcg/s390: Use distinct-operands facility
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

This allows using a 3-operand insn form for some arithmetic,
logicals and shifts.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/s390/tcg-target.h     |   1 +
 tcg/s390/tcg-target.inc.c | 118 +++++++++++++++++++++++++++++++++++-----------
 2 files changed, 91 insertions(+), 28 deletions(-)

diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 957f0c0afe..1b5eb22c26 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -58,6 +58,7 @@ typedef enum TCGReg {
 #define FACILITY_GEN_INST_EXT         (1ULL << (63 - 34))
 #define FACILITY_LOAD_ON_COND         (1ULL << (63 - 45))
 #define FACILITY_FAST_BCR_SER         FACILITY_LOAD_ON_COND
+#define FACILITY_DISTINCT_OPS         FACILITY_LOAD_ON_COND
 
 extern uint64_t s390_facilities;
 
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 5414c9d879..a80b07db65 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -159,6 +159,16 @@ typedef enum S390Opcode {
 
     RRF_LOCR    = 0xb9f2,
     RRF_LOCGR   = 0xb9e2,
+    RRF_NRK     = 0xb9f4,
+    RRF_NGRK    = 0xb9e4,
+    RRF_ORK     = 0xb9f6,
+    RRF_OGRK    = 0xb9e6,
+    RRF_SRK     = 0xb9f9,
+    RRF_SGRK    = 0xb9e9,
+    RRF_SLRK    = 0xb9fb,
+    RRF_SLGRK   = 0xb9eb,
+    RRF_XRK     = 0xb9f7,
+    RRF_XGRK    = 0xb9e7,
 
     RR_AR       = 0x1a,
     RR_ALR      = 0x1e,
@@ -179,8 +189,11 @@ typedef enum S390Opcode {
     RSY_RLL     = 0xeb1d,
     RSY_RLLG    = 0xeb1c,
     RSY_SLLG    = 0xeb0d,
+    RSY_SLLK    = 0xebdf,
     RSY_SRAG    = 0xeb0a,
+    RSY_SRAK    = 0xebdc,
     RSY_SRLG    = 0xeb0c,
+    RSY_SRLK    = 0xebde,
 
     RS_SLL      = 0x89,
     RS_SRA      = 0x8a,
@@ -1065,23 +1078,29 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
     case TCG_COND_GEU:
     do_geu:
         /* We need "real" carry semantics, so use SUBTRACT LOGICAL
-           instead of COMPARE LOGICAL.  This needs an extra move.  */
-        tcg_out_mov(s, type, TCG_TMP0, c1);
+           instead of COMPARE LOGICAL.  This may need an extra move.  */
         if (c2const) {
-            tcg_out_movi(s, TCG_TYPE_I64, dest, 0);
+            tcg_out_mov(s, type, TCG_TMP0, c1);
             if (type == TCG_TYPE_I32) {
                 tcg_out_insn(s, RIL, SLFI, TCG_TMP0, c2);
             } else {
                 tcg_out_insn(s, RIL, SLGFI, TCG_TMP0, c2);
             }
+        } else if (s390_facilities & FACILITY_DISTINCT_OPS) {
+            if (type == TCG_TYPE_I32) {
+                tcg_out_insn(s, RRF, SLRK, TCG_TMP0, c1, c2);
+            } else {
+                tcg_out_insn(s, RRF, SLGRK, TCG_TMP0, c1, c2);
+            }
         } else {
+            tcg_out_mov(s, type, TCG_TMP0, c1);
             if (type == TCG_TYPE_I32) {
                 tcg_out_insn(s, RR, SLR, TCG_TMP0, c2);
             } else {
                 tcg_out_insn(s, RRE, SLGR, TCG_TMP0, c2);
             }
-            tcg_out_movi(s, TCG_TYPE_I64, dest, 0);
         }
+        tcg_out_movi(s, TCG_TYPE_I64, dest, 0);
         tcg_out_insn(s, RRE, ALCGR, dest, dest);
         return;
 
@@ -1648,7 +1667,7 @@ static void tcg_out_qemu_st(TCGContext* s, TCGReg data_reg, TCGReg addr_reg,
 static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
                 const TCGArg *args, const int *const_args)
 {
-    S390Opcode op;
+    S390Opcode op, op2;
     TCGArg a0, a1, a2;
 
     switch (opc) {
@@ -1753,29 +1772,44 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         if (const_args[2]) {
             a2 = -a2;
             goto do_addi_32;
+        } else if (a0 == a1) {
+            tcg_out_insn(s, RR, SR, a0, a2);
+        } else {
+            tcg_out_insn(s, RRF, SRK, a0, a1, a2);
         }
-        tcg_out_insn(s, RR, SR, args[0], args[2]);
         break;
 
     case INDEX_op_and_i32:
+        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
         if (const_args[2]) {
-            tgen_andi(s, TCG_TYPE_I32, args[0], args[2]);
+            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
+            tgen_andi(s, TCG_TYPE_I32, a0, a2);
+        } else if (a0 == a1) {
+            tcg_out_insn(s, RR, NR, a0, a2);
         } else {
-            tcg_out_insn(s, RR, NR, args[0], args[2]);
+            tcg_out_insn(s, RRF, NRK, a0, a1, a2);
         }
         break;
     case INDEX_op_or_i32:
+        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
         if (const_args[2]) {
-            tgen64_ori(s, args[0], args[2] & 0xffffffff);
+            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
+            tgen64_ori(s, a0, a2);
+        } else if (a0 == a1) {
+            tcg_out_insn(s, RR, OR, a0, a2);
         } else {
-            tcg_out_insn(s, RR, OR, args[0], args[2]);
+            tcg_out_insn(s, RRF, ORK, a0, a1, a2);
         }
         break;
     case INDEX_op_xor_i32:
+        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
         if (const_args[2]) {
-            tgen64_xori(s, args[0], args[2] & 0xffffffff);
-        } else {
+            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
+            tgen64_xori(s, a0, a2);
+        } else if (a0 == a1) {
             tcg_out_insn(s, RR, XR, args[0], args[2]);
+        } else {
+            tcg_out_insn(s, RRF, XRK, a0, a1, a2);
         }
         break;
 
@@ -1804,18 +1838,31 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_shl_i32:
         op = RS_SLL;
+        op2 = RSY_SLLK;
     do_shift32:
-        if (const_args[2]) {
-            tcg_out_sh32(s, op, args[0], TCG_REG_NONE, args[2]);
+        a0 = args[0], a1 = args[1], a2 = (int32_t)args[2];
+        if (a0 == a1) {
+            if (const_args[2]) {
+                tcg_out_sh32(s, op, a0, TCG_REG_NONE, a2);
+            } else {
+                tcg_out_sh32(s, op, a0, a2, 0);
+            }
         } else {
-            tcg_out_sh32(s, op, args[0], args[2], 0);
+            /* Using tcg_out_sh64 here for the format; it is a 32-bit shift.  */
+            if (const_args[2]) {
+                tcg_out_sh64(s, op2, a0, a1, TCG_REG_NONE, a2);
+            } else {
+                tcg_out_sh64(s, op2, a0, a1, a2, 0);
+            }
         }
         break;
     case INDEX_op_shr_i32:
         op = RS_SRL;
+        op2 = RSY_SRLK;
         goto do_shift32;
     case INDEX_op_sar_i32:
         op = RS_SRA;
+        op2 = RSY_SRAK;
         goto do_shift32;
 
     case INDEX_op_rotl_i32:
@@ -1957,30 +2004,44 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         if (const_args[2]) {
             a2 = -a2;
             goto do_addi_64;
+        } else if (a0 == a1) {
+            tcg_out_insn(s, RRE, SGR, a0, a2);
         } else {
-            tcg_out_insn(s, RRE, SGR, args[0], args[2]);
+            tcg_out_insn(s, RRF, SGRK, a0, a1, a2);
         }
         break;
 
     case INDEX_op_and_i64:
+        a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
+            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
             tgen_andi(s, TCG_TYPE_I64, args[0], args[2]);
-        } else {
+        } else if (a0 == a1) {
             tcg_out_insn(s, RRE, NGR, args[0], args[2]);
+        } else {
+            tcg_out_insn(s, RRF, NGRK, a0, a1, a2);
         }
         break;
     case INDEX_op_or_i64:
+        a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
-            tgen64_ori(s, args[0], args[2]);
+            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
+            tgen64_ori(s, a0, a2);
+        } else if (a0 == a1) {
+            tcg_out_insn(s, RRE, OGR, a0, a2);
         } else {
-            tcg_out_insn(s, RRE, OGR, args[0], args[2]);
+            tcg_out_insn(s, RRF, OGRK, a0, a1, a2);
         }
         break;
     case INDEX_op_xor_i64:
+        a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
-            tgen64_xori(s, args[0], args[2]);
+            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
+            tgen64_xori(s, a0, a2);
+        } else if (a0 == a1) {
+            tcg_out_insn(s, RRE, XGR, a0, a2);
         } else {
-            tcg_out_insn(s, RRE, XGR, args[0], args[2]);
+            tcg_out_insn(s, RRF, XGRK, a0, a1, a2);
         }
         break;
 
@@ -2168,6 +2229,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef r_rC = { .args_ct_str = { "r", "rC" } };
     static const TCGTargetOpDef r_rZ = { .args_ct_str = { "r", "rZ" } };
     static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
+    static const TCGTargetOpDef r_r_rM = { .args_ct_str = { "r", "r", "rM" } };
     static const TCGTargetOpDef r_0_r = { .args_ct_str = { "r", "0", "r" } };
     static const TCGTargetOpDef r_0_ri = { .args_ct_str = { "r", "0", "ri" } };
     static const TCGTargetOpDef r_0_rI = { .args_ct_str = { "r", "0", "rI" } };
@@ -2211,7 +2273,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &r_r_ri;
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-        return &r_0_ri;
+        return (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_ri : &r_0_ri);
 
     case INDEX_op_mul_i32:
         /* If we have the general-instruction-extensions, then we have
@@ -2227,32 +2289,32 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
            OI[LH][LH] instructions.  By rejecting certain negative ranges,
            the immediate load plus the reg-reg OR is smaller.  */
         return (s390_facilities & FACILITY_EXT_IMM
-                ? &r_0_ri
+                ? (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_ri : &r_0_ri)
                 : &r_0_rN);
     case INDEX_op_or_i64:
         return (s390_facilities & FACILITY_EXT_IMM
-                ? &r_0_rM
+                ? (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_rM : &r_0_rM)
                 : &r_0_rN);
 
     case INDEX_op_xor_i32:
         /* Without EXT_IMM, no immediates are supported.  Otherwise,
            rejecting certain negative ranges leads to smaller code.  */
         return (s390_facilities & FACILITY_EXT_IMM
-                ? &r_0_ri
+                ? (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_ri : &r_0_ri)
                 : &r_0_r);
     case INDEX_op_xor_i64:
         return (s390_facilities & FACILITY_EXT_IMM
-                ? &r_0_rM
+                ? (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_rM : &r_0_rM)
                 : &r_0_r);
 
     case INDEX_op_and_i32:
     case INDEX_op_and_i64:
-        return &r_0_ri;
+        return (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_ri : &r_0_ri);
 
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
-        return &r_0_ri;
+        return (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_ri : &r_0_ri);
 
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
-- 
2.13.5
