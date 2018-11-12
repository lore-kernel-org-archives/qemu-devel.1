Received: from eggs.gnu.org ([2001:4830:134:3::10]:54341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK3c-000516-1X
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK3Q-000589-9M
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:36 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMK3K-00053J-NB
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:28 -0500
Received: by mail-wr1-x441.google.com with SMTP id u5-v6so5738312wrn.9
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:47:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 12 Nov 2018 22:45:02 +0100
Message-Id: <20181112214503.22941-17-richard.henderson@linaro.org>
In-Reply-To: <20181112214503.22941-1-richard.henderson@linaro.org>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 16/17] tcg/arm: Force qemu_ld/st
 arguments into fixed registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

This is an incremental step toward moving the qemu_ld/st
code sequence out of line.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.inc.c | 116 +++++++++++++++++++++++++--------------
 1 file changed, 75 insertions(+), 41 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 2deeb1f5d1..75589b43e2 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -270,38 +270,15 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         ct->u.regs = 0xffff;
         break;
 
-    /* qemu_ld address */
-    case 'l':
-        ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffff;
-#ifdef CONFIG_SOFTMMU
-        /* r0-r2,lr will be overwritten when reading the tlb entry,
-           so don't use these. */
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R0);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R1);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R2);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R14);
-#endif
-        break;
-
+#ifndef CONFIG_SOFTMMU
     /* qemu_st address & data */
     case 's':
         ct->ct |= TCG_CT_REG;
         ct->u.regs = 0xffff;
-        /* r0-r2 will be overwritten when reading the tlb entry (softmmu only)
-           and r0-r1 doing the byte swapping, so don't use these. */
+        /* r0 and tmp are needed for byte swapping.  */
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_R0);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R1);
-#if defined(CONFIG_SOFTMMU)
-        /* Avoid clashes with registers being used for helper args */
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R2);
-#if TARGET_LONG_BITS == 64
-        /* Avoid clashes with registers being used for helper args */
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R3);
-#endif
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R14);
-#endif
         break;
+#endif
 
     default:
         return NULL;
@@ -1630,8 +1607,8 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
     TCGMemOpIdx oi;
     TCGMemOp opc;
 #ifdef CONFIG_SOFTMMU
-    int mem_index;
-    TCGReg addend;
+    int mem_index, avail;
+    TCGReg addend, t0, t1;
     tcg_insn_unit *label_ptr;
 #endif
 
@@ -1644,8 +1621,20 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
 
 #ifdef CONFIG_SOFTMMU
     mem_index = get_mmuidx(oi);
+
+    avail = 0xf;
+    avail &= ~(1 << addrlo);
+    if (TARGET_LONG_BITS == 64) {
+        avail &= ~(1 << addrhi);
+    }
+    tcg_debug_assert(avail & 1);
+    t0 = TCG_REG_R0;
+    avail &= ~1;
+    tcg_debug_assert(avail != 0);
+    t1 = ctz32(avail);
+
     addend = tcg_out_tlb_read(s, addrlo, addrhi, opc, mem_index, 1,
-                              TCG_REG_R0, TCG_REG_R1, TCG_REG_TMP);
+                              t0, t1, TCG_REG_TMP);
 
     /* This a conditional BL only to load a pointer within this opcode into LR
        for the slow path.  We will not be using the value for a tail call.  */
@@ -1762,8 +1751,8 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
     TCGMemOpIdx oi;
     TCGMemOp opc;
 #ifdef CONFIG_SOFTMMU
-    int mem_index;
-    TCGReg addend;
+    int mem_index, avail;
+    TCGReg addend, t0, t1;
     tcg_insn_unit *label_ptr;
 #endif
 
@@ -1776,8 +1765,24 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
 
 #ifdef CONFIG_SOFTMMU
     mem_index = get_mmuidx(oi);
+
+    avail = 0xf;
+    avail &= ~(1 << addrlo);
+    avail &= ~(1 << datalo);
+    if (TARGET_LONG_BITS == 64) {
+        avail &= ~(1 << addrhi);
+    }
+    if (is64) {
+        avail &= ~(1 << datahi);
+    }
+    tcg_debug_assert(avail & 1);
+    t0 = TCG_REG_R0;
+    avail &= ~1;
+    tcg_debug_assert(avail != 0);
+    t1 = ctz32(avail);
+
     addend = tcg_out_tlb_read(s, addrlo, addrhi, opc, mem_index, 0,
-                              TCG_REG_R0, TCG_REG_R1, TCG_REG_TMP);
+                              t0, t1, TCG_REG_TMP);
 
     tcg_out_qemu_st_index(s, COND_EQ, opc, datalo, datahi, addrlo, addend);
 
