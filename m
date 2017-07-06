Received: from eggs.gnu.org ([2001:4830:134:3::10]:59698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSuay-0007V5-Vd
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSuax-0002PZ-7V
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:36 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dSuax-0002PO-1q
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:35 -0400
Received: by mail-qk0-x243.google.com with SMTP id 16so647348qkg.2
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 17:24:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  5 Jul 2017 14:23:54 -1000
Message-Id: <20170706002401.10507-5-rth@twiddle.net>
In-Reply-To: <20170706002401.10507-1-rth@twiddle.net>
References: <20170706002401.10507-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 04/11] target/sh4: Recognize common gUSA
 sequences
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, bruno@clisp.org

For many of the sequences produced by gcc or glibc,
we can translate these as host atomic operations.
Which saves the need to acquire the exclusive lock.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 300 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 290 insertions(+), 10 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 02c6efc..9ab7d6e 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1896,11 +1896,296 @@ static void decode_opc(DisasContext * ctx)
 }
 
 #ifdef CONFIG_USER_ONLY
-static int decode_gusa(DisasContext *ctx)
+/* For uniprocessors, SH4 uses optimistic restartable atomic sequences.
+   Upon an interrupt, a real kernel would simply notice magic values in
+   the registers and reset the PC to the start of the sequence.
+
+   For QEMU, we cannot do this in quite the same way.  Instead, we notice
+   the normal start of such a sequence (mov #-x,r15).  While we can handle
+   any sequence via cpu_exec_step_atomic, we can recognize the "normal"
+   sequences and transform them into atomic operations as seen by the host.
+*/
+static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
 {
+    uint16_t insns[5];
+    int ld_adr, ld_reg, ld_mop;
+    int op_reg, op_arg, op_opc;
+    int mt_reg, st_reg, st_mop;
+
     uint32_t pc = ctx->pc;
     uint32_t pc_end = ctx->tb->cs_base;
+    int backup = sextract32(ctx->tbflags, GUSA_SHIFT, 8);
+    int max_insns = (pc_end - pc) / 2;
+    int i;
+
+    if (pc != pc_end + backup || max_insns < 2) {
+        /* This is a malformed gUSA region.  Don't do anything special,
+           since the interpreter is likely to get confused.  */
+        ctx->envflags &= ~GUSA_MASK;
+        return 0;
+    }
+
+    if (ctx->tbflags & GUSA_EXCLUSIVE) {
+        /* Regardless of single-stepping or the end of the page,
+           we must complete execution of the gUSA region while
+           holding the exclusive lock.  */
+        *pmax_insns = max_insns;
+        return 0;
+    }
+
+    /* The state machine below will consume only a few insns.
+       If there are more than that in a region, fail now.  */
+    if (max_insns > ARRAY_SIZE(insns)) {
+        goto fail;
+    }
+
+    /* Read all of the insns for the region.  */
+    for (i = 0; i < max_insns; ++i) {
+        insns[i] = cpu_lduw_code(env, pc + i * 2);
+    }
+
+    ld_adr = ld_reg = ld_mop = -1;
+    op_reg = op_arg = op_opc = -1;
+    mt_reg = -1;
+    st_reg = st_mop = -1;
+    i = 0;
+
+#define NEXT_INSN \
+    do { if (i >= max_insns) goto fail; ctx->opcode = insns[i++]; } while (0)
+
+    /*
+     * Expect a load to begin the region.
+     */
+    NEXT_INSN;
+    switch (ctx->opcode & 0xf00f) {
+    case 0x6000: /* mov.b @Rm,Rn */
+        ld_mop = MO_SB;
+        break;
+    case 0x6001: /* mov.w @Rm,Rn */
+        ld_mop = MO_TESW;
+        break;
+    case 0x6002: /* mov.l @Rm,Rn */
+        ld_mop = MO_TESL;
+        break;
+    default:
+        goto fail;
+    }
+    ld_adr = B7_4;
+    op_reg = ld_reg = B11_8;
+    if (ld_adr == ld_reg) {
+        goto fail;
+    }
+
+    /*
+     * Expect an optional register move.
+     */
+    NEXT_INSN;
+    switch (ctx->opcode & 0xf00f) {
+    case 0x6003: /* mov Rm,Rn */
+        /* Here we want to recognize the ld output being
+           saved for later consumtion (e.g. atomic_fetch_op).  */
+        if (ld_reg != B7_4) {
+            goto fail;
+        }
+        op_reg = B11_8;
+        break;
+
+    default:
+        /* Put back and re-examine as operation.  */
+        --i;
+    }
+
+    /*
+     * Expect the operation.
+     */
+    NEXT_INSN;
+    switch (ctx->opcode & 0xf00f) {
+    case 0x300c: /* add Rm,Rn */
+        op_opc = INDEX_op_add_i32;
+        goto do_reg_op;
+    case 0x2009: /* and Rm,Rn */
+        op_opc = INDEX_op_and_i32;
+        goto do_reg_op;
+    case 0x200a: /* xor Rm,Rn */
+        op_opc = INDEX_op_xor_i32;
+        goto do_reg_op;
+    case 0x200b: /* or Rm,Rn */
+        op_opc = INDEX_op_or_i32;
+    do_reg_op:
+        /* The operation register should be as expected, and the
+           other input cannot depend on the load.  */
+        op_arg = B7_4;
+        if (op_reg != B11_8 || op_arg == op_reg || op_arg == ld_reg) {
+            goto fail;
+        }
+        break;
+
+    case 0x3000: /* cmp/eq Rm,Rn */
+        /* Looking for the middle of a compare-and-swap sequence,
+           beginning with the compare.  Operands can be either order,
+           but with only one overlapping the load.  */
+        if ((op_reg == B11_8) + (op_reg == B7_4) != 1) {
+            goto fail;
+        }
+        op_opc = INDEX_op_setcond_i32;  /* placeholder */
+        op_arg = (op_reg == B11_8 ? B7_4 : B11_8);
+
+        NEXT_INSN;
+        switch (ctx->opcode & 0xff00) {
+        case 0x8b00: /* bf label */
+        case 0x8f00: /* bf/s label */
+            if (pc + (i + 1 + B7_0s) * 2 != pc_end) {
+                goto fail;
+            }
+            if ((ctx->opcode & 0xff00) == 0x8b00) { /* bf label */
+                break;
+            }
+            /* We're looking to unconditionally modify Rn with the
+               result of the comparison, within the delay slot of
+               the branch.  This is used by older gcc.  */
+            NEXT_INSN;
+            if ((ctx->opcode & 0xf0ff) == 0x0029) { /* movt Rn */
+                mt_reg = B11_8;
+            } else {
+                goto fail;
+            }
+            break;
+
+        default:
+            goto fail;
+        }
+        break;
+
+    default:
+        /* Put back and re-examine as store.  */
+        --i;
+    }
+
+    /*
+     * Expect the store.
+     */
+    /* The store must be the last insn.  */
+    if (i != max_insns - 1) {
+        goto fail;
+    }
+    NEXT_INSN;
+    switch (ctx->opcode & 0xf00f) {
+    case 0x2000: /* mov.b Rm,@Rn */
+        st_mop = MO_UB;
+        break;
+    case 0x2001: /* mov.w Rm,@Rn */
+        st_mop = MO_UW;
+        break;
+    case 0x2002: /* mov.l Rm,@Rn */
+        st_mop = MO_UL;
+        break;
+    default:
+        goto fail;
+    }
+    /* The store must match the load.  */
+    if (ld_adr != B11_8 || st_mop != (ld_mop & MO_SIZE)) {
+        goto fail;
+    }
+    st_reg = B7_4;
+
+#undef NEXT_INSN
+
+    /*
+     * Emit the operation.
+     */
+    tcg_gen_insn_start(pc, ctx->envflags);
+    switch (op_opc) {
+    case -1:
+        /* No operation found.  Look for exchange pattern.  */
+        if (st_reg == ld_reg || st_reg == op_reg) {
+            goto fail;
+        }
+        tcg_gen_atomic_xchg_i32(REG(ld_reg), REG(ld_adr), REG(st_reg),
+                                ctx->memidx, ld_mop);
+        break;
+
+    case INDEX_op_add_i32:
+        if (op_reg != st_reg) {
+            goto fail;
+        }
+        if (op_reg == ld_reg && st_mop == MO_UL) {
+            tcg_gen_atomic_add_fetch_i32(REG(ld_reg), REG(ld_adr),
+                                         REG(op_arg), ctx->memidx, ld_mop);
+        } else {
+            tcg_gen_atomic_fetch_add_i32(REG(ld_reg), REG(ld_adr),
+                                         REG(op_arg), ctx->memidx, ld_mop);
+            if (op_reg != ld_reg) {
+                /* Note that mop sizes < 4 cannot use add_fetch
+                   because it won't carry into the higher bits.  */
+                tcg_gen_add_i32(REG(op_reg), REG(ld_reg), REG(op_arg));
+            }
+        }
+        break;
+
+    case INDEX_op_and_i32:
+        if (op_reg != st_reg) {
+            goto fail;
+        }
+        if (op_reg == ld_reg) {
+            tcg_gen_atomic_and_fetch_i32(REG(ld_reg), REG(ld_adr),
+                                         REG(op_arg), ctx->memidx, ld_mop);
+        } else {
+            tcg_gen_atomic_fetch_and_i32(REG(ld_reg), REG(ld_adr),
+                                         REG(op_arg), ctx->memidx, ld_mop);
+            tcg_gen_and_i32(REG(op_reg), REG(ld_reg), REG(op_arg));
+        }
+        break;
+
+    case INDEX_op_or_i32:
+        if (op_reg != st_reg) {
+            goto fail;
+        }
+        if (op_reg == ld_reg) {
+            tcg_gen_atomic_or_fetch_i32(REG(ld_reg), REG(ld_adr),
+                                        REG(op_arg), ctx->memidx, ld_mop);
+        } else {
+            tcg_gen_atomic_fetch_or_i32(REG(ld_reg), REG(ld_adr),
+                                        REG(op_arg), ctx->memidx, ld_mop);
+            tcg_gen_or_i32(REG(op_reg), REG(ld_reg), REG(op_arg));
+        }
+        break;
+
+    case INDEX_op_xor_i32:
+        if (op_reg != st_reg) {
+            goto fail;
+        }
+        if (op_reg == ld_reg) {
+            tcg_gen_atomic_xor_fetch_i32(REG(ld_reg), REG(ld_adr),
+                                         REG(op_arg), ctx->memidx, ld_mop);
+        } else {
+            tcg_gen_atomic_fetch_xor_i32(REG(ld_reg), REG(ld_adr),
+                                         REG(op_arg), ctx->memidx, ld_mop);
+            tcg_gen_xor_i32(REG(op_reg), REG(ld_reg), REG(op_arg));
+        }
+        break;
 
+    case INDEX_op_setcond_i32:
+        if (st_reg == ld_reg) {
+            goto fail;
+        }
+        tcg_gen_atomic_cmpxchg_i32(REG(ld_reg), REG(ld_adr), REG(op_arg),
+                                   REG(st_reg), ctx->memidx, ld_mop);
+        tcg_gen_setcond_i32(TCG_COND_EQ, cpu_sr_t, REG(ld_reg), REG(op_arg));
+        if (mt_reg >= 0) {
+            tcg_gen_mov_i32(REG(mt_reg), cpu_sr_t);
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    /* The entire region has been translated.  */
+    ctx->envflags &= ~GUSA_MASK;
+    ctx->pc = pc_end;
+    return max_insns;
+
+ fail:
     qemu_log_mask(LOG_UNIMP, "Unrecognized gUSA sequence %08x-%08x\n",
                   pc, pc_end);
 
@@ -1913,8 +2198,8 @@ static int decode_gusa(DisasContext *ctx)
     ctx->bstate = BS_EXCP;
 
     /* We're not executing an instruction, but we must report one for the
-       purposes of accounting within the TB.  At which point we might as
-       well report the entire region so that it's immediately available
+       purposes of accounting within the TB.  We might as well report the
+       entire region consumed via ctx->pc so that it's immediately available
        in the disassembly dump.  */
     ctx->pc = pc_end;
     return 1;
@@ -1966,13 +2251,8 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
     num_insns = 0;
 
 #ifdef CONFIG_USER_ONLY
-    if (ctx.tbflags & GUSA_EXCLUSIVE) {
-        /* Regardless of single-stepping or the end of the page,
-           we must complete execution of the gUSA region while
-           holding the exclusive lock.  */
-        max_insns = (tb->cs_base - ctx.pc) / 2;
-    } else if (ctx.tbflags & GUSA_MASK) {
-        num_insns = decode_gusa(&ctx);
+    if (ctx.tbflags & GUSA_MASK) {
+        num_insns = decode_gusa(&ctx, env, &max_insns);
     }
 #endif
 
-- 
2.9.4
