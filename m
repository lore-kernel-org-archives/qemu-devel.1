Received: from eggs.gnu.org ([2001:4830:134:3::10]:45801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=884a3e257=Alistair.Francis@wdc.com>)
	id 1gZhMl-00023A-Vx
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:18:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=884a3e257=Alistair.Francis@wdc.com>)
	id 1gZhMh-0000wH-VH
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:18:47 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Wed, 19 Dec 2018 19:18:39 +0000
Message-ID: <d5d88ff29163788938368bbdbd18815d59cef6a0.1545246859.git.alistair.francis@wdc.com>
References: <cover.1545246859.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1545246859.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 13/23] riscv: tcg-target: Add the out load
 and store instructions
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
 tcg/riscv/tcg-target.inc.c | 65 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 48399480b2..65718df7ad 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -630,3 +630,68 @@ static void tcg_out_ext32s(TCGContext *s, TCGReg ret, =
TCGReg arg)
 {
     tcg_out_opc_imm(s, OPC_ADDIW, ret, arg, 0);
 }
+
+static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
+                         TCGReg addr, intptr_t offset)
+{
+    intptr_t imm12 =3D sextreg(offset, 0, 12);
+
+    if (offset !=3D imm12) {
+        intptr_t diff =3D offset - (uintptr_t)s->code_ptr;
+
+        if (addr =3D=3D TCG_REG_ZERO && diff =3D=3D (int32_t)diff) {
+            imm12 =3D sextreg(diff, 0, 12);
+            tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP2, diff - imm12);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP2, offset - imm12);
+            if (addr !=3D TCG_REG_ZERO) {
+                tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP2, TCG_REG_TMP2, ad=
dr);
+            }
+        }
+        addr =3D TCG_REG_TMP2;
+    }
+
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
--=20
2.19.1
