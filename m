Received: from eggs.gnu.org ([2001:4830:134:3::10]:48192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8503fdbbc=Alistair.Francis@wdc.com>)
	id 1gNQFq-0007O3-Uq
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:36:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8503fdbbc=Alistair.Francis@wdc.com>)
	id 1gNQFn-0004lz-JE
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:36:54 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 15 Nov 2018 22:36:37 +0000
Message-ID: <4e25322ab80efb351d006d50672048fea2c71a03.1542321076.git.alistair.francis@wdc.com>
References: <cover.1542321076.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1542321076.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v1 18/23] riscv: tcg-target: Add the out op
 decoder
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
 tcg/riscv/tcg-target.inc.c | 472 +++++++++++++++++++++++++++++++++++++
 1 file changed, 472 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index c4a013a962..bf3b04f7dc 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -1103,6 +1103,478 @@ static void tcg_out_qemu_st(TCGContext *s, const TC=
GArg *args, bool is_64)
 #endif
 }
=20
+static tcg_insn_unit *tb_ret_addr;
+
+static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+                       const TCGArg *args, const int *const_args)
+{
+    TCGArg a0 =3D args[0];
+    TCGArg a1 =3D args[1];
+    TCGArg a2 =3D args[2];
+    int c2 =3D const_args[2];
+    const bool is32bit =3D TCG_TARGET_REG_BITS =3D=3D 32;
+
+    switch (opc) {
+    case INDEX_op_exit_tb:
+        /* Reuse the zeroing that exists for goto_ptr.  */
+        if (a0 =3D=3D 0) {
+            tcg_out_goto_long(s, s->code_gen_epilogue);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_A0, a0);
+            tcg_out_goto_long(s, tb_ret_addr);
+        }
+        break;
+
+    case INDEX_op_goto_tb:
+        if (s->tb_jmp_insn_offset) {
+            /* direct jump method */
+            s->tb_jmp_insn_offset[a0] =3D tcg_current_code_size(s);
+            /* should align on 64-bit boundary for atomic patching */
+            tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, 0);
+            tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, TCG_REG_TMP0, 0);
+        } else {
+            /* indirect jump method */
+            tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, TCG_REG_ZERO,
+                       (uintptr_t)(s->tb_jmp_target_addr + a0));
+            tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, TCG_REG_TMP0, 0);
+        }
+        s->tb_jmp_reset_offset[a0] =3D tcg_current_code_size(s);
+        break;
+
+    case INDEX_op_goto_ptr:
+        tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, a0, 0);
+        break;
+
+    case INDEX_op_br:
+        tcg_out_reloc(s, s->code_ptr, R_RISCV_JAL, arg_label(a0), 0);
+        tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, 0);
+        break;
+
+    case INDEX_op_ld8u_i32:
+    case INDEX_op_ld8u_i64:
+        tcg_out_ldst(s, OPC_LBU, a0, a1, a2);
+        break;
+    case INDEX_op_ld8s_i32:
+    case INDEX_op_ld8s_i64:
+        tcg_out_ldst(s, OPC_LB, a0, a1, a2);
+        break;
+    case INDEX_op_ld16u_i32:
+    case INDEX_op_ld16u_i64:
+        tcg_out_ldst(s, OPC_LHU, a0, a1, a2);
+        break;
+    case INDEX_op_ld16s_i32:
+    case INDEX_op_ld16s_i64:
+        tcg_out_ldst(s, OPC_LH, a0, a1, a2);
+        break;
+    case INDEX_op_ld32u_i64:
+        tcg_out_ldst(s, OPC_LWU, a0, a1, a2);
+        break;
+    case INDEX_op_ld_i32:
+    case INDEX_op_ld32s_i64:
+        tcg_out_ldst(s, OPC_LW, a0, a1, a2);
+        break;
+    case INDEX_op_ld_i64:
+        tcg_out_ldst(s, OPC_LD, a0, a1, a2);
+        break;
+
+    case INDEX_op_st8_i32:
+    case INDEX_op_st8_i64:
+        tcg_out_ldst(s, OPC_SB, a0, a1, a2);
+        break;
+    case INDEX_op_st16_i32:
+    case INDEX_op_st16_i64:
+        tcg_out_ldst(s, OPC_SH, a0, a1, a2);
+        break;
+    case INDEX_op_st_i32:
+    case INDEX_op_st32_i64:
+        tcg_out_ldst(s, OPC_SW, a0, a1, a2);
+        break;
+    case INDEX_op_st_i64:
+        tcg_out_ldst(s, OPC_SD, a0, a1, a2);
+        break;
+
+    case INDEX_op_add_i32:
+        if (c2) {
+            tcg_out_opc_imm(s, is32bit ? OPC_ADDI : OPC_ADDIW, a0, a1, a2)=
;
+        } else {
+            tcg_out_opc_reg(s, is32bit ? OPC_ADD : OPC_ADDW, a0, a1, a2);
+        }
+        break;
+    case INDEX_op_add_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_ADDI, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_ADD, a0, a1, a2);
+        }
+        break;
+
+    case INDEX_op_sub_i32:
+        if (c2) {
+            tcg_out_opc_imm(s, is32bit ? OPC_ADDI : OPC_ADDIW, a0, a1, -a2=
);
+        } else {
+            tcg_out_opc_reg(s, is32bit ? OPC_SUB : OPC_SUBW, a0, a1, a2);
+        }
+        break;
+    case INDEX_op_sub_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_ADDI, a0, a1, -a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_SUB, a0, a1, a2);
+        }
+        break;
+
+    case INDEX_op_and_i32:
+    case INDEX_op_and_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_ANDI, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_AND, a0, a1, a2);
+        }
+        break;
+
+    case INDEX_op_or_i32:
+    case INDEX_op_or_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_ORI, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_OR, a0, a1, a2);
+        }
+        break;
+
+    case INDEX_op_xor_i32:
+    case INDEX_op_xor_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_XORI, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_XOR, a0, a1, a2);
+        }
+        break;
+
+    case INDEX_op_not_i32:
+    case INDEX_op_not_i64:
+        tcg_out_opc_imm(s, OPC_XORI, a0, a1, -1);
+        break;
+
+    case INDEX_op_neg_i32:
+        tcg_out_opc_reg(s, is32bit ? OPC_SUB : OPC_SUBW, a0, TCG_REG_ZERO,=
 a1);
