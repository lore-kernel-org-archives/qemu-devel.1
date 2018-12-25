Received: from eggs.gnu.org ([208.118.235.92]:50023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtli-0005Qs-4x
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtlf-00085P-0K
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:38 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:40552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtle-00084n-Qe
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:34 -0500
Received: by mail-pl1-x630.google.com with SMTP id u18so6802425plq.7
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:57:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:02 +1100
Message-Id: <20181225205529.10874-16-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 15/42] tcg/riscv: Add branch and jump
 instructions
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
Message-Id: <c356657e627168d89cb5b012b7e21e4efbbe83f3.1545246859.git.alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.inc.c | 145 +++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 5da850b957..ecc76c9ef8 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -750,3 +750,148 @@ static void tcg_out_addsub2(TCGContext *s,
         tcg_out_opc_reg(s, opc_add, rh, th, TCG_REG_TMP0);
     }
 }
+
+static const struct {
+    RISCVInsn op;
+    bool swap;
+} tcg_brcond_to_riscv[] = {
+    [TCG_COND_EQ] =  { OPC_BEQ,  false },
+    [TCG_COND_NE] =  { OPC_BNE,  false },
+    [TCG_COND_LT] =  { OPC_BLT,  false },
+    [TCG_COND_GE] =  { OPC_BGE,  false },
+    [TCG_COND_LE] =  { OPC_BGE,  true  },
+    [TCG_COND_GT] =  { OPC_BLT,  true  },
+    [TCG_COND_LTU] = { OPC_BLTU, false },
+    [TCG_COND_GEU] = { OPC_BGEU, false },
+    [TCG_COND_LEU] = { OPC_BGEU, true  },
+    [TCG_COND_GTU] = { OPC_BLTU, true  }
+};
+
+static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
+                           TCGReg arg2, TCGLabel *l)
+{
+    RISCVInsn op = tcg_brcond_to_riscv[cond].op;
+
+    tcg_debug_assert(op != 0);
+
+    if (tcg_brcond_to_riscv[cond].swap) {
+        TCGReg t = arg1;
+        arg1 = arg2;
+        arg2 = t;
+    }
+
+    if (l->has_value) {
+        intptr_t diff = tcg_pcrel_diff(s, l->u.value_ptr);
+        if (diff == sextreg(diff, 0, 12)) {
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
+static void tcg_out_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
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
+    ptrdiff_t offset = tcg_pcrel_diff(s, target);
+    tcg_debug_assert(offset == sextreg(offset, 1, 20) << 1);
+    tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, offset);
+}
+
+static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
+{
+    TCGReg link = tail ? TCG_REG_ZERO : TCG_REG_RA;
+    ptrdiff_t offset = tcg_pcrel_diff(s, arg);
+    int ret;
+
+    if (offset == sextreg(offset, 1, 20) << 1) {
+        /* short jump: -2097150 to 2097152 */
+        tcg_out_opc_jump(s, OPC_JAL, link, offset);
+    } else if (TCG_TARGET_REG_BITS == 32 ||
+        offset == sextreg(offset, 1, 31) << 1) {
+        /* long jump: -2147483646 to 2147483648 */
+        tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, 0);
+        tcg_out_opc_imm(s, OPC_JALR, link, TCG_REG_TMP0, 0);
+        ret = reloc_call(s->code_ptr - 2, arg);\
+        tcg_debug_assert(ret == true);
+    } else if (TCG_TARGET_REG_BITS == 64) {
+        /* far jump: 64-bit */
+        tcg_target_long imm = sextreg((tcg_target_long)arg, 0, 12);
+        tcg_target_long base = (tcg_target_long)arg - imm;
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
-- 
2.17.2
