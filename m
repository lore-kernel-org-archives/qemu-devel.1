Received: from eggs.gnu.org ([2001:4830:134:3::10]:54372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK3g-0005O7-76
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK3V-00059J-2h
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:42 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMK3M-00054c-9L
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:30 -0500
Received: by mail-wr1-x441.google.com with SMTP id j26-v6so11019398wre.1
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:47:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 12 Nov 2018 22:45:03 +0100
Message-Id: <20181112214503.22941-18-richard.henderson@linaro.org>
In-Reply-To: <20181112214503.22941-1-richard.henderson@linaro.org>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 17/17] tcg/arm: Use
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
 tcg/arm/tcg-target.h     |   2 +-
 tcg/arm/tcg-target.inc.c | 302 +++++++++++++++------------------------
 2 files changed, 118 insertions(+), 186 deletions(-)

diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 94b3578c55..02981abdcc 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -141,7 +141,7 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
 
 #ifdef CONFIG_SOFTMMU
-#define TCG_TARGET_NEED_LDST_LABELS
+#define TCG_TARGET_NEED_LDST_OOL_LABELS
 #endif
 #define TCG_TARGET_NEED_POOL_LABELS
 
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 75589b43e2..1e9ff693d9 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1134,7 +1134,7 @@ static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
 }
 
 #ifdef CONFIG_SOFTMMU
-#include "tcg-ldst.inc.c"
+#include "tcg-ldst-ool.inc.c"
 
 /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
  *                                     int mmu_idx, uintptr_t ra)
@@ -1358,127 +1358,6 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
     return t2;
 }
 
