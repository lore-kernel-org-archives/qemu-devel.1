Received: from eggs.gnu.org ([209.51.188.92]:33456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9Jm-0004vg-GH
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9Jl-0007m9-4p
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:26 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:43910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1go9Jk-0007ka-Tj
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:25 -0500
Received: by mail-pg1-x52c.google.com with SMTP id v28so7381494pgk.10
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 07:59:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 07:58:53 -0800
Message-Id: <20190128155907.20607-10-richard.henderson@linaro.org>
In-Reply-To: <20190128155907.20607-1-richard.henderson@linaro.org>
References: <20190128155907.20607-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 09/23] tcg/aarch64: Implement vector saturating
 arithmetic
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
 tcg/aarch64/tcg-target.h     |  2 +-
 tcg/aarch64/tcg-target.inc.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 545a6eec75..a1884543d0 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -135,7 +135,7 @@ typedef enum {
 #define TCG_TARGET_HAS_shv_vec          0
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
-#define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       0
 
 #define TCG_TARGET_DEFAULT_MO (0)
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 0562e0aa40..b2b011f130 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -528,6 +528,10 @@ typedef enum {
     I3616_CMHI      = 0x2e203400,
     I3616_CMHS      = 0x2e203c00,
     I3616_CMEQ      = 0x2e208c00,
+    I3616_SQADD     = 0x0e200c00,
+    I3616_SQSUB     = 0x0e202c00,
+    I3616_UQADD     = 0x2e200c00,
+    I3616_UQSUB     = 0x2e202c00,
 
     /* AdvSIMD two-reg misc.  */
     I3617_CMGT0     = 0x0e208800,
@@ -2137,6 +2141,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_orc_vec:
         tcg_out_insn(s, 3616, ORN, is_q, 0, a0, a1, a2);
         break;
+    case INDEX_op_ssadd_vec:
+        tcg_out_insn(s, 3616, SQADD, is_q, vece, a0, a1, a2);
+        break;
+    case INDEX_op_sssub_vec:
+        tcg_out_insn(s, 3616, SQSUB, is_q, vece, a0, a1, a2);
+        break;
+    case INDEX_op_usadd_vec:
+        tcg_out_insn(s, 3616, UQADD, is_q, vece, a0, a1, a2);
+        break;
+    case INDEX_op_ussub_vec:
+        tcg_out_insn(s, 3616, UQSUB, is_q, vece, a0, a1, a2);
+        break;
     case INDEX_op_not_vec:
         tcg_out_insn(s, 3617, NOT, is_q, 0, a0, a1);
         break;
@@ -2207,6 +2223,10 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
         return 1;
     case INDEX_op_mul_vec:
         return vece < MO_64;
@@ -2386,6 +2406,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_xor_vec:
     case INDEX_op_andc_vec:
     case INDEX_op_orc_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
         return &w_w_w;
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
-- 
2.17.2
