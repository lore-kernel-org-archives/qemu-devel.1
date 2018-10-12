Received: from eggs.gnu.org ([2001:4830:134:3::10]:39893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1Hj-0001rQ-5t
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1Hh-0000IF-Nj
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:35 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:33836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gB1Hf-00006M-LZ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:31 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri, 12 Oct 2018 19:30:38 +0200
Message-Id: <20181012173047.25420-20-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 19/28] target/riscv: Replace gen_branch() with
 trans_branch()
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

The latter utilizes argument-sets of decodetree such that no manual
decoding is necessary as in gen_branch().

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn_trans/trans_rvi.inc.c | 56 +++++++++++++++++--------
 target/riscv/translate.c                | 47 ---------------------
 2 files changed, 38 insertions(+), 65 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index 2668beb990..6097b82df4 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -73,42 +73,62 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a, uint32_t insn)
     return true;
 }
 
-static bool trans_beq(DisasContext *ctx, arg_beq *a, uint32_t insn)
+static bool trans_branch(DisasContext *ctx, arg_branch *a, TCGCond cond)
 {
+    TCGLabel *l = gen_new_label();
+    TCGv source1, source2;
+    source1 = tcg_temp_new();
+    source2 = tcg_temp_new();
+    gen_get_gpr(source1, a->rs1);
+    gen_get_gpr(source2, a->rs2);
+
+    tcg_gen_brcond_tl(cond, source1, source2, l);
+    gen_goto_tb(ctx, 1, ctx->pc_succ_insn);
+    gen_set_label(l); /* branch taken */
+
     CPURISCVState *env = current_cpu->env_ptr;
-    gen_branch(env, ctx, OPC_RISC_BEQ, a->rs1, a->rs2, a->imm);
+    if (!riscv_has_ext(env, RVC) && ((ctx->base.pc_next + a->imm) & 0x3)) {
+        /* misaligned */
+        gen_exception_inst_addr_mis(ctx);
+    } else {
+        gen_goto_tb(ctx, 0, ctx->base.pc_next + a->imm);
+    }
+    ctx->base.is_jmp = DISAS_NORETURN;
+
+    tcg_temp_free(source1);
+    tcg_temp_free(source2);
+
     return true;
 }
+
+static bool trans_beq(DisasContext *ctx, arg_beq *a, uint32_t insn)
+{
+    return trans_branch(ctx, a, TCG_COND_EQ);
+}
+
 static bool trans_bne(DisasContext *ctx, arg_bne *a, uint32_t insn)
 {
-    CPURISCVState *env = current_cpu->env_ptr;
-    gen_branch(env, ctx, OPC_RISC_BNE, a->rs1, a->rs2, a->imm);
-    return true;
+    return trans_branch(ctx, a, TCG_COND_NE);
 }
+
 static bool trans_blt(DisasContext *ctx, arg_blt *a, uint32_t insn)
 {
-    CPURISCVState *env = current_cpu->env_ptr;
-    gen_branch(env, ctx, OPC_RISC_BLT, a->rs1, a->rs2, a->imm);
-    return true;
+    return trans_branch(ctx, a, TCG_COND_LT);
 }
+
 static bool trans_bge(DisasContext *ctx, arg_bge *a, uint32_t insn)
 {
-    CPURISCVState *env = current_cpu->env_ptr;
-    gen_branch(env, ctx, OPC_RISC_BGE, a->rs1, a->rs2, a->imm);
-    return true;
+    return trans_branch(ctx, a, TCG_COND_GE);
 }
+
 static bool trans_bltu(DisasContext *ctx, arg_bltu *a, uint32_t insn)
 {
-    CPURISCVState *env = current_cpu->env_ptr;
-    gen_branch(env, ctx, OPC_RISC_BLTU, a->rs1, a->rs2, a->imm);
-    return true;
+    return trans_branch(ctx, a, TCG_COND_LTU);
 }
+
 static bool trans_bgeu(DisasContext *ctx, arg_bgeu *a, uint32_t insn)
 {
-
-    CPURISCVState *env = current_cpu->env_ptr;
-    gen_branch(env, ctx, OPC_RISC_BGEU, a->rs1, a->rs2, a->imm);
-    return true;
+    return trans_branch(ctx, a, TCG_COND_GEU);
 }
 
 static bool trans_lb(DisasContext *ctx, arg_lb *a, uint32_t insn)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index a0da694aa3..b8a9b1c64b 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -488,53 +488,6 @@ static void gen_jal(CPURISCVState *env, DisasContext *ctx, int rd,
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_branch(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
-                       int rs1, int rs2, target_long bimm)
-{
-    TCGLabel *l = gen_new_label();
-    TCGv source1, source2;
-    source1 = tcg_temp_new();
-    source2 = tcg_temp_new();
-    gen_get_gpr(source1, rs1);
-    gen_get_gpr(source2, rs2);
-
-    switch (opc) {
-    case OPC_RISC_BEQ:
-        tcg_gen_brcond_tl(TCG_COND_EQ, source1, source2, l);
-        break;
-    case OPC_RISC_BNE:
-        tcg_gen_brcond_tl(TCG_COND_NE, source1, source2, l);
-        break;
-    case OPC_RISC_BLT:
-        tcg_gen_brcond_tl(TCG_COND_LT, source1, source2, l);
-        break;
-    case OPC_RISC_BGE:
-        tcg_gen_brcond_tl(TCG_COND_GE, source1, source2, l);
-        break;
-    case OPC_RISC_BLTU:
-        tcg_gen_brcond_tl(TCG_COND_LTU, source1, source2, l);
-        break;
-    case OPC_RISC_BGEU:
-        tcg_gen_brcond_tl(TCG_COND_GEU, source1, source2, l);
-        break;
-    default:
-        gen_exception_illegal(ctx);
-        return;
-    }
-    tcg_temp_free(source1);
-    tcg_temp_free(source2);
-
-    gen_goto_tb(ctx, 1, ctx->pc_succ_insn);
-    gen_set_label(l); /* branch taken */
-    if (!riscv_has_ext(env, RVC) && ((ctx->base.pc_next + bimm) & 0x3)) {
-        /* misaligned */
-        gen_exception_inst_addr_mis(ctx);
-    } else {
-        gen_goto_tb(ctx, 0, ctx->base.pc_next + bimm);
-    }
-    ctx->base.is_jmp = DISAS_NORETURN;
-}
-
 static void gen_load(DisasContext *ctx, uint32_t opc, int rd, int rs1,
         target_long imm)
 {
-- 
2.19.1
