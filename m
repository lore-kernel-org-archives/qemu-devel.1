Received: from eggs.gnu.org ([208.118.235.92]:51015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtoJ-0000WC-RL
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 16:00:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtoH-0002Gi-T4
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 16:00:19 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:33767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtoF-0002DK-Sz
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 16:00:17 -0500
Received: by mail-pl1-x633.google.com with SMTP id z23so6818468plo.0
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 13:00:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:28 +1100
Message-Id: <20181225205529.10874-42-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 41/42] tcg: Record register preferences during
 liveness
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

With these preferences, we can arrange for function call arguments to
be computed into the proper registers instead of requiring extra moves.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 197 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 165 insertions(+), 32 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index d40edb4f57..5f8c09b0b4 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2365,6 +2365,21 @@ static void reachable_code_pass(TCGContext *s)
 #define IS_DEAD_ARG(n)   (arg_life & (DEAD_ARG << (n)))
 #define NEED_SYNC_ARG(n) (arg_life & (SYNC_ARG << (n)))
 
+/* For liveness_pass_1, the register preferences for a given temp.  */
+static inline TCGRegSet *la_temp_pref(TCGTemp *ts)
+{
+    return ts->state_ptr;
+}
+
+/* For liveness_pass_1, reset the preferences for a given temp to the
+ * maximal regset for its type.
+ */
+static inline void la_reset_pref(TCGTemp *ts)
+{
+    *la_temp_pref(ts)
+        = (ts->state == TS_DEAD ? 0 : tcg_target_available_regs[ts->type]);
+}
+
 /* liveness analysis: end of function: all temps are dead, and globals
    should be in memory. */
 static void la_func_end(TCGContext *s, int ng, int nt)
@@ -2373,9 +2388,11 @@ static void la_func_end(TCGContext *s, int ng, int nt)
 
     for (i = 0; i < ng; ++i) {
         s->temps[i].state = TS_DEAD | TS_MEM;
+        la_reset_pref(&s->temps[i]);
     }
     for (i = ng; i < nt; ++i) {
         s->temps[i].state = TS_DEAD;
+        la_reset_pref(&s->temps[i]);
     }
 }
 
@@ -2387,11 +2404,13 @@ static void la_bb_end(TCGContext *s, int ng, int nt)
 
     for (i = 0; i < ng; ++i) {
         s->temps[i].state = TS_DEAD | TS_MEM;
+        la_reset_pref(&s->temps[i]);
     }
     for (i = ng; i < nt; ++i) {
         s->temps[i].state = (s->temps[i].temp_local
                              ? TS_DEAD | TS_MEM
                              : TS_DEAD);
+        la_reset_pref(&s->temps[i]);
     }
 }
 
@@ -2401,7 +2420,12 @@ static void la_global_sync(TCGContext *s, int ng)
     int i;
 
     for (i = 0; i < ng; ++i) {
-        s->temps[i].state |= TS_MEM;
+        int state = s->temps[i].state;
+        s->temps[i].state = state | TS_MEM;
+        if (state == TS_DEAD) {
+            /* If the global was previously dead, reset prefs.  */
+            la_reset_pref(&s->temps[i]);
+        }
     }
 }
 
@@ -2412,6 +2436,29 @@ static void la_global_kill(TCGContext *s, int ng)
 
     for (i = 0; i < ng; i++) {
         s->temps[i].state = TS_DEAD | TS_MEM;
+        la_reset_pref(&s->temps[i]);
+    }
+}
+
+/* liveness analysis: note live globals crossing calls.  */
+static void la_cross_call(TCGContext *s, int nt)
+{
+    TCGRegSet mask = ~tcg_target_call_clobber_regs;
+    int i;
+
+    for (i = 0; i < nt; i++) {
+        TCGTemp *ts = &s->temps[i];
+        if (!(ts->state & TS_DEAD)) {
+            TCGRegSet *pset = la_temp_pref(ts);
+            TCGRegSet set = *pset;
+
+            set &= mask;
+            /* If the combination is not possible, restart.  */
+            if (set == 0) {
+                set = tcg_target_available_regs[ts->type] & mask;
+            }
+            *pset = set;
+        }
     }
 }
 
@@ -2423,16 +2470,23 @@ static void liveness_pass_1(TCGContext *s)
     int nb_globals = s->nb_globals;
     int nb_temps = s->nb_temps;
     TCGOp *op, *op_prev;
