Received: from eggs.gnu.org ([2001:4830:134:3::10]:41583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fC2Jl-0006Fy-Lm
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fC2Ji-0000Ao-Gp
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:17:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44952 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fC2Ji-0000Ac-Cc
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:17:34 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Fri, 27 Apr 2018 14:17:23 +0200
Message-Id: <20180427121723.3543-1-lvivier@redhat.com>
Subject: [Qemu-devel] [RFC] tcg: workaround branch instruction overflow in
 tcg_out_qemu_ld/st
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
    This is an RFC for several reasons:
    - it doens't really fix the overflow problem
      only avoids the case
    - it uses a recursive function to revert the slow path
      functions order (and we can have a stack overflow...),

 tcg/tcg-ldst.inc.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-ldst.inc.c b/tcg/tcg-ldst.inc.c
index 0e14cf4357..1f41cda482 100644
--- a/tcg/tcg-ldst.inc.c
+++ b/tcg/tcg-ldst.inc.c
@@ -41,12 +41,16 @@ typedef struct TCGLabelQemuLdst {
 static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l);
 static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l);
 
-static bool tcg_out_ldst_finalize(TCGContext *s)
+static bool tcg_out_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 {
-    TCGLabelQemuLdst *lb;
+    bool ret;
 
-    /* qemu_ld/st slow paths */
-    for (lb = s->ldst_labels; lb != NULL; lb = lb->next) {
+    if (lb == NULL) {
+        return true;
+    }
+
+    ret = tcg_out_slow_path(s, lb->next);
+    if (ret) {
         if (lb->is_ld) {
             tcg_out_qemu_ld_slow_path(s, lb);
         } else {
@@ -57,11 +61,16 @@ static bool tcg_out_ldst_finalize(TCGContext *s)
            one operation beginning below the high water mark cannot overrun
            the buffer completely.  Thus we can test for overflow after
            generating code without having to check during generation.  */
-        if (unlikely((void *)s->code_ptr > s->code_gen_highwater)) {
-            return false;
-        }
+        ret = (void *)s->code_ptr <= s->code_gen_highwater;
     }
-    return true;
+
+    return ret;
+}
+
+static bool tcg_out_ldst_finalize(TCGContext *s)
+{
+    /* qemu_ld/st slow paths */
+    return tcg_out_slow_path(s, s->ldst_labels);
 }
 
 /*
-- 
2.14.3
