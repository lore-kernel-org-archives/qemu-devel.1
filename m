Received: from eggs.gnu.org ([208.118.235.92]:50850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtnx-0008JZ-BQ
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtnu-0001oZ-6S
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:57 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:44006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtnt-0001nx-VA
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:54 -0500
Received: by mail-pf1-x430.google.com with SMTP id w73so7069581pfk.10
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:59:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:24 +1100
Message-Id: <20181225205529.10874-38-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 37/42] tcg: Reindent parts of liveness_pass_1
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

There are two blocks of the form

    if (foo) {
        stuff1;
        goto bar;
    } else {
    baz:
        stuff2;
    }

which have unnecessary and confusing indentation.
Remove the else and unindent stuff2.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 139 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 71 insertions(+), 68 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index e2ae04d1d0..696a45f7f8 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2436,47 +2436,46 @@ static void liveness_pass_1(TCGContext *s)
                         }
                     }
                     goto do_remove;
-                } else {
-                do_not_remove_call:
+                }
+            do_not_remove_call:
 
-                    /* output args are dead */
-                    for (i = 0; i < nb_oargs; i++) {
-                        arg_ts = arg_temp(op->args[i]);
-                        if (arg_ts->state & TS_DEAD) {
-                            arg_life |= DEAD_ARG << i;
-                        }
-                        if (arg_ts->state & TS_MEM) {
-                            arg_life |= SYNC_ARG << i;
-                        }
-                        arg_ts->state = TS_DEAD;
+                /* output args are dead */
+                for (i = 0; i < nb_oargs; i++) {
+                    arg_ts = arg_temp(op->args[i]);
+                    if (arg_ts->state & TS_DEAD) {
+                        arg_life |= DEAD_ARG << i;
                     }
+                    if (arg_ts->state & TS_MEM) {
+                        arg_life |= SYNC_ARG << i;
+                    }
+                    arg_ts->state = TS_DEAD;
+                }
 
-                    if (!(call_flags & (TCG_CALL_NO_WRITE_GLOBALS |
-                                        TCG_CALL_NO_READ_GLOBALS))) {
-                        /* globals should go back to memory */
-                        for (i = 0; i < nb_globals; i++) {
-                            s->temps[i].state = TS_DEAD | TS_MEM;
-                        }
-                    } else if (!(call_flags & TCG_CALL_NO_READ_GLOBALS)) {
-                        /* globals should be synced to memory */
-                        for (i = 0; i < nb_globals; i++) {
-                            s->temps[i].state |= TS_MEM;
-                        }
+                if (!(call_flags & (TCG_CALL_NO_WRITE_GLOBALS |
+                                    TCG_CALL_NO_READ_GLOBALS))) {
+                    /* globals should go back to memory */
+                    for (i = 0; i < nb_globals; i++) {
+                        s->temps[i].state = TS_DEAD | TS_MEM;
                     }
+                } else if (!(call_flags & TCG_CALL_NO_READ_GLOBALS)) {
+                    /* globals should be synced to memory */
+                    for (i = 0; i < nb_globals; i++) {
+                        s->temps[i].state |= TS_MEM;
+                    }
+                }
 
-                    /* record arguments that die in this helper */
-                    for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
-                        arg_ts = arg_temp(op->args[i]);
-                        if (arg_ts && arg_ts->state & TS_DEAD) {
-                            arg_life |= DEAD_ARG << i;
-                        }
+                /* record arguments that die in this helper */
+                for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
+                    arg_ts = arg_temp(op->args[i]);
+                    if (arg_ts && arg_ts->state & TS_DEAD) {
+                        arg_life |= DEAD_ARG << i;
                     }
-                    /* input arguments are live for preceding opcodes */
-                    for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
-                        arg_ts = arg_temp(op->args[i]);
-                        if (arg_ts) {
-                            arg_ts->state &= ~TS_DEAD;
-                        }
+                }
+                /* input arguments are live for preceding opcodes */
+                for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
+                    arg_ts = arg_temp(op->args[i]);
+                    if (arg_ts) {
+                        arg_ts->state &= ~TS_DEAD;
                     }
                 }
             }
@@ -2580,43 +2579,47 @@ static void liveness_pass_1(TCGContext *s)
                         goto do_not_remove;
                     }
                 }
-            do_remove:
-                tcg_op_remove(s, op);
-            } else {
-            do_not_remove:
-                /* output args are dead */
-                for (i = 0; i < nb_oargs; i++) {
-                    arg_ts = arg_temp(op->args[i]);
-                    if (arg_ts->state & TS_DEAD) {
-                        arg_life |= DEAD_ARG << i;
-                    }
-                    if (arg_ts->state & TS_MEM) {
-                        arg_life |= SYNC_ARG << i;
-                    }
-                    arg_ts->state = TS_DEAD;
-                }
+                goto do_remove;
+            }
+            goto do_not_remove;
 
-                /* if end of basic block, update */
-                if (def->flags & TCG_OPF_BB_END) {
-                    tcg_la_bb_end(s);
-                } else if (def->flags & TCG_OPF_SIDE_EFFECTS) {
-                    /* globals should be synced to memory */
-                    for (i = 0; i < nb_globals; i++) {
-                        s->temps[i].state |= TS_MEM;
-                    }
-                }
+        do_remove:
+            tcg_op_remove(s, op);
+            break;
 
-                /* record arguments that die in this opcode */
-                for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
-                    arg_ts = arg_temp(op->args[i]);
-                    if (arg_ts->state & TS_DEAD) {
-                        arg_life |= DEAD_ARG << i;
-                    }
+        do_not_remove:
+            /* output args are dead */
+            for (i = 0; i < nb_oargs; i++) {
+                arg_ts = arg_temp(op->args[i]);
+                if (arg_ts->state & TS_DEAD) {
+                    arg_life |= DEAD_ARG << i;
                 }
-                /* input arguments are live for preceding opcodes */
-                for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
-                    arg_temp(op->args[i])->state &= ~TS_DEAD;
+                if (arg_ts->state & TS_MEM) {
+                    arg_life |= SYNC_ARG << i;
                 }
+                arg_ts->state = TS_DEAD;
+            }
+
+            /* if end of basic block, update */
+            if (def->flags & TCG_OPF_BB_END) {
+                tcg_la_bb_end(s);
+            } else if (def->flags & TCG_OPF_SIDE_EFFECTS) {
+                /* globals should be synced to memory */
+                for (i = 0; i < nb_globals; i++) {
+                    s->temps[i].state |= TS_MEM;
+                }
+            }
+
+            /* record arguments that die in this opcode */
+            for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
+                arg_ts = arg_temp(op->args[i]);
+                if (arg_ts->state & TS_DEAD) {
+                    arg_life |= DEAD_ARG << i;
+                }
+            }
+            /* input arguments are live for preceding opcodes */
+            for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
+                arg_temp(op->args[i])->state &= ~TS_DEAD;
             }
             break;
         }
-- 
2.17.2