+    TCGRegSet *prefs;
+    int i;
+
+    prefs = tcg_malloc(sizeof(TCGRegSet) * nb_temps);
+    for (i = 0; i < nb_temps; ++i) {
+        s->temps[i].state_ptr = prefs + i;
+    }
 
     /* ??? Should be redundant with the exit_tb that ends the TB.  */
     la_func_end(s, nb_globals, nb_temps);
 
     QTAILQ_FOREACH_REVERSE_SAFE(op, &s->ops, TCGOpHead, link, op_prev) {
-        int i, nb_iargs, nb_oargs;
+        int nb_iargs, nb_oargs;
         TCGOpcode opc_new, opc_new2;
         bool have_opc_new2;
         TCGLifeData arg_life = 0;
-        TCGTemp *arg_ts;
+        TCGTemp *ts;
         TCGOpcode opc = op->opc;
         const TCGOpDef *def = &tcg_op_defs[opc];
 
@@ -2440,6 +2494,7 @@ static void liveness_pass_1(TCGContext *s)
         case INDEX_op_call:
             {
                 int call_flags;
+                int nb_call_regs;
 
                 nb_oargs = TCGOP_CALLO(op);
                 nb_iargs = TCGOP_CALLI(op);
@@ -2448,8 +2503,8 @@ static void liveness_pass_1(TCGContext *s)
                 /* pure functions can be removed if their result is unused */
                 if (call_flags & TCG_CALL_NO_SIDE_EFFECTS) {
                     for (i = 0; i < nb_oargs; i++) {
-                        arg_ts = arg_temp(op->args[i]);
-                        if (arg_ts->state != TS_DEAD) {
+                        ts = arg_temp(op->args[i]);
+                        if (ts->state != TS_DEAD) {
                             goto do_not_remove_call;
                         }
                     }
@@ -2457,16 +2512,20 @@ static void liveness_pass_1(TCGContext *s)
                 }
             do_not_remove_call:
 
-                /* output args are dead */
+                /* Output args are dead.  */
                 for (i = 0; i < nb_oargs; i++) {
-                    arg_ts = arg_temp(op->args[i]);
-                    if (arg_ts->state & TS_DEAD) {
+                    ts = arg_temp(op->args[i]);
+                    if (ts->state & TS_DEAD) {
                         arg_life |= DEAD_ARG << i;
                     }
-                    if (arg_ts->state & TS_MEM) {
+                    if (ts->state & TS_MEM) {
                         arg_life |= SYNC_ARG << i;
                     }
-                    arg_ts->state = TS_DEAD;
+                    ts->state = TS_DEAD;
+                    la_reset_pref(ts);
+
+                    /* Not used -- it will be tcg_target_call_oarg_regs[i].  */
+                    op->output_pref[i] = 0;
                 }
 
                 if (!(call_flags & (TCG_CALL_NO_WRITE_GLOBALS |
@@ -2476,18 +2535,42 @@ static void liveness_pass_1(TCGContext *s)
                     la_global_sync(s, nb_globals);
                 }
 
-                /* record arguments that die in this helper */
+                /* Record arguments that die in this helper.  */
                 for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
-                    arg_ts = arg_temp(op->args[i]);
-                    if (arg_ts && arg_ts->state & TS_DEAD) {
+                    ts = arg_temp(op->args[i]);
+                    if (ts && ts->state & TS_DEAD) {
                         arg_life |= DEAD_ARG << i;
                     }
                 }
-                /* input arguments are live for preceding opcodes */
-                for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
-                    arg_ts = arg_temp(op->args[i]);
-                    if (arg_ts) {
-                        arg_ts->state &= ~TS_DEAD;
+
+                /* For all live registers, remove call-clobbered prefs.  */
+                la_cross_call(s, nb_temps);
+
+                nb_call_regs = ARRAY_SIZE(tcg_target_call_iarg_regs);
+
+                /* Input arguments are live for preceding opcodes.  */
+                for (i = 0; i < nb_iargs; i++) {
+                    ts = arg_temp(op->args[i + nb_oargs]);
+                    if (ts && ts->state & TS_DEAD) {
+                        /* For those arguments that die, and will be allocated
+                         * in registers, clear the register set for that arg,
+                         * to be filled in below.  For args that will be on
+                         * the stack, reset to any available reg.
+                         */
+                        *la_temp_pref(ts)
+                            = (i < nb_call_regs ? 0 :
+                               tcg_target_available_regs[ts->type]);
+                        ts->state &= ~TS_DEAD;
+                    }
+                }
+
+                /* For each input argument, add its input register to prefs.
+                   If a temp is used once, this produces a single set bit.  */
+                for (i = 0; i < MIN(nb_call_regs, nb_iargs); i++) {
+                    ts = arg_temp(op->args[i + nb_oargs]);
+                    if (ts) {
+                        tcg_regset_set_reg(*la_temp_pref(ts),
+                                           tcg_target_call_iarg_regs[i]);
                     }
                 }
             }
@@ -2496,7 +2579,9 @@ static void liveness_pass_1(TCGContext *s)
             break;
         case INDEX_op_discard:
             /* mark the temporary as dead */
-            arg_temp(op->args[0])->state = TS_DEAD;
+            ts = arg_temp(op->args[0]);
+            ts->state = TS_DEAD;
+            la_reset_pref(ts);
             break;
 
         case INDEX_op_add2_i32:
@@ -2600,43 +2685,91 @@ static void liveness_pass_1(TCGContext *s)
             break;
 
         do_not_remove:
-            /* output args are dead */
             for (i = 0; i < nb_oargs; i++) {
-                arg_ts = arg_temp(op->args[i]);
-                if (arg_ts->state & TS_DEAD) {
+                ts = arg_temp(op->args[i]);
+
+                /* Remember the preference of the uses that followed.  */
+                op->output_pref[i] = *la_temp_pref(ts);
+
+                /* Output args are dead.  */
+                if (ts->state & TS_DEAD) {
                     arg_life |= DEAD_ARG << i;
                 }
-                if (arg_ts->state & TS_MEM) {
+                if (ts->state & TS_MEM) {
                     arg_life |= SYNC_ARG << i;
                 }
-                arg_ts->state = TS_DEAD;
+                ts->state = TS_DEAD;
+                la_reset_pref(ts);
             }
 
-            /* if end of basic block, update */
+            /* If end of basic block, update.  */
             if (def->flags & TCG_OPF_BB_EXIT) {
                 la_func_end(s, nb_globals, nb_temps);
             } else if (def->flags & TCG_OPF_BB_END) {
                 la_bb_end(s, nb_globals, nb_temps);
             } else if (def->flags & TCG_OPF_SIDE_EFFECTS) {
                 la_global_sync(s, nb_globals);
+                if (def->flags & TCG_OPF_CALL_CLOBBER) {
+                    la_cross_call(s, nb_temps);
+                }
             }
 
-            /* record arguments that die in this opcode */
+            /* Record arguments that die in this opcode.  */
             for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
-                arg_ts = arg_temp(op->args[i]);
-                if (arg_ts->state & TS_DEAD) {
+                ts = arg_temp(op->args[i]);
+                if (ts->state & TS_DEAD) {
                     arg_life |= DEAD_ARG << i;
                 }
             }
-            /* input arguments are live for preceding opcodes */
+
+            /* Input arguments are live for preceding opcodes.  */
             for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
-                arg_temp(op->args[i])->state &= ~TS_DEAD;
+                ts = arg_temp(op->args[i]);
+                if (ts->state & TS_DEAD) {
+                    /* For operands that were dead, initially allow
+                       all regs for the type.  */
+                    *la_temp_pref(ts) = tcg_target_available_regs[ts->type];
+                    ts->state &= ~TS_DEAD;
+                }
+            }
+
+            /* Incorporate constraints for this operand.  */
+            switch (opc) {
+            case INDEX_op_mov_i32:
+            case INDEX_op_mov_i64:
+                /* Note that these are TCG_OPF_NOT_PRESENT and do not
+                   have proper constraints.  That said, special case
+                   moves to propagate preferences backward.  */
+                if (IS_DEAD_ARG(1)) {
+                    *la_temp_pref(arg_temp(op->args[0]))
+                        = *la_temp_pref(arg_temp(op->args[1]));
+                }
+                break;
+
+            default:
+                for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
+                    const TCGArgConstraint *ct = &def->args_ct[i];
+                    TCGRegSet set, *pset;
+
+                    ts = arg_temp(op->args[i]);
+                    pset = la_temp_pref(ts);
+                    set = *pset;
+
+                    set &= ct->u.regs;
+                    if (ct->ct & TCG_CT_IALIAS) {
+                        set &= op->output_pref[ct->alias_index];
+                    }
+                    /* If the combination is not possible, restart.  */
+                    if (set == 0) {
+                        set = ct->u.regs;
+                    }
+                    *pset = set;
+                }
+                break;
             }
             break;
         }
         op->life = arg_life;
-        op->output_pref[0] = 0;
-        op->output_pref[1] = 0;
     }
 }
 
-- 
2.17.2
