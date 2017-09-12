Received: from eggs.gnu.org ([2001:4830:134:3::10]:38229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro0M-0001y7-96
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro0J-0007CI-Di
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:42 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:37517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dro0J-0007C0-2R
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:39 -0400
Received: by mail-pg0-x22b.google.com with SMTP id d8so22189894pgt.4
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:25:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Sep 2017 09:25:13 -0700
Message-Id: <20170912162513.21694-17-richard.henderson@linaro.org>
In-Reply-To: <20170912162513.21694-1-richard.henderson@linaro.org>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 16/16] tcg/aarch64: Add vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, f4bug@amsat.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     |  23 ++-
 tcg/aarch64/tcg-target.inc.c | 372 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 350 insertions(+), 45 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index c2525066ab..310efa3c1d 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -31,13 +31,22 @@ typedef enum {
     TCG_REG_SP = 31,
     TCG_REG_XZR = 31,
 
+    TCG_REG_V0 = 32, TCG_REG_V1, TCG_REG_V2, TCG_REG_V3,
+    TCG_REG_V4, TCG_REG_V5, TCG_REG_V6, TCG_REG_V7,
+    TCG_REG_V8, TCG_REG_V9, TCG_REG_V10, TCG_REG_V11,
+    TCG_REG_V12, TCG_REG_V13, TCG_REG_V14, TCG_REG_V15,
+    TCG_REG_V16, TCG_REG_V17, TCG_REG_V18, TCG_REG_V19,
+    TCG_REG_V20, TCG_REG_V21, TCG_REG_V22, TCG_REG_V23,
+    TCG_REG_V24, TCG_REG_V25, TCG_REG_V26, TCG_REG_V27,
+    TCG_REG_V28, TCG_REG_V29, TCG_REG_V30, TCG_REG_V31,
+
     /* Aliases.  */
     TCG_REG_FP = TCG_REG_X29,
     TCG_REG_LR = TCG_REG_X30,
     TCG_AREG0  = TCG_REG_X19,
 } TCGReg;
 
-#define TCG_TARGET_NB_REGS 32
+#define TCG_TARGET_NB_REGS 64
 
 /* used for function call generation */
 #define TCG_REG_CALL_STACK              TCG_REG_SP
@@ -113,6 +122,18 @@ typedef enum {
 #define TCG_TARGET_HAS_mulsh_i64        1
 #define TCG_TARGET_HAS_direct_jump      1
 
+#define TCG_TARGET_HAS_v64              1
+#define TCG_TARGET_HAS_andc_v64         1
+#define TCG_TARGET_HAS_orc_v64          1
+#define TCG_TARGET_HAS_not_v64          1
+#define TCG_TARGET_HAS_neg_v64          1
+
+#define TCG_TARGET_HAS_v128             1
+#define TCG_TARGET_HAS_andc_v128        1
+#define TCG_TARGET_HAS_orc_v128         1
+#define TCG_TARGET_HAS_not_v128         1
+#define TCG_TARGET_HAS_neg_v128         1
+
 #define TCG_TARGET_DEFAULT_MO (0)
 
 static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 150530f30e..a2419dcb0c 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -20,10 +20,15 @@ QEMU_BUILD_BUG_ON(TCG_TYPE_I32 != 0 || TCG_TYPE_I64 != 1);
 
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
-    "%x0", "%x1", "%x2", "%x3", "%x4", "%x5", "%x6", "%x7",
-    "%x8", "%x9", "%x10", "%x11", "%x12", "%x13", "%x14", "%x15",
-    "%x16", "%x17", "%x18", "%x19", "%x20", "%x21", "%x22", "%x23",
-    "%x24", "%x25", "%x26", "%x27", "%x28", "%fp", "%x30", "%sp",
+    "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7",
+    "x8", "x9", "x10", "x11", "x12", "x13", "x14", "x15",
+    "x16", "x17", "x18", "x19", "x20", "x21", "x22", "x23",
+    "x24", "x25", "x26", "x27", "x28", "fp", "x30", "sp",
+
+    "v0", "v1", "v2", "v3", "v4", "v5", "v6", "v7",
+    "v8", "v9", "v10", "v11", "v12", "v13", "v14", "v15",
+    "v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",
+    "v24", "v25", "v26", "v27", "v28", "fp", "v30", "v31",
 };
 #endif /* CONFIG_DEBUG_TCG */
 
