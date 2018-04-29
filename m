Received: from eggs.gnu.org ([2001:4830:134:3::10]:52407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fCwDV-0003AX-7e
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 19:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fCwDR-0000zD-C6
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 19:58:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58014 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fCwDR-0000yl-6o
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 19:58:49 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Mon, 30 Apr 2018 01:58:40 +0200
Message-Id: <20180429235840.16659-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v3] tcg: workaround branch instruction overflow
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
    v3:
      - use QSIMPLEQ macros (rth)
      - RFC -> PATCH
    
    v2:
      - add a pointer to the tail of the list to add new element
        at the end and keep the original ordering
      - remove the recursive call

 tcg/tcg-ldst.inc.c | 8 ++++----
 tcg/tcg.c          | 2 +-
 tcg/tcg.h          | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tcg/tcg-ldst.inc.c b/tcg/tcg-ldst.inc.c
index 0e14cf4357..47f41b921b 100644
--- a/tcg/tcg-ldst.inc.c
+++ b/tcg/tcg-ldst.inc.c
@@ -30,7 +30,7 @@ typedef struct TCGLabelQemuLdst {
     TCGReg datahi_reg;      /* reg index for high word to be loaded or stored */
     tcg_insn_unit *raddr;   /* gen code addr of the next IR of qemu_ld/st IR */
     tcg_insn_unit *label_ptr[2]; /* label pointers to be updated */
-    struct TCGLabelQemuLdst *next;
+    QSIMPLEQ_ENTRY(TCGLabelQemuLdst) next;
 } TCGLabelQemuLdst;
 
 
@@ -46,7 +46,7 @@ static bool tcg_out_ldst_finalize(TCGContext *s)
     TCGLabelQemuLdst *lb;
 
     /* qemu_ld/st slow paths */
-    for (lb = s->ldst_labels; lb != NULL; lb = lb->next) {
+    QSIMPLEQ_FOREACH(lb, &s->ldst_labels, next) {
         if (lb->is_ld) {
             tcg_out_qemu_ld_slow_path(s, lb);
         } else {
@@ -72,7 +72,7 @@ static inline TCGLabelQemuLdst *new_ldst_label(TCGContext *s)
 {
     TCGLabelQemuLdst *l = tcg_malloc(sizeof(*l));
 
-    l->next = s->ldst_labels;
-    s->ldst_labels = l;
+    QSIMPLEQ_INSERT_TAIL(&s->ldst_labels, l, next);
+
     return l;
 }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index bb24526c93..b84850b726 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3324,7 +3324,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     s->code_ptr = tb->tc.ptr;
 
 #ifdef TCG_TARGET_NEED_LDST_LABELS
-    s->ldst_labels = NULL;
+    QSIMPLEQ_INIT(&s->ldst_labels);
 #endif
 #ifdef TCG_TARGET_NEED_POOL_LABELS
     s->pool_labels = NULL;
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 30896ca304..a3076c55d8 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -699,7 +699,7 @@ struct TCGContext {
 
     /* These structures are private to tcg-target.inc.c.  */
 #ifdef TCG_TARGET_NEED_LDST_LABELS
-    struct TCGLabelQemuLdst *ldst_labels;
+    QSIMPLEQ_HEAD(ldst_labels, TCGLabelQemuLdst) ldst_labels;
 #endif
 #ifdef TCG_TARGET_NEED_POOL_LABELS
     struct TCGLabelPoolData *pool_labels;
-- 
2.14.3
