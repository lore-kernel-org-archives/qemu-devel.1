Received: from eggs.gnu.org ([2001:4830:134:3::10]:35494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8V7-0006US-R0
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8V6-0003PD-Mv
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:57 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8V6-0003Ox-Fq
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:56 -0500
Received: by mail-pf0-x242.google.com with SMTP id 127so31458840pfg.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:56 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:55 -0800
Message-Id: <20170111021820.24416-41-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 40/65] tcg/ppc: Handle ctz and clz opcodes
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
 tcg/ppc/tcg-target.h     | 10 +++++---
 tcg/ppc/tcg-target.inc.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 698a599..c798c9c 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -49,6 +49,8 @@ typedef enum {
     TCG_AREG0 = TCG_REG_R27
 } TCGReg;
 
+extern bool have_isa_3_00;
+
 /* optional instructions automatically implemented */
 #define TCG_TARGET_HAS_ext8u_i32        0 /* andi */
 #define TCG_TARGET_HAS_ext16u_i32       0
@@ -68,8 +70,8 @@ typedef enum {
 #define TCG_TARGET_HAS_eqv_i32          1
 #define TCG_TARGET_HAS_nand_i32         1
 #define TCG_TARGET_HAS_nor_i32          1
-#define TCG_TARGET_HAS_clz_i32          0
-#define TCG_TARGET_HAS_ctz_i32          0
+#define TCG_TARGET_HAS_clz_i32          1
+#define TCG_TARGET_HAS_ctz_i32          have_isa_3_00
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     0
@@ -103,8 +105,8 @@ typedef enum {
 #define TCG_TARGET_HAS_eqv_i64          1
 #define TCG_TARGET_HAS_nand_i64         1
 #define TCG_TARGET_HAS_nor_i64          1
-#define TCG_TARGET_HAS_clz_i64          0
-#define TCG_TARGET_HAS_ctz_i64          0
+#define TCG_TARGET_HAS_clz_i64          1
+#define TCG_TARGET_HAS_ctz_i64          have_isa_3_00
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index bf17161..766bc1a 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -77,11 +77,15 @@
 #define TCG_CT_CONST_U32  0x800
 #define TCG_CT_CONST_ZERO 0x1000
 #define TCG_CT_CONST_MONE 0x2000
+#define TCG_CT_CONST_WSZ  0x4000
 
 static tcg_insn_unit *tb_ret_addr;
 
 #include "elf.h"
+
 static bool have_isa_2_06;
+bool have_isa_3_00;
+
 #define HAVE_ISA_2_06  have_isa_2_06
 #define HAVE_ISEL      have_isa_2_06
 
@@ -305,6 +309,9 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     case 'U':
         ct->ct |= TCG_CT_CONST_U32;
         break;
+    case 'W':
+        ct->ct |= TCG_CT_CONST_WSZ;
+        break;
     case 'Z':
         ct->ct |= TCG_CT_CONST_ZERO;
         break;
@@ -341,6 +348,9 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
         return 1;
     } else if ((ct & TCG_CT_CONST_MONE) && val == -1) {
         return 1;
+    } else if ((ct & TCG_CT_CONST_WSZ)
+               && val == (type == TCG_TYPE_I32 ? 32 : 64)) {
+        return 1;
     }
     return 0;
 }
@@ -445,6 +455,8 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define NOR    XO31(124)
 #define CNTLZW XO31( 26)
 #define CNTLZD XO31( 58)
+#define CNTTZW XO31(538)
+#define CNTTZD XO31(570)
 #define ANDC   XO31( 60)
 #define ORC    XO31(412)
 #define EQV    XO31(284)
@@ -1166,6 +1178,32 @@ static void tcg_out_movcond(TCGContext *s, TCGType type, TCGCond cond,
     }
 }
 
