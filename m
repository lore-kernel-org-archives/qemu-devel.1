Received: from eggs.gnu.org ([2001:4830:134:3::10]:36554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=862abf4e0=Alistair.Francis@wdc.com>)
	id 1gRkau-0005Ea-3q
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:08:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=862abf4e0=Alistair.Francis@wdc.com>)
	id 1gRkaq-0004Id-VQ
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:08:32 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 27 Nov 2018 21:08:25 +0000
Message-ID: <d2feed138c5a4078adf5a6f6bfdadb2765fd335c.1543352682.git.alistair.francis@wdc.com>
References: <cover.1543352682.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1543352682.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v2 12/24] riscv: tcg-target: Add the extract
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.inc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index e5a07b146f..4291a00962 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -512,6 +512,40 @@ static void tcg_out_movi(TCGContext *s, TCGType type, =
TCGReg rd,
     }
 }
=20
+static void tcg_out_ext8u(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_out_opc_imm(s, OPC_ANDI, ret, arg, 0xff);
+}
+
+static void tcg_out_ext16u(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_out_opc_imm(s, OPC_SLLI, ret, arg, TCG_TARGET_REG_BITS - 16);
+    tcg_out_opc_imm(s, OPC_SRLI, ret, ret, TCG_TARGET_REG_BITS - 16);
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
+    tcg_out_opc_imm(s, OPC_SLLI, ret, arg, TCG_TARGET_REG_BITS - 8);
+    tcg_out_opc_imm(s, OPC_SRAI, ret, ret, TCG_TARGET_REG_BITS - 8);
+}
+
+static void tcg_out_ext16s(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_out_opc_imm(s, OPC_SLLI, ret, arg, TCG_TARGET_REG_BITS - 16);
+    tcg_out_opc_imm(s, OPC_SRAI, ret, ret, TCG_TARGET_REG_BITS - 16);
+}
+
+static void tcg_out_ext32s(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_out_opc_imm(s, OPC_ADDIW, ret, arg, 0);
+}
+
 void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
                               uintptr_t addr)
 {
--=20
2.19.1
