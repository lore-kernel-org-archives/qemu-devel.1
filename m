Received: from eggs.gnu.org ([2001:4830:134:3::10]:54157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK3E-0003ZW-L0
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK3A-0004yo-Cy
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:19 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMK3A-0004y4-3X
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:16 -0500
Received: by mail-wm1-x343.google.com with SMTP id u13-v6so9546963wmc.4
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:47:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 12 Nov 2018 22:44:53 +0100
Message-Id: <20181112214503.22941-8-richard.henderson@linaro.org>
In-Reply-To: <20181112214503.22941-1-richard.henderson@linaro.org>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 07/17] tcg/i386: Use
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

Move the entire memory operation out of line.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |   2 +-
 tcg/i386/tcg-target.inc.c | 401 ++++++++++++++++----------------------
 2 files changed, 171 insertions(+), 232 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 9fdf37f23c..c2d84cf1d2 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -224,7 +224,7 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
 #define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
 
 #ifdef CONFIG_SOFTMMU
-#define TCG_TARGET_NEED_LDST_LABELS
+#define TCG_TARGET_NEED_LDST_OOL_LABELS
 #endif
 #define TCG_TARGET_NEED_POOL_LABELS
 
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 16d5af76ad..1833f4c2b2 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1619,7 +1619,7 @@ static void tcg_out_nopn(TCGContext *s, int n)
 }
 
 #if defined(CONFIG_SOFTMMU)
-#include "tcg-ldst.inc.c"
+#include "tcg-ldst-ool.inc.c"
 
 /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
  *                                     int mmu_idx, uintptr_t ra)
@@ -1632,6 +1632,14 @@ static void * const qemu_ld_helpers[16] = {
     [MO_BEUW] = helper_be_lduw_mmu,
     [MO_BEUL] = helper_be_ldul_mmu,
     [MO_BEQ]  = helper_be_ldq_mmu,
+
+    [MO_SB]   = helper_ret_ldsb_mmu,
+    [MO_LESW] = helper_le_ldsw_mmu,
+    [MO_BESW] = helper_be_ldsw_mmu,
+#if TCG_TARGET_REG_BITS == 64
+    [MO_LESL] = helper_le_ldsl_mmu,
+    [MO_BESL] = helper_be_ldsl_mmu,
+#endif
 };
 
 /* helper signature: helper_ret_st_mmu(CPUState *env, target_ulong addr,
@@ -1741,18 +1749,18 @@ static TCGReg tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
     }
 
     /* jne slow_path */
-    tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
+    tcg_out_opc(s, OPC_JCC_short + JCC_JNE, 0, 0, 0);
     label_ptr[0] = s->code_ptr;
-    s->code_ptr += 4;
+    s->code_ptr += 1;
 
     if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
         /* cmp 4(r0), addrhi */
         tcg_out_modrm_offset(s, OPC_CMP_GvEv, addrhi, r0, 4);
 
         /* jne slow_path */
-        tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
+        tcg_out_opc(s, OPC_JCC_short + JCC_JNE, 0, 0, 0);
         label_ptr[1] = s->code_ptr;
-        s->code_ptr += 4;
+        s->code_ptr += 1;
     }
 
     /* TLB Hit.  */
@@ -1764,181 +1772,6 @@ static TCGReg tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
     return base;
 }
 
