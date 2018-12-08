Received: from eggs.gnu.org ([2001:4830:134:3::10]:39721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQmd-0000e3-TQ
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:47:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQmZ-0000nE-Vc
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:47:51 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 8 Dec 2018 00:47:44 +0000
Message-ID: <ca06c726b208569d1dbea3d25566aea0ed8df47d.1544229872.git.alistair.francis@wdc.com>
References: <cover.1544229872.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544229872.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v3 10/24] riscv: tcg-target: Add the instruction
 emitters
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
 tcg/riscv/tcg-target.inc.c | 48 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index c385ff68ae..cfcab9c716 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -374,3 +374,51 @@ static int32_t encode_uj(RISCVInsn opc, TCGReg rd, uin=
t32_t imm)
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
+    for (i =3D 0; i < count; ++i) {
+        p[i] =3D encode_i(OPC_ADDI, TCG_REG_ZERO, TCG_REG_ZERO, 0);
+    }
+}
--=20
2.19.1
