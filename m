Received: from eggs.gnu.org ([2001:4830:134:3::10]:43008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cG4L9-0002Iv-4m
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 08:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cG4L6-0001ft-Px
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 08:38:55 -0500
Received: from [114.242.206.163] (port=49202 helo=loongson.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cG4L5-0001er-EX
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 08:38:52 -0500
From: Jin Guojie <jinguojie@loongson.cn>
Date: Sun, 11 Dec 2016 21:36:25 +0800
Message-Id: <1481463385-15898-11-git-send-email-jinguojie@loongson.cn>
In-Reply-To: <1481463385-15898-1-git-send-email-jinguojie@loongson.cn>
References: <1481463385-15898-1-git-send-email-jinguojie@loongson.cn>
Subject: [Qemu-devel] [PATCH v6 10/10] tcg-mips: Adjust qemu_ld/st for mips64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, James Hogan <james.hogan@imgtec.com>, YunQiang Su <wzssyqa@gmail.com>, Richard Henderson <rth@twiddle.net>, Jin Guojie <jinguojie@loongson.cn>

Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: James Hogan <james.hogan@imgtec.com>
Tested-by: YunQiang Su <wzssyqa@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Jin Guojie <jinguojie@loongson.cn>
---
 tcg/mips/tcg-target.inc.c | 203 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 146 insertions(+), 57 deletions(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 7282a4a..b992852 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -32,8 +32,16 @@
 # define MIPS_BE  0
 #endif
 
-#define LO_OFF    (MIPS_BE * 4)
-#define HI_OFF    (4 - LO_OFF)
+#if TCG_TARGET_REG_BITS == 32
+# define LO_OFF  (MIPS_BE * 4)
+# define HI_OFF  (4 - LO_OFF)
+#else
+/* To assert at compile-time that these values were never used
+   for TCG_TARGET_REGS == 64 */
+/* extern */ int link_error(void);
+# define LO_OFF  link_error()
+# define HI_OFF  link_error()
+#endif
 
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
@@ -193,7 +201,7 @@ static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
         tcg_regset_set(ct->u.regs, 0xffffffff);
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_A0);
 #if defined(CONFIG_SOFTMMU)
-        if (TARGET_LONG_BITS == 64) {
+        if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
             tcg_regset_reset_reg(ct->u.regs, TCG_REG_A2);
         }
 #endif
@@ -203,11 +211,11 @@ static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
         tcg_regset_set(ct->u.regs, 0xffffffff);
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_A0);
 #if defined(CONFIG_SOFTMMU)
-        if (TARGET_LONG_BITS == 32) {
-            tcg_regset_reset_reg(ct->u.regs, TCG_REG_A1);
-        } else {
+        if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
             tcg_regset_reset_reg(ct->u.regs, TCG_REG_A2);
             tcg_regset_reset_reg(ct->u.regs, TCG_REG_A3);
+        } else {
+            tcg_regset_reset_reg(ct->u.regs, TCG_REG_A1);
         }
 #endif
         break;
@@ -1104,6 +1112,10 @@ static void * const qemu_ld_helpers[16] = {
     [MO_BESW] = helper_be_ldsw_mmu,
     [MO_BEUL] = helper_be_ldul_mmu,
     [MO_BEQ]  = helper_be_ldq_mmu,
+#if TCG_TARGET_REG_BITS == 64
+    [MO_LESL] = helper_le_ldsl_mmu,
+    [MO_BESL] = helper_be_ldsl_mmu,
+#endif
 };
 
 static void * const qemu_st_helpers[16] = {
@@ -1131,6 +1143,9 @@ static int tcg_out_call_iarg_reg(TCGContext *s, int i, TCGReg arg)
     if (i < ARRAY_SIZE(tcg_target_call_iarg_regs)) {
         tcg_out_mov(s, TCG_TYPE_REG, tcg_target_call_iarg_regs[i], arg);
     } else {
+        /* For N32 and N64, the initial offset is different.  But there
+           we also have 8 argument register so we don't run out here.  */
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
         tcg_out_st(s, TCG_TYPE_REG, arg, TCG_REG_SP, 4 * i);
     }
     return i + 1;
@@ -1172,6 +1187,7 @@ static int tcg_out_call_iarg_imm(TCGContext *s, int i, TCGArg arg)
 
 static int tcg_out_call_iarg_reg2(TCGContext *s, int i, TCGReg al, TCGReg ah)
 {
+    tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
     i = (i + 1) & ~1;
     i = tcg_out_call_iarg_reg(s, i, (MIPS_BE ? ah : al));
     i = tcg_out_call_iarg_reg(s, i, (MIPS_BE ? al : ah));
@@ -1179,7 +1195,7 @@ static int tcg_out_call_iarg_reg2(TCGContext *s, int i, TCGReg al, TCGReg ah)
 }
 
 /* Perform the tlb comparison operation.  The complete host address is
-   placed in BASE.  Clobbers TMP0, TMP1, A0.  */
+   placed in BASE.  Clobbers TMP0, TMP1, TMP2, A0.  */
 static void tcg_out_tlb_load(TCGContext *s, TCGReg base, TCGReg addrl,
                              TCGReg addrh, TCGMemOpIdx oi,
                              tcg_insn_unit *label_ptr[2], bool is_load)
@@ -1187,6 +1203,7 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg base, TCGReg addrl,
     TCGMemOp opc = get_memop(oi);
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_bits = get_alignment_bits(opc);
+    target_ulong mask;
     int mem_index = get_mmuidx(oi);
     int cmp_off
         = (is_load
@@ -1194,11 +1211,11 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg base, TCGReg addrl,
            : offsetof(CPUArchState, tlb_table[mem_index][0].addr_write));
     int add_off = offsetof(CPUArchState, tlb_table[mem_index][0].addend);
 
-    tcg_out_opc_sa(s, OPC_SRL, TCG_REG_A0, addrl,
+    tcg_out_opc_sa(s, ALIAS_TSRL, TCG_REG_A0, addrl,
                    TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
     tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_A0, TCG_REG_A0,
                     (CPU_TLB_SIZE - 1) << CPU_TLB_ENTRY_BITS);
-    tcg_out_opc_reg(s, OPC_ADDU, TCG_REG_A0, TCG_REG_A0, TCG_AREG0);
+    tcg_out_opc_reg(s, ALIAS_PADD, TCG_REG_A0, TCG_REG_A0, TCG_AREG0);
 
     /* Compensate for very large offsets.  */
     if (add_off >= 0x8000) {
@@ -1208,51 +1225,63 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg base, TCGReg addrl,
         QEMU_BUILD_BUG_ON(offsetof(CPUArchState,
                                    tlb_table[NB_MMU_MODES - 1][1])
                           > 0x7ff0 + 0x7fff);
-        tcg_out_opc_imm(s, OPC_ADDIU, TCG_REG_A0, TCG_REG_A0, 0x7ff0);
+        tcg_out_opc_imm(s, ALIAS_PADDI, TCG_REG_A0, TCG_REG_A0, 0x7ff0);
         cmp_off -= 0x7ff0;
         add_off -= 0x7ff0;
     }
 
-    /* Load the (low half) tlb comparator.  */
-    tcg_out_opc_imm(s, OPC_LW, TCG_TMP0, TCG_REG_A0,
-                    cmp_off + (TARGET_LONG_BITS == 64 ? LO_OFF : 0));
-
     /* We don't currently support unaligned accesses.
        We could do so with mips32r6.  */
     if (a_bits < s_bits) {
         a_bits = s_bits;
     }
-    /* Mask the page bits, keeping the alignment bits to compare against.
-       In between on 32-bit targets, load the tlb addend for the fast path.  */
-    tcg_out_movi(s, TCG_TYPE_I32, TCG_TMP1,
-                 TARGET_PAGE_MASK | ((1 << a_bits) - 1));
-    if (TARGET_LONG_BITS == 32) {
-        tcg_out_opc_imm(s, OPC_LW, TCG_REG_A0, TCG_REG_A0, add_off);
+
+    mask = (target_ulong)TARGET_PAGE_MASK | ((1 << a_bits) - 1);
+
+    /* Load the (low half) tlb comparator.  Mask the page bits, keeping the
+       alignment bits to compare against.  */
+    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
+        tcg_out_ld(s, TCG_TYPE_I32, TCG_TMP0, TCG_REG_A0, cmp_off + LO_OFF);
+        tcg_out_movi(s, TCG_TYPE_I32, TCG_TMP1, mask);
+    } else {
+        tcg_out_ldst(s,
+                    (TARGET_LONG_BITS == 64 ? OPC_LD
+                    : TCG_TARGET_REG_BITS == 64 ? OPC_LWU : OPC_LW),
+                    TCG_TMP0, TCG_REG_A0, cmp_off);
+        tcg_out_movi(s, TCG_TYPE_TL, TCG_TMP1, mask);
+        /* No second compare is required here;
+           load the tlb addend for the fast path.  */
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP2, TCG_REG_A0, add_off);
     }
     tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, TCG_TMP1, addrl);
 
+    /* Zero extend a 32-bit guest address for a 64-bit host. */
+    if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
+        tcg_out_ext32u(s, base, addrl);
+        addrl = base;
+    }
+
     label_ptr[0] = s->code_ptr;
     tcg_out_opc_br(s, OPC_BNE, TCG_TMP1, TCG_TMP0);
 
     /* Load and test the high half tlb comparator.  */
