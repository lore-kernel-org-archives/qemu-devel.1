Received: from eggs.gnu.org ([2001:4830:134:3::10]:57825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fKuOt-0002eF-5r
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fKuOq-0005Xc-6P
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34215)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fKuOp-0005Vx-V5
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:32 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 21 May 2018 19:39:16 -0400
Message-Id: <1526945967-9687-7-git-send-email-cota@braap.org>
In-Reply-To: <1526945967-9687-1-git-send-email-cota@braap.org>
References: <1526945967-9687-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 06/17] translate-all: make l1_map lockless
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Groundwork for supporting parallel TCG generation.

We never remove entries from the radix tree, so we can use cmpxchg
to implement lockless insertions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 docs/devel/multi-thread-tcg.txt |  4 ++--
 accel/tcg/translate-all.c       | 24 ++++++++++++++----------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/docs/devel/multi-thread-tcg.txt b/docs/devel/multi-thread-tcg.txt
index a99b456..faf8918 100644
--- a/docs/devel/multi-thread-tcg.txt
+++ b/docs/devel/multi-thread-tcg.txt
@@ -134,8 +134,8 @@ tb_set_jmp_target() code. Modification to the linked lists that allow
 searching for linked pages are done under the protect of the
 tb_lock().
 
-The global page table is protected by the tb_lock() in system-mode and
-mmap_lock() in linux-user mode.
+The global page table is a lockless radix tree; cmpxchg is used
+to atomically insert new elements.
 
 The lookup caches are updated atomically and the lookup hash uses QHT
 which is designed for concurrent safe lookup.
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 7302d05..38e712d 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -469,20 +469,12 @@ static void page_init(void)
 #endif
 }
 
-/* If alloc=1:
- * Called with tb_lock held for system emulation.
- * Called with mmap_lock held for user-mode emulation.
- */
 static PageDesc *page_find_alloc(tb_page_addr_t index, int alloc)
 {
     PageDesc *pd;
     void **lp;
     int i;
 
-    if (alloc) {
-        assert_memory_lock();
-    }
-
     /* Level 1.  Always allocated.  */
     lp = l1_map + ((index >> v_l1_shift) & (v_l1_size - 1));
 
@@ -491,11 +483,17 @@ static PageDesc *page_find_alloc(tb_page_addr_t index, int alloc)
         void **p = atomic_rcu_read(lp);
 
         if (p == NULL) {
+            void *existing;
+
             if (!alloc) {
                 return NULL;
             }
             p = g_new0(void *, V_L2_SIZE);
-            atomic_rcu_set(lp, p);
+            existing = atomic_cmpxchg(lp, NULL, p);
+            if (unlikely(existing)) {
+                g_free(p);
+                p = existing;
+            }
         }
 
         lp = p + ((index >> (i * V_L2_BITS)) & (V_L2_SIZE - 1));
@@ -503,11 +501,17 @@ static PageDesc *page_find_alloc(tb_page_addr_t index, int alloc)
 
     pd = atomic_rcu_read(lp);
     if (pd == NULL) {
+        void *existing;
+
         if (!alloc) {
             return NULL;
         }
         pd = g_new0(PageDesc, V_L2_SIZE);
-        atomic_rcu_set(lp, pd);
+        existing = atomic_cmpxchg(lp, NULL, pd);
+        if (unlikely(existing)) {
+            g_free(pd);
+            pd = existing;
+        }
     }
 
     return pd + (index & (V_L2_SIZE - 1));
-- 
2.7.4
