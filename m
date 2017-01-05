Received: from eggs.gnu.org ([2001:4830:134:3::10]:41375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cP0QE-0000dL-L7
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 00:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cP0QB-0002Vt-TX
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 00:17:06 -0500
Received: from [114.242.206.163] (port=60311 helo=mail.loongson.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cP0QA-0002RY-NV
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 00:17:03 -0500
From: Jin Guojie <jinguojie@loongson.cn>
Date: Thu,  5 Jan 2017 12:57:46 +0800
Message-Id: <1483592275-4496-2-git-send-email-jinguojie@loongson.cn>
In-Reply-To: <1483592275-4496-1-git-send-email-jinguojie@loongson.cn>
References: <1483592275-4496-1-git-send-email-jinguojie@loongson.cn>
Subject: [Qemu-devel] [PATCH v6 RESEND 01/10] tcg-mips: Move bswap code to a
 subroutine
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

Without the mips32r2 instructions to perform swapping, bswap is quite large,
dominating the size of each reverse-endian qemu_ld/qemu_st operation.

Create a subroutine in the prologue block.  The subroutine requires extra
reserved registers (TCG_TMP[2, 3]).  Using these within qemu_ld means that
we need not place additional restrictions on the qemu_ld outputs.

Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: James Hogan <james.hogan@imgtec.com>
Tested-by: YunQiang Su <wzssyqa@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Jin Guojie <jinguojie@loongson.cn>
---
 tcg/mips/tcg-target.h     |   2 +-
 tcg/mips/tcg-target.inc.c | 207 ++++++++++++++++++++++++++++++----------------
 2 files changed, 139 insertions(+), 70 deletions(-)

diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 3aeac87..a6871fb 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -117,11 +117,11 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_muls2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muluh_i32        1
 #define TCG_TARGET_HAS_mulsh_i32        1
+#define TCG_TARGET_HAS_bswap32_i32      1
 
 /* optional instructions detected at runtime */
 #define TCG_TARGET_HAS_movcond_i32      use_movnz_instructions
 #define TCG_TARGET_HAS_bswap16_i32      use_mips32r2_instructions
-#define TCG_TARGET_HAS_bswap32_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_deposit_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index abce602..2b116ea 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -74,6 +74,8 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 
 #define TCG_TMP0  TCG_REG_AT
 #define TCG_TMP1  TCG_REG_T9
+#define TCG_TMP2  TCG_REG_T8
+#define TCG_TMP3  TCG_REG_T7
 
 /* check if we really need so many registers :P */
 static const int tcg_target_reg_alloc_order[] = {
@@ -122,6 +124,7 @@ static const TCGReg tcg_target_call_oarg_regs[2] = {
 };
 
 static tcg_insn_unit *tb_ret_addr;
+static tcg_insn_unit *bswap32_addr;
 
 static inline uint32_t reloc_pc16_val(tcg_insn_unit *pc, tcg_insn_unit *target)
 {
@@ -177,12 +180,7 @@ static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
         ct->ct |= TCG_CT_REG;
         tcg_regset_set(ct->u.regs, 0xffffffff);
         break;
-    case 'L': /* qemu_ld output arg constraint */
-        ct->ct |= TCG_CT_REG;
-        tcg_regset_set(ct->u.regs, 0xffffffff);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_V0);
-        break;
-    case 'l': /* qemu_ld input arg constraint */
+    case 'L': /* qemu_ld input arg constraint */
         ct->ct |= TCG_CT_REG;
         tcg_regset_set(ct->u.regs, 0xffffffff);
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_A0);
@@ -513,29 +511,22 @@ static inline void tcg_out_bswap16s(TCGContext *s, TCGReg ret, TCGReg arg)
     }
 }
 
