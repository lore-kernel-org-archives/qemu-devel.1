Received: from eggs.gnu.org ([2001:4830:134:3::10]:34235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIuk-0001UB-Ll
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIuh-0008HI-HI
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:22:38 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTIuh-0008H0-CH
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:22:35 -0400
Received: by mail-qt0-x241.google.com with SMTP id w12so2708505qta.2
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 19:22:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  6 Jul 2017 16:20:51 -1000
Message-Id: <20170707022111.21836-8-rth@twiddle.net>
In-Reply-To: <20170707022111.21836-1-rth@twiddle.net>
References: <20170707022111.21836-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 07/27] target/sh4: Recognize common gUSA
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
Cc: aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

For many of the sequences produced by gcc or glibc,
we can translate these as host atomic operations.
Which saves the need to acquire the exclusive lock.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 316 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 316 insertions(+)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 653c06c..73b3e02 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1894,10 +1894,17 @@ static void decode_opc(DisasContext * ctx)
 */
 static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
 {
+    uint16_t insns[5];
+    int ld_adr, ld_dst, ld_mop;
+    int op_dst, op_src, op_opc;
+    int mv_src, mt_dst, st_src, st_mop;
+    TCGv op_arg;
+
     uint32_t pc = ctx->pc;
     uint32_t pc_end = ctx->tb->cs_base;
     int backup = sextract32(ctx->tbflags, GUSA_SHIFT, 8);
     int max_insns = (pc_end - pc) / 2;
+    int i;
 
     if (pc != pc_end + backup || max_insns < 2) {
         /* This is a malformed gUSA region.  Don't do anything special,
@@ -1914,6 +1921,315 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
         return 0;
     }
 
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
+    ld_adr = ld_dst = ld_mop = -1;
+    mv_src = -1;
+    op_dst = op_src = op_opc = -1;
+    mt_dst = -1;
+    st_src = st_mop = -1;
+    TCGV_UNUSED(op_arg);
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
+    ld_dst = B11_8;
+    if (ld_adr == ld_dst) {
+        goto fail;
+    }
+    /* Unless we see a mov, any two-operand operation must use ld_dst.  */
+    op_dst = ld_dst;
+
+    /*
+     * Expect an optional register move.
+     */
+    NEXT_INSN;
+    switch (ctx->opcode & 0xf00f) {
+    case 0x6003: /* mov Rm,Rn */
+        /* Here we want to recognize ld_dst being saved for later consumtion,
+           or for another input register being copied so that ld_dst need not
+           be clobbered during the operation.  */
+        op_dst = B11_8;
+        mv_src = B7_4;
+        if (op_dst == ld_dst) {
+            /* Overwriting the load output.  */
+            goto fail;
+        }
+        if (mv_src != ld_dst) {
+            /* Copying a new input; constrain op_src to match the load.  */
+            op_src = ld_dst;
+        }
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
+        if (op_dst != B11_8) {
+            goto fail;
+        }
+        if (op_src < 0) {
+            /* Unconstrainted input.  */
+            op_src = B7_4;
+        } else if (op_src == B7_4) {
+            /* Constrained input matched load.  All operations are
+               commutative; "swap" them by "moving" the load output
+               to the (implicit) first argument and the move source
+               to the (explicit) second argument.  */
+            op_src = mv_src;
+        } else {
+            goto fail;
+        }
+        op_arg = REG(op_src);
+        break;
+
+    case 0x6007: /* not Rm,Rn */
+        if (ld_dst != B7_4 || mv_src >= 0) {
+            goto fail;
+        }
+        op_dst = B11_8;
+        op_opc = INDEX_op_xor_i32;
+        op_arg = tcg_const_i32(-1);
+        break;
+
+    case 0x7000 ... 0x700f: /* add #imm,Rn */
+        if (op_dst != B11_8 || op_src >= 0) {
+            goto fail;
+        }
+        op_opc = INDEX_op_add_i32;
+        op_arg = tcg_const_i32(B7_0s);
+        break;
+
+    case 0x3000: /* cmp/eq Rm,Rn */
+        /* Looking for the middle of a compare-and-swap sequence,
+           beginning with the compare.  Operands can be either order,
+           but with only one overlapping the load.  */
+        if ((ld_dst == B11_8) + (ld_dst == B7_4) != 1 || mv_src >= 0) {
+            goto fail;
+        }
+        op_opc = INDEX_op_setcond_i32;  /* placeholder */
+        op_src = (ld_dst == B11_8 ? B7_4 : B11_8);
+        op_arg = REG(op_src);
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
+                mt_dst = B11_8;
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
+    case 0x2008: /* tst Rm,Rn */
+        /* Looking for a compare-and-swap against zero.  */
+        if (ld_dst != B11_8 || ld_dst != B7_4 || mv_src >= 0) {
+            goto fail;
+        }
+        op_opc = INDEX_op_setcond_i32;
+        op_arg = tcg_const_i32(0);
+
+        NEXT_INSN;
+        if ((ctx->opcode & 0xff00) != 0x8900 /* bt label */
+            || pc + (i + 1 + B7_0s) * 2 != pc_end) {
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
+    st_src = B7_4;
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
+        if (st_src == ld_dst || mv_src >= 0) {
+            goto fail;
+        }
+        tcg_gen_atomic_xchg_i32(REG(ld_dst), REG(ld_adr), REG(st_src),
+                                ctx->memidx, ld_mop);
+        break;
+
+    case INDEX_op_add_i32:
+        if (op_dst != st_src) {
+            goto fail;
+        }
+        if (op_dst == ld_dst && st_mop == MO_UL) {
+            tcg_gen_atomic_add_fetch_i32(REG(ld_dst), REG(ld_adr),
+                                         op_arg, ctx->memidx, ld_mop);
+        } else {
+            tcg_gen_atomic_fetch_add_i32(REG(ld_dst), REG(ld_adr),
+                                         op_arg, ctx->memidx, ld_mop);
+            if (op_dst != ld_dst) {
+                /* Note that mop sizes < 4 cannot use add_fetch
+                   because it won't carry into the higher bits.  */
+                tcg_gen_add_i32(REG(op_dst), REG(ld_dst), op_arg);
+            }
+        }
+        break;
+
+    case INDEX_op_and_i32:
+        if (op_dst != st_src) {
+            goto fail;
+        }
+        if (op_dst == ld_dst) {
+            tcg_gen_atomic_and_fetch_i32(REG(ld_dst), REG(ld_adr),
+                                         op_arg, ctx->memidx, ld_mop);
+        } else {
+            tcg_gen_atomic_fetch_and_i32(REG(ld_dst), REG(ld_adr),
+                                         op_arg, ctx->memidx, ld_mop);
+            tcg_gen_and_i32(REG(op_dst), REG(ld_dst), op_arg);
+        }
+        break;
+
+    case INDEX_op_or_i32:
+        if (op_dst != st_src) {
+            goto fail;
+        }
+        if (op_dst == ld_dst) {
+            tcg_gen_atomic_or_fetch_i32(REG(ld_dst), REG(ld_adr),
+                                        op_arg, ctx->memidx, ld_mop);
+        } else {
+            tcg_gen_atomic_fetch_or_i32(REG(ld_dst), REG(ld_adr),
+                                        op_arg, ctx->memidx, ld_mop);
+            tcg_gen_or_i32(REG(op_dst), REG(ld_dst), op_arg);
+        }
+        break;
+
+    case INDEX_op_xor_i32:
+        if (op_dst != st_src) {
+            goto fail;
+        }
+        if (op_dst == ld_dst) {
+            tcg_gen_atomic_xor_fetch_i32(REG(ld_dst), REG(ld_adr),
+                                         op_arg, ctx->memidx, ld_mop);
+        } else {
+            tcg_gen_atomic_fetch_xor_i32(REG(ld_dst), REG(ld_adr),
+                                         op_arg, ctx->memidx, ld_mop);
+            tcg_gen_xor_i32(REG(op_dst), REG(ld_dst), op_arg);
+        }
+        break;
+
+    case INDEX_op_setcond_i32:
+        if (st_src == ld_dst) {
+            goto fail;
+        }
+        tcg_gen_atomic_cmpxchg_i32(REG(ld_dst), REG(ld_adr), op_arg,
+                                   REG(st_src), ctx->memidx, ld_mop);
+        tcg_gen_setcond_i32(TCG_COND_EQ, cpu_sr_t, REG(ld_dst), op_arg);
+        if (mt_dst >= 0) {
+            tcg_gen_mov_i32(REG(mt_dst), cpu_sr_t);
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
 
-- 
2.9.4
