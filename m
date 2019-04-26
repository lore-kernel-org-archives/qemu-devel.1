Received: from eggs.gnu.org ([209.51.188.92]:48029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aV-00006v-C6
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aU-0006ry-By
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:39 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:37750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aU-0006p7-5b
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:38 -0400
Received: by mail-pl1-x62f.google.com with SMTP id z8so1890877pln.4
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 26 Apr 2019 10:24:17 -0700
Message-Id: <20190426172421.27133-12-richard.henderson@linaro.org>
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 11/15] tcg: Restart TB generation after constant
 pool overflow
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

This is part b of relocation overflow handling.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-pool.inc.c | 12 +++++++-----
 tcg/tcg.c          |  9 +++++----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tcg/tcg-pool.inc.c b/tcg/tcg-pool.inc.c
index 7af5513ff3..4eaa84b631 100644
--- a/tcg/tcg-pool.inc.c
+++ b/tcg/tcg-pool.inc.c
@@ -121,14 +121,14 @@ static inline void new_pool_l8(TCGContext *s, int rtype, tcg_insn_unit *label,
 /* To be provided by cpu/tcg-target.inc.c.  */
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count);
 
-static bool tcg_out_pool_finalize(TCGContext *s)
+static int tcg_out_pool_finalize(TCGContext *s)
 {
     TCGLabelPoolData *p = s->pool_labels;
     TCGLabelPoolData *l = NULL;
     void *a;
 
     if (p == NULL) {
-        return true;
+        return 0;
     }
 
     /* ??? Round up to qemu_icache_linesize, but then do not round
@@ -142,15 +142,17 @@ static bool tcg_out_pool_finalize(TCGContext *s)
         size_t size = sizeof(tcg_target_ulong) * p->nlong;
         if (!l || l->nlong != p->nlong || memcmp(l->data, p->data, size)) {
             if (unlikely(a > s->code_gen_highwater)) {
-                return false;
+                return -1;
             }
             memcpy(a, p->data, size);
             a += size;
             l = p;
         }
-        patch_reloc(p->label, p->rtype, (intptr_t)a - size, p->addend);
+        if (!patch_reloc(p->label, p->rtype, (intptr_t)a - size, p->addend)) {
+            return -2;
+        }
     }
 
     s->code_ptr = a;
-    return true;
+    return 0;
 }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 752c45a0ec..0394e8ab34 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1019,8 +1019,8 @@ void tcg_prologue_init(TCGContext *s)
 #ifdef TCG_TARGET_NEED_POOL_LABELS
     /* Allow the prologue to put e.g. guest_base into a pool entry.  */
     {
-        bool ok = tcg_out_pool_finalize(s);
-        tcg_debug_assert(ok);
+        int result = tcg_out_pool_finalize(s);
+        tcg_debug_assert(result == 0);
     }
 #endif
 
@@ -4005,8 +4005,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     }
 #endif
 #ifdef TCG_TARGET_NEED_POOL_LABELS
-    if (!tcg_out_pool_finalize(s)) {
-        return -1;
+    i = tcg_out_pool_finalize(s);
+    if (i < 0) {
+        return i;
     }
 #endif
     if (!tcg_resolve_relocs(s)) {
-- 
2.17.1