-static inline void tcg_out_bswap32(TCGContext *s, TCGReg ret, TCGReg arg)
+static void tcg_out_bswap_subr(TCGContext *s, tcg_insn_unit *sub)
+{
+    bool ok = tcg_out_opc_jmp(s, OPC_JAL, sub);
+    tcg_debug_assert(ok);
+}
+
+static void tcg_out_bswap32(TCGContext *s, TCGReg ret, TCGReg arg)
 {
     if (use_mips32r2_instructions) {
         tcg_out_opc_reg(s, OPC_WSBH, ret, 0, arg);
         tcg_out_opc_sa(s, OPC_ROTR, ret, ret, 16);
     } else {
-        /* ret and arg must be different and can't be register at */
-        if (ret == arg || ret == TCG_TMP0 || arg == TCG_TMP0) {
-            tcg_abort();
-        }
-
-        tcg_out_opc_sa(s, OPC_SLL, ret, arg, 24);
-
-        tcg_out_opc_sa(s, OPC_SRL, TCG_TMP0, arg, 24);
-        tcg_out_opc_reg(s, OPC_OR, ret, ret, TCG_TMP0);
-
-        tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP0, arg, 0xff00);
-        tcg_out_opc_sa(s, OPC_SLL, TCG_TMP0, TCG_TMP0, 8);
-        tcg_out_opc_reg(s, OPC_OR, ret, ret, TCG_TMP0);
-
-        tcg_out_opc_sa(s, OPC_SRL, TCG_TMP0, arg, 8);
-        tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP0, TCG_TMP0, 0xff00);
-        tcg_out_opc_reg(s, OPC_OR, ret, ret, TCG_TMP0);
+        tcg_out_bswap_subr(s, bswap32_addr);
+        /* delay slot -- never omit the insn, like tcg_out_mov might.  */
+        tcg_out_opc_reg(s, OPC_OR, TCG_TMP0, arg, TCG_REG_ZERO);
+        tcg_out_mov(s, TCG_TYPE_I32, ret, TCG_TMP3);
     }
 }
 
@@ -1044,7 +1035,7 @@ static int tcg_out_call_iarg_reg2(TCGContext *s, int i, TCGReg al, TCGReg ah)
 }
 
 /* Perform the tlb comparison operation.  The complete host address is
-   placed in BASE.  Clobbers AT, T0, A0.  */
+   placed in BASE.  Clobbers TMP0, TMP1, A0.  */
 static void tcg_out_tlb_load(TCGContext *s, TCGReg base, TCGReg addrl,
                              TCGReg addrh, TCGMemOpIdx oi,
                              tcg_insn_unit *label_ptr[2], bool is_load)
@@ -1227,46 +1218,72 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 }
 #endif
 