+static void tcg_out_cntxz(TCGContext *s, TCGType type, uint32_t opc,
+                          TCGArg a0, TCGArg a1, TCGArg a2, bool const_a2)
+{
+    if (const_a2 && a2 == (type == TCG_TYPE_I32 ? 32 : 64)) {
+        tcg_out32(s, opc | RA(a0) | RS(a1));
+    } else {
+        tcg_out_cmp(s, TCG_COND_EQ, a1, 0, 1, 7, type);
+        /* Note that the only other valid constant for a2 is 0.  */
+        if (HAVE_ISEL) {
+            tcg_out32(s, opc | RA(TCG_REG_R0) | RS(a1));
+            tcg_out32(s, tcg_to_isel[TCG_COND_EQ] | TAB(a0, a2, TCG_REG_R0));
+        } else if (!const_a2 && a0 == a2) {
+            tcg_out32(s, tcg_to_bc[TCG_COND_EQ] | 8);
+            tcg_out32(s, opc | RA(a0) | RS(a1));
+        } else {
+            tcg_out32(s, opc | RA(a0) | RS(a1));
+            tcg_out32(s, tcg_to_bc[TCG_COND_NE] | 8);
+            if (const_a2) {
+                tcg_out_movi(s, type, a0, 0);
+            } else {
+                tcg_out_mov(s, type, a0, a2);
+            }
+        }
+    }
+}
+
 static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
                          const int *const_args)
 {
@@ -2103,6 +2141,24 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
         tcg_out32(s, NOR | SAB(args[1], args[0], args[2]));
         break;
 
+    case INDEX_op_clz_i32:
+        tcg_out_cntxz(s, TCG_TYPE_I32, CNTLZW, args[0], args[1],
+                      args[2], const_args[2]);
+        break;
+    case INDEX_op_ctz_i32:
+        tcg_out_cntxz(s, TCG_TYPE_I32, CNTTZW, args[0], args[1],
+                      args[2], const_args[2]);
+        break;
+
+    case INDEX_op_clz_i64:
+        tcg_out_cntxz(s, TCG_TYPE_I64, CNTLZD, args[0], args[1],
+                      args[2], const_args[2]);
+        break;
+    case INDEX_op_ctz_i64:
+        tcg_out_cntxz(s, TCG_TYPE_I64, CNTTZD, args[0], args[1],
+                      args[2], const_args[2]);
+        break;
+
     case INDEX_op_mul_i32:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
@@ -2515,6 +2571,8 @@ static const TCGTargetOpDef ppc_op_defs[] = {
     { INDEX_op_eqv_i32, { "r", "r", "ri" } },
     { INDEX_op_nand_i32, { "r", "r", "r" } },
     { INDEX_op_nor_i32, { "r", "r", "r" } },
+    { INDEX_op_clz_i32, { "r", "r", "rZW" } },
+    { INDEX_op_ctz_i32, { "r", "r", "rZW" } },
 
     { INDEX_op_shl_i32, { "r", "r", "ri" } },
     { INDEX_op_shr_i32, { "r", "r", "ri" } },
@@ -2563,6 +2621,8 @@ static const TCGTargetOpDef ppc_op_defs[] = {
     { INDEX_op_eqv_i64, { "r", "r", "r" } },
     { INDEX_op_nand_i64, { "r", "r", "r" } },
     { INDEX_op_nor_i64, { "r", "r", "r" } },
+    { INDEX_op_clz_i64, { "r", "r", "rZW" } },
+    { INDEX_op_ctz_i64, { "r", "r", "rZW" } },
 
     { INDEX_op_shl_i64, { "r", "r", "ri" } },
     { INDEX_op_shr_i64, { "r", "r", "ri" } },
@@ -2645,9 +2705,16 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 static void tcg_target_init(TCGContext *s)
 {
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
+    unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
+
     if (hwcap & PPC_FEATURE_ARCH_2_06) {
         have_isa_2_06 = true;
     }
+#ifdef PPC_FEATURE2_ARCH_3_00
+    if (hwcap2 & PPC_FEATURE2_ARCH_3_00) {
+        have_isa_3_00 = true;
+    }
+#endif
 
     tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I32], 0, 0xffffffff);
     tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I64], 0, 0xffffffff);
-- 
2.9.3
