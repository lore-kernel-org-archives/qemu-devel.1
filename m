Received: from eggs.gnu.org ([2001:4830:134:3::10]:46207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmb-0001Ap-GO
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmY-0008OC-3N
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52669)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmX-0008Nt-Vp
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:04:12 -0400
Message-Id: <1500235468-15341-30-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 29/45] exec-all: rename tb_free to tb_remove
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

We don't really free anything in this function anymore; we just remove
the TB from the binary search tree.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h   | 2 +-
 accel/tcg/cpu-exec.c      | 2 +-
 accel/tcg/translate-all.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index c7bf683..37487d7 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -408,7 +408,7 @@ static inline uint32_t curr_cf_mask(void)
     return val;
 }
 
-void tb_free(TranslationBlock *tb);
+void tb_remove(TranslationBlock *tb);
 void tb_flush(CPUState *cpu);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ba36f83..604fee2 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -221,7 +221,7 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
 
     tb_lock();
     tb_phys_invalidate(tb, -1);
-    tb_free(tb);
+    tb_remove(tb);
     tb_unlock();
 }
 #endif
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 7a01af0..7c6e401 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -375,7 +375,7 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t retaddr)
         if (tb->cflags & CF_NOCACHE) {
             /* one-shot translation, invalidate it immediately */
             tb_phys_invalidate(tb, -1);
-            tb_free(tb);
+            tb_remove(tb);
         }
         r = true;
     }
@@ -874,7 +874,7 @@ static TranslationBlock *tb_alloc(target_ulong pc)
 }
 
 /* Called with tb_lock held.  */
-void tb_free(TranslationBlock *tb)
+void tb_remove(TranslationBlock *tb)
 {
     assert_tb_locked();
 
@@ -1823,7 +1823,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
              * cpu_exec_nocache() */
             tb_phys_invalidate(tb->orig_tb, -1);
         }
-        tb_free(tb);
+        tb_remove(tb);
     }
     /* FIXME: In theory this could raise an exception.  In practice
        we have already translated the block once so it's probably ok.  */
-- 
2.7.4
