Received: from eggs.gnu.org ([2001:4830:134:3::10]:40077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQnP-0002wQ-JK
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:48:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQnM-00012b-CM
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:48:39 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 8 Dec 2018 00:48:33 +0000
Message-ID: <d579b3cc437a3b81025d42fee40faaf3c0196470.1544229872.git.alistair.francis@wdc.com>
References: <cover.1544229872.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544229872.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v3 15/24] riscv: tcg-target: Add the add2 and
 sub2 instructions
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
 tcg/riscv/tcg-target.inc.c | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 04e81f811a..10bd007cd4 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -681,3 +681,58 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, T=
CGArg val,
     }
     return false;
 }
+
+static void tcg_out_addsub2(TCGContext *s,
+                            TCGReg rl, TCGReg rh,
+                            TCGReg al, TCGReg ah,
+                            TCGReg bl, TCGReg bh,
+                            bool cbl, bool cbh, bool is_sub, bool is32bit)
+{
+    const RISCVInsn opc_add =3D is32bit ? OPC_ADDW : OPC_ADD;
+    const RISCVInsn opc_addi =3D is32bit ? OPC_ADDIW : OPC_ADDI;
+    const RISCVInsn opc_sub =3D is32bit ? OPC_SUBW : OPC_SUB;
+    TCGReg th =3D TCG_REG_TMP1;
+
+    /* If we have a negative constant such that negating it would
+       make the high part zero, we can (usually) eliminate one insn.  */
+    if (cbl && cbh && bh =3D=3D -1 && bl !=3D 0) {
+        bl =3D -bl;
+        bh =3D 0;
+        is_sub =3D !is_sub;
+    }
+
+    /* By operating on the high part first, we get to use the final
+       carry operation to move back from the temporary.  */
+    if (!cbh) {
+        tcg_out_opc_reg(s, (is_sub ? opc_sub : opc_add), th, ah, bh);
+    } else if (bh !=3D 0 || ah =3D=3D rl) {
+        tcg_out_opc_imm(s, opc_addi, th, ah, (is_sub ? -bh : bh));
+    } else {
+        th =3D ah;
+    }
+
+    /* Note that tcg optimization should eliminate the bl =3D=3D 0 case.  =
*/
+    if (is_sub) {
+        if (cbl) {
+            tcg_out_opc_imm(s, OPC_SLTIU, TCG_REG_TMP0, al, bl);
+            tcg_out_opc_imm(s, opc_addi, rl, al, -bl);
+        } else {
+            tcg_out_opc_reg(s, OPC_SLTU, TCG_REG_TMP0, al, bl);
+            tcg_out_opc_reg(s, opc_sub, rl, al, bl);
+        }
+        tcg_out_opc_reg(s, opc_sub, rh, th, TCG_REG_TMP0);
+    } else {
+        if (cbl) {
+            tcg_out_opc_imm(s, opc_addi, rl, al, bl);
+            tcg_out_opc_imm(s, OPC_SLTIU, TCG_REG_TMP0, rl, bl);
+        } else if (rl =3D=3D al && rl =3D=3D bl) {
+            tcg_out_opc_imm(s, OPC_SLTI, TCG_REG_TMP0, al, 0);
+            tcg_out_opc_reg(s, opc_addi, rl, al, bl);
+        } else {
+            tcg_out_opc_reg(s, opc_add, rl, al, bl);
+            tcg_out_opc_reg(s, OPC_SLTU, TCG_REG_TMP0,
+                            rl, (rl =3D=3D bl ? al : bl));
+        }
+        tcg_out_opc_reg(s, opc_add, rh, th, TCG_REG_TMP0);
+    }
+}
--=20
2.19.1
