Received: from eggs.gnu.org ([2001:4830:134:3::10]:38675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUG9H-0007T2-QD
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUG9D-0007kG-OK
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:19 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cUG9D-0007ji-BC
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:15 -0500
Received: by mail-wm0-x22c.google.com with SMTP id c206so2815872wme.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:05:15 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Jan 2017 17:04:42 +0000
Message-Id: <20170119170507.16185-3-alex.bennee@linaro.org>
In-Reply-To: <20170119170507.16185-1-alex.bennee@linaro.org>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 02/27] mttcg: translate-all: Enable locking
 debug in a debug build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

From: Pranith Kumar <bobby.prani@gmail.com>

Enable tcg lock debug asserts in a debug build by default instead of
relying on DEBUG_LOCKING. None of the other DEBUG_* macros have
asserts, so this patch removes DEBUG_LOCKING and enable these asserts
in a debug build.

CC: Richard Henderson <rth@twiddle.net>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
[AJB: tweak ifdefs so can be early in series]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 translate-all.c | 52 ++++++++++++++++------------------------------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/translate-all.c b/translate-all.c
index 20262938bb..055436a676 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -59,7 +59,6 @@
 
 /* #define DEBUG_TB_INVALIDATE */
 /* #define DEBUG_TB_FLUSH */
-/* #define DEBUG_LOCKING */
 /* make various TB consistency checks */
 /* #define DEBUG_TB_CHECK */
 
@@ -74,20 +73,10 @@
  * access to the memory related structures are protected with the
  * mmap_lock.
  */
-#ifdef DEBUG_LOCKING
-#define DEBUG_MEM_LOCKS 1
-#else
-#define DEBUG_MEM_LOCKS 0
-#endif
-
 #ifdef CONFIG_SOFTMMU
 #define assert_memory_lock() do { /* nothing */ } while (0)
 #else
-#define assert_memory_lock() do {               \
-        if (DEBUG_MEM_LOCKS) {                  \
-            g_assert(have_mmap_lock());         \
-        }                                       \
-    } while (0)
+#define assert_memory_lock() tcg_debug_assert(have_mmap_lock())
 #endif
 
 #define SMC_BITMAP_USE_THRESHOLD 10
@@ -169,10 +158,18 @@ static void page_table_config_init(void)
     assert(v_l2_levels >= 0);
 }
 
+#ifdef CONFIG_USER_ONLY
+#define assert_tb_locked() tcg_debug_assert(have_tb_lock)
+#define assert_tb_unlocked() tcg_debug_assert(!have_tb_lock)
+#else
+#define assert_tb_locked()  do { /* nothing */ } while (0)
+#define assert_tb_unlocked()  do { /* nothing */ } while (0)
+#endif
+
 void tb_lock(void)
 {
 #ifdef CONFIG_USER_ONLY
-    assert(!have_tb_lock);
+    assert_tb_unlocked();
     qemu_mutex_lock(&tcg_ctx.tb_ctx.tb_lock);
     have_tb_lock++;
 #endif
@@ -181,7 +178,7 @@ void tb_lock(void)
 void tb_unlock(void)
 {
 #ifdef CONFIG_USER_ONLY
-    assert(have_tb_lock);
+    assert_tb_locked();
     have_tb_lock--;
     qemu_mutex_unlock(&tcg_ctx.tb_ctx.tb_lock);
 #endif
@@ -197,23 +194,6 @@ void tb_lock_reset(void)
 #endif
 }
 
-#ifdef DEBUG_LOCKING
-#define DEBUG_TB_LOCKS 1
-#else
-#define DEBUG_TB_LOCKS 0
-#endif
-
-#ifdef CONFIG_SOFTMMU
-#define assert_tb_lock() do { /* nothing */ } while (0)
-#else
-#define assert_tb_lock() do {               \
-        if (DEBUG_TB_LOCKS) {               \
-            g_assert(have_tb_lock);         \
-        }                                   \
-    } while (0)
-#endif
-
-
 static TranslationBlock *tb_find_pc(uintptr_t tc_ptr);
 
 void cpu_gen_init(void)
@@ -847,7 +827,7 @@ static TranslationBlock *tb_alloc(target_ulong pc)
 {
     TranslationBlock *tb;
 
-    assert_tb_lock();
+    assert_tb_locked();
 
     if (tcg_ctx.tb_ctx.nb_tbs >= tcg_ctx.code_gen_max_blocks) {
         return NULL;
@@ -862,7 +842,7 @@ static TranslationBlock *tb_alloc(target_ulong pc)
 /* Called with tb_lock held.  */
 void tb_free(TranslationBlock *tb)
 {
-    assert_tb_lock();
+    assert_tb_locked();
 
     /* In practice this is mostly used for single use temporary TB
        Ignore the hard cases and just back up if this TB happens to
@@ -1104,7 +1084,7 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
     uint32_t h;
     tb_page_addr_t phys_pc;
 
-    assert_tb_lock();
+    assert_tb_locked();
 
     atomic_set(&tb->invalid, true);
 
@@ -1419,7 +1399,7 @@ static void tb_invalidate_phys_range_1(tb_page_addr_t start, tb_page_addr_t end)
 #ifdef CONFIG_SOFTMMU
 void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
 {
-    assert_tb_lock();
+    assert_tb_locked();
     tb_invalidate_phys_range_1(start, end);
 }
 #else
@@ -1462,7 +1442,7 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
 #endif /* TARGET_HAS_PRECISE_SMC */
 
     assert_memory_lock();
-    assert_tb_lock();
+    assert_tb_locked();
 
     p = page_find(start >> TARGET_PAGE_BITS);
     if (!p) {
-- 
2.11.0