@@ -43,6 +48,14 @@ static const int tcg_target_reg_alloc_order[] = {
     /* X19 reserved for AREG0 */
     /* X29 reserved as fp */
     /* X30 reserved as temporary */
+
+    TCG_REG_V0, TCG_REG_V1, TCG_REG_V2, TCG_REG_V3,
+    TCG_REG_V4, TCG_REG_V5, TCG_REG_V6, TCG_REG_V7,
+    /* V8 - V15 are call-saved, and skipped.  */
+    TCG_REG_V16, TCG_REG_V17, TCG_REG_V18, TCG_REG_V19,
+    TCG_REG_V20, TCG_REG_V21, TCG_REG_V22, TCG_REG_V23,
+    TCG_REG_V24, TCG_REG_V25, TCG_REG_V26, TCG_REG_V27,
+    TCG_REG_V28, TCG_REG_V29, TCG_REG_V30, TCG_REG_V31,
 };
 
 static const int tcg_target_call_iarg_regs[8] = {
@@ -119,10 +132,14 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
                                            const char *ct_str, TCGType type)
 {
     switch (*ct_str++) {
-    case 'r':
+    case 'r': /* general registers */
         ct->ct |= TCG_CT_REG;
         ct->u.regs = 0xffffffffu;
         break;
+    case 'w': /* advsimd registers */
+        ct->ct |= TCG_CT_REG;
+        ct->u.regs = 0xffffffff00000000ull;
+        break;
     case 'l': /* qemu_ld / qemu_st address, data_reg */
         ct->ct |= TCG_CT_REG;
         ct->u.regs = 0xffffffffu;
@@ -290,6 +307,12 @@ typedef enum {
     I3312_LDRSHX    = 0x38000000 | LDST_LD_S_X << 22 | MO_16 << 30,
     I3312_LDRSWX    = 0x38000000 | LDST_LD_S_X << 22 | MO_32 << 30,
 
+    I3312_LDRVD     = 0x3c000000 | LDST_LD << 22 | MO_64 << 30,
+    I3312_STRVD     = 0x3c000000 | LDST_ST << 22 | MO_64 << 30,
+
+    I3312_LDRVQ     = 0x3c000000 | 3 << 22 | 0 << 30,
+    I3312_STRVQ     = 0x3c000000 | 2 << 22 | 0 << 30,
+
     I3312_TO_I3310  = 0x00200800,
     I3312_TO_I3313  = 0x01000000,
 
@@ -374,8 +397,33 @@ typedef enum {
     I3510_EON       = 0x4a200000,
     I3510_ANDS      = 0x6a000000,
 
-    NOP             = 0xd503201f,
+    /* AdvSIMD modified immediate */
+    I3606_MOVI      = 0x0f000400,
+
+    /* AdvSIMD three same.  */
+    I3616_ADD_B     = 0x0e208400,
+    I3616_ADD_H     = 0x0e608400,
+    I3616_ADD_S     = 0x0ea08400,
+    I3616_ADD_D     = 0x4ee08400,
+    I3616_AND       = 0x0e201c00,
+    I3616_BIC       = 0x0e601c00,
+    I3616_EOR       = 0x2e201c00,
+    I3616_ORR       = 0x0ea01c00,
+    I3616_ORN       = 0x0ee01c00,
+    I3616_SUB_B     = 0x2e208400,
+    I3616_SUB_H     = 0x2e608400,
+    I3616_SUB_S     = 0x2ea08400,
+    I3616_SUB_D     = 0x6ee08400,
+
+    /* AdvSIMD two-reg misc.  */
+    I3617_NOT       = 0x2e205800,
+    I3617_NEG_B     = 0x2e20b800,
+    I3617_NEG_H     = 0x2e60b800,
+    I3617_NEG_S     = 0x2ea0b800,
+    I3617_NEG_D     = 0x6ee0b800,
+
     /* System instructions.  */
+    NOP             = 0xd503201f,
     DMB_ISH         = 0xd50338bf,
     DMB_LD          = 0x00000100,
     DMB_ST          = 0x00000200,
@@ -520,26 +568,47 @@ static void tcg_out_insn_3509(TCGContext *s, AArch64Insn insn, TCGType ext,
     tcg_out32(s, insn | ext << 31 | rm << 16 | ra << 10 | rn << 5 | rd);
 }
 
+static void tcg_out_insn_3606(TCGContext *s, AArch64Insn insn, bool q,
+                              TCGReg rd, bool op, int cmode, uint8_t imm8)
+{
+    tcg_out32(s, insn | q << 30 | op << 29 | cmode << 12 | (rd & 0x1f)
+              | (imm8 & 0xe0) << 16 | (imm8 & 0x1f) << 5);
+}
+
+static void tcg_out_insn_3616(TCGContext *s, AArch64Insn insn, bool q,
+                              TCGReg rd, TCGReg rn, TCGReg rm)
+{
+    tcg_out32(s, insn | q << 30 | (rm & 0x1f) << 16
+              | (rn & 0x1f) << 5 | (rd & 0x1f));
+}
+
+static void tcg_out_insn_3617(TCGContext *s, AArch64Insn insn, bool q,
+                              TCGReg rd, TCGReg rn)
+{
+    tcg_out32(s, insn | q << 30 | (rn & 0x1f) << 5 | (rd & 0x1f));
+}
+
 static void tcg_out_insn_3310(TCGContext *s, AArch64Insn insn,
                               TCGReg rd, TCGReg base, TCGType ext,
                               TCGReg regoff)
 {
     /* Note the AArch64Insn constants above are for C3.3.12.  Adjust.  */
     tcg_out32(s, insn | I3312_TO_I3310 | regoff << 16 |
-              0x4000 | ext << 13 | base << 5 | rd);
+              0x4000 | ext << 13 | base << 5 | (rd & 0x1f));
 }
 
 static void tcg_out_insn_3312(TCGContext *s, AArch64Insn insn,
                               TCGReg rd, TCGReg rn, intptr_t offset)
 {
-    tcg_out32(s, insn | (offset & 0x1ff) << 12 | rn << 5 | rd);
+    tcg_out32(s, insn | (offset & 0x1ff) << 12 | rn << 5 | (rd & 0x1f));
 }
 
 static void tcg_out_insn_3313(TCGContext *s, AArch64Insn insn,
                               TCGReg rd, TCGReg rn, uintptr_t scaled_uimm)
 {
     /* Note the AArch64Insn constants above are for C3.3.12.  Adjust.  */
-    tcg_out32(s, insn | I3312_TO_I3313 | scaled_uimm << 10 | rn << 5 | rd);
+    tcg_out32(s, insn | I3312_TO_I3313 | scaled_uimm << 10
+              | rn << 5 | (rd & 0x1f));
 }
 
 /* Register to register move using ORR (shifted register with no shift). */
@@ -594,6 +663,24 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
     int s0, s1;
     AArch64Insn opc;
 
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_debug_assert(rd < 32);
+        break;
+
+    case TCG_TYPE_V64:
+    case TCG_TYPE_V128:
+        tcg_debug_assert(rd >= 32);
+        /* ??? Revisit this as the implementation progresses.  */
+        tcg_debug_assert(value == 0);
+        tcg_out_insn(s, 3606, MOVI, 0, rd, 0, 0, 0);
+        return;
+
+    default:
+        g_assert_not_reached();
+    }
+
     /* For 32-bit values, discard potential garbage in value.  For 64-bit
        values within [2**31, 2**32-1], we can create smaller sequences by
        interpreting this as a negative 32-bit number, while ensuring that
@@ -669,15 +756,13 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
 /* Define something more legible for general use.  */
 #define tcg_out_ldst_r  tcg_out_insn_3310
 
-static void tcg_out_ldst(TCGContext *s, AArch64Insn insn,
-                         TCGReg rd, TCGReg rn, intptr_t offset)
+static void tcg_out_ldst(TCGContext *s, AArch64Insn insn, TCGReg rd,
+                         TCGReg rn, intptr_t offset, int lgsize)
 {
-    TCGMemOp size = (uint32_t)insn >> 30;
-
     /* If the offset is naturally aligned and in range, then we can
        use the scaled uimm12 encoding */
-    if (offset >= 0 && !(offset & ((1 << size) - 1))) {
-        uintptr_t scaled_uimm = offset >> size;
+    if (offset >= 0 && !(offset & ((1 << lgsize) - 1))) {
+        uintptr_t scaled_uimm = offset >> lgsize;
         if (scaled_uimm <= 0xfff) {
             tcg_out_insn_3313(s, insn, rd, rn, scaled_uimm);
             return;
@@ -695,32 +780,94 @@ static void tcg_out_ldst(TCGContext *s, AArch64Insn insn,
     tcg_out_ldst_r(s, insn, rd, rn, TCG_TYPE_I64, TCG_REG_TMP);
 }
 
-static inline void tcg_out_mov(TCGContext *s,
-                               TCGType type, TCGReg ret, TCGReg arg)
+static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
-    if (ret != arg) {
+    if (ret == arg) {
+        return;
+    }
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_debug_assert(ret < 32 && arg < 32);
         tcg_out_movr(s, type, ret, arg);
+        break;
+
+    case TCG_TYPE_V64:
+        tcg_debug_assert(ret >= 32 && arg >= 32);
+        tcg_out_insn(s, 3616, ORR, 0, ret, arg, arg);
+        break;
+    case TCG_TYPE_V128:
+        tcg_debug_assert(ret >= 32 && arg >= 32);
+        tcg_out_insn(s, 3616, ORR, 1, ret, arg, arg);
+        break;
+
+    default:
+        g_assert_not_reached();
     }
 }
 
-static inline void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
-                              TCGReg arg1, intptr_t arg2)
+static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
+                       TCGReg arg1, intptr_t arg2)
 {
-    tcg_out_ldst(s, type == TCG_TYPE_I32 ? I3312_LDRW : I3312_LDRX,
-                 arg, arg1, arg2);
+    AArch64Insn insn;
+    int lgsz;
+
+    switch (type) {
+    case TCG_TYPE_I32:
+        insn = I3312_LDRW;
+        lgsz = 2;
+        break;
+    case TCG_TYPE_I64:
+        insn = I3312_LDRX;
+        lgsz = 3;
+        break;
+    case TCG_TYPE_V64:
+        insn = I3312_LDRVD;
+        lgsz = 3;
+        break;
+    case TCG_TYPE_V128:
+        insn = I3312_LDRVQ;
+        lgsz = 4;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_out_ldst(s, insn, arg, arg1, arg2, lgsz);
 }
 
-static inline void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
-                              TCGReg arg1, intptr_t arg2)
+static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
+                       TCGReg arg1, intptr_t arg2)
 {
-    tcg_out_ldst(s, type == TCG_TYPE_I32 ? I3312_STRW : I3312_STRX,
-                 arg, arg1, arg2);
+    AArch64Insn insn;
+    int lgsz;
+
+    switch (type) {
+    case TCG_TYPE_I32:
+        insn = I3312_STRW;
+        lgsz = 2;
+        break;
+    case TCG_TYPE_I64:
+        insn = I3312_STRX;
+        lgsz = 3;
+        break;
+    case TCG_TYPE_V64:
+        insn = I3312_STRVD;
+        lgsz = 3;
+        break;
+    case TCG_TYPE_V128:
+        insn = I3312_STRVQ;
+        lgsz = 4;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_out_ldst(s, insn, arg, arg1, arg2, lgsz);
 }
 
 static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
                                TCGReg base, intptr_t ofs)
 {
-    if (val == 0) {
+    if (type <= TCG_TYPE_I64 && val == 0) {
         tcg_out_st(s, type, TCG_REG_XZR, base, ofs);
         return true;
     }
@@ -1210,14 +1357,15 @@ static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp opc,
     /* Merge "low bits" from tlb offset, load the tlb comparator into X0.
        X0 = load [X2 + (tlb_offset & 0x000fff)] */
     tcg_out_ldst(s, TARGET_LONG_BITS == 32 ? I3312_LDRW : I3312_LDRX,
-                 TCG_REG_X0, TCG_REG_X2, tlb_offset & 0xfff);
+                 TCG_REG_X0, TCG_REG_X2, tlb_offset & 0xfff,
+                 TARGET_LONG_BITS == 32 ? 2 : 3);
 
     /* Load the tlb addend. Do that early to avoid stalling.
        X1 = load [X2 + (tlb_offset & 0xfff) + offsetof(addend)] */
     tcg_out_ldst(s, I3312_LDRX, TCG_REG_X1, TCG_REG_X2,
                  (tlb_offset & 0xfff) + (offsetof(CPUTLBEntry, addend)) -
                  (is_read ? offsetof(CPUTLBEntry, addr_read)
-                  : offsetof(CPUTLBEntry, addr_write)));
+                  : offsetof(CPUTLBEntry, addr_write)), 3);
 
     /* Perform the address comparison. */
     tcg_out_cmp(s, (TARGET_LONG_BITS == 64), TCG_REG_X0, TCG_REG_X3, 0);
@@ -1435,49 +1583,49 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8u_i64:
-        tcg_out_ldst(s, I3312_LDRB, a0, a1, a2);
+        tcg_out_ldst(s, I3312_LDRB, a0, a1, a2, 0);
         break;
     case INDEX_op_ld8s_i32:
-        tcg_out_ldst(s, I3312_LDRSBW, a0, a1, a2);
+        tcg_out_ldst(s, I3312_LDRSBW, a0, a1, a2, 0);
         break;
     case INDEX_op_ld8s_i64:
-        tcg_out_ldst(s, I3312_LDRSBX, a0, a1, a2);
+        tcg_out_ldst(s, I3312_LDRSBX, a0, a1, a2, 0);
         break;
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16u_i64:
-        tcg_out_ldst(s, I3312_LDRH, a0, a1, a2);
+        tcg_out_ldst(s, I3312_LDRH, a0, a1, a2, 1);
         break;
     case INDEX_op_ld16s_i32:
-        tcg_out_ldst(s, I3312_LDRSHW, a0, a1, a2);
+        tcg_out_ldst(s, I3312_LDRSHW, a0, a1, a2, 1);
         break;
     case INDEX_op_ld16s_i64:
-        tcg_out_ldst(s, I3312_LDRSHX, a0, a1, a2);
+        tcg_out_ldst(s, I3312_LDRSHX, a0, a1, a2, 1);
         break;
     case INDEX_op_ld_i32:
     case INDEX_op_ld32u_i64:
-        tcg_out_ldst(s, I3312_LDRW, a0, a1, a2);
+        tcg_out_ldst(s, I3312_LDRW, a0, a1, a2, 2);
         break;
     case INDEX_op_ld32s_i64:
-        tcg_out_ldst(s, I3312_LDRSWX, a0, a1, a2);
+        tcg_out_ldst(s, I3312_LDRSWX, a0, a1, a2, 2);
         break;
     case INDEX_op_ld_i64:
-        tcg_out_ldst(s, I3312_LDRX, a0, a1, a2);
+        tcg_out_ldst(s, I3312_LDRX, a0, a1, a2, 3);
         break;
 
     case INDEX_op_st8_i32:
     case INDEX_op_st8_i64:
-        tcg_out_ldst(s, I3312_STRB, REG0(0), a1, a2);
+        tcg_out_ldst(s, I3312_STRB, REG0(0), a1, a2, 0);
         break;
     case INDEX_op_st16_i32:
     case INDEX_op_st16_i64:
-        tcg_out_ldst(s, I3312_STRH, REG0(0), a1, a2);
+        tcg_out_ldst(s, I3312_STRH, REG0(0), a1, a2, 1);
         break;
     case INDEX_op_st_i32:
     case INDEX_op_st32_i64:
-        tcg_out_ldst(s, I3312_STRW, REG0(0), a1, a2);
+        tcg_out_ldst(s, I3312_STRW, REG0(0), a1, a2, 2);
         break;
     case INDEX_op_st_i64:
-        tcg_out_ldst(s, I3312_STRX, REG0(0), a1, a2);
+        tcg_out_ldst(s, I3312_STRX, REG0(0), a1, a2, 3);
         break;
 
     case INDEX_op_add_i32:
@@ -1774,13 +1922,93 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_mb(s, a0);
         break;
 
+    case INDEX_op_ld_v64:
+        tcg_out_ldst(s, I3312_LDRVD, a0, a1, a2, 3);
+        break;
+    case INDEX_op_ld_v128:
+        tcg_out_ldst(s, I3312_LDRVQ, a0, a1, a2, 4);
+        break;
+    case INDEX_op_st_v64:
+        tcg_out_ldst(s, I3312_STRVD, a0, a1, a2, 3);
+        break;
+    case INDEX_op_st_v128:
+        tcg_out_ldst(s, I3312_STRVQ, a0, a1, a2, 4);
+        break;
+
+#define VOP(NAME)  case INDEX_op_##NAME##_v128: ext = 1; /* fallthru */ \
+                   case INDEX_op_##NAME##_v64
+
+    VOP(add8):
+        tcg_out_insn(s, 3616, ADD_B, ext, a0, a1, a2);
+        break;
+    VOP(add16):
+        tcg_out_insn(s, 3616, ADD_H, ext, a0, a1, a2);
+        break;
+    VOP(add32):
+        tcg_out_insn(s, 3616, ADD_S, ext, a0, a1, a2);
+        break;
+    case INDEX_op_add64_v128:
+        tcg_out_insn(s, 3616, ADD_D, 1, a0, a1, a2);
+        break;
+
+    VOP(sub8):
+        tcg_out_insn(s, 3616, SUB_B, ext, a0, a1, a2);
+        break;
+    VOP(sub16):
+        tcg_out_insn(s, 3616, SUB_H, ext, a0, a1, a2);
+        break;
+    VOP(sub32):
+        tcg_out_insn(s, 3616, SUB_S, ext, a0, a1, a2);
+        break;
+    case INDEX_op_sub64_v128:
+        tcg_out_insn(s, 3616, SUB_D, 1, a0, a1, a2);
+        break;
+
+    VOP(neg8):
+        tcg_out_insn(s, 3617, NEG_B, ext, a0, a1);
+        break;
+    VOP(neg16):
+        tcg_out_insn(s, 3617, NEG_H, ext, a0, a1);
+        break;
+    VOP(neg32):
+        tcg_out_insn(s, 3617, NEG_S, ext, a0, a1);
+        break;
+    case INDEX_op_neg64_v128:
+        tcg_out_insn(s, 3617, NEG_D, 1, a0, a1);
+        break;
+
+    VOP(and):
+        tcg_out_insn(s, 3616, AND, ext, a0, a1, a2);
+        break;
+    VOP(or):
+        tcg_out_insn(s, 3616, ORR, ext, a0, a1, a2);
+        break;
+    VOP(xor):
+        tcg_out_insn(s, 3616, EOR, ext, a0, a1, a2);
+        break;
+    VOP(andc):
+        tcg_out_insn(s, 3616, BIC, ext, a0, a1, a2);
+        break;
+    VOP(orc):
+        tcg_out_insn(s, 3616, ORN, ext, a0, a1, a2);
+        break;
+    VOP(not):
+        tcg_out_insn(s, 3617, NOT, ext, a0, a1);
+        break;
+
+#undef VOP
+
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
+    case INDEX_op_mov_v64:
+    case INDEX_op_mov_v128:
     case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
     case INDEX_op_movi_i64:
+    case INDEX_op_movi_v64:
+    case INDEX_op_movi_v128:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
-        tcg_abort();
+        g_assert_not_reached();
     }
 
 #undef REG0
