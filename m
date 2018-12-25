Received: from eggs.gnu.org ([208.118.235.92]:49892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtlL-00053N-Q3
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtlI-0007iJ-Jj
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:15 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:35860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtlI-0007hT-DK
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:12 -0500
Received: by mail-pf1-x42f.google.com with SMTP id b85so7082652pfc.3
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:57:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:54:59 +1100
Message-Id: <20181225205529.10874-13-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 12/42] tcg/riscv: Add the extract instructions
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
Message-Id: <c4d2afba46efefa9388cf3205fcedbb9a5fa411f.1545246859.git.alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.inc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 01b4443d6d..48399480b2 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -596,3 +596,37 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
     tcg_out_opc_upper(s, OPC_AUIPC, rd, 0);
     tcg_out_opc_imm(s, OPC_LD, rd, rd, 0);
 }
+
+static void tcg_out_ext8u(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_out_opc_imm(s, OPC_ANDI, ret, arg, 0xff);
+}
+
+static void tcg_out_ext16u(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 16);
+    tcg_out_opc_imm(s, OPC_SRLIW, ret, ret, 16);
+}
+
+static void tcg_out_ext32u(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_out_opc_imm(s, OPC_SLLI, ret, arg, 32);
+    tcg_out_opc_imm(s, OPC_SRLI, ret, ret, 32);
+}
+
+static void tcg_out_ext8s(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 24);
+    tcg_out_opc_imm(s, OPC_SRAIW, ret, ret, 24);
+}
+
+static void tcg_out_ext16s(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 16);
+    tcg_out_opc_imm(s, OPC_SRAIW, ret, ret, 16);
+}
+
+static void tcg_out_ext32s(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_out_opc_imm(s, OPC_ADDIW, ret, arg, 0);
+}
-- 
2.17.2
