Received: from eggs.gnu.org ([208.118.235.92]:50782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtnn-0007zk-7M
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtnk-0001eq-3A
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:47 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:43408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtnj-0001e8-Tr
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:44 -0500
Received: by mail-pg1-x532.google.com with SMTP id v28so6812052pgk.10
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:59:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:22 +1100
Message-Id: <20181225205529.10874-36-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 35/42] tcg: Improve register allocation for
 matching constraints
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

Try harder to honor the output_pref.  When we're forced to allocate
a second register for the input, it does not need to use the input
constraint; that will be honored by the register we allocate for the
output and a move is already required.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 32c66dae7d..32bac5e792 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3213,6 +3213,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
 
     /* satisfy input constraints */ 
     for (k = 0; k < nb_iargs; k++) {
+        TCGRegSet i_preferred_regs, o_preferred_regs;
+
         i = def->sorted_args[nb_oargs + k];
         arg = op->args[i];
         arg_ct = &def->args_ct[i];
@@ -3223,17 +3225,18 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             /* constant is OK for instruction */
             const_args[i] = 1;
             new_args[i] = ts->val;
-            goto iarg_end;
+            continue;
         }
 
-        temp_load(s, ts, arg_ct->u.regs, i_allocated_regs, 0);
-
+        i_preferred_regs = o_preferred_regs = 0;
         if (arg_ct->ct & TCG_CT_IALIAS) {
+            o_preferred_regs = op->output_pref[arg_ct->alias_index];
             if (ts->fixed_reg) {
                 /* if fixed register, we must allocate a new register
                    if the alias is not the same register */
-                if (arg != op->args[arg_ct->alias_index])
+                if (arg != op->args[arg_ct->alias_index]) {
                     goto allocate_in_reg;
+                }
             } else {
                 /* if the input is aliased to an output and if it is
                    not dead after the instruction, we must allocate
@@ -3241,33 +3244,42 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
                 if (!IS_DEAD_ARG(i)) {
                     goto allocate_in_reg;
                 }
+
                 /* check if the current register has already been allocated
                    for another input aliased to an output */
-                int k2, i2;
-                for (k2 = 0 ; k2 < k ; k2++) {
-                    i2 = def->sorted_args[nb_oargs + k2];
-                    if ((def->args_ct[i2].ct & TCG_CT_IALIAS) &&
-                        (new_args[i2] == ts->reg)) {
-                        goto allocate_in_reg;
+                if (ts->val_type == TEMP_VAL_REG) {
+                    int k2, i2;
+                    reg = ts->reg;
+                    for (k2 = 0 ; k2 < k ; k2++) {
+                        i2 = def->sorted_args[nb_oargs + k2];
+                        if ((def->args_ct[i2].ct & TCG_CT_IALIAS) &&
+                            reg == new_args[i2]) {
+                            goto allocate_in_reg;
+                        }
                     }
                 }
+                i_preferred_regs = o_preferred_regs;
             }
         }
+
+        temp_load(s, ts, arg_ct->u.regs, i_allocated_regs, i_preferred_regs);
         reg = ts->reg;
+
         if (tcg_regset_test_reg(arg_ct->u.regs, reg)) {
             /* nothing to do : the constraint is satisfied */
         } else {
         allocate_in_reg:
             /* allocate a new register matching the constraint 
                and move the temporary register into it */
+            temp_load(s, ts, tcg_target_available_regs[ts->type],
+                      i_allocated_regs, 0);
             reg = tcg_reg_alloc(s, arg_ct->u.regs, i_allocated_regs,
-                                0, ts->indirect_base);
+                                o_preferred_regs, ts->indirect_base);
             tcg_out_mov(s, ts->type, reg, ts->reg);
         }
         new_args[i] = reg;
         const_args[i] = 0;
         tcg_regset_set_reg(i_allocated_regs, reg);
-    iarg_end: ;
     }
     
     /* mark dead temporaries and free the associated registers */
-- 
2.17.2
