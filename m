Received: from eggs.gnu.org ([2001:4830:134:3::10]:37012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXye-00073a-S0
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXyd-0005r6-MF
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:12 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:41585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTXyd-0005qH-GC
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:11 -0400
Received: by mail-pg0-x242.google.com with SMTP id l65-v6so3358462pgl.8
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 12:32:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Jun 2018 09:31:39 -1000
Message-Id: <20180614193147.29680-11-richard.henderson@linaro.org>
In-Reply-To: <20180614193147.29680-1-richard.henderson@linaro.org>
References: <20180614193147.29680-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/18] translate-all: move
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
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

This greatly simplifies next commit's diff.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 77 ++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 38 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f32904d4a3..83bb40fb20 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1363,44 +1363,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     return tb;
 }
 
-/*
- * Invalidate all TBs which intersect with the target physical address range
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
 /*
  * Invalidate all TBs which intersect with the target physical address range
  * [start;end[. NOTE: start and end must refer to the *same* physical page.
@@ -1500,6 +1462,45 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
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
2.17.1
