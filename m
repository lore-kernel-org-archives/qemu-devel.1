Received: from eggs.gnu.org ([2001:4830:134:3::10]:45631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6Z-0008KU-W6
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6Y-0008Fu-58
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:07 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:47225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6X-0008DO-Ta
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:06 -0400
Received: by mail-wm0-x244.google.com with SMTP id r196so622442wmf.2
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:05 +0200
Message-Id: <20171025093535.10175-22-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/51] tcg: Use offsets not indices for TCGv_*
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

Using the offset of a temporary, relative to TCGContext, rather than
its index means that we don't use 0.  That leaves offset 0 free for
a NULL representation without having to leave index 0 unused.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h | 64 ++++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 8f692bc6cf..c85786fb47 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -428,14 +428,14 @@ typedef TCGv_ptr TCGv_env;
 #error Unhandled TARGET_LONG_BITS value
 #endif
 
-/* Dummy definition to avoid compiler warnings.  */
-#define TCGV_UNUSED_I32(x) (x = (TCGv_i32)-1)
-#define TCGV_UNUSED_I64(x) (x = (TCGv_i64)-1)
-#define TCGV_UNUSED_PTR(x) (x = (TCGv_ptr)-1)
+/* See the comment before tcgv_i32_temp.  */
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
@@ -453,8 +453,8 @@ typedef TCGv_ptr TCGv_env;
 #define TCG_CALL_NO_RWG_SE      (TCG_CALL_NO_RWG | TCG_CALL_NO_SE)
 #define TCG_CALL_NO_WG_SE       (TCG_CALL_NO_WG | TCG_CALL_NO_SE)
 
-/* used to align parameters */
-#define TCG_CALL_DUMMY_ARG      ((TCGArg)(-1))
+/* Used to align parameters.  See the comment before tcgv_i32_temp.  */
+#define TCG_CALL_DUMMY_ARG      ((TCGArg)0)
 
 /* Conditions.  Note that these are laid out for easy manipulation by
    the functions below:
@@ -701,62 +701,64 @@ static inline size_t temp_idx(TCGTemp *ts)
 
 static inline TCGArg temp_arg(TCGTemp *ts)
 {
-    return temp_idx(ts);
+    return (uintptr_t)ts;
 }
 
 static inline TCGTemp *arg_temp(TCGArg a)
 {
-    return a == TCG_CALL_DUMMY_ARG ? NULL : &tcg_ctx.temps[a];
+    return (TCGTemp *)(uintptr_t)a;
 }
 
-static inline size_t arg_index(TCGArg a)
+/* Using the offset of a temporary, relative to TCGContext, rather than
+   its index means that we don't use 0.  That leaves offset 0 free for
+   a NULL representation without having to leave index 0 unused.  */
+static inline TCGTemp *tcgv_i32_temp(TCGv_i32 v)
 {
-    return a;
-}
-
-static inline TCGArg tcgv_i32_arg(TCGv_i32 t)
-{
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
-    return (TCGv_i32)temp_idx(t);
+    (void)temp_idx(t); /* trigger embedded assert */
+    return (TCGv_i32)((void *)t - (void *)&tcg_ctx);
 }
 
 static inline TCGv_i64 temp_tcgv_i64(TCGTemp *t)
 {
-    return (TCGv_i64)temp_idx(t);
+    return (TCGv_i64)temp_tcgv_i32(t);
 }
 
 static inline TCGv_ptr temp_tcgv_ptr(TCGTemp *t)
 {
-    return (TCGv_ptr)temp_idx(t);
+    return (TCGv_ptr)temp_tcgv_i32(t);
 }
 
 #if TCG_TARGET_REG_BITS == 32
-- 
2.13.6
