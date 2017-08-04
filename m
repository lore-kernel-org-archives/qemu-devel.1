Received: from eggs.gnu.org ([2001:4830:134:3::10]:59685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPd-0003y3-Nt
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPb-0003N8-RT
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:41 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:37852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddVPb-0003LG-JB
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:39 -0400
Received: by mail-pf0-x244.google.com with SMTP id p13so861893pfd.4
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 22:44:39 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	o14sm1061063pfi.158.2017.08.03.22.44.37 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 22:44:37 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 22:44:14 -0700
Message-Id: <20170804054426.10590-12-rth@twiddle.net>
In-Reply-To: <20170804054426.10590-1-rth@twiddle.net>
References: <20170804054426.10590-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 11/23] tcg/s390: Use constant pool for
 cmpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Also use CHI/CGHI for 16-bit signed constants.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/s390/tcg-target.inc.c | 136 +++++++++++++++++++++++-----------------------
 1 file changed, 67 insertions(+), 69 deletions(-)

diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index b0b34fa5ab..e7ab8e4df3 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -39,9 +39,8 @@
 
 #define TCG_CT_CONST_S16   0x100
 #define TCG_CT_CONST_S32   0x200
-#define TCG_CT_CONST_U31   0x400
-#define TCG_CT_CONST_S33   0x800
-#define TCG_CT_CONST_ZERO  0x1000
+#define TCG_CT_CONST_S33   0x400
+#define TCG_CT_CONST_ZERO  0x800
 
 /* Several places within the instruction set 0 means "no register"
    rather than TCG_REG_R0.  */
