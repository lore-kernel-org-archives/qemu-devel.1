Received: from eggs.gnu.org ([2001:4830:134:3::10]:37340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=862abf4e0=Alistair.Francis@wdc.com>)
	id 1gRkcd-0006kK-QH
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=862abf4e0=Alistair.Francis@wdc.com>)
	id 1gRkca-0005cb-LA
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:10:19 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 27 Nov 2018 21:10:14 +0000
Message-ID: <287a8dbdfa046fc269b0f238076f25157733c66a.1543352682.git.alistair.francis@wdc.com>
References: <cover.1543352682.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1543352682.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v2 24/24] WIP: Try to patch longer branches
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
---
 tcg/riscv/tcg-target.inc.c | 44 +++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index b8e9c0e126..cf1680935a 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -418,10 +418,37 @@ static void reloc_call(tcg_insn_unit *code_ptr, tcg_i=
nsn_unit *target)
 static void patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
+    uint32_t insn =3D *code_ptr;
+    intptr_t diff;
+    bool short_jmp;
+
     tcg_debug_assert(addend =3D=3D 0);
+
     switch (type) {
     case R_RISCV_BRANCH:
-        reloc_sbimm12(code_ptr, (tcg_insn_unit *)value);
+        diff =3D value - (uintptr_t)code_ptr;
+#if TCG_TARGET_REG_BITS =3D=3D 64
+        short_jmp =3D diff =3D=3D sextract64(diff, 0, 12);
+#else
+        short_jmp =3D diff =3D=3D sextract32(diff, 0, 12);
+#endif
+        if (short_jmp) {
+            reloc_sbimm12(code_ptr, (tcg_insn_unit *)value);
+        } else {
+            /* Invert the condition */
+            insn =3D insn ^ (1 << 12);
+            /* Clear the offset */
+            insn &=3D 0xFFF;
+            /* Set the offset to the PC + 8 */
+            insn |=3D ((unsigned int)(code_ptr + 8)) << 12;
+
+            /* Move forward */
+            code_ptr++;
+            insn =3D *code_ptr;
+
+            /* Overwrite the NOP with jal x0,value */
+            insn =3D encode_uj(OPC_JAL, TCG_REG_ZERO, value);
+        }
         break;
     case R_RISCV_JAL:
         reloc_jimm20(code_ptr, (tcg_insn_unit *)value);
@@ -677,16 +704,27 @@ static void tcg_out_brcond(TCGContext *s, TCGCond con=
d, TCGReg arg1,
                            TCGReg arg2, TCGLabel *l)
 {
     RISCVInsn op =3D tcg_brcond_to_riscv[cond].op;
+    intptr_t diff;
     bool swap =3D tcg_brcond_to_riscv[cond].swap;
+    bool short_jmp;
+
+    tcg_debug_assert(op !=3D 0);
=20
     tcg_out_opc_branch(s, op, swap ? arg2 : arg1, swap ? arg1 : arg2, 0);
=20
-    tcg_debug_assert(op !=3D 0);
+    diff =3D l->u.value_ptr - (uintptr_t)s->code_gen_ptr;
+#if TCG_TARGET_REG_BITS =3D=3D 64
+    short_jmp =3D diff =3D=3D sextract64(diff, 0, 12);
+#else
+    short_jmp =3D diff =3D=3D sextract32(diff, 0, 12);
+#endif
=20
-    if (l->has_value) {
+    if (l->has_value && short_jmp) {
         reloc_sbimm12(s->code_ptr - 1, l->u.value_ptr);
     } else {
         tcg_out_reloc(s, s->code_ptr - 1, R_RISCV_BRANCH, l, 0);
+        /* NOP to allow patching later */
+        tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_ZERO, TCG_REG_ZERO, 0);
     }
 }
=20
--=20
2.19.1
