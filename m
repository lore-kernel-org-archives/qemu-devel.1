Received: from eggs.gnu.org ([2001:4830:134:3::10]:51760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDvs3-0005X3-0L
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDvs1-0004DB-Tk
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:48:51 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:42989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDvs1-0004Cg-O6
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:48:49 -0400
Received: by mail-pf0-x242.google.com with SMTP id p14so1025530pfh.9
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 10:48:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  2 May 2018 10:48:42 -0700
Message-Id: <20180502174842.16253-4-richard.henderson@linaro.org>
In-Reply-To: <20180502174842.16253-1-richard.henderson@linaro.org>
References: <20180502174842.16253-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 5/5] tcg: workaround branch instruction overflow
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
Cc: peter.maydell@linaro.org, Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org

From: Laurent Vivier <lvivier@redhat.com>

ppc64 uses a BC instruction to call the tcg_out_qemu_ld/st
slow path. BC instruction uses a relative address encoded
on 14 bits.

The slow path functions are added at the end of the generated
instructions buffer, in the reverse order of the callers.
So more we have slow path functions more the distance between
the caller (BC) and the function increases.

This patch changes the behavior to generate the functions in
the same order of the callers.

Cc: qemu-stable@nongnu.org
Fixes: 15fa08f845 ("tcg: Dynamically allocate TCGOps")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20180429235840.16659-1-lvivier@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h          | 2 +-
 tcg/tcg-ldst.inc.c | 8 ++++----
 tcg/tcg.c          | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index eb0d4f6ca7..75fbad128b 100644
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
index b5e706bc49..551caf1c53 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3297,7 +3297,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     s->code_ptr = tb->tc.ptr;
 
 #ifdef TCG_TARGET_NEED_LDST_LABELS
-    s->ldst_labels = NULL;
+    QSIMPLEQ_INIT(&s->ldst_labels);
 #endif
 #ifdef TCG_TARGET_NEED_POOL_LABELS
     s->pool_labels = NULL;
-- 
2.14.3
