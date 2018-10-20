Received: from eggs.gnu.org ([2001:4830:134:3::10]:40760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlTV-00021R-EG
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlTQ-0004CD-Fl
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:05 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:40596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gDlTQ-0004Ao-34
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:00 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Sat, 20 Oct 2018 09:14:24 +0200
Message-Id: <20181020071451.27808-3-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 02/29] targer/riscv: Activate decodetree and
 implemnt LUI & AUIPC
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

for now only LUI & AUIPC are decoded and translated. If decodetree fails, we
fall back to the old decoder.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
v1 -> v2:
        - ex_shift_amount returns uint32_t

 target/riscv/Makefile.objs              | 10 +++++++
 target/riscv/insn32.decode              | 30 +++++++++++++++++++++
 target/riscv/insn_trans/trans_rvi.inc.c | 35 +++++++++++++++++++++++++
 target/riscv/translate.c                | 24 ++++++++++++-----
 4 files changed, 92 insertions(+), 7 deletions(-)
 create mode 100644 target/riscv/insn32.decode
 create mode 100644 target/riscv/insn_trans/trans_rvi.inc.c

diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
index abd0a7cde3..ea02f9b9ef 100644
--- a/target/riscv/Makefile.objs
+++ b/target/riscv/Makefile.objs
@@ -1 +1,11 @@
 obj-y += translate.o op_helper.o helper.o cpu.o fpu_helper.o gdbstub.o pmp.o
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
index 0000000000..44d4e922b6
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
index 0000000000..aee0d1637d
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
+static bool trans_lui(DisasContext *ctx, arg_lui *a, uint32_t insn)
+{
+    if (a->rd != 0) {
+        tcg_gen_movi_tl(cpu_gpr[a->rd], a->imm);
+    }
+    return true;
+}
+
+static bool trans_auipc(DisasContext *ctx, arg_auipc *a, uint32_t insn)
+{
+    if (a->rd != 0) {
+        tcg_gen_movi_tl(cpu_gpr[a->rd], a->imm + ctx->base.pc_next);
+    }
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index e81b9f097e..65a323a201 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1667,6 +1667,19 @@ static void decode_RV32_64C(CPURISCVState *env, DisasContext *ctx)
     }
 }
 
+#define EX_SH(amount) \
+    static int32_t ex_shift_##amount(int imm) \
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
 static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
 {
     int rs1;
@@ -1687,12 +1700,6 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
     imm = GET_IMM(ctx->opcode);
 
     switch (op) {
-    case OPC_RISC_LUI:
-        if (rd == 0) {
-            break; /* NOP */
-        }
-        tcg_gen_movi_tl(cpu_gpr[rd], sextract64(ctx->opcode, 12, 20) << 12);
-        break;
     case OPC_RISC_AUIPC:
         if (rd == 0) {
             break; /* NOP */
@@ -1802,7 +1809,10 @@ static void decode_opc(DisasContext *ctx)
         }
     } else {
         ctx->pc_succ_insn = ctx->base.pc_next + 4;
-        decode_RV32_64G(ctx->env, ctx);
+        if (!decode_insn32(ctx, ctx->opcode)) {
+            /* fallback to old decoder */
+            decode_RV32_64G(ctx->env, ctx);
+        }
     }
 }
 
-- 
2.19.1
