Received: from eggs.gnu.org ([2001:4830:134:3::10]:34005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVhS-0006e5-Vo
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVhS-0002Sp-5k
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:59 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNVhS-0002Sk-1Q
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:58 -0400
Received: by mail-qk0-x244.google.com with SMTP id r62so13614710qkf.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 19:48:57 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 20 Jun 2017 19:48:31 -0700
Message-Id: <20170621024831.26019-17-rth@twiddle.net>
In-Reply-To: <20170621024831.26019-1-rth@twiddle.net>
References: <20170621024831.26019-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 16/16] tcg: Store pointers to temporaries
 directly in TCGArg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.c |  8 ++++----
 tcg/tcg.h | 14 ++++++++------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1ca1192..c25f455 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -810,11 +810,11 @@ void tcg_gen_callN(TCGContext *s, void *func, TCGArg ret,
 #else
         if (TCG_TARGET_REG_BITS < 64 && (sizemask & 1)) {
 #ifdef HOST_WORDS_BIGENDIAN
-            op->args[pi++] = ret + 1;
+            op->args[pi++] = ret + sizeof(TCGTemp);
             op->args[pi++] = ret;
 #else
             op->args[pi++] = ret;
-            op->args[pi++] = ret + 1;
+            op->args[pi++] = ret + sizeof(TCGTemp);
 #endif
             nb_rets = 2;
         } else {
@@ -849,11 +849,11 @@ void tcg_gen_callN(TCGContext *s, void *func, TCGArg ret,
               have to get more complicated to differentiate between
               stack arguments and register arguments.  */
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TCG_TARGET_STACK_GROWSUP)
-            op->args[pi++] = args[i] + 1;
+            op->args[pi++] = args[i] + sizeof(TCGTemp);
             op->args[pi++] = args[i];
 #else
             op->args[pi++] = args[i];
-            op->args[pi++] = args[i] + 1;
+            op->args[pi++] = args[i] + sizeof(TCGTemp);
 #endif
             real_args += 2;
             continue;
diff --git a/tcg/tcg.h b/tcg/tcg.h
index a5a0412..df73b31 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -520,7 +520,7 @@ typedef TCGv_ptr TCGv_env;
 #define TCG_CALL_NO_WG_SE       (TCG_CALL_NO_WG | TCG_CALL_NO_SE)
 
 /* used to align parameters */
-#define TCG_CALL_DUMMY_ARG      ((TCGArg)(-1))
+#define TCG_CALL_DUMMY_ARG      0
 
 /* Conditions.  Note that these are laid out for easy manipulation by
    the functions below:
@@ -714,24 +714,26 @@ extern bool parallel_cpus;
 
 static inline size_t temp_idx(TCGTemp *ts)
 {
-    ptrdiff_t n = ts - tcg_ctx.temps;
-    tcg_debug_assert(n >= 0 && n < tcg_ctx.nb_temps);
+    size_t n = ts - tcg_ctx.temps;
+    tcg_debug_assert(n < tcg_ctx.nb_temps);
     return n;
 }
 
 static inline TCGArg temp_arg(TCGTemp *ts)
 {
-    return temp_idx(ts);
+    size_t n = ts - tcg_ctx.temps;
+    tcg_debug_assert(n < tcg_ctx.nb_temps);
+    return (uintptr_t)ts;
 }
 
 static inline TCGTemp *arg_temp(TCGArg a)
 {
-    return a == TCG_CALL_DUMMY_ARG ? NULL : &tcg_ctx.temps[a];
+    return (TCGTemp *)(uintptr_t)a;
 }
 
 static inline size_t arg_index(TCGArg a)
 {
-    return a;
+    return temp_idx(arg_temp(a));
 }
 
 static inline TCGv_i32 QEMU_ARTIFICIAL MAKE_TCGV_I32(TCGArg i)
-- 
2.9.4
