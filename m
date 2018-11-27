Received: from eggs.gnu.org ([2001:4830:134:3::10]:36485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=862abf4e0=Alistair.Francis@wdc.com>)
	id 1gRkal-00055A-II
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=862abf4e0=Alistair.Francis@wdc.com>)
	id 1gRkai-0004EU-Cv
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:08:23 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 27 Nov 2018 21:08:16 +0000
Message-ID: <51221791beb40b25309805b1c76db0004f26f64e.1543352682.git.alistair.francis@wdc.com>
References: <cover.1543352682.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1543352682.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v2 11/24] riscv: tcg-target: Add the mov and movi
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 tcg/riscv/tcg-target.inc.c | 78 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 9c48679f11..e5a07b146f 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -434,6 +434,84 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int t=
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
+#if TCG_TARGET_REG_BITS =3D=3D 64
+    tcg_target_long lo =3D sextract64(val, 0, 12);
+#else
+    tcg_target_long lo =3D sextract32(val, 0, 12);
+#endif
+    tcg_target_long hi =3D val - lo;
+    int shift;
+    tcg_target_long tmp;
+
+    RISCVInsn add32_op =3D TCG_TARGET_REG_BITS =3D=3D 64 ? OPC_ADDIW : OPC=
_ADDI;
+
+#if TCG_TARGET_REG_BITS =3D=3D 64
+    ptrdiff_t offset =3D tcg_pcrel_diff(s, (void *)val);
+#endif
+
+    if (TCG_TARGET_REG_BITS =3D=3D 32 || val =3D=3D (int32_t)val) {
+        tcg_out_opc_upper(s, OPC_LUI, rd, hi);
+        if (lo !=3D 0) {
+            tcg_out_opc_imm(s, add32_op, rd, rd, lo);
+        }
+
+        return;
+    }
+
+    /* We can only be here if TCG_TARGET_REG_BITS !=3D 32 */
+    if (offset =3D=3D sextract64(offset, 1, 31) << 1) {
+        tcg_out_opc_upper(s, OPC_AUIPC, rd, 0);
+        tcg_out_opc_imm(s, OPC_ADDI, rd, rd, 0);
+        reloc_call(s->code_ptr - 2, (tcg_insn_unit *)val);
+        return;
+    }
+
+    shift =3D ctz64(val);
+    tmp =3D val >> shift;
+
+    if (tmp =3D=3D sextract64(tmp, 0, 12)) {
+        tcg_out_opc_imm(s, OPC_ADDI, rd, TCG_REG_ZERO, 1);
+        tcg_out_opc_imm(s, OPC_SLLI, rd, rd, ctz64(val));
+    } else if (!(val >> 31 =3D=3D 0 || val >> 31 =3D=3D -1)) {
+        shift =3D ctz64(hi);
+        hi >>=3D shift;
+        tcg_out_movi(s, type, rd, hi);
+        tcg_out_opc_imm(s, OPC_SLLI, rd, rd, shift);
+        if (lo !=3D 0) {
+            tcg_out_opc_imm(s, OPC_ADDI, rd, rd, lo);
+        }
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