-/*
- * Record the context of a call to the out of line helper code for the slow path
- * for a load or store, so that we can later generate the correct helper code
- */
-static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
-                                TCGReg datalo, TCGReg datahi,
-                                TCGReg addrlo, TCGReg addrhi,
-                                tcg_insn_unit *raddr,
-                                tcg_insn_unit **label_ptr)
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
-    label->label_ptr[0] = label_ptr[0];
-    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
-        label->label_ptr[1] = label_ptr[1];
-    }
-}
-
-/*
- * Generate code for the slow path for a load at the end of block
- */
-static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
-{
-    TCGMemOpIdx oi = l->oi;
-    TCGMemOp opc = get_memop(oi);
-    TCGReg data_reg;
-    tcg_insn_unit **label_ptr = &l->label_ptr[0];
-
-    /* resolve label address */
-    tcg_patch32(label_ptr[0], s->code_ptr - label_ptr[0] - 4);
-    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
-        tcg_patch32(label_ptr[1], s->code_ptr - label_ptr[1] - 4);
-    }
-
-    if (TCG_TARGET_REG_BITS == 32) {
-        int ofs = 0;
-
-        tcg_out_st(s, TCG_TYPE_PTR, TCG_AREG0, TCG_REG_ESP, ofs);
-        ofs += 4;
-
-        tcg_out_st(s, TCG_TYPE_I32, l->addrlo_reg, TCG_REG_ESP, ofs);
-        ofs += 4;
-
-        if (TARGET_LONG_BITS == 64) {
-            tcg_out_st(s, TCG_TYPE_I32, l->addrhi_reg, TCG_REG_ESP, ofs);
-            ofs += 4;
-        }
-
-        tcg_out_sti(s, TCG_TYPE_I32, oi, TCG_REG_ESP, ofs);
-        ofs += 4;
-
-        tcg_out_sti(s, TCG_TYPE_PTR, (uintptr_t)l->raddr, TCG_REG_ESP, ofs);
-    } else {
-        tcg_out_mov(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[0], TCG_AREG0);
-        /* The second argument is already loaded with addrlo.  */
-        tcg_out_movi(s, TCG_TYPE_I32, tcg_target_call_iarg_regs[2], oi);
-        tcg_out_movi(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[3],
-                     (uintptr_t)l->raddr);
-    }
-
-    tcg_out_call(s, qemu_ld_helpers[opc & (MO_BSWAP | MO_SIZE)]);
-
-    data_reg = l->datalo_reg;
-    switch (opc & MO_SSIZE) {
-    case MO_SB:
-        tcg_out_ext8s(s, data_reg, TCG_REG_EAX, P_REXW);
-        break;
-    case MO_SW:
-        tcg_out_ext16s(s, data_reg, TCG_REG_EAX, P_REXW);
-        break;
-#if TCG_TARGET_REG_BITS == 64
-    case MO_SL:
-        tcg_out_ext32s(s, data_reg, TCG_REG_EAX);
-        break;
-#endif
-    case MO_UB:
-    case MO_UW:
-        /* Note that the helpers have zero-extended to tcg_target_long.  */
-    case MO_UL:
-        tcg_out_mov(s, TCG_TYPE_I32, data_reg, TCG_REG_EAX);
-        break;
-    case MO_Q:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_mov(s, TCG_TYPE_I64, data_reg, TCG_REG_RAX);
-        } else if (data_reg == TCG_REG_EDX) {
-            /* xchg %edx, %eax */
-            tcg_out_opc(s, OPC_XCHG_ax_r32 + TCG_REG_EDX, 0, 0, 0);
-            tcg_out_mov(s, TCG_TYPE_I32, l->datahi_reg, TCG_REG_EAX);
-        } else {
-            tcg_out_mov(s, TCG_TYPE_I32, data_reg, TCG_REG_EAX);
-            tcg_out_mov(s, TCG_TYPE_I32, l->datahi_reg, TCG_REG_EDX);
-        }
-        break;
-    default:
-        tcg_abort();
-    }
-
-    /* Jump to the code corresponding to next IR of qemu_st */
-    tcg_out_jmp(s, l->raddr);
-}
-
-/*
- * Generate code for the slow path for a store at the end of block
- */
-static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
-{
-    TCGMemOpIdx oi = l->oi;
-    TCGMemOp opc = get_memop(oi);
-    TCGMemOp s_bits = opc & MO_SIZE;
-    tcg_insn_unit **label_ptr = &l->label_ptr[0];
-    TCGReg retaddr;
-
-    /* resolve label address */
-    tcg_patch32(label_ptr[0], s->code_ptr - label_ptr[0] - 4);
-    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
-        tcg_patch32(label_ptr[1], s->code_ptr - label_ptr[1] - 4);
-    }
-
-    if (TCG_TARGET_REG_BITS == 32) {
-        int ofs = 0;
-
-        tcg_out_st(s, TCG_TYPE_PTR, TCG_AREG0, TCG_REG_ESP, ofs);
-        ofs += 4;
-
-        tcg_out_st(s, TCG_TYPE_I32, l->addrlo_reg, TCG_REG_ESP, ofs);
-        ofs += 4;
-
-        if (TARGET_LONG_BITS == 64) {
-            tcg_out_st(s, TCG_TYPE_I32, l->addrhi_reg, TCG_REG_ESP, ofs);
-            ofs += 4;
-        }
-
-        tcg_out_st(s, TCG_TYPE_I32, l->datalo_reg, TCG_REG_ESP, ofs);
-        ofs += 4;
-
-        if (s_bits == MO_64) {
-            tcg_out_st(s, TCG_TYPE_I32, l->datahi_reg, TCG_REG_ESP, ofs);
-            ofs += 4;
-        }
-
-        tcg_out_sti(s, TCG_TYPE_I32, oi, TCG_REG_ESP, ofs);
-        ofs += 4;
-
-        retaddr = TCG_REG_EAX;
-        tcg_out_movi(s, TCG_TYPE_PTR, retaddr, (uintptr_t)l->raddr);
-        tcg_out_st(s, TCG_TYPE_PTR, retaddr, TCG_REG_ESP, ofs);
-    } else {
-        tcg_out_mov(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[0], TCG_AREG0);
-        /* The second argument is already loaded with addrlo.  */
-        tcg_out_mov(s, (s_bits == MO_64 ? TCG_TYPE_I64 : TCG_TYPE_I32),
-                    tcg_target_call_iarg_regs[2], l->datalo_reg);
-        tcg_out_movi(s, TCG_TYPE_I32, tcg_target_call_iarg_regs[3], oi);
-
-        if (ARRAY_SIZE(tcg_target_call_iarg_regs) > 4) {
-            retaddr = tcg_target_call_iarg_regs[4];
-            tcg_out_movi(s, TCG_TYPE_PTR, retaddr, (uintptr_t)l->raddr);
-        } else {
-            retaddr = TCG_REG_RAX;
-            tcg_out_movi(s, TCG_TYPE_PTR, retaddr, (uintptr_t)l->raddr);
-            tcg_out_st(s, TCG_TYPE_PTR, retaddr, TCG_REG_ESP,
-                       TCG_TARGET_CALL_STACK_OFFSET);
-        }
-    }
-
-    /* "Tail call" to the helper, with the return address back inline.  */
-    tcg_out_push(s, retaddr);
-    tcg_out_jmp(s, qemu_st_helpers[opc & (MO_BSWAP | MO_SIZE)]);
-}
 #elif defined(__x86_64__) && defined(__linux__)
 # include <asm/prctl.h>
 # include <sys/prctl.h>
