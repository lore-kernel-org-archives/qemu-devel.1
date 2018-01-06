Received: from eggs.gnu.org ([2001:4830:134:3::10]:48509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXewJ-0007rI-NX
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXewF-0005vx-Sj
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:31 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:46441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eXewF-0005u8-HH
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:27 -0500
Received: by mail-pg0-x244.google.com with SMTP id r2so2708485pgq.13
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 19:14:27 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-183-164.tukw.qwest.net.
	[97.113.183.164]) by smtp.gmail.com with ESMTPSA id
	g10sm17740595pfe.77.2018.01.05.19.14.24 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Jan 2018 19:14:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Jan 2018 19:13:46 -0800
Message-Id: <20180106031346.6650-24-richard.henderson@linaro.org>
In-Reply-To: <20180106031346.6650-1-richard.henderson@linaro.org>
References: <20180106031346.6650-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v8 23/23] tcg/aarch64: Add vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     |  30 +-
 tcg/aarch64/tcg-target.opc.h |   3 +
 tcg/aarch64/tcg-target.inc.c | 674 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 660 insertions(+), 47 deletions(-)
 create mode 100644 tcg/aarch64/tcg-target.opc.h

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index c2525066ab..46434ecca4 100644
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
@@ -113,6 +122,25 @@ typedef enum {
 #define TCG_TARGET_HAS_mulsh_i64        1
 #define TCG_TARGET_HAS_direct_jump      1
 
+#define TCG_TARGET_HAS_v64              1
+#define TCG_TARGET_HAS_v128             1
+#define TCG_TARGET_HAS_v256             0
+
+#define TCG_TARGET_HAS_andc_vec         1
+#define TCG_TARGET_HAS_orc_vec          1
+#define TCG_TARGET_HAS_not_vec          1
+#define TCG_TARGET_HAS_neg_vec          1
+#define TCG_TARGET_HAS_shi_vec          1
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_zip_vec          1
+#define TCG_TARGET_HAS_uzp_vec          1
+#define TCG_TARGET_HAS_trn_vec          1
+#define TCG_TARGET_HAS_cmp_vec          1
+#define TCG_TARGET_HAS_mul_vec          1
+#define TCG_TARGET_HAS_extl_vec         1
+#define TCG_TARGET_HAS_exth_vec         1
+
 #define TCG_TARGET_DEFAULT_MO (0)
 
 static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
diff --git a/tcg/aarch64/tcg-target.opc.h b/tcg/aarch64/tcg-target.opc.h
new file mode 100644
index 0000000000..4816a6c3d4
--- /dev/null
+++ b/tcg/aarch64/tcg-target.opc.h
@@ -0,0 +1,3 @@
+/* Target-specific opcodes for host vector expansion.  These will be
+   emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
+   consider these to be UNSPEC with names.  */
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 150530f30e..b2ce818d7c 100644
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
@@ -54,6 +67,7 @@ static const int tcg_target_call_oarg_regs[1] = {
 };
 
 #define TCG_REG_TMP TCG_REG_X30
+#define TCG_VEC_TMP TCG_REG_V31
 
 #ifndef CONFIG_SOFTMMU
 /* Note that XZR cannot be encoded in the address base register slot,
@@ -119,9 +133,13 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
                                            const char *ct_str, TCGType type)
 {
     switch (*ct_str++) {
-    case 'r':
+    case 'r': /* general registers */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffffffffu;
+        ct->u.regs |= 0xffffffffu;
+        break;
+    case 'w': /* advsimd registers */
+        ct->ct |= TCG_CT_REG;
+        ct->u.regs |= 0xffffffff00000000ull;
         break;
     case 'l': /* qemu_ld / qemu_st address, data_reg */
         ct->ct |= TCG_CT_REG;
@@ -178,6 +196,98 @@ static inline bool is_limm(uint64_t val)
     return (val & (val - 1)) == 0;
 }
 
