Received: from eggs.gnu.org ([2001:4830:134:3::10]:44133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj1-0000E9-LE
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCiy-0003af-13
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:30 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCix-0003Un-Qx
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:27 -0500
Received: by mail-wm1-x343.google.com with SMTP id r63-v6so12199042wma.4
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:45 +0100
Message-Id: <20181123144558.5048-25-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 24/37] tcg/ppc: Force qemu_ld/st
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
Cc: Alistair.Francis@wdc.com

This is an incremental step toward moving the qemu_ld/st
code sequence out of line.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 151 ++++++++++++++++++++++++++++-----------
 1 file changed, 111 insertions(+), 40 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index f7c33f3b7f..c706b2cf53 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -248,25 +248,6 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         ct->ct |= TCG_CT_REG;
         ct->u.regs = 0xffffffff;
         break;
-    case 'L':                   /* qemu_ld constraint */
-        ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffffffff;
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R3);
-#ifdef CONFIG_SOFTMMU
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R4);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R5);
-#endif
-        break;
-    case 'S':                   /* qemu_st constraint */
-        ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffffffff;
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R3);
-#ifdef CONFIG_SOFTMMU
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R4);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R5);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R6);
-#endif
-        break;
     case 'I':
         ct->ct |= TCG_CT_CONST_S16;
         break;
@@ -1759,6 +1740,21 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 
     tcg_out_b(s, 0, lb->raddr);
 }
+
+static TCGReg softmmu_args_2(TCGReg reg, TCGReg *lo, TCGReg *hi)
+{
+#ifdef HOST_WORDS_BIGENDIAN
+    static bool is_be = true;
+#else
+    static bool is_be = false;
+#endif
+
+    assert(TCG_TARGET_REG_BITS == 32);
+    reg |= TCG_TARGET_CALL_ALIGN_ARGS;
+    *(is_be ? hi : lo) = reg;
+    *(is_be ? lo : hi) = reg + 1;
+    return reg + 2;
+}
 #endif /* SOFTMMU */
 
 static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is_64)
@@ -1782,9 +1778,9 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is_64)
 
 #ifdef CONFIG_SOFTMMU
     mem_index = get_mmuidx(oi);
-    rbase = TCG_REG_R3;
+    rbase = TCG_REG_R9;
     addrlo = tcg_out_tlb_read(s, opc, addrlo, addrhi, mem_index, true,
-                              rbase, TCG_REG_R4);
+                              rbase, TCG_REG_R10);
 
     /* Load a pointer into the current opcode w/conditional branch-link. */
     label_ptr = s->code_ptr;
@@ -1858,9 +1854,9 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
 
 #ifdef CONFIG_SOFTMMU
     mem_index = get_mmuidx(oi);
-    rbase = TCG_REG_R3;
+    rbase = TCG_REG_R9;
     addrlo = tcg_out_tlb_read(s, opc, addrlo, addrhi, mem_index, false,
-                              rbase, TCG_REG_R4);
+                              rbase, TCG_REG_R10);
 
     /* Load a pointer into the current opcode w/conditional branch-link. */
     label_ptr = s->code_ptr;
@@ -2627,13 +2623,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
     static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
     static const TCGTargetOpDef r_r = { .args_ct_str = { "r", "r" } };
-    static const TCGTargetOpDef r_L = { .args_ct_str = { "r", "L" } };
-    static const TCGTargetOpDef S_S = { .args_ct_str = { "S", "S" } };
     static const TCGTargetOpDef r_ri = { .args_ct_str = { "r", "ri" } };
     static const TCGTargetOpDef r_r_r = { .args_ct_str = { "r", "r", "r" } };
-    static const TCGTargetOpDef r_L_L = { .args_ct_str = { "r", "L", "L" } };
-    static const TCGTargetOpDef L_L_L = { .args_ct_str = { "L", "L", "L" } };
-    static const TCGTargetOpDef S_S_S = { .args_ct_str = { "S", "S", "S" } };
     static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
     static const TCGTargetOpDef r_r_rI = { .args_ct_str = { "r", "r", "rI" } };
     static const TCGTargetOpDef r_r_rT = { .args_ct_str = { "r", "r", "rT" } };
@@ -2644,10 +2635,6 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "r", "rI", "rT" } };
     static const TCGTargetOpDef r_r_rZW
         = { .args_ct_str = { "r", "r", "rZW" } };
-    static const TCGTargetOpDef L_L_L_L
-        = { .args_ct_str = { "L", "L", "L", "L" } };
-    static const TCGTargetOpDef S_S_S_S
-        = { .args_ct_str = { "S", "S", "S", "S" } };
     static const TCGTargetOpDef movc
         = { .args_ct_str = { "r", "r", "ri", "rZ", "rZ" } };
     static const TCGTargetOpDef dep
@@ -2660,6 +2647,15 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "r", "r", "r", "r", "rI", "rZM" } };
     static const TCGTargetOpDef sub2
         = { .args_ct_str = { "r", "r", "rI", "rZM", "r", "r" } };
