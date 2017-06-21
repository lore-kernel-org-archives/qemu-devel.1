Received: from eggs.gnu.org ([2001:4830:134:3::10]:33837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVhB-0006Ph-5w
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVh9-0002KG-79
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:41 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNVh9-0002Jk-0o
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:39 -0400
Received: by mail-qt0-x244.google.com with SMTP id x58so25652893qtc.2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 19:48:38 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 20 Jun 2017 19:48:16 -0700
Message-Id: <20170621024831.26019-2-rth@twiddle.net>
In-Reply-To: <20170621024831.26019-1-rth@twiddle.net>
References: <20170621024831.26019-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 01/16] tcg: Merge opcode arguments into TCGOp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net

Rather than have a separate buffer of 10*max_ops entries,
give each opcode 10 entries.  The result is actually a bit
smaller and should have slightly more cache locality.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/optimize.c |  6 ++--
 tcg/tcg-op.c   | 99 +++++++++++++++++++++-------------------------------------
 tcg/tcg.c      | 98 ++++++++++++++++++++++++++-------------------------------
 tcg/tcg.h      | 33 +++++++-------------
 4 files changed, 94 insertions(+), 142 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index adfc56c..002aad6 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -576,7 +576,7 @@ void tcg_optimize(TCGContext *s)
         TCGArg tmp;
 
         TCGOp * const op = &s->gen_op_buf[oi];
-        TCGArg * const args = &s->gen_opparam_buf[op->args];
+        TCGArg * const args = op->args;
         TCGOpcode opc = op->opc;
         const TCGOpDef *def = &tcg_op_defs[opc];
 
@@ -1184,7 +1184,7 @@ void tcg_optimize(TCGContext *s)
                 uint64_t b = ((uint64_t)bh << 32) | bl;
                 TCGArg rl, rh;
                 TCGOp *op2 = tcg_op_insert_before(s, op, INDEX_op_movi_i32, 2);