-    if (TARGET_LONG_BITS == 64) {
+    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
         /* delay slot */
-        tcg_out_opc_imm(s, OPC_LW, TCG_TMP0, TCG_REG_A0, cmp_off + HI_OFF);
+        tcg_out_ld(s, TCG_TYPE_I32, TCG_TMP0, TCG_REG_A0, cmp_off + HI_OFF);
 
-        /* Load the tlb addend for the fast path. We can't do it earlier with
-           64-bit targets or we'll clobber a0 before reading the high half tlb
-           comparator.  */
-        tcg_out_opc_imm(s, OPC_LW, TCG_REG_A0, TCG_REG_A0, add_off);
+        /* Load the tlb addend for the fast path.  */
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP2, TCG_REG_A0, add_off);
 
         label_ptr[1] = s->code_ptr;
         tcg_out_opc_br(s, OPC_BNE, addrh, TCG_TMP0);
     }
 
     /* delay slot */
-    tcg_out_opc_reg(s, OPC_ADDU, base, TCG_REG_A0, addrl);
+    tcg_out_opc_reg(s, ALIAS_PADD, base, TCG_TMP2, addrl);
 }
 
 static void add_qemu_ldst_label(TCGContext *s, int is_ld, TCGMemOpIdx oi,
+                                TCGType ext,
                                 TCGReg datalo, TCGReg datahi,
                                 TCGReg addrlo, TCGReg addrhi,
                                 void *raddr, tcg_insn_unit *label_ptr[2])
