Received: from eggs.gnu.org ([2001:4830:134:3::10]:52732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AY-0002mN-Bg
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AT-0003uI-CY
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:12 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:51122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e49AT-0003tg-88
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:09 -0400
Received: by mail-pg0-x22f.google.com with SMTP id y7so7343538pgb.7
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:27:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:58 -0700
Message-Id: <20171016172609.23422-40-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 39/50] exec-all: rename tb_free to tb_remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

From: "Emilio G. Cota" <cota@braap.org>

We don't really free anything in this function anymore; we just remove
the TB from the binary search tree.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h   | 2 +-
 accel/tcg/cpu-exec.c      | 2 +-
 accel/tcg/translate-all.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 4c4242a1d8..746f4be71e 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -389,7 +389,7 @@ static inline uint32_t curr_cflags(void)
          | (use_icount ? CF_USE_ICOUNT : 0);
 }
 
-void tb_free(TranslationBlock *tb);
+void tb_remove(TranslationBlock *tb);
 void tb_flush(CPUState *cpu);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 59fd784436..6a4a33235b 100644
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
index 083e1c7336..76db9c775a 100644
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
 
@@ -1816,7 +1816,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
              * cpu_exec_nocache() */
             tb_phys_invalidate(tb->orig_tb, -1);
         }
-        tb_free(tb);
+        tb_remove(tb);
     }
     /* FIXME: In theory this could raise an exception.  In practice
        we have already translated the block once so it's probably ok.  */
-- 
2.13.6
