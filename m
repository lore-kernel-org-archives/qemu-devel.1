Received: from eggs.gnu.org ([208.118.235.92]:50179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtm7-0005uB-OM
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtm5-0008RK-Iv
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:58:03 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:41507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtm5-0008Qe-Aa
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:58:01 -0500
Received: by mail-pg1-x52b.google.com with SMTP id m1so6814324pgq.8
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:58:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:05 +1100
Message-Id: <20181225205529.10874-19-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 18/42] tcg/riscv: Add the out op decoder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, Michael Clark <mjc@sifive.com>

From: Alistair Francis <Alistair.Francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <7c47f00cb4a9a777120456e0704b4076a5d943ab.1545246859.git.alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.inc.c | 496 +++++++++++++++++++++++++++++++++++++
 1 file changed, 496 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 154315787c..014c5287f5 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -1309,3 +1309,499 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
     tcg_out_qemu_st_direct(s, data_regl, data_regh, base, opc);
 #endif
 }
+
+static tcg_insn_unit *tb_ret_addr;
+
+static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+                       const TCGArg *args, const int *const_args)
+{
+    TCGArg a0 = args[0];
+    TCGArg a1 = args[1];
+    TCGArg a2 = args[2];
+    int c2 = const_args[2];
+
+    switch (opc) {
+    case INDEX_op_exit_tb:
+        /* Reuse the zeroing that exists for goto_ptr.  */
+        if (a0 == 0) {
+            tcg_out_call_int(s, s->code_gen_epilogue, true);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_A0, a0);
+            tcg_out_call_int(s, tb_ret_addr, true);
+        }
+        break;
+
+    case INDEX_op_goto_tb:
+        assert(s->tb_jmp_insn_offset == 0);
+        /* indirect jump method */
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, TCG_REG_ZERO,
+                   (uintptr_t)(s->tb_jmp_target_addr + a0));
+        tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, TCG_REG_TMP0, 0);
+        set_jmp_reset_offset(s, a0);
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
+            tcg_out_opc_imm(s, OPC_ADDIW, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_ADDW, a0, a1, a2);
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
+            tcg_out_opc_imm(s, OPC_ADDIW, a0, a1, -a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_SUBW, a0, a1, a2);
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
+        tcg_out_opc_reg(s, OPC_SUBW, a0, TCG_REG_ZERO, a1);
+        break;
+    case INDEX_op_neg_i64:
+        tcg_out_opc_reg(s, OPC_SUB, a0, TCG_REG_ZERO, a1);
+        break;
+
+    case INDEX_op_mul_i32:
+        tcg_out_opc_reg(s, OPC_MULW, a0, a1, a2);
+        break;
+    case INDEX_op_mul_i64:
+        tcg_out_opc_reg(s, OPC_MUL, a0, a1, a2);
+        break;
+
+    case INDEX_op_div_i32:
+        tcg_out_opc_reg(s, OPC_DIVW, a0, a1, a2);
+        break;
+    case INDEX_op_div_i64:
+        tcg_out_opc_reg(s, OPC_DIV, a0, a1, a2);
+        break;
+
+    case INDEX_op_divu_i32:
+        tcg_out_opc_reg(s, OPC_DIVUW, a0, a1, a2);
+        break;
+    case INDEX_op_divu_i64:
+        tcg_out_opc_reg(s, OPC_DIVU, a0, a1, a2);
+        break;
+
+    case INDEX_op_rem_i32:
+        tcg_out_opc_reg(s, OPC_REMW, a0, a1, a2);
+        break;
+    case INDEX_op_rem_i64:
+        tcg_out_opc_reg(s, OPC_REM, a0, a1, a2);
+        break;
+
+    case INDEX_op_remu_i32:
+        tcg_out_opc_reg(s, OPC_REMUW, a0, a1, a2);
+        break;
+    case INDEX_op_remu_i64:
+        tcg_out_opc_reg(s, OPC_REMU, a0, a1, a2);
+        break;
+
+    case INDEX_op_shl_i32:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_SLLIW, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_SLLW, a0, a1, a2);
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
+            tcg_out_opc_imm(s, OPC_SRLIW, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_SRLW, a0, a1, a2);
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
+            tcg_out_opc_imm(s, OPC_SRAIW, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_SRAW, a0, a1, a2);
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
+    case INDEX_op_add2_i32:
+        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
+                        const_args[4], const_args[5], false, true);
+        break;
+    case INDEX_op_add2_i64:
+        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
+                        const_args[4], const_args[5], false, false);
+        break;
+    case INDEX_op_sub2_i32:
+        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
+                        const_args[4], const_args[5], true, true);
+        break;
+    case INDEX_op_sub2_i64:
+        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
+                        const_args[4], const_args[5], true, false);
+        break;
+
+    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond_i64:
+        tcg_out_brcond(s, a2, a0, a1, arg_label(args[3]));
+        break;
+    case INDEX_op_brcond2_i32:
+        tcg_out_brcond2(s, args[4], a0, a1, a2, args[3], arg_label(args[5]));
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
+    case INDEX_op_extrl_i64_i32:
+    case INDEX_op_ext_i32_i64:
+        tcg_out_ext32s(s, a0, a1);
+        break;
+
+    case INDEX_op_extrh_i64_i32:
+        tcg_out_opc_imm(s, OPC_SRAI, a0, a1, 32);
+        break;
+
+    case INDEX_op_mulsh_i32:
+    case INDEX_op_mulsh_i64:
+        tcg_out_opc_reg(s, OPC_MULH, a0, a1, a2);
+        break;
+
+    case INDEX_op_muluh_i32:
+    case INDEX_op_muluh_i64:
+        tcg_out_opc_reg(s, OPC_MULHU, a0, a1, a2);
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
+        = { .args_ct_str = { "r" } };
+    static const TCGTargetOpDef r_r
+        = { .args_ct_str = { "r", "r" } };
+    static const TCGTargetOpDef rZ_r
+        = { .args_ct_str = { "rZ", "r" } };
+    static const TCGTargetOpDef rZ_rZ
+        = { .args_ct_str = { "rZ", "rZ" } };
+    static const TCGTargetOpDef rZ_rZ_rZ_rZ
+        = { .args_ct_str = { "rZ", "rZ", "rZ", "rZ" } };
+    static const TCGTargetOpDef r_r_ri
+        = { .args_ct_str = { "r", "r", "ri" } };
+    static const TCGTargetOpDef r_r_rI
+        = { .args_ct_str = { "r", "r", "rI" } };
+    static const TCGTargetOpDef r_rZ_rN
+        = { .args_ct_str = { "r", "rZ", "rN" } };
+    static const TCGTargetOpDef r_rZ_rZ
+        = { .args_ct_str = { "r", "rZ", "rZ" } };
+    static const TCGTargetOpDef r_rZ_rZ_rZ_rZ
+        = { .args_ct_str = { "r", "rZ", "rZ", "rZ", "rZ" } };
+    static const TCGTargetOpDef r_L
+        = { .args_ct_str = { "r", "L" } };
+    static const TCGTargetOpDef r_r_L
+        = { .args_ct_str = { "r", "r", "L" } };
+    static const TCGTargetOpDef r_L_L
+        = { .args_ct_str = { "r", "L", "L" } };
+    static const TCGTargetOpDef r_r_L_L
+        = { .args_ct_str = { "r", "r", "L", "L" } };
+    static const TCGTargetOpDef LZ_L
+        = { .args_ct_str = { "LZ", "L" } };
+    static const TCGTargetOpDef LZ_L_L
+        = { .args_ct_str = { "LZ", "L", "L" } };
+    static const TCGTargetOpDef LZ_LZ_L
+        = { .args_ct_str = { "LZ", "LZ", "L" } };
+    static const TCGTargetOpDef LZ_LZ_L_L
+        = { .args_ct_str = { "LZ", "LZ", "L", "L" } };
+    static const TCGTargetOpDef r_r_rZ_rZ_rM_rM
+        = { .args_ct_str = { "r", "r", "rZ", "rZ", "rM", "rM" } };
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
+    case INDEX_op_extrl_i64_i32:
+    case INDEX_op_extrh_i64_i32:
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
+    case INDEX_op_add2_i32:
+    case INDEX_op_add2_i64:
+    case INDEX_op_sub2_i32:
+    case INDEX_op_sub2_i64:
+        return &r_r_rZ_rZ_rM_rM;
+
+    case INDEX_op_brcond2_i32:
+        return &rZ_rZ_rZ_rZ;
+
+    case INDEX_op_setcond2_i32:
+        return &r_rZ_rZ_rZ_rZ;
+
+    case INDEX_op_qemu_ld_i32:
+        return TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &r_L : &r_L_L;
+    case INDEX_op_qemu_st_i32:
+        return TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &LZ_L : &LZ_L_L;
+    case INDEX_op_qemu_ld_i64:
+        return TCG_TARGET_REG_BITS == 64 ? &r_L
+               : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &r_r_L
+               : &r_r_L_L;
+    case INDEX_op_qemu_st_i64:
+        return TCG_TARGET_REG_BITS == 64 ? &LZ_L
+               : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &LZ_LZ_L
+               : &LZ_LZ_L_L;
+
+    default:
+        return NULL;
+    }
+}
-- 
2.17.2
