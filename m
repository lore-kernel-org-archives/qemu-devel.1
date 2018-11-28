Received: from eggs.gnu.org ([2001:4830:134:3::10]:47986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRsYl-000416-Rb
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRsYi-0004Mt-OD
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:51 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gRsYi-0004Lv-G2
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:48 -0500
Received: by mail-pg1-x543.google.com with SMTP id v28so8963261pgk.10
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 21:38:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 27 Nov 2018 21:38:30 -0800
Message-Id: <20181128053834.10861-9-richard.henderson@linaro.org>
In-Reply-To: <20181128053834.10861-1-richard.henderson@linaro.org>
References: <20181128053834.10861-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 08/12] tcg: Reindent parts of liveness_pass_1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 139 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 71 insertions(+), 68 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 27d081e11a..82f9a66d31 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2458,47 +2458,46 @@ static void liveness_pass_1(TCGContext *s)
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
@@ -2602,43 +2601,47 @@ static void liveness_pass_1(TCGContext *s)
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