+        break;
+    case INDEX_op_neg_i64:
+        tcg_out_opc_imm(s, OPC_SUB, a0, TCG_REG_ZERO, a1);
+        break;
+
+    case INDEX_op_mul_i32:
+        tcg_out_opc_reg(s, is32bit ? OPC_MUL : OPC_MULW, a0, a1, a2);
+        break;
+    case INDEX_op_mul_i64:
+        tcg_out_opc_reg(s, OPC_MUL, a0, a1, a2);
+        break;
+
+    case INDEX_op_div_i32:
+        tcg_out_opc_reg(s, is32bit ? OPC_DIV : OPC_DIVW, a0, a1, a2);
+        break;
+    case INDEX_op_div_i64:
+        tcg_out_opc_reg(s, OPC_DIV, a0, a1, a2);
+        break;
+
+    case INDEX_op_divu_i32:
+        tcg_out_opc_reg(s, is32bit ? OPC_DIVU : OPC_DIVUW, a0, a1, a2);
+        break;
+    case INDEX_op_divu_i64:
+        tcg_out_opc_reg(s, OPC_DIVU, a0, a1, a2);
+        break;
+
+    case INDEX_op_rem_i32:
+        tcg_out_opc_reg(s, is32bit ? OPC_REM : OPC_REMW, a0, a1, a2);
+        break;
+    case INDEX_op_rem_i64:
+        tcg_out_opc_reg(s, OPC_REM, a0, a1, a2);
+        break;
+
+    case INDEX_op_remu_i32:
+        tcg_out_opc_reg(s, is32bit ? OPC_REMU : OPC_REMUW, a0, a1, a2);
+        break;
+    case INDEX_op_remu_i64:
+        tcg_out_opc_reg(s, OPC_REMU, a0, a1, a2);
+        break;
+
+    case INDEX_op_shl_i32:
+        if (c2) {
+            tcg_out_opc_imm(s, is32bit ? OPC_SLLI : OPC_SLLIW, a0, a1, a2)=
;
+        } else {
+            tcg_out_opc_reg(s, is32bit ? OPC_SLL : OPC_SLLW, a0, a1, a2);
+        }
+        break;
+    case INDEX_op_shl_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_SLLI, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_SLL, a0, a1, a2);
+        }
+        break;
+
+    case INDEX_op_shr_i32:
+        if (c2) {
+            tcg_out_opc_imm(s, is32bit ? OPC_SRLI : OPC_SRLIW, a0, a1, a2)=
;
+        } else {
+            tcg_out_opc_reg(s, is32bit ? OPC_SRL : OPC_SRLW, a0, a1, a2);
+        }
+        break;
+    case INDEX_op_shr_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_SRLI, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_SRL, a0, a1, a2);
+        }
+        break;
+
+    case INDEX_op_sar_i32:
+        if (c2) {
+            tcg_out_opc_imm(s, is32bit ? OPC_SRAI : OPC_SRAIW, a0, a1, a2)=
;
+        } else {
+            tcg_out_opc_reg(s, is32bit ? OPC_SRA : OPC_SRAW, a0, a1, a2);
+        }
+        break;
+    case INDEX_op_sar_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_SRAI, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_SRA, a0, a1, a2);
+        }
+        break;
+
+    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond_i64:
+        tcg_out_brcond(s, a2, a0, a1, arg_label(args[3]));
+        break;
+    case INDEX_op_brcond2_i32:
+        tcg_out_brcond2(s, args[4], a0, a1, a2, args[3], arg_label(args[5]=
));
+        break;
+
+    case INDEX_op_setcond_i32:
+    case INDEX_op_setcond_i64:
+        tcg_out_setcond(s, args[3], a0, a1, a2);
+        break;
+    case INDEX_op_setcond2_i32:
+        tcg_out_setcond2(s, args[5], a0, a1, a2, args[3], args[4]);
+        break;
+
+    case INDEX_op_qemu_ld_i32:
+        tcg_out_qemu_ld(s, args, false);
+        break;
+    case INDEX_op_qemu_ld_i64:
+        tcg_out_qemu_ld(s, args, true);
+        break;
+    case INDEX_op_qemu_st_i32:
+        tcg_out_qemu_st(s, args, false);
+        break;
+    case INDEX_op_qemu_st_i64:
+        tcg_out_qemu_st(s, args, true);
+        break;
+
+    case INDEX_op_ext8u_i32:
+    case INDEX_op_ext8u_i64:
+        tcg_out_ext8u(s, a0, a1);
+        break;
+
+    case INDEX_op_ext16u_i32:
+    case INDEX_op_ext16u_i64:
+        tcg_out_ext16u(s, a0, a1);
+        break;
+
+    case INDEX_op_ext32u_i64:
+    case INDEX_op_extu_i32_i64:
+        tcg_out_ext32u(s, a0, a1);
+        break;
+
+    case INDEX_op_ext8s_i32:
+    case INDEX_op_ext8s_i64:
+        tcg_out_ext8s(s, a0, a1);
+        break;
+
+    case INDEX_op_ext16s_i32:
+    case INDEX_op_ext16s_i64:
+        tcg_out_ext16s(s, a0, a1);
+        break;
+
+    case INDEX_op_ext32s_i64:
+    case INDEX_op_ext_i32_i64:
+        tcg_out_ext32s(s, a0, a1);
+        break;
+
+    case INDEX_op_mulsh_i32:
+    case INDEX_op_mulsh_i64:
+        tcg_out_opc_imm(s, OPC_MULH, a0, a1, a2);
+        break;
+
+    case INDEX_op_muluh_i32:
+    case INDEX_op_muluh_i64:
+        tcg_out_opc_imm(s, OPC_MULHU, a0, a1, a2);
+        break;
+
+    case INDEX_op_mb:
+        tcg_out_mb(s, a0);
+        break;
+
+    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
+    case INDEX_op_mov_i64:
+    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
+    case INDEX_op_movi_i64:
+    case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
+{
+    static const TCGTargetOpDef r
+        =3D { .args_ct_str =3D { "r" } };
+    static const TCGTargetOpDef r_r
+        =3D { .args_ct_str =3D { "r", "r" } };
+    static const TCGTargetOpDef rZ_r
+        =3D { .args_ct_str =3D { "rZ", "r" } };
+    static const TCGTargetOpDef rZ_rZ
+        =3D { .args_ct_str =3D { "rZ", "rZ" } };
+    static const TCGTargetOpDef rZ_rZ_rZ_rZ
+        =3D { .args_ct_str =3D { "rZ", "rZ", "rZ", "rZ" } };
+    static const TCGTargetOpDef r_r_ri
+        =3D { .args_ct_str =3D { "r", "r", "ri" } };
+    static const TCGTargetOpDef r_r_rI
+        =3D { .args_ct_str =3D { "r", "r", "rI" } };
+    static const TCGTargetOpDef r_rZ_rN
+        =3D { .args_ct_str =3D { "r", "rZ", "rN" } };
+    static const TCGTargetOpDef r_rZ_rZ
+        =3D { .args_ct_str =3D { "r", "rZ", "rZ" } };
+    static const TCGTargetOpDef r_rZ_rZ_rZ_rZ
+        =3D { .args_ct_str =3D { "r", "rZ", "rZ", "rZ", "rZ" } };
+    static const TCGTargetOpDef r_L
+        =3D { .args_ct_str =3D { "r", "L" } };
+    static const TCGTargetOpDef r_r_L
+        =3D { .args_ct_str =3D { "r", "r", "L" } };
+    static const TCGTargetOpDef r_L_L
+        =3D { .args_ct_str =3D { "r", "L", "L" } };
+    static const TCGTargetOpDef r_r_L_L
+        =3D { .args_ct_str =3D { "r", "r", "L", "L" } };
+    static const TCGTargetOpDef LZ_L
+        =3D { .args_ct_str =3D { "LZ", "L" } };
+    static const TCGTargetOpDef LZ_L_L
+        =3D { .args_ct_str =3D { "LZ", "L", "L" } };
+    static const TCGTargetOpDef LZ_LZ_L
+        =3D { .args_ct_str =3D { "LZ", "LZ", "L" } };
+    static const TCGTargetOpDef LZ_LZ_L_L
+        =3D { .args_ct_str =3D { "LZ", "LZ", "L", "L" } };
+
+    switch (op) {
+    case INDEX_op_goto_ptr:
+        return &r;
+
+    case INDEX_op_ld8u_i32:
+    case INDEX_op_ld8s_i32:
+    case INDEX_op_ld16u_i32:
+    case INDEX_op_ld16s_i32:
+    case INDEX_op_ld_i32:
+    case INDEX_op_not_i32:
+    case INDEX_op_neg_i32:
+    case INDEX_op_ld8u_i64:
+    case INDEX_op_ld8s_i64:
+    case INDEX_op_ld16u_i64:
+    case INDEX_op_ld16s_i64:
+    case INDEX_op_ld32s_i64:
+    case INDEX_op_ld32u_i64:
+    case INDEX_op_ld_i64:
+    case INDEX_op_not_i64:
+    case INDEX_op_neg_i64:
+    case INDEX_op_ext8u_i32:
+    case INDEX_op_ext8u_i64:
+    case INDEX_op_ext16u_i32:
+    case INDEX_op_ext16u_i64:
+    case INDEX_op_ext32u_i64:
+    case INDEX_op_extu_i32_i64:
+    case INDEX_op_ext8s_i32:
+    case INDEX_op_ext8s_i64:
+    case INDEX_op_ext16s_i32:
+    case INDEX_op_ext16s_i64:
+    case INDEX_op_ext32s_i64:
+    case INDEX_op_ext_i32_i64:
+        return &r_r;
+
+    case INDEX_op_st8_i32:
+    case INDEX_op_st16_i32:
+    case INDEX_op_st_i32:
+    case INDEX_op_st8_i64:
+    case INDEX_op_st16_i64:
+    case INDEX_op_st32_i64:
+    case INDEX_op_st_i64:
+        return &rZ_r;
+
+    case INDEX_op_add_i32:
+    case INDEX_op_and_i32:
+    case INDEX_op_or_i32:
+    case INDEX_op_xor_i32:
+    case INDEX_op_add_i64:
+    case INDEX_op_and_i64:
+    case INDEX_op_or_i64:
+    case INDEX_op_xor_i64:
+        return &r_r_rI;
+
+    case INDEX_op_sub_i32:
+    case INDEX_op_sub_i64:
+        return &r_rZ_rN;
+
+    case INDEX_op_mul_i32:
+    case INDEX_op_mulsh_i32:
+    case INDEX_op_muluh_i32:
+    case INDEX_op_div_i32:
+    case INDEX_op_divu_i32:
+    case INDEX_op_rem_i32:
+    case INDEX_op_remu_i32:
+    case INDEX_op_setcond_i32:
+    case INDEX_op_mul_i64:
+    case INDEX_op_mulsh_i64:
+    case INDEX_op_muluh_i64:
+    case INDEX_op_div_i64:
+    case INDEX_op_divu_i64:
+    case INDEX_op_rem_i64:
+    case INDEX_op_remu_i64:
+    case INDEX_op_setcond_i64:
+        return &r_rZ_rZ;
+
+    case INDEX_op_shl_i32:
+    case INDEX_op_shr_i32:
+    case INDEX_op_sar_i32:
+    case INDEX_op_shl_i64:
+    case INDEX_op_shr_i64:
+    case INDEX_op_sar_i64:
+        return &r_r_ri;
+
+    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond_i64:
+        return &rZ_rZ;
+
+    case INDEX_op_brcond2_i32:
+        return &rZ_rZ_rZ_rZ;
+
+    case INDEX_op_setcond2_i32:
+        return &r_rZ_rZ_rZ_rZ;
+
+    case INDEX_op_qemu_ld_i32:
+        return TARGET_LONG_BITS <=3D TCG_TARGET_REG_BITS ? &r_L : &r_L_L;
+    case INDEX_op_qemu_st_i32:
+        return TARGET_LONG_BITS <=3D TCG_TARGET_REG_BITS ? &LZ_L : &LZ_L_L=
;
+    case INDEX_op_qemu_ld_i64:
+        return TCG_TARGET_REG_BITS =3D=3D 64 ? &r_L
+               : TARGET_LONG_BITS <=3D TCG_TARGET_REG_BITS ? &r_r_L
+               : &r_r_L_L;
+    case INDEX_op_qemu_st_i64:
+        return TCG_TARGET_REG_BITS =3D=3D 64 ? &LZ_L
+               : TARGET_LONG_BITS <=3D TCG_TARGET_REG_BITS ? &LZ_LZ_L
+               : &LZ_LZ_L_L;
+
+    default:
+        return NULL;
+    }
+}
+
 void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
                               uintptr_t addr)
 {
--=20
2.19.1
