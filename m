Received: from eggs.gnu.org ([2001:4830:134:3::10]:44470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gb7-00066S-DF
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gb5-0007ij-Cm
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:01 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:54404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5gb5-0007iT-6d
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:20:59 -0400
Received: by mail-pf0-x241.google.com with SMTP id n89so13056254pfk.11
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 16:20:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 20 Oct 2017 16:19:53 -0700
Message-Id: <20171020232023.15010-23-richard.henderson@linaro.org>
In-Reply-To: <20171020232023.15010-1-richard.henderson@linaro.org>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 22/52] tcg: Use pointers in TCGOp->args
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, f4bug@amsat.org, pbonzini@redhat.com

This limits the indexing into tcg_ctx.temps to initial
opcode generation time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h | 46 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 7fe0fb9e07..17779393a1 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -701,65 +701,61 @@ static inline size_t temp_idx(TCGTemp *ts)
 
 static inline TCGArg temp_arg(TCGTemp *ts)
 {
-    ptrdiff_t a = (void *)ts - (void *)&tcg_ctx;
-    tcg_debug_assert(a >= offsetof(TCGContext, temps)
-                     && a < offsetof(TCGContext, temps[tcg_ctx.nb_temps]));
-    return a;
+    return (uintptr_t)ts;
 }
 
 static inline TCGTemp *arg_temp(TCGArg a)
 {
-    if (a == TCG_CALL_DUMMY_ARG) {
-        return NULL;
-    }
-    tcg_debug_assert(a >= offsetof(TCGContext, temps)
-                     && a < offsetof(TCGContext, temps[tcg_ctx.nb_temps]));
-    return (void *)&tcg_ctx + a;
+    return (TCGTemp *)a;
 }
 
-static inline TCGArg tcgv_i32_arg(TCGv_i32 t)
+static inline TCGTemp *tcgv_i32_temp(TCGv_i32 v)
 {
-    return (intptr_t)t;
+    uintptr_t o = (uintptr_t)v;
+    TCGTemp *t = (void *)&tcg_ctx + o;
+    tcg_debug_assert(offsetof(TCGContext, temps[temp_idx(t)]) == o);
+    return t;
 }
 
-static inline TCGArg tcgv_i64_arg(TCGv_i64 t)
+static inline TCGTemp *tcgv_i64_temp(TCGv_i64 v)
 {
-    return (intptr_t)t;
+    return tcgv_i32_temp((TCGv_i32)v);
 }
 
-static inline TCGArg tcgv_ptr_arg(TCGv_ptr t)
+static inline TCGTemp *tcgv_ptr_temp(TCGv_ptr v)
 {
-    return (intptr_t)t;
+    return tcgv_i32_temp((TCGv_i32)v);
 }
 
-static inline TCGTemp *tcgv_i32_temp(TCGv_i32 t)
+static inline TCGArg tcgv_i32_arg(TCGv_i32 v)
 {
-    return arg_temp(tcgv_i32_arg(t));
+    return temp_arg(tcgv_i32_temp(v));
 }
 
-static inline TCGTemp *tcgv_i64_temp(TCGv_i64 t)
+static inline TCGArg tcgv_i64_arg(TCGv_i64 v)
 {
-    return arg_temp(tcgv_i64_arg(t));
+    return temp_arg(tcgv_i64_temp(v));
 }
 
-static inline TCGTemp *tcgv_ptr_temp(TCGv_ptr t)
+static inline TCGArg tcgv_ptr_arg(TCGv_ptr v)
 {
-    return arg_temp(tcgv_ptr_arg(t));
+    return temp_arg(tcgv_ptr_temp(v));
 }
 
 static inline TCGv_i32 temp_tcgv_i32(TCGTemp *t)
 {
-    return (TCGv_i32)temp_arg(t);
+    (void)temp_idx(t); /* trigger embedded assert */
+    return (TCGv_i32)((void *)t - (void *)&tcg_ctx);
 }
 
 static inline TCGv_i64 temp_tcgv_i64(TCGTemp *t)
 {
-    return (TCGv_i64)temp_arg(t);
+    return (TCGv_i64)temp_tcgv_i32(t);
 }
 
 static inline TCGv_ptr temp_tcgv_ptr(TCGTemp *t)
 {
-    return (TCGv_ptr)temp_arg(t);
+    return (TCGv_ptr)temp_tcgv_i32(t);
 }
 
 #if TCG_TARGET_REG_BITS == 32
-- 
2.13.6