-static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
+static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg lo, TCGReg hi,
                                    TCGReg base, TCGMemOp opc)
 {
     switch (opc & (MO_SSIZE | MO_BSWAP)) {
     case MO_UB:
-        tcg_out_opc_imm(s, OPC_LBU, datalo, base, 0);
+        tcg_out_opc_imm(s, OPC_LBU, lo, base, 0);
         break;
     case MO_SB:
-        tcg_out_opc_imm(s, OPC_LB, datalo, base, 0);
+        tcg_out_opc_imm(s, OPC_LB, lo, base, 0);
         break;
     case MO_UW | MO_BSWAP:
         tcg_out_opc_imm(s, OPC_LHU, TCG_TMP1, base, 0);
-        tcg_out_bswap16(s, datalo, TCG_TMP1);
+        tcg_out_bswap16(s, lo, TCG_TMP1);
         break;
     case MO_UW:
-        tcg_out_opc_imm(s, OPC_LHU, datalo, base, 0);
+        tcg_out_opc_imm(s, OPC_LHU, lo, base, 0);
         break;
     case MO_SW | MO_BSWAP:
         tcg_out_opc_imm(s, OPC_LHU, TCG_TMP1, base, 0);
-        tcg_out_bswap16s(s, datalo, TCG_TMP1);
+        tcg_out_bswap16s(s, lo, TCG_TMP1);
         break;
     case MO_SW:
-        tcg_out_opc_imm(s, OPC_LH, datalo, base, 0);
+        tcg_out_opc_imm(s, OPC_LH, lo, base, 0);
         break;
     case MO_UL | MO_BSWAP:
-        tcg_out_opc_imm(s, OPC_LW, TCG_TMP1, base, 0);
-        tcg_out_bswap32(s, datalo, TCG_TMP1);
+        if (use_mips32r2_instructions) {
+            tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
+            tcg_out_bswap32(s, lo, lo);
+        } else {
+            tcg_out_bswap_subr(s, bswap32_addr);
+            /* delay slot */
+            tcg_out_opc_imm(s, OPC_LW, TCG_TMP0, base, 0);
+            tcg_out_mov(s, TCG_TYPE_I32, lo, TCG_TMP3);
+        }
         break;
     case MO_UL:
-        tcg_out_opc_imm(s, OPC_LW, datalo, base, 0);
+        tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
         break;
     case MO_Q | MO_BSWAP:
-        tcg_out_opc_imm(s, OPC_LW, TCG_TMP1, base, HI_OFF);
-        tcg_out_bswap32(s, datalo, TCG_TMP1);
-        tcg_out_opc_imm(s, OPC_LW, TCG_TMP1, base, LO_OFF);
-        tcg_out_bswap32(s, datahi, TCG_TMP1);
+        if (use_mips32r2_instructions) {
+            tcg_out_opc_imm(s, OPC_LW, TCG_TMP0, base, 0);
+            tcg_out_opc_imm(s, OPC_LW, TCG_TMP1, base, 4);
+            tcg_out_opc_reg(s, OPC_WSBH, TCG_TMP0, 0, TCG_TMP0);
+            tcg_out_opc_reg(s, OPC_WSBH, TCG_TMP1, 0, TCG_TMP1);
+            tcg_out_opc_sa(s, OPC_ROTR, MIPS_BE ? lo : hi, TCG_TMP0, 16);
+            tcg_out_opc_sa(s, OPC_ROTR, MIPS_BE ? hi : lo, TCG_TMP1, 16);
+        } else {
+            tcg_out_bswap_subr(s, bswap32_addr);
+            /* delay slot */
+            tcg_out_opc_imm(s, OPC_LW, TCG_TMP0, base, 0);
+            tcg_out_opc_imm(s, OPC_LW, TCG_TMP0, base, 4);
+            tcg_out_bswap_subr(s, bswap32_addr);
+            /* delay slot */
+            tcg_out_mov(s, TCG_TYPE_I32, MIPS_BE ? lo : hi, TCG_TMP3);
+            tcg_out_mov(s, TCG_TYPE_I32, MIPS_BE ? hi : lo, TCG_TMP3);
+        }
         break;
     case MO_Q:
-        tcg_out_opc_imm(s, OPC_LW, datalo, base, LO_OFF);
-        tcg_out_opc_imm(s, OPC_LW, datahi, base, HI_OFF);
+        /* Prefer to load from offset 0 first, but allow for overlap.  */
+        if (MIPS_BE ? hi != base : lo == base) {
+            tcg_out_opc_imm(s, OPC_LW, hi, base, HI_OFF);
+            tcg_out_opc_imm(s, OPC_LW, lo, base, LO_OFF);
+        } else {
+            tcg_out_opc_imm(s, OPC_LW, lo, base, LO_OFF);
+            tcg_out_opc_imm(s, OPC_LW, hi, base, HI_OFF);
+        }
         break;
     default:
         tcg_abort();
@@ -1282,9 +1299,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is_64)
 #if defined(CONFIG_SOFTMMU)
     tcg_insn_unit *label_ptr[2];
 #endif
-    /* Note that we've eliminated V0 from the output registers,
-       so we won't overwrite the base register during loading.  */
-    TCGReg base = TCG_REG_V0;
+    TCGReg base = TCG_REG_A0;
 
     data_regl = *args++;
     data_regh = (is_64 ? *args++ : 0);
@@ -1311,40 +1326,54 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is_64)
 #endif
 }
 
-static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
+static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg lo, TCGReg hi,
                                    TCGReg base, TCGMemOp opc)
 {
+    /* Don't clutter the code below with checks to avoid bswapping ZERO.  */
+    if ((lo | hi) == 0) {
+        opc &= ~MO_BSWAP;
+    }
+
     switch (opc & (MO_SIZE | MO_BSWAP)) {
     case MO_8:
-        tcg_out_opc_imm(s, OPC_SB, datalo, base, 0);
+        tcg_out_opc_imm(s, OPC_SB, lo, base, 0);
         break;
 
     case MO_16 | MO_BSWAP:
-        tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP1, datalo, 0xffff);
+        tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP1, lo, 0xffff);
         tcg_out_bswap16(s, TCG_TMP1, TCG_TMP1);
-        datalo = TCG_TMP1;
+        lo = TCG_TMP1;
         /* FALLTHRU */
     case MO_16:
-        tcg_out_opc_imm(s, OPC_SH, datalo, base, 0);
+        tcg_out_opc_imm(s, OPC_SH, lo, base, 0);
         break;
 
     case MO_32 | MO_BSWAP:
-        tcg_out_bswap32(s, TCG_TMP1, datalo);
-        datalo = TCG_TMP1;
+        tcg_out_bswap32(s, TCG_TMP3, lo);
+        lo = TCG_TMP3;
         /* FALLTHRU */
     case MO_32:
