Received: from eggs.gnu.org ([2001:4830:134:3::10]:54243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK3K-0003zA-Lv
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK3I-000531-Rp
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:26 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMK3G-00050p-JS
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:23 -0500
Received: by mail-wr1-x441.google.com with SMTP id u9-v6so11033081wrr.0
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:47:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 12 Nov 2018 22:44:58 +0100
Message-Id: <20181112214503.22941-13-richard.henderson@linaro.org>
In-Reply-To: <20181112214503.22941-1-richard.henderson@linaro.org>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 12/17] tcg/aarch64: Use
 TCG_TARGET_NEED_LDST_OOL_LABELS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     |   2 +-
 tcg/aarch64/tcg-target.inc.c | 191 +++++++++++++++++------------------
 2 files changed, 93 insertions(+), 100 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 9aea1d1771..d1bd77c41d 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -146,7 +146,7 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
 
 #ifdef CONFIG_SOFTMMU
-#define TCG_TARGET_NEED_LDST_LABELS
+#define TCG_TARGET_NEED_LDST_OOL_LABELS
 #endif
 #define TCG_TARGET_NEED_POOL_LABELS
 
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 403f5caf14..8edea527f7 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -145,18 +145,6 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         ct->ct |= TCG_CT_REG;
         ct->u.regs |= 0xffffffff00000000ull;
         break;
-    case 'l': /* qemu_ld / qemu_st address, data_reg */
-        ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffffffffu;
-#ifdef CONFIG_SOFTMMU
-        /* x0 and x1 will be overwritten when reading the tlb entry,
-           and x2, and x3 for helper args, better to avoid using them. */
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_X0);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_X1);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_X2);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_X3);
-#endif
-        break;
     case 'A': /* Valid for arithmetic immediate (positive or negative).  */
         ct->ct |= TCG_CT_CONST_AIMM;
         break;
@@ -1378,7 +1366,7 @@ static void tcg_out_cltz(TCGContext *s, TCGType ext, TCGReg d,
 }
 
 #ifdef CONFIG_SOFTMMU
-#include "tcg-ldst.inc.c"
+#include "tcg-ldst-ool.inc.c"
 
 /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
  *                                     TCGMemOpIdx oi, uintptr_t ra)
