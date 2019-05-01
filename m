Received: from eggs.gnu.org ([209.51.188.92]:38291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRP-0006RT-Ds
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRM-0002rZ-Cg
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:59 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:36882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRM-0002r9-5J
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:56 -0400
Received: by mail-pl1-x629.google.com with SMTP id z8so7764253pln.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:05:56 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.05.53 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:05:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 30 Apr 2019 22:05:16 -0700
Message-Id: <20190501050536.15580-10-richard.henderson@linaro.org>
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 09/29] tcg: Manually expand INDEX_op_dup_vec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This case is similar to INDEX_op_mov_* in that we need to do
different things depending on the current location of the source.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c |   9 ++--
 tcg/i386/tcg-target.inc.c    |   8 ++-
 tcg/tcg.c                    | 102 +++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 10 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index e443b5df23..3cefdd1e43 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -2108,10 +2108,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_mov_vec:
     case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
     case INDEX_op_movi_i64:
-    case INDEX_op_dupi_vec:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         g_assert_not_reached();
@@ -2208,9 +2206,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_not_vec:
         tcg_out_insn(s, 3617, NOT, is_q, 0, a0, a1);
         break;
-    case INDEX_op_dup_vec:
-        tcg_out_dup_vec(s, type, vece, a0, a1);
-        break;
     case INDEX_op_shli_vec:
         tcg_out_insn(s, 3614, SHL, is_q, a0, a1, a2 + (8 << vece));
         break;
@@ -2254,6 +2249,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
             }
         }
         break;
+
+    case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
+    case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
+    case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
     default:
         g_assert_not_reached();
     }
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 0d621670c7..3c8229d413 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2603,10 +2603,8 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_mov_vec:
     case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
     case INDEX_op_movi_i64:
-    case INDEX_op_dupi_vec:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         tcg_abort();
@@ -2795,9 +2793,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_st_vec:
         tcg_out_st(s, type, a0, a1, a2);
         break;
-    case INDEX_op_dup_vec:
-        tcg_out_dup_vec(s, type, vece, a0, a1);
-        break;
 
     case INDEX_op_x86_shufps_vec:
         insn = OPC_SHUFPS;
@@ -2839,6 +2834,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out8(s, a2);
         break;
 
+    case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
+    case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
+    case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
     default:
         g_assert_not_reached();
     }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 3ef4d3478d..78fd0e4594 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3407,6 +3407,105 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
     }
 }
 
+static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
+{
+    const TCGLifeData arg_life = op->life;
+    TCGRegSet dup_out_regs, dup_in_regs;
+    TCGTemp *its, *ots;
+    TCGType itype, vtype;
+    unsigned vece;
+    bool ok;
+
+    ots = arg_temp(op->args[0]);
+    its = arg_temp(op->args[1]);
+
+    /* There should be no fixed vector registers.  */
+    tcg_debug_assert(!ots->fixed_reg);
+
+    itype = its->type;
+    vece = TCGOP_VECE(op);
+    vtype = TCGOP_VECL(op) + TCG_TYPE_V64;
+
+    if (its->val_type == TEMP_VAL_CONST) {
+        /* Propagate constant via movi -> dupi.  */
+        tcg_target_ulong val = its->val;
+        if (IS_DEAD_ARG(1)) {
+            temp_dead(s, its);
+        }
+        tcg_reg_alloc_do_movi(s, ots, val, arg_life, op->output_pref[0]);
+        return;
+    }
+
+    dup_out_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[0].u.regs;
+    dup_in_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[1].u.regs;
+
+    /* Allocate the output register now.  */
+    if (ots->val_type != TEMP_VAL_REG) {
+        TCGRegSet allocated_regs = s->reserved_regs;
+
+        if (!IS_DEAD_ARG(1) && its->val_type == TEMP_VAL_REG) {
+            /* Make sure to not spill the input register. */
+            tcg_regset_set_reg(allocated_regs, its->reg);
+        }
+        ots->reg = tcg_reg_alloc(s, dup_out_regs, allocated_regs,
+                                 op->output_pref[0], ots->indirect_base);
+        ots->val_type = TEMP_VAL_REG;
+        ots->mem_coherent = 0;
+        s->reg_to_temp[ots->reg] = ots;
+    }
+
+    switch (its->val_type) {
+    case TEMP_VAL_REG:
+        /*
+         * The dup constriaints must be broad, covering all possible VECE.
+         * However, tcg_op_dup_vec() gets to see the VECE and we allow it
+         * to fail, indicating that extra moves are required for that case.
+         */
+        if (tcg_regset_test_reg(dup_in_regs, its->reg)) {
+            if (tcg_out_dup_vec(s, vtype, vece, ots->reg, its->reg)) {
+                goto done;
+            }
+            /* Try again from memory or a vector input register.  */
+        }
+        if (!its->mem_coherent) {
+            /*
+             * The input register is not synced, and so an extra store
+             * would be required to use memory.  Attempt an integer-vector
+             * register move first.  We do not have a TCGRegSet for this.
+             */
+            if (tcg_out_mov(s, itype, ots->reg, its->reg)) {
+                break;
+            }
+            /* Sync the temp back to its slot and load from there.  */
+            temp_sync(s, its, s->reserved_regs, 0, 0);
+        }
+        /* fall through */
+
+    case TEMP_VAL_MEM:
+        /* TODO: dup from memory */
+        tcg_out_ld(s, itype, ots->reg, its->mem_base->reg, its->mem_offset);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    /* We now have a vector input register, so dup must succeed. */
+    ok = tcg_out_dup_vec(s, vtype, vece, ots->reg, ots->reg);
+    tcg_debug_assert(ok);
+
+ done:
+    if (IS_DEAD_ARG(1)) {
+        temp_dead(s, its);
+    }
+    if (NEED_SYNC_ARG(0)) {
+        temp_sync(s, ots, s->reserved_regs, 0, 0);
+    }
+    if (IS_DEAD_ARG(0)) {
+        temp_dead(s, ots);
+    }
+}
+
 static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
 {
     const TCGLifeData arg_life = op->life;
@@ -3981,6 +4080,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
         case INDEX_op_dupi_vec:
             tcg_reg_alloc_movi(s, op);
             break;
+        case INDEX_op_dup_vec:
+            tcg_reg_alloc_dup(s, op);
+            break;
         case INDEX_op_insn_start:
             if (num_insns >= 0) {
                 size_t off = tcg_current_code_size(s);
-- 
2.17.1
