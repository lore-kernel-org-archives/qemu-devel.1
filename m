Received: from eggs.gnu.org ([2001:4830:134:3::10]:35187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Ur-0006Bp-DC
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Uq-0003DX-9z
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:41 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8Uq-0003DE-2D
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:40 -0500
Received: by mail-pf0-x242.google.com with SMTP id f144so12524907pfa.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:40 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:35 -0800
Message-Id: <20170111021820.24416-21-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/65] tcg: Add markup for output requires new
 register
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

This is the same concept as, and same markup as, the
early clobber markup in gcc.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.c | 34 ++++++++++++++++++++++------------
 tcg/tcg.h |  1 +
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index aabf94f..27913f0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1263,6 +1263,10 @@ void tcg_add_target_add_op_defs(const TCGTargetOpDef *tdefs)
                     if (*ct_str == '\0')
                         break;
                     switch(*ct_str) {
+                    case '&':
+                        def->args_ct[i].ct |= TCG_CT_NEWREG;
+                        ct_str++;
+                        break;
                     case 'i':
                         def->args_ct[i].ct |= TCG_CT_CONST;
                         ct_str++;
@@ -2208,7 +2212,8 @@ static void tcg_reg_alloc_op(TCGContext *s,
                              const TCGOpDef *def, TCGOpcode opc,
                              const TCGArg *args, TCGLifeData arg_life)
 {
-    TCGRegSet allocated_regs;
+    TCGRegSet i_allocated_regs;
+    TCGRegSet o_allocated_regs;
     int i, k, nb_iargs, nb_oargs;
     TCGReg reg;
     TCGArg arg;
@@ -2225,8 +2230,10 @@ static void tcg_reg_alloc_op(TCGContext *s,
            args + nb_oargs + nb_iargs, 
            sizeof(TCGArg) * def->nb_cargs);
 
+    tcg_regset_set(i_allocated_regs, s->reserved_regs);
+    tcg_regset_set(o_allocated_regs, s->reserved_regs);
+
     /* satisfy input constraints */ 
-    tcg_regset_set(allocated_regs, s->reserved_regs);
     for(k = 0; k < nb_iargs; k++) {
         i = def->sorted_args[nb_oargs + k];
         arg = args[i];
@@ -2241,7 +2248,7 @@ static void tcg_reg_alloc_op(TCGContext *s,
             goto iarg_end;
         }
 
-        temp_load(s, ts, arg_ct->u.regs, allocated_regs);
+        temp_load(s, ts, arg_ct->u.regs, i_allocated_regs);
 
         if (arg_ct->ct & TCG_CT_IALIAS) {
             if (ts->fixed_reg) {
@@ -2275,13 +2282,13 @@ static void tcg_reg_alloc_op(TCGContext *s,
         allocate_in_reg:
             /* allocate a new register matching the constraint 
                and move the temporary register into it */
-            reg = tcg_reg_alloc(s, arg_ct->u.regs, allocated_regs,
+            reg = tcg_reg_alloc(s, arg_ct->u.regs, i_allocated_regs,
                                 ts->indirect_base);
             tcg_out_mov(s, ts->type, reg, ts->reg);
         }
         new_args[i] = reg;
         const_args[i] = 0;
-        tcg_regset_set_reg(allocated_regs, reg);
+        tcg_regset_set_reg(i_allocated_regs, reg);
     iarg_end: ;
     }
     
@@ -2293,24 +2300,23 @@ static void tcg_reg_alloc_op(TCGContext *s,
     }
 
     if (def->flags & TCG_OPF_BB_END) {
-        tcg_reg_alloc_bb_end(s, allocated_regs);
+        tcg_reg_alloc_bb_end(s, i_allocated_regs);
     } else {
         if (def->flags & TCG_OPF_CALL_CLOBBER) {
             /* XXX: permit generic clobber register list ? */ 
             for (i = 0; i < TCG_TARGET_NB_REGS; i++) {
                 if (tcg_regset_test_reg(tcg_target_call_clobber_regs, i)) {
-                    tcg_reg_free(s, i, allocated_regs);
+                    tcg_reg_free(s, i, i_allocated_regs);
                 }
             }
         }
         if (def->flags & TCG_OPF_SIDE_EFFECTS) {
             /* sync globals if the op has side effects and might trigger
                an exception. */
-            sync_globals(s, allocated_regs);
+            sync_globals(s, i_allocated_regs);
         }
         
         /* satisfy the output constraints */
-        tcg_regset_set(allocated_regs, s->reserved_regs);
         for(k = 0; k < nb_oargs; k++) {
             i = def->sorted_args[k];
             arg = args[i];
@@ -2318,6 +2324,10 @@ static void tcg_reg_alloc_op(TCGContext *s,
             ts = &s->temps[arg];
             if (arg_ct->ct & TCG_CT_ALIAS) {
                 reg = new_args[arg_ct->alias_index];
+            } else if (arg_ct->ct & TCG_CT_NEWREG) {
+                reg = tcg_reg_alloc(s, arg_ct->u.regs,
+                                    i_allocated_regs | o_allocated_regs,
+                                    ts->indirect_base);
             } else {
                 /* if fixed register, we try to use it */
                 reg = ts->reg;
@@ -2325,10 +2335,10 @@ static void tcg_reg_alloc_op(TCGContext *s,
                     tcg_regset_test_reg(arg_ct->u.regs, reg)) {
                     goto oarg_end;
                 }
-                reg = tcg_reg_alloc(s, arg_ct->u.regs, allocated_regs,
+                reg = tcg_reg_alloc(s, arg_ct->u.regs, o_allocated_regs,
                                     ts->indirect_base);
             }
-            tcg_regset_set_reg(allocated_regs, reg);
+            tcg_regset_set_reg(o_allocated_regs, reg);
             /* if a fixed register is used, then a move will be done afterwards */
             if (!ts->fixed_reg) {
                 if (ts->val_type == TEMP_VAL_REG) {
@@ -2357,7 +2367,7 @@ static void tcg_reg_alloc_op(TCGContext *s,
             tcg_out_mov(s, ts->type, ts->reg, reg);
         }
         if (NEED_SYNC_ARG(i)) {
-            temp_sync(s, ts, allocated_regs, IS_DEAD_ARG(i));
+            temp_sync(s, ts, o_allocated_regs, IS_DEAD_ARG(i));
         } else if (IS_DEAD_ARG(i)) {
             temp_dead(s, ts);
         }
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 5fd3733..ebfcefd 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -851,6 +851,7 @@ void tcg_dump_op_count(FILE *f, fprintf_function cpu_fprintf);
 
 #define TCG_CT_ALIAS  0x80
 #define TCG_CT_IALIAS 0x40
+#define TCG_CT_NEWREG 0x20 /* output requires a new register */
 #define TCG_CT_REG    0x01
 #define TCG_CT_CONST  0x02 /* any constant of register size */
 
-- 
2.9.3