-                TCGArg *args2 = &s->gen_opparam_buf[op2->args];
+                TCGArg *args2 = op2->args;
 
                 if (opc == INDEX_op_add2_i32) {
                     a += b;
@@ -1210,7 +1210,7 @@ void tcg_optimize(TCGContext *s)
                 uint64_t r = (uint64_t)a * b;
                 TCGArg rl, rh;
                 TCGOp *op2 = tcg_op_insert_before(s, op, INDEX_op_movi_i32, 2);
-                TCGArg *args2 = &s->gen_opparam_buf[op2->args];
+                TCGArg *args2 = op2->args;
 
                 rl = args[0];
                 rh = args[1];
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 87f673e..3a627c1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -45,107 +45,78 @@ extern TCGv_i32 TCGV_HIGH_link_error(TCGv_i64);
    Up to and including filling in the forward link immediately.  We'll do
    proper termination of the end of the list after we finish translation.  */
 
-static void tcg_emit_op(TCGContext *ctx, TCGOpcode opc, int args)
+static inline TCGOp *tcg_emit_op(TCGContext *ctx, TCGOpcode opc)
 {
     int oi = ctx->gen_next_op_idx;
     int ni = oi + 1;
     int pi = oi - 1;
+    TCGOp *op = &ctx->gen_op_buf[oi];
 
     tcg_debug_assert(oi < OPC_BUF_SIZE);
     ctx->gen_op_buf[0].prev = oi;
     ctx->gen_next_op_idx = ni;
 
-    ctx->gen_op_buf[oi] = (TCGOp){
-        .opc = opc,
-        .args = args,
-        .prev = pi,
-        .next = ni
-    };
+    memset(op, 0, offsetof(TCGOp, args));
+    op->opc = opc;
+    op->prev = pi;
+    op->next = ni;
+
+    return op;
 }
 
 void tcg_gen_op1(TCGContext *ctx, TCGOpcode opc, TCGArg a1)
 {
-    int pi = ctx->gen_next_parm_idx;
-
-    tcg_debug_assert(pi + 1 <= OPPARAM_BUF_SIZE);
-    ctx->gen_next_parm_idx = pi + 1;
-    ctx->gen_opparam_buf[pi] = a1;
-
-    tcg_emit_op(ctx, opc, pi);
+    TCGOp *op = tcg_emit_op(ctx, opc);
+    op->args[0] = a1;
 }
 
 void tcg_gen_op2(TCGContext *ctx, TCGOpcode opc, TCGArg a1, TCGArg a2)
 {
-    int pi = ctx->gen_next_parm_idx;
-
-    tcg_debug_assert(pi + 2 <= OPPARAM_BUF_SIZE);
-    ctx->gen_next_parm_idx = pi + 2;
-    ctx->gen_opparam_buf[pi + 0] = a1;
-    ctx->gen_opparam_buf[pi + 1] = a2;
-
-    tcg_emit_op(ctx, opc, pi);
+    TCGOp *op = tcg_emit_op(ctx, opc);
+    op->args[0] = a1;
+    op->args[1] = a2;
 }
 
 void tcg_gen_op3(TCGContext *ctx, TCGOpcode opc, TCGArg a1,
                  TCGArg a2, TCGArg a3)
 {
-    int pi = ctx->gen_next_parm_idx;
-
-    tcg_debug_assert(pi + 3 <= OPPARAM_BUF_SIZE);
-    ctx->gen_next_parm_idx = pi + 3;
-    ctx->gen_opparam_buf[pi + 0] = a1;
-    ctx->gen_opparam_buf[pi + 1] = a2;
-    ctx->gen_opparam_buf[pi + 2] = a3;
-
-    tcg_emit_op(ctx, opc, pi);
+    TCGOp *op = tcg_emit_op(ctx, opc);
+    op->args[0] = a1;
+    op->args[1] = a2;
+    op->args[2] = a3;
 }
 
 void tcg_gen_op4(TCGContext *ctx, TCGOpcode opc, TCGArg a1,
                  TCGArg a2, TCGArg a3, TCGArg a4)
 {
-    int pi = ctx->gen_next_parm_idx;
-
-    tcg_debug_assert(pi + 4 <= OPPARAM_BUF_SIZE);
-    ctx->gen_next_parm_idx = pi + 4;
-    ctx->gen_opparam_buf[pi + 0] = a1;
-    ctx->gen_opparam_buf[pi + 1] = a2;
-    ctx->gen_opparam_buf[pi + 2] = a3;
-    ctx->gen_opparam_buf[pi + 3] = a4;
-
-    tcg_emit_op(ctx, opc, pi);
+    TCGOp *op = tcg_emit_op(ctx, opc);
+    op->args[0] = a1;
+    op->args[1] = a2;
+    op->args[2] = a3;
+    op->args[3] = a4;
 }
 
 void tcg_gen_op5(TCGContext *ctx, TCGOpcode opc, TCGArg a1,
                  TCGArg a2, TCGArg a3, TCGArg a4, TCGArg a5)
 {
-    int pi = ctx->gen_next_parm_idx;
-
-    tcg_debug_assert(pi + 5 <= OPPARAM_BUF_SIZE);
-    ctx->gen_next_parm_idx = pi + 5;
-    ctx->gen_opparam_buf[pi + 0] = a1;
-    ctx->gen_opparam_buf[pi + 1] = a2;
-    ctx->gen_opparam_buf[pi + 2] = a3;
-    ctx->gen_opparam_buf[pi + 3] = a4;
-    ctx->gen_opparam_buf[pi + 4] = a5;
-
-    tcg_emit_op(ctx, opc, pi);
+    TCGOp *op = tcg_emit_op(ctx, opc);
+    op->args[0] = a1;
+    op->args[1] = a2;
+    op->args[2] = a3;
+    op->args[3] = a4;
+    op->args[4] = a5;
 }
 
 void tcg_gen_op6(TCGContext *ctx, TCGOpcode opc, TCGArg a1, TCGArg a2,
                  TCGArg a3, TCGArg a4, TCGArg a5, TCGArg a6)
 {
-    int pi = ctx->gen_next_parm_idx;
-
-    tcg_debug_assert(pi + 6 <= OPPARAM_BUF_SIZE);
-    ctx->gen_next_parm_idx = pi + 6;
-    ctx->gen_opparam_buf[pi + 0] = a1;
-    ctx->gen_opparam_buf[pi + 1] = a2;
-    ctx->gen_opparam_buf[pi + 2] = a3;
-    ctx->gen_opparam_buf[pi + 3] = a4;
-    ctx->gen_opparam_buf[pi + 4] = a5;
-    ctx->gen_opparam_buf[pi + 5] = a6;
-
-    tcg_emit_op(ctx, opc, pi);
+    TCGOp *op = tcg_emit_op(ctx, opc);
+    op->args[0] = a1;
+    op->args[1] = a2;
+    op->args[2] = a3;
+    op->args[3] = a4;
+    op->args[4] = a5;
+    op->args[5] = a6;
 }
 
 void tcg_gen_mb(TCGBar mb_type)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 3559829..298aa0c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -469,7 +469,6 @@ void tcg_func_start(TCGContext *s)
     s->gen_op_buf[0].next = 1;
     s->gen_op_buf[0].prev = 0;
     s->gen_next_op_idx = 1;
-    s->gen_next_parm_idx = 0;
 
     s->be = tcg_malloc(sizeof(TCGBackendData));
 }