+static bool is_fimm(uint64_t v64, int *op, int *cmode, int *imm8)
+{
+    int i;
+
+    *op = 0;
+    if (v64 == (-1ull / 0xff) * (v64 & 0xff)) {
+        *cmode = 0xe;
+        *imm8 = v64 & 0xff;
+        return true;
+    }
+    if (v64 == (-1ull / 0xffff) * (v64 & 0xffff)) {
+        uint64_t v16 = v64 & 0xffff;
+
+        if (v16 == (v64 & 0xff)) {
+            *cmode = 0x8;
+            *imm8 = v64 & 0xff;
+            return true;
+        } else if (v16 == (v64 & 0xff00)) {
+            *cmode = 0xa;
+            *imm8 = v16 >> 8;
+            return true;
+        }
+    }
+    if (v64 == deposit64(v64, 32, 32, v64)) {
+        uint64_t v32 = (uint32_t)v64;
+
+        if (v32 == (v64 & 0xff)) {
+            *cmode = 0x0;
+            *imm8 = v64 & 0xff;
+            return true;
+        } else if (v32 == (v32 & 0xff00)) {
+            *cmode = 0x2;
+            *imm8 = (v64 >> 8) & 0xff;
+            return true;
+        } else if (v32 == (v32 & 0xff0000)) {
+            *cmode = 0x4;
+            *imm8 = (v64 >> 16) & 0xff;
+            return true;
+        } else if (v32 == (v32 & 0xff000000)) {
+            *cmode = 0x6;
+            *imm8 = v32 >> 24;
+            return true;
+        } else if ((v32 & 0xffff00ff) == 0xff) {
+            *cmode = 0xc;
+            *imm8 = (v64 >> 8) & 0xff;
+            return true;
+        } else if ((v32 & 0xff00ffff) == 0xffff) {
+            *cmode = 0xd;
+            *imm8 = (v64 >> 16) & 0xff;
+            return true;
+        } else if (extract32(v32, 0, 19) == 0
+                   && (extract32(v32, 25, 6) == 0x20
+                       || extract32(v32, 25, 6) == 0x1f)) {
+            *cmode = 0xf;
+            *imm8 = (extract32(v32, 31, 1) << 7)
+                  | (extract32(v32, 25, 1) << 6)
+                  | extract32(v32, 19, 6);
+            return true;
+        }
+    }
+    if (extract64(v64, 0, 48) == 0
+        && (extract64(v64, 54, 9) == 0x100
+            || extract64(v64, 54, 9) == 0x0ff)) {
+        *cmode = 0xf;
+        *op = 1;
+        *imm8 = (extract64(v64, 63, 1) << 7)
+              | (extract64(v64, 54, 1) << 6)
+              | extract64(v64, 48, 6);
+        return true;
+    }
+    for (i = 0; i < 64; i += 8) {
+        uint64_t byte = extract64(v64, i, 8);
+        if (byte != 0 && byte != 0xff) {
+            break;
+        }
+    }
+    if (i == 64) {
+        *cmode = 0xe;
+        *op = 1;
+        *imm8 = (extract64(v64, 0, 1) << 0)
+              | (extract64(v64, 8, 1) << 1)
+              | (extract64(v64, 16, 1) << 2)
+              | (extract64(v64, 24, 1) << 3)
+              | (extract64(v64, 32, 1) << 4)
+              | (extract64(v64, 40, 1) << 5)
+              | (extract64(v64, 48, 1) << 6)
+              | (extract64(v64, 56, 1) << 7);
+        return true;
+    }
+    return false;
+}
+
 static int tcg_target_const_match(tcg_target_long val, TCGType type,
                                   const TCGArgConstraint *arg_ct)
 {
@@ -271,6 +381,9 @@ typedef enum {
 
     /* Load literal for loading the address at pc-relative offset */
     I3305_LDR       = 0x58000000,
+    I3305_LDR_v64   = 0x5c000000,
+    I3305_LDR_v128  = 0x9c000000,
+
     /* Load/store register.  Described here as 3.3.12, but the helper
        that emits them can transform to 3.3.10 or 3.3.13.  */
     I3312_STRB      = 0x38000000 | LDST_ST << 22 | MO_8 << 30,
@@ -290,6 +403,15 @@ typedef enum {
     I3312_LDRSHX    = 0x38000000 | LDST_LD_S_X << 22 | MO_16 << 30,
     I3312_LDRSWX    = 0x38000000 | LDST_LD_S_X << 22 | MO_32 << 30,
 
+    I3312_LDRVS     = 0x3c000000 | LDST_LD << 22 | MO_32 << 30,
+    I3312_STRVS     = 0x3c000000 | LDST_ST << 22 | MO_32 << 30,
+
+    I3312_LDRVD     = 0x3c000000 | LDST_LD << 22 | MO_64 << 30,
+    I3312_STRVD     = 0x3c000000 | LDST_ST << 22 | MO_64 << 30,
+
+    I3312_LDRVQ     = 0x3c000000 | 3 << 22 | 0 << 30,
+    I3312_STRVQ     = 0x3c000000 | 2 << 22 | 0 << 30,
+
     I3312_TO_I3310  = 0x00200800,
     I3312_TO_I3313  = 0x01000000,
 
@@ -374,8 +496,58 @@ typedef enum {
     I3510_EON       = 0x4a200000,
     I3510_ANDS      = 0x6a000000,
 
-    NOP             = 0xd503201f,
+    /* AdvSIMD zip.uzp/trn */
+    I3603_ZIP1      = 0x0e003800,
+    I3603_UZP1      = 0x0e001800,
+    I3603_TRN1      = 0x0e002800,
+    I3603_ZIP2      = 0x0e007800,
+    I3603_UZP2      = 0x0e005800,
+    I3603_TRN2      = 0x0e006800,
+
+    /* AdvSIMD copy */
+    I3605_DUP      = 0x0e000400,
+    I3605_INS      = 0x4e001c00,
+    I3605_UMOV     = 0x0e003c00,
+
+    /* AdvSIMD modified immediate */
+    I3606_MOVI      = 0x0f000400,
+
+    /* AdvSIMD shift by immediate */
+    I3614_SSHR      = 0x0f000400,
+    I3614_SSRA      = 0x0f001400,
+    I3614_SHL       = 0x0f005400,
+    I3614_SSHLL     = 0x0f00a400,
+    I3614_USHR      = 0x2f000400,
+    I3614_USRA      = 0x2f001400,
+    I3614_USHLL     = 0x2f00a400,
+
+    /* AdvSIMD three same.  */
+    I3616_ADD       = 0x0e208400,
+    I3616_AND       = 0x0e201c00,
+    I3616_BIC       = 0x0e601c00,
+    I3616_EOR       = 0x2e201c00,
+    I3616_MUL       = 0x0e209c00,
+    I3616_ORR       = 0x0ea01c00,
+    I3616_ORN       = 0x0ee01c00,
+    I3616_SUB       = 0x2e208400,
+    I3616_CMGT      = 0x0e203400,
+    I3616_CMGE      = 0x0e203c00,
+    I3616_CMTST     = 0x0e208c00,
+    I3616_CMHI      = 0x2e203400,
+    I3616_CMHS      = 0x2e203c00,
+    I3616_CMEQ      = 0x2e208c00,
+
+    /* AdvSIMD two-reg misc.  */
+    I3617_CMGT0     = 0x0e208800,
+    I3617_CMEQ0     = 0x0e209800,
+    I3617_CMLT0     = 0x0e20a800,
+    I3617_CMGE0     = 0x2e208800,
+    I3617_CMLE0     = 0x2e20a800,
+    I3617_NOT       = 0x2e205800,
+    I3617_NEG       = 0x2e20b800,
+
     /* System instructions.  */
+    NOP             = 0xd503201f,
     DMB_ISH         = 0xd50338bf,
     DMB_LD          = 0x00000100,
     DMB_ST          = 0x00000200,
@@ -520,26 +692,71 @@ static void tcg_out_insn_3509(TCGContext *s, AArch64Insn insn, TCGType ext,
     tcg_out32(s, insn | ext << 31 | rm << 16 | ra << 10 | rn << 5 | rd);
 }
 
+static void tcg_out_insn_3603(TCGContext *s, AArch64Insn insn, bool q,
+                              unsigned size, TCGReg rd, TCGReg rn, TCGReg rm)
+{
+    tcg_out32(s, insn | q << 30 | (size << 22) | (rd & 0x1f)
+              | (rn & 0x1f) << 5 | (rm & 0x1f) << 16);
+}
+
+static void tcg_out_insn_3605(TCGContext *s, AArch64Insn insn, bool q,
+                              TCGReg rd, TCGReg rn, int dst_idx, int src_idx)
+{
+    /* Note that bit 11 set means general register input.  Therefore
+       we can handle both register sets with one function.  */
+    tcg_out32(s, insn | q << 30 | (dst_idx << 16) | (src_idx << 11)
+              | (rd & 0x1f) | (~rn & 0x20) << 6 | (rn & 0x1f) << 5);
+}
+
+static void tcg_out_insn_3606(TCGContext *s, AArch64Insn insn, bool q,
+                              TCGReg rd, bool op, int cmode, uint8_t imm8)
+{
+    tcg_out32(s, insn | q << 30 | op << 29 | cmode << 12 | (rd & 0x1f)
+              | (imm8 & 0xe0) << (16 - 5) | (imm8 & 0x1f) << 5);
+}
+
+static void tcg_out_insn_3614(TCGContext *s, AArch64Insn insn, bool q,
+                              TCGReg rd, TCGReg rn, unsigned immhb)
+{
+    tcg_out32(s, insn | q << 30 | immhb << 16
+              | (rn & 0x1f) << 5 | (rd & 0x1f));
+}
+
+static void tcg_out_insn_3616(TCGContext *s, AArch64Insn insn, bool q,
+                              unsigned size, TCGReg rd, TCGReg rn, TCGReg rm)
+{
+    tcg_out32(s, insn | q << 30 | (size << 22) | (rm & 0x1f) << 16
+              | (rn & 0x1f) << 5 | (rd & 0x1f));
+}
+
+static void tcg_out_insn_3617(TCGContext *s, AArch64Insn insn, bool q,
+                              unsigned size, TCGReg rd, TCGReg rn)
+{
+    tcg_out32(s, insn | q << 30 | (size << 22)
+              | (rn & 0x1f) << 5 | (rd & 0x1f));
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
@@ -585,6 +802,35 @@ static void tcg_out_logicali(TCGContext *s, AArch64Insn insn, TCGType ext,
     tcg_out_insn_3404(s, insn, ext, rd, rn, ext, r, c);
 }
 
+static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
+                             TCGReg rd, uint64_t v64)
+{
+    int op, cmode, imm8;
+
+    if (is_fimm(v64, &op, &cmode, &imm8)) {
+        tcg_out_insn(s, 3606, MOVI, type == TCG_TYPE_V128, rd, op, cmode, imm8);
+    } else if (type == TCG_TYPE_V128) {
+        new_pool_l2(s, R_AARCH64_CONDBR19, s->code_ptr, 0, v64, v64);
+        tcg_out_insn(s, 3305, LDR_v128, 0, rd);
+    } else {
+        new_pool_label(s, v64, R_AARCH64_CONDBR19, s->code_ptr, 0);
+        tcg_out_insn(s, 3305, LDR_v64, 0, rd);
+    }
+}
+
+static void tcg_out_movi_vec(TCGContext *s, TCGType type,
+                             TCGReg ret, const TCGArg *a)
+{
+    if (type == TCG_TYPE_V128) {
+        /* We assume that INDEX_op_dupi could not be used and
+           therefore we must use a constant pool entry.  */
+        new_pool_l2(s, R_AARCH64_CONDBR19, s->code_ptr, 0, a[0], a[1]);
+        tcg_out_insn(s, 3305, LDR_v128, 0, ret);
+    } else {
+        tcg_out_dupi_vec(s, TCG_TYPE_V64, ret, a[0]);
+    }
+}
+
 static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
                          tcg_target_long value)
 {
@@ -594,6 +840,22 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
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
+        tcg_out_dupi_vec(s, type, rd, value);
+        return;
+
+    default:
+        g_assert_not_reached();
+    }
+
     /* For 32-bit values, discard potential garbage in value.  For 64-bit
        values within [2**31, 2**32-1], we can create smaller sequences by
        interpreting this as a negative 32-bit number, while ensuring that
@@ -669,15 +931,13 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
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
@@ -695,32 +955,102 @@ static void tcg_out_ldst(TCGContext *s, AArch64Insn insn,
     tcg_out_ldst_r(s, insn, rd, rn, TCG_TYPE_I64, TCG_REG_TMP);
 }
 
-static inline void tcg_out_mov(TCGContext *s,
-                               TCGType type, TCGReg ret, TCGReg arg)
+static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
-    if (ret != arg) {
-        tcg_out_movr(s, type, ret, arg);
+    if (ret == arg) {
+        return;
+    }
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        if (ret < 32 && arg < 32) {
+            tcg_out_movr(s, type, ret, arg);
+            break;
+        } else if (ret < 32) {
+            tcg_out_insn(s, 3605, UMOV, type, ret, arg, 0, 0);
+            break;
+        } else if (arg < 32) {
+            tcg_out_insn(s, 3605, INS, 0, ret, arg, 4 << type, 0);
+            break;
+        }
+        /* FALLTHRU */
+
+    case TCG_TYPE_V64:
+        tcg_debug_assert(ret >= 32 && arg >= 32);
+        tcg_out_insn(s, 3616, ORR, 0, 0, ret, arg, arg);
+        break;
+    case TCG_TYPE_V128:
+        tcg_debug_assert(ret >= 32 && arg >= 32);
+        tcg_out_insn(s, 3616, ORR, 1, 0, ret, arg, arg);
+        break;
+
+    default:
+        g_assert_not_reached();
     }
 }
 
-static inline void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
-                              TCGReg arg1, intptr_t arg2)
+static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
+                       TCGReg base, intptr_t ofs)
 {
-    tcg_out_ldst(s, type == TCG_TYPE_I32 ? I3312_LDRW : I3312_LDRX,
-                 arg, arg1, arg2);
+    AArch64Insn insn;
+    int lgsz;
+
+    switch (type) {
+    case TCG_TYPE_I32:
+        insn = (ret < 32 ? I3312_LDRW : I3312_LDRVS);
+        lgsz = 2;
+        break;
+    case TCG_TYPE_I64:
+        insn = (ret < 32 ? I3312_LDRX : I3312_LDRVD);
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
+    tcg_out_ldst(s, insn, ret, base, ofs, lgsz);
 }
 
-static inline void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
-                              TCGReg arg1, intptr_t arg2)
+static void tcg_out_st(TCGContext *s, TCGType type, TCGReg src,
+                       TCGReg base, intptr_t ofs)
 {
-    tcg_out_ldst(s, type == TCG_TYPE_I32 ? I3312_STRW : I3312_STRX,
-                 arg, arg1, arg2);
+    AArch64Insn insn;
+    int lgsz;
+
+    switch (type) {
+    case TCG_TYPE_I32:
+        insn = (src < 32 ? I3312_STRW : I3312_STRVS);
+        lgsz = 2;
+        break;
+    case TCG_TYPE_I64:
+        insn = (src < 32 ? I3312_STRX : I3312_STRVD);
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
+    tcg_out_ldst(s, insn, src, base, ofs, lgsz);
 }
 
 static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
                                TCGReg base, intptr_t ofs)
 {
-    if (val == 0) {
+    if (type <= TCG_TYPE_I64 && val == 0) {
         tcg_out_st(s, type, TCG_REG_XZR, base, ofs);
         return true;
     }
@@ -1210,14 +1540,15 @@ static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp opc,
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
@@ -1435,49 +1766,49 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
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
@@ -1776,25 +2107,230 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
+    case INDEX_op_mov_vec:
     case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
     case INDEX_op_movi_i64:
+    case INDEX_op_dupi_vec:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
-        tcg_abort();
+        g_assert_not_reached();
     }
 
 #undef REG0
 }
 