@@ -1790,11 +2018,14 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
     static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
     static const TCGTargetOpDef r_r = { .args_ct_str = { "r", "r" } };
+    static const TCGTargetOpDef w_w = { .args_ct_str = { "w", "w" } };
+    static const TCGTargetOpDef w_r = { .args_ct_str = { "w", "r" } };
     static const TCGTargetOpDef r_l = { .args_ct_str = { "r", "l" } };
     static const TCGTargetOpDef r_rA = { .args_ct_str = { "r", "rA" } };
     static const TCGTargetOpDef rZ_r = { .args_ct_str = { "rZ", "r" } };
     static const TCGTargetOpDef lZ_l = { .args_ct_str = { "lZ", "l" } };
     static const TCGTargetOpDef r_r_r = { .args_ct_str = { "r", "r", "r" } };
+    static const TCGTargetOpDef w_w_w = { .args_ct_str = { "w", "w", "w" } };
     static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
     static const TCGTargetOpDef r_r_rA = { .args_ct_str = { "r", "r", "rA" } };
     static const TCGTargetOpDef r_r_rL = { .args_ct_str = { "r", "r", "rL" } };
@@ -1938,6 +2169,49 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sub2_i64:
         return &add2;
 
+    case INDEX_op_add8_v64:
+    case INDEX_op_add16_v64:
+    case INDEX_op_add32_v64:
+    case INDEX_op_add8_v128:
+    case INDEX_op_add16_v128:
+    case INDEX_op_add32_v128:
+    case INDEX_op_add64_v128:
+    case INDEX_op_sub8_v64:
+    case INDEX_op_sub16_v64:
+    case INDEX_op_sub32_v64:
+    case INDEX_op_sub8_v128:
+    case INDEX_op_sub16_v128:
+    case INDEX_op_sub32_v128:
+    case INDEX_op_sub64_v128:
+    case INDEX_op_and_v64:
+    case INDEX_op_and_v128:
+    case INDEX_op_or_v64:
+    case INDEX_op_or_v128:
+    case INDEX_op_xor_v64:
+    case INDEX_op_xor_v128:
+    case INDEX_op_andc_v64:
+    case INDEX_op_andc_v128:
+    case INDEX_op_orc_v64:
+    case INDEX_op_orc_v128:
+        return &w_w_w;
+
+    case INDEX_op_not_v64:
+    case INDEX_op_not_v128:
+    case INDEX_op_neg8_v64:
+    case INDEX_op_neg16_v64:
+    case INDEX_op_neg32_v64:
+    case INDEX_op_neg8_v128:
+    case INDEX_op_neg16_v128:
+    case INDEX_op_neg32_v128:
+    case INDEX_op_neg64_v128:
+        return &w_w;
+
+    case INDEX_op_ld_v64:
+    case INDEX_op_ld_v128:
+    case INDEX_op_st_v64:
+    case INDEX_op_st_v128:
+        return &w_r;
+
     default:
         return NULL;
     }
@@ -1947,8 +2221,10 @@ static void tcg_target_init(TCGContext *s)
 {
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffffu;
     tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffffu;
+    tcg_target_available_regs[TCG_TYPE_V64] = 0xffffffff00000000ull;
+    tcg_target_available_regs[TCG_TYPE_V128] = 0xffffffff00000000ull;
 
-    tcg_target_call_clobber_regs = 0xfffffffu;
+    tcg_target_call_clobber_regs = -1ull;
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_X19);
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_X20);
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_X21);
@@ -1960,6 +2236,14 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_X27);
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_X28);
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_X29);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V8);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V9);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V10);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V11);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V12);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V13);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V14);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V15);
 
     s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_SP);
-- 
2.13.5
