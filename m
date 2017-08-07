Received: from eggs.gnu.org ([2001:4830:134:3::10]:47870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpR-0005yu-0R
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpJ-0005l2-Ep
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35559)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1derpJ-0005km-Aq
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  7 Aug 2017 19:52:36 -0400
Message-Id: <1502149958-23381-21-git-send-email-cota@braap.org>
In-Reply-To: <1502149958-23381-1-git-send-email-cota@braap.org>
References: <1502149958-23381-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 20/22] exec: remove tb_lock from
 notdirty_mem_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

By passing a locked page_collection to tb_invalidate_phys_page_fast.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.h |  3 ++-
 accel/tcg/translate-all.c |  8 ++++----
 exec.c                    | 11 +++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
index 6d1d258..e6cb963 100644
--- a/accel/tcg/translate-all.h
+++ b/accel/tcg/translate-all.h
@@ -26,7 +26,8 @@
 struct page_collection *page_collection_lock(tb_page_addr_t start,
                                              tb_page_addr_t end);
 void page_collection_unlock(struct page_collection *set);
-void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len);
+void tb_invalidate_phys_page_fast(struct page_collection *pages,
+                                  tb_page_addr_t start, int len);
 void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
                                    int is_cpu_write_access);
 void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 30c3fba..dc19217 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1915,10 +1915,12 @@ void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
 /* len must be <= 8 and start must be a multiple of len.
  * Called via softmmu_template.h when code areas are written to with
  * iothread mutex not held.
+ *
+ * Call with all @pages in the range [@start, @start + len[ locked.
  */
-void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len)
+void tb_invalidate_phys_page_fast(struct page_collection *pages,
+                                  tb_page_addr_t start, int len)
 {
-    struct page_collection *pages;
     PageDesc *p;
 
 #if 0
@@ -1937,7 +1939,6 @@ void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len)
         return;
     }
 
-    pages = page_collection_lock(start, start + len);
     if (!p->code_bitmap &&
         ++p->code_write_count >= SMC_BITMAP_USE_THRESHOLD) {
         build_page_bitmap(p);
@@ -1955,7 +1956,6 @@ void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len)
     do_invalidate:
         tb_invalidate_phys_page_range__locked(pages, p, start, start + len, 1);
     }
-    page_collection_unlock(pages);
 }
 #else
 /* Called with mmap_lock held. If pc is not 0 then it indicates the
diff --git a/exec.c b/exec.c
index 6e85535..620a496 100644
--- a/exec.c
+++ b/exec.c
@@ -2331,13 +2331,12 @@ ram_addr_t qemu_ram_addr_from_host(void *ptr)
 static void notdirty_mem_write(void *opaque, hwaddr ram_addr,
                                uint64_t val, unsigned size)
 {
-    bool locked = false;
+    struct page_collection *pages = NULL;
 
     assert(tcg_enabled());
     if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)) {
-        locked = true;
-        tb_lock();
-        tb_invalidate_phys_page_fast(ram_addr, size);
+        pages = page_collection_lock(ram_addr, ram_addr + size);
+        tb_invalidate_phys_page_fast(pages, ram_addr, size);
     }
     switch (size) {
     case 1:
@@ -2353,8 +2352,8 @@ static void notdirty_mem_write(void *opaque, hwaddr ram_addr,
         abort();
     }
 
-    if (locked) {
-        tb_unlock();
+    if (pages) {
+        page_collection_unlock(pages);
     }
 
     /* Set both VGA and migration bits for simplicity and to remove
-- 
2.7.4
