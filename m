Received: from eggs.gnu.org ([2001:4830:134:3::10]:52222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e499k-0001vF-5v
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e499j-0003JY-2t
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:24 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:52538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e499i-0003Ih-R8
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:22 -0400
Received: by mail-pg0-x230.google.com with SMTP id a192so5918158pge.9
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:26:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:25 -0700
Message-Id: <20171016172609.23422-7-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 06/50] tcg: Add temp_global bit to TCGTemp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

This avoids needing to test the index of a temp against nb_globals.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.h      | 12 ++++++++----
 tcg/optimize.c | 15 ++++++++-------
 tcg/tcg.c      | 11 ++++++++---
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index f06187fd8e..fc4d1ed58b 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -579,10 +579,14 @@ typedef struct TCGTemp {
     unsigned int indirect_base:1;
     unsigned int mem_coherent:1;
     unsigned int mem_allocated:1;
-    unsigned int temp_local:1; /* If true, the temp is saved across
-                                  basic blocks. Otherwise, it is not
-                                  preserved across basic blocks. */
-    unsigned int temp_allocated:1; /* never used for code gen */
+    /* If true, the temp is saved across both basic blocks and
+       translation blocks.  */
+    unsigned int temp_global:1;
+    /* If true, the temp is saved across basic blocks but dead
+       at the end of translation blocks.  If false, the temp is
+       dead at the end of basic blocks.  */
+    unsigned int temp_local:1;
+    unsigned int temp_allocated:1;
 
     tcg_target_long val;
     struct TCGTemp *mem_base;
diff --git a/tcg/optimize.c b/tcg/optimize.c
index d8c3a7ed56..55f9e83ce8 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -116,25 +116,26 @@ static TCGOpcode op_to_movi(TCGOpcode op)
     }
 }
 
-static TCGArg find_better_copy(TCGContext *s, TCGArg temp)
+static TCGArg find_better_copy(TCGContext *s, TCGArg arg)
 {
+    TCGTemp *ts = arg_temp(arg);
     TCGArg i;
 
     /* If this is already a global, we can't do better. */
-    if (temp < s->nb_globals) {
-        return temp;
+    if (ts->temp_global) {
+        return arg;
     }
 
     /* Search for a global first. */
-    for (i = temps[temp].next_copy ; i != temp ; i = temps[i].next_copy) {
+    for (i = temps[arg].next_copy ; i != arg; i = temps[i].next_copy) {
         if (i < s->nb_globals) {
             return i;
         }
     }
 
     /* If it is a temp, search for a temp local. */
-    if (!arg_temp(temp)->temp_local) {
-        for (i = temps[temp].next_copy ; i != temp ; i = temps[i].next_copy) {
+    if (!ts->temp_local) {
+        for (i = temps[arg].next_copy ; i != arg; i = temps[i].next_copy) {
             if (s->temps[i].temp_local) {
                 return i;
             }
@@ -142,7 +143,7 @@ static TCGArg find_better_copy(TCGContext *s, TCGArg temp)
     }
 
     /* Failure to find a better representation, return the same temp. */
-    return temp;
+    return arg;
 }
 
 static bool temps_are_copies(TCGArg arg1, TCGArg arg2)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 2704aa8a4d..915e041bea 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -489,9 +489,14 @@ static inline TCGTemp *tcg_temp_alloc(TCGContext *s)
 
 static inline TCGTemp *tcg_global_alloc(TCGContext *s)
 {
+    TCGTemp *ts;
+
     tcg_debug_assert(s->nb_globals == s->nb_temps);
     s->nb_globals++;
-    return tcg_temp_alloc(s);
+    ts = tcg_temp_alloc(s);
+    ts->temp_global = 1;
+
+    return ts;
 }
 
 static int tcg_global_reg_new_internal(TCGContext *s, TCGType type,
@@ -1190,7 +1195,7 @@ static char *tcg_get_arg_str_ptr(TCGContext *s, char *buf, int buf_size,
 {
     int idx = temp_idx(s, ts);
 
-    if (idx < s->nb_globals) {
+    if (ts->temp_global) {
         pstrcpy(buf, buf_size, ts->name);
     } else if (ts->temp_local) {
         snprintf(buf, buf_size, "loc%d", idx - s->nb_globals);
@@ -2128,7 +2133,7 @@ static void temp_free_or_dead(TCGContext *s, TCGTemp *ts, int free_or_dead)
     }
     ts->val_type = (free_or_dead < 0
                     || ts->temp_local
-                    || temp_idx(s, ts) < s->nb_globals
+                    || ts->temp_global
                     ? TEMP_VAL_MEM : TEMP_VAL_DEAD);
 }
 
-- 
2.13.6
