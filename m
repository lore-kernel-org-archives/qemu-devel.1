Received: from eggs.gnu.org ([209.51.188.92]:59810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwtP-000205-Vw
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwtM-0002xU-CP
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:56:11 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:37817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gtwtM-0000ue-1H
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:56:08 -0500
Received: by mail-pg1-x52f.google.com with SMTP id q206so1317266pgq.4
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 07:54:44 -0800 (PST)
Date: Wed, 13 Feb 2019 07:53:43 -0800
Message-Id: <20190213155414.22285-5-palmer@sifive.com>
In-Reply-To: <20190213155414.22285-1-palmer@sifive.com>
References: <20190213155414.22285-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PATCH v7 04/35] target/riscv: Convert RV32I
 load/store insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>

From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn32.decode              | 10 ++++++
 target/riscv/insn_trans/trans_rvi.inc.c | 48 +++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 81f56c16b45f..076de873c4f1 100644
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
 @b       .......   ..... ..... ... ..... ....... &b      imm=%imm_b %rs2 %rs1
+@s       .......   ..... ..... ... ..... .......         imm=%imm_s %rs2 %rs1
 @u       ....................      ..... .......         imm=%imm_u          %rd
 @j       ....................      ..... .......         imm=%imm_j          %rd
 
@@ -47,3 +49,11 @@ blt      ....... .....    ..... 100 ..... 1100011 @b
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
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index bcf20def50eb..d13b7b2b6d8f 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -82,3 +82,51 @@ static bool trans_bgeu(DisasContext *ctx, arg_bgeu *a)
     gen_branch(ctx, OPC_RISC_BGEU, a->rs1, a->rs2, a->imm);
     return true;
 }
+
+static bool trans_lb(DisasContext *ctx, arg_lb *a)
+{
+    gen_load(ctx, OPC_RISC_LB, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_lh(DisasContext *ctx, arg_lh *a)
+{
+    gen_load(ctx, OPC_RISC_LH, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_lw(DisasContext *ctx, arg_lw *a)
+{
+    gen_load(ctx, OPC_RISC_LW, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_lbu(DisasContext *ctx, arg_lbu *a)
+{
+    gen_load(ctx, OPC_RISC_LBU, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_lhu(DisasContext *ctx, arg_lhu *a)
+{
+    gen_load(ctx, OPC_RISC_LHU, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_sb(DisasContext *ctx, arg_sb *a)
+{
+    gen_store(ctx, OPC_RISC_SB, a->rs1, a->rs2, a->imm);
+    return true;
+}
+
+static bool trans_sh(DisasContext *ctx, arg_sh *a)
+{
+    gen_store(ctx, OPC_RISC_SH, a->rs1, a->rs2, a->imm);
+    return true;
+}
+
+static bool trans_sw(DisasContext *ctx, arg_sw *a)
+{
+    gen_store(ctx, OPC_RISC_SW, a->rs1, a->rs2, a->imm);
+    return true;
+}
-- 
2.18.1
