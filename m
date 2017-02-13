Received: from eggs.gnu.org ([2001:4830:134:3::10]:53639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdFSP-0005Mw-0n
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdFSN-0002cY-Kl
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:10:12 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cdFSN-0002bz-FO
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:10:11 -0500
Received: by mail-wm0-x234.google.com with SMTP id v77so91993082wmv.0
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 04:10:11 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 13 Feb 2017 12:10:03 +0000
Message-Id: <20170213121017.12907-11-alex.bennee@linaro.org>
In-Reply-To: <20170213121017.12907-1-alex.bennee@linaro.org>
References: <20170213121017.12907-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v12 10/24] tcg: enable tb_lock() for SoftMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net
Cc: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

tb_lock() has long been used for linux-user mode to protect code
generation. By enabling it now we prepare for MTTCG and ensure all code
generation is serialised by this lock. The other major structure that
needs protecting is the l1_map and its PageDesc structures. For the
SoftMMU case we also use tb_lock() to protect these structures instead
of linux-user mmap_lock() which as the name suggests serialises updates
to the structure as a result of guest mmap operations.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
v4
  - split from main tcg: enable thread-per-vCPU patch
v7
  - fixed up with Pranith's tcg_debug_assert() changes
---
 translate-all.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/translate-all.c b/translate-all.c
index f810259c41..9bac061c9b 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -75,7 +75,7 @@
  * mmap_lock.
  */
 #ifdef CONFIG_SOFTMMU
-#define assert_memory_lock() do { /* nothing */ } while (0)
+#define assert_memory_lock() tcg_debug_assert(have_tb_lock)
 #else
 #define assert_memory_lock() tcg_debug_assert(have_mmap_lock())
 #endif
@@ -135,9 +135,7 @@ TCGContext tcg_ctx;
 bool parallel_cpus;
 
 /* translation block context */
-#ifdef CONFIG_USER_ONLY
 __thread int have_tb_lock;
-#endif
 
 static void page_table_config_init(void)
 {
@@ -159,40 +157,29 @@ static void page_table_config_init(void)
     assert(v_l2_levels >= 0);
 }
 
-#ifdef CONFIG_USER_ONLY
 #define assert_tb_locked() tcg_debug_assert(have_tb_lock)
 #define assert_tb_unlocked() tcg_debug_assert(!have_tb_lock)
-#else
-#define assert_tb_locked()  do { /* nothing */ } while (0)
-#define assert_tb_unlocked()  do { /* nothing */ } while (0)
-#endif
 
 void tb_lock(void)
 {
-#ifdef CONFIG_USER_ONLY
     assert_tb_unlocked();
     qemu_mutex_lock(&tcg_ctx.tb_ctx.tb_lock);
     have_tb_lock++;
-#endif
 }
 
 void tb_unlock(void)
 {
-#ifdef CONFIG_USER_ONLY
     assert_tb_locked();
     have_tb_lock--;
     qemu_mutex_unlock(&tcg_ctx.tb_ctx.tb_lock);
-#endif
 }
 
 void tb_lock_reset(void)
 {
-#ifdef CONFIG_USER_ONLY
     if (have_tb_lock) {
         qemu_mutex_unlock(&tcg_ctx.tb_ctx.tb_lock);
         have_tb_lock = 0;
     }
-#endif
 }
 
 static TranslationBlock *tb_find_pc(uintptr_t tc_ptr);
-- 
2.11.0
