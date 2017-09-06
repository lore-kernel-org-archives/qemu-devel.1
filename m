Received: from eggs.gnu.org ([2001:4830:134:3::10]:40066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpbeV-0005bC-Kv
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpbeT-0000RZ-0C
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:50:03 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:32783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpbeS-0000RP-OU
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:50:00 -0400
Received: by mail-pg0-x235.google.com with SMTP id t3so15708897pgt.0
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 07:50:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 07:49:39 -0700
Message-Id: <20170906144940.30880-14-richard.henderson@linaro.org>
In-Reply-To: <20170906144940.30880-1-richard.henderson@linaro.org>
References: <20170906144940.30880-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 13/14] tcg/s390: Use load-on-condition-2 facility
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

This allows LOAD HALFWORD IMMEDIATE ON CONDITION,
eliminating one insn in some common cases.

Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/s390/tcg-target.h     |  1 +
 tcg/s390/tcg-target.inc.c | 79 +++++++++++++++++++++++++++++++++++++----------
 2 files changed, 63 insertions(+), 17 deletions(-)

diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index f7619a9ef1..bedda5edf6 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -59,6 +59,7 @@ typedef enum TCGReg {
 #define FACILITY_LOAD_ON_COND         (1ULL << (63 - 45))
 #define FACILITY_FAST_BCR_SER         FACILITY_LOAD_ON_COND
 #define FACILITY_DISTINCT_OPS         FACILITY_LOAD_ON_COND
+#define FACILITY_LOAD_ON_COND2        (1ULL << (63 - 53))
 
 extern uint64_t s390_facilities;
 
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index a80b07db65..0de968fde2 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -122,6 +122,7 @@ typedef enum S390Opcode {
     RIE_CLGIJ   = 0xec7d,
     RIE_CLRJ    = 0xec77,
     RIE_CRJ     = 0xec76,
+    RIE_LOCGHI  = 0xec46,
     RIE_RISBG   = 0xec55,
 
     RRE_AGR     = 0xb908,
@@ -495,6 +496,13 @@ static void tcg_out_insn_RI(TCGContext *s, S390Opcode op, TCGReg r1, int i2)
     tcg_out32(s, (op << 16) | (r1 << 20) | (i2 & 0xffff));
 }
 
+static void tcg_out_insn_RIE(TCGContext *s, S390Opcode op, TCGReg r1,
+                             int i2, int m3)
+{
+    tcg_out16(s, (op & 0xff00) | (r1 << 4) | m3);
+    tcg_out32(s, (i2 << 16) | (op & 0xff));
+}
+
 static void tcg_out_insn_RIL(TCGContext *s, S390Opcode op, TCGReg r1, int i2)
 {
     tcg_out16(s, op | (r1 << 4));
@@ -1063,7 +1071,20 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
                          TCGReg dest, TCGReg c1, TCGArg c2, int c2const)
 {
     int cc;
+    bool have_loc;
 
+    /* With LOC2, we can always emit the minimum 3 insns.  */
+    if (s390_facilities & FACILITY_LOAD_ON_COND2) {
+        /* Emit: d = 0, d = (cc ? 1 : d).  */
+        cc = tgen_cmp(s, type, cond, c1, c2, c2const, false);
+        tcg_out_movi(s, TCG_TYPE_I64, dest, 0);
+        tcg_out_insn(s, RIE, LOCGHI, dest, 1, cc);
+        return;
+    }
+
+    have_loc = (s390_facilities & FACILITY_LOAD_ON_COND) != 0;
+
+    /* For HAVE_LOC, only the path through do_greater is smaller.  */
     switch (cond) {
     case TCG_COND_GTU:
     case TCG_COND_GT:
@@ -1076,6 +1097,9 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
         return;
 
     case TCG_COND_GEU:
+        if (have_loc) {
+            goto do_loc;
+        }
     do_geu:
         /* We need "real" carry semantics, so use SUBTRACT LOGICAL
            instead of COMPARE LOGICAL.  This may need an extra move.  */
@@ -1105,10 +1129,17 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
         return;
 
     case TCG_COND_LEU:
+        if (have_loc) {
+            goto do_loc;
+        }
+        /* fallthru */
     case TCG_COND_LTU:
     case TCG_COND_LT:
         /* Swap operands so that we can use GEU/GTU/GT.  */
         if (c2const) {
+            if (have_loc) {
+                goto do_loc;
+            }
             tcg_out_movi(s, type, TCG_TMP0, c2);
             c2 = c1;
             c2const = 0;
@@ -1133,6 +1164,9 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
         break;
 
     case TCG_COND_EQ:
+        if (have_loc) {
+            goto do_loc;
+        }
         /* X == 0 is X <= 0 is 0 >= X.  */
         if (c2const && c2 == 0) {
             tcg_out_movi(s, TCG_TYPE_I64, TCG_TMP0, 0);
@@ -1148,33 +1182,39 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
     }
 
     cc = tgen_cmp(s, type, cond, c1, c2, c2const, false);
-    if (s390_facilities & FACILITY_LOAD_ON_COND) {
-        /* Emit: d = 0, t = 1, d = (cc ? t : d).  */
-        tcg_out_movi(s, TCG_TYPE_I64, dest, 0);
-        tcg_out_movi(s, TCG_TYPE_I64, TCG_TMP0, 1);
-        tcg_out_insn(s, RRF, LOCGR, dest, TCG_TMP0, cc);
-    } else {
-        /* Emit: d = 1; if (cc) goto over; d = 0; over:  */
-        tcg_out_movi(s, type, dest, 1);
-        tcg_out_insn(s, RI, BRC, cc, (4 + 4) >> 1);
-        tcg_out_movi(s, type, dest, 0);
-    }
+    /* Emit: d = 1; if (cc) goto over; d = 0; over:  */
+    tcg_out_movi(s, type, dest, 1);
+    tcg_out_insn(s, RI, BRC, cc, (4 + 4) >> 1);
+    tcg_out_movi(s, type, dest, 0);
+    return;
+
+ do_loc:
+    cc = tgen_cmp(s, type, cond, c1, c2, c2const, false);
+    /* Emit: d = 0, t = 1, d = (cc ? t : d).  */
+    tcg_out_movi(s, TCG_TYPE_I64, dest, 0);
+    tcg_out_movi(s, TCG_TYPE_I64, TCG_TMP0, 1);
+    tcg_out_insn(s, RRF, LOCGR, dest, TCG_TMP0, cc);
 }
 
 static void tgen_movcond(TCGContext *s, TCGType type, TCGCond c, TCGReg dest,
-                         TCGReg c1, TCGArg c2, int c2const, TCGReg r3)
+                         TCGReg c1, TCGArg c2, int c2const,
+                         TCGArg v3, int v3const)
 {
     int cc;
     if (s390_facilities & FACILITY_LOAD_ON_COND) {
         cc = tgen_cmp(s, type, c, c1, c2, c2const, false);
-        tcg_out_insn(s, RRF, LOCGR, dest, r3, cc);
+        if (v3const) {
+            tcg_out_insn(s, RIE, LOCGHI, dest, v3, cc);
+        } else {
+            tcg_out_insn(s, RRF, LOCGR, dest, v3, cc);
+        }
     } else {
         c = tcg_invert_cond(c);
         cc = tgen_cmp(s, type, c, c1, c2, c2const, false);
 
         /* Emit: if (cc) goto over; dest = r3; over:  */
         tcg_out_insn(s, RI, BRC, cc, (4 + 4) >> 1);
-        tcg_out_insn(s, RRE, LGR, dest, r3);
+        tcg_out_insn(s, RRE, LGR, dest, v3);
     }
 }
 
@@ -1937,7 +1977,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_movcond_i32:
         tgen_movcond(s, TCG_TYPE_I32, args[5], args[0], args[1],
-                     args[2], const_args[2], args[3]);
+                     args[2], const_args[2], args[3], const_args[3]);
         break;
 
     case INDEX_op_qemu_ld_i32:
@@ -2170,7 +2210,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_movcond_i64:
         tgen_movcond(s, TCG_TYPE_I64, args[5], args[0], args[1],
-                     args[2], const_args[2], args[3]);
+                     args[2], const_args[2], args[3], const_args[3]);
         break;
 
     OP_32_64(deposit):
@@ -2391,7 +2431,12 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
                 = { .args_ct_str = { "r", "r", "rZ", "r", "0" } };
             static const TCGTargetOpDef movc_c
                 = { .args_ct_str = { "r", "r", "rC", "r", "0" } };
-            return (s390_facilities & FACILITY_EXT_IMM ? &movc_c : &movc_z);
+            static const TCGTargetOpDef movc_l
+                = { .args_ct_str = { "r", "r", "rC", "rI", "0" } };
+            return (s390_facilities & FACILITY_EXT_IMM
+                    ? (s390_facilities & FACILITY_LOAD_ON_COND2
+                       ? &movc_l : &movc_c)
+                    : &movc_z);
         }
     case INDEX_op_div2_i32:
     case INDEX_op_div2_i64:
-- 
2.13.5
