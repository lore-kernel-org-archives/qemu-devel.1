Received: from eggs.gnu.org ([2001:4830:134:3::10]:58462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4GsM-0002GY-IR
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 22:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4GsK-0003WA-Ar
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 22:13:14 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51093)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f4GsK-0003Vf-3h
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 22:13:12 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu,  5 Apr 2018 22:13:03 -0400
Message-Id: <1522980788-1252-13-git-send-email-cota@braap.org>
In-Reply-To: <1522980788-1252-1-git-send-email-cota@braap.org>
References: <1522980788-1252-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 12/17] translate-all: add page_collection
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

The appended adds assertions to make sure we do not longjmp with page
locks held. Some notes:

- user-mode has nothing to check, since page_locks are !user-mode only.

- The checks only apply to page collections, since these have relatively
  complex callers.

- Some simple page_lock/unlock callers have been left unchecked --
  namely page_lock_tb, tb_phys_invalidate and tb_link_page.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h   |  8 ++++++++
 accel/tcg/cpu-exec.c      |  1 +
 accel/tcg/translate-all.c | 20 ++++++++++++++++++++
 3 files changed, 29 insertions(+)

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
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 778801a..6a3a21d 100644
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
index 29bc1da..f8862f6 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -666,6 +666,18 @@ do_assert_page_locked(const PageDesc *pd, const char *file, int line)
 
 #define assert_page_locked(pd) do_assert_page_locked(pd, __FILE__, __LINE__)
 
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
+
 #else /* !CONFIG_DEBUG_TCG */
 
 #define assert_page_locked(pd)
@@ -678,6 +690,10 @@ static inline void page_unlock__debug(const PageDesc *pd)
 {
 }
 
+static inline void set_page_collection_locked(bool val)
+{
+}
+
 #endif /* CONFIG_DEBUG_TCG */
 
 static inline void page_lock(PageDesc *pd)
@@ -754,6 +770,7 @@ static void do_page_entry_lock(struct page_entry *pe)
     page_lock(pe->pd);
     g_assert(!pe->locked);
     pe->locked = true;
+    set_page_collection_locked(true);
 }
 
 static gboolean page_entry_lock(gpointer key, gpointer value, gpointer data)
@@ -846,6 +863,7 @@ page_collection_lock(tb_page_addr_t start, tb_page_addr_t end)
     set->tree = g_tree_new_full(tb_page_addr_cmp, NULL, NULL,
                                 page_entry_destroy);
     set->max = NULL;
+    assert_page_collection_locked(false);
 
  retry:
     g_tree_foreach(set->tree, page_entry_lock, NULL);
@@ -864,6 +882,7 @@ page_collection_lock(tb_page_addr_t start, tb_page_addr_t end)
                  page_trylock_add(set, tb->page_addr[1]))) {
                 /* drop all locks, and reacquire in order */
                 g_tree_foreach(set->tree, page_entry_unlock, NULL);
+                set_page_collection_locked(false);
                 goto retry;
             }
         }
@@ -876,6 +895,7 @@ void page_collection_unlock(struct page_collection *set)
     /* entries are unlocked and freed via page_entry_destroy */
     g_tree_destroy(set->tree);
     g_free(set);
+    set_page_collection_locked(false);
 }
 
 #endif /* !CONFIG_USER_ONLY */
-- 
2.7.4
