Received: from eggs.gnu.org ([2001:4830:134:3::10]:55976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fb6mx-00032n-OW
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fb6ms-0001z5-Rm
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:07:23 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52497)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fb6ms-0001yi-KH
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:07:18 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu,  5 Jul 2018 12:07:17 -0400
Message-Id: <1530806837-5416-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH] translate-all: honour CF_NOCACHE in tb_gen_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>

This fixes a record-replay regression introduced by 95590e2
("translate-all: discard TB when tb_link_page returns an existing
matching TB", 2018-06-15). The problem is that code using CF_NOCACHE
assumes that the TB returned from tb_gen_code is always a
newly-generated one. This assumption, however, was broken in
the aforementioned commit.

Fix it by honouring CF_NOCACHE, so that tb_gen_code always
returns a newly-generated TB when CF_NOCACHE is passed to it.
Do this by avoiding the TB hash table if CF_NOCACHE is set.

Reported-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Tested-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 170b957..49d77fa 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1446,7 +1446,8 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
     phys_pc = tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
     h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb_cflags(tb) & CF_HASH_MASK,
                      tb->trace_vcpu_dstate);
-    if (!qht_remove(&tb_ctx.htable, tb, h)) {
+    if (!(tb->cflags & CF_NOCACHE) &&
+        !qht_remove(&tb_ctx.htable, tb, h)) {
         return;
     }
 
@@ -1604,8 +1605,6 @@ tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
 {
     PageDesc *p;
     PageDesc *p2 = NULL;
-    void *existing_tb = NULL;
-    uint32_t h;
 
     assert_memory_lock();
 
@@ -1625,20 +1624,25 @@ tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
         tb->page_addr[1] = -1;
     }
 
-    /* add in the hash table */
-    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_MASK,
-                     tb->trace_vcpu_dstate);
-    qht_insert(&tb_ctx.htable, tb, h, &existing_tb);
+    if (!(tb->cflags & CF_NOCACHE)) {
+        void *existing_tb = NULL;
+        uint32_t h;
 
-    /* remove TB from the page(s) if we couldn't insert it */
-    if (unlikely(existing_tb)) {
-        tb_page_remove(p, tb);
-        invalidate_page_bitmap(p);
-        if (p2) {
-            tb_page_remove(p2, tb);
-            invalidate_page_bitmap(p2);
+        /* add in the hash table */
+        h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_MASK,
+                         tb->trace_vcpu_dstate);
+        qht_insert(&tb_ctx.htable, tb, h, &existing_tb);
+
+        /* remove TB from the page(s) if we couldn't insert it */
+        if (unlikely(existing_tb)) {
+            tb_page_remove(p, tb);
+            invalidate_page_bitmap(p);
+            if (p2) {
+                tb_page_remove(p2, tb);
+                invalidate_page_bitmap(p2);
+            }
+            tb = existing_tb;
         }
-        tb = existing_tb;
     }
 
     if (p2 && p2 != p) {
-- 
2.7.4
