Received: from eggs.gnu.org ([2001:4830:134:3::10]:52332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5UF-0003Ge-II
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5U8-0008Li-TT
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:27 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:34083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq5U8-0008Kz-Kd
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:20 -0400
Received: by mail-pf0-x22a.google.com with SMTP id e1so1640981pfk.1
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 15:41:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 15:40:45 -0700
Message-Id: <20170907224051.21518-18-richard.henderson@linaro.org>
In-Reply-To: <20170907224051.21518-1-richard.henderson@linaro.org>
References: <20170907224051.21518-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 17/23] tcg/arm: Code rearrangement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Move constants before all of the functions.
Move tcg_out_<format> functions before all
of the others.  No functional change.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/arm/tcg-target.inc.c | 599 +++++++++++++++++++++++------------------------
 1 file changed, 299 insertions(+), 300 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 6c12b169ce..f40e87066f 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -85,6 +85,97 @@ static const int tcg_target_call_oarg_regs[2] = {
 
 #define TCG_REG_TMP  TCG_REG_R12
 
+enum arm_cond_code_e {
+    COND_EQ = 0x0,
+    COND_NE = 0x1,
+    COND_CS = 0x2,	/* Unsigned greater or equal */
+    COND_CC = 0x3,	/* Unsigned less than */
+    COND_MI = 0x4,	/* Negative */
+    COND_PL = 0x5,	/* Zero or greater */
+    COND_VS = 0x6,	/* Overflow */
+    COND_VC = 0x7,	/* No overflow */
+    COND_HI = 0x8,	/* Unsigned greater than */
+    COND_LS = 0x9,	/* Unsigned less or equal */
+    COND_GE = 0xa,
+    COND_LT = 0xb,
+    COND_GT = 0xc,
+    COND_LE = 0xd,
+    COND_AL = 0xe,
+};
+
+#define TO_CPSR (1 << 20)
+
+#define SHIFT_IMM_LSL(im)	(((im) << 7) | 0x00)
+#define SHIFT_IMM_LSR(im)	(((im) << 7) | 0x20)
+#define SHIFT_IMM_ASR(im)	(((im) << 7) | 0x40)
+#define SHIFT_IMM_ROR(im)	(((im) << 7) | 0x60)
+#define SHIFT_REG_LSL(rs)	(((rs) << 8) | 0x10)
+#define SHIFT_REG_LSR(rs)	(((rs) << 8) | 0x30)
+#define SHIFT_REG_ASR(rs)	(((rs) << 8) | 0x50)
+#define SHIFT_REG_ROR(rs)	(((rs) << 8) | 0x70)
+
+typedef enum {
+    ARITH_AND = 0x0 << 21,
+    ARITH_EOR = 0x1 << 21,
+    ARITH_SUB = 0x2 << 21,
+    ARITH_RSB = 0x3 << 21,
+    ARITH_ADD = 0x4 << 21,
+    ARITH_ADC = 0x5 << 21,
+    ARITH_SBC = 0x6 << 21,
+    ARITH_RSC = 0x7 << 21,
+    ARITH_TST = 0x8 << 21 | TO_CPSR,
+    ARITH_CMP = 0xa << 21 | TO_CPSR,
+    ARITH_CMN = 0xb << 21 | TO_CPSR,
+    ARITH_ORR = 0xc << 21,
+    ARITH_MOV = 0xd << 21,
+    ARITH_BIC = 0xe << 21,
+    ARITH_MVN = 0xf << 21,
+
+    INSN_CLZ       = 0x016f0f10,
+    INSN_RBIT      = 0x06ff0f30,
+
+    INSN_LDR_IMM   = 0x04100000,
+    INSN_LDR_REG   = 0x06100000,
+    INSN_STR_IMM   = 0x04000000,
+    INSN_STR_REG   = 0x06000000,
+
+    INSN_LDRH_IMM  = 0x005000b0,
+    INSN_LDRH_REG  = 0x001000b0,
+    INSN_LDRSH_IMM = 0x005000f0,
+    INSN_LDRSH_REG = 0x001000f0,
+    INSN_STRH_IMM  = 0x004000b0,
+    INSN_STRH_REG  = 0x000000b0,
+
+    INSN_LDRB_IMM  = 0x04500000,
+    INSN_LDRB_REG  = 0x06500000,
+    INSN_LDRSB_IMM = 0x005000d0,
+    INSN_LDRSB_REG = 0x001000d0,
+    INSN_STRB_IMM  = 0x04400000,
+    INSN_STRB_REG  = 0x06400000,
+
+    INSN_LDRD_IMM  = 0x004000d0,
+    INSN_LDRD_REG  = 0x000000d0,
+    INSN_STRD_IMM  = 0x004000f0,
+    INSN_STRD_REG  = 0x000000f0,
+
+    INSN_DMB_ISH   = 0x5bf07ff5,
+    INSN_DMB_MCR   = 0xba0f07ee,
+} ARMInsn;
+
+static const uint8_t tcg_cond_to_arm_cond[] = {
+    [TCG_COND_EQ] = COND_EQ,
+    [TCG_COND_NE] = COND_NE,
+    [TCG_COND_LT] = COND_LT,
+    [TCG_COND_GE] = COND_GE,
+    [TCG_COND_LE] = COND_LE,
+    [TCG_COND_GT] = COND_GT,
+    /* unsigned */
+    [TCG_COND_LTU] = COND_CC,
+    [TCG_COND_GEU] = COND_CS,
+    [TCG_COND_LEU] = COND_LS,
+    [TCG_COND_GTU] = COND_HI,
+};
+
 static inline void reloc_pc24(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
 {
     ptrdiff_t offset = (tcg_ptr_byte_diff(target, code_ptr) - 8) >> 2;
@@ -236,183 +327,257 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
     }
 }
 
-#define TO_CPSR (1 << 20)
+static inline void tcg_out_b(TCGContext *s, int cond, int32_t offset)
+{
+    tcg_out32(s, (cond << 28) | 0x0a000000 |
+                    (((offset - 8) >> 2) & 0x00ffffff));
+}
 
-typedef enum {
-    ARITH_AND = 0x0 << 21,
-    ARITH_EOR = 0x1 << 21,
-    ARITH_SUB = 0x2 << 21,
-    ARITH_RSB = 0x3 << 21,
-    ARITH_ADD = 0x4 << 21,
-    ARITH_ADC = 0x5 << 21,
-    ARITH_SBC = 0x6 << 21,
-    ARITH_RSC = 0x7 << 21,
-    ARITH_TST = 0x8 << 21 | TO_CPSR,
-    ARITH_CMP = 0xa << 21 | TO_CPSR,
-    ARITH_CMN = 0xb << 21 | TO_CPSR,
-    ARITH_ORR = 0xc << 21,
-    ARITH_MOV = 0xd << 21,
-    ARITH_BIC = 0xe << 21,
-    ARITH_MVN = 0xf << 21,
+static inline void tcg_out_b_noaddr(TCGContext *s, int cond)
+{
+    /* We pay attention here to not modify the branch target by masking
+       the corresponding bytes.  This ensure that caches and memory are
+       kept coherent during retranslation. */
+    tcg_out32(s, deposit32(*s->code_ptr, 24, 8, (cond << 4) | 0x0a));
+}
 
-    INSN_CLZ       = 0x016f0f10,
-    INSN_RBIT      = 0x06ff0f30,
+static inline void tcg_out_bl_noaddr(TCGContext *s, int cond)
+{
+    /* We pay attention here to not modify the branch target by masking
+       the corresponding bytes.  This ensure that caches and memory are
+       kept coherent during retranslation. */
+    tcg_out32(s, deposit32(*s->code_ptr, 24, 8, (cond << 4) | 0x0b));
+}
 
-    INSN_LDR_IMM   = 0x04100000,
-    INSN_LDR_REG   = 0x06100000,
-    INSN_STR_IMM   = 0x04000000,
-    INSN_STR_REG   = 0x06000000,
+static inline void tcg_out_bl(TCGContext *s, int cond, int32_t offset)
+{
+    tcg_out32(s, (cond << 28) | 0x0b000000 |
+                    (((offset - 8) >> 2) & 0x00ffffff));
+}
 
-    INSN_LDRH_IMM  = 0x005000b0,
-    INSN_LDRH_REG  = 0x001000b0,
-    INSN_LDRSH_IMM = 0x005000f0,
-    INSN_LDRSH_REG = 0x001000f0,
-    INSN_STRH_IMM  = 0x004000b0,
-    INSN_STRH_REG  = 0x000000b0,
+static inline void tcg_out_blx(TCGContext *s, int cond, int rn)
+{
+    tcg_out32(s, (cond << 28) | 0x012fff30 | rn);
+}
 
-    INSN_LDRB_IMM  = 0x04500000,
-    INSN_LDRB_REG  = 0x06500000,
-    INSN_LDRSB_IMM = 0x005000d0,
-    INSN_LDRSB_REG = 0x001000d0,
-    INSN_STRB_IMM  = 0x04400000,
-    INSN_STRB_REG  = 0x06400000,
+static inline void tcg_out_blx_imm(TCGContext *s, int32_t offset)
+{
+    tcg_out32(s, 0xfa000000 | ((offset & 2) << 23) |
+                (((offset - 8) >> 2) & 0x00ffffff));
+}
 
-    INSN_LDRD_IMM  = 0x004000d0,
-    INSN_LDRD_REG  = 0x000000d0,
-    INSN_STRD_IMM  = 0x004000f0,
-    INSN_STRD_REG  = 0x000000f0,
+static inline void tcg_out_dat_reg(TCGContext *s,
+                int cond, int opc, int rd, int rn, int rm, int shift)
+{
+    tcg_out32(s, (cond << 28) | (0 << 25) | opc |
+                    (rn << 16) | (rd << 12) | shift | rm);
+}
 
-    INSN_DMB_ISH   = 0x5bf07ff5,
-    INSN_DMB_MCR   = 0xba0f07ee,
+static inline void tcg_out_nop(TCGContext *s)
+{
+    if (use_armv7_instructions) {
+        /* Architected nop introduced in v6k.  */
+        /* ??? This is an MSR (imm) 0,0,0 insn.  Anyone know if this
+           also Just So Happened to do nothing on pre-v6k so that we
+           don't need to conditionalize it?  */
+        tcg_out32(s, 0xe320f000);
+    } else {
+        /* Prior to that the assembler uses mov r0, r0.  */
+        tcg_out_dat_reg(s, COND_AL, ARITH_MOV, 0, 0, 0, SHIFT_IMM_LSL(0));
+    }
+}
 
-} ARMInsn;
+static inline void tcg_out_mov_reg(TCGContext *s, int cond, int rd, int rm)
+{
+    /* Simple reg-reg move, optimising out the 'do nothing' case */
+    if (rd != rm) {
+        tcg_out_dat_reg(s, cond, ARITH_MOV, rd, 0, rm, SHIFT_IMM_LSL(0));
+    }
+}
 
-#define SHIFT_IMM_LSL(im)	(((im) << 7) | 0x00)
-#define SHIFT_IMM_LSR(im)	(((im) << 7) | 0x20)
-#define SHIFT_IMM_ASR(im)	(((im) << 7) | 0x40)
-#define SHIFT_IMM_ROR(im)	(((im) << 7) | 0x60)
-#define SHIFT_REG_LSL(rs)	(((rs) << 8) | 0x10)
-#define SHIFT_REG_LSR(rs)	(((rs) << 8) | 0x30)
-#define SHIFT_REG_ASR(rs)	(((rs) << 8) | 0x50)
-#define SHIFT_REG_ROR(rs)	(((rs) << 8) | 0x70)
+static inline void tcg_out_bx(TCGContext *s, int cond, TCGReg rn)
+{
+    /* Unless the C portion of QEMU is compiled as thumb, we don't
+       actually need true BX semantics; merely a branch to an address
+       held in a register.  */
+    if (use_armv5t_instructions) {
+        tcg_out32(s, (cond << 28) | 0x012fff10 | rn);
+    } else {
+        tcg_out_mov_reg(s, cond, TCG_REG_PC, rn);
+    }
+}
 
-enum arm_cond_code_e {
-    COND_EQ = 0x0,
-    COND_NE = 0x1,
-    COND_CS = 0x2,	/* Unsigned greater or equal */
-    COND_CC = 0x3,	/* Unsigned less than */
-    COND_MI = 0x4,	/* Negative */
-    COND_PL = 0x5,	/* Zero or greater */
-    COND_VS = 0x6,	/* Overflow */
-    COND_VC = 0x7,	/* No overflow */
-    COND_HI = 0x8,	/* Unsigned greater than */
-    COND_LS = 0x9,	/* Unsigned less or equal */
-    COND_GE = 0xa,
-    COND_LT = 0xb,
-    COND_GT = 0xc,
-    COND_LE = 0xd,
-    COND_AL = 0xe,
-};
+static inline void tcg_out_dat_imm(TCGContext *s,
+                int cond, int opc, int rd, int rn, int im)
+{
+    tcg_out32(s, (cond << 28) | (1 << 25) | opc |
+                    (rn << 16) | (rd << 12) | im);
+}
 
-static const uint8_t tcg_cond_to_arm_cond[] = {
-    [TCG_COND_EQ] = COND_EQ,
-    [TCG_COND_NE] = COND_NE,
-    [TCG_COND_LT] = COND_LT,
-    [TCG_COND_GE] = COND_GE,
-    [TCG_COND_LE] = COND_LE,
-    [TCG_COND_GT] = COND_GT,
-    /* unsigned */
-    [TCG_COND_LTU] = COND_CC,
-    [TCG_COND_GEU] = COND_CS,
-    [TCG_COND_LEU] = COND_LS,
-    [TCG_COND_GTU] = COND_HI,
-};
+/* Note that this routine is used for both LDR and LDRH formats, so we do
+   not wish to include an immediate shift at this point.  */
+static void tcg_out_memop_r(TCGContext *s, int cond, ARMInsn opc, TCGReg rt,
+                            TCGReg rn, TCGReg rm, bool u, bool p, bool w)
+{
+    tcg_out32(s, (cond << 28) | opc | (u << 23) | (p << 24)
+              | (w << 21) | (rn << 16) | (rt << 12) | rm);
+}
+
+static void tcg_out_memop_8(TCGContext *s, int cond, ARMInsn opc, TCGReg rt,
+                            TCGReg rn, int imm8, bool p, bool w)
+{
+    bool u = 1;
+    if (imm8 < 0) {
+        imm8 = -imm8;
+        u = 0;
+    }
+    tcg_out32(s, (cond << 28) | opc | (u << 23) | (p << 24) | (w << 21) |
+              (rn << 16) | (rt << 12) | ((imm8 & 0xf0) << 4) | (imm8 & 0xf));
+}
+
+static void tcg_out_memop_12(TCGContext *s, int cond, ARMInsn opc, TCGReg rt,
+                             TCGReg rn, int imm12, bool p, bool w)
+{
+    bool u = 1;
+    if (imm12 < 0) {
+        imm12 = -imm12;
+        u = 0;
+    }
+    tcg_out32(s, (cond << 28) | opc | (u << 23) | (p << 24) | (w << 21) |
+              (rn << 16) | (rt << 12) | imm12);
+}
+
+static inline void tcg_out_ld32_12(TCGContext *s, int cond, TCGReg rt,
+                                   TCGReg rn, int imm12)
+{
+    tcg_out_memop_12(s, cond, INSN_LDR_IMM, rt, rn, imm12, 1, 0);
+}
+
+static inline void tcg_out_st32_12(TCGContext *s, int cond, TCGReg rt,
+                                   TCGReg rn, int imm12)
+{
+    tcg_out_memop_12(s, cond, INSN_STR_IMM, rt, rn, imm12, 1, 0);
+}
+
+static inline void tcg_out_ld32_r(TCGContext *s, int cond, TCGReg rt,
+                                  TCGReg rn, TCGReg rm)
+{
+    tcg_out_memop_r(s, cond, INSN_LDR_REG, rt, rn, rm, 1, 1, 0);
+}
+
+static inline void tcg_out_st32_r(TCGContext *s, int cond, TCGReg rt,
+                                  TCGReg rn, TCGReg rm)
+{
+    tcg_out_memop_r(s, cond, INSN_STR_REG, rt, rn, rm, 1, 1, 0);
+}
+
+static inline void tcg_out_ldrd_8(TCGContext *s, int cond, TCGReg rt,
+                                   TCGReg rn, int imm8)
+{
+    tcg_out_memop_8(s, cond, INSN_LDRD_IMM, rt, rn, imm8, 1, 0);
+}
+
+static inline void tcg_out_ldrd_r(TCGContext *s, int cond, TCGReg rt,
+                                  TCGReg rn, TCGReg rm)
+{
+    tcg_out_memop_r(s, cond, INSN_LDRD_REG, rt, rn, rm, 1, 1, 0);
+}
+
+static inline void tcg_out_strd_8(TCGContext *s, int cond, TCGReg rt,
+                                   TCGReg rn, int imm8)
+{
+    tcg_out_memop_8(s, cond, INSN_STRD_IMM, rt, rn, imm8, 1, 0);
+}
+
+static inline void tcg_out_strd_r(TCGContext *s, int cond, TCGReg rt,
+                                  TCGReg rn, TCGReg rm)
+{
+    tcg_out_memop_r(s, cond, INSN_STRD_REG, rt, rn, rm, 1, 1, 0);
+}
+
+/* Register pre-increment with base writeback.  */
+static inline void tcg_out_ld32_rwb(TCGContext *s, int cond, TCGReg rt,
+                                    TCGReg rn, TCGReg rm)
+{
+    tcg_out_memop_r(s, cond, INSN_LDR_REG, rt, rn, rm, 1, 1, 1);
+}
+
+static inline void tcg_out_st32_rwb(TCGContext *s, int cond, TCGReg rt,
+                                    TCGReg rn, TCGReg rm)
+{
+    tcg_out_memop_r(s, cond, INSN_STR_REG, rt, rn, rm, 1, 1, 1);
+}
+
+static inline void tcg_out_ld16u_8(TCGContext *s, int cond, TCGReg rt,
+                                   TCGReg rn, int imm8)
+{
+    tcg_out_memop_8(s, cond, INSN_LDRH_IMM, rt, rn, imm8, 1, 0);
+}
 
-static inline void tcg_out_b(TCGContext *s, int cond, int32_t offset)
+static inline void tcg_out_st16_8(TCGContext *s, int cond, TCGReg rt,
+                                  TCGReg rn, int imm8)
 {
-    tcg_out32(s, (cond << 28) | 0x0a000000 |
-                    (((offset - 8) >> 2) & 0x00ffffff));
+    tcg_out_memop_8(s, cond, INSN_STRH_IMM, rt, rn, imm8, 1, 0);
 }
 
-static inline void tcg_out_b_noaddr(TCGContext *s, int cond)
+static inline void tcg_out_ld16u_r(TCGContext *s, int cond, TCGReg rt,
+                                   TCGReg rn, TCGReg rm)
 {
-    /* We pay attention here to not modify the branch target by masking
-       the corresponding bytes.  This ensure that caches and memory are
-       kept coherent during retranslation. */
-    tcg_out32(s, deposit32(*s->code_ptr, 24, 8, (cond << 4) | 0x0a));
+    tcg_out_memop_r(s, cond, INSN_LDRH_REG, rt, rn, rm, 1, 1, 0);
 }
 
-static inline void tcg_out_bl_noaddr(TCGContext *s, int cond)
+static inline void tcg_out_st16_r(TCGContext *s, int cond, TCGReg rt,
+                                  TCGReg rn, TCGReg rm)
 {
-    /* We pay attention here to not modify the branch target by masking
-       the corresponding bytes.  This ensure that caches and memory are
-       kept coherent during retranslation. */
-    tcg_out32(s, deposit32(*s->code_ptr, 24, 8, (cond << 4) | 0x0b));
+    tcg_out_memop_r(s, cond, INSN_STRH_REG, rt, rn, rm, 1, 1, 0);
 }
 
-static inline void tcg_out_bl(TCGContext *s, int cond, int32_t offset)
+static inline void tcg_out_ld16s_8(TCGContext *s, int cond, TCGReg rt,
+                                   TCGReg rn, int imm8)
 {
-    tcg_out32(s, (cond << 28) | 0x0b000000 |
-                    (((offset - 8) >> 2) & 0x00ffffff));
+    tcg_out_memop_8(s, cond, INSN_LDRSH_IMM, rt, rn, imm8, 1, 0);
 }
 
-static inline void tcg_out_blx(TCGContext *s, int cond, int rn)
+static inline void tcg_out_ld16s_r(TCGContext *s, int cond, TCGReg rt,
+                                   TCGReg rn, TCGReg rm)
 {
-    tcg_out32(s, (cond << 28) | 0x012fff30 | rn);
+    tcg_out_memop_r(s, cond, INSN_LDRSH_REG, rt, rn, rm, 1, 1, 0);
 }
 
-static inline void tcg_out_blx_imm(TCGContext *s, int32_t offset)
+static inline void tcg_out_ld8_12(TCGContext *s, int cond, TCGReg rt,
+                                  TCGReg rn, int imm12)
 {
-    tcg_out32(s, 0xfa000000 | ((offset & 2) << 23) |
-                (((offset - 8) >> 2) & 0x00ffffff));
+    tcg_out_memop_12(s, cond, INSN_LDRB_IMM, rt, rn, imm12, 1, 0);
 }
 
-static inline void tcg_out_dat_reg(TCGContext *s,
-                int cond, int opc, int rd, int rn, int rm, int shift)
+static inline void tcg_out_st8_12(TCGContext *s, int cond, TCGReg rt,
+                                  TCGReg rn, int imm12)
 {
-    tcg_out32(s, (cond << 28) | (0 << 25) | opc |
-                    (rn << 16) | (rd << 12) | shift | rm);
+    tcg_out_memop_12(s, cond, INSN_STRB_IMM, rt, rn, imm12, 1, 0);
 }
 
-static inline void tcg_out_nop(TCGContext *s)
+static inline void tcg_out_ld8_r(TCGContext *s, int cond, TCGReg rt,
+                                 TCGReg rn, TCGReg rm)
 {
-    if (use_armv7_instructions) {
-        /* Architected nop introduced in v6k.  */
-        /* ??? This is an MSR (imm) 0,0,0 insn.  Anyone know if this
-           also Just So Happened to do nothing on pre-v6k so that we
-           don't need to conditionalize it?  */
-        tcg_out32(s, 0xe320f000);
-    } else {
-        /* Prior to that the assembler uses mov r0, r0.  */
-        tcg_out_dat_reg(s, COND_AL, ARITH_MOV, 0, 0, 0, SHIFT_IMM_LSL(0));
-    }
+    tcg_out_memop_r(s, cond, INSN_LDRB_REG, rt, rn, rm, 1, 1, 0);
 }
 
-static inline void tcg_out_mov_reg(TCGContext *s, int cond, int rd, int rm)
+static inline void tcg_out_st8_r(TCGContext *s, int cond, TCGReg rt,
+                                 TCGReg rn, TCGReg rm)
 {
-    /* Simple reg-reg move, optimising out the 'do nothing' case */
-    if (rd != rm) {
-        tcg_out_dat_reg(s, cond, ARITH_MOV, rd, 0, rm, SHIFT_IMM_LSL(0));
-    }
+    tcg_out_memop_r(s, cond, INSN_STRB_REG, rt, rn, rm, 1, 1, 0);
 }
 
-static inline void tcg_out_bx(TCGContext *s, int cond, TCGReg rn)
+static inline void tcg_out_ld8s_8(TCGContext *s, int cond, TCGReg rt,
+                                  TCGReg rn, int imm8)
 {
-    /* Unless the C portion of QEMU is compiled as thumb, we don't
-       actually need true BX semantics; merely a branch to an address
-       held in a register.  */
-    if (use_armv5t_instructions) {
-        tcg_out32(s, (cond << 28) | 0x012fff10 | rn);
-    } else {
-        tcg_out_mov_reg(s, cond, TCG_REG_PC, rn);
-    }
+    tcg_out_memop_8(s, cond, INSN_LDRSB_IMM, rt, rn, imm8, 1, 0);
 }
 
-static inline void tcg_out_dat_imm(TCGContext *s,
-                int cond, int opc, int rd, int rn, int im)
+static inline void tcg_out_ld8s_r(TCGContext *s, int cond, TCGReg rt,
+                                  TCGReg rn, TCGReg rm)
 {
-    tcg_out32(s, (cond << 28) | (1 << 25) | opc |
-                    (rn << 16) | (rd << 12) | im);
+    tcg_out_memop_r(s, cond, INSN_LDRSB_REG, rt, rn, rm, 1, 1, 0);
 }
 
 static void tcg_out_movi32(TCGContext *s, int cond, int rd, uint32_t arg)
@@ -747,172 +912,6 @@ static inline void tcg_out_sextract(TCGContext *s, int cond, TCGReg rd,
               | (ofs << 7) | ((len - 1) << 16));
 }
 
