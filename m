Received: from eggs.gnu.org ([2001:4830:134:3::10]:54486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ewYQM-0000Yk-0c
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ewYQI-0005xt-Ry
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:20:26 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:45177)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ewYQI-0005wl-C6
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:20:22 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 15 Mar 2018 20:19:56 +0100
Message-Id: <20180315191958.28937-2-laurent@vivier.eu>
In-Reply-To: <20180315191958.28937-1-laurent@vivier.eu>
References: <20180315191958.28937-1-laurent@vivier.eu>
Subject: [Qemu-devel] [RFC 1/3] tcg: introduce tcg_temp_try_free()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

m68k has some functions returning either
locally allocated TCGv or memory allocated
TCGv (registers). We want to free locally
allocated TCGv to avoid overflow in sequence like:

0xc00ae406:  movel %fp@(-132),%fp@(-268)
0xc00ae40c:  movel %fp@(-128),%fp@(-264)
0xc00ae412:  movel %fp@(-20),%fp@(-212)
0xc00ae418:  movel %fp@(-16),%fp@(-208)
0xc00ae41e:  movel %fp@(-60),%fp@(-220)
0xc00ae424:  movel %fp@(-56),%fp@(-216)
0xc00ae42a:  movel %fp@(-124),%fp@(-252)
0xc00ae430:  movel %fp@(-120),%fp@(-248)
0xc00ae436:  movel %fp@(-12),%fp@(-260)
0xc00ae43c:  movel %fp@(-8),%fp@(-256)
0xc00ae442:  movel %fp@(-52),%fp@(-276)
0xc00ae448:  movel %fp@(-48),%fp@(-272)
...

That can fill a lot of TCGv entries in a sequence,
especially since 15fa08f845 ("tcg: Dynamically allocate TCGOps")

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 tcg/tcg-op.h |  2 ++
 tcg/tcg.c    | 28 +++++++++++++++++++++-------
 tcg/tcg.h    |  3 +++
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 75bb55aeac..564e310426 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -811,6 +811,7 @@ void tcg_gen_lookup_and_goto_ptr(void);
 #define tcg_global_mem_new tcg_global_mem_new_i32
 #define tcg_temp_local_new() tcg_temp_local_new_i32()
 #define tcg_temp_free tcg_temp_free_i32
+#define tcg_temp_try_free tcg_temp_try_free_i32
 #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i32
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i32
 #else
@@ -819,6 +820,7 @@ void tcg_gen_lookup_and_goto_ptr(void);
 #define tcg_global_mem_new tcg_global_mem_new_i64
 #define tcg_temp_local_new() tcg_temp_local_new_i64()
 #define tcg_temp_free tcg_temp_free_i64
+#define tcg_temp_try_free tcg_temp_try_free_i64
 #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i64
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i64
 #endif
diff --git a/tcg/tcg.c b/tcg/tcg.c
index bb24526c93..9d02c07e7a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1072,11 +1072,15 @@ TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match)
     return temp_tcgv_vec(t);
 }
 
-static void tcg_temp_free_internal(TCGTemp *ts)
+static void tcg_temp_free_internal(TCGTemp *ts, bool try)
 {
     TCGContext *s = tcg_ctx;
     int k, idx;
 
+    if (try && ts->temp_allocated == 0) {
+        return;
+    }
+
 #if defined(CONFIG_DEBUG_TCG)
     s->temps_in_use--;
     if (s->temps_in_use < 0) {
@@ -1095,17 +1099,27 @@ static void tcg_temp_free_internal(TCGTemp *ts)
 
 void tcg_temp_free_i32(TCGv_i32 arg)
 {
-    tcg_temp_free_internal(tcgv_i32_temp(arg));
+    tcg_temp_free_internal(tcgv_i32_temp(arg), false);
 }
 
 void tcg_temp_free_i64(TCGv_i64 arg)
 {
-    tcg_temp_free_internal(tcgv_i64_temp(arg));
+    tcg_temp_free_internal(tcgv_i64_temp(arg), false);
+}
+
+void tcg_temp_try_free_i32(TCGv_i32 arg)
+{
+    tcg_temp_free_internal(tcgv_i32_temp(arg), true);
+}
+
+void tcg_temp_try_free_i64(TCGv_i64 arg)
+{
+    tcg_temp_free_internal(tcgv_i64_temp(arg), true);
 }
 
 void tcg_temp_free_vec(TCGv_vec arg)
 {
-    tcg_temp_free_internal(tcgv_vec_temp(arg));
+    tcg_temp_free_internal(tcgv_vec_temp(arg), false);
 }
 
 TCGv_i32 tcg_const_i32(int32_t val)
@@ -1572,8 +1586,8 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
     for (i = real_args = 0; i < orig_nargs; ++i) {
         int is_64bit = orig_sizemask & (1 << (i+1)*2);
         if (is_64bit) {
-            tcg_temp_free_internal(args[real_args++]);
-            tcg_temp_free_internal(args[real_args++]);
+            tcg_temp_free_internal(args[real_args++], false);
+            tcg_temp_free_internal(args[real_args++], false);
         } else {
             real_args++;
         }
@@ -1590,7 +1604,7 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
     for (i = 0; i < nargs; ++i) {
         int is_64bit = sizemask & (1 << (i+1)*2);
         if (!is_64bit) {
-            tcg_temp_free_internal(args[i]);
+            tcg_temp_free_internal(args[i], false);
         }
     }
 #endif /* TCG_TARGET_EXTEND_ARGS */
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 9e2d909a4a..e6d9dc0643 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -890,6 +890,9 @@ void tcg_temp_free_i32(TCGv_i32 arg);
 void tcg_temp_free_i64(TCGv_i64 arg);
 void tcg_temp_free_vec(TCGv_vec arg);
 
+void tcg_temp_try_free_i32(TCGv_i32 arg);
+void tcg_temp_try_free_i64(TCGv_i64 arg);
+
 static inline TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t offset,
                                               const char *name)
 {
-- 
2.14.3