@@ -2118,11 +2123,14 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
     static const TCGTargetOpDef r_r = { .args_ct_str = { "r", "r" } };
     static const TCGTargetOpDef s_s = { .args_ct_str = { "s", "s" } };
-    static const TCGTargetOpDef r_l = { .args_ct_str = { "r", "l" } };
+    static const TCGTargetOpDef a_b = { .args_ct_str = { "a", "b" } };
+    static const TCGTargetOpDef c_b = { .args_ct_str = { "c", "b" } };
     static const TCGTargetOpDef r_r_r = { .args_ct_str = { "r", "r", "r" } };
-    static const TCGTargetOpDef r_r_l = { .args_ct_str = { "r", "r", "l" } };
-    static const TCGTargetOpDef r_l_l = { .args_ct_str = { "r", "l", "l" } };
     static const TCGTargetOpDef s_s_s = { .args_ct_str = { "s", "s", "s" } };
+    static const TCGTargetOpDef a_c_d = { .args_ct_str = { "a", "c", "d" } };
+    static const TCGTargetOpDef a_b_b = { .args_ct_str = { "a", "b", "b" } };
+    static const TCGTargetOpDef e_c_d = { .args_ct_str = { "e", "c", "d" } };
+    static const TCGTargetOpDef e_f_b = { .args_ct_str = { "e", "f", "b" } };
     static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
     static const TCGTargetOpDef r_r_rI = { .args_ct_str = { "r", "r", "rI" } };
     static const TCGTargetOpDef r_r_rIN
@@ -2131,10 +2139,12 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "r", "r", "rIK" } };
     static const TCGTargetOpDef r_r_r_r
         = { .args_ct_str = { "r", "r", "r", "r" } };
-    static const TCGTargetOpDef r_r_l_l
-        = { .args_ct_str = { "r", "r", "l", "l" } };
     static const TCGTargetOpDef s_s_s_s
         = { .args_ct_str = { "s", "s", "s", "s" } };
+    static const TCGTargetOpDef a_b_c_d
+        = { .args_ct_str = { "a", "b", "c", "d" } };
+    static const TCGTargetOpDef e_f_c_d
+        = { .args_ct_str = { "e", "f", "c", "d" } };
     static const TCGTargetOpDef br
         = { .args_ct_str = { "r", "rIN" } };
     static const TCGTargetOpDef dep
@@ -2215,13 +2225,37 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &setc2;
 
     case INDEX_op_qemu_ld_i32:
-        return TARGET_LONG_BITS == 32 ? &r_l : &r_l_l;
+        if (!USING_SOFTMMU) {
+            return TARGET_LONG_BITS == 32 ? &r_r : &r_r_r;
+        } else if (TARGET_LONG_BITS == 32) {
+            return &a_b;     /* temps available r0, r2, r3, r12 */
+        } else {
+            return &a_c_d;   /* temps available r0, r1, r12 */
+        }
     case INDEX_op_qemu_ld_i64:
-        return TARGET_LONG_BITS == 32 ? &r_r_l : &r_r_l_l;
+        if (!USING_SOFTMMU) {
+            return TARGET_LONG_BITS == 32 ? &r_r_r : &r_r_r_r;
+        } else if (TARGET_LONG_BITS == 32) {
+            return &a_b_b;   /* temps available r0, r2, r3, r12 */
+        } else {
+            return &a_b_c_d; /* temps available r0, r1, r12 */
+        }
     case INDEX_op_qemu_st_i32:
-        return TARGET_LONG_BITS == 32 ? &s_s : &s_s_s;
+        if (!USING_SOFTMMU) {
+            return TARGET_LONG_BITS == 32 ? &s_s : &s_s_s;
+        } else if (TARGET_LONG_BITS == 32) {
+            return &c_b;     /* temps available r0, r3, r12 */
+        } else {
+            return &e_c_d;   /* temps available r0, r1, r12 */
+        }
     case INDEX_op_qemu_st_i64:
-        return TARGET_LONG_BITS == 32 ? &s_s_s : &s_s_s_s;
+        if (!USING_SOFTMMU) {
+            return TARGET_LONG_BITS == 32 ? &s_s_s : &s_s_s_s;
+        } else if (TARGET_LONG_BITS == 32) {
+            return &e_f_b;   /* temps available r0, r2, r3, r12 */
+        } else {
+            return &e_f_c_d; /* temps available r0, r1, r12 */
+        }
 
     default:
         return NULL;
-- 
2.17.2
