Received: from eggs.gnu.org ([208.118.235.92]:50619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtnT-0007bC-88
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtnQ-0001GH-2Y
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:27 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:44210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtnP-0001FI-TM
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:24 -0500
Received: by mail-pg1-x535.google.com with SMTP id t13so6806496pgr.11
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:59:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:18 +1100
Message-Id: <20181225205529.10874-32-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 31/42] tcg: Add preferred_reg argument to
 temp_load
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

Pass this through to tcg_reg_alloc.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 210bd5c6b9..351d302a68 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2837,7 +2837,7 @@ static void temp_allocate_frame(TCGContext *s, TCGTemp *ts)
     s->current_frame_offset += sizeof(tcg_target_long);
 }
 
-static void temp_load(TCGContext *, TCGTemp *, TCGRegSet, TCGRegSet);
+static void temp_load(TCGContext *, TCGTemp *, TCGRegSet, TCGRegSet, TCGRegSet);
 
 /* Mark a temporary as free or dead.  If 'free_or_dead' is negative,
    mark it free; otherwise mark it dead.  */
@@ -2886,7 +2886,7 @@ static void temp_sync(TCGContext *s, TCGTemp *ts,
                 break;
             }
             temp_load(s, ts, tcg_target_available_regs[ts->type],
-                      allocated_regs);
+                      allocated_regs, 0);
             /* fallthrough */
 
         case TEMP_VAL_REG:
@@ -2992,7 +2992,7 @@ static TCGReg tcg_reg_alloc(TCGContext *s, TCGRegSet required_regs,
 /* Make sure the temporary is in a register.  If needed, allocate the register
    from DESIRED while avoiding ALLOCATED.  */
 static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet desired_regs,
-                      TCGRegSet allocated_regs)
+                      TCGRegSet allocated_regs, TCGRegSet preferred_regs)
 {
     TCGReg reg;
 
@@ -3001,13 +3001,13 @@ static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet desired_regs,
         return;
     case TEMP_VAL_CONST:
         reg = tcg_reg_alloc(s, desired_regs, allocated_regs,
-                            0, ts->indirect_base);
+                            preferred_regs, ts->indirect_base);
         tcg_out_movi(s, ts->type, reg, ts->val);
         ts->mem_coherent = 0;
         break;
     case TEMP_VAL_MEM:
         reg = tcg_reg_alloc(s, desired_regs, allocated_regs,
-                            0, ts->indirect_base);
+                            preferred_regs, ts->indirect_base);
         tcg_out_ld(s, ts->type, reg, ts->mem_base->reg, ts->mem_offset);
         ts->mem_coherent = 1;
         break;
@@ -3137,7 +3137,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
        the SOURCE value into its own register first, that way we
        don't have to reload SOURCE the next time it is used. */
     if (ts->val_type == TEMP_VAL_MEM) {
-        temp_load(s, ts, tcg_target_available_regs[itype], allocated_regs);
+        temp_load(s, ts, tcg_target_available_regs[itype], allocated_regs, 0);
     }
 
     tcg_debug_assert(ts->val_type == TEMP_VAL_REG);
@@ -3221,7 +3221,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             goto iarg_end;
         }
 
-        temp_load(s, ts, arg_ct->u.regs, i_allocated_regs);
+        temp_load(s, ts, arg_ct->u.regs, i_allocated_regs, 0);
 
         if (arg_ct->ct & TCG_CT_IALIAS) {
             if (ts->fixed_reg) {
@@ -3402,7 +3402,7 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
         if (arg != TCG_CALL_DUMMY_ARG) {
             ts = arg_temp(arg);
             temp_load(s, ts, tcg_target_available_regs[ts->type],
-                      s->reserved_regs);
+                      s->reserved_regs, 0);
             tcg_out_st(s, ts->type, ts->reg, TCG_REG_CALL_STACK, stack_offset);
         }
 #ifndef TCG_TARGET_STACK_GROWSUP
@@ -3427,7 +3427,7 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
                 TCGRegSet arg_set = 0;
 
                 tcg_regset_set_reg(arg_set, reg);
-                temp_load(s, ts, arg_set, allocated_regs);
+                temp_load(s, ts, arg_set, allocated_regs, 0);
             }
 
             tcg_regset_set_reg(allocated_regs, reg);
-- 
2.17.2
