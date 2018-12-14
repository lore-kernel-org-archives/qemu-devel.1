Received: from eggs.gnu.org ([2001:4830:134:3::10]:58995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1D-0006Hv-Bj
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1C-0007iy-9w
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:03 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:36807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe1B-0007Po-W2
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:02 -0500
Received: by mail-ot1-x330.google.com with SMTP id k98so4130455otk.3
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:19:16 -0600
Message-Id: <20181214031923.29527-27-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 25/32] tcg/optimize: Optimize bswap
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

Somehow we forgot these operations, once upon a time.
This will allow immediate stores to have their bswap
optimized away.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 5dbe11c3c8..6b98ec13e6 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -353,6 +353,15 @@ static TCGArg do_constant_folding_2(TCGOpcode op, TCGArg x, TCGArg y)
     CASE_OP_32_64(ext16u):
         return (uint16_t)x;
 
+    CASE_OP_32_64(bswap16):
+        return bswap16(x);
+
+    CASE_OP_32_64(bswap32):
+        return bswap32(x);
+
+    case INDEX_op_bswap64_i64:
+        return bswap64(x);
+
     case INDEX_op_ext_i32_i64:
     case INDEX_op_ext32s_i64:
         return (int32_t)x;
@@ -1105,6 +1114,9 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(ext16s):
         CASE_OP_32_64(ext16u):
         CASE_OP_32_64(ctpop):
+        CASE_OP_32_64(bswap16):
+        CASE_OP_32_64(bswap32):
+        case INDEX_op_bswap64_i64:
         case INDEX_op_ext32s_i64:
         case INDEX_op_ext32u_i64:
         case INDEX_op_ext_i32_i64:
-- 
2.17.2
