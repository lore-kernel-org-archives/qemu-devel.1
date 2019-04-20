Received: from eggs.gnu.org ([209.51.188.92]:40517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXX-00011a-DZ
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXW-0000mm-6F
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:59 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXU-00006M-VL
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:57 -0400
Received: by mail-pf1-x441.google.com with SMTP id c207so3462049pfc.7
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 19 Apr 2019 21:34:31 -1000
Message-Id: <20190420073442.7488-28-richard.henderson@linaro.org>
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 27/38] tcg/aarch64: Support vector absolute
 value
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     | 2 +-
 tcg/aarch64/tcg-target.inc.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 21d06d928c..e43554c3c7 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -132,7 +132,7 @@ typedef enum {
 #define TCG_TARGET_HAS_orc_vec          1
 #define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          1
-#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_abs_vec          1
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 7d2a8213ec..cf891defd4 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -554,6 +554,7 @@ typedef enum {
     I3617_CMGE0     = 0x2e208800,
     I3617_CMLE0     = 0x2e20a800,
     I3617_NOT       = 0x2e205800,
+    I3617_ABS       = 0x0e20b800,
     I3617_NEG       = 0x2e20b800,
 
     /* System instructions.  */
@@ -2205,6 +2206,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_neg_vec:
         tcg_out_insn(s, 3617, NEG, is_q, vece, a0, a1);
         break;
+    case INDEX_op_abs_vec:
+        tcg_out_insn(s, 3617, ABS, is_q, vece, a0, a1);
+        break;
     case INDEX_op_and_vec:
         tcg_out_insn(s, 3616, AND, is_q, 0, a0, a1, a2);
         break;
@@ -2316,6 +2320,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_andc_vec:
     case INDEX_op_orc_vec:
     case INDEX_op_neg_vec:
+    case INDEX_op_abs_vec:
     case INDEX_op_not_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_shli_vec:
@@ -2559,6 +2564,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &w_w_w;
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
+    case INDEX_op_abs_vec:
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
-- 
2.17.1
