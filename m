Received: from eggs.gnu.org ([2001:4830:134:3::10]:40143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQnY-00035l-US
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQnV-00015j-Mk
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:48:48 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 8 Dec 2018 00:48:42 +0000
Message-ID: <4369495a6e303d93663e99b3c2239c8d2a1eccba.1544229872.git.alistair.francis@wdc.com>
References: <cover.1544229872.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544229872.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v3 16/24] riscv: tcg-target: Add branch and jump
 instructions
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
 tcg/riscv/tcg-target.inc.c | 142 +++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 10bd007cd4..a00bbe8ff1 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -736,3 +736,145 @@ static void tcg_out_addsub2(TCGContext *s,
         tcg_out_opc_reg(s, opc_add, rh, th, TCG_REG_TMP0);
     }
 }
+
+static const struct {
+    RISCVInsn op;
+    bool swap;
+} tcg_brcond_to_riscv[] =3D {
+    [TCG_COND_EQ] =3D  { OPC_BEQ,  false },
+    [TCG_COND_NE] =3D  { OPC_BNE,  false },
+    [TCG_COND_LT] =3D  { OPC_BLT,  false },
+    [TCG_COND_GE] =3D  { OPC_BGE,  false },
+    [TCG_COND_LE] =3D  { OPC_BGE,  true  },
+    [TCG_COND_GT] =3D  { OPC_BLT,  true  },
+    [TCG_COND_LTU] =3D { OPC_BLTU, false },
+    [TCG_COND_GEU] =3D { OPC_BGEU, false },
+    [TCG_COND_LEU] =3D { OPC_BGEU, true  },
+    [TCG_COND_GTU] =3D { OPC_BLTU, true  }
+};
+
+static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
+                           TCGReg arg2, TCGLabel *l)
+{
+    RISCVInsn op =3D tcg_brcond_to_riscv[cond].op;
+
+    tcg_debug_assert(op !=3D 0);
+
+    if (tcg_brcond_to_riscv[cond].swap) {
+        TCGReg t =3D arg1;
+        arg1 =3D arg2;
+        arg2 =3D t;
+    }
+
+    if (l->has_value) {
+        intptr_t diff =3D tcg_pcrel_diff(s, l->u.value_ptr);
+        if (diff =3D=3D sextreg(diff, 0, 12)) {
+            tcg_out_opc_branch(s, op, arg1, arg2, diff);
+        } else {
+            /* Invert the conditional branch.  */
+            tcg_out_opc_branch(s, op ^ (1 << 12), arg1, arg2, 8);
+            tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, diff - 4);
+        }
+    } else {
+        tcg_out_reloc(s, s->code_ptr, R_RISCV_BRANCH, l, 0);
+        tcg_out_opc_branch(s, op, arg1, arg2, 0);
+        /* NOP to allow patching later */
+        tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_ZERO, TCG_REG_ZERO, 0);
+    }
+}
+
+static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
+                            TCGReg arg1, TCGReg arg2)
+{
+    switch (cond) {
+    case TCG_COND_EQ:
+        tcg_out_opc_reg(s, OPC_SUB, ret, arg1, arg2);
+        tcg_out_opc_imm(s, OPC_SLTIU, ret, ret, 1);
+        break;
+    case TCG_COND_NE:
+        tcg_out_opc_reg(s, OPC_SUB, ret, arg1, arg2);
+        tcg_out_opc_reg(s, OPC_SLTU, ret, TCG_REG_ZERO, ret);
+        break;
+    case TCG_COND_LT:
+        tcg_out_opc_reg(s, OPC_SLT, ret, arg1, arg2);
+        break;
+    case TCG_COND_GE:
+        tcg_out_opc_reg(s, OPC_SLT, ret, arg1, arg2);
+        tcg_out_opc_imm(s, OPC_XORI, ret, ret, 1);
+        break;
+    case TCG_COND_LE:
+        tcg_out_opc_reg(s, OPC_SLT, ret, arg2, arg1);
+        tcg_out_opc_imm(s, OPC_XORI, ret, ret, 1);
+        break;
+    case TCG_COND_GT:
+        tcg_out_opc_reg(s, OPC_SLT, ret, arg2, arg1);
+        break;
+    case TCG_COND_LTU:
+        tcg_out_opc_reg(s, OPC_SLTU, ret, arg1, arg2);
+        break;
+    case TCG_COND_GEU:
+        tcg_out_opc_reg(s, OPC_SLTU, ret, arg1, arg2);
+        tcg_out_opc_imm(s, OPC_XORI, ret, ret, 1);
+        break;
+    case TCG_COND_LEU:
+        tcg_out_opc_reg(s, OPC_SLTU, ret, arg2, arg1);
+        tcg_out_opc_imm(s, OPC_XORI, ret, ret, 1);
+        break;
+    case TCG_COND_GTU:
+        tcg_out_opc_reg(s, OPC_SLTU, ret, arg2, arg1);
+        break;
+    default:
+         g_assert_not_reached();
+         break;
+     }
+}
+
+static void tcg_out_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg=
 ah,
+                            TCGReg bl, TCGReg bh, TCGLabel *l)
+{
+    /* todo */
+    g_assert_not_reached();
+}
+
+static void tcg_out_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
+                             TCGReg al, TCGReg ah, TCGReg bl, TCGReg bh)
+{
+    /* todo */
+    g_assert_not_reached();
+}
+
+static inline void tcg_out_goto(TCGContext *s, tcg_insn_unit *target)
+{
+    ptrdiff_t offset =3D tcg_pcrel_diff(s, target);
+    tcg_debug_assert(offset =3D=3D sextreg(offset, 1, 20) << 1);
+    tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, offset);
+}
+
+static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
+{
+    TCGReg link =3D tail ? TCG_REG_ZERO : TCG_REG_RA;
+    ptrdiff_t offset =3D tcg_pcrel_diff(s, arg);
+    if (offset =3D=3D sextreg(offset, 1, 20) << 1) {
+        /* short jump: -2097150 to 2097152 */
+        tcg_out_opc_jump(s, OPC_JAL, link, offset);
+    } else if (TCG_TARGET_REG_BITS =3D=3D 32 ||
+        offset =3D=3D sextreg(offset, 1, 31) << 1) {
+        /* long jump: -2147483646 to 2147483648 */
+        tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, 0);
+        tcg_out_opc_imm(s, OPC_JALR, link, TCG_REG_TMP0, 0);
+        reloc_call(s->code_ptr - 2, arg);
+    } else if (TCG_TARGET_REG_BITS =3D=3D 64) {
+        /* far jump: 64-bit */
+        tcg_target_long imm =3D sextreg((tcg_target_long)arg, 0, 12);
+        tcg_target_long base =3D (tcg_target_long)arg - imm;
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, base);
+        tcg_out_opc_imm(s, OPC_JALR, link, TCG_REG_TMP0, imm);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
+{
+    tcg_out_call_int(s, arg, false);
+}
--=20
2.19.1
