Received: from eggs.gnu.org ([2001:4830:134:3::10]:47640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8503fdbbc=Alistair.Francis@wdc.com>)
	id 1gNQED-0005zT-8J
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8503fdbbc=Alistair.Francis@wdc.com>)
	id 1gNQE9-0003ty-GV
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:35:13 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 15 Nov 2018 22:35:05 +0000
Message-ID: <1d5f88588063393fe28b689ce9501715022052ed.1542321076.git.alistair.francis@wdc.com>
References: <cover.1542321076.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1542321076.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v1 08/23] riscv: tcg-target: Add support for the
 constraints
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
 tcg/riscv/tcg-target.inc.c | 139 +++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index a9c57493a0..e585740870 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -119,6 +119,145 @@ static const int tcg_target_call_oarg_regs[] =3D {
 #define TCG_CT_CONST_S12   0x200
 #define TCG_CT_CONST_N12   0x400
=20
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
+        /* tcg_out_tlb_load uses TCG_REG_TMP0/TMP1 and TCG_REG_L0/L1 */
+        /* tcg_regset_reset_reg(ct->u.regs, TCG_REG_TMP0); */
+        /* tcg_regset_reset_reg(ct->u.regs, TCG_REG_TMP1); */
+        tcg_regset_reset_reg(ct->u.regs, TCG_REG_TMP2);
+
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
+    if ((ct & TCG_CT_CONST_S12) && val >=3D -2048 && val <=3D 2047) {
+        return 1;
+    }
+    if ((ct & TCG_CT_CONST_N12) && val >=3D -2047 && val <=3D 2048) {
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
+    OPC_ADDIW =3D 0x1b,
+    OPC_ADDW =3D 0x3b,
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
+    OPC_DIVUW =3D 0x200503b,
+    OPC_DIVW =3D 0x200403b,
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
+    OPC_MULW =3D 0x200003b,
+    OPC_OR =3D 0x6033,
+    OPC_ORI =3D 0x6013,
+    OPC_REM =3D 0x2006033,
+    OPC_REMU =3D 0x2007033,
+    OPC_REMUW =3D 0x200703b,
+    OPC_REMW =3D 0x200603b,
+    OPC_SB =3D 0x23,
+    OPC_SD =3D 0x3023,
+    OPC_SH =3D 0x1023,
+    OPC_SLL =3D 0x1033,
+    OPC_SLLI =3D 0x1013,
+    OPC_SLLIW =3D 0x101b,
+    OPC_SLLW =3D 0x103b,
+    OPC_SLT =3D 0x2033,
+    OPC_SLTI =3D 0x2013,
+    OPC_SLTIU =3D 0x3013,
+    OPC_SLTU =3D 0x3033,
+    OPC_SRA =3D 0x40005033,
+    OPC_SRAI =3D 0x40005013,
+    OPC_SRAIW =3D 0x4000501b,
+    OPC_SRAW =3D 0x4000503b,
+    OPC_SRL =3D 0x5033,
+    OPC_SRLI =3D 0x5013,
+    OPC_SRLIW =3D 0x501b,
+    OPC_SRLW =3D 0x503b,
+    OPC_SUB =3D 0x40000033,
+    OPC_SUBW =3D 0x4000003b,
+    OPC_SW =3D 0x2023,
+    OPC_XOR =3D 0x4033,
+    OPC_XORI =3D 0x4013,
+    OPC_FENCE_RW_RW =3D 0x0330000f,
+    OPC_FENCE_R_R =3D 0x0220000f,
+    OPC_FENCE_W_R =3D 0x0120000f,
+    OPC_FENCE_R_W =3D 0x0210000f,
+    OPC_FENCE_W_W =3D 0x0110000f,
+    OPC_FENCE_R_RW =3D 0x0230000f,
+    OPC_FENCE_RW_W =3D 0x0310000f,
+} RISCVInsn;
+
 typedef struct {
     DebugFrameHeader h;
     uint8_t fde_def_cfa[4];
--=20
2.19.1
