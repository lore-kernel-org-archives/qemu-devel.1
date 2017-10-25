Received: from eggs.gnu.org ([2001:4830:134:3::10]:45364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6G-00084K-EG
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6E-0007pW-V1
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:48 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:45462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6E-0007ov-LS
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:46 -0400
Received: by mail-wr0-x243.google.com with SMTP id y9so11086290wrb.2
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:35:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:34:48 +0200
Message-Id: <20171025093535.10175-5-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/51] tcg: Propagate TCGOp down to allocators
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

Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.c | 75 +++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 37 insertions(+), 38 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 4f56077f64..27c8b14295 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2334,25 +2334,24 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
     }
 }
 
-static void tcg_reg_alloc_movi(TCGContext *s, const TCGArg *args,
-                               TCGLifeData arg_life)
+static void tcg_reg_alloc_movi(TCGContext *s, const TCGOp *op)
 {
-    TCGTemp *ots = &s->temps[args[0]];
-    tcg_target_ulong val = args[1];
+    TCGTemp *ots = &s->temps[op->args[0]];
+    tcg_target_ulong val = op->args[1];
 
-    tcg_reg_alloc_do_movi(s, ots, val, arg_life);
+    tcg_reg_alloc_do_movi(s, ots, val, op->life);
 }
 
-static void tcg_reg_alloc_mov(TCGContext *s, const TCGOpDef *def,
-                              const TCGArg *args, TCGLifeData arg_life)
+static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
 {
+    const TCGLifeData arg_life = op->life;
     TCGRegSet allocated_regs;
     TCGTemp *ts, *ots;
     TCGType otype, itype;
 
     allocated_regs = s->reserved_regs;
-    ots = &s->temps[args[0]];
-    ts = &s->temps[args[1]];
+    ots = &s->temps[op->args[0]];
+    ts = &s->temps[op->args[1]];
 
     /* Note that otype != itype for no-op truncation.  */
     otype = ots->type;
@@ -2382,7 +2381,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOpDef *def,
            liveness analysis disabled). */
         tcg_debug_assert(NEED_SYNC_ARG(0));
         if (!ots->mem_allocated) {
-            temp_allocate_frame(s, args[0]);
+            temp_allocate_frame(s, op->args[0]);
         }
         tcg_out_st(s, otype, ts->reg, ots->mem_base->reg, ots->mem_offset);
         if (IS_DEAD_ARG(1)) {
@@ -2416,10 +2415,10 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOpDef *def,
     }
 }
 
