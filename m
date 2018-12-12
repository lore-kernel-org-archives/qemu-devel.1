Received: from eggs.gnu.org ([2001:4830:134:3::10]:48568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8779827ad=Alistair.Francis@wdc.com>)
	id 1gXAQa-00013s-4G
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8779827ad=Alistair.Francis@wdc.com>)
	id 1gXAQW-00027C-26
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:44:16 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Wed, 12 Dec 2018 19:43:55 +0000
Message-ID: <4fcd5630ea673024b1c17f2987043176e78ee673.1544643238.git.alistair.francis@wdc.com>
References: <cover.1544643238.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544643238.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 07/23] riscv: tcg-target: Add support for
 the constraints
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.inc.c | 168 +++++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 6c969e3973..f853d01803 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -116,3 +116,171 @@ static const int tcg_target_call_oarg_regs[] =3D {
     TCG_REG_A0,
     TCG_REG_A1,
 };
+
+#define TCG_CT_CONST_ZERO  0x100
+#define TCG_CT_CONST_S12   0x200
+#define TCG_CT_CONST_N12   0x400
+#define TCG_CT_CONST_M12   0x800
+
+static inline tcg_target_long sextreg(tcg_target_long val, int pos, int le=
n)
+{
+    if (TCG_TARGET_REG_BITS =3D=3D 32) {
+        return sextract32(val, pos, len);
+    } else {
+        return sextract64(val, pos, len);
+    }
+}
+
+/* parse target specific constraints */
+static const char *target_parse_constraint(TCGArgConstraint *ct,
+                                           const char *ct_str, TCGType typ=
e)
+{
+    switch (*ct_str++) {
+    case 'r':
+        ct->ct |=3D TCG_CT_REG;
+        ct->u.regs =3D 0xffffffff;
+        break;
+    case 'L':
+        /* qemu_ld/qemu_st constraint */
+        ct->ct |=3D TCG_CT_REG;
+        ct->u.regs =3D 0xffffffff;
+        /* qemu_ld/qemu_st uses TCG_REG_TMP0 */
+#if defined(CONFIG_SOFTMMU)
+        tcg_regset_reset_reg(ct->u.regs, tcg_target_call_iarg_regs[0]);
+        tcg_regset_reset_reg(ct->u.regs, tcg_target_call_iarg_regs[1]);
+        tcg_regset_reset_reg(ct->u.regs, tcg_target_call_iarg_regs[2]);
+        tcg_regset_reset_reg(ct->u.regs, tcg_target_call_iarg_regs[3]);
+        tcg_regset_reset_reg(ct->u.regs, tcg_target_call_iarg_regs[4]);
+#endif
+        break;
+    case 'I':
+        ct->ct |=3D TCG_CT_CONST_S12;
+        break;
+    case 'N':
+        ct->ct |=3D TCG_CT_CONST_N12;
+        break;
+    case 'M':
+        ct->ct |=3D TCG_CT_CONST_M12;
+        break;
+    case 'Z':
+        /* we can use a zero immediate as a zero register argument. */
+        ct->ct |=3D TCG_CT_CONST_ZERO;
+        break;
+    default:
+        return NULL;
+    }
+    return ct_str;
+}
+
+/* test if a constant matches the constraint */
+static int tcg_target_const_match(tcg_target_long val, TCGType type,
+                                  const TCGArgConstraint *arg_ct)
+{
+    int ct =3D arg_ct->ct;
+    if (ct & TCG_CT_CONST) {
+        return 1;
+    }
+    if ((ct & TCG_CT_CONST_ZERO) && val =3D=3D 0) {
+        return 1;
+    }
+    if ((ct & TCG_CT_CONST_S12) && val =3D=3D sextreg(val, 0, 12)) {
+        return 1;
+    }
+    if ((ct & TCG_CT_CONST_N12) && -val =3D=3D sextreg(-val, 0, 12)) {
+        return 1;
+    }
+    if ((ct & TCG_CT_CONST_M12) && val >=3D -0xfff && val <=3D 0xfff) {
+        return 1;
+    }
+    return 0;
+}
+
+/*
+ * RISC-V Base ISA opcodes (IM)
+ */
+
+typedef enum {
+    OPC_ADD =3D 0x33,
+    OPC_ADDI =3D 0x13,
+    OPC_AND =3D 0x7033,
+    OPC_ANDI =3D 0x7013,
+    OPC_AUIPC =3D 0x17,
+    OPC_BEQ =3D 0x63,
+    OPC_BGE =3D 0x5063,
+    OPC_BGEU =3D 0x7063,
+    OPC_BLT =3D 0x4063,
+    OPC_BLTU =3D 0x6063,
+    OPC_BNE =3D 0x1063,
+    OPC_DIV =3D 0x2004033,
+    OPC_DIVU =3D 0x2005033,
+    OPC_JAL =3D 0x6f,
+    OPC_JALR =3D 0x67,
+    OPC_LB =3D 0x3,
+    OPC_LBU =3D 0x4003,
+    OPC_LD =3D 0x3003,
+    OPC_LH =3D 0x1003,
+    OPC_LHU =3D 0x5003,
+    OPC_LUI =3D 0x37,
+    OPC_LW =3D 0x2003,
+    OPC_LWU =3D 0x6003,
+    OPC_MUL =3D 0x2000033,
+    OPC_MULH =3D 0x2001033,
+    OPC_MULHSU =3D 0x2002033,
+    OPC_MULHU =3D 0x2003033,
+    OPC_OR =3D 0x6033,
+    OPC_ORI =3D 0x6013,
+    OPC_REM =3D 0x2006033,
+    OPC_REMU =3D 0x2007033,
+    OPC_SB =3D 0x23,
+    OPC_SD =3D 0x3023,
+    OPC_SH =3D 0x1023,
+    OPC_SLL =3D 0x1033,
+    OPC_SLLI =3D 0x1013,
+    OPC_SLT =3D 0x2033,
+    OPC_SLTI =3D 0x2013,
+    OPC_SLTIU =3D 0x3013,
+    OPC_SLTU =3D 0x3033,
+    OPC_SRA =3D 0x40005033,
+    OPC_SRAI =3D 0x40005013,
+    OPC_SRL =3D 0x5033,
+    OPC_SRLI =3D 0x5013,
+    OPC_SUB =3D 0x40000033,
+    OPC_SW =3D 0x2023,
+    OPC_XOR =3D 0x4033,
+    OPC_XORI =3D 0x4013,
+
+#if TCG_TARGET_REG_BITS =3D=3D 64
+    OPC_ADDIW =3D 0x1b,
+    OPC_ADDW =3D 0x3b,
+    OPC_DIVUW =3D 0x200503b,
+    OPC_DIVW =3D 0x200403b,
+    OPC_MULW =3D 0x200003b,
+    OPC_REMUW =3D 0x200703b,
+    OPC_REMW =3D 0x200603b,
+    OPC_SLLIW =3D 0x101b,
+    OPC_SLLW =3D 0x103b,
+    OPC_SRAIW =3D 0x4000501b,
+    OPC_SRAW =3D 0x4000503b,
+    OPC_SRLIW =3D 0x501b,
+    OPC_SRLW =3D 0x503b,
+    OPC_SUBW =3D 0x4000003b,
+#else
+    /* Simplify code throughout by defining aliases for RV32.  */
+    OPC_ADDIW =3D OPC_ADDI,
+    OPC_ADDW =3D OPC_ADD,
+    OPC_DIVUW =3D OPC_DIVU,
+    OPC_DIVW =3D OPC_DIV,
+    OPC_MULW =3D OPC_MUL,
+    OPC_REMUW =3D OPC_REMU,
+    OPC_REMW =3D OPC_REM,
+    OPC_SLLIW =3D OPC_SLLI,
+    OPC_SLLW =3D OPC_SLL,
+    OPC_SRAIW =3D OPC_SRAI,
+    OPC_SRAW =3D OPC_SRA,
+    OPC_SRLIW =3D OPC_SRLI,
+    OPC_SRLW =3D OPC_SRL,
+    OPC_SUBW =3D OPC_SUB,
+#endif
+
+    OPC_FENCE =3D 0x0000000f,
+} RISCVInsn;
--=20
2.19.1
