Received: from eggs.gnu.org ([2001:4830:134:3::10]:48769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8779827ad=Alistair.Francis@wdc.com>)
	id 1gXAR0-0001T1-6Z
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:44:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8779827ad=Alistair.Francis@wdc.com>)
	id 1gXAQv-0002QT-8j
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:44:42 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Wed, 12 Dec 2018 19:44:33 +0000
Message-ID: <0c8383b7652e682cd683a04f7e0660a26c1510af.1544643238.git.alistair.francis@wdc.com>
References: <cover.1544643238.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544643238.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 11/23] riscv: tcg-target: Add the mov and
 movi instruction
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
---
 tcg/riscv/tcg-target.inc.c | 85 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index e6ad5f8e4c..9baa8a19c4 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -497,3 +497,88 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int t=
ype,
         tcg_abort();
     }
 }
+
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
+    tcg_target_long lo, hi, tmp;
+    int shift;
+
+    if (TCG_TARGET_REG_BITS =3D=3D 64 && type =3D=3D TCG_TYPE_I32) {
+        val =3D (int32_t)val;
+    }
+
+    lo =3D sextreg(val, 0, 12);
+    if (val =3D=3D lo) {
+        tcg_out_opc_imm(s, OPC_ADDI, rd, TCG_REG_ZERO, lo);
+        return;
+    }
+
+    hi =3D val - lo;
+    if (TCG_TARGET_REG_BITS =3D=3D 32 || val =3D=3D (int32_t)val) {
+        tcg_out_opc_upper(s, OPC_LUI, rd, hi);
+        if (lo !=3D 0) {
+            tcg_out_opc_imm(s, OPC_ADDIW, rd, rd, lo);
+        }
+        return;
+    }
+
+    /* We can only be here if TCG_TARGET_REG_BITS !=3D 32 */
+    tmp =3D tcg_pcrel_diff(s, (void *)val);
+    if (tmp =3D=3D (int32_t)tmp) {
+        tcg_out_opc_upper(s, OPC_AUIPC, rd, 0);
+        tcg_out_opc_imm(s, OPC_ADDI, rd, rd, 0);
+        reloc_call(s->code_ptr - 2, (tcg_insn_unit *)val);
+        return;
+    }
+
+    /* Look for a single 20-bit section.  */
+    shift =3D ctz64(val);
+    tmp =3D val >> shift;
+    if (tmp =3D=3D sextreg(tmp, 0, 20)) {
+        tcg_out_opc_upper(s, OPC_LUI, rd, tmp << 12);
+        if (shift > 12) {
+            tcg_out_opc_imm(s, OPC_SLLI, rd, rd, shift - 12);
+        } else {
+            tcg_out_opc_imm(s, OPC_SRAI, rd, rd, 12 - shift);
+        }
+        return;
+    }
+
+    /* Look for a few high zero bits, with lots of bits set in the middle.=
  */
+    shift =3D clz64(val);
+    tmp =3D val << shift;
+    if (tmp =3D=3D sextreg(tmp, 12, 20) << 12) {
+        tcg_out_opc_upper(s, OPC_LUI, rd, tmp);
+        tcg_out_opc_imm(s, OPC_SRLI, rd, rd, shift);
+        return;
+    } else if (tmp =3D=3D sextreg(tmp, 0, 12)) {
+        tcg_out_opc_imm(s, OPC_ADDI, rd, TCG_REG_ZERO, tmp);
+        tcg_out_opc_imm(s, OPC_SRLI, rd, rd, shift);
+        return;
+    }
+
+    /* Drop into the constant pool.  */
+    new_pool_label(s, val, R_RISCV_CALL, s->code_ptr, 0);
+    tcg_out_opc_upper(s, OPC_AUIPC, rd, 0);
+    tcg_out_opc_imm(s, OPC_LD, rd, rd, 0);
+}
--=20
2.19.1
