Received: from eggs.gnu.org ([2001:4830:134:3::10]:47880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRsYi-0003tD-GC
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRsYg-0004Ln-Jb
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:48 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gRsYe-0004Js-Hy
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:46 -0500
Received: by mail-pf1-x444.google.com with SMTP id h3so9623490pfg.1
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 21:38:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 27 Nov 2018 21:38:27 -0800
Message-Id: <20181128053834.10861-6-richard.henderson@linaro.org>
In-Reply-To: <20181128053834.10861-1-richard.henderson@linaro.org>
References: <20181128053834.10861-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 05/12] tcg: Add output_pref to TCGOp
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

Allocate storage for, but do not yet fill in, per-opcode
preferences for the output operands.  Pass it in to the
register allocation routines for output operands.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h |  3 +++
 tcg/tcg.c | 18 +++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index c6caeeb42b..b2e274b7af 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -621,6 +621,9 @@ typedef struct TCGOp {
 
     /* Arguments for the opcode.  */
     TCGArg args[MAX_OPC_PARAM];
+
+    /* Register preferences for the output(s).  */
+    TCGRegSet output_pref[2];
 } TCGOp;
 
 #define TCGOP_CALLI(X)    (X)->param1
diff --git a/tcg/tcg.c b/tcg/tcg.c
index c83ca238aa..f86415ce29 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2613,6 +2613,8 @@ static void liveness_pass_1(TCGContext *s)
             break;
         }
         op->life = arg_life;
+        op->output_pref[0] = 0;
+        op->output_pref[1] = 0;
     }
 }
 
@@ -3127,17 +3129,18 @@ static void tcg_reg_alloc_movi(TCGContext *s, const TCGOp *op)
     TCGTemp *ots = arg_temp(op->args[0]);
     tcg_target_ulong val = op->args[1];
 
-    tcg_reg_alloc_do_movi(s, ots, val, op->life, 0);
+    tcg_reg_alloc_do_movi(s, ots, val, op->life, op->output_pref[0]);
 }
 
 static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
 {
     const TCGLifeData arg_life = op->life;
-    TCGRegSet allocated_regs;
+    TCGRegSet allocated_regs, preferred_regs;
     TCGTemp *ts, *ots;
     TCGType otype, itype;
 
     allocated_regs = s->reserved_regs;
+    preferred_regs = op->output_pref[0];
     ots = arg_temp(op->args[0]);
     ts = arg_temp(op->args[1]);
 
@@ -3151,7 +3154,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
         if (IS_DEAD_ARG(1)) {
             temp_dead(s, ts);
         }
-        tcg_reg_alloc_do_movi(s, ots, val, arg_life, 0);
+        tcg_reg_alloc_do_movi(s, ots, val, arg_life, preferred_regs);
         return;
     }
 
@@ -3160,7 +3163,8 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
        the SOURCE value into its own register first, that way we
        don't have to reload SOURCE the next time it is used. */
     if (ts->val_type == TEMP_VAL_MEM) {
-        temp_load(s, ts, tcg_target_available_regs[itype], allocated_regs, 0);
+        temp_load(s, ts, tcg_target_available_regs[itype],
+                  allocated_regs, preferred_regs);
     }
 
     tcg_debug_assert(ts->val_type == TEMP_VAL_REG);
@@ -3190,7 +3194,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
                    input one. */
                 tcg_regset_set_reg(allocated_regs, ts->reg);
                 ots->reg = tcg_reg_alloc(s, tcg_target_available_regs[otype],
-                                         allocated_regs, 0,
+                                         allocated_regs, preferred_regs,
                                          ots->indirect_base);
             }
             tcg_out_mov(s, otype, ots->reg, ts->reg);
@@ -3324,7 +3328,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             } else if (arg_ct->ct & TCG_CT_NEWREG) {
                 reg = tcg_reg_alloc(s, arg_ct->u.regs,
                                     i_allocated_regs | o_allocated_regs,
-                                    0, ts->indirect_base);
+                                    op->output_pref[k], ts->indirect_base);
             } else {
                 /* if fixed register, we try to use it */
                 reg = ts->reg;
@@ -3333,7 +3337,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
                     goto oarg_end;
                 }
                 reg = tcg_reg_alloc(s, arg_ct->u.regs, o_allocated_regs,
-                                    0, ts->indirect_base);
+                                    op->output_pref[k], ts->indirect_base);
             }
             tcg_regset_set_reg(o_allocated_regs, reg);
             /* if a fixed register is used, then a move will be done afterwards */
-- 
2.17.2
