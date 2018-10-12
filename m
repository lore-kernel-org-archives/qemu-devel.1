Received: from eggs.gnu.org ([2001:4830:134:3::10]:39854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1Hh-0001qq-PH
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1Hd-0000FE-MK
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:33 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:37110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gB1Hb-0008S5-TI
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:28 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri, 12 Oct 2018 19:30:28 +0200
Message-Id: <20181012173047.25420-10-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/28] target/riscv: Convert RV64A insns to
 decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de
Cc: qemu-devel@nongnu.org, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn32.decode              |  13 +++
 target/riscv/insn_trans/trans_rva.inc.c |  99 +++++++++++++++++
 target/riscv/translate.c                | 140 ------------------------
 3 files changed, 112 insertions(+), 140 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 31fca2f184..b4a86f5402 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -148,3 +148,16 @@ amomin_w   10000 . . ..... ..... 010 ..... 0101111 @atom_st
 amomax_w   10100 . . ..... ..... 010 ..... 0101111 @atom_st
 amominu_w  11000 . . ..... ..... 010 ..... 0101111 @atom_st
 amomaxu_w  11100 . . ..... ..... 010 ..... 0101111 @atom_st
+
+# *** RV64A Standard Extension (in addition to RV32A) ***
+lr_d       00010 . . 00000 ..... 011 ..... 0101111 @atom_ld
+sc_d       00011 . . ..... ..... 011 ..... 0101111 @atom_st
+amoswap_d  00001 . . ..... ..... 011 ..... 0101111 @atom_st
+amoadd_d   00000 . . ..... ..... 011 ..... 0101111 @atom_st
+amoxor_d   00100 . . ..... ..... 011 ..... 0101111 @atom_st
+amoand_d   01100 . . ..... ..... 011 ..... 0101111 @atom_st
+amoor_d    01000 . . ..... ..... 011 ..... 0101111 @atom_st
+amomin_d   10000 . . ..... ..... 011 ..... 0101111 @atom_st
+amomax_d   10100 . . ..... ..... 011 ..... 0101111 @atom_st
+amominu_d  11000 . . ..... ..... 011 ..... 0101111 @atom_st
+amomaxu_d  11100 . . ..... ..... 011 ..... 0101111 @atom_st
diff --git a/target/riscv/insn_trans/trans_rva.inc.c b/target/riscv/insn_trans/trans_rva.inc.c
index 2cb2bfd9cc..06616982c6 100644
--- a/target/riscv/insn_trans/trans_rva.inc.c
+++ b/target/riscv/insn_trans/trans_rva.inc.c
@@ -173,3 +173,102 @@ static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a, uint32_t insn)
 {
     return gen_amo(ctx, a, OPC_RISC_AMOMAXU, (MO_ALIGN | MO_TESL));
 }
