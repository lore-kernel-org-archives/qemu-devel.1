Received: from eggs.gnu.org ([2001:4830:134:3::10]:46264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmc-0001B2-T1
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmX-0008NW-41
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:50 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60087)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmW-0008NJ-WB
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:45 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:04:09 -0400
Message-Id: <1500235468-15341-27-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 26/45] translate-all: define and use
 DEBUG_TB_CHECK_GATE
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

This prevents bit rot by ensuring the debug code is compiled when
building a user-mode target.

Unfortunately the helpers are user-mode-only so we cannot fully
get rid of the ifdef checks. Add a comment to explain this.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index aaf3993..df1ccbf 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -82,6 +82,12 @@
 #undef DEBUG_TB_CHECK
 #endif
 
+#ifdef DEBUG_TB_CHECK
+#define DEBUG_TB_CHECK_GATE 1
+#else
+#define DEBUG_TB_CHECK_GATE 0
+#endif
+
 /* Access to the various translations structures need to be serialised via locks
  * for consistency. This is automatic for SoftMMU based system
  * emulation due to its single threaded nature. In user-mode emulation
@@ -950,7 +956,13 @@ void tb_flush(CPUState *cpu)
     }
 }
 
-#ifdef DEBUG_TB_CHECK
+/*
+ * Formerly ifdef DEBUG_TB_CHECK. These debug functions are user-mode-only,
+ * so in order to prevent bit rot we compile them unconditionally in user-mode,
+ * and let the optimizer get rid of them by wrapping their user-only callers
+ * with if (DEBUG_TB_CHECK_GATE).
+ */
+#ifdef CONFIG_USER_ONLY
 
 static void
 do_tb_invalidate_check(struct qht *ht, void *p, uint32_t hash, void *userp)
@@ -994,7 +1006,7 @@ static void tb_page_check(void)
     qht_iter(&tcg_ctx.tb_ctx.htable, do_tb_page_check, NULL);
 }
 
-#endif
+#endif /* CONFIG_USER_ONLY */
 
 static inline void tb_page_remove(TranslationBlock **ptb, TranslationBlock *tb)
 {
@@ -1242,8 +1254,10 @@ static void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
                      tb->trace_vcpu_dstate);
     qht_insert(&tcg_ctx.tb_ctx.htable, tb, h);
 
-#ifdef DEBUG_TB_CHECK
-    tb_page_check();
+#ifdef CONFIG_USER_ONLY
+    if (DEBUG_TB_CHECK_GATE) {
+        tb_page_check();
+    }
 #endif
 }
 
@@ -2223,8 +2237,10 @@ int page_unprotect(target_ulong address, uintptr_t pc)
             /* and since the content will be modified, we must invalidate
                the corresponding translated code. */
             current_tb_invalidated |= tb_invalidate_phys_page(addr, pc);
-#ifdef DEBUG_TB_CHECK
-            tb_invalidate_check(addr);
+#ifdef CONFIG_USER_ONLY
+            if (DEBUG_TB_CHECK_GATE) {
+                tb_invalidate_check(addr);
+            }
 #endif
         }
         mprotect((void *)g2h(host_start), qemu_host_page_size,
-- 
2.7.4