-/* Record the context of a call to the out of line helper code for the slow
-   path for a load or store, so that we can later generate the correct
-   helper code.  */
-static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
-                                TCGReg datalo, TCGReg datahi, TCGReg addrlo,
-                                TCGReg addrhi, tcg_insn_unit *raddr,
-                                tcg_insn_unit *label_ptr)
-{
-    TCGLabelQemuLdst *label = new_ldst_label(s);
-
-    label->is_ld = is_ld;
-    label->oi = oi;
-    label->datalo_reg = datalo;
-    label->datahi_reg = datahi;
-    label->addrlo_reg = addrlo;
-    label->addrhi_reg = addrhi;
-    label->raddr = raddr;
-    label->label_ptr[0] = label_ptr;
-}
-
-static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
-{
-    TCGReg argreg, datalo, datahi;
-    TCGMemOpIdx oi = lb->oi;
-    TCGMemOp opc = get_memop(oi);
-    void *func;
-
-    reloc_pc24(lb->label_ptr[0], s->code_ptr);
-
-    argreg = tcg_out_arg_reg32(s, TCG_REG_R0, TCG_AREG0);
-    if (TARGET_LONG_BITS == 64) {
-        argreg = tcg_out_arg_reg64(s, argreg, lb->addrlo_reg, lb->addrhi_reg);
-    } else {
-        argreg = tcg_out_arg_reg32(s, argreg, lb->addrlo_reg);
-    }
-    argreg = tcg_out_arg_imm32(s, argreg, oi);
-    argreg = tcg_out_arg_reg32(s, argreg, TCG_REG_R14);
-
-    /* For armv6 we can use the canonical unsigned helpers and minimize
-       icache usage.  For pre-armv6, use the signed helpers since we do
-       not have a single insn sign-extend.  */
-    if (use_armv6_instructions) {
-        func = qemu_ld_helpers[opc & (MO_BSWAP | MO_SIZE)];
-    } else {
-        func = qemu_ld_helpers[opc & (MO_BSWAP | MO_SSIZE)];
-        if (opc & MO_SIGN) {
-            opc = MO_UL;
-        }
-    }
-    tcg_out_call(s, func);
-
-    datalo = lb->datalo_reg;
-    datahi = lb->datahi_reg;
-    switch (opc & MO_SSIZE) {
-    case MO_SB:
-        tcg_out_ext8s(s, COND_AL, datalo, TCG_REG_R0);
-        break;
-    case MO_SW:
-        tcg_out_ext16s(s, COND_AL, datalo, TCG_REG_R0);
-        break;
-    default:
-        tcg_out_mov_reg(s, COND_AL, datalo, TCG_REG_R0);
-        break;
-    case MO_Q:
-        if (datalo != TCG_REG_R1) {
-            tcg_out_mov_reg(s, COND_AL, datalo, TCG_REG_R0);
-            tcg_out_mov_reg(s, COND_AL, datahi, TCG_REG_R1);
-        } else if (datahi != TCG_REG_R0) {
-            tcg_out_mov_reg(s, COND_AL, datahi, TCG_REG_R1);
-            tcg_out_mov_reg(s, COND_AL, datalo, TCG_REG_R0);
-        } else {
-            tcg_out_mov_reg(s, COND_AL, TCG_REG_TMP, TCG_REG_R0);
-            tcg_out_mov_reg(s, COND_AL, datahi, TCG_REG_R1);
-            tcg_out_mov_reg(s, COND_AL, datalo, TCG_REG_TMP);
-        }
-        break;
-    }
-
-    tcg_out_goto(s, COND_AL, lb->raddr);
-}
-
-static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
-{
-    TCGReg argreg, datalo, datahi;
-    TCGMemOpIdx oi = lb->oi;
-    TCGMemOp opc = get_memop(oi);
-
-    reloc_pc24(lb->label_ptr[0], s->code_ptr);
-
-    argreg = TCG_REG_R0;
-    argreg = tcg_out_arg_reg32(s, argreg, TCG_AREG0);
-    if (TARGET_LONG_BITS == 64) {
-        argreg = tcg_out_arg_reg64(s, argreg, lb->addrlo_reg, lb->addrhi_reg);
-    } else {
-        argreg = tcg_out_arg_reg32(s, argreg, lb->addrlo_reg);
-    }
-
-    datalo = lb->datalo_reg;
-    datahi = lb->datahi_reg;
-    switch (opc & MO_SIZE) {
-    case MO_8:
-        argreg = tcg_out_arg_reg8(s, argreg, datalo);
-        break;
-    case MO_16:
-        argreg = tcg_out_arg_reg16(s, argreg, datalo);
-        break;
-    case MO_32:
-    default:
-        argreg = tcg_out_arg_reg32(s, argreg, datalo);
-        break;
-    case MO_64:
-        argreg = tcg_out_arg_reg64(s, argreg, datalo, datahi);
-        break;
-    }
-
-    argreg = tcg_out_arg_imm32(s, argreg, oi);
-    argreg = tcg_out_arg_reg32(s, argreg, TCG_REG_R14);
-
-    /* Tail-call to the helper, which will return to the fast path.  */
-    tcg_out_goto(s, COND_AL, qemu_st_helpers[opc & (MO_BSWAP | MO_SIZE)]);
-}
 #endif /* SOFTMMU */
 
 static inline void tcg_out_qemu_ld_index(TCGContext *s, TCGMemOp opc,
@@ -1603,54 +1482,28 @@ static inline void tcg_out_qemu_ld_direct(TCGContext *s, TCGMemOp opc,
 
 static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
 {
-    TCGReg addrlo, datalo, datahi, addrhi __attribute__((unused));
+    TCGReg addrlo __attribute__((unused));
+    TCGReg addrhi __attribute__((unused));
+    TCGReg datalo __attribute__((unused));
+    TCGReg datahi __attribute__((unused));
     TCGMemOpIdx oi;
-    TCGMemOp opc;
-#ifdef CONFIG_SOFTMMU
-    int mem_index, avail;
-    TCGReg addend, t0, t1;
-    tcg_insn_unit *label_ptr;
-#endif
 
     datalo = *args++;
     datahi = (is64 ? *args++ : 0);
     addrlo = *args++;
     addrhi = (TARGET_LONG_BITS == 64 ? *args++ : 0);
     oi = *args++;
-    opc = get_memop(oi);
 
 #ifdef CONFIG_SOFTMMU
-    mem_index = get_mmuidx(oi);
-
-    avail = 0xf;
-    avail &= ~(1 << addrlo);
-    if (TARGET_LONG_BITS == 64) {
-        avail &= ~(1 << addrhi);
-    }
-    tcg_debug_assert(avail & 1);
-    t0 = TCG_REG_R0;
-    avail &= ~1;
-    tcg_debug_assert(avail != 0);
-    t1 = ctz32(avail);
-
-    addend = tcg_out_tlb_read(s, addrlo, addrhi, opc, mem_index, 1,
-                              t0, t1, TCG_REG_TMP);
-
-    /* This a conditional BL only to load a pointer within this opcode into LR
-       for the slow path.  We will not be using the value for a tail call.  */
-    label_ptr = s->code_ptr;
-    tcg_out_bl_noaddr(s, COND_NE);
-
-    tcg_out_qemu_ld_index(s, opc, datalo, datahi, addrlo, addend);
-
-    add_qemu_ldst_label(s, true, oi, datalo, datahi, addrlo, addrhi,
-                        s->code_ptr, label_ptr);
-#else /* !CONFIG_SOFTMMU */
+    add_ldst_ool_label(s, true, is64, oi, R_ARM_PC24, 0);
+    tcg_out_bl_noaddr(s, COND_AL);
+#else
     if (guest_base) {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP, guest_base);
-        tcg_out_qemu_ld_index(s, opc, datalo, datahi, addrlo, TCG_REG_TMP);
+        tcg_out_qemu_ld_index(s, get_memop(oi), datalo, datahi,
+                              addrlo, TCG_REG_TMP);
     } else {
-        tcg_out_qemu_ld_direct(s, opc, datalo, datahi, addrlo);
+        tcg_out_qemu_ld_direct(s, get_memop(oi), datalo, datahi, addrlo);
     }
 #endif
 }
@@ -1747,33 +1600,76 @@ static inline void tcg_out_qemu_st_direct(TCGContext *s, TCGMemOp opc,
 
 static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
 {
-    TCGReg addrlo, datalo, datahi, addrhi __attribute__((unused));
+    TCGReg addrlo __attribute__((unused));
+    TCGReg addrhi __attribute__((unused));
+    TCGReg datalo __attribute__((unused));
+    TCGReg datahi __attribute__((unused));
     TCGMemOpIdx oi;
-    TCGMemOp opc;
-#ifdef CONFIG_SOFTMMU
-    int mem_index, avail;
-    TCGReg addend, t0, t1;
-    tcg_insn_unit *label_ptr;
-#endif
 
     datalo = *args++;
     datahi = (is64 ? *args++ : 0);
     addrlo = *args++;
     addrhi = (TARGET_LONG_BITS == 64 ? *args++ : 0);
     oi = *args++;
-    opc = get_memop(oi);
 
 #ifdef CONFIG_SOFTMMU
-    mem_index = get_mmuidx(oi);
+    add_ldst_ool_label(s, false, is64, oi, R_ARM_PC24, 0);
+    tcg_out_bl_noaddr(s, COND_AL);
+#else
+    if (guest_base) {
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP, guest_base);
+        tcg_out_qemu_st_index(s, COND_AL, get_memop(oi), datalo,
+                              datahi, addrlo, TCG_REG_TMP);
+    } else {
+        tcg_out_qemu_st_direct(s, get_memop(oi), datalo, datahi, addrlo);
+    }
+#endif
+}
 
+#ifdef CONFIG_SOFTMMU
+static tcg_insn_unit *tcg_out_qemu_ldst_ool(TCGContext *s, bool is_ld,
+                                            bool is_64, TCGMemOpIdx oi)
+{
+    TCGReg addrlo, addrhi, datalo, datahi, addend, argreg, t0, t1;
+    TCGMemOp opc = get_memop(oi);
+    int mem_index = get_mmuidx(oi);
+    tcg_insn_unit *thunk = s->code_ptr;
+    tcg_insn_unit *label;
+    uintptr_t func;
+    int avail;
+
+    /* Pick out where the arguments are located.  A 64-bit address is
+     * aligned in the register pair R2:R3.  Loads return into R0:R1.
+     * A 32-bit store with a 32-bit address has room at R2, but
+     * otherwise uses R4:R5.
+     */
+    if (TARGET_LONG_BITS == 64) {
+        addrlo = TCG_REG_R2, addrhi = TCG_REG_R3;
+    } else {
+        addrlo = TCG_REG_R1, addrhi = -1;
+    }
+    if (is_ld) {
+        datalo = TCG_REG_R0;
+    } else if (TARGET_LONG_BITS == 64 || is_64) {
+        datalo = TCG_REG_R4;
+    } else {
+        datalo = TCG_REG_R2;
+    }
+    datahi = (is_64 ? datalo + 1 : -1);
+
+    /* We need 3 call-clobbered temps.  One of them is always R12,
+     * one of them is always R0.  The third is somewhere in R[1-3].
+     */
     avail = 0xf;
     avail &= ~(1 << addrlo);
-    avail &= ~(1 << datalo);
     if (TARGET_LONG_BITS == 64) {
         avail &= ~(1 << addrhi);
     }
-    if (is64) {
-        avail &= ~(1 << datahi);
+    if (!is_ld) {
+        avail &= ~(1 << datalo);
+        if (is_64) {
+            avail &= ~(1 << datahi);
+        }
     }
     tcg_debug_assert(avail & 1);
     t0 = TCG_REG_R0;
@@ -1781,27 +1677,63 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
     tcg_debug_assert(avail != 0);
     t1 = ctz32(avail);
 
-    addend = tcg_out_tlb_read(s, addrlo, addrhi, opc, mem_index, 0,
+    addend = tcg_out_tlb_read(s, addrlo, addrhi, opc, mem_index, is_ld,
                               t0, t1, TCG_REG_TMP);
 
-    tcg_out_qemu_st_index(s, COND_EQ, opc, datalo, datahi, addrlo, addend);
+    label = s->code_ptr;
+    tcg_out_b_noaddr(s, COND_NE);
 
-    /* The conditional call must come last, as we're going to return here.  */
-    label_ptr = s->code_ptr;
-    tcg_out_bl_noaddr(s, COND_NE);
-
-    add_qemu_ldst_label(s, false, oi, datalo, datahi, addrlo, addrhi,
-                        s->code_ptr, label_ptr);
-#else /* !CONFIG_SOFTMMU */
-    if (guest_base) {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP, guest_base);
-        tcg_out_qemu_st_index(s, COND_AL, opc, datalo,
-                              datahi, addrlo, TCG_REG_TMP);
+    /* TCG Hit.  */
+    if (is_ld) {
+        tcg_out_qemu_ld_index(s, opc, datalo, datahi, addrlo, addend);
     } else {
-        tcg_out_qemu_st_direct(s, opc, datalo, datahi, addrlo);
+        tcg_out_qemu_st_index(s, COND_AL, opc, datalo, datahi, addrlo, addend);
     }
-#endif
+    tcg_out_bx(s, COND_AL, TCG_REG_R14);
+
+    /* TLB Miss.  */
+    reloc_pc24(label, s->code_ptr);
+
+    tcg_out_arg_reg32(s, TCG_REG_R0, TCG_AREG0);
+    /* addrlo and addrhi are in place -- see above */
+    argreg = addrlo + (TARGET_LONG_BITS / 32);
+    if (!is_ld) {
+        switch (opc & MO_SIZE) {
+        case MO_8:
+            argreg = tcg_out_arg_reg8(s, argreg, datalo);
+            break;
+        case MO_16:
+            argreg = tcg_out_arg_reg16(s, argreg, datalo);
+            break;
+        case MO_32:
+            argreg = tcg_out_arg_reg32(s, argreg, datalo);
+            break;
+        case MO_64:
+            argreg = tcg_out_arg_reg64(s, argreg, datalo, datahi);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+    argreg = tcg_out_arg_imm32(s, argreg, oi);
+    argreg = tcg_out_arg_reg32(s, argreg, TCG_REG_R14);
+
+    /* Tail call to the helper.  */
+    if (is_ld) {
+        func = (uintptr_t)qemu_ld_helpers[opc & (MO_BSWAP | MO_SSIZE)];
+    } else {
+        func = (uintptr_t)qemu_st_helpers[opc & (MO_BSWAP | MO_SIZE)];
+    }
+    if (use_armv7_instructions) {
+        tcg_out_movi32(s, COND_AL, TCG_REG_TMP, func);
+        tcg_out_bx(s, COND_AL, TCG_REG_TMP);
+    } else {
+        tcg_out_movi_pool(s, COND_AL, TCG_REG_PC, func);
+    }
+
+    return thunk;
 }
+#endif
 
 static tcg_insn_unit *tb_ret_addr;
 
-- 
2.17.2
