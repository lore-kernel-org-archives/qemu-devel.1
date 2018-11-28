Received: from eggs.gnu.org ([2001:4830:134:3::10]:47820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRsYd-0003ki-92
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRsYa-0004Iu-Fm
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:42 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gRsYa-0004Id-Ad
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:40 -0500
Received: by mail-pg1-x544.google.com with SMTP id 17so8979569pgg.1
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 21:38:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 27 Nov 2018 21:38:24 -0800
Message-Id: <20181128053834.10861-3-richard.henderson@linaro.org>
In-Reply-To: <20181128053834.10861-1-richard.henderson@linaro.org>
References: <20181128053834.10861-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 02/12] tcg: Add preferred_reg argument to
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
Cc: cota@braap.org

Pass this through to tcg_reg_alloc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index c596277fd0..7f29a2045a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2859,7 +2859,7 @@ static void temp_allocate_frame(TCGContext *s, TCGTemp *ts)
     s->current_frame_offset += sizeof(tcg_target_long);
 }
 
-static void temp_load(TCGContext *, TCGTemp *, TCGRegSet, TCGRegSet);
+static void temp_load(TCGContext *, TCGTemp *, TCGRegSet, TCGRegSet, TCGRegSet);
 
 /* Mark a temporary as free or dead.  If 'free_or_dead' is negative,
    mark it free; otherwise mark it dead.  */
@@ -2908,7 +2908,7 @@ static void temp_sync(TCGContext *s, TCGTemp *ts,
                 break;
             }
             temp_load(s, ts, tcg_target_available_regs[ts->type],
-                      allocated_regs);
+                      allocated_regs, 0);
             /* fallthrough */
 
         case TEMP_VAL_REG:
@@ -3014,7 +3014,7 @@ static TCGReg tcg_reg_alloc(TCGContext *s, TCGRegSet required_regs,
 /* Make sure the temporary is in a register.  If needed, allocate the register
    from DESIRED while avoiding ALLOCATED.  */
 static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet desired_regs,
-                      TCGRegSet allocated_regs)
+                      TCGRegSet allocated_regs, TCGRegSet preferred_regs)
 {
     TCGReg reg;
 
@@ -3023,13 +3023,13 @@ static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet desired_regs,
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
@@ -3159,7 +3159,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
        the SOURCE value into its own register first, that way we
        don't have to reload SOURCE the next time it is used. */
     if (ts->val_type == TEMP_VAL_MEM) {
-        temp_load(s, ts, tcg_target_available_regs[itype], allocated_regs);
+        temp_load(s, ts, tcg_target_available_regs[itype], allocated_regs, 0);
     }
 
     tcg_debug_assert(ts->val_type == TEMP_VAL_REG);
@@ -3243,7 +3243,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             goto iarg_end;
         }
 
-        temp_load(s, ts, arg_ct->u.regs, i_allocated_regs);
+        temp_load(s, ts, arg_ct->u.regs, i_allocated_regs, 0);
 
         if (arg_ct->ct & TCG_CT_IALIAS) {
             if (ts->fixed_reg) {
@@ -3424,7 +3424,7 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
         if (arg != TCG_CALL_DUMMY_ARG) {
             ts = arg_temp(arg);
             temp_load(s, ts, tcg_target_available_regs[ts->type],
-                      s->reserved_regs);
+                      s->reserved_regs, 0);
             tcg_out_st(s, ts->type, ts->reg, TCG_REG_CALL_STACK, stack_offset);
         }
 #ifndef TCG_TARGET_STACK_GROWSUP
@@ -3449,7 +3449,7 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
                 TCGRegSet arg_set = 0;
 
                 tcg_regset_set_reg(arg_set, reg);
-                temp_load(s, ts, arg_set, allocated_regs);
+                temp_load(s, ts, arg_set, allocated_regs, 0);
             }
 
             tcg_regset_set_reg(allocated_regs, reg);
-- 
2.17.2