+static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
+                           unsigned vecl, unsigned vece,
+                           const TCGArg *args, const int *const_args)
+{
+    static const AArch64Insn cmp_insn[16] = {
+        [TCG_COND_EQ] = I3616_CMEQ,
+        [TCG_COND_GT] = I3616_CMGT,
+        [TCG_COND_GE] = I3616_CMGE,
+        [TCG_COND_GTU] = I3616_CMHI,
+        [TCG_COND_GEU] = I3616_CMHS,
+    };
+    static const AArch64Insn cmp0_insn[16] = {
+        [TCG_COND_EQ] = I3617_CMEQ0,
+        [TCG_COND_GT] = I3617_CMGT0,
+        [TCG_COND_GE] = I3617_CMGE0,
+        [TCG_COND_LT] = I3617_CMLT0,
+        [TCG_COND_LE] = I3617_CMLE0,
+    };
+
+    TCGType type = vecl + TCG_TYPE_V64;
+    unsigned is_q = vecl;
+    TCGArg a0, a1, a2;
+
+    a0 = args[0];
+    a1 = args[1];
+    a2 = args[2];
+
+    switch (opc) {
+    case INDEX_op_movi_vec:
+        tcg_out_movi_vec(s, type, a0, args + 1);
+        break;
+    case INDEX_op_ld_vec:
+        tcg_out_ld(s, type, a0, a1, a2);
+        break;
+    case INDEX_op_st_vec:
+        tcg_out_st(s, type, a0, a1, a2);
+        break;
+    case INDEX_op_add_vec:
+        tcg_out_insn(s, 3616, ADD, is_q, vece, a0, a1, a2);
+        break;
+    case INDEX_op_sub_vec:
+        tcg_out_insn(s, 3616, SUB, is_q, vece, a0, a1, a2);
+        break;
+    case INDEX_op_mul_vec:
+        tcg_out_insn(s, 3616, MUL, is_q, vece, a0, a1, a2);
+        break;
+    case INDEX_op_neg_vec:
+        tcg_out_insn(s, 3617, NEG, is_q, vece, a0, a1);
+        break;
+    case INDEX_op_and_vec:
+        tcg_out_insn(s, 3616, AND, is_q, 0, a0, a1, a2);
+        break;
+    case INDEX_op_or_vec:
+        tcg_out_insn(s, 3616, ORR, is_q, 0, a0, a1, a2);
+        break;
+    case INDEX_op_xor_vec:
+        tcg_out_insn(s, 3616, EOR, is_q, 0, a0, a1, a2);
+        break;
+    case INDEX_op_andc_vec:
+        tcg_out_insn(s, 3616, BIC, is_q, 0, a0, a1, a2);
+        break;
+    case INDEX_op_orc_vec:
+        tcg_out_insn(s, 3616, ORN, is_q, 0, a0, a1, a2);
+        break;
+    case INDEX_op_not_vec:
+        tcg_out_insn(s, 3617, NOT, is_q, 0, a0, a1);
+        break;
+    case INDEX_op_dup_vec:
+        tcg_out_insn(s, 3605, DUP, is_q, a0, a1, 1 << vece, 0);
+        break;
+    case INDEX_op_shli_vec:
+        tcg_out_insn(s, 3614, SHL, is_q, a0, a1, a2 + (8 << vece));
+        break;
+    case INDEX_op_shri_vec:
+        tcg_out_insn(s, 3614, USHR, is_q, a0, a1, (16 << vece) - a2);
+        break;
+    case INDEX_op_sari_vec:
+        tcg_out_insn(s, 3614, SSHR, is_q, a0, a1, (16 << vece) - a2);
+        break;
+    case INDEX_op_cmp_vec:
+        {
+            TCGCond cond = args[3];
+            AArch64Insn insn;
+
+            if (cond == TCG_COND_NE) {
+                if (const_args[2]) {
+                    tcg_out_insn(s, 3616, CMTST, is_q, vece, a0, a1, a1);
+                } else {
+                    tcg_out_insn(s, 3616, CMEQ, is_q, vece, a0, a1, a2);
+                    tcg_out_insn(s, 3617, NOT, is_q, 0, a0, a0);
+                }
+            } else {
+                if (const_args[2]) {
+                    insn = cmp0_insn[cond];
+                    if (insn) {
+                        tcg_out_insn_3617(s, insn, is_q, vece, a0, a1);
+                        break;
+                    }
+                    tcg_out_dupi_vec(s, type, TCG_VEC_TMP, 0);
+                    a2 = TCG_VEC_TMP;
+                }
+                insn = cmp_insn[cond];
+                if (insn == 0) {
+                    TCGArg t;
+                    t = a1, a1 = a2, a2 = t;
+                    cond = tcg_swap_cond(cond);
+                    insn = cmp_insn[cond];
+                    tcg_debug_assert(insn != 0);
+                }
+                tcg_out_insn_3616(s, insn, is_q, vece, a0, a1, a2);
+            }
+        }
+        break;
+    case INDEX_op_zipl_vec:
+        tcg_out_insn(s, 3603, ZIP1, is_q, vece, a0, a1, a2);
+        break;
+    case INDEX_op_ziph_vec:
+        tcg_out_insn(s, 3603, ZIP2, is_q, vece, a0, a1, a2);
+        break;
+    case INDEX_op_uzpe_vec:
+        tcg_out_insn(s, 3603, UZP1, is_q, vece, a0, a1, a2);
+        break;
+    case INDEX_op_uzpo_vec:
+        tcg_out_insn(s, 3603, UZP2, is_q, vece, a0, a1, a2);
+        break;
+    case INDEX_op_trne_vec:
+        tcg_out_insn(s, 3603, TRN1, is_q, vece, a0, a1, a2);
+        break;
+    case INDEX_op_trno_vec:
+        tcg_out_insn(s, 3603, TRN2, is_q, vece, a0, a1, a2);
+        break;
+    case INDEX_op_extul_vec:
+        tcg_out_insn(s, 3614, USHLL, 0, a0, a1, 0 + (8 << vece));
+        break;
+    case INDEX_op_extuh_vec:
+        if (is_q) {
+            tcg_out_insn(s, 3614, USHLL, 1, a0, a1, 0 + (8 << vece));
+        } else {
+            tcg_out_insn(s, 3614, USHLL, 0, a0, a1, 0 + (8 << vece));
+            tcg_out_insn(s, 3605, INS, 0, a0, a0, 8, 16);
+        }
+        break;
+    case INDEX_op_extsl_vec:
+        tcg_out_insn(s, 3614, SSHLL, 0, a0, a1, 0 + (8 << vece));
+        break;
+    case INDEX_op_extsh_vec:
+        if (is_q) {
+            tcg_out_insn(s, 3614, SSHLL, 1, a0, a1, 0 + (8 << vece));
+        } else {
+            tcg_out_insn(s, 3614, SSHLL, 0, a0, a1, 0 + (8 << vece));
+            tcg_out_insn(s, 3605, INS, 0, a0, a0, 8, 16);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
+{
+    switch (opc) {
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_mul_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_andc_vec:
+    case INDEX_op_orc_vec:
+    case INDEX_op_neg_vec:
+    case INDEX_op_not_vec:
+    case INDEX_op_cmp_vec:
+    case INDEX_op_zipl_vec:
+    case INDEX_op_ziph_vec:
+    case INDEX_op_uzpe_vec:
+    case INDEX_op_uzpo_vec:
+    case INDEX_op_trne_vec:
+    case INDEX_op_trno_vec:
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_sari_vec:
+    case INDEX_op_extul_vec:
+    case INDEX_op_extuh_vec:
+    case INDEX_op_extsl_vec:
+    case INDEX_op_extsh_vec:
+        return 1;
+
+    default:
+        return 0;
+    }
+}
+
+void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
+                       TCGArg a0, ...)
+{
+}
+
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
     static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
+    static const TCGTargetOpDef w = { .args_ct_str = { "w" } };
     static const TCGTargetOpDef r_r = { .args_ct_str = { "r", "r" } };
+    static const TCGTargetOpDef w_w = { .args_ct_str = { "w", "w" } };
+    static const TCGTargetOpDef w_r = { .args_ct_str = { "w", "r" } };
+    static const TCGTargetOpDef w_wr = { .args_ct_str = { "w", "wr" } };
     static const TCGTargetOpDef r_l = { .args_ct_str = { "r", "l" } };
     static const TCGTargetOpDef r_rA = { .args_ct_str = { "r", "rA" } };
     static const TCGTargetOpDef rZ_r = { .args_ct_str = { "rZ", "r" } };
     static const TCGTargetOpDef lZ_l = { .args_ct_str = { "lZ", "l" } };
     static const TCGTargetOpDef r_r_r = { .args_ct_str = { "r", "r", "r" } };
+    static const TCGTargetOpDef w_w_w = { .args_ct_str = { "w", "w", "w" } };
+    static const TCGTargetOpDef w_w_wZ = { .args_ct_str = { "w", "w", "wZ" } };
     static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
     static const TCGTargetOpDef r_r_rA = { .args_ct_str = { "r", "r", "rA" } };
     static const TCGTargetOpDef r_r_rL = { .args_ct_str = { "r", "r", "rL" } };
@@ -1938,6 +2474,41 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sub2_i64:
         return &add2;
 
+    case INDEX_op_movi_vec:
+        return &w;
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_mul_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_andc_vec:
+    case INDEX_op_orc_vec:
+    case INDEX_op_zipl_vec:
+    case INDEX_op_ziph_vec:
+    case INDEX_op_uzpe_vec:
+    case INDEX_op_uzpo_vec:
+    case INDEX_op_trne_vec:
+    case INDEX_op_trno_vec:
+        return &w_w_w;
+    case INDEX_op_not_vec:
+    case INDEX_op_neg_vec:
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_sari_vec:
+    case INDEX_op_extul_vec:
+    case INDEX_op_extuh_vec:
+    case INDEX_op_extsl_vec:
+    case INDEX_op_extsh_vec:
+        return &w_w;
+    case INDEX_op_ld_vec:
+    case INDEX_op_st_vec:
+        return &w_r;
+    case INDEX_op_dup_vec:
+        return &w_wr;
+    case INDEX_op_cmp_vec:
+        return &w_w_wZ;
+
     default:
         return NULL;
     }
@@ -1947,8 +2518,10 @@ static void tcg_target_init(TCGContext *s)
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
@@ -1960,12 +2533,21 @@ static void tcg_target_init(TCGContext *s)
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
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_FP);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_X18); /* platform register */
+    tcg_regset_set_reg(s->reserved_regs, TCG_VEC_TMP);
 }
 
 /* Saving pairs: (X19, X20) .. (X27, X28), (X29(fp), X30(lr)).  */
-- 
2.14.3