-static void tcg_reg_alloc_op(TCGContext *s, 
-                             const TCGOpDef *def, TCGOpcode opc,
-                             const TCGArg *args, TCGLifeData arg_life)
+static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
 {
+    const TCGLifeData arg_life = op->life;
+    const TCGOpDef * const def = &tcg_op_defs[op->opc];
     TCGRegSet i_allocated_regs;
     TCGRegSet o_allocated_regs;
     int i, k, nb_iargs, nb_oargs;
@@ -2435,16 +2434,16 @@ static void tcg_reg_alloc_op(TCGContext *s,
 
     /* copy constants */
     memcpy(new_args + nb_oargs + nb_iargs, 
-           args + nb_oargs + nb_iargs, 
+           op->args + nb_oargs + nb_iargs,
            sizeof(TCGArg) * def->nb_cargs);
 
     i_allocated_regs = s->reserved_regs;
     o_allocated_regs = s->reserved_regs;
 
     /* satisfy input constraints */ 
-    for(k = 0; k < nb_iargs; k++) {
+    for (k = 0; k < nb_iargs; k++) {
         i = def->sorted_args[nb_oargs + k];
-        arg = args[i];
+        arg = op->args[i];
         arg_ct = &def->args_ct[i];
         ts = &s->temps[arg];
 
@@ -2462,7 +2461,7 @@ static void tcg_reg_alloc_op(TCGContext *s,
             if (ts->fixed_reg) {
                 /* if fixed register, we must allocate a new register
                    if the alias is not the same register */
-                if (arg != args[arg_ct->alias_index])
+                if (arg != op->args[arg_ct->alias_index])
                     goto allocate_in_reg;
             } else {
                 /* if the input is aliased to an output and if it is
@@ -2503,7 +2502,7 @@ static void tcg_reg_alloc_op(TCGContext *s,
     /* mark dead temporaries and free the associated registers */
     for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
         if (IS_DEAD_ARG(i)) {
-            temp_dead(s, &s->temps[args[i]]);
+            temp_dead(s, &s->temps[op->args[i]]);
         }
     }
 
@@ -2527,7 +2526,7 @@ static void tcg_reg_alloc_op(TCGContext *s,
         /* satisfy the output constraints */
         for(k = 0; k < nb_oargs; k++) {
             i = def->sorted_args[k];
-            arg = args[i];
+            arg = op->args[i];
             arg_ct = &def->args_ct[i];
             ts = &s->temps[arg];
             if ((arg_ct->ct & TCG_CT_ALIAS)
@@ -2566,11 +2565,11 @@ static void tcg_reg_alloc_op(TCGContext *s,
     }
 
     /* emit instruction */
-    tcg_out_op(s, opc, new_args, const_args);
+    tcg_out_op(s, op->opc, new_args, const_args);
     
     /* move the outputs in the correct register if needed */
     for(i = 0; i < nb_oargs; i++) {
-        ts = &s->temps[args[i]];
+        ts = &s->temps[op->args[i]];
         reg = new_args[i];
         if (ts->fixed_reg && ts->reg != reg) {
             tcg_out_mov(s, ts->type, ts->reg, reg);
@@ -2589,9 +2588,11 @@ static void tcg_reg_alloc_op(TCGContext *s,
 #define STACK_DIR(x) (x)
 #endif
 
-static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
-                               const TCGArg * const args, TCGLifeData arg_life)
+static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
 {
+    const int nb_oargs = op->callo;
+    const int nb_iargs = op->calli;
+    const TCGLifeData arg_life = op->life;
     int flags, nb_regs, i;
     TCGReg reg;
     TCGArg arg;
@@ -2602,8 +2603,8 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
     int allocate_args;
     TCGRegSet allocated_regs;
 
-    func_addr = (tcg_insn_unit *)(intptr_t)args[nb_oargs + nb_iargs];
-    flags = args[nb_oargs + nb_iargs + 1];
+    func_addr = (tcg_insn_unit *)(intptr_t)op->args[nb_oargs + nb_iargs];
+    flags = op->args[nb_oargs + nb_iargs + 1];
 
     nb_regs = ARRAY_SIZE(tcg_target_call_iarg_regs);
     if (nb_regs > nb_iargs) {
@@ -2622,8 +2623,8 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
     }
 
     stack_offset = TCG_TARGET_CALL_STACK_OFFSET;
-    for(i = nb_regs; i < nb_iargs; i++) {
-        arg = args[nb_oargs + i];
+    for (i = nb_regs; i < nb_iargs; i++) {
+        arg = op->args[nb_oargs + i];
 #ifdef TCG_TARGET_STACK_GROWSUP
         stack_offset -= sizeof(tcg_target_long);
 #endif
@@ -2640,8 +2641,8 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
     
     /* assign input registers */
     allocated_regs = s->reserved_regs;
-    for(i = 0; i < nb_regs; i++) {
-        arg = args[nb_oargs + i];
+    for (i = 0; i < nb_regs; i++) {
+        arg = op->args[nb_oargs + i];
         if (arg != TCG_CALL_DUMMY_ARG) {
             ts = &s->temps[arg];
             reg = tcg_target_call_iarg_regs[i];
@@ -2663,9 +2664,9 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
     }
     
     /* mark dead temporaries and free the associated registers */
-    for(i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
+    for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
         if (IS_DEAD_ARG(i)) {
-            temp_dead(s, &s->temps[args[i]]);
+            temp_dead(s, &s->temps[op->args[i]]);
         }
     }
     
@@ -2690,7 +2691,7 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
 
     /* assign output registers and emit moves if needed */
     for(i = 0; i < nb_oargs; i++) {
-        arg = args[i];
+        arg = op->args[i];
         ts = &s->temps[arg];
         reg = tcg_target_call_oarg_regs[i];
         tcg_debug_assert(s->reg_to_temp[reg] == NULL);
@@ -2838,8 +2839,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     for (oi = s->gen_op_buf[0].next; oi != 0; oi = oi_next) {
         TCGOp * const op = &s->gen_op_buf[oi];
         TCGOpcode opc = op->opc;
-        const TCGOpDef *def = &tcg_op_defs[opc];
-        TCGLifeData arg_life = op->life;
 
         oi_next = op->next;
 #ifdef CONFIG_PROFILER
@@ -2849,11 +2848,11 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
         switch (opc) {
         case INDEX_op_mov_i32:
         case INDEX_op_mov_i64:
-            tcg_reg_alloc_mov(s, def, op->args, arg_life);
+            tcg_reg_alloc_mov(s, op);
             break;
         case INDEX_op_movi_i32:
         case INDEX_op_movi_i64:
-            tcg_reg_alloc_movi(s, op->args, arg_life);
+            tcg_reg_alloc_movi(s, op);
             break;
         case INDEX_op_insn_start:
             if (num_insns >= 0) {
@@ -2878,7 +2877,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
             tcg_out_label(s, arg_label(op->args[0]), s->code_ptr);
             break;
         case INDEX_op_call:
-            tcg_reg_alloc_call(s, op->callo, op->calli, op->args, arg_life);
+            tcg_reg_alloc_call(s, op);
             break;
         default:
             /* Sanity check that we've not introduced any unhandled opcodes. */
@@ -2886,7 +2885,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
             /* Note: in order to speed up the code, it would be much
                faster to have specialized register allocator functions for
                some common argument patterns */
-            tcg_reg_alloc_op(s, def, opc, op->args, arg_life);
+            tcg_reg_alloc_op(s, op);
             break;
         }
 #ifdef CONFIG_DEBUG_TCG
-- 
2.13.6