@@ -75,6 +74,10 @@ typedef enum S390Opcode {
     RIL_CGFI    = 0xc20c,
     RIL_CLFI    = 0xc20f,
     RIL_CLGFI   = 0xc20e,
+    RIL_CLRL    = 0xc60f,
+    RIL_CLGRL   = 0xc60a,
+    RIL_CRL     = 0xc60d,
+    RIL_CGRL    = 0xc608,
     RIL_IIHF    = 0xc008,
     RIL_IILF    = 0xc009,
     RIL_LARL    = 0xc000,
@@ -97,6 +100,8 @@ typedef enum S390Opcode {
     RI_AGHI     = 0xa70b,
     RI_AHI      = 0xa70a,
     RI_BRC      = 0xa704,
+    RI_CHI      = 0xa70e,
+    RI_CGHI     = 0xa70f,
     RI_IIHH     = 0xa500,
     RI_IIHL     = 0xa501,
     RI_IILH     = 0xa502,
@@ -206,6 +211,8 @@ typedef enum S390Opcode {
     RXY_AG      = 0xe308,
     RXY_AY      = 0xe35a,
     RXY_CG      = 0xe320,
+    RXY_CLG     = 0xe321,
+    RXY_CLY     = 0xe355,
     RXY_CY      = 0xe359,
     RXY_LAY     = 0xe371,
     RXY_LB      = 0xe376,
@@ -423,20 +430,6 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     case 'J':
         ct->ct |= TCG_CT_CONST_S32;
         break;
-    case 'C':
-        /* ??? We have no insight here into whether the comparison is
-           signed or unsigned.  The COMPARE IMMEDIATE insn uses a 32-bit
-           signed immediate, and the COMPARE LOGICAL IMMEDIATE insn uses
-           a 32-bit unsigned immediate.  If we were to use the (semi)
-           obvious "val == (int32_t)val" we would be enabling unsigned
-           comparisons vs very large numbers.  The only solution is to
-           take the intersection of the ranges.  */
-        /* ??? Another possible solution is to simply lie and allow all
-           constants here and force the out-of-range values into a temp
-           register in tgen_cmp when we have knowledge of the actual
-           comparison code in use.  */
-        ct->ct |= TCG_CT_CONST_U31;
-        break;
     case 'Z':
         ct->ct |= TCG_CT_CONST_ZERO;
         break;
@@ -467,8 +460,6 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
         return val == (int32_t)val;
     } else if (ct & TCG_CT_CONST_S33) {
         return val >= -0xffffffffll && val <= 0xffffffffll;
-    } else if (ct & TCG_CT_CONST_U31) {
-        return val >= 0 && val <= 0x7fffffff;
     } else if (ct & TCG_CT_CONST_ZERO) {
         return val == 0;
     }
@@ -1092,6 +1083,8 @@ static int tgen_cmp(TCGContext *s, TCGType type, TCGCond c, TCGReg r1,
                     TCGArg c2, bool c2const, bool need_carry)
 {
     bool is_unsigned = is_unsigned_cond(c);
+    S390Opcode op;
+
     if (c2const) {
         if (c2 == 0) {
             if (!(is_unsigned && need_carry)) {
@@ -1102,44 +1095,67 @@ static int tgen_cmp(TCGContext *s, TCGType type, TCGCond c, TCGReg r1,
                 }
                 return tcg_cond_to_ltr_cond[c];
             }
-            /* If we only got here because of load-and-test,
-               and we couldn't use that, then we need to load
-               the constant into a register.  */
-            if (!(s390_facilities & FACILITY_EXT_IMM)) {
-                c2 = TCG_TMP0;
-                tcg_out_movi(s, type, c2, 0);
-                goto do_reg;
-            }
         }
-        if (is_unsigned) {
-            if (type == TCG_TYPE_I32) {
-                tcg_out_insn(s, RIL, CLFI, r1, c2);
-            } else {
-                tcg_out_insn(s, RIL, CLGFI, r1, c2);
-            }
-        } else {
+
+        if (!is_unsigned && c2 == (int16_t)c2) {
+            op = (type == TCG_TYPE_I32 ? RI_CHI : RI_CGHI);
+            tcg_out_insn_RI(s, op, r1, c2);
+            goto exit;
+        }
+
+        if (s390_facilities & FACILITY_EXT_IMM) {
             if (type == TCG_TYPE_I32) {
-                tcg_out_insn(s, RIL, CFI, r1, c2);
-            } else {
-                tcg_out_insn(s, RIL, CGFI, r1, c2);
+                op = (is_unsigned ? RIL_CLFI : RIL_CFI);
+                tcg_out_insn_RIL(s, op, r1, c2);
+                goto exit;
+            } else if (c2 == (is_unsigned ? (uint32_t)c2 : (int32_t)c2)) {
+                op = (is_unsigned ? RIL_CLGFI : RIL_CGFI);
+                tcg_out_insn_RIL(s, op, r1, c2);
+                goto exit;
             }
         }
-    } else {
-    do_reg:
-        if (is_unsigned) {
+
+        /* Use the constant pool, but not for small constants.  */
+        if (maybe_out_small_movi(s, type, TCG_TMP0, c2)) {
+            c2 = TCG_TMP0;
+            /* fall through to reg-reg */
+        } else if (USE_REG_TB) {
             if (type == TCG_TYPE_I32) {
-                tcg_out_insn(s, RR, CLR, r1, c2);
+                op = (is_unsigned ? RXY_CLY : RXY_CY);
+                tcg_out_insn_RXY(s, op, r1, TCG_REG_TB, TCG_REG_NONE, 0);
+                new_pool_label(s, (uint32_t)c2, R_390_20, s->code_ptr - 2,
+                               4 - (intptr_t)s->code_gen_ptr);
             } else {
-                tcg_out_insn(s, RRE, CLGR, r1, c2);
+                op = (is_unsigned ? RXY_CLG : RXY_CG);
+                tcg_out_insn_RXY(s, op, r1, TCG_REG_TB, TCG_REG_NONE, 0);
+                new_pool_label(s, c2, R_390_20, s->code_ptr - 2,
+                               -(intptr_t)s->code_gen_ptr);
             }
+            goto exit;
         } else {
             if (type == TCG_TYPE_I32) {
-                tcg_out_insn(s, RR, CR, r1, c2);
+                op = (is_unsigned ? RIL_CLRL : RIL_CRL);
+                tcg_out_insn_RIL(s, op, r1, 0);
+                new_pool_label(s, (uint32_t)c2, R_390_PC32DBL,
+                               s->code_ptr - 2, 2 + 4);
             } else {
-                tcg_out_insn(s, RRE, CGR, r1, c2);
+                op = (is_unsigned ? RIL_CLGRL : RIL_CGRL);
+                tcg_out_insn_RIL(s, op, r1, 0);
+                new_pool_label(s, c2, R_390_PC32DBL, s->code_ptr - 2, 2);
             }
+            goto exit;
         }
     }
+
+    if (type == TCG_TYPE_I32) {
+        op = (is_unsigned ? RR_CLR : RR_CR);
+        tcg_out_insn_RR(s, op, r1, c2);
+    } else {
+        op = (is_unsigned ? RRE_CLGR : RRE_CGR);
+        tcg_out_insn_RRE(s, op, r1, c2);
+    }
+
+ exit:
     return tcg_cond_to_s390_cond[c];
 }
 
@@ -2325,8 +2341,6 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef r_L = { .args_ct_str = { "r", "L" } };
     static const TCGTargetOpDef L_L = { .args_ct_str = { "L", "L" } };
     static const TCGTargetOpDef r_ri = { .args_ct_str = { "r", "ri" } };
-    static const TCGTargetOpDef r_rC = { .args_ct_str = { "r", "rC" } };
-    static const TCGTargetOpDef r_rZ = { .args_ct_str = { "r", "rZ" } };
     static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
     static const TCGTargetOpDef r_0_ri = { .args_ct_str = { "r", "0", "ri" } };
     static const TCGTargetOpDef r_0_rI = { .args_ct_str = { "r", "0", "rI" } };
@@ -2401,10 +2415,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &r_r_ri;
 
     case INDEX_op_brcond_i32:
-        /* Without EXT_IMM, only the LOAD AND TEST insn is available.  */
-        return (s390_facilities & FACILITY_EXT_IMM ? &r_ri : &r_rZ);
     case INDEX_op_brcond_i64:
-        return (s390_facilities & FACILITY_EXT_IMM ? &r_rC : &r_rZ);
+        return &r_ri;
 
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
@@ -2430,6 +2442,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &r_r;
 
     case INDEX_op_clz_i64:
+    case INDEX_op_setcond_i32:
+    case INDEX_op_setcond_i64:
         return &r_r_ri;
 
     case INDEX_op_qemu_ld_i32:
@@ -2446,30 +2460,14 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
                 = { .args_ct_str = { "r", "rZ", "r" } };
             return &dep;
         }
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-        {
-            /* Without EXT_IMM, only the LOAD AND TEST insn is available.  */
-            static const TCGTargetOpDef setc_z
-                = { .args_ct_str = { "r", "r", "rZ" } };
-            static const TCGTargetOpDef setc_c
-                = { .args_ct_str = { "r", "r", "rC" } };
-            return (s390_facilities & FACILITY_EXT_IMM ? &setc_c : &setc_z);
-        }
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         {
-            /* Without EXT_IMM, only the LOAD AND TEST insn is available.  */
-            static const TCGTargetOpDef movc_z
-                = { .args_ct_str = { "r", "r", "rZ", "r", "0" } };
-            static const TCGTargetOpDef movc_c
-                = { .args_ct_str = { "r", "r", "rC", "r", "0" } };
+            static const TCGTargetOpDef movc
+                = { .args_ct_str = { "r", "r", "ri", "r", "0" } };
             static const TCGTargetOpDef movc_l
-                = { .args_ct_str = { "r", "r", "rC", "rI", "0" } };
-            return (s390_facilities & FACILITY_EXT_IMM
-                    ? (s390_facilities & FACILITY_LOAD_ON_COND2
-                       ? &movc_l : &movc_c)
-                    : &movc_z);
+                = { .args_ct_str = { "r", "r", "ri", "rI", "0" } };
+            return (s390_facilities & FACILITY_LOAD_ON_COND2 ? &movc_l : &movc);
         }
     case INDEX_op_div2_i32:
     case INDEX_op_div2_i64:
-- 
2.13.3
