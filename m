Received: from eggs.gnu.org ([2001:4830:134:3::10]:52377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49A1-0002DC-0t
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e499z-0003X8-UB
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:41 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:50192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e499z-0003Wg-PQ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:39 -0400
Received: by mail-pf0-x234.google.com with SMTP id b6so7884690pfh.7
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:26:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:37 -0700
Message-Id: <20171016172609.23422-19-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 18/50] tcg: Reserve temporary index 0
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

Since we cast indicies to pointers, reserving 0 allows
us to use NULL for unused/dummy instead of (T *)-1.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h | 16 ++++++++--------
 tcg/tcg.c |  5 ++++-
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index b8ede7fe5c..ccf1bcdaf6 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -471,13 +471,13 @@ static inline intptr_t QEMU_ARTIFICIAL GET_TCGV_PTR(TCGv_ptr t)
 #define TCGV_EQUAL_PTR(a, b) (GET_TCGV_PTR(a) == GET_TCGV_PTR(b))
 
 /* Dummy definition to avoid compiler warnings.  */
-#define TCGV_UNUSED_I32(x) x = MAKE_TCGV_I32(-1)
-#define TCGV_UNUSED_I64(x) x = MAKE_TCGV_I64(-1)
-#define TCGV_UNUSED_PTR(x) x = MAKE_TCGV_PTR(-1)
+#define TCGV_UNUSED_I32(x) ((x) = NULL)
+#define TCGV_UNUSED_I64(x) ((x) = NULL)
+#define TCGV_UNUSED_PTR(x) ((x) = NULL)
 
-#define TCGV_IS_UNUSED_I32(x) (GET_TCGV_I32(x) == -1)
-#define TCGV_IS_UNUSED_I64(x) (GET_TCGV_I64(x) == -1)
-#define TCGV_IS_UNUSED_PTR(x) (GET_TCGV_PTR(x) == -1)
+#define TCGV_IS_UNUSED_I32(x) (GET_TCGV_I32(x) == 0)
+#define TCGV_IS_UNUSED_I64(x) (GET_TCGV_I64(x) == 0)
+#define TCGV_IS_UNUSED_PTR(x) (GET_TCGV_PTR(x) == 0)
 
 /* call flags */
 /* Helper does not read globals (either directly or through an exception). It
@@ -496,7 +496,7 @@ static inline intptr_t QEMU_ARTIFICIAL GET_TCGV_PTR(TCGv_ptr t)
 #define TCG_CALL_NO_WG_SE       (TCG_CALL_NO_WG | TCG_CALL_NO_SE)
 
 /* used to align parameters */
-#define TCG_CALL_DUMMY_ARG      ((TCGArg)(-1))
+#define TCG_CALL_DUMMY_ARG      ((TCGArg)0)
 
 /* Conditions.  Note that these are laid out for easy manipulation by
    the functions below:
@@ -737,7 +737,7 @@ extern bool parallel_cpus;
 static inline size_t temp_idx(TCGTemp *ts)
 {
     ptrdiff_t n = ts - tcg_ctx.temps;
-    tcg_debug_assert(n >= 0 && n < tcg_ctx.nb_temps);
+    tcg_debug_assert(n > 0 && n < tcg_ctx.nb_temps);
     return n;
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 129aecca60..7cf39f7067 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -333,7 +333,10 @@ void tcg_context_init(TCGContext *s)
     int *sorted_args;
 
     memset(s, 0, sizeof(*s));
-    s->nb_globals = 0;
+    /* Reserve temp index 0 so that, with the funny casting that we do,
+       the first one doesn't look like NULL.  */
+    s->nb_globals = 1;
+    s->nb_temps = 1;
 
     /* Count total number of arguments and allocate the corresponding
        space */
-- 
2.13.6
