Received: from eggs.gnu.org ([2001:4830:134:3::10]:57833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fKuOt-0002eL-6j
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fKuOr-0005YZ-9f
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fKuOq-0005XX-FP
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:32 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 21 May 2018 19:39:22 -0400
Message-Id: <1526945967-9687-13-git-send-email-cota@braap.org>
In-Reply-To: <1526945967-9687-1-git-send-email-cota@braap.org>
References: <1526945967-9687-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 12/17] translate-all: introduce
 assert_no_pages_locked
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

The appended adds assertions to make sure we do not longjmp with page
locks held. Note that user-mode has nothing to check, since page_locks
are !user-mode only.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h   | 8 ++++++++
 accel/tcg/cpu-exec.c      | 1 +
 accel/tcg/translate-all.c | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 3fad93b..66902f7 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -434,6 +434,14 @@ void tb_lock(void);
 void tb_unlock(void);
 void tb_lock_reset(void);
 
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_DEBUG_TCG)
+void assert_no_pages_locked(void);
+#else
+static inline void assert_no_pages_locked(void)
+{
+}
+#endif
+
 #if !defined(CONFIG_USER_ONLY)
 
 struct MemoryRegion *iotlb_to_region(CPUState *cpu,
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 7b934a6..ad1f0c4 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -274,6 +274,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
         tcg_debug_assert(!have_mmap_lock());
 #endif
         tb_lock_reset();
+        assert_no_pages_locked();
     }
 
     if (in_exclusive_region) {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 8286203..f3a0ecb 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -658,6 +658,12 @@ do_assert_page_locked(const PageDesc *pd, const char *file, int line)
 
 #define assert_page_locked(pd) do_assert_page_locked(pd, __FILE__, __LINE__)
 
+void assert_no_pages_locked(void)
+{
+    ht_pages_locked_debug_init();
+    g_assert(g_hash_table_size(ht_pages_locked_debug) == 0);
+}
+
 #else /* !CONFIG_DEBUG_TCG */
 
 #define assert_page_locked(pd)
@@ -828,6 +834,7 @@ page_collection_lock(tb_page_addr_t start, tb_page_addr_t end)
     set->tree = g_tree_new_full(tb_page_addr_cmp, NULL, NULL,
                                 page_entry_destroy);
     set->max = NULL;
+    assert_no_pages_locked();
 
  retry:
     g_tree_foreach(set->tree, page_entry_lock, NULL);
-- 
2.7.4
