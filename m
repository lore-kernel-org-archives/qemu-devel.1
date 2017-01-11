Received: from eggs.gnu.org ([2001:4830:134:3::10]:35546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VA-0006Yb-S4
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8V9-0003Qr-D6
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:00 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8V9-0003QR-6G
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:59 -0500
Received: by mail-pf0-x243.google.com with SMTP id b22so15072990pfd.3
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:59 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:58 -0800
Message-Id: <20170111021820.24416-44-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 43/65] tcg/mips: Handle clz opcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/mips/tcg-target.h     |  6 ++++--
 tcg/mips/tcg-target.inc.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 06988cf..a680f16 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -121,8 +121,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_nor_i32          1
-#define TCG_TARGET_HAS_clz_i32          0
-#define TCG_TARGET_HAS_ctz_i32          0
 #define TCG_TARGET_HAS_andc_i32         0
 #define TCG_TARGET_HAS_orc_i32          0
 #define TCG_TARGET_HAS_eqv_i32          0
@@ -165,6 +163,8 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
 #define TCG_TARGET_HAS_rot_i32          use_mips32r2_instructions
+#define TCG_TARGET_HAS_clz_i32          use_mips32r2_instructions
+#define TCG_TARGET_HAS_ctz_i32          0
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_movcond_i64      use_movnz_instructions
@@ -177,6 +177,8 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_ext8s_i64        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i64       use_mips32r2_instructions
 #define TCG_TARGET_HAS_rot_i64          use_mips32r2_instructions
+#define TCG_TARGET_HAS_clz_i64          use_mips32r2_instructions
+#define TCG_TARGET_HAS_ctz_i64          0
 #endif
 
 /* optional instructions automatically implemented */
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index ea20891..01ac7b2 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -179,6 +179,7 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
 #define TCG_CT_CONST_S16  0x400    /* Signed 16-bit: -32768 - 32767 */
 #define TCG_CT_CONST_P2M1 0x800    /* Power of 2 minus 1.  */
 #define TCG_CT_CONST_N16  0x1000   /* "Negatable" 16-bit: -32767 - 32767 */
+#define TCG_CT_CONST_WSZ  0x2000   /* word size */
 
 static inline bool is_p2m1(tcg_target_long val)
 {
@@ -229,6 +230,9 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     case 'N':
         ct->ct |= TCG_CT_CONST_N16;
         break;
+    case 'W':
+        ct->ct |= TCG_CT_CONST_WSZ;
+        break;
     case 'Z':
         /* We are cheating a bit here, using the fact that the register
            ZERO is also the register number 0. Hence there is no need
@@ -260,6 +264,9 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
     } else if ((ct & TCG_CT_CONST_P2M1)
                && use_mips32r2_instructions && is_p2m1(val)) {
         return 1;
+    } else if ((ct & TCG_CT_CONST_WSZ)
+               && val == (type == TCG_TYPE_I32 ? 32 : 64)) {
+        return 1;
     }
     return 0;
 }
@@ -356,6 +363,8 @@ typedef enum {
     OPC_DSRL32   = OPC_SPECIAL | 076,
     OPC_DROTR32  = OPC_SPECIAL | 076 | (1 << 21),
     OPC_DSRA32   = OPC_SPECIAL | 077,
+    OPC_CLZ_R6   = OPC_SPECIAL | 0120,
+    OPC_DCLZ_R6  = OPC_SPECIAL | 0122,
 
     OPC_REGIMM   = 001 << 26,
     OPC_BLTZ     = OPC_REGIMM | (000 << 16),
@@ -363,6 +372,8 @@ typedef enum {
 
     OPC_SPECIAL2 = 034 << 26,
     OPC_MUL_R5   = OPC_SPECIAL2 | 002,
+    OPC_CLZ      = OPC_SPECIAL2 | 040,
+    OPC_DCLZ     = OPC_SPECIAL2 | 044,
 
     OPC_SPECIAL3 = 037 << 26,
     OPC_EXT      = OPC_SPECIAL3 | 000,
@@ -1664,6 +1675,33 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
     tcg_out32(s, sync[a0 & TCG_MO_ALL]);
 }
 
+static void tcg_out_clz(TCGContext *s, MIPSInsn opcv2, MIPSInsn opcv6,
+                        int width, TCGReg a0, TCGReg a1, TCGArg a2)
+{
+    if (use_mips32r6_instructions) {
+        if (a2 == width) {
+            tcg_out_opc_reg(s, opcv6, a0, a1, 0);
+        } else {
+            tcg_out_opc_reg(s, opcv6, TCG_TMP0, a1, 0);
+            tcg_out_movcond(s, TCG_COND_EQ, a0, a1, 0, a2, TCG_TMP0);
+        }
+    } else {
+        if (a2 == width) {
+            tcg_out_opc_reg(s, opcv2, a0, a1, a1);
+        } else if (a0 == a2) {
+            tcg_out_opc_reg(s, opcv2, TCG_TMP0, a1, a1);
+            tcg_out_opc_reg(s, OPC_MOVN, a0, TCG_TMP0, a1);
+        } else if (a0 != a1) {
+            tcg_out_opc_reg(s, opcv2, a0, a1, a1);
+            tcg_out_opc_reg(s, OPC_MOVZ, a0, a2, a1);
+        } else {
+            tcg_out_opc_reg(s, opcv2, TCG_TMP0, a1, a1);
+            tcg_out_opc_reg(s, OPC_MOVZ, TCG_TMP0, a2, a1);
+            tcg_out_mov(s, TCG_TYPE_REG, a0, TCG_TMP0);
+        }
+    }
+}
+
 static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
                               const TCGArg *args, const int *const_args)
 {
@@ -2040,6 +2078,13 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_clz_i32:
+        tcg_out_clz(s, OPC_CLZ, OPC_CLZ_R6, 32, a0, a1, a2);
+        break;
+    case INDEX_op_clz_i64:
+        tcg_out_clz(s, OPC_DCLZ, OPC_DCLZ_R6, 64, a0, a1, a2);
+        break;
+
     case INDEX_op_deposit_i32:
         tcg_out_opc_bf(s, OPC_INS, a0, a2, args[3] + args[4] - 1, args[3]);
         break;
@@ -2150,6 +2195,7 @@ static const TCGTargetOpDef mips_op_defs[] = {
     { INDEX_op_sar_i32, { "r", "rZ", "ri" } },
     { INDEX_op_rotr_i32, { "r", "rZ", "ri" } },
     { INDEX_op_rotl_i32, { "r", "rZ", "ri" } },
+    { INDEX_op_clz_i32,  { "r", "r", "rWZ" } },
 
     { INDEX_op_bswap16_i32, { "r", "r" } },
     { INDEX_op_bswap32_i32, { "r", "r" } },
@@ -2213,6 +2259,7 @@ static const TCGTargetOpDef mips_op_defs[] = {
     { INDEX_op_sar_i64, { "r", "rZ", "ri" } },
     { INDEX_op_rotr_i64, { "r", "rZ", "ri" } },
     { INDEX_op_rotl_i64, { "r", "rZ", "ri" } },
+    { INDEX_op_clz_i64,  { "r", "r", "rWZ" } },
 
     { INDEX_op_bswap16_i64, { "r", "r" } },
     { INDEX_op_bswap32_i64, { "r", "r" } },
-- 
2.9.3
