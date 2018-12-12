Received: from eggs.gnu.org ([2001:4830:134:3::10]:48570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8779827ad=Alistair.Francis@wdc.com>)
	id 1gXAQa-00013t-52
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8779827ad=Alistair.Francis@wdc.com>)
	id 1gXAQW-00027I-2y
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:44:16 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Wed, 12 Dec 2018 19:44:05 +0000
Message-ID: <9bfe565bb23718e4d7b534925275c2b2df8c2b48.1544643238.git.alistair.francis@wdc.com>
References: <cover.1544643238.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544643238.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 08/23] riscv: tcg-target: Add the immediate
 encoders
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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.inc.c | 90 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index f853d01803..08838027cd 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -284,3 +284,93 @@ typedef enum {
=20
     OPC_FENCE =3D 0x0000000f,
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
+    return opc | (rd & 0x1f) << 7 | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 2=
0;
+}
+
+/* Type-I */
+
+static int32_t encode_imm12(uint32_t imm)
+{
+    return (imm & 0xfff) << 20;
+}
+
+static int32_t encode_i(RISCVInsn opc, TCGReg rd, TCGReg rs1, uint32_t imm=
)
+{
+    return opc | (rd & 0x1f) << 7 | (rs1 & 0x1f) << 15 | encode_imm12(imm)=
;
+}
+
+/* Type-S */
+
+static int32_t encode_simm12(uint32_t imm)
+{
+    int32_t ret =3D 0;
+
+    ret |=3D (imm & 0xFE0) << 20;
+    ret |=3D (imm & 0x1F) << 7;
+
+    return ret;
+}
+
+static int32_t encode_s(RISCVInsn opc, TCGReg rs1, TCGReg rs2, uint32_t im=
m)
+{
+    return opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20 | encode_simm12(i=
mm);
+}
+
+/* Type-SB */
+
+static int32_t encode_sbimm12(uint32_t imm)
+{
+    int32_t ret =3D 0;
+
+    ret |=3D (imm & 0x1000) << 19;
+    ret |=3D (imm & 0x7e0) << 20;
+    ret |=3D (imm & 0x1e) << 7;
+    ret |=3D (imm & 0x800) >> 4;
+
+    return ret;
+}
+
+static int32_t encode_sb(RISCVInsn opc, TCGReg rs1, TCGReg rs2, uint32_t i=
mm)
+{
+    return opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20 | encode_sbimm12(=
imm);
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
+    int32_t ret =3D 0;
+
+    ret |=3D (imm & 0x0007fe) << (21 - 1);
+    ret |=3D (imm & 0x000800) << (20 - 11);
+    ret |=3D (imm & 0x0ff000) << (12 - 12);
+    ret |=3D (imm & 0x100000) << (31 - 20);
+
+    return ret;
+}
+
+static int32_t encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
+{
+    return opc | (rd & 0x1f) << 7 | encode_ujimm20(imm);
+}
--=20
2.19.1
