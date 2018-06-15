Received: from eggs.gnu.org ([2001:4830:134:3::10]:51649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTue4-0000WB-NN
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTue1-0002cL-GH
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:44:28 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:43852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTue1-0002bl-Ad
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:44:25 -0400
Received: by mail-pg0-x22c.google.com with SMTP id a14-v6so4852466pgw.10
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:44:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 15 Jun 2018 09:43:48 -1000
Message-Id: <20180615194354.12489-14-richard.henderson@linaro.org>
In-Reply-To: <20180615194354.12489-1-richard.henderson@linaro.org>
References: <20180615194354.12489-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v2 13/19] translate-all: introduce
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
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

The appended adds assertions to make sure we do not longjmp with page
locks held. Note that user-mode has nothing to check, since page_locks
are !user-mode only.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h   | 8 ++++++++
 accel/tcg/cpu-exec.c      | 1 +
 accel/tcg/translate-all.c | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 8d92e3cea9..4f07a17052 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -435,6 +435,14 @@ void tb_lock(void);
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
 
 /**
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 7570c59f09..d75c35380a 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -273,6 +273,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
         tcg_debug_assert(!have_mmap_lock());
 #endif
         tb_lock_reset();
+        assert_no_pages_locked();
     }
 
     if (in_exclusive_region) {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 8b378586f4..c75298d08a 100644
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
@@ -829,6 +835,7 @@ page_collection_lock(tb_page_addr_t start, tb_page_addr_t end)
     set->tree = g_tree_new_full(tb_page_addr_cmp, NULL, NULL,
                                 page_entry_destroy);
     set->max = NULL;
+    assert_no_pages_locked();
 
  retry:
     g_tree_foreach(set->tree, page_entry_lock, NULL);
-- 
2.17.1
