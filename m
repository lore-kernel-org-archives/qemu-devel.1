Received: from eggs.gnu.org ([2001:4830:134:3::10]:51518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddW14-0003Ws-9A
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddW11-0005Ni-Hi
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:22 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddW11-0005Mt-9a
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:19 -0400
Received: by mail-pg0-x242.google.com with SMTP id y192so919163pgd.1
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 23:23:19 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	q199sm1335819pfq.135.2017.08.03.23.23.16 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 23:23:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 23:23:09 -0700
Message-Id: <20170804062314.12594-2-rth@twiddle.net>
In-Reply-To: <20170804062314.12594-1-rth@twiddle.net>
References: <20170804062314.12594-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 1/6] tcg: Add tcg_reg_alloc_new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This allows the backend to allocate an otherwise unused register.
This can allow the backend to avoid having to reserve a full-time
temporary register.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.h |  1 +
 tcg/tcg.c | 58 +++++++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index ac94133870..dd97095af5 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -655,6 +655,7 @@ struct TCGContext {
     uintptr_t *tb_jmp_insn_offset; /* tb->jmp_target_arg if direct_jump */
     uintptr_t *tb_jmp_target_addr; /* tb->jmp_target_arg if !direct_jump */
 
+    TCGRegSet regs_in_use;
     TCGRegSet reserved_regs;
     intptr_t current_frame_offset;
     intptr_t frame_start;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index fd8a3dfe93..787c8ba0f7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -112,6 +112,8 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
 static void tcg_out_call(TCGContext *s, tcg_insn_unit *target);
 static int tcg_target_const_match(tcg_target_long val, TCGType type,
                                   const TCGArgConstraint *arg_ct);
+static TCGReg tcg_reg_alloc_new(TCGContext *s, TCGType t)
+    __attribute__((unused));
 #ifdef TCG_TARGET_NEED_LDST_LABELS
 static bool tcg_out_ldst_finalize(TCGContext *s);
 #endif
@@ -1947,16 +1949,19 @@ static void temp_sync(TCGContext *s, TCGTemp *ts,
             /* If we're going to free the temp immediately, then we won't
                require it later in a register, so attempt to store the
                constant to memory directly.  */
-            if (free_or_dead
-                && tcg_out_sti(s, ts->type, ts->val,
-                               ts->mem_base->reg, ts->mem_offset)) {
-                break;
+            if (free_or_dead) {
+                s->regs_in_use = -1;
+                if (tcg_out_sti(s, ts->type, ts->val,
+                                ts->mem_base->reg, ts->mem_offset)) {
+                    break;
+                }
             }
             temp_load(s, ts, tcg_target_available_regs[ts->type],
                       allocated_regs);
             /* fallthrough */
 
         case TEMP_VAL_REG:
+            s->regs_in_use = -1;
             tcg_out_st(s, ts->type, ts->reg,
                        ts->mem_base->reg, ts->mem_offset);
             break;
@@ -2015,6 +2020,14 @@ static TCGReg tcg_reg_alloc(TCGContext *s, TCGRegSet desired_regs,
     tcg_abort();
 }
 
+static TCGReg tcg_reg_alloc_new(TCGContext *s, TCGType t)
+{
+    TCGReg r;
+    r = tcg_reg_alloc(s, tcg_target_available_regs[t], s->regs_in_use, 0);
+    tcg_regset_set_reg(s->regs_in_use, r);
+    return r;
+}
+
 /* Make sure the temporary is in a register.  If needed, allocate the register
    from DESIRED while avoiding ALLOCATED.  */
 static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet desired_regs,
@@ -2027,11 +2040,13 @@ static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet desired_regs,
         return;
     case TEMP_VAL_CONST:
         reg = tcg_reg_alloc(s, desired_regs, allocated_regs, ts->indirect_base);
+        s->regs_in_use = allocated_regs;
         tcg_out_movi(s, ts->type, reg, ts->val);
         ts->mem_coherent = 0;
         break;
     case TEMP_VAL_MEM:
         reg = tcg_reg_alloc(s, desired_regs, allocated_regs, ts->indirect_base);
+        s->regs_in_use = -1;
         tcg_out_ld(s, ts->type, reg, ts->mem_base->reg, ts->mem_offset);
         ts->mem_coherent = 1;
         break;
@@ -2105,6 +2120,7 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
 {
     if (ots->fixed_reg) {
         /* For fixed registers, we do not do any constant propagation.  */
+        s->regs_in_use = s->reserved_regs;
         tcg_out_movi(s, ots->type, ots->reg, val);
         return;
     }
@@ -2129,17 +2145,16 @@ static void tcg_reg_alloc_movi(TCGContext *s, const TCGArg *args,
     TCGTemp *ots = &s->temps[args[0]];
     tcg_target_ulong val = args[1];
 
+    s->regs_in_use = s->reserved_regs;
     tcg_reg_alloc_do_movi(s, ots, val, arg_life);
 }
 
 static void tcg_reg_alloc_mov(TCGContext *s, const TCGOpDef *def,
                               const TCGArg *args, TCGLifeData arg_life)
 {
-    TCGRegSet allocated_regs;
     TCGTemp *ts, *ots;
     TCGType otype, itype;
 
-    tcg_regset_set(allocated_regs, s->reserved_regs);
     ots = &s->temps[args[0]];
     ts = &s->temps[args[1]];
 
@@ -2153,6 +2168,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOpDef *def,
         if (IS_DEAD_ARG(1)) {
             temp_dead(s, ts);
         }
+        s->regs_in_use = s->reserved_regs;
         tcg_reg_alloc_do_movi(s, ots, val, arg_life);
         return;
     }
@@ -2162,7 +2178,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOpDef *def,
        the SOURCE value into its own register first, that way we
        don't have to reload SOURCE the next time it is used. */
     if (ts->val_type == TEMP_VAL_MEM) {
-        temp_load(s, ts, tcg_target_available_regs[itype], allocated_regs);
+        temp_load(s, ts, tcg_target_available_regs[itype], s->reserved_regs);
     }
 
     tcg_debug_assert(ts->val_type == TEMP_VAL_REG);
@@ -2173,12 +2189,14 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOpDef *def,
         if (!ots->mem_allocated) {
             temp_allocate_frame(s, args[0]);
         }
+        s->regs_in_use = -1;
         tcg_out_st(s, otype, ts->reg, ots->mem_base->reg, ots->mem_offset);
         if (IS_DEAD_ARG(1)) {
             temp_dead(s, ts);
         }
         temp_dead(s, ots);
     } else {
+        TCGRegSet allocated_regs;
         if (IS_DEAD_ARG(1) && !ts->fixed_reg && !ots->fixed_reg) {
             /* the mov can be suppressed */
             if (ots->val_type == TEMP_VAL_REG) {
@@ -2188,19 +2206,21 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOpDef *def,
             temp_dead(s, ts);
         } else {
             if (ots->val_type != TEMP_VAL_REG) {
-                /* When allocating a new register, make sure to not spill the
-                   input one. */
+                /* When allocating a new register, make sure to not
+                   spill the input one. */
+                allocated_regs = s->reserved_regs;
                 tcg_regset_set_reg(allocated_regs, ts->reg);
                 ots->reg = tcg_reg_alloc(s, tcg_target_available_regs[otype],
                                          allocated_regs, ots->indirect_base);
             }
+            s->regs_in_use = -1;
             tcg_out_mov(s, otype, ots->reg, ts->reg);
         }
         ots->val_type = TEMP_VAL_REG;
         ots->mem_coherent = 0;
         s->reg_to_temp[ots->reg] = ots;
         if (NEED_SYNC_ARG(0)) {
-            temp_sync(s, ots, allocated_regs, 0);
+            temp_sync(s, ots, s->reserved_regs, 0);
         }
     }
 }
@@ -2281,6 +2301,7 @@ static void tcg_reg_alloc_op(TCGContext *s,
                and move the temporary register into it */
             reg = tcg_reg_alloc(s, arg_ct->u.regs, i_allocated_regs,
                                 ts->indirect_base);
+            s->regs_in_use = -1;
             tcg_out_mov(s, ts->type, reg, ts->reg);
         }
         new_args[i] = reg;
@@ -2355,6 +2376,7 @@ static void tcg_reg_alloc_op(TCGContext *s,
     }
 
     /* emit instruction */
+    s->regs_in_use = i_allocated_regs | o_allocated_regs;
     tcg_out_op(s, opc, new_args, const_args);
     
     /* move the outputs in the correct register if needed */
@@ -2362,6 +2384,7 @@ static void tcg_reg_alloc_op(TCGContext *s,
         ts = &s->temps[args[i]];
         reg = new_args[i];
         if (ts->fixed_reg && ts->reg != reg) {
+            s->regs_in_use = -1;
             tcg_out_mov(s, ts->type, ts->reg, reg);
         }
         if (NEED_SYNC_ARG(i)) {
@@ -2420,6 +2443,7 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
             ts = &s->temps[arg];
             temp_load(s, ts, tcg_target_available_regs[ts->type],
                       s->reserved_regs);
+            s->regs_in_use = -1;
             tcg_out_st(s, ts->type, ts->reg, TCG_REG_CALL_STACK, stack_offset);
         }
 #ifndef TCG_TARGET_STACK_GROWSUP
@@ -2428,7 +2452,7 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
     }
     
     /* assign input registers */
-    tcg_regset_set(allocated_regs, s->reserved_regs);
+    allocated_regs = s->reserved_regs;
     for(i = 0; i < nb_regs; i++) {
         arg = args[nb_oargs + i];
         if (arg != TCG_CALL_DUMMY_ARG) {
@@ -2438,6 +2462,7 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
 
             if (ts->val_type == TEMP_VAL_REG) {
                 if (ts->reg != reg) {
+                    s->regs_in_use = -1;
                     tcg_out_mov(s, ts->type, reg, ts->reg);
                 }
             } else {
@@ -2458,7 +2483,7 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
             temp_dead(s, &s->temps[args[i]]);
         }
     }
-    
+
     /* clobber call registers */
     for (i = 0; i < TCG_TARGET_NB_REGS; i++) {
         if (tcg_regset_test_reg(tcg_target_call_clobber_regs, i)) {
@@ -2476,10 +2501,16 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
         save_globals(s, allocated_regs);
     }
 
+    s->regs_in_use = allocated_regs;
     tcg_out_call(s, func_addr);
 
     /* assign output registers and emit moves if needed */
-    for(i = 0; i < nb_oargs; i++) {
+    allocated_regs = s->reserved_regs;
+    for (i = 0; i < nb_oargs; i++) {
+        reg = tcg_target_call_oarg_regs[i];
+        tcg_regset_set_reg(allocated_regs, reg);
+    }
+    for (i = 0; i < nb_oargs; i++) {
         arg = args[i];
         ts = &s->temps[arg];
         reg = tcg_target_call_oarg_regs[i];
@@ -2487,6 +2518,7 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
 
         if (ts->fixed_reg) {
             if (ts->reg != reg) {
+                s->regs_in_use = -1;
                 tcg_out_mov(s, ts->type, ts->reg, reg);
             }
         } else {
-- 
2.13.3
