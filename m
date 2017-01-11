Received: from eggs.gnu.org ([2001:4830:134:3::10]:35887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VR-0006pG-5g
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VQ-0003ei-4k
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:17 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8VP-0003eT-Vd
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:16 -0500
Received: by mail-pf0-x242.google.com with SMTP id 127so31460019pfg.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:19:15 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:18:19 -0800
Message-Id: <20170111021820.24416-65-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 64/65] tcg/ppc: Handle ctpop opcode
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
 tcg/ppc/tcg-target.h     |  5 +++--
 tcg/ppc/tcg-target.inc.c | 12 +++++++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 57e66cf..abd8b3d 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -49,6 +49,7 @@ typedef enum {
     TCG_AREG0 = TCG_REG_R27
 } TCGReg;
 
+extern bool have_isa_2_06;
 extern bool have_isa_3_00;
 
 /* optional instructions automatically implemented */
@@ -72,7 +73,7 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_nor_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          have_isa_3_00
-#define TCG_TARGET_HAS_ctpop_i32        0
+#define TCG_TARGET_HAS_ctpop_i32        have_isa_2_06
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     0
@@ -108,7 +109,7 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_nor_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          have_isa_3_00
-#define TCG_TARGET_HAS_ctpop_i64        0
+#define TCG_TARGET_HAS_ctpop_i64        have_isa_2_06
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 766bc1a..64f67d2 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -83,7 +83,7 @@ static tcg_insn_unit *tb_ret_addr;
 
 #include "elf.h"
 
-static bool have_isa_2_06;
+bool have_isa_2_06;
 bool have_isa_3_00;
 
 #define HAVE_ISA_2_06  have_isa_2_06
@@ -457,6 +457,8 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define CNTLZD XO31( 58)
 #define CNTTZW XO31(538)
 #define CNTTZD XO31(570)
+#define CNTPOPW XO31(378)
+#define CNTPOPD XO31(506)
 #define ANDC   XO31( 60)
 #define ORC    XO31(412)
 #define EQV    XO31(284)
@@ -2149,6 +2151,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
         tcg_out_cntxz(s, TCG_TYPE_I32, CNTTZW, args[0], args[1],
                       args[2], const_args[2]);
         break;
+    case INDEX_op_ctpop_i32:
+        tcg_out32(s, CNTPOPW | SAB(args[1], args[0], 0));
+        break;
 
     case INDEX_op_clz_i64:
         tcg_out_cntxz(s, TCG_TYPE_I64, CNTLZD, args[0], args[1],
@@ -2158,6 +2163,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
         tcg_out_cntxz(s, TCG_TYPE_I64, CNTTZD, args[0], args[1],
                       args[2], const_args[2]);
         break;
+    case INDEX_op_ctpop_i64:
+        tcg_out32(s, CNTPOPD | SAB(args[1], args[0], 0));
+        break;
 
     case INDEX_op_mul_i32:
         a0 = args[0], a1 = args[1], a2 = args[2];
@@ -2573,6 +2581,7 @@ static const TCGTargetOpDef ppc_op_defs[] = {
     { INDEX_op_nor_i32, { "r", "r", "r" } },
     { INDEX_op_clz_i32, { "r", "r", "rZW" } },
     { INDEX_op_ctz_i32, { "r", "r", "rZW" } },
+    { INDEX_op_ctpop_i32, { "r", "r" } },
 
     { INDEX_op_shl_i32, { "r", "r", "ri" } },
     { INDEX_op_shr_i32, { "r", "r", "ri" } },
@@ -2623,6 +2632,7 @@ static const TCGTargetOpDef ppc_op_defs[] = {
     { INDEX_op_nor_i64, { "r", "r", "r" } },
     { INDEX_op_clz_i64, { "r", "r", "rZW" } },
     { INDEX_op_ctz_i64, { "r", "r", "rZW" } },
+    { INDEX_op_ctpop_i64, { "r", "r" } },
 
     { INDEX_op_shl_i64, { "r", "r", "ri" } },
     { INDEX_op_shr_i64, { "r", "r", "ri" } },
-- 
2.9.3
