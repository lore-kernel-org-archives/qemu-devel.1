Received: from eggs.gnu.org ([2001:4830:134:3::10]:40067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1Hr-0001xt-AI
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1Ho-0000Qg-2A
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:43 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:37146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gB1Hn-0000EC-N1
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:39 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri, 12 Oct 2018 19:30:39 +0200
Message-Id: <20181012173047.25420-21-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 20/28] target/riscv: Replace gen_load() with
 trans_load()
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

With decodetree we don't need to convert RISC-V opcodes into to MemOps
as gen_load() did.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn_trans/trans_rvi.inc.c | 44 +++++++++++++++++--------
 target/riscv/translate.c                | 20 -----------
 2 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index 6097b82df4..873a5e8b53 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -131,46 +131,62 @@ static bool trans_bgeu(DisasContext *ctx, arg_bgeu *a, uint32_t insn)
     return trans_branch(ctx, a, TCG_COND_GEU);
 }
 
-static bool trans_lb(DisasContext *ctx, arg_lb *a, uint32_t insn)
+static bool trans_load(DisasContext *ctx, arg_lb *a, int memop)
 {
-    gen_load(ctx, OPC_RISC_LB, a->rd, a->rs1, a->imm);
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+    tcg_gen_addi_tl(t0, t0, a->imm);
+
+    if (memop < 0) {
+        return false;
+    }
+
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, memop);
+    gen_set_gpr(a->rd, t1);
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
     return true;
 }
+
+static bool trans_lb(DisasContext *ctx, arg_lb *a, uint32_t insn)
+{
+    return trans_load(ctx, a, MO_SB);
+}
+
 static bool trans_lh(DisasContext *ctx, arg_lh *a, uint32_t insn)
 {
-    gen_load(ctx, OPC_RISC_LH, a->rd, a->rs1, a->imm);
-    return true;
+    return trans_load(ctx, a, MO_TESW);
 }
+
 static bool trans_lw(DisasContext *ctx, arg_lw *a, uint32_t insn)
 {
-    gen_load(ctx, OPC_RISC_LW, a->rd, a->rs1, a->imm);
-    return true;
+    return trans_load(ctx, a, MO_TESL);
 }
+
 static bool trans_lbu(DisasContext *ctx, arg_lbu *a, uint32_t insn)
 {
-    gen_load(ctx, OPC_RISC_LBU, a->rd, a->rs1, a->imm);
-    return true;
+    return trans_load(ctx, a, MO_UB);
 }
+
 static bool trans_lhu(DisasContext *ctx, arg_lhu *a, uint32_t insn)
 {
-    gen_load(ctx, OPC_RISC_LHU, a->rd, a->rs1, a->imm);
-    return true;
+    return trans_load(ctx, a, MO_TEUW);
 }
 
 static bool trans_lwu(DisasContext *ctx, arg_lwu *a, uint32_t insn)
 {
 #ifdef TARGET_RISCV64
-    gen_load(ctx, OPC_RISC_LWU, a->rd, a->rs1, a->imm);
-    return true;
+    return trans_load(ctx, a, MO_TEUL);
 #else
     return false;
 #endif
 }
+
 static bool trans_ld(DisasContext *ctx, arg_ld *a, uint32_t insn)
 {
 #ifdef TARGET_RISCV64
-    gen_load(ctx, OPC_RISC_LD, a->rd, a->rs1, a->imm);
-    return true;
+    return trans_load(ctx, a, MO_TEQ);
 #else
     return false;
 #endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index b8a9b1c64b..544e71a46c 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -488,26 +488,6 @@ static void gen_jal(CPURISCVState *env, DisasContext *ctx, int rd,
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_load(DisasContext *ctx, uint32_t opc, int rd, int rs1,
-        target_long imm)
-{
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    gen_get_gpr(t0, rs1);
-    tcg_gen_addi_tl(t0, t0, imm);
-    int memop = tcg_memop_lookup[(opc >> 12) & 0x7];
-
-    if (memop < 0) {
-        gen_exception_illegal(ctx);
-        return;
-    }
-
-    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, memop);
-    gen_set_gpr(rd, t1);
-    tcg_temp_free(t0);
-    tcg_temp_free(t1);
-}
-
 static void gen_store(DisasContext *ctx, uint32_t opc, int rs1, int rs2,
         target_long imm)
 {
-- 
2.19.1