@@ -2067,7 +1900,6 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
     TCGReg datahi __attribute__((unused)) = -1;
     TCGReg addrhi __attribute__((unused)) = -1;
     TCGMemOpIdx oi;
-    TCGMemOp opc;
     int i = -1;
 
     datalo = args[++i];
@@ -2079,35 +1911,25 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
         addrhi = args[++i];
     }
     oi = args[++i];
-    opc = get_memop(oi);
 
 #if defined(CONFIG_SOFTMMU)
-    {
-        int mem_index = get_mmuidx(oi);
-        tcg_insn_unit *label_ptr[2];
-        TCGReg base;
-
-        tcg_debug_assert(datalo == tcg_target_call_oarg_regs[0]);
-        if (TCG_TARGET_REG_BITS == 32 && is64) {
-            tcg_debug_assert(datahi == tcg_target_call_oarg_regs[1]);
-        }
-        tcg_debug_assert(addrlo == softmmu_arg(0));
-        if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
-            tcg_debug_assert(addrhi == softmmu_arg(1));
-        }
-
-        base = tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc,
-                                label_ptr, offsetof(CPUTLBEntry, addr_read));
-
-        /* TLB Hit.  */
-        tcg_out_qemu_ld_direct(s, datalo, datahi, base, -1, 0, 0, opc);
-
-        /* Record the current context of a load into ldst label */
-        add_qemu_ldst_label(s, true, oi, datalo, datahi, addrlo, addrhi,
-                            s->code_ptr, label_ptr);
+    /* Assert that we've set up the constraints properly.  */
+    tcg_debug_assert(datalo == tcg_target_call_oarg_regs[0]);
+    if (TCG_TARGET_REG_BITS == 32 && is64) {
+        tcg_debug_assert(datahi == tcg_target_call_oarg_regs[1]);
     }
