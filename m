Received: from eggs.gnu.org ([2001:4830:134:3::10]:50996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eqXzH-0004bZ-WB
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 00:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eqXzD-0000R6-6w
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 00:39:40 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40001)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eqXzD-0000QK-1f
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 00:39:35 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 27 Feb 2018 00:39:20 -0500
Message-Id: <1519709965-29833-12-git-send-email-cota@braap.org>
In-Reply-To: <1519709965-29833-1-git-send-email-cota@braap.org>
References: <1519709965-29833-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 11/16] translate-all: add page_collection
 assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

The appended adds assertions to make sure we do not longjmp with page
locks held. Some notes:

- user-mode has nothing to check, since page_locks are !user-mode only.

- The checks only apply to page collections, since these have relatively
  complex callers.

- Some simple page_lock/unlock callers have been left unchecked --
  namely page_lock_tb, tb_phys_invalidate and tb_link_page.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cpu-exec.c      |  1 +
 accel/tcg/translate-all.c | 22 ++++++++++++++++++++++
 include/exec/exec-all.h   |  8 ++++++++
 3 files changed, 31 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8c68727..7c83887 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -271,6 +271,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
         tcg_debug_assert(!have_mmap_lock());
 #endif
         tb_lock_reset();
+        assert_page_collection_locked(false);
     }
 
     if (in_exclusive_region) {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 07527d5..82832ef 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -605,6 +605,24 @@ void page_collection_unlock(struct page_collection *set)
 { }
 #else /* !CONFIG_USER_ONLY */
 
+#ifdef CONFIG_DEBUG_TCG
+static __thread bool page_collection_locked;
+
+void assert_page_collection_locked(bool val)
+{
+    tcg_debug_assert(page_collection_locked == val);
+}
+
+static inline void set_page_collection_locked(bool val)
+{
+    page_collection_locked = val;
+}
+#else
+static inline void set_page_collection_locked(bool val)
+{
+}
+#endif /* !CONFIG_DEBUG_TCG */
+
 static inline void page_lock(PageDesc *pd)
 {
     qemu_spin_lock(&pd->lock);
@@ -677,6 +695,7 @@ static void do_page_entry_lock(struct page_entry *pe)
     page_lock(pe->pd);
     g_assert(!pe->locked);
     pe->locked = true;
+    set_page_collection_locked(true);
 }
 
 static gboolean page_entry_lock(gpointer key, gpointer value, gpointer data)
@@ -769,6 +788,7 @@ page_collection_lock(tb_page_addr_t start, tb_page_addr_t end)
     set->tree = g_tree_new_full(tb_page_addr_cmp, NULL, NULL,
                                 page_entry_destroy);
     set->max = NULL;
+    assert_page_collection_locked(false);
 
  retry:
     g_tree_foreach(set->tree, page_entry_lock, NULL);
@@ -787,6 +807,7 @@ page_collection_lock(tb_page_addr_t start, tb_page_addr_t end)
                  page_trylock_add(set, tb->page_addr[1]))) {
                 /* drop all locks, and reacquire in order */
                 g_tree_foreach(set->tree, page_entry_unlock, NULL);
+                set_page_collection_locked(false);
                 goto retry;
             }
         }
@@ -799,6 +820,7 @@ void page_collection_unlock(struct page_collection *set)
     /* entries are unlocked and freed via page_entry_destroy */
     g_tree_destroy(set->tree);
     g_free(set);
+    set_page_collection_locked(false);
 }
 
 #endif /* !CONFIG_USER_ONLY */
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index aeaa127..7911e69 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -431,6 +431,14 @@ void tb_lock(void);
 void tb_unlock(void);
 void tb_lock_reset(void);
 
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_DEBUG_TCG)
+void assert_page_collection_locked(bool val);
+#else
+static inline void assert_page_collection_locked(bool val)
+{
+}
+#endif
+
 #if !defined(CONFIG_USER_ONLY)
 
 struct MemoryRegion *iotlb_to_region(CPUState *cpu,
-- 
2.7.4
