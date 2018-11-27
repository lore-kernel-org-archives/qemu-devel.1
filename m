Received: from eggs.gnu.org ([2001:4830:134:3::10]:37288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=862abf4e0=Alistair.Francis@wdc.com>)
	id 1gRkcV-0006dT-FH
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=862abf4e0=Alistair.Francis@wdc.com>)
	id 1gRkcS-0005T8-8z
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:10:11 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 27 Nov 2018 21:10:05 +0000
Message-ID: <46fe7e6cef5c03c2165feaf400cca797ee1b10f9.1543352682.git.alistair.francis@wdc.com>
References: <cover.1543352682.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1543352682.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v2 23/24] WIP: Add missing instructions
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
 tcg/riscv/tcg-target.inc.c | 77 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 13756f6d0d..b8e9c0e126 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -606,6 +606,57 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, T=
CGArg val,
     return false;
 }
=20
+static void tcg_out_addsub2(TCGContext *s,
+                            TCGReg rl, TCGReg rh,
+                            TCGReg al, TCGReg ah,
+                            TCGReg bl, TCGReg bh,
+                            bool cbl, bool cbh, bool is_sub)
+{
+    /* FIXME: This is just copied from MIPS */
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
+        tcg_out_opc_reg(s, (is_sub ? OPC_SUB : OPC_ADDI), th, ah, bh);
+    } else if (bh !=3D 0 || ah =3D=3D rl) {
+        tcg_out_opc_imm(s, OPC_ADDI, th, ah, (is_sub ? -bh : bh));
+    } else {
+        th =3D ah;
+    }
+
+    if (is_sub) {
+        if (cbl) {
+            tcg_out_opc_imm(s, OPC_SLLI, TCG_REG_TMP0, al, bl);
+            tcg_out_opc_imm(s, OPC_ADDI, rl, al, -bl);
+        } else {
+            tcg_out_opc_reg(s, OPC_SLLI, TCG_REG_TMP0, al, bl);
+            tcg_out_opc_reg(s, OPC_SUB, rl, al, bl);
+        }
+        tcg_out_opc_reg(s, OPC_SUB, rh, th, TCG_REG_TMP0);
+    } else {
+        if (cbl) {
+            tcg_out_opc_imm(s, OPC_ADDI, rl, al, bl);
+            tcg_out_opc_imm(s, OPC_SLLI, TCG_REG_TMP0, rl, bl);
+        } else if (rl =3D=3D al && rl =3D=3D bl) {
+            tcg_out_opc_imm(s, OPC_SRLI, TCG_REG_TMP0, al, 31);
+            tcg_out_opc_reg(s, OPC_ADDI, rl, al, bl);
+        } else {
+            tcg_out_opc_reg(s, OPC_ADDI, rl, al, bl);
+            tcg_out_opc_reg(s, OPC_SLLI, TCG_REG_TMP0, rl, (rl =3D=3D bl ?=
 al : bl));
+        }
+        tcg_out_opc_reg(s, OPC_ADDI, rh, th, TCG_REG_TMP0);
+    }
+}
+
 static const struct {
     RISCVInsn op;
     bool swap;
@@ -1384,6 +1435,18 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
=20
+    case INDEX_op_add2_i32:
+    case INDEX_op_add2_i64:
+        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
+                        const_args[4], const_args[5], false);
+        break;
+
+    case INDEX_op_sub2_i32:
+    case INDEX_op_sub2_i64:
+        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
+                        const_args[4], const_args[5], true);
+        break;
+
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
         tcg_out_brcond(s, a2, a0, a1, arg_label(args[3]));
@@ -1439,6 +1502,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
=20
     case INDEX_op_ext32s_i64:
+    case INDEX_op_extrl_i64_i32:
+    case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
         tcg_out_ext32s(s, a0, a1);
         break;
@@ -1505,6 +1570,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpc=
ode op)
         =3D { .args_ct_str =3D { "LZ", "LZ", "L" } };
     static const TCGTargetOpDef LZ_LZ_L_L
         =3D { .args_ct_str =3D { "LZ", "LZ", "L", "L" } };
+    static const TCGTargetOpDef rZ_rZ_rZ_rZ_rZ_rZ
+        =3D { .args_ct_str =3D { "rZ", "rZ", "rZ", "rZ", "rZ", "rZ" } };
=20
     switch (op) {
     case INDEX_op_goto_ptr:
@@ -1537,6 +1604,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpc=
ode op)
     case INDEX_op_ext16s_i32:
     case INDEX_op_ext16s_i64:
     case INDEX_op_ext32s_i64:
+    case INDEX_op_extrl_i64_i32:
+    case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
         return &r_r;
=20
@@ -1593,6 +1662,14 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOp=
code op)
     case INDEX_op_brcond_i64:
         return &rZ_rZ;
=20
+    case INDEX_op_add2_i32:
+    case INDEX_op_add2_i64:
+        return &rZ_rZ_rZ_rZ_rZ_rZ;
+
+    case INDEX_op_sub2_i32:
+    case INDEX_op_sub2_i64:
+        return &rZ_rZ_rZ_rZ_rZ_rZ;
+
     case INDEX_op_brcond2_i32:
         return &rZ_rZ_rZ_rZ;
=20
--=20
2.19.1
