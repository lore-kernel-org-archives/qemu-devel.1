Received: from eggs.gnu.org ([209.51.188.92]:47960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aO-0008R4-96
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aN-0006Ll-7Q
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:32 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:45495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aN-0006KW-1s
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:31 -0400
Received: by mail-pg1-x533.google.com with SMTP id y27so1205418pgl.12
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 26 Apr 2019 10:24:11 -0700
Message-Id: <20190426172421.27133-6-richard.henderson@linaro.org>
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 05/15] tcg/i386: Support INDEX_op_extract2_{i32,
 i64}
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  4 ++--
 tcg/i386/tcg-target.inc.c | 11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 2c58eaa9ed..241bf19413 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -124,7 +124,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
-#define TCG_TARGET_HAS_extract2_i32     0
+#define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -163,7 +163,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
-#define TCG_TARGET_HAS_extract2_i64     0
+#define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index e0670e5098..1fa833840e 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -452,6 +452,7 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_SHUFPS      (0xc6 | P_EXT)
 #define OPC_SHLX        (0xf7 | P_EXT38 | P_DATA16)
 #define OPC_SHRX        (0xf7 | P_EXT38 | P_SIMDF2)
+#define OPC_SHRD_Ib     (0xac | P_EXT)
 #define OPC_TESTL	(0x85)
 #define OPC_TZCNT       (0xbc | P_EXT | P_SIMDF3)
 #define OPC_UD2         (0x0b | P_EXT)
@@ -2587,6 +2588,12 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    OP_32_64(extract2):
+        /* Note that SHRD outputs to the r/m operand.  */
+        tcg_out_modrm(s, OPC_SHRD_Ib + rexw, a2, a0);
+        tcg_out8(s, args[3]);
+        break;
+
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
@@ -2845,6 +2852,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef r_0 = { .args_ct_str = { "r", "0" } };
     static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
     static const TCGTargetOpDef r_r_re = { .args_ct_str = { "r", "r", "re" } };
+    static const TCGTargetOpDef r_0_r = { .args_ct_str = { "r", "0", "r" } };
     static const TCGTargetOpDef r_0_re = { .args_ct_str = { "r", "0", "re" } };
     static const TCGTargetOpDef r_0_ci = { .args_ct_str = { "r", "0", "ci" } };
     static const TCGTargetOpDef r_L = { .args_ct_str = { "r", "L" } };
@@ -2970,6 +2978,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ctpop_i32:
     case INDEX_op_ctpop_i64:
         return &r_r;
+    case INDEX_op_extract2_i32:
+    case INDEX_op_extract2_i64:
+        return &r_0_r;
 
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
-- 
2.17.1
