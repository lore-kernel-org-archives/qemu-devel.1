Received: from eggs.gnu.org ([209.51.188.92]:47972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aP-0008SO-GE
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aO-0006Qu-Dj
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:33 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:38576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aO-0006N7-7Y
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:32 -0400
Received: by mail-pf1-x429.google.com with SMTP id 10so2048734pfo.5
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 26 Apr 2019 10:24:12 -0700
Message-Id: <20190426172421.27133-7-richard.henderson@linaro.org>
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/15] tcg/arm: Support INDEX_op_extract2_i32
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.h     |  2 +-
 tcg/arm/tcg-target.inc.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 4ee6c98958..17e771374d 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -116,7 +116,7 @@ extern bool use_idiv_instructions;
 #define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
 #define TCG_TARGET_HAS_extract_i32      use_armv7_instructions
 #define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
-#define TCG_TARGET_HAS_extract2_i32     0
+#define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_mulu2_i32        1
 #define TCG_TARGET_HAS_muls2_i32        1
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 2245a8aeb9..6873b0cf95 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -2064,6 +2064,27 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sextract_i32:
         tcg_out_sextract(s, COND_AL, args[0], args[1], args[2], args[3]);
         break;
+    case INDEX_op_extract2_i32:
+        /* ??? These optimization vs zero should be generic.  */
+        /* ??? But we can't substitute 2 for 1 in the opcode stream yet.  */
+        if (const_args[1]) {
+            if (const_args[2]) {
+                tcg_out_movi(s, TCG_TYPE_REG, args[0], 0);
+            } else {
+                tcg_out_dat_reg(s, COND_AL, ARITH_MOV, args[0], 0,
+                                args[2], SHIFT_IMM_LSL(32 - args[3]));
+            }
+        } else if (const_args[2]) {
+            tcg_out_dat_reg(s, COND_AL, ARITH_MOV, args[0], 0,
+                            args[1], SHIFT_IMM_LSR(args[3]));
+        } else {
+            /* We can do extract2 in 2 insns, vs the 3 required otherwise.  */
+            tcg_out_dat_reg(s, COND_AL, ARITH_MOV, TCG_REG_TMP, 0,
+                            args[2], SHIFT_IMM_LSL(32 - args[3]));
+            tcg_out_dat_reg(s, COND_AL, ARITH_ORR, args[0], TCG_REG_TMP,
+                            args[1], SHIFT_IMM_LSR(args[3]));
+        }
+        break;
 
     case INDEX_op_div_i32:
         tcg_out_sdiv(s, COND_AL, args[0], args[1], args[2]);
@@ -2108,6 +2129,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "s", "s", "s", "s" } };
     static const TCGTargetOpDef br
         = { .args_ct_str = { "r", "rIN" } };
+    static const TCGTargetOpDef ext2
+        = { .args_ct_str = { "r", "rZ", "rZ" } };
     static const TCGTargetOpDef dep
         = { .args_ct_str = { "r", "0", "rZ" } };
     static const TCGTargetOpDef movc
@@ -2174,6 +2197,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &br;
     case INDEX_op_deposit_i32:
         return &dep;
+    case INDEX_op_extract2_i32:
+        return &ext2;
     case INDEX_op_movcond_i32:
         return &movc;
     case INDEX_op_add2_i32:
-- 
2.17.1
