Received: from eggs.gnu.org ([209.51.188.92]:33509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9K1-000583-20
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9Jw-0007qC-F9
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:39 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:40214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1go9Jp-0007mw-VV
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:31 -0500
Received: by mail-pl1-x635.google.com with SMTP id u18so7917175plq.7
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 07:59:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 07:58:54 -0800
Message-Id: <20190128155907.20607-11-richard.henderson@linaro.org>
In-Reply-To: <20190128155907.20607-1-richard.henderson@linaro.org>
References: <20190128155907.20607-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 10/23] tcg/aarch64: Implement vector minmax
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
index a1884543d0..2d93cf404e 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -136,7 +136,7 @@ typedef enum {
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
-#define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_minmax_vec       1
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index b2b011f130..ee0d5819af 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -528,8 +528,12 @@ typedef enum {
     I3616_CMHI      = 0x2e203400,
     I3616_CMHS      = 0x2e203c00,
     I3616_CMEQ      = 0x2e208c00,
+    I3616_SMAX      = 0x0e206400,
+    I3616_SMIN      = 0x0e206c00,
     I3616_SQADD     = 0x0e200c00,
     I3616_SQSUB     = 0x0e202c00,
+    I3616_UMAX      = 0x2e206400,
+    I3616_UMIN      = 0x2e206c00,
     I3616_UQADD     = 0x2e200c00,
     I3616_UQSUB     = 0x2e202c00,
 
@@ -2153,6 +2157,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_ussub_vec:
         tcg_out_insn(s, 3616, UQSUB, is_q, vece, a0, a1, a2);
         break;
+    case INDEX_op_smax_vec:
+        tcg_out_insn(s, 3616, SMAX, is_q, vece, a0, a1, a2);
+        break;
+    case INDEX_op_smin_vec:
+        tcg_out_insn(s, 3616, SMIN, is_q, vece, a0, a1, a2);
+        break;
+    case INDEX_op_umax_vec:
+        tcg_out_insn(s, 3616, UMAX, is_q, vece, a0, a1, a2);
+        break;
+    case INDEX_op_umin_vec:
+        tcg_out_insn(s, 3616, UMIN, is_q, vece, a0, a1, a2);
+        break;
     case INDEX_op_not_vec:
         tcg_out_insn(s, 3617, NOT, is_q, 0, a0, a1);
         break;
@@ -2227,6 +2243,10 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_sssub_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_ussub_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
         return 1;
     case INDEX_op_mul_vec:
         return vece < MO_64;
@@ -2410,6 +2430,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sssub_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_ussub_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
         return &w_w_w;
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
-- 
2.17.2
