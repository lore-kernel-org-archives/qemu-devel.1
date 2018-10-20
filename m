Received: from eggs.gnu.org ([2001:4830:134:3::10]:40785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlTW-00021V-Nn
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlTV-0004GY-0j
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:06 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:40610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gDlTU-0004En-KF
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:04 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Sat, 20 Oct 2018 09:14:30 +0200
Message-Id: <20181020071451.27808-9-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 08/29] target/riscv: Convert RVXM insns to
 decodetree
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

 target/riscv/insn32.decode              | 17 +++++
 target/riscv/insn_trans/trans_rvm.inc.c | 98 +++++++++++++++++++++++++
 target/riscv/translate.c                | 10 +--
 3 files changed, 116 insertions(+), 9 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvm.inc.c

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 4f6341aa37..a484844f34 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -113,3 +113,20 @@ subw     0100000 .....  ..... 000 ..... 0111011 @r
 sllw     0000000 .....  ..... 001 ..... 0111011 @r
 srlw     0000000 .....  ..... 101 ..... 0111011 @r
 sraw     0100000 .....  ..... 101 ..... 0111011 @r
+
+# *** RV32M Standard Extension ***
+mul      0000001 .....  ..... 000 ..... 0110011 @r
+mulh     0000001 .....  ..... 001 ..... 0110011 @r
+mulhsu   0000001 .....  ..... 010 ..... 0110011 @r
+mulhu    0000001 .....  ..... 011 ..... 0110011 @r
+div      0000001 .....  ..... 100 ..... 0110011 @r
+divu     0000001 .....  ..... 101 ..... 0110011 @r
+rem      0000001 .....  ..... 110 ..... 0110011 @r
+remu     0000001 .....  ..... 111 ..... 0110011 @r
+
+# *** RV64M Standard Extension (in addition to RV32M) ***
+mulw     0000001 .....  ..... 000 ..... 0111011 @r
+divw     0000001 .....  ..... 100 ..... 0111011 @r
+divuw    0000001 .....  ..... 101 ..... 0111011 @r
+remw     0000001 .....  ..... 110 ..... 0111011 @r
+remuw    0000001 .....  ..... 111 ..... 0111011 @r
diff --git a/target/riscv/insn_trans/trans_rvm.inc.c b/target/riscv/insn_trans/trans_rvm.inc.c
new file mode 100644
index 0000000000..ffeae57a36
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvm.inc.c
@@ -0,0 +1,98 @@
+/*
+ * RISC-V translation routines for the RV64M Standard Extension.
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
+
+static bool trans_mul(DisasContext *ctx, arg_mul *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_MUL, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_mulh(DisasContext *ctx, arg_mulh *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_MULH, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_mulhsu(DisasContext *ctx, arg_mulhsu *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_MULHSU, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_mulhu(DisasContext *ctx, arg_mulhu *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_MULHU, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_div(DisasContext *ctx, arg_div *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_DIV, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_divu(DisasContext *ctx, arg_divu *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_DIVU, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_rem(DisasContext *ctx, arg_rem *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_REM, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_remu(DisasContext *ctx, arg_remu *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_REMU, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_mulw(DisasContext *ctx, arg_mulw *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_MULW, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_divw(DisasContext *ctx, arg_divw *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_DIVW, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_divuw(DisasContext *ctx, arg_divuw *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_DIVUW, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_remw(DisasContext *ctx, arg_remw *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_REMW, a->rd, a->rs1, a->rs2);
+    return true;
+}
+
+static bool trans_remuw(DisasContext *ctx, arg_remuw *a, uint32_t insn)
+{
+    gen_arith(ctx, OPC_RISC_REMUW, a->rd, a->rs1, a->rs2);
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index d811090764..17c4d79b18 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1639,6 +1639,7 @@ bool decode_insn32(DisasContext *ctx, uint32_t insn);
 #include "decode_insn32.inc.c"
 /* Include insn module translation function */
 #include "insn_trans/trans_rvi.inc.c"
+#include "insn_trans/trans_rvm.inc.c"
 
 static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
 {
@@ -1660,15 +1661,6 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
     imm = GET_IMM(ctx->opcode);
 
     switch (op) {
-    case OPC_RISC_ARITH:
-#if defined(TARGET_RISCV64)
-    case OPC_RISC_ARITH_W:
-#endif
-        if (rd == 0) {
-            break; /* NOP */
-        }
-        gen_arith(ctx, MASK_OP_ARITH(ctx->opcode), rd, rs1, rs2);
-        break;
     case OPC_RISC_FP_LOAD:
         gen_fp_load(ctx, MASK_OP_FP_LOAD(ctx->opcode), rd, rs1, imm);
         break;
-- 
2.19.1
