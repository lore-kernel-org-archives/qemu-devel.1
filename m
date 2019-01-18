Received: from eggs.gnu.org ([209.51.188.92]:41556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gkTzh-0004a9-1K
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:15:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gkTzU-0006ay-6T
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:15:24 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri, 18 Jan 2019 14:14:26 +0100
Message-Id: <20190118131456.32451-6-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20190118131456.32451-1-kbastian@mail.uni-paderborn.de>
References: <20190118131456.32451-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 05/35] target/riscv: Convert RV64I
 load/store insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com, kbastian@mail.uni-paderborn.de
Cc: qemu-riscv@nongnu.org, peer.adelt@hni.uni-paderborn.de, richard.henderson@linaro.org, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>

this splits the 64-bit only instructions into its own decode file such
that we generate the decoder for these instructions only for the RISC-V
64 bit target.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
v3 -> v4:
    - insn64.decode -> insn32-64.decode

 target/riscv/Makefile.objs              |  8 +++++---
 target/riscv/insn32-64.decode           | 25 +++++++++++++++++++++++++
 target/riscv/insn_trans/trans_rvi.inc.c | 20 ++++++++++++++++++++
 target/riscv/translate.c                |  7 -------
 4 files changed, 50 insertions(+), 10 deletions(-)
 create mode 100644 target/riscv/insn32-64.decode

diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
index bf0a268033..05087a91bb 100644
--- a/target/riscv/Makefile.objs
+++ b/target/riscv/Makefile.objs
@@ -2,10 +2,12 @@ obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o gdbstub.o
 
 DECODETREE = $(SRC_PATH)/scripts/decodetree.py
 
-target/riscv/decode_insn32.inc.c: \
-  $(SRC_PATH)/target/riscv/insn32.decode $(DECODETREE)
+decode32-y = $(SRC_PATH)/target/riscv/insn32.decode
+decode32-$(TARGET_RISCV64) += $(SRC_PATH)/target/riscv/insn32-64.decode
+
+target/riscv/decode_insn32.inc.c: $(decode32-y) $(DECODETREE)
 	$(call quiet-command, \
-	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn32 $<, \
+	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn32 $(decode32-y), \
 	  "GEN", $(TARGET_DIR)$@)
 
 target/riscv/translate.o: target/riscv/decode_insn32.inc.c
diff --git a/target/riscv/insn32-64.decode b/target/riscv/insn32-64.decode
new file mode 100644
index 0000000000..439d4e2c58
--- /dev/null
+++ b/target/riscv/insn32-64.decode
@@ -0,0 +1,25 @@
+#
+# RISC-V translation routines for the RV Instruction Set.
+#
+# Copyright (c) 2018 Peer Adelt, peer.adelt@hni.uni-paderborn.de
+#                    Bastian Koppelmann, kbastian@mail.uni-paderborn.de
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms and conditions of the GNU General Public License,
+# version 2 or later, as published by the Free Software Foundation.
+#
+# This program is distributed in the hope it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+# more details.
+#
+# You should have received a copy of the GNU General Public License along with
+# this program.  If not, see <http://www.gnu.org/licenses/>.
+
+# This is concatenated with insn32.decode for risc64 targets.
+# Most of the fields and formats are there.
+
+# *** RV64I Base Instruction Set (in addition to RV32I) ***
+lwu      ............   ..... 110 ..... 0000011 @i
+ld       ............   ..... 011 ..... 0000011 @i
+sd       ....... .....  ..... 011 ..... 0100011 @s
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index f3b88ebb69..39a20a70e8 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -130,3 +130,23 @@ static bool trans_sw(DisasContext *ctx, arg_sw *a)
     gen_store(ctx, OPC_RISC_SW, a->rs1, a->rs2, a->imm);
     return true;
 }
+
+#ifdef TARGET_RISCV64
+static bool trans_lwu(DisasContext *ctx, arg_lwu *a)
+{
+    gen_load(ctx, OPC_RISC_LWU, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_ld(DisasContext *ctx, arg_ld *a)
+{
+    gen_load(ctx, OPC_RISC_LD, a->rd, a->rs1, a->imm);
+    return true;
+}
+
+static bool trans_sd(DisasContext *ctx, arg_sd *a)
+{
+    gen_store(ctx, OPC_RISC_SD, a->rs1, a->rs2, a->imm);
+    return true;
+}
+#endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index b81297f23e..609207f785 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1711,13 +1711,6 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
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
2.20.1
