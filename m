Received: from eggs.gnu.org ([2001:4830:134:3::10]:47818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpN-0005yf-Ku
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpI-0005jy-A5
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:53 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56507)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1derpI-0005jh-77
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:48 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  7 Aug 2017 19:52:31 -0400
Message-Id: <1502149958-23381-16-git-send-email-cota@braap.org>
In-Reply-To: <1502149958-23381-1-git-send-email-cota@braap.org>
References: <1502149958-23381-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 15/22] translate-all: move
 tb_invalidate_phys_page_range up in the file
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

This greatly simplifies next commit's diff.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 77 ++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 38 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index e8f663f..76fecf5 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1362,44 +1362,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 
 /*
  * Invalidate all TBs which intersect with the target physical address range
- * [start;end[. NOTE: start and end may refer to *different* physical pages.
- * 'is_cpu_write_access' should be true if called from a real cpu write
- * access: the virtual CPU will exit the current TB if code is modified inside
- * this TB.
- *
- * Called with mmap_lock held for user-mode emulation, grabs tb_lock
- * Called with tb_lock held for system-mode emulation
- */
-static void tb_invalidate_phys_range_1(tb_page_addr_t start, tb_page_addr_t end)
-{
-    tb_page_addr_t next;
-
-    for (next = (start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
-         start < end;
-         start = next, next += TARGET_PAGE_SIZE) {
-        tb_page_addr_t bound = MIN(next, end);
-
-        tb_invalidate_phys_page_range(start, bound, 0);
-    }
-}
-
-#ifdef CONFIG_SOFTMMU
-void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
-{
-    assert_tb_locked();
-    tb_invalidate_phys_range_1(start, end);
-}
-#else
-void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
-{
-    assert_memory_lock();
-    tb_lock();
-    tb_invalidate_phys_range_1(start, end);
-    tb_unlock();
-}
-#endif
-/*
- * Invalidate all TBs which intersect with the target physical address range
  * [start;end[. NOTE: start and end must refer to the *same* physical page.
  * 'is_cpu_write_access' should be true if called from a real cpu write
  * access: the virtual CPU will exit the current TB if code is modified inside
@@ -1501,6 +1463,45 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
 #endif
 }
 
+/*
+ * Invalidate all TBs which intersect with the target physical address range
+ * [start;end[. NOTE: start and end may refer to *different* physical pages.
+ * 'is_cpu_write_access' should be true if called from a real cpu write
+ * access: the virtual CPU will exit the current TB if code is modified inside
+ * this TB.
+ *
+ * Called with mmap_lock held for user-mode emulation, grabs tb_lock
+ * Called with tb_lock held for system-mode emulation
+ */
+static void tb_invalidate_phys_range_1(tb_page_addr_t start, tb_page_addr_t end)
+{
+    tb_page_addr_t next;
+
+    for (next = (start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+         start < end;
+         start = next, next += TARGET_PAGE_SIZE) {
+        tb_page_addr_t bound = MIN(next, end);
+
+        tb_invalidate_phys_page_range(start, bound, 0);
+    }
+}
+
+#ifdef CONFIG_SOFTMMU
+void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
+{
+    assert_tb_locked();
+    tb_invalidate_phys_range_1(start, end);
+}
+#else
+void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
+{
+    assert_memory_lock();
+    tb_lock();
+    tb_invalidate_phys_range_1(start, end);
+    tb_unlock();
+}
+#endif
+
 #ifdef CONFIG_SOFTMMU
 /* len must be <= 8 and start must be a multiple of len.
  * Called via softmmu_template.h when code areas are written to with
-- 
2.7.4
