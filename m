Received: from eggs.gnu.org ([2001:4830:134:3::10]:33973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVhO-0006aB-V5
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVhO-0002Rs-0i
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:55 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNVhN-0002RG-SB
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:53 -0400
Received: by mail-qk0-x241.google.com with SMTP id 16so8296120qkg.2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 19:48:53 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 20 Jun 2017 19:48:28 -0700
Message-Id: <20170621024831.26019-14-rth@twiddle.net>
In-Reply-To: <20170621024831.26019-1-rth@twiddle.net>
References: <20170621024831.26019-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 13/16] tcg: Export temp_idx
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

At the same time, drop the TCGContext argument and use tcg_ctx instead.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.c | 15 ++++-----------
 tcg/tcg.h |  7 ++++++-
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index f8d96fa..26931a7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -473,13 +473,6 @@ void tcg_func_start(TCGContext *s)
     s->be = tcg_malloc(sizeof(TCGBackendData));
 }
 
-static inline int temp_idx(TCGContext *s, TCGTemp *ts)
-{
-    ptrdiff_t n = ts - s->temps;
-    tcg_debug_assert(n >= 0 && n < s->nb_temps);
-    return n;
-}
-
 static inline TCGTemp *tcg_temp_alloc(TCGContext *s)
 {
     int n = s->nb_temps++;
@@ -516,7 +509,7 @@ static int tcg_global_reg_new_internal(TCGContext *s, TCGType type,
     ts->name = name;
     tcg_regset_set_reg(s->reserved_regs, reg);
 
-    return temp_idx(s, ts);
+    return temp_idx(ts);
 }
 
 void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size)
@@ -605,7 +598,7 @@ int tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
         ts->mem_offset = offset;
         ts->name = name;
     }
-    return temp_idx(s, ts);
+    return temp_idx(ts);
 }
 
 static int tcg_temp_new_internal(TCGType type, int temp_local)
@@ -645,7 +638,7 @@ static int tcg_temp_new_internal(TCGType type, int temp_local)
             ts->temp_allocated = 1;
             ts->temp_local = temp_local;
         }
-        idx = temp_idx(s, ts);
+        idx = temp_idx(ts);
     }
 
 #if defined(CONFIG_DEBUG_TCG)
@@ -963,7 +956,7 @@ static void tcg_reg_alloc_start(TCGContext *s)
 static char *tcg_get_arg_str_ptr(TCGContext *s, char *buf, int buf_size,
                                  TCGTemp *ts)
 {
-    int idx = temp_idx(s, ts);
+    int idx = temp_idx(ts);
 
     if (ts->temp_global) {
         pstrcpy(buf, buf_size, ts->name);
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 4f69d0c..b75a745 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -733,13 +733,18 @@ struct TCGContext {
 extern TCGContext tcg_ctx;
 extern bool parallel_cpus;
 
-static inline TCGArg temp_arg(TCGTemp *ts)
+static inline size_t temp_idx(TCGTemp *ts)
 {
     ptrdiff_t n = ts - tcg_ctx.temps;
     tcg_debug_assert(n >= 0 && n < tcg_ctx.nb_temps);
     return n;
 }
 
+static inline TCGArg temp_arg(TCGTemp *ts)
+{
+    return temp_idx(ts);
+}
+
 static inline TCGTemp *arg_temp(TCGArg a)
 {
     return a == TCG_CALL_DUMMY_ARG ? NULL : &tcg_ctx.temps[a];
-- 
2.9.4
