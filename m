Received: from eggs.gnu.org ([2001:4830:134:3::10]:40759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlTV-00021Q-EK
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlTS-0004Dn-CH
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:05 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:33720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gDlTS-0004D6-1F
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:02 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Sat, 20 Oct 2018 09:14:26 +0200
Message-Id: <20181020071451.27808-5-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 04/29] target/riscv: Convert RVXI load/store
 insns to decodetree
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
v1 -> v2:
    - fixed spacing

 target/riscv/insn32.decode              | 15 +++++
 target/riscv/insn_trans/trans_rvi.inc.c | 78 +++++++++++++++++++++++++
 target/riscv/translate.c                |  7 ---
 3 files changed, 93 insertions(+), 7 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b49913416d..badd1d9216 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -23,6 +23,7 @@
 
 # immediates:
 %imm_i    20:s12
+%imm_s    25:s7 7:5
 %imm_b    31:s1 7:1 25:6 8:4     !function=ex_shift_1
 %imm_j    31:s1 12:8 20:1 21:10  !function=ex_shift_1
 %imm_u    12:s20                 !function=ex_shift_12
@@ -33,6 +34,7 @@
 # Formats 32:
 @i       ............    ..... ... ..... .......         imm=%imm_i     %rs1 %rd
 @b       .......   ..... ..... ... ..... ....... &branch imm=%imm_b %rs2 %rs1
+@s       .......   ..... ..... ... ..... .......         imm=%imm_s %rs2 %rs1
 @u       ....................      ..... .......         imm=%imm_u          %rd
 @j       ....................      ..... .......         imm=%imm_j          %rd
 
@@ -47,3 +49,16 @@ blt      ....... .....    ..... 100 ..... 1100011 @b
 bge      ....... .....    ..... 101 ..... 1100011 @b
 bltu     ....... .....    ..... 110 ..... 1100011 @b
 bgeu     ....... .....    ..... 111 ..... 1100011 @b
+lb       ............     ..... 000 ..... 0000011 @i
+lh       ............     ..... 001 ..... 0000011 @i
+lw       ............     ..... 010 ..... 0000011 @i
+lbu      ............     ..... 100 ..... 0000011 @i
+lhu      ............     ..... 101 ..... 0000011 @i
+sb       .......  .....   ..... 000 ..... 0100011 @s
+sh       .......  .....   ..... 001 ..... 0100011 @s
+sw       .......  .....   ..... 010 ..... 0100011 @s
+
+# *** RV64I Base Instruction Set (in addition to RV32I) ***
+lwu      ............   ..... 110 ..... 0000011 @i
+ld       ............   ..... 011 ..... 0000011 @i
+sd       ....... .....  ..... 011 ..... 0100011 @s
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index 3935a80ba5..2c8ecff76f 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -82,3 +82,81 @@ static bool trans_bgeu(DisasContext *ctx, arg_bgeu *a, uint32_t insn)
     gen_branch(ctx->env, ctx, OPC_RISC_BGEU, a->rs1, a->rs2, a->imm);
     return true;
 }
+
+static bool trans_lb(DisasContext *ctx, arg_lb *a, uint32_t insn)
+{
+    gen_load(ctx, OPC_RISC_LB, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_lh(DisasContext *ctx, arg_lh *a, uint32_t insn)
+{
+    gen_load(ctx, OPC_RISC_LH, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_lw(DisasContext *ctx, arg_lw *a, uint32_t insn)
+{
+    gen_load(ctx, OPC_RISC_LW, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_lbu(DisasContext *ctx, arg_lbu *a, uint32_t insn)
+{
+    gen_load(ctx, OPC_RISC_LBU, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_lhu(DisasContext *ctx, arg_lhu *a, uint32_t insn)
+{
+    gen_load(ctx, OPC_RISC_LHU, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_lwu(DisasContext *ctx, arg_lwu *a, uint32_t insn)
+{
+#ifdef TARGET_RISCV64
+    gen_load(ctx, OPC_RISC_LWU, a->rd, a->rs1, a->imm);
+    return true;
+#else
+    return false;
+#endif
+}
+
+static bool trans_ld(DisasContext *ctx, arg_ld *a, uint32_t insn)
+{
+#ifdef TARGET_RISCV64
+    gen_load(ctx, OPC_RISC_LD, a->rd, a->rs1, a->imm);
+    return true;
+#else
+    return false;
+#endif
+}
+
+static bool trans_sb(DisasContext *ctx, arg_sb *a, uint32_t insn)
+{
+    gen_store(ctx, OPC_RISC_SB, a->rs1, a->rs2, a->imm);
+    return true;
+}
+
+static bool trans_sh(DisasContext *ctx, arg_sh *a, uint32_t insn)
+{
+    gen_store(ctx, OPC_RISC_SH, a->rs1, a->rs2, a->imm);
+    return true;
+}
+
+static bool trans_sw(DisasContext *ctx, arg_sw *a, uint32_t insn)
+{
+    gen_store(ctx, OPC_RISC_SW, a->rs1, a->rs2, a->imm);
+    return true;
+}
+
+static bool trans_sd(DisasContext *ctx, arg_sd *a, uint32_t insn)
+{
+#ifdef TARGET_RISCV64
+    gen_store(ctx, OPC_RISC_SD, a->rs1, a->rs2, a->imm);
+    return true;
+#else
+    return false;
+#endif
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9b6848e666..6b59dbb373 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1701,13 +1701,6 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
     imm = GET_IMM(ctx->opcode);
 
     switch (op) {
-    case OPC_RISC_LOAD:
-        gen_load(ctx, MASK_OP_LOAD(ctx->opcode), rd, rs1, imm);
-        break;
-    case OPC_RISC_STORE:
-        gen_store(ctx, MASK_OP_STORE(ctx->opcode), rs1, rs2,
-                  GET_STORE_IMM(ctx->opcode));
-        break;
     case OPC_RISC_ARITH_IMM:
 #if defined(TARGET_RISCV64)
     case OPC_RISC_ARITH_IMM_W:
-- 
2.19.1