-/* Note that this routine is used for both LDR and LDRH formats, so we do
-   not wish to include an immediate shift at this point.  */
-static void tcg_out_memop_r(TCGContext *s, int cond, ARMInsn opc, TCGReg rt,
-                            TCGReg rn, TCGReg rm, bool u, bool p, bool w)
-{
-    tcg_out32(s, (cond << 28) | opc | (u << 23) | (p << 24)
-              | (w << 21) | (rn << 16) | (rt << 12) | rm);
-}
-
-static void tcg_out_memop_8(TCGContext *s, int cond, ARMInsn opc, TCGReg rt,
-                            TCGReg rn, int imm8, bool p, bool w)
-{
-    bool u = 1;
-    if (imm8 < 0) {
-        imm8 = -imm8;
-        u = 0;
-    }
-    tcg_out32(s, (cond << 28) | opc | (u << 23) | (p << 24) | (w << 21) |
-              (rn << 16) | (rt << 12) | ((imm8 & 0xf0) << 4) | (imm8 & 0xf));
-}
-
-static void tcg_out_memop_12(TCGContext *s, int cond, ARMInsn opc, TCGReg rt,
-                             TCGReg rn, int imm12, bool p, bool w)
-{
-    bool u = 1;
-    if (imm12 < 0) {
-        imm12 = -imm12;
-        u = 0;
-    }
-    tcg_out32(s, (cond << 28) | opc | (u << 23) | (p << 24) | (w << 21) |
-              (rn << 16) | (rt << 12) | imm12);
-}
-
-static inline void tcg_out_ld32_12(TCGContext *s, int cond, TCGReg rt,
-                                   TCGReg rn, int imm12)
-{
-    tcg_out_memop_12(s, cond, INSN_LDR_IMM, rt, rn, imm12, 1, 0);
-}
-
-static inline void tcg_out_st32_12(TCGContext *s, int cond, TCGReg rt,
-                                   TCGReg rn, int imm12)
-{
-    tcg_out_memop_12(s, cond, INSN_STR_IMM, rt, rn, imm12, 1, 0);
-}
-
-static inline void tcg_out_ld32_r(TCGContext *s, int cond, TCGReg rt,
-                                  TCGReg rn, TCGReg rm)
-{
-    tcg_out_memop_r(s, cond, INSN_LDR_REG, rt, rn, rm, 1, 1, 0);
-}
-
-static inline void tcg_out_st32_r(TCGContext *s, int cond, TCGReg rt,
-                                  TCGReg rn, TCGReg rm)
-{
-    tcg_out_memop_r(s, cond, INSN_STR_REG, rt, rn, rm, 1, 1, 0);
-}
-
-static inline void tcg_out_ldrd_8(TCGContext *s, int cond, TCGReg rt,
-                                   TCGReg rn, int imm8)
-{
-    tcg_out_memop_8(s, cond, INSN_LDRD_IMM, rt, rn, imm8, 1, 0);
-}
-
-static inline void tcg_out_ldrd_r(TCGContext *s, int cond, TCGReg rt,
-                                  TCGReg rn, TCGReg rm)
-{
-    tcg_out_memop_r(s, cond, INSN_LDRD_REG, rt, rn, rm, 1, 1, 0);
-}
-
-static inline void tcg_out_strd_8(TCGContext *s, int cond, TCGReg rt,
-                                   TCGReg rn, int imm8)
-{
-    tcg_out_memop_8(s, cond, INSN_STRD_IMM, rt, rn, imm8, 1, 0);
-}
-
-static inline void tcg_out_strd_r(TCGContext *s, int cond, TCGReg rt,
-                                  TCGReg rn, TCGReg rm)
-{
-    tcg_out_memop_r(s, cond, INSN_STRD_REG, rt, rn, rm, 1, 1, 0);
-}
-
-/* Register pre-increment with base writeback.  */
-static inline void tcg_out_ld32_rwb(TCGContext *s, int cond, TCGReg rt,
-                                    TCGReg rn, TCGReg rm)
-{
-    tcg_out_memop_r(s, cond, INSN_LDR_REG, rt, rn, rm, 1, 1, 1);
-}
-
-static inline void tcg_out_st32_rwb(TCGContext *s, int cond, TCGReg rt,
-                                    TCGReg rn, TCGReg rm)
-{
-    tcg_out_memop_r(s, cond, INSN_STR_REG, rt, rn, rm, 1, 1, 1);
-}
-
-static inline void tcg_out_ld16u_8(TCGContext *s, int cond, TCGReg rt,
-                                   TCGReg rn, int imm8)
-{
-    tcg_out_memop_8(s, cond, INSN_LDRH_IMM, rt, rn, imm8, 1, 0);
-}
-
-static inline void tcg_out_st16_8(TCGContext *s, int cond, TCGReg rt,
-                                  TCGReg rn, int imm8)
-{
-    tcg_out_memop_8(s, cond, INSN_STRH_IMM, rt, rn, imm8, 1, 0);
-}
-
-static inline void tcg_out_ld16u_r(TCGContext *s, int cond, TCGReg rt,
-                                   TCGReg rn, TCGReg rm)
-{
-    tcg_out_memop_r(s, cond, INSN_LDRH_REG, rt, rn, rm, 1, 1, 0);
-}
-
-static inline void tcg_out_st16_r(TCGContext *s, int cond, TCGReg rt,
-                                  TCGReg rn, TCGReg rm)
-{
-    tcg_out_memop_r(s, cond, INSN_STRH_REG, rt, rn, rm, 1, 1, 0);
-}
-
-static inline void tcg_out_ld16s_8(TCGContext *s, int cond, TCGReg rt,
-                                   TCGReg rn, int imm8)
-{
-    tcg_out_memop_8(s, cond, INSN_LDRSH_IMM, rt, rn, imm8, 1, 0);
-}
-
-static inline void tcg_out_ld16s_r(TCGContext *s, int cond, TCGReg rt,
-                                   TCGReg rn, TCGReg rm)
-{
-    tcg_out_memop_r(s, cond, INSN_LDRSH_REG, rt, rn, rm, 1, 1, 0);
-}
-
-static inline void tcg_out_ld8_12(TCGContext *s, int cond, TCGReg rt,
-                                  TCGReg rn, int imm12)
-{
-    tcg_out_memop_12(s, cond, INSN_LDRB_IMM, rt, rn, imm12, 1, 0);
-}
-
-static inline void tcg_out_st8_12(TCGContext *s, int cond, TCGReg rt,
-                                  TCGReg rn, int imm12)
-{
-    tcg_out_memop_12(s, cond, INSN_STRB_IMM, rt, rn, imm12, 1, 0);
-}
-
-static inline void tcg_out_ld8_r(TCGContext *s, int cond, TCGReg rt,
-                                 TCGReg rn, TCGReg rm)
-{
-    tcg_out_memop_r(s, cond, INSN_LDRB_REG, rt, rn, rm, 1, 1, 0);
-}
-
-static inline void tcg_out_st8_r(TCGContext *s, int cond, TCGReg rt,
-                                 TCGReg rn, TCGReg rm)
-{
-    tcg_out_memop_r(s, cond, INSN_STRB_REG, rt, rn, rm, 1, 1, 0);
-}
-
-static inline void tcg_out_ld8s_8(TCGContext *s, int cond, TCGReg rt,
-                                  TCGReg rn, int imm8)
-{
-    tcg_out_memop_8(s, cond, INSN_LDRSB_IMM, rt, rn, imm8, 1, 0);
-}
-
-static inline void tcg_out_ld8s_r(TCGContext *s, int cond, TCGReg rt,
-                                  TCGReg rn, TCGReg rm)
-{
-    tcg_out_memop_r(s, cond, INSN_LDRSB_REG, rt, rn, rm, 1, 1, 0);
-}
-
 static inline void tcg_out_ld32u(TCGContext *s, int cond,
                 int rd, int rn, int32_t offset)
 {
-- 
2.13.5
