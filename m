Received: from eggs.gnu.org ([2001:4830:134:3::10]:42019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejpNs-00089T-Qd
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejpNq-00044H-So
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:49:16 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:40292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejpNq-00043M-LZ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:49:14 -0500
Received: by mail-pf0-x242.google.com with SMTP id u20so669289pfl.7
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 08:49:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  8 Feb 2018 08:49:09 -0800
Message-Id: <20180208164909.8639-2-richard.henderson@linaro.org>
In-Reply-To: <20180208164909.8639-1-richard.henderson@linaro.org>
References: <20180208164909.8639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 01/20] tcg: Allow multiple word entries into
 the constant pool
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

This will be required for storing vector constants.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-pool.inc.c | 113 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 92 insertions(+), 21 deletions(-)

diff --git a/tcg/tcg-pool.inc.c b/tcg/tcg-pool.inc.c
index 8a85131405..7af5513ff3 100644
--- a/tcg/tcg-pool.inc.c
+++ b/tcg/tcg-pool.inc.c
@@ -22,39 +22,110 @@
 
 typedef struct TCGLabelPoolData {
     struct TCGLabelPoolData *next;
-    tcg_target_ulong data;
     tcg_insn_unit *label;
     intptr_t addend;
-    int type;
+    int rtype;
+    unsigned nlong;
+    tcg_target_ulong data[];
 } TCGLabelPoolData;
 
 
-static void new_pool_label(TCGContext *s, tcg_target_ulong data, int type,
-                           tcg_insn_unit *label, intptr_t addend)
+static TCGLabelPoolData *new_pool_alloc(TCGContext *s, int nlong, int rtype,
+                                        tcg_insn_unit *label, intptr_t addend)
 {
-    TCGLabelPoolData *n = tcg_malloc(sizeof(*n));
-    TCGLabelPoolData *i, **pp;
+    TCGLabelPoolData *n = tcg_malloc(sizeof(TCGLabelPoolData)
+                                     + sizeof(tcg_target_ulong) * nlong);
 
-    n->data = data;
     n->label = label;
-    n->type = type;
     n->addend = addend;
+    n->rtype = rtype;
+    n->nlong = nlong;
+    return n;
+}
+
+static void new_pool_insert(TCGContext *s, TCGLabelPoolData *n)
+{
+    TCGLabelPoolData *i, **pp;
+    int nlong = n->nlong;
 
     /* Insertion sort on the pool.  */
-    for (pp = &s->pool_labels; (i = *pp) && i->data < data; pp = &i->next) {
-        continue;
+    for (pp = &s->pool_labels; (i = *pp) != NULL; pp = &i->next) {
+        if (nlong > i->nlong) {
+            break;
+        }
+        if (nlong < i->nlong) {
+            continue;
+        }
+        if (memcmp(n->data, i->data, sizeof(tcg_target_ulong) * nlong) >= 0) {
+            break;
+        }
     }
     n->next = *pp;
     *pp = n;
 }
 
+/* The "usual" for generic integer code.  */
+static inline void new_pool_label(TCGContext *s, tcg_target_ulong d, int rtype,
+                                  tcg_insn_unit *label, intptr_t addend)
+{
+    TCGLabelPoolData *n = new_pool_alloc(s, 1, rtype, label, addend);
+    n->data[0] = d;
+    new_pool_insert(s, n);
+}
+
+/* For v64 or v128, depending on the host.  */
+static inline void new_pool_l2(TCGContext *s, int rtype, tcg_insn_unit *label,
+                               intptr_t addend, tcg_target_ulong d0,
+                               tcg_target_ulong d1)
+{
+    TCGLabelPoolData *n = new_pool_alloc(s, 2, rtype, label, addend);
+    n->data[0] = d0;
+    n->data[1] = d1;
+    new_pool_insert(s, n);
+}
+
+/* For v128 or v256, depending on the host.  */
+static inline void new_pool_l4(TCGContext *s, int rtype, tcg_insn_unit *label,
+                               intptr_t addend, tcg_target_ulong d0,
+                               tcg_target_ulong d1, tcg_target_ulong d2,
+                               tcg_target_ulong d3)
+{
+    TCGLabelPoolData *n = new_pool_alloc(s, 4, rtype, label, addend);
+    n->data[0] = d0;
+    n->data[1] = d1;
+    n->data[2] = d2;
+    n->data[3] = d3;
+    new_pool_insert(s, n);
+}
+
+/* For v256, for 32-bit host.  */
+static inline void new_pool_l8(TCGContext *s, int rtype, tcg_insn_unit *label,
+                               intptr_t addend, tcg_target_ulong d0,
+                               tcg_target_ulong d1, tcg_target_ulong d2,
+                               tcg_target_ulong d3, tcg_target_ulong d4,
+                               tcg_target_ulong d5, tcg_target_ulong d6,
+                               tcg_target_ulong d7)
+{
+    TCGLabelPoolData *n = new_pool_alloc(s, 8, rtype, label, addend);
+    n->data[0] = d0;
+    n->data[1] = d1;
+    n->data[2] = d2;
+    n->data[3] = d3;
+    n->data[4] = d4;
+    n->data[5] = d5;
+    n->data[6] = d6;
+    n->data[7] = d7;
+    new_pool_insert(s, n);
+}
+
 /* To be provided by cpu/tcg-target.inc.c.  */
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count);
 
 static bool tcg_out_pool_finalize(TCGContext *s)
 {
     TCGLabelPoolData *p = s->pool_labels;
-    tcg_target_ulong d, *a;
+    TCGLabelPoolData *l = NULL;
+    void *a;
 
     if (p == NULL) {
         return true;
@@ -62,24 +133,24 @@ static bool tcg_out_pool_finalize(TCGContext *s)
 
     /* ??? Round up to qemu_icache_linesize, but then do not round
        again when allocating the next TranslationBlock structure.  */
-    a = (void *)ROUND_UP((uintptr_t)s->code_ptr, sizeof(tcg_target_ulong));
+    a = (void *)ROUND_UP((uintptr_t)s->code_ptr,
+                         sizeof(tcg_target_ulong) * p->nlong);
     tcg_out_nop_fill(s->code_ptr, (tcg_insn_unit *)a - s->code_ptr);
     s->data_gen_ptr = a;
 
-    /* Ensure the first comparison fails.  */
-    d = p->data + 1;
-
     for (; p != NULL; p = p->next) {
-        if (p->data != d) {
-            d = p->data;
-            if (unlikely((void *)a > s->code_gen_highwater)) {
+        size_t size = sizeof(tcg_target_ulong) * p->nlong;
+        if (!l || l->nlong != p->nlong || memcmp(l->data, p->data, size)) {
+            if (unlikely(a > s->code_gen_highwater)) {
                 return false;
             }
-            *a++ = d;
+            memcpy(a, p->data, size);
+            a += size;
+            l = p;
         }
-        patch_reloc(p->label, p->type, (intptr_t)(a - 1), p->addend);
+        patch_reloc(p->label, p->rtype, (intptr_t)a - size, p->addend);
     }
 
-    s->code_ptr = (void *)a;
+    s->code_ptr = a;
     return true;
 }
-- 
2.14.3
