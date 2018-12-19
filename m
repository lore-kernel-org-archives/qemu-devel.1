Received: from eggs.gnu.org ([2001:4830:134:3::10]:45680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=884a3e257=Alistair.Francis@wdc.com>)
	id 1gZhMY-0001ts-Jh
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:18:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=884a3e257=Alistair.Francis@wdc.com>)
	id 1gZhMS-0000mF-K1
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:18:34 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Wed, 19 Dec 2018 19:18:06 +0000
Message-ID: <6ac4f4b0d5ea93cb0ee9a3b8b47ee9f7b3711494.1545246859.git.alistair.francis@wdc.com>
References: <cover.1545246859.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1545246859.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 10/23] riscv: tcg-target: Add the relocation
 functions
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
 tcg/riscv/tcg-target.inc.c | 88 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index d198cfd5f7..a26744052f 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -422,3 +422,91 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int cou=
nt)
         p[i] =3D encode_i(OPC_ADDI, TCG_REG_ZERO, TCG_REG_ZERO, 0);
     }
 }
+
+/*
+ * Relocations
+ */
+
+static bool reloc_sbimm12(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+{
+    intptr_t offset =3D (intptr_t)target - (intptr_t)code_ptr;
+
+    if (offset =3D=3D sextreg(offset, 1, 12) << 1) {
+        code_ptr[0] |=3D encode_sbimm12(offset);
+        return true;
+    }
+
+    return false;
+}
+
+static bool reloc_jimm20(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+{
+    intptr_t offset =3D (intptr_t)target - (intptr_t)code_ptr;
+
+    if (offset =3D=3D sextreg(offset, 1, 20) << 1) {
+        code_ptr[0] |=3D encode_ujimm20(offset);
+        return true;
+    }
+
+    return false;
+}
+
+static bool reloc_call(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+{
+    intptr_t offset =3D (intptr_t)target - (intptr_t)code_ptr;
+    int32_t lo =3D sextreg(offset, 0, 12);
+    int32_t hi =3D offset - lo;
+
+    if (offset =3D=3D hi + lo) {
+        code_ptr[0] |=3D encode_uimm20(hi);
+        code_ptr[1] |=3D encode_imm12(lo);
+        return true;
+    }
+
+    return false;
+}
+
+static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
+                        intptr_t value, intptr_t addend)
+{
+    uint32_t insn =3D *code_ptr;
+    intptr_t diff;
+    bool short_jmp;
+
+    tcg_debug_assert(addend =3D=3D 0);
+
+    switch (type) {
+    case R_RISCV_BRANCH:
+        diff =3D value - (uintptr_t)code_ptr;
+        short_jmp =3D diff =3D=3D sextreg(diff, 0, 12);
+        if (short_jmp) {
+            return reloc_sbimm12(code_ptr, (tcg_insn_unit *)value);
+        } else {
+            /* Invert the condition */
+            insn =3D insn ^ (1 << 12);
+            /* Clear the offset */
+            insn &=3D 0x01fff07f;
+            /* Set the offset to the PC + 8 */
+            insn |=3D encode_sbimm12(8);
+
+            /* Move forward */
+            code_ptr[0] =3D insn;
+
+            /* Overwrite the NOP with jal x0,value */
+            diff =3D value - (uintptr_t)(code_ptr + 1);
+            insn =3D encode_uj(OPC_JAL, TCG_REG_ZERO, diff);
+            code_ptr[1] =3D insn;
+
+            return true;
+        }
+        break;
+    case R_RISCV_JAL:
+        return reloc_jimm20(code_ptr, (tcg_insn_unit *)value);
+        break;
+    case R_RISCV_CALL:
+        return reloc_call(code_ptr, (tcg_insn_unit *)value);
+        break;
+    default:
+        tcg_abort();
+    }
+}
--=20
2.19.1
