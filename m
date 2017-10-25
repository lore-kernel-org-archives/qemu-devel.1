Received: from eggs.gnu.org ([2001:4830:134:3::10]:45363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6G-00084J-Db
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6C-0007nl-Vf
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:48 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:50346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6C-0007lM-Fw
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:44 -0400
Received: by mail-wm0-x244.google.com with SMTP id u138so593665wmu.5
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:35:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:34:46 +0200
Message-Id: <20171025093535.10175-3-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/51] tcg: Propagate args to op->args in
 optimizer
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
 tcg/optimize.c | 430 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 227 insertions(+), 203 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 002aad6bf4..1a1c6fb90c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -166,8 +166,7 @@ static bool temps_are_copies(TCGArg arg1, TCGArg arg2)
     return false;
 }
 
-static void tcg_opt_gen_movi(TCGContext *s, TCGOp *op, TCGArg *args,
-                             TCGArg dst, TCGArg val)
+static void tcg_opt_gen_movi(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg val)
 {
     TCGOpcode new_op = op_to_movi(op->opc);
     tcg_target_ulong mask;
@@ -184,12 +183,11 @@ static void tcg_opt_gen_movi(TCGContext *s, TCGOp *op, TCGArg *args,
     }
     temps[dst].mask = mask;
 
-    args[0] = dst;
-    args[1] = val;
+    op->args[0] = dst;
+    op->args[1] = val;
 }
 
-static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op, TCGArg *args,
-                            TCGArg dst, TCGArg src)
+static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg src)
 {
     if (temps_are_copies(dst, src)) {
         tcg_op_remove(s, op);
@@ -218,8 +216,8 @@ static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op, TCGArg *args,
         temps[dst].val = temps[src].val;
     }
 
-    args[0] = dst;
-    args[1] = src;
+    op->args[0] = dst;
+    op->args[1] = src;
 }
 
 static TCGArg do_constant_folding_2(TCGOpcode op, TCGArg x, TCGArg y)