-        tcg_out_opc_imm(s, OPC_SW, datalo, base, 0);
+        tcg_out_opc_imm(s, OPC_SW, lo, base, 0);
         break;
 
     case MO_64 | MO_BSWAP:
-        tcg_out_bswap32(s, TCG_TMP1, datalo);
-        tcg_out_opc_imm(s, OPC_SW, TCG_TMP1, base, HI_OFF);
-        tcg_out_bswap32(s, TCG_TMP1, datahi);
-        tcg_out_opc_imm(s, OPC_SW, TCG_TMP1, base, LO_OFF);
+        if (use_mips32r2_instructions) {
+            tcg_out_opc_reg(s, OPC_WSBH, TCG_TMP0, 0, MIPS_BE ? lo : hi);
+            tcg_out_opc_reg(s, OPC_WSBH, TCG_TMP1, 0, MIPS_BE ? hi : lo);
+            tcg_out_opc_sa(s, OPC_ROTR, TCG_TMP0, TCG_TMP0, 16);
+            tcg_out_opc_sa(s, OPC_ROTR, TCG_TMP1, TCG_TMP1, 16);
+            tcg_out_opc_imm(s, OPC_SW, TCG_TMP0, base, 0);
+            tcg_out_opc_imm(s, OPC_SW, TCG_TMP1, base, 4);
+        } else {
+            tcg_out_bswap32(s, TCG_TMP3, MIPS_BE ? lo : hi);
+            tcg_out_opc_imm(s, OPC_SW, TCG_TMP3, base, 0);
+            tcg_out_bswap32(s, TCG_TMP3, MIPS_BE ? hi : lo);
+            tcg_out_opc_imm(s, OPC_SW, TCG_TMP3, base, 4);
+        }
         break;
     case MO_64:
-        tcg_out_opc_imm(s, OPC_SW, datalo, base, LO_OFF);
-        tcg_out_opc_imm(s, OPC_SW, datahi, base, HI_OFF);
+        tcg_out_opc_imm(s, OPC_SW, MIPS_BE ? hi : lo, base, 0);
+        tcg_out_opc_imm(s, OPC_SW, MIPS_BE ? lo : hi, base, 4);
         break;
 
     default:
