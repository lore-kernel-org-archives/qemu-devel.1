Received: from eggs.gnu.org ([208.118.235.92]:50078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtlv-0005jb-AX
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtlr-0008FN-Do
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:51 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtln-0008Bm-Mn
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:45 -0500
Received: by mail-pg1-x541.google.com with SMTP id d72so6807362pga.9
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:57:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:03 +1100
Message-Id: <20181225205529.10874-17-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 16/42] tcg/riscv: Add slowpath load and store
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
Message-Id: <1a0a7e8f3347764f212c5efa5c07c9be17efdec6.1545246859.git.alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.inc.c | 256 +++++++++++++++++++++++++++++++++++++
 1 file changed, 256 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index ecc76c9ef8..7216bad086 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -895,3 +895,259 @@ static void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
 {
     tcg_out_call_int(s, arg, false);
 }
+
+static void tcg_out_mb(TCGContext *s, TCGArg a0)
+{
+    tcg_insn_unit insn = OPC_FENCE;
+
+    if (a0 & TCG_MO_LD_LD) {
+        insn |= 0x02200000;
+    }
+    if (a0 & TCG_MO_ST_LD) {
+        insn |= 0x01200000;
+    }
+    if (a0 & TCG_MO_LD_ST) {
+        insn |= 0x02100000;
+    }
+    if (a0 & TCG_MO_ST_ST) {
+        insn |= 0x02200000;
+    }
+    tcg_out32(s, insn);
+}
+
+/*
+ * Load/store and TLB
+ */
+
+#if defined(CONFIG_SOFTMMU)
+#include "tcg-ldst.inc.c"
+
+/* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
+ *                                     TCGMemOpIdx oi, uintptr_t ra)
+ */
+static void * const qemu_ld_helpers[16] = {
+    [MO_UB]   = helper_ret_ldub_mmu,
+    [MO_SB]   = helper_ret_ldsb_mmu,
+    [MO_LEUW] = helper_le_lduw_mmu,
+    [MO_LESW] = helper_le_ldsw_mmu,
+    [MO_LEUL] = helper_le_ldul_mmu,
+#if TCG_TARGET_REG_BITS == 64
+    [MO_LESL] = helper_le_ldsl_mmu,
+#endif
+    [MO_LEQ]  = helper_le_ldq_mmu,
+    [MO_BEUW] = helper_be_lduw_mmu,
+    [MO_BESW] = helper_be_ldsw_mmu,
+    [MO_BEUL] = helper_be_ldul_mmu,
+#if TCG_TARGET_REG_BITS == 64
+    [MO_BESL] = helper_be_ldsl_mmu,
+#endif
+    [MO_BEQ]  = helper_be_ldq_mmu,
+};
+
+/* helper signature: helper_ret_st_mmu(CPUState *env, target_ulong addr,
+ *                                     uintxx_t val, TCGMemOpIdx oi,
+ *                                     uintptr_t ra)
+ */
+static void * const qemu_st_helpers[16] = {
+    [MO_UB]   = helper_ret_stb_mmu,
+    [MO_LEUW] = helper_le_stw_mmu,
+    [MO_LEUL] = helper_le_stl_mmu,
+    [MO_LEQ]  = helper_le_stq_mmu,
+    [MO_BEUW] = helper_be_stw_mmu,
+    [MO_BEUL] = helper_be_stl_mmu,
+    [MO_BEQ]  = helper_be_stq_mmu,
+};
+
+static void tcg_out_tlb_load(TCGContext *s, TCGReg addrl,
+                             TCGReg addrh, TCGMemOpIdx oi,
+                             tcg_insn_unit **label_ptr, bool is_load)
+{
+    TCGMemOp opc = get_memop(oi);
+    unsigned s_bits = opc & MO_SIZE;
+    unsigned a_bits = get_alignment_bits(opc);
+    target_ulong mask;
+    int mem_index = get_mmuidx(oi);
+    int cmp_off
+        = (is_load
+           ? offsetof(CPUArchState, tlb_table[mem_index][0].addr_read)
+           : offsetof(CPUArchState, tlb_table[mem_index][0].addr_write));
+    int add_off = offsetof(CPUArchState, tlb_table[mem_index][0].addend);
+    RISCVInsn load_cmp_op = (TARGET_LONG_BITS == 64 ? OPC_LD :
+                             TCG_TARGET_REG_BITS == 64 ? OPC_LWU : OPC_LW);
+    RISCVInsn load_add_op = TCG_TARGET_REG_BITS == 64 ? OPC_LD : OPC_LW;
+    TCGReg base = TCG_AREG0;
+
+    /* We don't support oversize guests */
+    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
+        g_assert_not_reached();
+    }
+
+    /* We don't support unaligned accesses. */
+    if (a_bits < s_bits) {
+        a_bits = s_bits;
+    }
+    mask = (target_ulong)TARGET_PAGE_MASK | ((1 << a_bits) - 1);
+
+
+    /* Compensate for very large offsets.  */
+    if (add_off >= 0x1000) {
+        int adj;
+        base = TCG_REG_TMP2;
+        if (cmp_off <= 2 * 0xfff) {
+            adj = 0xfff;
+            tcg_out_opc_imm(s, OPC_ADDI, base, TCG_AREG0, adj);
+        } else {
+            adj = cmp_off - sextreg(cmp_off, 0, 12);
+            tcg_debug_assert(add_off - adj >= -0x1000
+                             && add_off - adj < 0x1000);
+
+            tcg_out_opc_upper(s, OPC_LUI, base, adj);
+            tcg_out_opc_reg(s, OPC_ADD, base, base, TCG_AREG0);
+        }
+        add_off -= adj;
+        cmp_off -= adj;
+    }
+
+    /* Extract the page index.  */
+    if (CPU_TLB_BITS + CPU_TLB_ENTRY_BITS < 12) {
+        tcg_out_opc_imm(s, OPC_SRLI, TCG_REG_TMP0, addrl,
+                        TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+        tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP0, TCG_REG_TMP0,
+                        MAKE_64BIT_MASK(CPU_TLB_ENTRY_BITS, CPU_TLB_BITS));
+    } else if (TARGET_PAGE_BITS >= 12) {
+        tcg_out_opc_upper(s, OPC_LUI, TCG_REG_TMP0,
+                          MAKE_64BIT_MASK(TARGET_PAGE_BITS, CPU_TLB_BITS));
+        tcg_out_opc_reg(s, OPC_AND, TCG_REG_TMP0, TCG_REG_TMP0, addrl);
+        tcg_out_opc_imm(s, OPC_SRLI, TCG_REG_TMP0, TCG_REG_TMP0,
+                        CPU_TLB_BITS - CPU_TLB_ENTRY_BITS);
+    } else {
+        tcg_out_opc_imm(s, OPC_SRLI, TCG_REG_TMP0, addrl, TARGET_PAGE_BITS);
+        tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP0, TCG_REG_TMP0,
+                        MAKE_64BIT_MASK(0, CPU_TLB_BITS));
+        tcg_out_opc_imm(s, OPC_SLLI, TCG_REG_TMP0, TCG_REG_TMP0,
+                        CPU_TLB_ENTRY_BITS);
+    }
+
+    /* Add that to the base address to index the tlb.  */
+    tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP2, base, TCG_REG_TMP0);
+    base = TCG_REG_TMP2;
+
+    /* Load the tlb comparator and the addend.  */
+    tcg_out_ldst(s, load_cmp_op, TCG_REG_TMP0, base, cmp_off);
+    tcg_out_ldst(s, load_add_op, TCG_REG_TMP2, base, add_off);
+
+    /* Clear the non-page, non-alignment bits from the address.  */
+    if (mask == sextreg(mask, 0, 12)) {
+        tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP1, addrl, mask);
+    } else {
+        tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_TMP1, mask);
+        tcg_out_opc_reg(s, OPC_AND, TCG_REG_TMP1, TCG_REG_TMP1, addrl);
+     }
+
+    /* Compare masked address with the TLB entry. */
+    label_ptr[0] = s->code_ptr;
+    tcg_out_opc_branch(s, OPC_BNE, TCG_REG_TMP0, TCG_REG_TMP1, 0);
+    /* NOP to allow patching later */
+    tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_ZERO, TCG_REG_ZERO, 0);
+    /* TODO: Move this out of line
+     * see:
+     *   https://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg02234.html
+     */
+
+    /* TLB Hit - translate address using addend.  */
+    if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
+        tcg_out_ext32u(s, TCG_REG_TMP0, addrl);
+        addrl = TCG_REG_TMP0;
+    }
+    tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, TCG_REG_TMP2, addrl);
+}
+
+static void add_qemu_ldst_label(TCGContext *s, int is_ld, TCGMemOpIdx oi,
+                                TCGType ext,
+                                TCGReg datalo, TCGReg datahi,
+                                TCGReg addrlo, TCGReg addrhi,
+                                void *raddr, tcg_insn_unit **label_ptr)
+{
+    TCGLabelQemuLdst *label = new_ldst_label(s);
+
+    label->is_ld = is_ld;
+    label->oi = oi;
+    label->type = ext;
+    label->datalo_reg = datalo;
+    label->datahi_reg = datahi;
+    label->addrlo_reg = addrlo;
+    label->addrhi_reg = addrhi;
+    label->raddr = raddr;
+    label->label_ptr[0] = label_ptr[0];
+}
+
+static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+{
+    TCGMemOpIdx oi = l->oi;
+    TCGMemOp opc = get_memop(oi);
+    TCGReg a0 = tcg_target_call_iarg_regs[0];
+    TCGReg a1 = tcg_target_call_iarg_regs[1];
+    TCGReg a2 = tcg_target_call_iarg_regs[2];
+    TCGReg a3 = tcg_target_call_iarg_regs[3];
+
+    /* We don't support oversize guests */
+    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
+        g_assert_not_reached();
+    }
+
+    /* resolve label address */
+    patch_reloc(l->label_ptr[0], R_RISCV_BRANCH, (intptr_t) s->code_ptr, 0);
+
+    /* call load helper */
+    tcg_out_mov(s, TCG_TYPE_PTR, a0, TCG_AREG0);
+    tcg_out_mov(s, TCG_TYPE_PTR, a1, l->addrlo_reg);
+    tcg_out_movi(s, TCG_TYPE_PTR, a2, oi);
+    tcg_out_movi(s, TCG_TYPE_PTR, a3, (tcg_target_long)l->raddr);
+
+    tcg_out_call(s, qemu_ld_helpers[opc & (MO_BSWAP | MO_SSIZE)]);
+    tcg_out_mov(s, (opc & MO_SIZE) == MO_64, l->datalo_reg, a0);
+
+    tcg_out_goto(s, l->raddr);
+}
+
+static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+{
+    TCGMemOpIdx oi = l->oi;
+    TCGMemOp opc = get_memop(oi);
+    TCGMemOp s_bits = opc & MO_SIZE;
+    TCGReg a0 = tcg_target_call_iarg_regs[0];
+    TCGReg a1 = tcg_target_call_iarg_regs[1];
+    TCGReg a2 = tcg_target_call_iarg_regs[2];
+    TCGReg a3 = tcg_target_call_iarg_regs[3];
+    TCGReg a4 = tcg_target_call_iarg_regs[4];
+
+    /* We don't support oversize guests */
+    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
+        g_assert_not_reached();
+    }
+
+    /* resolve label address */
+    patch_reloc(l->label_ptr[0], R_RISCV_BRANCH, (intptr_t) s->code_ptr, 0);
+
+    /* call store helper */
+    tcg_out_mov(s, TCG_TYPE_PTR, a0, TCG_AREG0);
+    tcg_out_mov(s, TCG_TYPE_PTR, a1, l->addrlo_reg);
+    tcg_out_mov(s, TCG_TYPE_PTR, a2, l->datalo_reg);
+    switch (s_bits) {
+    case MO_8:
+        tcg_out_ext8u(s, a2, a2);
+        break;
+    case MO_16:
+        tcg_out_ext16u(s, a2, a2);
+        break;
+    default:
+        break;
+    }
+    tcg_out_movi(s, TCG_TYPE_PTR, a3, oi);
+    tcg_out_movi(s, TCG_TYPE_PTR, a4, (tcg_target_long)l->raddr);
+
+    tcg_out_call(s, qemu_st_helpers[opc & (MO_BSWAP | MO_SSIZE)]);
+
+    tcg_out_goto(s, l->raddr);
+}
+#endif /* CONFIG_SOFTMMU */
-- 
2.17.2