+
+static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a, uint32_t insn)
+{
+#ifdef TARGET_RISCV64
+    return gen_lr(ctx, a, MO_ALIGN | MO_TEQ);
+#else
+    return false;
+#endif
+}
+
+static bool trans_sc_d(DisasContext *ctx, arg_sc_d *a, uint32_t insn)
+{
+#ifdef TARGET_RISCV64
+    return gen_sc(ctx, a, (MO_ALIGN | MO_TEQ));
+#else
+    return false;
+#endif
+}
+
+static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a, uint32_t insn)
+{
+#ifdef TARGET_RISCV64
+    return gen_amo(ctx, a, OPC_RISC_AMOSWAP, (MO_ALIGN | MO_TEQ));
+#else
+    return false;
+#endif
+}
+
+static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a, uint32_t insn)
+{
+#ifdef TARGET_RISCV64
+    return gen_amo(ctx, a, OPC_RISC_AMOADD, (MO_ALIGN | MO_TEQ));
+#else
+    return false;
+#endif
+}
+
+static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a, uint32_t insn)
+{
+#ifdef TARGET_RISCV64
+    return gen_amo(ctx, a, OPC_RISC_AMOXOR, (MO_ALIGN | MO_TEQ));
+#else
+    return false;
+#endif
+}
+
+static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a, uint32_t insn)
+{
+#ifdef TARGET_RISCV64
+    return gen_amo(ctx, a, OPC_RISC_AMOAND, (MO_ALIGN | MO_TEQ));
+#else
+    return false;
+#endif
+}
+
+static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a, uint32_t insn)
+{
+#ifdef TARGET_RISCV64
+    return gen_amo(ctx, a, OPC_RISC_AMOOR, (MO_ALIGN | MO_TEQ));
+#else
+    return false;
+#endif
+}
+
+static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a, uint32_t insn)
+{
+#ifdef TARGET_RISCV64
+    return gen_amo(ctx, a, OPC_RISC_AMOMIN, (MO_ALIGN | MO_TEQ));
+#else
+    return false;
+#endif
+}
+
+static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a, uint32_t insn)
+{
+#ifdef TARGET_RISCV64
+    return gen_amo(ctx, a, OPC_RISC_AMOMAX, (MO_ALIGN | MO_TEQ));
+#else
+    return false;
+#endif
+}
+
+static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a, uint32_t insn)
+{
+#ifdef TARGET_RISCV64
+    return gen_amo(ctx, a, OPC_RISC_AMOMINU, (MO_ALIGN | MO_TEQ));
+#else
+    return false;
+#endif
+}
+
+static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a, uint32_t insn)
+{
+#ifdef TARGET_RISCV64
+    return gen_amo(ctx, a, OPC_RISC_AMOMAXU, (MO_ALIGN | MO_TEQ));
+#else
+    return false;
+#endif
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 760ed88162..1f6d58cb7e 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -710,143 +710,6 @@ static void gen_fp_store(DisasContext *ctx, uint32_t opc, int rs1,
     tcg_temp_free(t0);
 }
 
-static void gen_atomic(DisasContext *ctx, uint32_t opc,
-                      int rd, int rs1, int rs2)
-{
-    TCGv src1, src2, dat;
-    TCGLabel *l1, *l2;
-    TCGMemOp mop;
-    bool aq, rl;
-
-    /* Extract the size of the atomic operation.  */
-    switch (extract32(opc, 12, 3)) {
-    case 2: /* 32-bit */
-        mop = MO_ALIGN | MO_TESL;
-        break;
-#if defined(TARGET_RISCV64)
-    case 3: /* 64-bit */
-        mop = MO_ALIGN | MO_TEQ;
-        break;
-#endif
-    default:
-        gen_exception_illegal(ctx);
-        return;
-    }
-    rl = extract32(opc, 25, 1);
-    aq = extract32(opc, 26, 1);
-
-    src1 = tcg_temp_new();
-    src2 = tcg_temp_new();
-
-    switch (MASK_OP_ATOMIC_NO_AQ_RL_SZ(opc)) {
-    case OPC_RISC_LR:
-        /* Put addr in load_res, data in load_val.  */
-        gen_get_gpr(src1, rs1);
-        if (rl) {
-            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
-        }
-        tcg_gen_qemu_ld_tl(load_val, src1, ctx->mem_idx, mop);
-        if (aq) {
-            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
-        }
-        tcg_gen_mov_tl(load_res, src1);
-        gen_set_gpr(rd, load_val);
-        break;
-
-    case OPC_RISC_SC:
-        l1 = gen_new_label();
-        l2 = gen_new_label();
-        dat = tcg_temp_new();
-
-        gen_get_gpr(src1, rs1);
-        tcg_gen_brcond_tl(TCG_COND_NE, load_res, src1, l1);
-
-        gen_get_gpr(src2, rs2);
-        /* Note that the TCG atomic primitives are SC,
-           so we can ignore AQ/RL along this path.  */
-        tcg_gen_atomic_cmpxchg_tl(src1, load_res, load_val, src2,
-                                  ctx->mem_idx, mop);
-        tcg_gen_setcond_tl(TCG_COND_NE, dat, src1, load_val);
-        gen_set_gpr(rd, dat);
-        tcg_gen_br(l2);
-
-        gen_set_label(l1);
-        /* Address comparion failure.  However, we still need to
-           provide the memory barrier implied by AQ/RL.  */
-        tcg_gen_mb(TCG_MO_ALL + aq * TCG_BAR_LDAQ + rl * TCG_BAR_STRL);
-        tcg_gen_movi_tl(dat, 1);
-        gen_set_gpr(rd, dat);
-
-        gen_set_label(l2);
-        tcg_temp_free(dat);
-        break;
-
-    case OPC_RISC_AMOSWAP:
-        /* Note that the TCG atomic primitives are SC,
-           so we can ignore AQ/RL along this path.  */
-        gen_get_gpr(src1, rs1);
-        gen_get_gpr(src2, rs2);
-        tcg_gen_atomic_xchg_tl(src2, src1, src2, ctx->mem_idx, mop);
-        gen_set_gpr(rd, src2);
-        break;
-    case OPC_RISC_AMOADD:
-        gen_get_gpr(src1, rs1);
-        gen_get_gpr(src2, rs2);
-        tcg_gen_atomic_fetch_add_tl(src2, src1, src2, ctx->mem_idx, mop);
-        gen_set_gpr(rd, src2);
-        break;
-    case OPC_RISC_AMOXOR:
-        gen_get_gpr(src1, rs1);
-        gen_get_gpr(src2, rs2);
-        tcg_gen_atomic_fetch_xor_tl(src2, src1, src2, ctx->mem_idx, mop);
-        gen_set_gpr(rd, src2);
-        break;
-    case OPC_RISC_AMOAND:
-        gen_get_gpr(src1, rs1);
-        gen_get_gpr(src2, rs2);
-        tcg_gen_atomic_fetch_and_tl(src2, src1, src2, ctx->mem_idx, mop);
-        gen_set_gpr(rd, src2);
-        break;
-    case OPC_RISC_AMOOR:
-        gen_get_gpr(src1, rs1);
-        gen_get_gpr(src2, rs2);
-        tcg_gen_atomic_fetch_or_tl(src2, src1, src2, ctx->mem_idx, mop);
-        gen_set_gpr(rd, src2);
-        break;
-    case OPC_RISC_AMOMIN:
-        gen_get_gpr(src1, rs1);
-        gen_get_gpr(src2, rs2);
-        tcg_gen_atomic_fetch_smin_tl(src2, src1, src2, ctx->mem_idx, mop);
-        gen_set_gpr(rd, src2);
-        break;
-    case OPC_RISC_AMOMAX:
-        gen_get_gpr(src1, rs1);
-        gen_get_gpr(src2, rs2);
-        tcg_gen_atomic_fetch_smax_tl(src2, src1, src2, ctx->mem_idx, mop);
-        gen_set_gpr(rd, src2);
-        break;
-    case OPC_RISC_AMOMINU:
-        gen_get_gpr(src1, rs1);
-        gen_get_gpr(src2, rs2);
-        tcg_gen_atomic_fetch_umin_tl(src2, src1, src2, ctx->mem_idx, mop);
-        gen_set_gpr(rd, src2);
-        break;
-    case OPC_RISC_AMOMAXU:
-        gen_get_gpr(src1, rs1);
-        gen_get_gpr(src2, rs2);
-        tcg_gen_atomic_fetch_umax_tl(src2, src1, src2, ctx->mem_idx, mop);
-        gen_set_gpr(rd, src2);
-        break;
-
-    default:
-        gen_exception_illegal(ctx);
-        break;
-    }
-
-    tcg_temp_free(src1);
-    tcg_temp_free(src2);
-}
-
 static void gen_set_rm(DisasContext *ctx, int rm)
 {
     TCGv_i32 t0;
@@ -1668,9 +1531,6 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
         gen_fp_store(ctx, MASK_OP_FP_STORE(ctx->opcode), rs1, rs2,
                      GET_STORE_IMM(ctx->opcode));
         break;
-    case OPC_RISC_ATOMIC:
-        gen_atomic(ctx, MASK_OP_ATOMIC(ctx->opcode), rd, rs1, rs2);
-        break;
     case OPC_RISC_FMADD:
         gen_fp_fmadd(ctx, MASK_OP_FP_FMADD(ctx->opcode), rd, rs1, rs2,
                      GET_RS3(ctx->opcode), GET_RM(ctx->opcode));
-- 
2.19.1
