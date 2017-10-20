Received: from eggs.gnu.org ([2001:4830:134:3::10]:44469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gb7-00066R-Cz
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gb4-0007iA-50
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:01 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:50160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5gb3-0007hx-V3
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:20:58 -0400
Received: by mail-pf0-x242.google.com with SMTP id i5so13070066pfe.6
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 16:20:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 20 Oct 2017 16:19:52 -0700
Message-Id: <20171020232023.15010-22-richard.henderson@linaro.org>
In-Reply-To: <20171020232023.15010-1-richard.henderson@linaro.org>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 21/52] tcg: Use offsets not indices for
 TCGv_*
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

Using the offset of a temporary, relative to TCGContext, rather than
its index means that we don't use 0.  That leaves offset 0 free for
a NULL representation without having to leave index 0 unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 8f692bc6cf..7fe0fb9e07 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -429,13 +429,13 @@ typedef TCGv_ptr TCGv_env;
 #endif
 
 /* Dummy definition to avoid compiler warnings.  */
-#define TCGV_UNUSED_I32(x) (x = (TCGv_i32)-1)
-#define TCGV_UNUSED_I64(x) (x = (TCGv_i64)-1)
-#define TCGV_UNUSED_PTR(x) (x = (TCGv_ptr)-1)
+#define TCGV_UNUSED_I32(x) (x = (TCGv_i32)NULL)
+#define TCGV_UNUSED_I64(x) (x = (TCGv_i64)NULL)
+#define TCGV_UNUSED_PTR(x) (x = (TCGv_ptr)NULL)
 
-#define TCGV_IS_UNUSED_I32(x) ((x) == (TCGv_i32)-1)
-#define TCGV_IS_UNUSED_I64(x) ((x) == (TCGv_i64)-1)
-#define TCGV_IS_UNUSED_PTR(x) ((x) == (TCGv_ptr)-1)
+#define TCGV_IS_UNUSED_I32(x) ((x) == (TCGv_i32)NULL)
+#define TCGV_IS_UNUSED_I64(x) ((x) == (TCGv_i64)NULL)
+#define TCGV_IS_UNUSED_PTR(x) ((x) == (TCGv_ptr)NULL)
 
 /* call flags */
 /* Helper does not read globals (either directly or through an exception). It
@@ -454,7 +454,7 @@ typedef TCGv_ptr TCGv_env;
 #define TCG_CALL_NO_WG_SE       (TCG_CALL_NO_WG | TCG_CALL_NO_SE)
 
 /* used to align parameters */
-#define TCG_CALL_DUMMY_ARG      ((TCGArg)(-1))
+#define TCG_CALL_DUMMY_ARG      ((TCGArg)0)
 
 /* Conditions.  Note that these are laid out for easy manipulation by
    the functions below:
@@ -701,17 +701,20 @@ static inline size_t temp_idx(TCGTemp *ts)
 
 static inline TCGArg temp_arg(TCGTemp *ts)
 {
-    return temp_idx(ts);
+    ptrdiff_t a = (void *)ts - (void *)&tcg_ctx;
+    tcg_debug_assert(a >= offsetof(TCGContext, temps)
+                     && a < offsetof(TCGContext, temps[tcg_ctx.nb_temps]));
+    return a;
 }
 
 static inline TCGTemp *arg_temp(TCGArg a)
 {
-    return a == TCG_CALL_DUMMY_ARG ? NULL : &tcg_ctx.temps[a];
-}
-
-static inline size_t arg_index(TCGArg a)
-{
-    return a;
+    if (a == TCG_CALL_DUMMY_ARG) {
+        return NULL;
+    }
+    tcg_debug_assert(a >= offsetof(TCGContext, temps)
+                     && a < offsetof(TCGContext, temps[tcg_ctx.nb_temps]));
+    return (void *)&tcg_ctx + a;
 }
 
 static inline TCGArg tcgv_i32_arg(TCGv_i32 t)
@@ -746,17 +749,17 @@ static inline TCGTemp *tcgv_ptr_temp(TCGv_ptr t)
 
 static inline TCGv_i32 temp_tcgv_i32(TCGTemp *t)
 {
-    return (TCGv_i32)temp_idx(t);
+    return (TCGv_i32)temp_arg(t);
 }
 
 static inline TCGv_i64 temp_tcgv_i64(TCGTemp *t)
 {
-    return (TCGv_i64)temp_idx(t);
+    return (TCGv_i64)temp_arg(t);
 }
 
 static inline TCGv_ptr temp_tcgv_ptr(TCGTemp *t)
 {
-    return (TCGv_ptr)temp_idx(t);
+    return (TCGv_ptr)temp_arg(t);
 }
 
 #if TCG_TARGET_REG_BITS == 32
-- 
2.13.6
