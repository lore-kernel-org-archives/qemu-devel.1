Received: from eggs.gnu.org ([2001:4830:134:3::10]:43684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gP4x2-0001i0-Az
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:16:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gP4x0-00050t-Je
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:16:20 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:42377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gP4x0-00050h-EO
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:16:18 -0500
Received: by mail-pf1-x429.google.com with SMTP id 64so911817pfr.9
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 04:16:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 20 Nov 2018 13:15:55 +0100
Message-Id: <20181120121558.7660-3-richard.henderson@linaro.org>
In-Reply-To: <20181120121558.7660-1-richard.henderson@linaro.org>
References: <20181120121558.7660-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/5] tcg/optimize: Optimize bswap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com

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
