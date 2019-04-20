Received: from eggs.gnu.org ([209.51.188.92]:40579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXY-00012z-Rb
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXW-0000nL-Ft
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:00 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXW-0000Do-6g
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:58 -0400
Received: by mail-pf1-x442.google.com with SMTP id i17so3465924pfo.6
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 19 Apr 2019 21:34:34 -1000
Message-Id: <20190420073442.7488-31-richard.henderson@linaro.org>
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 30/38] tcg/aarch64: Support vector comparison
 select value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com

The instruction set has 3 insns that perform the same operation,
only varying in which operand must overlap the destination.  We
can represent the operation without overlap and choose based on
the operands seen.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     |  2 +-
 tcg/aarch64/tcg-target.inc.c | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index e1135e930a..e030bf3c8f 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -140,7 +140,7 @@ typedef enum {
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
-#define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       1
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index cf891defd4..84d402acd8 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -525,6 +525,9 @@ typedef enum {
     I3616_ADD       = 0x0e208400,
     I3616_AND       = 0x0e201c00,
     I3616_BIC       = 0x0e601c00,
+    I3616_BIF       = 0x2ee01c00,
+    I3616_BIT       = 0x2ea01c00,
+    I3616_BSL       = 0x2e601c00,
     I3616_EOR       = 0x2e201c00,
     I3616_MUL       = 0x0e209c00,
     I3616_ORR       = 0x0ea01c00,
@@ -2178,7 +2181,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 
     TCGType type = vecl + TCG_TYPE_V64;
     unsigned is_q = vecl;
-    TCGArg a0, a1, a2;
+    TCGArg a0, a1, a2, a3;
 
     a0 = args[0];
     a1 = args[1];
@@ -2301,6 +2304,20 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_cmpsel_vec:
+        a3 = args[3];
+        if (a0 == a3) {
+            tcg_out_insn(s, 3616, BIT, is_q, 0, a0, a2, a1);
+        } else if (a0 == a2) {
+            tcg_out_insn(s, 3616, BIF, is_q, 0, a0, a3, a1);
+        } else {
+            if (a0 != a1) {
+                tcg_out_mov(s, type, a0, a1);
+            }
+            tcg_out_insn(s, 3616, BSL, is_q, 0, a0, a2, a3);
+        }
+        break;
+
     case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
     case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
@@ -2323,6 +2340,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_abs_vec:
     case INDEX_op_not_vec:
     case INDEX_op_cmp_vec:
+    case INDEX_op_cmpsel_vec:
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
@@ -2405,6 +2423,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "r", "r", "rA", "rZ", "rZ" } };
     static const TCGTargetOpDef add2
         = { .args_ct_str = { "r", "r", "rZ", "rZ", "rA", "rMZ" } };
+    static const TCGTargetOpDef w_w_w_w
+        = { .args_ct_str = { "w", "w", "w", "w" } };
 
     switch (op) {
     case INDEX_op_goto_ptr:
@@ -2577,6 +2597,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &w_wr;
     case INDEX_op_cmp_vec:
         return &w_w_wZ;
+    case INDEX_op_cmpsel_vec:
+        return &w_w_w_w;
 
     default:
         return NULL;
-- 
2.17.1