+#ifdef CONFIG_SOFTMMU
+    static const char * const arg_letter[] = {
+        NULL, NULL, NULL, "A", "B", "C", "D", "E", "F", NULL, NULL
+    };
+    TCGReg hi, lo, arg;
+#else
+    static const TCGTargetOpDef r_r_r_r
+        = { .args_ct_str = { "r", "r", "r", "r" } };
+#endif
 
     switch (op) {
     case INDEX_op_goto_ptr:
@@ -2782,18 +2778,93 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sub2_i32:
         return &sub2;
 
+#ifdef CONFIG_SOFTMMU
     case INDEX_op_qemu_ld_i32:
-        return (TCG_TARGET_REG_BITS == 64 || TARGET_LONG_BITS == 32
-                ? &r_L : &r_L_L);
+        {
+            static TCGTargetOpDef ld32;
+            ld32.args_ct_str[0] = arg_letter[tcg_target_call_oarg_regs[0]];
+            if (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS) {
+                ld32.args_ct_str[1] = arg_letter[tcg_target_call_iarg_regs[1]];
+            } else {
+                arg = tcg_target_call_iarg_regs[1];
+                arg = softmmu_args_2(arg, &lo, &hi);
+                ld32.args_ct_str[1] = arg_letter[lo];
+                ld32.args_ct_str[2] = arg_letter[hi];
+            }
+            return &ld32;
+        }
     case INDEX_op_qemu_st_i32:
-        return (TCG_TARGET_REG_BITS == 64 || TARGET_LONG_BITS == 32
-                ? &S_S : &S_S_S);
+        {
+            static TCGTargetOpDef st32;
+            arg = tcg_target_call_iarg_regs[1];
+            if (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS) {
+                st32.args_ct_str[0] = arg_letter[arg + 1];
+                st32.args_ct_str[1] = arg_letter[arg];
+            } else {
+                arg = softmmu_args_2(arg, &lo, &hi);
+                st32.args_ct_str[0] = arg_letter[arg];
+                st32.args_ct_str[1] = arg_letter[lo];
+                st32.args_ct_str[2] = arg_letter[hi];
+            }
+            return &st32;
+        }
     case INDEX_op_qemu_ld_i64:
-        return (TCG_TARGET_REG_BITS == 64 ? &r_L
-                : TARGET_LONG_BITS == 32 ? &L_L_L : &L_L_L_L);
+        {
+            static TCGTargetOpDef ld64;
+            if (TCG_TARGET_REG_BITS == 64) {
+                ld64.args_ct_str[0] = arg_letter[tcg_target_call_oarg_regs[0]];
+                ld64.args_ct_str[1] = arg_letter[tcg_target_call_iarg_regs[1]];
+            } else {
+                arg = tcg_target_call_oarg_regs[1];
+                arg = softmmu_args_2(arg, &lo, &hi);
+                ld64.args_ct_str[0] = arg_letter[lo];
+                ld64.args_ct_str[1] = arg_letter[hi];
+                arg = tcg_target_call_iarg_regs[1];
+                if (TARGET_LONG_BITS == 32) {
+                    ld64.args_ct_str[2] = arg_letter[arg];
+                } else {
+                    arg = softmmu_args_2(arg, &lo, &hi);
+                    ld64.args_ct_str[2] = arg_letter[lo];
+                    ld64.args_ct_str[3] = arg_letter[hi];
+                }
+            }
+            return &ld64;
+        }
     case INDEX_op_qemu_st_i64:
-        return (TCG_TARGET_REG_BITS == 64 ? &S_S
-                : TARGET_LONG_BITS == 32 ? &S_S_S : &S_S_S_S);
+        {
+            static TCGTargetOpDef st64;
+            if (TCG_TARGET_REG_BITS == 64) {
+                st64.args_ct_str[1] = arg_letter[tcg_target_call_iarg_regs[1]];
+                st64.args_ct_str[0] = arg_letter[tcg_target_call_iarg_regs[2]];
+            } else {
+                arg = tcg_target_call_iarg_regs[1];
+                if (TARGET_LONG_BITS == 32) {
+                    st64.args_ct_str[2] = arg_letter[arg++];
+                } else {
+                    arg = softmmu_args_2(arg, &lo, &hi);
+                    st64.args_ct_str[2] = arg_letter[lo];
+                    st64.args_ct_str[3] = arg_letter[hi];
+                }
+                arg = softmmu_args_2(arg, &lo, &hi);
+                st64.args_ct_str[0] = arg_letter[lo];
+                st64.args_ct_str[1] = arg_letter[hi];
+            }
+            return &st64;
+        }
+#else
+    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_st_i32:
+        return TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &r_r : &r_r_r;
+    case INDEX_op_qemu_ld_i64:
+    case INDEX_op_qemu_st_i64:
+        if (TCG_TARGET_REG_BITS == 64) {
+            return &r_r;
+        } else if (TARGET_LONG_BITS == 32) {
+            return &r_r_r;
+        } else {
+            return &r_r_r_r;
+        }
+#endif
 
     default:
         return NULL;
-- 
2.17.2
