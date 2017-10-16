Received: from eggs.gnu.org ([2001:4830:134:3::10]:52215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e499j-0001ur-Oh
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e499h-0003IA-Ro
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:23 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:43971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e499h-0003HZ-JK
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:21 -0400
Received: by mail-pg0-x22c.google.com with SMTP id s75so6499626pgs.0
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:26:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:24 -0700
Message-Id: <20171016172609.23422-6-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 05/50] tcg: Introduce arg_temp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.h      |  5 +++++
 tcg/optimize.c |  4 ++--
 tcg/tcg.c      | 51 +++++++++++++++++++++++++--------------------------
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 2cefd9f125..f06187fd8e 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -725,6 +725,11 @@ struct TCGContext {
 extern TCGContext tcg_ctx;
 extern bool parallel_cpus;
 
+static inline TCGTemp *arg_temp(TCGArg a)
+{
+    return &tcg_ctx.temps[a];
+}
+
 static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)
 {
     tcg_ctx.gen_op_buf[op_idx].args[arg] = v;
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1a1c6fb90c..d8c3a7ed56 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -133,7 +133,7 @@ static TCGArg find_better_copy(TCGContext *s, TCGArg temp)
     }
 
     /* If it is a temp, search for a temp local. */
-    if (!s->temps[temp].temp_local) {
+    if (!arg_temp(temp)->temp_local) {
         for (i = temps[temp].next_copy ; i != temp ; i = temps[i].next_copy) {
             if (s->temps[i].temp_local) {
                 return i;
@@ -207,7 +207,7 @@ static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg src)
     }
     temps[dst].mask = mask;
 
-    if (s->temps[src].type == s->temps[dst].type) {
+    if (arg_temp(src)->type == arg_temp(dst)->type) {
         temps[dst].next_copy = temps[src].next_copy;
         temps[dst].prev_copy = src;
         temps[temps[dst].next_copy].prev_copy = dst;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 147b8904d8..2704aa8a4d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1200,11 +1200,10 @@ static char *tcg_get_arg_str_ptr(TCGContext *s, char *buf, int buf_size,
     return buf;
 }
 
-static char *tcg_get_arg_str_idx(TCGContext *s, char *buf,
-                                 int buf_size, int idx)
+static char *tcg_get_arg_str(TCGContext *s, char *buf,
+                             int buf_size, TCGArg arg)
 {
-    tcg_debug_assert(idx >= 0 && idx < s->nb_temps);
-    return tcg_get_arg_str_ptr(s, buf, buf_size, &s->temps[idx]);
+    return tcg_get_arg_str_ptr(s, buf, buf_size, arg_temp(arg));
 }
 
 /* Find helper name.  */
@@ -1307,14 +1306,14 @@ void tcg_dump_ops(TCGContext *s)
                             tcg_find_helper(s, op->args[nb_oargs + nb_iargs]),
                             op->args[nb_oargs + nb_iargs + 1], nb_oargs);
             for (i = 0; i < nb_oargs; i++) {
-                col += qemu_log(",%s", tcg_get_arg_str_idx(s, buf, sizeof(buf),
-                                                           op->args[i]));
+                col += qemu_log(",%s", tcg_get_arg_str(s, buf, sizeof(buf),
+                                                       op->args[i]));
             }
             for (i = 0; i < nb_iargs; i++) {
                 TCGArg arg = op->args[nb_oargs + i];
                 const char *t = "<dummy>";
                 if (arg != TCG_CALL_DUMMY_ARG) {
-                    t = tcg_get_arg_str_idx(s, buf, sizeof(buf), arg);
+                    t = tcg_get_arg_str(s, buf, sizeof(buf), arg);
                 }
                 col += qemu_log(",%s", t);
             }
@@ -1330,15 +1329,15 @@ void tcg_dump_ops(TCGContext *s)
                 if (k != 0) {
                     col += qemu_log(",");
                 }
-                col += qemu_log("%s", tcg_get_arg_str_idx(s, buf, sizeof(buf),
-                                                          op->args[k++]));
+                col += qemu_log("%s", tcg_get_arg_str(s, buf, sizeof(buf),
+                                                      op->args[k++]));
             }
             for (i = 0; i < nb_iargs; i++) {
                 if (k != 0) {
                     col += qemu_log(",");
                 }
-                col += qemu_log("%s", tcg_get_arg_str_idx(s, buf, sizeof(buf),
-                                                          op->args[k++]));
+                col += qemu_log("%s", tcg_get_arg_str(s, buf, sizeof(buf),
+                                                      op->args[k++]));
             }
             switch (c) {
             case INDEX_op_brcond_i32:
@@ -1930,7 +1929,7 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
             if (arg < nb_globals) {
                 dir = dir_temps[arg];
                 if (dir != 0 && temp_state[arg] == TS_DEAD) {
-                    TCGTemp *its = &s->temps[arg];
+                    TCGTemp *its = arg_temp(arg);
                     TCGOpcode lopc = (its->type == TCG_TYPE_I32
                                       ? INDEX_op_ld_i32
                                       : INDEX_op_ld_i64);
@@ -2001,7 +2000,7 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
 
             /* Sync outputs upon their last write.  */
             if (NEED_SYNC_ARG(i)) {
-                TCGTemp *its = &s->temps[arg];
+                TCGTemp *its = arg_temp(arg);
                 TCGOpcode sopc = (its->type == TCG_TYPE_I32
                                   ? INDEX_op_st_i32
                                   : INDEX_op_st_i64);
@@ -2032,7 +2031,7 @@ static void dump_regs(TCGContext *s)
 
     for(i = 0; i < s->nb_temps; i++) {
         ts = &s->temps[i];
-        printf("  %10s: ", tcg_get_arg_str_idx(s, buf, sizeof(buf), i));
+        printf("  %10s: ", tcg_get_arg_str_ptr(s, buf, sizeof(buf), ts));
         switch(ts->val_type) {
         case TEMP_VAL_REG:
             printf("%s", tcg_target_reg_names[ts->reg]);
@@ -2336,7 +2335,7 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
 
 static void tcg_reg_alloc_movi(TCGContext *s, const TCGOp *op)
 {
-    TCGTemp *ots = &s->temps[op->args[0]];
+    TCGTemp *ots = arg_temp(op->args[0]);
     tcg_target_ulong val = op->args[1];
 
     tcg_reg_alloc_do_movi(s, ots, val, op->life);
@@ -2350,8 +2349,8 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
     TCGType otype, itype;
 
     allocated_regs = s->reserved_regs;
-    ots = &s->temps[op->args[0]];
-    ts = &s->temps[op->args[1]];
+    ots = arg_temp(op->args[0]);
+    ts = arg_temp(op->args[1]);
 
     /* Note that otype != itype for no-op truncation.  */
     otype = ots->type;
@@ -2448,7 +2447,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         i = def->sorted_args[nb_oargs + k];
         arg = op->args[i];
         arg_ct = &def->args_ct[i];
-        ts = &s->temps[arg];
+        ts = arg_temp(arg);
 
         if (ts->val_type == TEMP_VAL_CONST
             && tcg_target_const_match(ts->val, ts->type, arg_ct)) {
@@ -2505,7 +2504,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     /* mark dead temporaries and free the associated registers */
     for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
         if (IS_DEAD_ARG(i)) {
-            temp_dead(s, &s->temps[op->args[i]]);
+            temp_dead(s, arg_temp(op->args[i]));
         }
     }
 
@@ -2531,7 +2530,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             i = def->sorted_args[k];
             arg = op->args[i];
             arg_ct = &def->args_ct[i];
-            ts = &s->temps[arg];
+            ts = arg_temp(arg);
             if ((arg_ct->ct & TCG_CT_ALIAS)
                 && !const_args[arg_ct->alias_index]) {
                 reg = new_args[arg_ct->alias_index];
@@ -2572,7 +2571,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     
     /* move the outputs in the correct register if needed */
     for(i = 0; i < nb_oargs; i++) {
-        ts = &s->temps[op->args[i]];
+        ts = arg_temp(op->args[i]);
         reg = new_args[i];
         if (ts->fixed_reg && ts->reg != reg) {
             tcg_out_mov(s, ts->type, ts->reg, reg);
@@ -2632,7 +2631,7 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
         stack_offset -= sizeof(tcg_target_long);
 #endif
         if (arg != TCG_CALL_DUMMY_ARG) {
-            ts = &s->temps[arg];
+            ts = arg_temp(arg);
             temp_load(s, ts, tcg_target_available_regs[ts->type],
                       s->reserved_regs);
             tcg_out_st(s, ts->type, ts->reg, TCG_REG_CALL_STACK, stack_offset);
@@ -2647,7 +2646,7 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
     for (i = 0; i < nb_regs; i++) {
         arg = op->args[nb_oargs + i];
         if (arg != TCG_CALL_DUMMY_ARG) {
-            ts = &s->temps[arg];
+            ts = arg_temp(arg);
             reg = tcg_target_call_iarg_regs[i];
             tcg_reg_free(s, reg, allocated_regs);
 
@@ -2669,7 +2668,7 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
     /* mark dead temporaries and free the associated registers */
     for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
         if (IS_DEAD_ARG(i)) {
-            temp_dead(s, &s->temps[op->args[i]]);
+            temp_dead(s, arg_temp(op->args[i]));
         }
     }
     
@@ -2695,7 +2694,7 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
     /* assign output registers and emit moves if needed */
     for(i = 0; i < nb_oargs; i++) {
         arg = op->args[i];
-        ts = &s->temps[arg];
+        ts = arg_temp(arg);
         reg = tcg_target_call_oarg_regs[i];
         tcg_debug_assert(s->reg_to_temp[reg] == NULL);
 
@@ -2873,7 +2872,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
             }
             break;
         case INDEX_op_discard:
-            temp_dead(s, &s->temps[op->args[0]]);
+            temp_dead(s, arg_temp(op->args[0]));
             break;
         case INDEX_op_set_label:
             tcg_reg_alloc_bb_end(s, s->reserved_regs);
-- 
2.13.6
