Received: from eggs.gnu.org ([209.51.188.92]:46243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gmF4R-00026l-Gm
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gmEoU-0007iN-Ls
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:27:17 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Wed, 23 Jan 2019 10:25:26 +0100
Message-Id: <20190123092538.8004-24-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20190123092538.8004-1-kbastian@mail.uni-paderborn.de>
References: <20190123092538.8004-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 23/35] target/riscv: Remove manual decoding
 from gen_store()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sagark@eecs.berkeley.edu, palmer@sifive.com, kbastian@mail.uni-paderborn.de
Cc: qemu-riscv@nongnu.org, peer.adelt@hni.uni-paderborn.de, richard.henderson@linaro.org, qemu-devel@nongnu.org

With decodetree we don't need to convert RISC-V opcodes into to MemOps
as the old gen_store() did.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn_trans/trans_rvi.inc.c | 27 +++++++++++++++++--------
 target/riscv/translate.c                |  8 +++++---
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index 1ad00bd776..da843b4e99 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -168,22 +168,34 @@ static bool trans_lhu(DisasContext *ctx, arg_lhu *a)
     return gen_load(ctx, a, MO_TEUW);
 }
 
-static bool trans_sb(DisasContext *ctx, arg_sb *a)
+static bool gen_store(DisasContext *ctx, arg_sb *a, TCGMemOp memop)
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
+static bool trans_sb(DisasContext *ctx, arg_sb *a)
+{
+    return gen_store(ctx, a, MO_SB);
+}
+
 static bool trans_sh(DisasContext *ctx, arg_sh *a)
 {
-    gen_store(ctx, OPC_RISC_SH, a->rs1, a->rs2, a->imm);
-    return true;
+    return gen_store(ctx, a, MO_TESW);
 }
 
 static bool trans_sw(DisasContext *ctx, arg_sw *a)
 {
-    gen_store(ctx, OPC_RISC_SW, a->rs1, a->rs2, a->imm);
-    return true;
+    return gen_store(ctx, a, MO_TESL);
 }
 
 #ifdef TARGET_RISCV64
@@ -199,8 +211,7 @@ static bool trans_ld(DisasContext *ctx, arg_ld *a)
 
 static bool trans_sd(DisasContext *ctx, arg_sd *a)
 {
-    gen_store(ctx, OPC_RISC_SD, a->rs1, a->rs2, a->imm);
-    return true;
+    return gen_store(ctx, a, MO_TEQ);
 }
 #endif
 
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index d0fefa8fb9..59452be191 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -55,6 +55,7 @@ typedef struct DisasContext {
     CPURISCVState *env;
 } DisasContext;
 
+#ifdef TARGET_RISCV64
 /* convert riscv funct3 to qemu memop for load/store */
 static const int tcg_memop_lookup[8] = {
     [0 ... 7] = -1,
@@ -68,6 +69,7 @@ static const int tcg_memop_lookup[8] = {
     [6] = MO_TEUL,
 #endif
 };
+#endif
 
 #ifdef TARGET_RISCV64
 #define CASE_OP_32_64(X) case X: case glue(X, W)
@@ -509,9 +511,8 @@ static void gen_load_c(DisasContext *ctx, uint32_t opc, int rd, int rs1,
     tcg_temp_free(t0);
     tcg_temp_free(t1);
 }
-#endif
 
-static void gen_store(DisasContext *ctx, uint32_t opc, int rs1, int rs2,
+static void gen_store_c(DisasContext *ctx, uint32_t opc, int rs1, int rs2,
         target_long imm)
 {
     TCGv t0 = tcg_temp_new();
@@ -530,6 +531,7 @@ static void gen_store(DisasContext *ctx, uint32_t opc, int rs1, int rs2,
     tcg_temp_free(t0);
     tcg_temp_free(dat);
 }
+#endif
 
 #ifdef TARGET_RISCV32
 static void gen_fp_load(DisasContext *ctx, uint32_t opc, int rd,
@@ -653,7 +655,7 @@ static void decode_RV32_64C0(DisasContext *ctx)
     case 7:
 #if defined(TARGET_RISCV64)
         /* C.SD (RV64/128) -> sd rs2', offset[7:3](rs1')*/
-        gen_store(ctx, OPC_RISC_SD, rs1s, rd_rs2,
+        gen_store_c(ctx, OPC_RISC_SD, rs1s, rd_rs2,
                   GET_C_LD_IMM(ctx->opcode));
 #else
         /* C.FSW (RV32) -> fsw rs2', offset[6:2](rs1')*/
-- 
2.20.1
