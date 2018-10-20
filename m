Received: from eggs.gnu.org ([2001:4830:134:3::10]:41041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlU0-0002SV-8f
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlTu-0004em-EF
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:36 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:50188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gDlTq-0004S8-FS
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:28 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Sat, 20 Oct 2018 09:14:44 +0200
Message-Id: <20181020071451.27808-23-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 22/29] target/riscv: Remove manual decoding
 from gen_store()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, kbastian@mail.uni-paderborn.de
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, richard.henderson@linaro.org, qemu-devel@nongnu.org

With decodetree we don't need to convert RISC-V opcodes into to MemOps
as the old gen_store() did.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
v1 -> v2:
   - trans_store -> gen_store
    - removed negative memop check

 target/riscv/insn_trans/trans_rvi.inc.c | 27 ++++++++++++++------
 target/riscv/translate.c                | 34 -------------------------
 2 files changed, 19 insertions(+), 42 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index 77fa66b7cd..48cc50d35f 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -186,29 +186,40 @@ static bool trans_ld(DisasContext *ctx, arg_ld *a, uint32_t insn)
 #endif
 }
 
-static bool trans_sb(DisasContext *ctx, arg_sb *a, uint32_t insn)
+static bool gen_store(DisasContext *ctx, arg_sb *a, int memop)
 {
-    gen_store(ctx, OPC_RISC_SB, a->rs1, a->rs2, a->imm);
+    TCGv t0 = tcg_temp_new();
+    TCGv dat = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+    tcg_gen_addi_tl(t0, t0, a->imm);
+    gen_get_gpr(dat, a->rs2);
+
+    tcg_gen_qemu_st_tl(dat, t0, ctx->mem_idx, memop);
+    tcg_temp_free(t0);
+    tcg_temp_free(dat);
     return true;
 }
 
+
+static bool trans_sb(DisasContext *ctx, arg_sb *a, uint32_t insn)
+{
+    return gen_store(ctx, a, MO_SB);
+}
+
 static bool trans_sh(DisasContext *ctx, arg_sh *a, uint32_t insn)
 {
-    gen_store(ctx, OPC_RISC_SH, a->rs1, a->rs2, a->imm);
-    return true;
+    return gen_store(ctx, a, MO_TESW);
 }
 
 static bool trans_sw(DisasContext *ctx, arg_sw *a, uint32_t insn)
 {
-    gen_store(ctx, OPC_RISC_SW, a->rs1, a->rs2, a->imm);
-    return true;
+    return gen_store(ctx, a, MO_TESL);
 }
 
 static bool trans_sd(DisasContext *ctx, arg_sd *a, uint32_t insn)
 {
 #ifdef TARGET_RISCV64
-    gen_store(ctx, OPC_RISC_SD, a->rs1, a->rs2, a->imm);
-    return true;
+    return gen_store(ctx, a, MO_TEQ);
 #else
     return false;
 #endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 947fb9345b..a8dbd00b99 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -55,20 +55,6 @@ typedef struct DisasContext {
     CPURISCVState *env;
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
@@ -489,26 +475,6 @@ static void gen_jal(CPURISCVState *env, DisasContext *ctx, int rd,
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
