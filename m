Received: from eggs.gnu.org ([209.51.188.92]:59248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwsS-00015L-R1
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwsP-0001Pz-AS
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:55:10 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gtwsN-0000rx-8c
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:55:09 -0500
Received: by mail-pl1-x643.google.com with SMTP id r14so1329662pls.12
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 07:54:41 -0800 (PST)
Date: Wed, 13 Feb 2019 07:53:41 -0800
Message-Id: <20190213155414.22285-3-palmer@sifive.com>
In-Reply-To: <20190213155414.22285-1-palmer@sifive.com>
References: <20190213155414.22285-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PATCH v7 02/35] target/riscv: Activate decodetree and
 implemnt LUI & AUIPC
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

for now only LUI & AUIPC are decoded and translated. If decodetree fails, we
fall back to the old decoder.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/Makefile.objs              | 10 +++++++
 target/riscv/insn32.decode              | 30 +++++++++++++++++++++
 target/riscv/insn_trans/trans_rvi.inc.c | 35 +++++++++++++++++++++++++
 target/riscv/translate.c                | 31 ++++++++++++----------
 4 files changed, 92 insertions(+), 14 deletions(-)
 create mode 100644 target/riscv/insn32.decode
 create mode 100644 target/riscv/insn_trans/trans_rvi.inc.c

diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
index 4072abe3e45c..bf0a268033a0 100644
--- a/target/riscv/Makefile.objs
+++ b/target/riscv/Makefile.objs
@@ -1 +1,11 @@
 obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o gdbstub.o pmp.o
+
+DECODETREE = $(SRC_PATH)/scripts/decodetree.py
+
+target/riscv/decode_insn32.inc.c: \
+  $(SRC_PATH)/target/riscv/insn32.decode $(DECODETREE)
+	$(call quiet-command, \
+	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn32 $<, \
+	  "GEN", $(TARGET_DIR)$@)
+
+target/riscv/translate.o: target/riscv/decode_insn32.inc.c
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
new file mode 100644
index 000000000000..44d4e922b6fa
--- /dev/null
+++ b/target/riscv/insn32.decode
@@ -0,0 +1,30 @@
+#
+# RISC-V translation routines for the RVXI Base Integer Instruction Set.
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
+# Fields:
+%rd        7:5
+
+# immediates:
+%imm_u    12:s20                 !function=ex_shift_12
+
+# Formats 32:
+@u       ....................      ..... .......         imm=%imm_u          %rd
+
+# *** RV32I Base Instruction Set ***
+lui      ....................       ..... 0110111 @u
+auipc    ....................       ..... 0010111 @u
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
new file mode 100644
index 000000000000..9885a8d27551
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -0,0 +1,35 @@
+/*
+ * RISC-V translation routines for the RVXI Base Integer Instruction Set.
+ *
+ * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
+ * Copyright (c) 2018 Peer Adelt, peer.adelt@hni.uni-paderborn.de
+ *                    Bastian Koppelmann, kbastian@mail.uni-paderborn.de
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+static bool trans_lui(DisasContext *ctx, arg_lui *a)
+{
+    if (a->rd != 0) {
+        tcg_gen_movi_tl(cpu_gpr[a->rd], a->imm);
+    }
+    return true;
+}
+
+static bool trans_auipc(DisasContext *ctx, arg_auipc *a)
+{
+    if (a->rd != 0) {
+        tcg_gen_movi_tl(cpu_gpr[a->rd], a->imm + ctx->base.pc_next);
+    }
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9e06eb8c2de5..4076f28b3c8b 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1875,6 +1875,19 @@ static void decode_RV32_64C(DisasContext *ctx)
     }
 }
 
+#define EX_SH(amount) \
+    static int ex_shift_##amount(int imm) \
+    {                                         \
+        return imm << amount;                 \
+    }
+EX_SH(12)
+
+bool decode_insn32(DisasContext *ctx, uint32_t insn);
+/* Include the auto-generated decoder for 32 bit insn */
+#include "decode_insn32.inc.c"
+/* Include insn module translation function */
+#include "insn_trans/trans_rvi.inc.c"
+
 static void decode_RV32_64G(DisasContext *ctx)
 {
     int rs1;
@@ -1895,19 +1908,6 @@ static void decode_RV32_64G(DisasContext *ctx)
     imm = GET_IMM(ctx->opcode);
 
     switch (op) {
-    case OPC_RISC_LUI:
-        if (rd == 0) {
-            break; /* NOP */
-        }
-        tcg_gen_movi_tl(cpu_gpr[rd], sextract64(ctx->opcode, 12, 20) << 12);
-        break;
-    case OPC_RISC_AUIPC:
-        if (rd == 0) {
-            break; /* NOP */
-        }
-        tcg_gen_movi_tl(cpu_gpr[rd], (sextract64(ctx->opcode, 12, 20) << 12) +
-               ctx->base.pc_next);
-        break;
     case OPC_RISC_JAL:
         imm = GET_JAL_IMM(ctx->opcode);
         gen_jal(ctx, rd, imm);
@@ -2012,7 +2012,10 @@ static void decode_opc(DisasContext *ctx)
         }
     } else {
         ctx->pc_succ_insn = ctx->base.pc_next + 4;
-        decode_RV32_64G(ctx);
+        if (!decode_insn32(ctx, ctx->opcode)) {
+            /* fallback to old decoder */
+            decode_RV32_64G(ctx);
+        }
     }
 }
 
-- 
2.18.1
