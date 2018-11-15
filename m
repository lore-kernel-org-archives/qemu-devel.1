Received: from eggs.gnu.org ([2001:4830:134:3::10]:47727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8503fdbbc=Alistair.Francis@wdc.com>)
	id 1gNQEj-0006Sk-3Z
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:35:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8503fdbbc=Alistair.Francis@wdc.com>)
	id 1gNQEf-0004JF-Qj
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:35:44 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 15 Nov 2018 22:35:33 +0000
Message-ID: <1fe9630dd4ad73b8581684cd0ed6d5fa2918390f.1542321076.git.alistair.francis@wdc.com>
References: <cover.1542321076.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1542321076.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v1 11/23] riscv: tcg-target: Add the relocation
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 tcg/riscv/tcg-target.inc.c | 51 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index d402e48cbf..475feca906 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -371,6 +371,57 @@ static void tcg_out_opc_jump(TCGContext *s, RISCVInsn =
opc,
     tcg_out32(s, encode_uj(opc, rd, imm));
 }
=20
+/*
+ * Relocations
+ */
+
+static void reloc_sbimm12(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+{
+    intptr_t offset =3D (intptr_t)target - (intptr_t)code_ptr;
+    tcg_debug_assert(offset =3D=3D sextract32(offset, 1, 12) << 1);
+
+    code_ptr[0] |=3D encode_sbimm12(offset);
+}
+
+static void reloc_jimm20(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+{
+    intptr_t offset =3D (intptr_t)target - (intptr_t)code_ptr;
+    tcg_debug_assert(offset =3D=3D sextract32(offset, 1, 20) << 1);
+
+    code_ptr[0] |=3D encode_ujimm12(offset);
+}
+
+static void reloc_call(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+{
+    intptr_t offset =3D (intptr_t)target - (intptr_t)code_ptr;
+    tcg_debug_assert(offset =3D=3D (int32_t)offset);
+
+    int32_t hi20 =3D ((offset + 0x800) >> 12) << 12;
+    int32_t lo12 =3D offset - hi20;
+
+    code_ptr[0] |=3D encode_uimm20(hi20);
+    code_ptr[1] |=3D encode_imm12(lo12);
+}
+
+static void patch_reloc(tcg_insn_unit *code_ptr, int type,
+                        intptr_t value, intptr_t addend)
+{
+    tcg_debug_assert(addend =3D=3D 0);
+    switch (type) {
+    case R_RISCV_BRANCH:
+        reloc_sbimm12(code_ptr, (tcg_insn_unit *)value);
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
+
 void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
                               uintptr_t addr)
 {
--=20
2.19.1
