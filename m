Received: from eggs.gnu.org ([2001:4830:134:3::10]:47671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8503fdbbc=Alistair.Francis@wdc.com>)
	id 1gNQEL-00067B-Qv
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8503fdbbc=Alistair.Francis@wdc.com>)
	id 1gNQEH-0003y4-Ms
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:35:21 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 15 Nov 2018 22:35:14 +0000
Message-ID: <2d6d038f9949b5b39feb48e322be881f31a7f4e1.1542321076.git.alistair.francis@wdc.com>
References: <cover.1542321076.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1542321076.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v1 09/23] riscv: tcg-target: Add the immediate
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 tcg/riscv/tcg-target.inc.c | 81 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index e585740870..5319f7ade5 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -258,6 +258,87 @@ typedef enum {
     OPC_FENCE_RW_W =3D 0x0310000f,
 } RISCVInsn;
=20
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
+    return ((imm << 20) >> 25) << 25 | ((imm << 27) >> 27) << 7;
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
+    return ((imm << 19) >> 31) << 31 | ((imm << 21) >> 26) << 25 |
+           ((imm << 27) >> 28) << 8 | ((imm << 20) >> 31) << 7;
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
+    return (imm >> 12) << 12;
+}
+
+static int32_t encode_u(RISCVInsn opc, TCGReg rd, uint32_t imm)
+{
+    return opc | (rd & 0x1f) << 7 | encode_uimm20(imm);
+}
+
+/* Type-UJ */
+
+static int32_t encode_ujimm12(uint32_t imm)
+{
+    return ((imm << 11) >> 31) << 31 | ((imm << 21) >> 22) << 21 |
+           ((imm << 20) >> 31) << 20 | ((imm << 12) >> 24) << 12;
+}
+
+static int32_t encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
+{
+    return opc | (rd & 0x1f) << 7 | encode_ujimm12(imm);
+}
+
+void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
+                              uintptr_t addr)
+{
+    /* Note: jump target patching should be atomic */
+    reloc_call((tcg_insn_unit *)jmp_addr, (tcg_insn_unit*)addr);
+    flush_icache_range(jmp_addr, jmp_addr + 8);
+}
+
 typedef struct {
     DebugFrameHeader h;
     uint8_t fde_def_cfa[4];
--=20
2.19.1
