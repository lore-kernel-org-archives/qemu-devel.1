Received: from eggs.gnu.org ([2001:4830:134:3::10]:39799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQmp-00019p-Jq
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:48:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQml-0000rc-J2
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:48:03 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 8 Dec 2018 00:47:54 +0000
Message-ID: <4b09385f9d320719fe5ed5eb77a7f53581b667e9.1544229872.git.alistair.francis@wdc.com>
References: <cover.1544229872.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544229872.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v3 11/24] riscv: tcg-target: Add the relocation
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
 tcg/riscv/tcg-target.inc.c | 75 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index cfcab9c716..05e85805d2 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -422,3 +422,78 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int cou=
nt)
         p[i] =3D encode_i(OPC_ADDI, TCG_REG_ZERO, TCG_REG_ZERO, 0);
     }
 }
+
+/*
+ * Relocations
+ */
+
+static void reloc_sbimm12(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+{
+    intptr_t offset =3D (intptr_t)target - (intptr_t)code_ptr;
+    tcg_debug_assert(offset =3D=3D sextreg(offset, 1, 12) << 1);
+
+    code_ptr[0] |=3D encode_sbimm12(offset);
+}
+
+static void reloc_jimm20(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+{
+    intptr_t offset =3D (intptr_t)target - (intptr_t)code_ptr;
+    tcg_debug_assert(offset =3D=3D sextreg(offset, 1, 20) << 1);
+
+    code_ptr[0] |=3D encode_ujimm20(offset);
+}
+
+static void reloc_call(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+{
+    intptr_t offset =3D (intptr_t)target - (intptr_t)code_ptr;
+    int32_t lo =3D sextreg(offset, 0, 12);
+    int32_t hi =3D offset - lo;
+
+    tcg_debug_assert(offset =3D=3D hi + lo);
+
+    code_ptr[0] |=3D encode_uimm20(hi);
+    code_ptr[1] |=3D encode_imm12(lo);
+}
+
+static void patch_reloc(tcg_insn_unit *code_ptr, int type,
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
+            reloc_sbimm12(code_ptr, (tcg_insn_unit *)value);
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
+        }
+        break;
+    case R_RISCV_JAL:
+        reloc_jimm20(code_ptr, (tcg_insn_unit *)value);
+        break;
+    case R_RISCV_CALL:
+        reloc_call(code_ptr, (tcg_insn_unit *)value);
+        break;
+    default:
+        tcg_abort();
+    }
+}
--=20
2.19.1
