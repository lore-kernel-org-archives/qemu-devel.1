Received: from eggs.gnu.org ([208.118.235.92]:49667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtkp-0004Ro-NG
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtko-0007Ap-U4
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:56:43 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtko-0007A0-NH
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:56:42 -0500
Received: by mail-pl1-x642.google.com with SMTP id e11so6796824plt.11
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:56:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:54:55 +1100
Message-Id: <20181225205529.10874-9-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 08/42] tcg/riscv: Add the immediate encoders
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
Message-Id: <d54dc56303fd1b0d7ed53869de2dbb59b111c7ca.1545246859.git.alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.inc.c | 90 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index f853d01803..08838027cd 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -284,3 +284,93 @@ typedef enum {
 
     OPC_FENCE = 0x0000000f,
 } RISCVInsn;
+
+/*
+ * RISC-V immediate and instruction encoders (excludes 16-bit RVC)
+ */
+
+/* Type-R */
+
+static int32_t encode_r(RISCVInsn opc, TCGReg rd, TCGReg rs1, TCGReg rs2)
+{
+    return opc | (rd & 0x1f) << 7 | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20;
+}
+
+/* Type-I */
+
+static int32_t encode_imm12(uint32_t imm)
+{
+    return (imm & 0xfff) << 20;
+}
+
+static int32_t encode_i(RISCVInsn opc, TCGReg rd, TCGReg rs1, uint32_t imm)
+{
+    return opc | (rd & 0x1f) << 7 | (rs1 & 0x1f) << 15 | encode_imm12(imm);
+}
+
+/* Type-S */
+
+static int32_t encode_simm12(uint32_t imm)
+{
+    int32_t ret = 0;
+
+    ret |= (imm & 0xFE0) << 20;
+    ret |= (imm & 0x1F) << 7;
+
+    return ret;
+}
+
+static int32_t encode_s(RISCVInsn opc, TCGReg rs1, TCGReg rs2, uint32_t imm)
+{
+    return opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20 | encode_simm12(imm);
+}
+
+/* Type-SB */
+
+static int32_t encode_sbimm12(uint32_t imm)
+{
+    int32_t ret = 0;
+
+    ret |= (imm & 0x1000) << 19;
+    ret |= (imm & 0x7e0) << 20;
+    ret |= (imm & 0x1e) << 7;
+    ret |= (imm & 0x800) >> 4;
+
+    return ret;
+}
+
+static int32_t encode_sb(RISCVInsn opc, TCGReg rs1, TCGReg rs2, uint32_t imm)
+{
+    return opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20 | encode_sbimm12(imm);
+}
+
+/* Type-U */
+
+static int32_t encode_uimm20(uint32_t imm)
+{
+    return imm & 0xfffff000;
+}
+
+static int32_t encode_u(RISCVInsn opc, TCGReg rd, uint32_t imm)
+{
+    return opc | (rd & 0x1f) << 7 | encode_uimm20(imm);
+}
+
+/* Type-UJ */
+
+static int32_t encode_ujimm20(uint32_t imm)
+{
+    int32_t ret = 0;
+
+    ret |= (imm & 0x0007fe) << (21 - 1);
+    ret |= (imm & 0x000800) << (20 - 11);
+    ret |= (imm & 0x0ff000) << (12 - 12);
+    ret |= (imm & 0x100000) << (31 - 20);
+
+    return ret;
+}
+
+static int32_t encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
+{
+    return opc | (rd & 0x1f) << 7 | encode_ujimm20(imm);
+}
-- 
2.17.2