@@ -1261,13 +1290,14 @@ static void add_qemu_ldst_label(TCGContext *s, int is_ld, TCGMemOpIdx oi,
 
     label->is_ld = is_ld;
     label->oi = oi;
+    label->type = ext;
     label->datalo_reg = datalo;
     label->datahi_reg = datahi;
     label->addrlo_reg = addrlo;
     label->addrhi_reg = addrhi;
     label->raddr = raddr;
     label->label_ptr[0] = label_ptr[0];
-    if (TARGET_LONG_BITS == 64) {
+    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
         label->label_ptr[1] = label_ptr[1];
     }
 }
@@ -1281,12 +1311,12 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 
     /* resolve label address */
     reloc_pc16(l->label_ptr[0], s->code_ptr);
-    if (TARGET_LONG_BITS == 64) {
+    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
         reloc_pc16(l->label_ptr[1], s->code_ptr);
     }
 
     i = 1;
-    if (TARGET_LONG_BITS == 64) {
+    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
         i = tcg_out_call_iarg_reg2(s, i, l->addrlo_reg, l->addrhi_reg);
     } else {
         i = tcg_out_call_iarg_reg(s, i, l->addrlo_reg);
@@ -1298,7 +1328,7 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     tcg_out_mov(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[0], TCG_AREG0);
 
     v0 = l->datalo_reg;
-    if ((opc & MO_SIZE) == MO_64) {
+    if (TCG_TARGET_REG_BITS == 32 && (opc & MO_SIZE) == MO_64) {
         /* We eliminated V0 from the possible output registers, so it
            cannot be clobbered here.  So we must move V1 first.  */
         if (MIPS_BE) {
@@ -1312,7 +1342,12 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     reloc_pc16(s->code_ptr, l->raddr);
     tcg_out_opc_br(s, OPC_BEQ, TCG_REG_ZERO, TCG_REG_ZERO);
     /* delay slot */
-    tcg_out_mov(s, TCG_TYPE_REG, v0, TCG_REG_V0);
+    if (TCG_TARGET_REG_BITS == 64 && l->type == TCG_TYPE_I32) {
+        /* we always sign-extend 32-bit loads */
+        tcg_out_opc_sa(s, OPC_SLL, v0, TCG_REG_V0, 0);
+    } else {
+        tcg_out_opc_reg(s, OPC_OR, v0, TCG_REG_V0, TCG_REG_ZERO);
+    }
 }
 
 static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
@@ -1324,12 +1359,12 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 
     /* resolve label address */
     reloc_pc16(l->label_ptr[0], s->code_ptr);
-    if (TARGET_LONG_BITS == 64) {
+    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
         reloc_pc16(l->label_ptr[1], s->code_ptr);
     }
 
     i = 1;
-    if (TARGET_LONG_BITS == 64) {
+    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
         i = tcg_out_call_iarg_reg2(s, i, l->addrlo_reg, l->addrhi_reg);
     } else {
         i = tcg_out_call_iarg_reg(s, i, l->addrlo_reg);
@@ -1345,7 +1380,11 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
         i = tcg_out_call_iarg_reg(s, i, l->datalo_reg);
         break;
     case MO_64:
-        i = tcg_out_call_iarg_reg2(s, i, l->datalo_reg, l->datahi_reg);
+        if (TCG_TARGET_REG_BITS == 32) {
+            i = tcg_out_call_iarg_reg2(s, i, l->datalo_reg, l->datahi_reg);
+        } else {
+            i = tcg_out_call_iarg_reg(s, i, l->datalo_reg);
+        }
         break;
     default:
         tcg_abort();
@@ -1363,7 +1402,7 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 #endif
 
 static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg lo, TCGReg hi,
-                                   TCGReg base, TCGMemOp opc)
+                                   TCGReg base, TCGMemOp opc, bool is_64)
 {
     switch (opc & (MO_SSIZE | MO_BSWAP)) {
     case MO_UB:
@@ -1387,6 +1426,20 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg lo, TCGReg hi,
         tcg_out_opc_imm(s, OPC_LH, lo, base, 0);
         break;
     case MO_UL | MO_BSWAP:
+        if (TCG_TARGET_REG_BITS == 64 && is_64) {
+            if (use_mips32r2_instructions) {
+                tcg_out_opc_imm(s, OPC_LWU, lo, base, 0);
+                tcg_out_bswap32u(s, lo, lo);
+            } else {
+                tcg_out_bswap_subr(s, bswap32u_addr);
+                /* delay slot */
+                tcg_out_opc_imm(s, OPC_LWU, TCG_TMP0, base, 0);
+                tcg_out_mov(s, TCG_TYPE_I64, lo, TCG_TMP3);
+            }
+            break;
+        }
+        /* FALLTHRU */
+    case MO_SL | MO_BSWAP:
         if (use_mips32r2_instructions) {
             tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
             tcg_out_bswap32(s, lo, lo);
@@ -1398,10 +1451,26 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg lo, TCGReg hi,
         }
         break;
     case MO_UL:
+        if (TCG_TARGET_REG_BITS == 64 && is_64) {
+            tcg_out_opc_imm(s, OPC_LWU, lo, base, 0);
+            break;
+        }
+        /* FALLTHRU */
+    case MO_SL:
         tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
         break;
     case MO_Q | MO_BSWAP:
-        if (use_mips32r2_instructions) {
+        if (TCG_TARGET_REG_BITS == 64) {
+            if (use_mips32r2_instructions) {
+                tcg_out_opc_imm(s, OPC_LD, lo, base, 0);
+                tcg_out_bswap64(s, lo, lo);
+            } else {
+                tcg_out_bswap_subr(s, bswap64_addr);
+                /* delay slot */
+                tcg_out_opc_imm(s, OPC_LD, TCG_TMP0, base, 0);
+                tcg_out_mov(s, TCG_TYPE_I64, lo, TCG_TMP3);
+            }
+        } else if (use_mips32r2_instructions) {
             tcg_out_opc_imm(s, OPC_LW, TCG_TMP0, base, 0);
             tcg_out_opc_imm(s, OPC_LW, TCG_TMP1, base, 4);
             tcg_out_opc_reg(s, OPC_WSBH, TCG_TMP0, 0, TCG_TMP0);
@@ -1421,7 +1490,9 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg lo, TCGReg hi,
         break;
     case MO_Q:
         /* Prefer to load from offset 0 first, but allow for overlap.  */
-        if (MIPS_BE ? hi != base : lo == base) {
+        if (TCG_TARGET_REG_BITS == 64) {
+            tcg_out_opc_imm(s, OPC_LD, lo, base, 0);
+        } else if (MIPS_BE ? hi != base : lo == base) {
             tcg_out_opc_imm(s, OPC_LW, hi, base, HI_OFF);
             tcg_out_opc_imm(s, OPC_LW, lo, base, LO_OFF);
         } else {
@@ -1446,27 +1517,33 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is_64)
     TCGReg base = TCG_REG_A0;
 
     data_regl = *args++;
-    data_regh = (is_64 ? *args++ : 0);
+    data_regh = (TCG_TARGET_REG_BITS == 32 && is_64 ? *args++ : 0);
     addr_regl = *args++;
-    addr_regh = (TARGET_LONG_BITS == 64 ? *args++ : 0);
+    addr_regh = (TCG_TARGET_REG_BITS < TARGET_LONG_BITS ? *args++ : 0);
     oi = *args++;
     opc = get_memop(oi);
 
 #if defined(CONFIG_SOFTMMU)
     tcg_out_tlb_load(s, base, addr_regl, addr_regh, oi, label_ptr, 1);
-    tcg_out_qemu_ld_direct(s, data_regl, data_regh, base, opc);
-    add_qemu_ldst_label(s, 1, oi, data_regl, data_regh, addr_regl, addr_regh,
+    tcg_out_qemu_ld_direct(s, data_regl, data_regh, base, opc, is_64);
+    add_qemu_ldst_label(s, 1, oi,
+                        (is_64 ? TCG_TYPE_I64 : TCG_TYPE_I32),
+                        data_regl, data_regh, addr_regl, addr_regh,
                         s->code_ptr, label_ptr);
 #else
+    if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
+        tcg_out_ext32u(s, base, addr_regl);
+        addr_regl = base;
+    }
     if (guest_base == 0 && data_regl != addr_regl) {
         base = addr_regl;
     } else if (guest_base == (int16_t)guest_base) {
-        tcg_out_opc_imm(s, OPC_ADDIU, base, addr_regl, guest_base);
+        tcg_out_opc_imm(s, ALIAS_PADDI, base, addr_regl, guest_base);
     } else {
         tcg_out_movi(s, TCG_TYPE_PTR, base, guest_base);
-        tcg_out_opc_reg(s, OPC_ADDU, base, base, addr_regl);
+        tcg_out_opc_reg(s, ALIAS_PADD, base, base, addr_regl);
     }
-    tcg_out_qemu_ld_direct(s, data_regl, data_regh, base, opc);
+    tcg_out_qemu_ld_direct(s, data_regl, data_regh, base, opc, is_64);
 #endif
 }
 
@@ -1501,7 +1578,10 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg lo, TCGReg hi,
         break;
 
     case MO_64 | MO_BSWAP:
-        if (use_mips32r2_instructions) {
+        if (TCG_TARGET_REG_BITS == 64) {
+            tcg_out_bswap64(s, TCG_TMP3, lo);
+            tcg_out_opc_imm(s, OPC_SD, TCG_TMP3, base, 0);
+        } else if (use_mips32r2_instructions) {
             tcg_out_opc_reg(s, OPC_WSBH, TCG_TMP0, 0, MIPS_BE ? lo : hi);
             tcg_out_opc_reg(s, OPC_WSBH, TCG_TMP1, 0, MIPS_BE ? hi : lo);
             tcg_out_opc_sa(s, OPC_ROTR, TCG_TMP0, TCG_TMP0, 16);
@@ -1516,8 +1596,12 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg lo, TCGReg hi,
         }
         break;
     case MO_64:
-        tcg_out_opc_imm(s, OPC_SW, MIPS_BE ? hi : lo, base, 0);
-        tcg_out_opc_imm(s, OPC_SW, MIPS_BE ? lo : hi, base, 4);
+        if (TCG_TARGET_REG_BITS == 64) {
+            tcg_out_opc_imm(s, OPC_SD, lo, base, 0);
+        } else {
+            tcg_out_opc_imm(s, OPC_SW, MIPS_BE ? hi : lo, base, 0);
+            tcg_out_opc_imm(s, OPC_SW, MIPS_BE ? lo : hi, base, 4);
+        }
         break;
 
     default:
@@ -1537,27 +1621,32 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
     TCGReg base = TCG_REG_A0;
 
     data_regl = *args++;
-    data_regh = (is_64 ? *args++ : 0);
+    data_regh = (TCG_TARGET_REG_BITS == 32 && is_64 ? *args++ : 0);
     addr_regl = *args++;
-    addr_regh = (TARGET_LONG_BITS == 64 ? *args++ : 0);
+    addr_regh = (TCG_TARGET_REG_BITS < TARGET_LONG_BITS ? *args++ : 0);
     oi = *args++;
     opc = get_memop(oi);
 
 #if defined(CONFIG_SOFTMMU)
     tcg_out_tlb_load(s, base, addr_regl, addr_regh, oi, label_ptr, 0);
     tcg_out_qemu_st_direct(s, data_regl, data_regh, base, opc);
-    add_qemu_ldst_label(s, 0, oi, data_regl, data_regh, addr_regl, addr_regh,
+    add_qemu_ldst_label(s, 0, oi,
+                        (is_64 ? TCG_TYPE_I64 : TCG_TYPE_I32),
+                        data_regl, data_regh, addr_regl, addr_regh,
                         s->code_ptr, label_ptr);
 #else
+    base = TCG_REG_A0;
+    if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
+        tcg_out_ext32u(s, base, addr_regl);
+        addr_regl = base;
+    }
     if (guest_base == 0) {
         base = addr_regl;
+    } else if (guest_base == (int16_t)guest_base) {
+        tcg_out_opc_imm(s, ALIAS_PADDI, base, addr_regl, guest_base);
     } else {
-        if (guest_base == (int16_t)guest_base) {
-            tcg_out_opc_imm(s, OPC_ADDIU, base, addr_regl, guest_base);
-        } else {
-            tcg_out_movi(s, TCG_TYPE_PTR, base, guest_base);
-            tcg_out_opc_reg(s, OPC_ADDU, base, base, addr_regl);
-        }
+        tcg_out_movi(s, TCG_TYPE_PTR, base, guest_base);
+        tcg_out_opc_reg(s, ALIAS_PADD, base, base, addr_regl);
     }
     tcg_out_qemu_st_direct(s, data_regl, data_regh, base, opc);
 #endif
-- 
2.1.0
