Received: from eggs.gnu.org ([2001:4830:134:3::10]:47803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8503fdbbc=Alistair.Francis@wdc.com>)
	id 1gNQEn-0006WO-3G
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8503fdbbc=Alistair.Francis@wdc.com>)
	id 1gNQEj-0004LY-MB
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:35:49 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 15 Nov 2018 22:35:42 +0000
Message-ID: <51aa21df48c5d80484bf396b82d9e3943daf1e0c.1542321076.git.alistair.francis@wdc.com>
References: <cover.1542321076.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1542321076.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v1 12/23] riscv: tcg-target: Add the mov and movi
 instruction
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
 tcg/riscv/tcg-target.inc.c | 62 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 475feca906..0e891e24c9 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -422,6 +422,68 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int t=
ype,
     }
 }
=20
+/*
+ * TCG intrinsics
+ */
+
+static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg ar=
g)
+{
+    if (ret =3D=3D arg) {
+        return;
+    }
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_out_opc_imm(s, OPC_ADDI, ret, arg, 0);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
+                         tcg_target_long val)
+{
+    tcg_target_long lo =3D sextract32(val, 0, 12);
+    tcg_target_long hi =3D val - lo;
+
+    RISCVInsn add32_op =3D TCG_TARGET_REG_BITS =3D=3D 64 ? OPC_ADDIW : OPC=
_ADDI;
+
+#if TCG_TARGET_REG_BITS =3D=3D 64
+    ptrdiff_t offset =3D tcg_pcrel_diff(s, (void *)val);
+#endif
+
+    if (val =3D=3D lo) {
+        tcg_out_opc_imm(s, OPC_ADDI, rd, TCG_REG_ZERO, val);
+    } else if (val && !(val & (val - 1))) {
+        /* power of 2 */
+        tcg_out_opc_imm(s, OPC_ADDI, rd, TCG_REG_ZERO, 1);
+        tcg_out_opc_imm(s, OPC_SLLI, rd, rd, ctz64(val));
+    } else if (TCG_TARGET_REG_BITS =3D=3D 64 &&
+               !(val >> 31 =3D=3D 0 || val >> 31 =3D=3D -1)) {
+        int shift =3D 12 + ctz64(hi >> 12);
+        hi >>=3D shift;
+        tcg_out_movi(s, type, rd, hi);
+        tcg_out_opc_imm(s, OPC_SLLI, rd, rd, shift);
+        if (lo !=3D 0) {
+            tcg_out_opc_imm(s, OPC_ADDI, rd, rd, lo);
+        }
+#if TCG_TARGET_REG_BITS =3D=3D 64
+    } else if (offset =3D=3D sextract32(offset, 1, 31) << 1) {
+        tcg_out_opc_upper(s, OPC_AUIPC, rd, 0);
+        tcg_out_opc_imm(s, OPC_ADDI, rd, rd, 0);
+        reloc_call(s->code_ptr - 2, (tcg_insn_unit *)val);
+#endif
+    } else {
+        if (hi !=3D 0) {
+            tcg_out_opc_upper(s, OPC_LUI, rd, hi);
+        }
+        if (lo !=3D 0) {
+            tcg_out_opc_imm(s, add32_op, rd, hi =3D=3D 0 ? TCG_REG_ZERO : =
rd, lo);
+        }
+    }
+}
+
 void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
                               uintptr_t addr)
 {
--=20
2.19.1
