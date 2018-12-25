Received: from eggs.gnu.org ([208.118.235.92]:50583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtnP-0007WR-NH
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtnN-0001Cd-PJ
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:23 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:33938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtnL-00019W-Qb
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:21 -0500
Received: by mail-pl1-x630.google.com with SMTP id w4so6820442plz.1
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:59:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:17 +1100
Message-Id: <20181225205529.10874-31-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 30/42] tcg: Add preferred_reg argument to
 tcg_reg_alloc
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

This new argument will aid register allocation by indicating how
the temporary will be used in future.  If the preference cannot
be satisfied, fall back to the constraints of the current insn.

Short circuit the preference when it cannot be satisfied or if
it does not further constrain the operation.

With an eye toward optimizing function call sequences, optimize
for the preferred_reg set containing a single register.

For the moment, all users pass 0 for preference.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 103 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 81 insertions(+), 22 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index d2be550ab4..210bd5c6b9 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1887,6 +1887,20 @@ static const char * const alignment_name[(MO_AMASK >> MO_ASHIFT) + 1] = {
     [MO_ALIGN_64 >> MO_ASHIFT] = "al64+",
 };
 
+static inline bool tcg_regset_single(TCGRegSet d)
+{
+    return (d & (d - 1)) == 0;
+}
+
+static inline TCGReg tcg_regset_first(TCGRegSet d)
+{
+    if (TCG_TARGET_NB_REGS <= 32) {
+        return ctz32(d);
+    } else {
+        return ctz64(d);
+    }
+}
+
 void tcg_dump_ops(TCGContext *s)
 {
     char buf[128];
@@ -1902,6 +1916,7 @@ void tcg_dump_ops(TCGContext *s)
         def = &tcg_op_defs[c];
 
         if (c == INDEX_op_insn_start) {
+            nb_oargs = 0;
             col += qemu_log("\n ----");
 
             for (i = 0; i < TARGET_INSN_START_WORDS; ++i) {
@@ -2902,31 +2917,72 @@ static void tcg_reg_free(TCGContext *s, TCGReg reg, TCGRegSet allocated_regs)
     }
 }
 
-/* Allocate a register belonging to reg1 & ~reg2 */
-static TCGReg tcg_reg_alloc(TCGContext *s, TCGRegSet desired_regs,
-                            TCGRegSet allocated_regs, bool rev)
+/**
+ * tcg_reg_alloc:
+ * @required_regs: Set of registers in which we must allocate.
+ * @allocated_regs: Set of registers which must be avoided.
+ * @preferred_regs: Set of registers we should prefer.
+ * @rev: True if we search the registers in "indirect" order.
+ *
+ * The allocated register must be in @required_regs & ~@allocated_regs,
+ * but if we can put it in @preferred_regs we may save a move later.
+ */
+static TCGReg tcg_reg_alloc(TCGContext *s, TCGRegSet required_regs,
+                            TCGRegSet allocated_regs,
+                            TCGRegSet preferred_regs, bool rev)
 {
-    int i, n = ARRAY_SIZE(tcg_target_reg_alloc_order);
+    int i, j, f, n = ARRAY_SIZE(tcg_target_reg_alloc_order);
+    TCGRegSet reg_ct[2];
     const int *order;
-    TCGReg reg;
-    TCGRegSet reg_ct;
 
-    reg_ct = desired_regs & ~allocated_regs;
+    reg_ct[1] = required_regs & ~allocated_regs;
+    tcg_debug_assert(reg_ct[1] != 0);
+    reg_ct[0] = reg_ct[1] & preferred_regs;
+
+    /* Skip the preferred_regs option if it cannot be satisfied,
+       or if the preference made no difference.  */
+    f = reg_ct[0] == 0 || reg_ct[0] == reg_ct[1];
+
     order = rev ? indirect_reg_alloc_order : tcg_target_reg_alloc_order;
 
-    /* first try free registers */
-    for(i = 0; i < n; i++) {
-        reg = order[i];
-        if (tcg_regset_test_reg(reg_ct, reg) && s->reg_to_temp[reg] == NULL)
-            return reg;
+    /* Try free registers, preferences first.  */
+    for (j = f; j < 2; j++) {
+        TCGRegSet set = reg_ct[j];
+
+        if (tcg_regset_single(set)) {
+            /* One register in the set.  */
+            TCGReg reg = tcg_regset_first(set);
+            if (s->reg_to_temp[reg] == NULL) {
+                return reg;
+            }
+        } else {
+            for (i = 0; i < n; i++) {
+                TCGReg reg = order[i];
+                if (s->reg_to_temp[reg] == NULL &&
+                    tcg_regset_test_reg(set, reg)) {
+                    return reg;
+                }
+            }
+        }
     }
 
-    /* XXX: do better spill choice */
-    for(i = 0; i < n; i++) {
-        reg = order[i];
-        if (tcg_regset_test_reg(reg_ct, reg)) {
+    /* We must spill something.  */
+    for (j = f; j < 2; j++) {
+        TCGRegSet set = reg_ct[j];
+
+        if (tcg_regset_single(set)) {
+            /* One register in the set.  */
+            TCGReg reg = tcg_regset_first(set);
             tcg_reg_free(s, reg, allocated_regs);
             return reg;
+        } else {
+            for (i = 0; i < n; i++) {
+                TCGReg reg = order[i];
+                if (tcg_regset_test_reg(set, reg)) {
+                    tcg_reg_free(s, reg, allocated_regs);
+                    return reg;
+                }
+            }
         }
     }
 
@@ -2944,12 +3000,14 @@ static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet desired_regs,
     case TEMP_VAL_REG:
         return;
     case TEMP_VAL_CONST:
-        reg = tcg_reg_alloc(s, desired_regs, allocated_regs, ts->indirect_base);
+        reg = tcg_reg_alloc(s, desired_regs, allocated_regs,
+                            0, ts->indirect_base);
         tcg_out_movi(s, ts->type, reg, ts->val);
         ts->mem_coherent = 0;
         break;
     case TEMP_VAL_MEM:
-        reg = tcg_reg_alloc(s, desired_regs, allocated_regs, ts->indirect_base);
+        reg = tcg_reg_alloc(s, desired_regs, allocated_regs,
+                            0, ts->indirect_base);
         tcg_out_ld(s, ts->type, reg, ts->mem_base->reg, ts->mem_offset);
         ts->mem_coherent = 1;
         break;
@@ -3109,7 +3167,8 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
                    input one. */
                 tcg_regset_set_reg(allocated_regs, ts->reg);
                 ots->reg = tcg_reg_alloc(s, tcg_target_available_regs[otype],
-                                         allocated_regs, ots->indirect_base);
+                                         allocated_regs, 0,
+                                         ots->indirect_base);
             }
             tcg_out_mov(s, otype, ots->reg, ts->reg);
         }
@@ -3197,7 +3256,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             /* allocate a new register matching the constraint 
                and move the temporary register into it */
             reg = tcg_reg_alloc(s, arg_ct->u.regs, i_allocated_regs,
-                                ts->indirect_base);
+                                0, ts->indirect_base);
             tcg_out_mov(s, ts->type, reg, ts->reg);
         }
         new_args[i] = reg;
@@ -3242,7 +3301,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             } else if (arg_ct->ct & TCG_CT_NEWREG) {
                 reg = tcg_reg_alloc(s, arg_ct->u.regs,
                                     i_allocated_regs | o_allocated_regs,
-                                    ts->indirect_base);
+                                    0, ts->indirect_base);
             } else {
                 /* if fixed register, we try to use it */
                 reg = ts->reg;
@@ -3251,7 +3310,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
                     goto oarg_end;
                 }
                 reg = tcg_reg_alloc(s, arg_ct->u.regs, o_allocated_regs,
-                                    ts->indirect_base);
+                                    0, ts->indirect_base);
             }
             tcg_regset_set_reg(o_allocated_regs, reg);
             /* if a fixed register is used, then a move will be done afterwards */
-- 
2.17.2