@@ -559,7 +557,7 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
 void tcg_optimize(TCGContext *s)
 {
     int oi, oi_next, nb_temps, nb_globals;
-    TCGArg *prev_mb_args = NULL;
+    TCGOp *prev_mb = NULL;
 
     /* Array VALS has an element for each temp.
        If this temp holds a constant then its value is kept in VALS' element.
@@ -576,7 +574,6 @@ void tcg_optimize(TCGContext *s)
         TCGArg tmp;
 
         TCGOp * const op = &s->gen_op_buf[oi];
-        TCGArg * const args = op->args;
         TCGOpcode opc = op->opc;
         const TCGOpDef *def = &tcg_op_defs[opc];
 
@@ -588,7 +585,7 @@ void tcg_optimize(TCGContext *s)
             nb_oargs = op->callo;
             nb_iargs = op->calli;
             for (i = 0; i < nb_oargs + nb_iargs; i++) {
-                tmp = args[i];
+                tmp = op->args[i];
                 if (tmp != TCG_CALL_DUMMY_ARG) {
                     init_temp_info(tmp);
                 }
@@ -597,14 +594,14 @@ void tcg_optimize(TCGContext *s)
             nb_oargs = def->nb_oargs;
             nb_iargs = def->nb_iargs;
             for (i = 0; i < nb_oargs + nb_iargs; i++) {
-                init_temp_info(args[i]);
+                init_temp_info(op->args[i]);
             }
         }
 
         /* Do copy propagation */
         for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
-            if (temp_is_copy(args[i])) {
-                args[i] = find_better_copy(s, args[i]);
+            if (temp_is_copy(op->args[i])) {
+                op->args[i] = find_better_copy(s, op->args[i]);
             }
         }
 
@@ -620,45 +617,45 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(nor):
         CASE_OP_32_64(muluh):
         CASE_OP_32_64(mulsh):
-            swap_commutative(args[0], &args[1], &args[2]);
+            swap_commutative(op->args[0], &op->args[1], &op->args[2]);
             break;
         CASE_OP_32_64(brcond):
-            if (swap_commutative(-1, &args[0], &args[1])) {
-                args[2] = tcg_swap_cond(args[2]);
+            if (swap_commutative(-1, &op->args[0], &op->args[1])) {
+                op->args[2] = tcg_swap_cond(op->args[2]);
             }
             break;
         CASE_OP_32_64(setcond):
-            if (swap_commutative(args[0], &args[1], &args[2])) {
-                args[3] = tcg_swap_cond(args[3]);
+            if (swap_commutative(op->args[0], &op->args[1], &op->args[2])) {
+                op->args[3] = tcg_swap_cond(op->args[3]);
             }
             break;
         CASE_OP_32_64(movcond):
-            if (swap_commutative(-1, &args[1], &args[2])) {
-                args[5] = tcg_swap_cond(args[5]);
+            if (swap_commutative(-1, &op->args[1], &op->args[2])) {
+                op->args[5] = tcg_swap_cond(op->args[5]);
             }
             /* For movcond, we canonicalize the "false" input reg to match
                the destination reg so that the tcg backend can implement
                a "move if true" operation.  */
-            if (swap_commutative(args[0], &args[4], &args[3])) {
-                args[5] = tcg_invert_cond(args[5]);
+            if (swap_commutative(op->args[0], &op->args[4], &op->args[3])) {
+                op->args[5] = tcg_invert_cond(op->args[5]);
             }
             break;
         CASE_OP_32_64(add2):
-            swap_commutative(args[0], &args[2], &args[4]);
-            swap_commutative(args[1], &args[3], &args[5]);
+            swap_commutative(op->args[0], &op->args[2], &op->args[4]);
+            swap_commutative(op->args[1], &op->args[3], &op->args[5]);
             break;
         CASE_OP_32_64(mulu2):
         CASE_OP_32_64(muls2):
-            swap_commutative(args[0], &args[2], &args[3]);
+            swap_commutative(op->args[0], &op->args[2], &op->args[3]);
             break;
         case INDEX_op_brcond2_i32:
-            if (swap_commutative2(&args[0], &args[2])) {
-                args[4] = tcg_swap_cond(args[4]);
+            if (swap_commutative2(&op->args[0], &op->args[2])) {
+                op->args[4] = tcg_swap_cond(op->args[4]);
             }
             break;
         case INDEX_op_setcond2_i32:
-            if (swap_commutative2(&args[1], &args[3])) {
-                args[5] = tcg_swap_cond(args[5]);
+            if (swap_commutative2(&op->args[1], &op->args[3])) {
+                op->args[5] = tcg_swap_cond(op->args[5]);
             }
             break;
         default:
@@ -673,8 +670,8 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(sar):
         CASE_OP_32_64(rotl):
         CASE_OP_32_64(rotr):
-            if (temp_is_const(args[1]) && temps[args[1]].val == 0) {
-                tcg_opt_gen_movi(s, op, args, args[0], 0);
+            if (temp_is_const(op->args[1]) && temps[op->args[1]].val == 0) {
+                tcg_opt_gen_movi(s, op, op->args[0], 0);
                 continue;
             }
             break;
@@ -683,7 +680,7 @@ void tcg_optimize(TCGContext *s)
                 TCGOpcode neg_op;
                 bool have_neg;
 
-                if (temp_is_const(args[2])) {
+                if (temp_is_const(op->args[2])) {
                     /* Proceed with possible constant folding. */
                     break;
                 }
@@ -697,40 +694,45 @@ void tcg_optimize(TCGContext *s)
                 if (!have_neg) {
                     break;
                 }
-                if (temp_is_const(args[1]) && temps[args[1]].val == 0) {
+                if (temp_is_const(op->args[1])
+                    && temps[op->args[1]].val == 0) {
                     op->opc = neg_op;
-                    reset_temp(args[0]);
-                    args[1] = args[2];
+                    reset_temp(op->args[0]);
+                    op->args[1] = op->args[2];
                     continue;
                 }
             }
             break;
         CASE_OP_32_64(xor):
         CASE_OP_32_64(nand):
-            if (!temp_is_const(args[1])
-                && temp_is_const(args[2]) && temps[args[2]].val == -1) {
+            if (!temp_is_const(op->args[1])
+                && temp_is_const(op->args[2])
+                && temps[op->args[2]].val == -1) {
                 i = 1;
                 goto try_not;
             }
             break;
         CASE_OP_32_64(nor):
-            if (!temp_is_const(args[1])
-                && temp_is_const(args[2]) && temps[args[2]].val == 0) {
+            if (!temp_is_const(op->args[1])
+                && temp_is_const(op->args[2])
+                && temps[op->args[2]].val == 0) {
                 i = 1;
                 goto try_not;
             }
             break;
         CASE_OP_32_64(andc):
-            if (!temp_is_const(args[2])
-                && temp_is_const(args[1]) && temps[args[1]].val == -1) {
+            if (!temp_is_const(op->args[2])
+                && temp_is_const(op->args[1])
+                && temps[op->args[1]].val == -1) {
                 i = 2;
                 goto try_not;
             }
             break;
         CASE_OP_32_64(orc):
         CASE_OP_32_64(eqv):
-            if (!temp_is_const(args[2])
-                && temp_is_const(args[1]) && temps[args[1]].val == 0) {
+            if (!temp_is_const(op->args[2])
+                && temp_is_const(op->args[1])
+                && temps[op->args[1]].val == 0) {
                 i = 2;
                 goto try_not;
             }
@@ -751,8 +753,8 @@ void tcg_optimize(TCGContext *s)
                     break;
                 }
                 op->opc = not_op;
-                reset_temp(args[0]);
-                args[1] = args[i];
+                reset_temp(op->args[0]);
+                op->args[1] = op->args[i];
                 continue;
             }
         default:
@@ -771,18 +773,20 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(or):
         CASE_OP_32_64(xor):
         CASE_OP_32_64(andc):
-            if (!temp_is_const(args[1])
-                && temp_is_const(args[2]) && temps[args[2]].val == 0) {
-                tcg_opt_gen_mov(s, op, args, args[0], args[1]);
+            if (!temp_is_const(op->args[1])
+                && temp_is_const(op->args[2])
+                && temps[op->args[2]].val == 0) {
+                tcg_opt_gen_mov(s, op, op->args[0], op->args[1]);
                 continue;
             }
             break;
         CASE_OP_32_64(and):
         CASE_OP_32_64(orc):
         CASE_OP_32_64(eqv):
-            if (!temp_is_const(args[1])
-                && temp_is_const(args[2]) && temps[args[2]].val == -1) {
-                tcg_opt_gen_mov(s, op, args, args[0], args[1]);
+            if (!temp_is_const(op->args[1])
+                && temp_is_const(op->args[2])
+                && temps[op->args[2]].val == -1) {
+                tcg_opt_gen_mov(s, op, op->args[0], op->args[1]);
                 continue;
             }
             break;
@@ -796,21 +800,21 @@ void tcg_optimize(TCGContext *s)
         affected = -1;
         switch (opc) {
         CASE_OP_32_64(ext8s):
-            if ((temps[args[1]].mask & 0x80) != 0) {
+            if ((temps[op->args[1]].mask & 0x80) != 0) {
                 break;
             }
         CASE_OP_32_64(ext8u):
             mask = 0xff;
             goto and_const;
         CASE_OP_32_64(ext16s):
-            if ((temps[args[1]].mask & 0x8000) != 0) {
+            if ((temps[op->args[1]].mask & 0x8000) != 0) {
                 break;
             }
         CASE_OP_32_64(ext16u):
             mask = 0xffff;
             goto and_const;
         case INDEX_op_ext32s_i64:
-            if ((temps[args[1]].mask & 0x80000000) != 0) {
+            if ((temps[op->args[1]].mask & 0x80000000) != 0) {
                 break;
             }
         case INDEX_op_ext32u_i64:
@@ -818,110 +822,111 @@ void tcg_optimize(TCGContext *s)
             goto and_const;
 
         CASE_OP_32_64(and):
-            mask = temps[args[2]].mask;
-            if (temp_is_const(args[2])) {
+            mask = temps[op->args[2]].mask;
+            if (temp_is_const(op->args[2])) {
         and_const:
-                affected = temps[args[1]].mask & ~mask;
+                affected = temps[op->args[1]].mask & ~mask;
             }
-            mask = temps[args[1]].mask & mask;
+            mask = temps[op->args[1]].mask & mask;
             break;
 
         case INDEX_op_ext_i32_i64:
-            if ((temps[args[1]].mask & 0x80000000) != 0) {
+            if ((temps[op->args[1]].mask & 0x80000000) != 0) {
                 break;
             }
         case INDEX_op_extu_i32_i64:
             /* We do not compute affected as it is a size changing op.  */
-            mask = (uint32_t)temps[args[1]].mask;
+            mask = (uint32_t)temps[op->args[1]].mask;
             break;
 
         CASE_OP_32_64(andc):
             /* Known-zeros does not imply known-ones.  Therefore unless
-               args[2] is constant, we can't infer anything from it.  */
-            if (temp_is_const(args[2])) {
-                mask = ~temps[args[2]].mask;
+               op->args[2] is constant, we can't infer anything from it.  */
+            if (temp_is_const(op->args[2])) {
+                mask = ~temps[op->args[2]].mask;
                 goto and_const;
             }
-            /* But we certainly know nothing outside args[1] may be set. */
-            mask = temps[args[1]].mask;
+            /* But we certainly know nothing outside op->args[1] may be set. */
+            mask = temps[op->args[1]].mask;
             break;
 
         case INDEX_op_sar_i32:
-            if (temp_is_const(args[2])) {
-                tmp = temps[args[2]].val & 31;
-                mask = (int32_t)temps[args[1]].mask >> tmp;
+            if (temp_is_const(op->args[2])) {
+                tmp = temps[op->args[2]].val & 31;
+                mask = (int32_t)temps[op->args[1]].mask >> tmp;
             }
             break;
         case INDEX_op_sar_i64:
-            if (temp_is_const(args[2])) {
-                tmp = temps[args[2]].val & 63;
-                mask = (int64_t)temps[args[1]].mask >> tmp;
+            if (temp_is_const(op->args[2])) {
+                tmp = temps[op->args[2]].val & 63;
+                mask = (int64_t)temps[op->args[1]].mask >> tmp;
             }
             break;
 
         case INDEX_op_shr_i32:
-            if (temp_is_const(args[2])) {
-                tmp = temps[args[2]].val & 31;
-                mask = (uint32_t)temps[args[1]].mask >> tmp;
+            if (temp_is_const(op->args[2])) {
+                tmp = temps[op->args[2]].val & 31;
+                mask = (uint32_t)temps[op->args[1]].mask >> tmp;
             }
             break;
         case INDEX_op_shr_i64:
-            if (temp_is_const(args[2])) {
-                tmp = temps[args[2]].val & 63;
-                mask = (uint64_t)temps[args[1]].mask >> tmp;
+            if (temp_is_const(op->args[2])) {
+                tmp = temps[op->args[2]].val & 63;
+                mask = (uint64_t)temps[op->args[1]].mask >> tmp;
             }
             break;
 
         case INDEX_op_extrl_i64_i32:
-            mask = (uint32_t)temps[args[1]].mask;
+            mask = (uint32_t)temps[op->args[1]].mask;
             break;
         case INDEX_op_extrh_i64_i32:
-            mask = (uint64_t)temps[args[1]].mask >> 32;
+            mask = (uint64_t)temps[op->args[1]].mask >> 32;
             break;
 
         CASE_OP_32_64(shl):
-            if (temp_is_const(args[2])) {
-                tmp = temps[args[2]].val & (TCG_TARGET_REG_BITS - 1);
-                mask = temps[args[1]].mask << tmp;
+            if (temp_is_const(op->args[2])) {
+                tmp = temps[op->args[2]].val & (TCG_TARGET_REG_BITS - 1);
+                mask = temps[op->args[1]].mask << tmp;
             }
             break;
 
         CASE_OP_32_64(neg):
             /* Set to 1 all bits to the left of the rightmost.  */
-            mask = -(temps[args[1]].mask & -temps[args[1]].mask);
+            mask = -(temps[op->args[1]].mask & -temps[op->args[1]].mask);
             break;
 
         CASE_OP_32_64(deposit):
-            mask = deposit64(temps[args[1]].mask, args[3], args[4],
-                             temps[args[2]].mask);
+            mask = deposit64(temps[op->args[1]].mask, op->args[3],
+                             op->args[4], temps[op->args[2]].mask);
             break;
 
         CASE_OP_32_64(extract):
-            mask = extract64(temps[args[1]].mask, args[2], args[3]);
-            if (args[2] == 0) {
-                affected = temps[args[1]].mask & ~mask;
+            mask = extract64(temps[op->args[1]].mask, op->args[2], op->args[3]);
+            if (op->args[2] == 0) {
+                affected = temps[op->args[1]].mask & ~mask;
             }
             break;
         CASE_OP_32_64(sextract):
-            mask = sextract64(temps[args[1]].mask, args[2], args[3]);
-            if (args[2] == 0 && (tcg_target_long)mask >= 0) {
-                affected = temps[args[1]].mask & ~mask;
+            mask = sextract64(temps[op->args[1]].mask,
+                              op->args[2], op->args[3]);
+            if (op->args[2] == 0 && (tcg_target_long)mask >= 0) {
+                affected = temps[op->args[1]].mask & ~mask;
             }
             break;
 
         CASE_OP_32_64(or):
         CASE_OP_32_64(xor):
-            mask = temps[args[1]].mask | temps[args[2]].mask;
+            mask = temps[op->args[1]].mask | temps[op->args[2]].mask;
             break;
 
         case INDEX_op_clz_i32:
         case INDEX_op_ctz_i32:
-            mask = temps[args[2]].mask | 31;
+            mask = temps[op->args[2]].mask | 31;
             break;
 
         case INDEX_op_clz_i64:
         case INDEX_op_ctz_i64:
-            mask = temps[args[2]].mask | 63;
+            mask = temps[op->args[2]].mask | 63;
             break;
 
         case INDEX_op_ctpop_i32:
@@ -937,7 +942,7 @@ void tcg_optimize(TCGContext *s)
             break;
 
         CASE_OP_32_64(movcond):
-            mask = temps[args[3]].mask | temps[args[4]].mask;
+            mask = temps[op->args[3]].mask | temps[op->args[4]].mask;
             break;
 
         CASE_OP_32_64(ld8u):
@@ -952,7 +957,7 @@ void tcg_optimize(TCGContext *s)
 
         CASE_OP_32_64(qemu_ld):
             {
-                TCGMemOpIdx oi = args[nb_oargs + nb_iargs];
+                TCGMemOpIdx oi = op->args[nb_oargs + nb_iargs];
                 TCGMemOp mop = get_memop(oi);
                 if (!(mop & MO_SIGN)) {
                     mask = (2ULL << ((8 << (mop & MO_SIZE)) - 1)) - 1;
@@ -976,12 +981,12 @@ void tcg_optimize(TCGContext *s)
 
         if (partmask == 0) {
             tcg_debug_assert(nb_oargs == 1);
-            tcg_opt_gen_movi(s, op, args, args[0], 0);
+            tcg_opt_gen_movi(s, op, op->args[0], 0);
             continue;
         }
         if (affected == 0) {
             tcg_debug_assert(nb_oargs == 1);
-            tcg_opt_gen_mov(s, op, args, args[0], args[1]);
+            tcg_opt_gen_mov(s, op, op->args[0], op->args[1]);
             continue;
         }
 
@@ -991,8 +996,8 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(mul):
         CASE_OP_32_64(muluh):
         CASE_OP_32_64(mulsh):
-            if ((temp_is_const(args[2]) && temps[args[2]].val == 0)) {
-                tcg_opt_gen_movi(s, op, args, args[0], 0);
+            if ((temp_is_const(op->args[2]) && temps[op->args[2]].val == 0)) {
+                tcg_opt_gen_movi(s, op, op->args[0], 0);
                 continue;
             }
             break;
@@ -1004,8 +1009,8 @@ void tcg_optimize(TCGContext *s)
         switch (opc) {
         CASE_OP_32_64(or):
         CASE_OP_32_64(and):
-            if (temps_are_copies(args[1], args[2])) {
-                tcg_opt_gen_mov(s, op, args, args[0], args[1]);
+            if (temps_are_copies(op->args[1], op->args[2])) {
+                tcg_opt_gen_mov(s, op, op->args[0], op->args[1]);
                 continue;
             }
             break;
@@ -1018,8 +1023,8 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(andc):
         CASE_OP_32_64(sub):
         CASE_OP_32_64(xor):
-            if (temps_are_copies(args[1], args[2])) {
-                tcg_opt_gen_movi(s, op, args, args[0], 0);
+            if (temps_are_copies(op->args[1], op->args[2])) {
+                tcg_opt_gen_movi(s, op, op->args[0], 0);
                 continue;
             }
             break;
@@ -1032,10 +1037,10 @@ void tcg_optimize(TCGContext *s)
            allocator where needed and possible.  Also detect copies. */
         switch (opc) {
         CASE_OP_32_64(mov):
-            tcg_opt_gen_mov(s, op, args, args[0], args[1]);
+            tcg_opt_gen_mov(s, op, op->args[0], op->args[1]);
             break;
         CASE_OP_32_64(movi):
-            tcg_opt_gen_movi(s, op, args, args[0], args[1]);
+            tcg_opt_gen_movi(s, op, op->args[0], op->args[1]);
             break;
 
         CASE_OP_32_64(not):
@@ -1051,9 +1056,9 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_extu_i32_i64:
         case INDEX_op_extrl_i64_i32:
         case INDEX_op_extrh_i64_i32:
-            if (temp_is_const(args[1])) {
-                tmp = do_constant_folding(opc, temps[args[1]].val, 0);
-                tcg_opt_gen_movi(s, op, args, args[0], tmp);
+            if (temp_is_const(op->args[1])) {
+                tmp = do_constant_folding(opc, temps[op->args[1]].val, 0);
+                tcg_opt_gen_movi(s, op, op->args[0], tmp);
                 break;
             }
             goto do_default;
@@ -1080,68 +1085,72 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(divu):
         CASE_OP_32_64(rem):
         CASE_OP_32_64(remu):
-            if (temp_is_const(args[1]) && temp_is_const(args[2])) {
-                tmp = do_constant_folding(opc, temps[args[1]].val,
-                                          temps[args[2]].val);
-                tcg_opt_gen_movi(s, op, args, args[0], tmp);
+            if (temp_is_const(op->args[1]) && temp_is_const(op->args[2])) {
+                tmp = do_constant_folding(opc, temps[op->args[1]].val,
+                                          temps[op->args[2]].val);
+                tcg_opt_gen_movi(s, op, op->args[0], tmp);
                 break;
             }
             goto do_default;
 
         CASE_OP_32_64(clz):
         CASE_OP_32_64(ctz):
-            if (temp_is_const(args[1])) {
-                TCGArg v = temps[args[1]].val;
+            if (temp_is_const(op->args[1])) {
+                TCGArg v = temps[op->args[1]].val;
                 if (v != 0) {
                     tmp = do_constant_folding(opc, v, 0);
-                    tcg_opt_gen_movi(s, op, args, args[0], tmp);
+                    tcg_opt_gen_movi(s, op, op->args[0], tmp);
                 } else {
-                    tcg_opt_gen_mov(s, op, args, args[0], args[2]);
+                    tcg_opt_gen_mov(s, op, op->args[0], op->args[2]);
                 }
                 break;
             }
             goto do_default;
 
         CASE_OP_32_64(deposit):
-            if (temp_is_const(args[1]) && temp_is_const(args[2])) {
-                tmp = deposit64(temps[args[1]].val, args[3], args[4],
-                                temps[args[2]].val);
-                tcg_opt_gen_movi(s, op, args, args[0], tmp);
+            if (temp_is_const(op->args[1]) && temp_is_const(op->args[2])) {
+                tmp = deposit64(temps[op->args[1]].val, op->args[3],
+                                op->args[4], temps[op->args[2]].val);
+                tcg_opt_gen_movi(s, op, op->args[0], tmp);
                 break;
             }
             goto do_default;
 
         CASE_OP_32_64(extract):
-            if (temp_is_const(args[1])) {
-                tmp = extract64(temps[args[1]].val, args[2], args[3]);
-                tcg_opt_gen_movi(s, op, args, args[0], tmp);
+            if (temp_is_const(op->args[1])) {
+                tmp = extract64(temps[op->args[1]].val,
+                                op->args[2], op->args[3]);
+                tcg_opt_gen_movi(s, op, op->args[0], tmp);
                 break;
             }
             goto do_default;
 
         CASE_OP_32_64(sextract):
-            if (temp_is_const(args[1])) {
-                tmp = sextract64(temps[args[1]].val, args[2], args[3]);
-                tcg_opt_gen_movi(s, op, args, args[0], tmp);
+            if (temp_is_const(op->args[1])) {
+                tmp = sextract64(temps[op->args[1]].val,
+                                 op->args[2], op->args[3]);
+                tcg_opt_gen_movi(s, op, op->args[0], tmp);
                 break;
             }
             goto do_default;
 
         CASE_OP_32_64(setcond):
-            tmp = do_constant_folding_cond(opc, args[1], args[2], args[3]);
+            tmp = do_constant_folding_cond(opc, op->args[1],
+                                           op->args[2], op->args[3]);
             if (tmp != 2) {
-                tcg_opt_gen_movi(s, op, args, args[0], tmp);
+                tcg_opt_gen_movi(s, op, op->args[0], tmp);
                 break;
             }
             goto do_default;
 
         CASE_OP_32_64(brcond):
-            tmp = do_constant_folding_cond(opc, args[0], args[1], args[2]);
+            tmp = do_constant_folding_cond(opc, op->args[0],
+                                           op->args[1], op->args[2]);
             if (tmp != 2) {
                 if (tmp) {
                     reset_all_temps(nb_temps);
                     op->opc = INDEX_op_br;
-                    args[0] = args[3];
+                    op->args[0] = op->args[3];
                 } else {
                     tcg_op_remove(s, op);
                 }
@@ -1150,21 +1159,22 @@ void tcg_optimize(TCGContext *s)
             goto do_default;
 
         CASE_OP_32_64(movcond):
-            tmp = do_constant_folding_cond(opc, args[1], args[2], args[5]);
+            tmp = do_constant_folding_cond(opc, op->args[1],
+                                           op->args[2], op->args[5]);
             if (tmp != 2) {
-                tcg_opt_gen_mov(s, op, args, args[0], args[4-tmp]);
+                tcg_opt_gen_mov(s, op, op->args[0], op->args[4-tmp]);
                 break;
             }
-            if (temp_is_const(args[3]) && temp_is_const(args[4])) {
-                tcg_target_ulong tv = temps[args[3]].val;
-                tcg_target_ulong fv = temps[args[4]].val;
-                TCGCond cond = args[5];
+            if (temp_is_const(op->args[3]) && temp_is_const(op->args[4])) {
+                tcg_target_ulong tv = temps[op->args[3]].val;
+                tcg_target_ulong fv = temps[op->args[4]].val;
+                TCGCond cond = op->args[5];
                 if (fv == 1 && tv == 0) {
                     cond = tcg_invert_cond(cond);
                 } else if (!(tv == 1 && fv == 0)) {
                     goto do_default;
                 }
-                args[3] = cond;
+                op->args[3] = cond;
                 op->opc = opc = (opc == INDEX_op_movcond_i32
                                  ? INDEX_op_setcond_i32
                                  : INDEX_op_setcond_i64);
@@ -1174,17 +1184,16 @@ void tcg_optimize(TCGContext *s)
 
         case INDEX_op_add2_i32:
         case INDEX_op_sub2_i32:
-            if (temp_is_const(args[2]) && temp_is_const(args[3])
-                && temp_is_const(args[4]) && temp_is_const(args[5])) {
-                uint32_t al = temps[args[2]].val;
-                uint32_t ah = temps[args[3]].val;
-                uint32_t bl = temps[args[4]].val;
-                uint32_t bh = temps[args[5]].val;
+            if (temp_is_const(op->args[2]) && temp_is_const(op->args[3])
+                && temp_is_const(op->args[4]) && temp_is_const(op->args[5])) {
+                uint32_t al = temps[op->args[2]].val;
+                uint32_t ah = temps[op->args[3]].val;
+                uint32_t bl = temps[op->args[4]].val;
+                uint32_t bh = temps[op->args[5]].val;
                 uint64_t a = ((uint64_t)ah << 32) | al;
                 uint64_t b = ((uint64_t)bh << 32) | bl;
                 TCGArg rl, rh;
                 TCGOp *op2 = tcg_op_insert_before(s, op, INDEX_op_movi_i32, 2);
-                TCGArg *args2 = op2->args;
 
                 if (opc == INDEX_op_add2_i32) {
                     a += b;
@@ -1192,10 +1201,10 @@ void tcg_optimize(TCGContext *s)
                     a -= b;
                 }
 
-                rl = args[0];
-                rh = args[1];
-                tcg_opt_gen_movi(s, op, args, rl, (int32_t)a);
-                tcg_opt_gen_movi(s, op2, args2, rh, (int32_t)(a >> 32));
+                rl = op->args[0];
+                rh = op->args[1];
+                tcg_opt_gen_movi(s, op, rl, (int32_t)a);
+                tcg_opt_gen_movi(s, op2, rh, (int32_t)(a >> 32));
 
                 /* We've done all we need to do with the movi.  Skip it.  */
                 oi_next = op2->next;
@@ -1204,18 +1213,17 @@ void tcg_optimize(TCGContext *s)
             goto do_default;
 
         case INDEX_op_mulu2_i32:
-            if (temp_is_const(args[2]) && temp_is_const(args[3])) {
-                uint32_t a = temps[args[2]].val;
-                uint32_t b = temps[args[3]].val;
+            if (temp_is_const(op->args[2]) && temp_is_const(op->args[3])) {
+                uint32_t a = temps[op->args[2]].val;
+                uint32_t b = temps[op->args[3]].val;
                 uint64_t r = (uint64_t)a * b;
                 TCGArg rl, rh;
                 TCGOp *op2 = tcg_op_insert_before(s, op, INDEX_op_movi_i32, 2);
-                TCGArg *args2 = op2->args;
 
-                rl = args[0];
-                rh = args[1];
-                tcg_opt_gen_movi(s, op, args, rl, (int32_t)r);
-                tcg_opt_gen_movi(s, op2, args2, rh, (int32_t)(r >> 32));
+                rl = op->args[0];
+                rh = op->args[1];
+                tcg_opt_gen_movi(s, op, rl, (int32_t)r);
+                tcg_opt_gen_movi(s, op2, rh, (int32_t)(r >> 32));
 
                 /* We've done all we need to do with the movi.  Skip it.  */
                 oi_next = op2->next;
@@ -1224,41 +1232,47 @@ void tcg_optimize(TCGContext *s)
             goto do_default;
 
         case INDEX_op_brcond2_i32:
-            tmp = do_constant_folding_cond2(&args[0], &args[2], args[4]);
+            tmp = do_constant_folding_cond2(&op->args[0], &op->args[2],
+                                            op->args[4]);
             if (tmp != 2) {
                 if (tmp) {
             do_brcond_true:
                     reset_all_temps(nb_temps);
                     op->opc = INDEX_op_br;
-                    args[0] = args[5];
+                    op->args[0] = op->args[5];
                 } else {
             do_brcond_false:
                     tcg_op_remove(s, op);
                 }
-            } else if ((args[4] == TCG_COND_LT || args[4] == TCG_COND_GE)
-                       && temp_is_const(args[2]) && temps[args[2]].val == 0
-                       && temp_is_const(args[3]) && temps[args[3]].val == 0) {
+            } else if ((op->args[4] == TCG_COND_LT
+                        || op->args[4] == TCG_COND_GE)
+                       && temp_is_const(op->args[2])
+                       && temps[op->args[2]].val == 0
+                       && temp_is_const(op->args[3])
+                       && temps[op->args[3]].val == 0) {
                 /* Simplify LT/GE comparisons vs zero to a single compare
                    vs the high word of the input.  */
             do_brcond_high:
                 reset_all_temps(nb_temps);
                 op->opc = INDEX_op_brcond_i32;
-                args[0] = args[1];
-                args[1] = args[3];
-                args[2] = args[4];
-                args[3] = args[5];
-            } else if (args[4] == TCG_COND_EQ) {
+                op->args[0] = op->args[1];
+                op->args[1] = op->args[3];
+                op->args[2] = op->args[4];
+                op->args[3] = op->args[5];
+            } else if (op->args[4] == TCG_COND_EQ) {
                 /* Simplify EQ comparisons where one of the pairs
                    can be simplified.  */
                 tmp = do_constant_folding_cond(INDEX_op_brcond_i32,
-                                               args[0], args[2], TCG_COND_EQ);
+                                               op->args[0], op->args[2],
+                                               TCG_COND_EQ);
                 if (tmp == 0) {
                     goto do_brcond_false;
                 } else if (tmp == 1) {
                     goto do_brcond_high;
                 }
                 tmp = do_constant_folding_cond(INDEX_op_brcond_i32,
-                                               args[1], args[3], TCG_COND_EQ);
+                                               op->args[1], op->args[3],
+                                               TCG_COND_EQ);
                 if (tmp == 0) {
                     goto do_brcond_false;
                 } else if (tmp != 1) {
@@ -1267,21 +1281,23 @@ void tcg_optimize(TCGContext *s)
             do_brcond_low:
                 reset_all_temps(nb_temps);
                 op->opc = INDEX_op_brcond_i32;
-                args[1] = args[2];
-                args[2] = args[4];
-                args[3] = args[5];
-            } else if (args[4] == TCG_COND_NE) {
+                op->args[1] = op->args[2];
+                op->args[2] = op->args[4];
+                op->args[3] = op->args[5];
+            } else if (op->args[4] == TCG_COND_NE) {
                 /* Simplify NE comparisons where one of the pairs
                    can be simplified.  */
                 tmp = do_constant_folding_cond(INDEX_op_brcond_i32,
-                                               args[0], args[2], TCG_COND_NE);
+                                               op->args[0], op->args[2],
+                                               TCG_COND_NE);
                 if (tmp == 0) {
                     goto do_brcond_high;
                 } else if (tmp == 1) {
                     goto do_brcond_true;
                 }
                 tmp = do_constant_folding_cond(INDEX_op_brcond_i32,
-                                               args[1], args[3], TCG_COND_NE);
+                                               op->args[1], op->args[3],
+                                               TCG_COND_NE);
                 if (tmp == 0) {
                     goto do_brcond_low;
                 } else if (tmp == 1) {
@@ -1294,57 +1310,65 @@ void tcg_optimize(TCGContext *s)
             break;
 
         case INDEX_op_setcond2_i32:
-            tmp = do_constant_folding_cond2(&args[1], &args[3], args[5]);
+            tmp = do_constant_folding_cond2(&op->args[1], &op->args[3],
+                                            op->args[5]);
             if (tmp != 2) {
             do_setcond_const:
-                tcg_opt_gen_movi(s, op, args, args[0], tmp);
-            } else if ((args[5] == TCG_COND_LT || args[5] == TCG_COND_GE)
-                       && temp_is_const(args[3]) && temps[args[3]].val == 0
-                       && temp_is_const(args[4]) && temps[args[4]].val == 0) {
+                tcg_opt_gen_movi(s, op, op->args[0], tmp);
+            } else if ((op->args[5] == TCG_COND_LT
+                        || op->args[5] == TCG_COND_GE)
+                       && temp_is_const(op->args[3])
+                       && temps[op->args[3]].val == 0
+                       && temp_is_const(op->args[4])
+                       && temps[op->args[4]].val == 0) {
                 /* Simplify LT/GE comparisons vs zero to a single compare
                    vs the high word of the input.  */
             do_setcond_high:
-                reset_temp(args[0]);
-                temps[args[0]].mask = 1;
+                reset_temp(op->args[0]);
+                temps[op->args[0]].mask = 1;
                 op->opc = INDEX_op_setcond_i32;
-                args[1] = args[2];
-                args[2] = args[4];
-                args[3] = args[5];
-            } else if (args[5] == TCG_COND_EQ) {
+                op->args[1] = op->args[2];
+                op->args[2] = op->args[4];
+                op->args[3] = op->args[5];
+            } else if (op->args[5] == TCG_COND_EQ) {
                 /* Simplify EQ comparisons where one of the pairs
                    can be simplified.  */
                 tmp = do_constant_folding_cond(INDEX_op_setcond_i32,
-                                               args[1], args[3], TCG_COND_EQ);
+                                               op->args[1], op->args[3],
+                                               TCG_COND_EQ);
                 if (tmp == 0) {
                     goto do_setcond_const;
                 } else if (tmp == 1) {
                     goto do_setcond_high;
                 }
                 tmp = do_constant_folding_cond(INDEX_op_setcond_i32,
-                                               args[2], args[4], TCG_COND_EQ);
+                                               op->args[2], op->args[4],
+                                               TCG_COND_EQ);
                 if (tmp == 0) {
                     goto do_setcond_high;
                 } else if (tmp != 1) {
                     goto do_default;
                 }
             do_setcond_low:
-                reset_temp(args[0]);
-                temps[args[0]].mask = 1;
+                reset_temp(op->args[0]);
+                temps[op->args[0]].mask = 1;
                 op->opc = INDEX_op_setcond_i32;
-                args[2] = args[3];
-                args[3] = args[5];
-            } else if (args[5] == TCG_COND_NE) {
+                op->args[2] = op->args[3];
+                op->args[3] = op->args[5];
+            } else if (op->args[5] == TCG_COND_NE) {
                 /* Simplify NE comparisons where one of the pairs
                    can be simplified.  */
                 tmp = do_constant_folding_cond(INDEX_op_setcond_i32,
-                                               args[1], args[3], TCG_COND_NE);
+                                               op->args[1], op->args[3],
+                                               TCG_COND_NE);
                 if (tmp == 0) {
                     goto do_setcond_high;
                 } else if (tmp == 1) {
                     goto do_setcond_const;
                 }
                 tmp = do_constant_folding_cond(INDEX_op_setcond_i32,
-                                               args[2], args[4], TCG_COND_NE);
+                                               op->args[2], op->args[4],
+                                               TCG_COND_NE);
                 if (tmp == 0) {
                     goto do_setcond_low;
                 } else if (tmp == 1) {
@@ -1357,7 +1381,7 @@ void tcg_optimize(TCGContext *s)
             break;
 
         case INDEX_op_call:
-            if (!(args[nb_oargs + nb_iargs + 1]
+            if (!(op->args[nb_oargs + nb_iargs + 1]
                   & (TCG_CALL_NO_READ_GLOBALS | TCG_CALL_NO_WRITE_GLOBALS))) {
                 for (i = 0; i < nb_globals; i++) {
                     if (test_bit(i, temps_used.l)) {
@@ -1379,11 +1403,11 @@ void tcg_optimize(TCGContext *s)
             } else {
         do_reset_output:
                 for (i = 0; i < nb_oargs; i++) {
-                    reset_temp(args[i]);
+                    reset_temp(op->args[i]);
                     /* Save the corresponding known-zero bits mask for the
                        first output argument (only one supported so far). */
                     if (i == 0) {
-                        temps[args[i]].mask = mask;
+                        temps[op->args[i]].mask = mask;
                     }
                 }
             }
@@ -1391,7 +1415,7 @@ void tcg_optimize(TCGContext *s)
         }
 
         /* Eliminate duplicate and redundant fence instructions.  */
-        if (prev_mb_args) {
+        if (prev_mb) {
             switch (opc) {
             case INDEX_op_mb:
                 /* Merge two barriers of the same type into one,
@@ -1405,7 +1429,7 @@ void tcg_optimize(TCGContext *s)
                  * barrier.  This is stricter than specified but for
                  * the purposes of TCG is better than not optimizing.
                  */
-                prev_mb_args[0] |= args[0];
+                prev_mb->args[0] |= op->args[0];
                 tcg_op_remove(s, op);
                 break;
 
@@ -1421,11 +1445,11 @@ void tcg_optimize(TCGContext *s)
             case INDEX_op_qemu_st_i64:
             case INDEX_op_call:
                 /* Opcodes that touch guest memory stop the optimization.  */
-                prev_mb_args = NULL;
+                prev_mb = NULL;
                 break;
             }
         } else if (opc == INDEX_op_mb) {
-            prev_mb_args = args;
+            prev_mb = op;
         }
     }
 }
-- 
2.13.6