@@ -1391,6 +1379,12 @@ static void * const qemu_ld_helpers[16] = {
     [MO_BEUW] = helper_be_lduw_mmu,
     [MO_BEUL] = helper_be_ldul_mmu,
     [MO_BEQ]  = helper_be_ldq_mmu,
+
+    [MO_SB]   = helper_ret_ldsb_mmu,
+    [MO_LESW] = helper_le_ldsw_mmu,
+    [MO_LESL] = helper_le_ldsl_mmu,
+    [MO_BESW] = helper_be_ldsw_mmu,
+    [MO_BESL] = helper_be_ldsl_mmu,
 };
 
 /* helper signature: helper_ret_st_mmu(CPUState *env, target_ulong addr,
@@ -1407,67 +1401,6 @@ static void * const qemu_st_helpers[16] = {
     [MO_BEQ]  = helper_be_stq_mmu,
 };
 
-static inline void tcg_out_adr(TCGContext *s, TCGReg rd, void *target)
-{
-    ptrdiff_t offset = tcg_pcrel_diff(s, target);
-    tcg_debug_assert(offset == sextract64(offset, 0, 21));
-    tcg_out_insn(s, 3406, ADR, rd, offset);
-}
-
-static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
-{
-    TCGMemOpIdx oi = lb->oi;
-    TCGMemOp opc = get_memop(oi);
-    TCGMemOp size = opc & MO_SIZE;
-
-    reloc_pc19(lb->label_ptr[0], s->code_ptr);
-
-    tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_X0, TCG_AREG0);
-    tcg_out_mov(s, TARGET_LONG_BITS == 64, TCG_REG_X1, lb->addrlo_reg);
-    tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_X2, oi);
-    tcg_out_adr(s, TCG_REG_X3, lb->raddr);
-    tcg_out_call(s, qemu_ld_helpers[opc & (MO_BSWAP | MO_SIZE)]);
-    if (opc & MO_SIGN) {
-        tcg_out_sxt(s, lb->type, size, lb->datalo_reg, TCG_REG_X0);
-    } else {
-        tcg_out_mov(s, size == MO_64, lb->datalo_reg, TCG_REG_X0);
-    }
-
-    tcg_out_goto(s, lb->raddr);
-}
-
-static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
-{
-    TCGMemOpIdx oi = lb->oi;
-    TCGMemOp opc = get_memop(oi);
-    TCGMemOp size = opc & MO_SIZE;
-
-    reloc_pc19(lb->label_ptr[0], s->code_ptr);
-
-    tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_X0, TCG_AREG0);
-    tcg_out_mov(s, TARGET_LONG_BITS == 64, TCG_REG_X1, lb->addrlo_reg);
-    tcg_out_mov(s, size == MO_64, TCG_REG_X2, lb->datalo_reg);
-    tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_X3, oi);
-    tcg_out_adr(s, TCG_REG_X4, lb->raddr);
-    tcg_out_call(s, qemu_st_helpers[opc & (MO_BSWAP | MO_SIZE)]);
-    tcg_out_goto(s, lb->raddr);
-}
-
-static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
-                                TCGType ext, TCGReg data_reg, TCGReg addr_reg,
-                                tcg_insn_unit *raddr, tcg_insn_unit *label_ptr)
-{
-    TCGLabelQemuLdst *label = new_ldst_label(s);
-
-    label->is_ld = is_ld;
-    label->oi = oi;
-    label->type = ext;
-    label->datalo_reg = data_reg;
-    label->addrlo_reg = addr_reg;
-    label->raddr = raddr;
-    label->label_ptr[0] = label_ptr;
-}
-
 /*
  * Load and compare a TLB entry, emitting the conditional jump to the
  * slow path on failure.  Returns the register for the host addend.
@@ -1644,19 +1577,22 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
                             TCGMemOpIdx oi, TCGType ext)
 {
     TCGMemOp memop = get_memop(oi);
-    const TCGType otype = TARGET_LONG_BITS == 64 ? TCG_TYPE_I64 : TCG_TYPE_I32;
-#ifdef CONFIG_SOFTMMU
-    unsigned mem_index = get_mmuidx(oi);
-    tcg_insn_unit *label_ptr;
-    TCGReg base;
 
-    base = tcg_out_tlb_read(s, addr_reg, memop, &label_ptr, mem_index, 1,
-                            TCG_REG_X0, TCG_REG_X1, TCG_REG_X2, TCG_REG_X3);
-    tcg_out_qemu_ld_direct(s, memop, ext, data_reg,
-                           base, otype, addr_reg);
-    add_qemu_ldst_label(s, true, oi, ext, data_reg, addr_reg,
-                        s->code_ptr, label_ptr);
+#ifdef CONFIG_SOFTMMU
+    /* Ignore the requested "ext".  We get the same correct result from
+     * a 16-bit sign-extended to 64-bit as we do sign-extended to 32-bit,
+     * and we create fewer out-of-line thunks.
+     */
+    bool is_64 = (memop & MO_SIGN) || ((memop & MO_SIZE) == MO_64);
+
+    tcg_debug_assert(data_reg == TCG_REG_X0);
+    tcg_debug_assert(addr_reg == TCG_REG_X1);
+
+    add_ldst_ool_label(s, true, is_64, oi, R_AARCH64_JUMP26, 0);
+    tcg_out_insn(s, 3206, BL, 0);
 #else /* !CONFIG_SOFTMMU */
