Received: from eggs.gnu.org ([2001:4830:134:3::10]:47997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8503fdbbc=Alistair.Francis@wdc.com>)
	id 1gNQFG-0006wG-FI
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8503fdbbc=Alistair.Francis@wdc.com>)
	id 1gNQFC-0004a1-IH
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:36:18 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 15 Nov 2018 22:36:00 +0000
Message-ID: <7961f2bc55e109ff10543c4665c5cbc3c75a5bf7.1542321076.git.alistair.francis@wdc.com>
References: <cover.1542321076.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1542321076.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v1 14/23] riscv: tcg-target: Add the out load and
 store instructions
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
 tcg/riscv/tcg-target.inc.c | 56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 646a4d3ebd..bc433170c4 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -518,6 +518,62 @@ static void tcg_out_ext32s(TCGContext *s, TCGReg ret, =
TCGReg arg)
     tcg_out_opc_imm(s, OPC_ADDIW, ret, arg, 0);
 }
=20
+static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
+                         TCGReg addr, intptr_t offset)
+{
+    int32_t imm12 =3D sextract32(offset, 0, 12);
+    if (offset !=3D imm12) {
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP2, offset - imm12);
+        if (addr !=3D TCG_REG_ZERO) {
+            tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP2, TCG_REG_TMP2, addr);
+        }
+        addr =3D TCG_REG_TMP2;
+    }
+    switch (opc) {
+    case OPC_SB:
+    case OPC_SH:
+    case OPC_SW:
+    case OPC_SD:
+        tcg_out_opc_store(s, opc, addr, data, imm12);
+        break;
+    case OPC_LB:
+    case OPC_LBU:
+    case OPC_LH:
+    case OPC_LHU:
+    case OPC_LW:
+    case OPC_LWU:
+    case OPC_LD:
+        tcg_out_opc_imm(s, opc, data, addr, imm12);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
+                       TCGReg arg1, intptr_t arg2)
+{
+    bool is32bit =3D (TCG_TARGET_REG_BITS =3D=3D 32 || type =3D=3D TCG_TYP=
E_I32);
+    tcg_out_ldst(s, is32bit ? OPC_LW : OPC_LD, arg, arg1, arg2);
+}
+
+static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
+                       TCGReg arg1, intptr_t arg2)
+{
+    bool is32bit =3D (TCG_TARGET_REG_BITS =3D=3D 32 || type =3D=3D TCG_TYP=
E_I32);
+    tcg_out_ldst(s, is32bit ? OPC_SW : OPC_SD, arg, arg1, arg2);
+}
+
+static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
+                        TCGReg base, intptr_t ofs)
+{
+    if (val =3D=3D 0) {
+        tcg_out_st(s, type, TCG_REG_ZERO, base, ofs);
+        return true;
+    }
+    return false;
+}
+
 void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
                               uintptr_t addr)
 {
--=20
2.19.1
