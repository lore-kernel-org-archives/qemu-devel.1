Received: from eggs.gnu.org ([2001:4830:134:3::10]:52435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fCLEO-000072-89
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 04:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fCLEL-0006bc-21
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 04:29:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53302 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fCLEK-0006ar-TK
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 04:29:16 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Sat, 28 Apr 2018 10:29:08 +0200
Message-Id: <20180428082908.32351-1-lvivier@redhat.com>
Subject: [Qemu-devel] [RFC v2] tcg: workaround branch instruction overflow
 in tcg_out_qemu_ld/st
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Richard Henderson <rth@twiddle.net>

ppc64 uses a BC instruction to call the tcg_out_qemu_ld/st
slow path. BC instruction uses a relative address encoded
on 14 bits.

The slow path functions are added at the end of the generated
instructions buffer, in the reverse order of the callers.
So more we have slow path functions more the distance between
the caller (BC) and the function increases.

This patch changes the behavior to generate the functions in
the same order of the callers.

Fixes: 15fa08f845 ("tcg: Dynamically allocate TCGOps")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---

Notes:
    v2:
      - add a pointer to the tail of the list to add new element
        at the end and keep the original ordering
      - remove the recursive call

 tcg/tcg-ldst.inc.c | 11 ++++++++---
 tcg/tcg.c          |  3 ++-
 tcg/tcg.h          |  3 ++-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tcg/tcg-ldst.inc.c b/tcg/tcg-ldst.inc.c
index 0e14cf4357..735ebf8da6 100644
--- a/tcg/tcg-ldst.inc.c
+++ b/tcg/tcg-ldst.inc.c
@@ -46,7 +46,7 @@ static bool tcg_out_ldst_finalize(TCGContext *s)
     TCGLabelQemuLdst *lb;
 
     /* qemu_ld/st slow paths */
-    for (lb = s->ldst_labels; lb != NULL; lb = lb->next) {
+    for (lb = s->ldst_head; lb != NULL; lb = lb->next) {
         if (lb->is_ld) {
             tcg_out_qemu_ld_slow_path(s, lb);
         } else {
@@ -72,7 +72,12 @@ static inline TCGLabelQemuLdst *new_ldst_label(TCGContext *s)
 {
     TCGLabelQemuLdst *l = tcg_malloc(sizeof(*l));
 
-    l->next = s->ldst_labels;
-    s->ldst_labels = l;
+    l->next = NULL;
+    if (s->ldst_tail) {
+        s->ldst_tail->next = l;
+    } else {
+        s->ldst_head = l;
+    }
+    s->ldst_tail = l;
     return l;
 }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index bb24526c93..3ab195a23f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3324,7 +3324,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     s->code_ptr = tb->tc.ptr;
 
 #ifdef TCG_TARGET_NEED_LDST_LABELS
-    s->ldst_labels = NULL;
+    s->ldst_head = NULL;
+    s->ldst_tail = NULL;
 #endif
 #ifdef TCG_TARGET_NEED_POOL_LABELS
     s->pool_labels = NULL;
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 30896ca304..22cb7cbffc 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -699,7 +699,8 @@ struct TCGContext {
 
     /* These structures are private to tcg-target.inc.c.  */
 #ifdef TCG_TARGET_NEED_LDST_LABELS
-    struct TCGLabelQemuLdst *ldst_labels;
+    struct TCGLabelQemuLdst *ldst_head;
+    struct TCGLabelQemuLdst *ldst_tail;
 #endif
 #ifdef TCG_TARGET_NEED_POOL_LABELS
     struct TCGLabelPoolData *pool_labels;
-- 
2.14.3
