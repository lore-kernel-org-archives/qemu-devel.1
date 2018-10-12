Received: from eggs.gnu.org ([2001:4830:134:3::10]:40103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1Ht-00020N-DV
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1Hq-0000S6-5p
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:45 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:42814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gB1Hp-0000EH-RG
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:42 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri, 12 Oct 2018 19:30:40 +0200
Message-Id: <20181012173047.25420-22-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 21/28] target/riscv: Replace gen_store() with
 trans_store()
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
as gen_store() did.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn_trans/trans_rvi.inc.c | 31 ++++++++++++++++------
 target/riscv/translate.c                | 34 -------------------------
 2 files changed, 23 insertions(+), 42 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index 873a5e8b53..b09c52a708 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -192,27 +192,42 @@ static bool trans_ld(DisasContext *ctx, arg_ld *a, uint32_t insn)
 #endif
 }
 
-static bool trans_sb(DisasContext *ctx, arg_sb *a, uint32_t insn)
+static bool trans_store(DisasContext *ctx, arg_sb *a, int memop)
 {
-    gen_store(ctx, OPC_RISC_SB, a->rs1, a->rs2, a->imm);
+    TCGv t0 = tcg_temp_new();
+    TCGv dat = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+    tcg_gen_addi_tl(t0, t0, a->imm);
+    gen_get_gpr(dat, a->rs2);
+
+    if (memop < 0) {
+        return false;
+    }
+
+    tcg_gen_qemu_st_tl(dat, t0, ctx->mem_idx, memop);
+    tcg_temp_free(t0);
+    tcg_temp_free(dat);
     return true;
 }
+
+static bool trans_sb(DisasContext *ctx, arg_sb *a, uint32_t insn)
+{
+    return trans_store(ctx, a, MO_SB);
+}
 static bool trans_sh(DisasContext *ctx, arg_sh *a, uint32_t insn)
 {
-    gen_store(ctx, OPC_RISC_SH, a->rs1, a->rs2, a->imm);
-    return true;
+    return trans_store(ctx, a, MO_TESW);
 }
+
 static bool trans_sw(DisasContext *ctx, arg_sw *a, uint32_t insn)
 {
-    gen_store(ctx, OPC_RISC_SW, a->rs1, a->rs2, a->imm);
-    return true;
+    return trans_store(ctx, a, MO_TESL);
 }
 
 static bool trans_sd(DisasContext *ctx, arg_sd *a, uint32_t insn)
 {
 #ifdef TARGET_RISCV64
-    gen_store(ctx, OPC_RISC_SD, a->rs1, a->rs2, a->imm);
-    return true;
+    return trans_store(ctx, a, MO_TEQ);
 #else
     return false;
 #endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 544e71a46c..feae31cb94 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -54,20 +54,6 @@ typedef struct DisasContext {
     int frm;
 } DisasContext;
 
-/* convert riscv funct3 to qemu memop for load/store */
-static const int tcg_memop_lookup[8] = {
-    [0 ... 7] = -1,
-    [0] = MO_SB,
-    [1] = MO_TESW,
-    [2] = MO_TESL,
-    [4] = MO_UB,
-    [5] = MO_TEUW,
-#ifdef TARGET_RISCV64
-    [3] = MO_TEQ,
-    [6] = MO_TEUL,
-#endif
-};
-
 #ifdef TARGET_RISCV64
 #define CASE_OP_32_64(X) case X: case glue(X, W)
 #else
@@ -488,26 +474,6 @@ static void gen_jal(CPURISCVState *env, DisasContext *ctx, int rd,
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_store(DisasContext *ctx, uint32_t opc, int rs1, int rs2,
-        target_long imm)
-{
-    TCGv t0 = tcg_temp_new();
-    TCGv dat = tcg_temp_new();
-    gen_get_gpr(t0, rs1);
-    tcg_gen_addi_tl(t0, t0, imm);
-    gen_get_gpr(dat, rs2);
-    int memop = tcg_memop_lookup[(opc >> 12) & 0x7];
-
-    if (memop < 0) {
-        gen_exception_illegal(ctx);
-        return;
-    }
-
-    tcg_gen_qemu_st_tl(dat, t0, ctx->mem_idx, memop);
-    tcg_temp_free(t0);
-    tcg_temp_free(dat);
-}
-
 static void gen_set_rm(DisasContext *ctx, int rm)
 {
     TCGv_i32 t0;
-- 
2.19.1
