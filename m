Received: from eggs.gnu.org ([208.118.235.92]:49773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtky-0004dX-UY
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:56:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtkv-0007JG-Q7
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:56:52 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:34964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtkv-0007I4-K7
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:56:49 -0500
Received: by mail-pf1-x434.google.com with SMTP id z9so7082249pfi.2
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:56:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:54:56 +1100
Message-Id: <20181225205529.10874-10-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 09/42] tcg/riscv: Add the instruction emitters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, Michael Clark <mjc@sifive.com>

From: Alistair Francis <Alistair.Francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <c740aca183675625bb9cf3ce7b9e8b9d431ca694.1545246859.git.alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.inc.c | 48 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 08838027cd..d198cfd5f7 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -374,3 +374,51 @@ static int32_t encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
 {
     return opc | (rd & 0x1f) << 7 | encode_ujimm20(imm);
 }
+
+/*
+ * RISC-V instruction emitters
+ */
+
+static void tcg_out_opc_reg(TCGContext *s, RISCVInsn opc,
+                            TCGReg rd, TCGReg rs1, TCGReg rs2)
+{
+    tcg_out32(s, encode_r(opc, rd, rs1, rs2));
+}
+
+static void tcg_out_opc_imm(TCGContext *s, RISCVInsn opc,
+                            TCGReg rd, TCGReg rs1, TCGArg imm)
+{
+    tcg_out32(s, encode_i(opc, rd, rs1, imm));
+}
+
+static void tcg_out_opc_store(TCGContext *s, RISCVInsn opc,
+                              TCGReg rs1, TCGReg rs2, uint32_t imm)
+{
+    tcg_out32(s, encode_s(opc, rs1, rs2, imm));
+}
+
+static void tcg_out_opc_branch(TCGContext *s, RISCVInsn opc,
+                               TCGReg rs1, TCGReg rs2, uint32_t imm)
+{
+    tcg_out32(s, encode_sb(opc, rs1, rs2, imm));
+}
+
+static void tcg_out_opc_upper(TCGContext *s, RISCVInsn opc,
+                              TCGReg rd, uint32_t imm)
+{
+    tcg_out32(s, encode_u(opc, rd, imm));
+}
+
+static void tcg_out_opc_jump(TCGContext *s, RISCVInsn opc,
+                             TCGReg rd, uint32_t imm)
+{
+    tcg_out32(s, encode_uj(opc, rd, imm));
+}
+
+static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
+{
+    int i;
+    for (i = 0; i < count; ++i) {
+        p[i] = encode_i(OPC_ADDI, TCG_REG_ZERO, TCG_REG_ZERO, 0);
+    }
+}
-- 
2.17.2