@@ -1355,12 +1384,13 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
 static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
 {
     TCGReg addr_regl, addr_regh __attribute__((unused));
-    TCGReg data_regl, data_regh, base;
+    TCGReg data_regl, data_regh;
     TCGMemOpIdx oi;
     TCGMemOp opc;
 #if defined(CONFIG_SOFTMMU)
     tcg_insn_unit *label_ptr[2];
 #endif
+    TCGReg base = TCG_REG_A0;
 
     data_regl = *args++;
     data_regh = (is_64 ? *args++ : 0);
@@ -1370,9 +1400,6 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
     opc = get_memop(oi);
 
 #if defined(CONFIG_SOFTMMU)
-    /* Note that we eliminated the helper's address argument,
-       so we can reuse that for the base.  */
-    base = (TARGET_LONG_BITS == 32 ? TCG_REG_A1 : TCG_REG_A2);
     tcg_out_tlb_load(s, base, addr_regl, addr_regh, oi, label_ptr, 0);
     tcg_out_qemu_st_direct(s, data_regl, data_regh, base, opc);
     add_qemu_ldst_label(s, 0, oi, data_regl, data_regh, addr_regl, addr_regh,
@@ -1381,7 +1408,6 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
     if (guest_base == 0) {
         base = addr_regl;
     } else {
-        base = TCG_REG_A0;
         if (guest_base == (int16_t)guest_base) {
             tcg_out_opc_imm(s, OPC_ADDIU, base, addr_regl, guest_base);
         } else {
@@ -1630,8 +1656,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_bswap32_i32:
-        tcg_out_opc_reg(s, OPC_WSBH, a0, 0, a1);
-        tcg_out_opc_sa(s, OPC_ROTR, a0, a0, 16);
+        tcg_out_bswap32(s, a0, a1);
         break;
 
     case INDEX_op_deposit_i32:
@@ -1751,14 +1776,14 @@ static const TCGTargetOpDef mips_op_defs[] = {
     { INDEX_op_brcond2_i32, { "rZ", "rZ", "rZ", "rZ" } },
 
 #if TARGET_LONG_BITS == 32
-    { INDEX_op_qemu_ld_i32, { "L", "lZ" } },
+    { INDEX_op_qemu_ld_i32, { "r", "LZ" } },
     { INDEX_op_qemu_st_i32, { "SZ", "SZ" } },
-    { INDEX_op_qemu_ld_i64, { "L", "L", "lZ" } },
+    { INDEX_op_qemu_ld_i64, { "r", "r", "LZ" } },
     { INDEX_op_qemu_st_i64, { "SZ", "SZ", "SZ" } },
 #else
-    { INDEX_op_qemu_ld_i32, { "L", "lZ", "lZ" } },
+    { INDEX_op_qemu_ld_i32, { "r", "LZ", "LZ" } },
     { INDEX_op_qemu_st_i32, { "SZ", "SZ", "SZ" } },
-    { INDEX_op_qemu_ld_i64, { "L", "L", "lZ", "lZ" } },
+    { INDEX_op_qemu_ld_i64, { "r", "r", "LZ", "LZ" } },
     { INDEX_op_qemu_st_i64, { "SZ", "SZ", "SZ", "SZ" } },
 #endif
 
@@ -1858,6 +1883,16 @@ static void tcg_target_detect_isa(void)
     sigaction(SIGILL, &sa_old, NULL);
 }
 
+static tcg_insn_unit *align_code_ptr(TCGContext *s)
+{
+    uintptr_t p = (uintptr_t)s->code_ptr;
+    if (p & 15) {
+        p = (p + 15) & -16;
+        s->code_ptr = (void *)p;
+    }
+    return s->code_ptr;
+}
+
 /* Generate global QEMU prologue and epilogue code */
 static void tcg_target_qemu_prologue(TCGContext *s)
 {
@@ -1892,7 +1927,39 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     }
 
     tcg_out_opc_reg(s, OPC_JR, 0, TCG_REG_RA, 0);
+    /* delay slot */
     tcg_out_addi(s, TCG_REG_SP, frame_size);
+
+    if (use_mips32r2_instructions) {
+        return;
+    }
+
+    /* Bswap subroutine: Input in TCG_TMP0, output in TCG_TMP3;
+       clobbers TCG_TMP1, TCG_TMP2.  */
+
+    /*
+     * bswap32 -- 32-bit swap (signed result for mips64).  a0 = abcd.
+     */
+    bswap32_addr = align_code_ptr(s);
+    /* t3 = (ssss)d000 */
+    tcg_out_opc_sa(s, OPC_SLL, TCG_TMP3, TCG_TMP0, 24);
+    /* t1 = 000a */
+    tcg_out_opc_sa(s, OPC_SRL, TCG_TMP1, TCG_TMP0, 24);
+    /* t2 = 00c0 */
+    tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP2, TCG_TMP0, 0xff00);
+    /* t3 = d00a */
+    tcg_out_opc_reg(s, OPC_OR, TCG_TMP3, TCG_TMP3, TCG_TMP1);
+    /* t1 = 0abc */
+    tcg_out_opc_sa(s, OPC_SRL, TCG_TMP1, TCG_TMP0, 8);
+    /* t2 = 0c00 */
+    tcg_out_opc_sa(s, OPC_SLL, TCG_TMP2, TCG_TMP2, 8);
+    /* t1 = 00b0 */
+    tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP1, TCG_TMP1, 0xff00);
+    /* t3 = dc0a */
+    tcg_out_opc_reg(s, OPC_OR, TCG_TMP3, TCG_TMP3, TCG_TMP2);
+    tcg_out_opc_reg(s, OPC_JR, 0, TCG_REG_RA, 0);
+    /* t3 = dcba -- delay slot */
+    tcg_out_opc_reg(s, OPC_OR, TCG_TMP3, TCG_TMP3, TCG_TMP1);
 }
 
 static void tcg_target_init(TCGContext *s)
@@ -1923,6 +1990,8 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_K1);   /* kernel use only */
     tcg_regset_set_reg(s->reserved_regs, TCG_TMP0);     /* internal use */
     tcg_regset_set_reg(s->reserved_regs, TCG_TMP1);     /* internal use */
+    tcg_regset_set_reg(s->reserved_regs, TCG_TMP2);     /* internal use */
+    tcg_regset_set_reg(s->reserved_regs, TCG_TMP3);     /* internal use */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_RA);   /* return address */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_SP);   /* stack pointer */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_GP);   /* global pointer */
-- 
2.1.0