+    tcg_debug_assert(addrlo == softmmu_arg(0));
+    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
+        tcg_debug_assert(addrhi == softmmu_arg(1));
+    }
+
+    /* Call to thunk.  */
+    tcg_out8(s, OPC_CALL_Jz);
+    add_ldst_ool_label(s, true, is64, oi, R_386_PC32, -4);
+    s->code_ptr += 4;
 #else
     {
+        TCGMemOp opc = get_memop(oi);
         int32_t offset = guest_base;
         TCGReg base = addrlo;
         int index = -1;
@@ -2222,7 +2044,6 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
     TCGReg datahi __attribute__((unused)) = -1;
     TCGReg addrhi __attribute__((unused)) = -1;
     TCGMemOpIdx oi;
-    TCGMemOp opc;
     int i = -1;
 
     datalo = args[++i];
@@ -2234,36 +2055,26 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
         addrhi = args[++i];
     }
     oi = args[++i];
-    opc = get_memop(oi);
 
 #if defined(CONFIG_SOFTMMU)
-    {
-        int mem_index = get_mmuidx(oi);
-        tcg_insn_unit *label_ptr[2];
-        TCGReg base;
-
-        i = -1;
-        tcg_debug_assert(addrlo == softmmu_arg(++i));
-        if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
-            tcg_debug_assert(addrhi == softmmu_arg(++i));
-        }
-        tcg_debug_assert(datalo == softmmu_arg(++i));
-        if (TCG_TARGET_REG_BITS == 32 && is64) {
-            tcg_debug_assert(datahi == softmmu_arg(++i));
-        }
-
-        base = tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc,
-                                label_ptr, offsetof(CPUTLBEntry, addr_write));
-
-        /* TLB Hit.  */
-        tcg_out_qemu_st_direct(s, datalo, datahi, base, 0, 0, opc);
-
-        /* Record the current context of a store into ldst label */
-        add_qemu_ldst_label(s, false, oi, datalo, datahi, addrlo, addrhi,
-                            s->code_ptr, label_ptr);
+    /* Assert that we've set up the constraints properly.  */
+    i = -1;
+    tcg_debug_assert(addrlo == softmmu_arg(++i));
+    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
+        tcg_debug_assert(addrhi == softmmu_arg(++i));
     }
+    tcg_debug_assert(datalo == softmmu_arg(++i));
+    if (TCG_TARGET_REG_BITS == 32 && is64) {
+        tcg_debug_assert(datahi == softmmu_arg(++i));
+    }
+
+    /* Call to thunk.  */
+    tcg_out8(s, OPC_CALL_Jz);
+    add_ldst_ool_label(s, false, is64, oi, R_386_PC32, -4);
+    s->code_ptr += 4;
 #else
     {
+        TCGMemOp opc = get_memop(oi);
         int32_t offset = guest_base;
         TCGReg base = addrlo;
         int seg = 0;
@@ -2298,6 +2109,134 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
 #endif
 }
 
