Received: from eggs.gnu.org ([2001:4830:134:3::10]:36934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXyZ-0006wl-OO
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXyY-0005n5-4U
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:07 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:41796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTXyX-0005lj-VA
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:06 -0400
Received: by mail-pf0-x242.google.com with SMTP id a11-v6so3706183pff.8
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 12:32:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Jun 2018 09:31:36 -1000
Message-Id: <20180614193147.29680-8-richard.henderson@linaro.org>
In-Reply-To: <20180614193147.29680-1-richard.henderson@linaro.org>
References: <20180614193147.29680-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/18] translate-all: make l1_map lockless
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Groundwork for supporting parallel TCG generation.

We never remove entries from the radix tree, so we can use cmpxchg
to implement lockless insertions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c       | 24 ++++++++++++++----------
 docs/devel/multi-thread-tcg.txt |  4 ++--
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 52e62125ed..52273e5846 100644
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
diff --git a/docs/devel/multi-thread-tcg.txt b/docs/devel/multi-thread-tcg.txt
index a99b4564c6..faf8918b23 100644
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
-- 
2.17.1
