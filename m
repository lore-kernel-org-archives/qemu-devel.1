Received: from eggs.gnu.org ([2001:4830:134:3::10]:45977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6v-0000FM-7O
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6t-00008g-FL
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:29 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:56390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6t-00007p-95
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:27 -0400
Received: by mail-wr0-x243.google.com with SMTP id r79so23326216wrb.13
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:22 +0200
Message-Id: <20171025093535.10175-39-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 38/51] exec-all: rename tb_free to tb_remove
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

We don't really free anything in this function anymore; we just remove
the TB from the binary search tree.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h   | 2 +-
 accel/tcg/cpu-exec.c      | 2 +-
 accel/tcg/translate-all.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index e2d598082e..923ece3e9b 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -388,7 +388,7 @@ static inline uint32_t curr_cflags(void)
          | (use_icount ? CF_USE_ICOUNT : 0);
 }
 
-void tb_free(TranslationBlock *tb);
+void tb_remove(TranslationBlock *tb);
 void tb_flush(CPUState *cpu);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index b44c7941aa..9b58cdee28 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -220,7 +220,7 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
 
     tb_lock();
     tb_phys_invalidate(tb, -1);
-    tb_free(tb);
+    tb_remove(tb);
     tb_unlock();
 }
 #endif
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 678e5ab61e..e929ccb30b 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -373,7 +373,7 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t retaddr)
         if (tb->cflags & CF_NOCACHE) {
             /* one-shot translation, invalidate it immediately */
             tb_phys_invalidate(tb, -1);
-            tb_free(tb);
+            tb_remove(tb);
         }
         r = true;
     }
@@ -872,7 +872,7 @@ static TranslationBlock *tb_alloc(target_ulong pc)
 }
 
 /* Called with tb_lock held.  */
-void tb_free(TranslationBlock *tb)
+void tb_remove(TranslationBlock *tb)
 {
     assert_tb_locked();
 
@@ -1811,7 +1811,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
              * cpu_exec_nocache() */
             tb_phys_invalidate(tb->orig_tb, -1);
         }
-        tb_free(tb);
+        tb_remove(tb);
     }
 
     /* TODO: If env->pc != tb->pc (i.e. the faulting instruction was not
-- 
2.13.6