+    const TCGType otype = TARGET_LONG_BITS == 64 ? TCG_TYPE_I64 : TCG_TYPE_I32;
+
     if (USE_GUEST_BASE) {
         tcg_out_qemu_ld_direct(s, memop, ext, data_reg,
                                TCG_REG_GUEST_BASE, otype, addr_reg);
@@ -1671,18 +1607,18 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
                             TCGMemOpIdx oi)
 {
     TCGMemOp memop = get_memop(oi);
-    const TCGType otype = TARGET_LONG_BITS == 64 ? TCG_TYPE_I64 : TCG_TYPE_I32;
-#ifdef CONFIG_SOFTMMU
-    unsigned mem_index = get_mmuidx(oi);
-    tcg_insn_unit *label_ptr;
-    TCGReg base;
 
-    base = tcg_out_tlb_read(s, addr_reg, memop, &label_ptr, mem_index, 0,
-                            TCG_REG_X0, TCG_REG_X1, TCG_REG_X2, TCG_REG_X3);
-    tcg_out_qemu_st_direct(s, memop, data_reg, base, otype, addr_reg);
-    add_qemu_ldst_label(s, false, oi, (memop & MO_SIZE)== MO_64,
-                        data_reg, addr_reg, s->code_ptr, label_ptr);
+#ifdef CONFIG_SOFTMMU
+    bool is_64 = (memop & MO_SIZE) == MO_64;
+
+    tcg_debug_assert(addr_reg == TCG_REG_X1);
+    tcg_debug_assert(data_reg == TCG_REG_X2);
+
+    add_ldst_ool_label(s, false, is_64, oi, R_AARCH64_JUMP26, 0);
+    tcg_out_insn(s, 3206, BL, 0);
 #else /* !CONFIG_SOFTMMU */
+    const TCGType otype = TARGET_LONG_BITS == 64 ? TCG_TYPE_I64 : TCG_TYPE_I32;
+
     if (USE_GUEST_BASE) {
         tcg_out_qemu_st_direct(s, memop, data_reg,
                                TCG_REG_GUEST_BASE, otype, addr_reg);
@@ -1693,6 +1629,52 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
 #endif /* CONFIG_SOFTMMU */
 }
 
+#ifdef CONFIG_SOFTMMU
+static tcg_insn_unit *tcg_out_qemu_ldst_ool(TCGContext *s, bool is_ld,
+                                            bool is_64, TCGMemOpIdx oi)
+{
+    const TCGType otype = TARGET_LONG_BITS == 64 ? TCG_TYPE_I64 : TCG_TYPE_I32;
+    const TCGMemOp memop = get_memop(oi);
+    const unsigned mem_index = get_mmuidx(oi);
+    const TCGReg addr_reg = TCG_REG_X1;
+    const TCGReg data_reg = is_ld ? TCG_REG_X0 : TCG_REG_X2;
+    tcg_insn_unit * const thunk = s->code_ptr;
+    tcg_insn_unit *label;
+    TCGReg base, arg;
+
+    base = tcg_out_tlb_read(s, addr_reg, memop, &label, mem_index, is_ld,
+                            TCG_REG_X4, TCG_REG_X5, TCG_REG_X6, TCG_REG_X7);
+
+    /* TLB Hit */
+    if (is_ld) {
+        tcg_out_qemu_ld_direct(s, memop, is_64, data_reg,
+                               base, otype, addr_reg);
+    } else {
+        tcg_out_qemu_st_direct(s, memop, data_reg, base, otype, addr_reg);
+    }
+    tcg_out_insn(s, 3207, RET, TCG_REG_LR);
+
+    /* TLB Miss */
+    reloc_pc19(label, s->code_ptr);
+
+    tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_X0, TCG_AREG0);
+    /* addr_reg and data_reg are already in place.  */
+    arg = is_ld ? TCG_REG_X2 : TCG_REG_X3;
+    tcg_out_movi(s, TCG_TYPE_I32, arg++, oi);
+    tcg_out_mov(s, TCG_TYPE_PTR, arg++, TCG_REG_LR);
+
+    if (is_ld) {
+        tcg_out_goto_long(s, qemu_ld_helpers[memop & (MO_BSWAP | MO_SSIZE)],
+                          TCG_REG_X7);
+    } else {
+        tcg_out_goto_long(s, qemu_st_helpers[memop & (MO_BSWAP | MO_SIZE)],
+                          TCG_REG_X7);
+    }
+
+    return thunk;
+}
+#endif
+
 static tcg_insn_unit *tb_ret_addr;
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc,
@@ -2262,10 +2244,12 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef w_w = { .args_ct_str = { "w", "w" } };
     static const TCGTargetOpDef w_r = { .args_ct_str = { "w", "r" } };
     static const TCGTargetOpDef w_wr = { .args_ct_str = { "w", "wr" } };
-    static const TCGTargetOpDef r_l = { .args_ct_str = { "r", "l" } };
     static const TCGTargetOpDef r_rA = { .args_ct_str = { "r", "rA" } };
     static const TCGTargetOpDef rZ_r = { .args_ct_str = { "rZ", "r" } };
-    static const TCGTargetOpDef lZ_l = { .args_ct_str = { "lZ", "l" } };
+#ifdef CONFIG_SOFTMMU
+    static const TCGTargetOpDef a_b = { .args_ct_str = { "a", "b" } };
+    static const TCGTargetOpDef c_b = { .args_ct_str = { "c", "b" } };
+#endif
     static const TCGTargetOpDef r_r_r = { .args_ct_str = { "r", "r", "r" } };
     static const TCGTargetOpDef w_w_w = { .args_ct_str = { "w", "w", "w" } };
     static const TCGTargetOpDef w_w_wZ = { .args_ct_str = { "w", "w", "wZ" } };
@@ -2397,10 +2381,19 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
-        return &r_l;
+#ifdef CONFIG_SOFTMMU
+        return &a_b;
+#else
+        return &r_r;
+#endif
+
     case INDEX_op_qemu_st_i32:
     case INDEX_op_qemu_st_i64:
-        return &lZ_l;
+#ifdef CONFIG_SOFTMMU
+        return &c_b;
+#else
+        return &r_r;
+#endif
 
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
-- 
2.17.2