@@ -757,9 +756,10 @@ int tcg_check_temp_count(void)
 void tcg_gen_callN(TCGContext *s, void *func, TCGArg ret,
                    int nargs, TCGArg *args)
 {
-    int i, real_args, nb_rets, pi, pi_first;
+    int i, real_args, nb_rets, pi;
     unsigned sizemask, flags;
     TCGHelperInfo *info;
+    TCGOp *op;
 
     info = g_hash_table_lookup(s->helpers, (gpointer)func);
     flags = info->flags;
@@ -772,11 +772,11 @@ void tcg_gen_callN(TCGContext *s, void *func, TCGArg ret,
     int orig_sizemask = sizemask;
     int orig_nargs = nargs;
     TCGv_i64 retl, reth;
+    TCGArg split_args[MAX_OPC_PARAM];
 
     TCGV_UNUSED_I64(retl);
     TCGV_UNUSED_I64(reth);
     if (sizemask != 0) {
-        TCGArg *split_args = __builtin_alloca(sizeof(TCGArg) * nargs * 2);
         for (i = real_args = 0; i < nargs; ++i) {
             int is_64bit = sizemask & (1 << (i+1)*2);
             if (is_64bit) {
@@ -811,7 +811,19 @@ void tcg_gen_callN(TCGContext *s, void *func, TCGArg ret,
     }
 #endif /* TCG_TARGET_EXTEND_ARGS */
 
-    pi_first = pi = s->gen_next_parm_idx;
+    i = s->gen_next_op_idx;
+    tcg_debug_assert(i < OPC_BUF_SIZE);
+    s->gen_op_buf[0].prev = i;
+    s->gen_next_op_idx = i + 1;
+    op = &s->gen_op_buf[i];
+
+    /* Set links for sequential allocation during translation.  */
+    memset(op, 0, offsetof(TCGOp, args));
+    op->opc = INDEX_op_call;
+    op->prev = i - 1;
+    op->next = i + 1;
+
+    pi = 0;
     if (ret != TCG_CALL_DUMMY_ARG) {
 #if defined(__sparc__) && !defined(__arch64__) \
     && !defined(CONFIG_TCG_INTERPRETER)
@@ -821,31 +833,33 @@ void tcg_gen_callN(TCGContext *s, void *func, TCGArg ret,
                two return temporaries, and reassemble below.  */
             retl = tcg_temp_new_i64();
             reth = tcg_temp_new_i64();
-            s->gen_opparam_buf[pi++] = GET_TCGV_I64(reth);
-            s->gen_opparam_buf[pi++] = GET_TCGV_I64(retl);
+            op->args[pi++] = GET_TCGV_I64(reth);
+            op->args[pi++] = GET_TCGV_I64(retl);
             nb_rets = 2;
         } else {
-            s->gen_opparam_buf[pi++] = ret;
+            op->args[pi++] = ret;
             nb_rets = 1;
         }
 #else
         if (TCG_TARGET_REG_BITS < 64 && (sizemask & 1)) {
 #ifdef HOST_WORDS_BIGENDIAN
-            s->gen_opparam_buf[pi++] = ret + 1;
-            s->gen_opparam_buf[pi++] = ret;
+            op->args[pi++] = ret + 1;
+            op->args[pi++] = ret;
 #else
-            s->gen_opparam_buf[pi++] = ret;
-            s->gen_opparam_buf[pi++] = ret + 1;
+            op->args[pi++] = ret;
+            op->args[pi++] = ret + 1;
 #endif
             nb_rets = 2;
         } else {
-            s->gen_opparam_buf[pi++] = ret;
+            op->args[pi++] = ret;
             nb_rets = 1;
         }
 #endif
     } else {
         nb_rets = 0;
     }
+    op->callo = nb_rets;
+
     real_args = 0;
     for (i = 0; i < nargs; i++) {
         int is_64bit = sizemask & (1 << (i+1)*2);
@@ -853,7 +867,7 @@ void tcg_gen_callN(TCGContext *s, void *func, TCGArg ret,
 #ifdef TCG_TARGET_CALL_ALIGN_ARGS
             /* some targets want aligned 64 bit args */
             if (real_args & 1) {
-                s->gen_opparam_buf[pi++] = TCG_CALL_DUMMY_ARG;
+                op->args[pi++] = TCG_CALL_DUMMY_ARG;
                 real_args++;
             }
 #endif
@@ -868,42 +882,26 @@ void tcg_gen_callN(TCGContext *s, void *func, TCGArg ret,
               have to get more complicated to differentiate between
               stack arguments and register arguments.  */
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TCG_TARGET_STACK_GROWSUP)
-            s->gen_opparam_buf[pi++] = args[i] + 1;
-            s->gen_opparam_buf[pi++] = args[i];
+            op->args[pi++] = args[i] + 1;
+            op->args[pi++] = args[i];
 #else
-            s->gen_opparam_buf[pi++] = args[i];
-            s->gen_opparam_buf[pi++] = args[i] + 1;
+            op->args[pi++] = args[i];
+            op->args[pi++] = args[i] + 1;
 #endif
             real_args += 2;
             continue;
         }
 
-        s->gen_opparam_buf[pi++] = args[i];
+        op->args[pi++] = args[i];
         real_args++;
     }
-    s->gen_opparam_buf[pi++] = (uintptr_t)func;
-    s->gen_opparam_buf[pi++] = flags;
+    op->args[pi++] = (uintptr_t)func;
+    op->args[pi++] = flags;
+    op->calli = real_args;
 
-    i = s->gen_next_op_idx;
-    tcg_debug_assert(i < OPC_BUF_SIZE);
-    tcg_debug_assert(pi <= OPPARAM_BUF_SIZE);
-
-    /* Set links for sequential allocation during translation.  */
-    s->gen_op_buf[i] = (TCGOp){
-        .opc = INDEX_op_call,
-        .callo = nb_rets,
-        .calli = real_args,
-        .args = pi_first,
-        .prev = i - 1,
-        .next = i + 1
-    };
-
-    /* Make sure the calli field didn't overflow.  */
-    tcg_debug_assert(s->gen_op_buf[i].calli == real_args);
-
-    s->gen_op_buf[0].prev = i;
-    s->gen_next_op_idx = i + 1;
-    s->gen_next_parm_idx = pi;
+    /* Make sure the fields didn't overflow.  */
+    tcg_debug_assert(op->calli == real_args);
+    tcg_debug_assert(pi <= ARRAY_SIZE(op->args));
 
 #if defined(__sparc__) && !defined(__arch64__) \
     && !defined(CONFIG_TCG_INTERPRETER)
@@ -1063,7 +1061,7 @@ void tcg_dump_ops(TCGContext *s)
         op = &s->gen_op_buf[oi];
         c = op->opc;
         def = &tcg_op_defs[c];
-        args = &s->gen_opparam_buf[op->args];
+        args = op->args;
 
         if (c == INDEX_op_insn_start) {
             col += qemu_log("%s ----", oi != s->gen_op_buf[0].next ? "\n" : "");
@@ -1347,20 +1345,16 @@ TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *old_op,
                             TCGOpcode opc, int nargs)
 {
     int oi = s->gen_next_op_idx;
-    int pi = s->gen_next_parm_idx;
     int prev = old_op->prev;
     int next = old_op - s->gen_op_buf;
     TCGOp *new_op;
 
     tcg_debug_assert(oi < OPC_BUF_SIZE);
-    tcg_debug_assert(pi + nargs <= OPPARAM_BUF_SIZE);
     s->gen_next_op_idx = oi + 1;
-    s->gen_next_parm_idx = pi + nargs;
 
     new_op = &s->gen_op_buf[oi];
     *new_op = (TCGOp){
         .opc = opc,
-        .args = pi,
         .prev = prev,
         .next = next
     };
@@ -1374,20 +1368,16 @@ TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *old_op,
                            TCGOpcode opc, int nargs)
 {
     int oi = s->gen_next_op_idx;
-    int pi = s->gen_next_parm_idx;
     int prev = old_op - s->gen_op_buf;
     int next = old_op->next;
     TCGOp *new_op;
 
     tcg_debug_assert(oi < OPC_BUF_SIZE);
-    tcg_debug_assert(pi + nargs <= OPPARAM_BUF_SIZE);
     s->gen_next_op_idx = oi + 1;
-    s->gen_next_parm_idx = pi + nargs;
 
     new_op = &s->gen_op_buf[oi];
     *new_op = (TCGOp){
         .opc = opc,
-        .args = pi,
         .prev = prev,
         .next = next
     };
@@ -1443,7 +1433,7 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
         TCGArg arg;
 
         TCGOp * const op = &s->gen_op_buf[oi];
-        TCGArg * const args = &s->gen_opparam_buf[op->args];
+        TCGArg * const args = op->args;
         TCGOpcode opc = op->opc;
         const TCGOpDef *def = &tcg_op_defs[opc];
 
@@ -1681,7 +1671,7 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
 
     for (oi = s->gen_op_buf[0].next; oi != 0; oi = oi_next) {
         TCGOp *op = &s->gen_op_buf[oi];
-        TCGArg *args = &s->gen_opparam_buf[op->args];
+        TCGArg *args = op->args;
         TCGOpcode opc = op->opc;
         const TCGOpDef *def = &tcg_op_defs[opc];
         TCGLifeData arg_life = op->life;
@@ -1724,7 +1714,7 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
                                       ? INDEX_op_ld_i32
                                       : INDEX_op_ld_i64);
                     TCGOp *lop = tcg_op_insert_before(s, op, lopc, 3);
-                    TCGArg *largs = &s->gen_opparam_buf[lop->args];
+                    TCGArg *largs = lop->args;
 
                     largs[0] = dir;
                     largs[1] = temp_idx(s, its->mem_base);
@@ -1796,7 +1786,7 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
                                   ? INDEX_op_st_i32
                                   : INDEX_op_st_i64);
                 TCGOp *sop = tcg_op_insert_after(s, op, sopc, 3);
-                TCGArg *sargs = &s->gen_opparam_buf[sop->args];
+                TCGArg *sargs = sop->args;
 
                 sargs[0] = dir;
                 sargs[1] = temp_idx(s, its->mem_base);
@@ -2624,7 +2614,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     num_insns = -1;
     for (oi = s->gen_op_buf[0].next; oi != 0; oi = oi_next) {
         TCGOp * const op = &s->gen_op_buf[oi];
-        TCGArg * const args = &s->gen_opparam_buf[op->args];
+        TCGArg * const args = op->args;
         TCGOpcode opc = op->opc;
         const TCGOpDef *def = &tcg_op_defs[opc];
         TCGLifeData arg_life = op->life;
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 9e37722..720e04e 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -51,8 +51,6 @@
 #define OPC_BUF_SIZE 640
 #define OPC_MAX_SIZE (OPC_BUF_SIZE - MAX_OP_PER_INSTR)
 
-#define OPPARAM_BUF_SIZE (OPC_BUF_SIZE * MAX_OPC_PARAM)
-
 #define CPU_TEMP_BUF_NLONGS 128
 
 /* Default target word size to pointer size.  */
@@ -613,33 +611,29 @@ typedef struct TCGTempSet {
 #define SYNC_ARG  1
 typedef uint16_t TCGLifeData;
 
-/* The layout here is designed to avoid crossing of a 32-bit boundary.
-   If we do so, gcc adds padding, expanding the size to 12.  */
+/* The layout here is designed to avoid crossing of a 32-bit boundary.  */
 typedef struct TCGOp {
     TCGOpcode opc   : 8;        /*  8 */
 
-    /* Index of the prev/next op, or 0 for the end of the list.  */
-    unsigned prev   : 10;       /* 18 */
-    unsigned next   : 10;       /* 28 */
-
     /* The number of out and in parameter for a call.  */
-    unsigned calli  : 4;        /* 32 */
-    unsigned callo  : 2;        /* 34 */
+    unsigned calli  : 4;        /* 12 */
+    unsigned callo  : 2;        /* 14 */
+    unsigned        : 2;        /* 16 */
 
-    /* Index of the arguments for this op, or 0 for zero-operand ops.  */
-    unsigned args   : 14;       /* 48 */
+    /* Index of the prev/next op, or 0 for the end of the list.  */
+    unsigned prev   : 16;       /* 32 */
+    unsigned next   : 16;       /* 48 */
 
     /* Lifetime data of the operands.  */
     unsigned life   : 16;       /* 64 */
+
+    /* Arguments for the opcode.  */
+    TCGArg args[MAX_OPC_PARAM];
 } TCGOp;
 
 /* Make sure operands fit in the bitfields above.  */
 QEMU_BUILD_BUG_ON(NB_OPS > (1 << 8));
-QEMU_BUILD_BUG_ON(OPC_BUF_SIZE > (1 << 10));
-QEMU_BUILD_BUG_ON(OPPARAM_BUF_SIZE > (1 << 14));
-
-/* Make sure that we don't overflow 64 bits without noticing.  */
-QEMU_BUILD_BUG_ON(sizeof(TCGOp) > 8);
+QEMU_BUILD_BUG_ON(OPC_BUF_SIZE > (1 << 16));
 
 struct TCGContext {
     uint8_t *pool_cur, *pool_end;
@@ -691,7 +685,6 @@ struct TCGContext {
 #endif
 
     int gen_next_op_idx;
-    int gen_next_parm_idx;
 
     /* Code generation.  Note that we specifically do not use tcg_insn_unit
        here, because there's too much arithmetic throughout that relies
@@ -723,7 +716,6 @@ struct TCGContext {
     TCGTemp *reg_to_temp[TCG_TARGET_NB_REGS];
 
     TCGOp gen_op_buf[OPC_BUF_SIZE];
-    TCGArg gen_opparam_buf[OPPARAM_BUF_SIZE];
 
     uint16_t gen_insn_end_off[TCG_MAX_INSNS];
     target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
@@ -734,8 +726,7 @@ extern bool parallel_cpus;
 
 static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)
 {
-    int op_argi = tcg_ctx.gen_op_buf[op_idx].args;
-    tcg_ctx.gen_opparam_buf[op_argi + arg] = v;
+    tcg_ctx.gen_op_buf[op_idx].args[arg] = v;
 }
 
 /* The number of opcodes emitted so far.  */
-- 
2.9.4