+#if defined(CONFIG_SOFTMMU)
+/*
+ * Generate code for an out-of-line thunk performing a load.
+ */
+static tcg_insn_unit *tcg_out_qemu_ldst_ool(TCGContext *s, bool is_ld,
+                                            bool is64, TCGMemOpIdx oi)
+{
+    TCGMemOp opc = get_memop(oi);
+    int mem_index = get_mmuidx(oi);
+    tcg_insn_unit *label_ptr[2], *thunk;
+    TCGReg datalo, addrlo, base;
+    TCGReg datahi __attribute__((unused)) = -1;
+    TCGReg addrhi __attribute__((unused)) = -1;
+    int i;
+
+    /* Since we're amortizing the cost, align the thunk.  */
+    thunk = QEMU_ALIGN_PTR_UP(s->code_ptr, 16);
+    if (thunk != s->code_ptr) {
+        memset(s->code_ptr, 0x90, thunk - s->code_ptr);
+        s->code_ptr = thunk;
+    }
+
+    /* Discover where the inputs are held.  */
+    i = -1;
+    addrlo = softmmu_arg(++i);
+    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
+        addrhi = softmmu_arg(++i);
+    }
+    if (is_ld) {
+        datalo = tcg_target_call_oarg_regs[0];
+        if (TCG_TARGET_REG_BITS == 32 && is64) {
+            datahi = tcg_target_call_oarg_regs[1];
+        }
+    } else {
+        datalo = softmmu_arg(++i);
+        if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
+            datahi = softmmu_arg(++i);
+        }
+    }
+
+    base = tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc, label_ptr,
+                            is_ld ? offsetof(CPUTLBEntry, addr_read)
+                            : offsetof(CPUTLBEntry, addr_write));
+
+    /* TLB Hit.  */
+    if (is_ld) {
+        tcg_out_qemu_ld_direct(s, datalo, datahi, base, -1, 0, 0, opc);
+    } else {
+        tcg_out_qemu_st_direct(s, datalo, datahi, base, 0, 0, opc);
+    }
+    tcg_out_opc(s, OPC_RET, 0, 0, 0);
+
+    /* TLB Miss.  */
+
+    /* resolve label address */
+    tcg_patch8(label_ptr[0], s->code_ptr - label_ptr[0] - 1);
+    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
+        tcg_patch8(label_ptr[1], s->code_ptr - label_ptr[1] - 1);
+    }
+
+    if (TCG_TARGET_REG_BITS == 32) {
+        /* Copy the return address into a temporary.  */
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_L0, TCG_REG_ESP, 0);
+        i = 4;
+
+        tcg_out_st(s, TCG_TYPE_PTR, TCG_AREG0, TCG_REG_ESP, i);
+        i += 4;
+
+        tcg_out_st(s, TCG_TYPE_I32, addrlo, TCG_REG_ESP, i);
+        i += 4;
+
+        if (TARGET_LONG_BITS == 64) {
+            tcg_out_st(s, TCG_TYPE_I32, addrhi, TCG_REG_ESP, i);
+            i += 4;
+        }
+
+        if (!is_ld) {
+            tcg_out_st(s, TCG_TYPE_I32, datalo, TCG_REG_ESP, i);
+            i += 4;
+
+            if (is64) {
+                tcg_out_st(s, TCG_TYPE_I32, datahi, TCG_REG_ESP, i);
+                i += 4;
+            }
+        }
+
+        tcg_out_sti(s, TCG_TYPE_I32, oi, TCG_REG_ESP, i);
+        i += 4;
+
+        tcg_out_st(s, TCG_TYPE_PTR, TCG_REG_L0, TCG_REG_ESP, i);
+    } else {
+        tcg_out_mov(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[0], TCG_AREG0);
+
+        /* The address and data values have been placed by constraints.  */
+        tcg_debug_assert(addrlo == tcg_target_call_iarg_regs[1]);
+        if (is_ld) {
+            i = 2;
+        } else {
+            tcg_debug_assert(datalo == tcg_target_call_iarg_regs[2]);
+            i = 3;
+        }
+
+        tcg_out_movi(s, TCG_TYPE_I32, tcg_target_call_iarg_regs[i++], oi);
+
+        /* Copy the return address from the stack to the rvalue argument.
+         * WIN64 runs out of argument registers for stores.
+         */
+        if (i < (int)ARRAY_SIZE(tcg_target_call_iarg_regs)) {
+            tcg_out_ld(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[i],
+                       TCG_REG_ESP, 0);
+        } else {
+            tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_RAX, TCG_REG_ESP, 0);
+            tcg_out_st(s, TCG_TYPE_PTR, TCG_REG_RAX, TCG_REG_ESP,
+                       TCG_TARGET_CALL_STACK_OFFSET + 8);
+        }
+    }
+
+    /* Tail call to the helper.  */
+    if (is_ld) {
+        tcg_out_jmp(s, qemu_ld_helpers[opc & (MO_BSWAP | MO_SSIZE)]);
+    } else {
+        tcg_out_jmp(s, qemu_st_helpers[opc & (MO_BSWAP | MO_SIZE)]);
+    }
+
+    return thunk;
+}
+#endif
+
 static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
                               const TCGArg *args, const int *const_args)
 {
-- 
2.17.2
