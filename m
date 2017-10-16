Received: from eggs.gnu.org ([2001:4830:134:3::10]:52407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49A5-0002JH-Hc
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49A4-0003aR-JF
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:45 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:44288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e49A4-0003Zv-DQ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:44 -0400
Received: by mail-pf0-x22a.google.com with SMTP id x7so16317335pfa.1
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:26:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:40 -0700
Message-Id: <20171016172609.23422-22-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 21/50] tcg: Use pointers in TCGOp->args
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

This limits the indexing into tcg_ctx.temps to initial
opcode generation time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index ccf1bcdaf6..d5bf61b1cf 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -741,24 +741,29 @@ static inline size_t temp_idx(TCGTemp *ts)
     return n;
 }
 
+static inline TCGTemp *idx_temp(size_t n)
+{
+    return n == TCG_CALL_DUMMY_ARG ? NULL : &tcg_ctx.temps[n];
+}
+
 static inline TCGArg temp_arg(TCGTemp *ts)
 {
-    return temp_idx(ts);
+    return (uintptr_t)ts;
 }
 
 static inline TCGTemp *arg_temp(TCGArg a)
 {
-    return a == TCG_CALL_DUMMY_ARG ? NULL : &tcg_ctx.temps[a];
+    return (TCGTemp *)a;
 }
 
 static inline size_t arg_index(TCGArg a)
 {
-    return a;
+    return temp_idx(arg_temp(a));
 }
 
 static inline TCGArg index_arg(size_t n)
 {
-    return n;
+    return temp_arg(idx_temp(n));
 }
 
 static inline TCGArg tcgv_i32_arg(TCGv_i32 t)
-- 
2.13.6
