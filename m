Received: from eggs.gnu.org ([2001:4830:134:3::10]:60551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqQ-0002Oi-C9
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqM-0004WM-NR
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:25 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:53905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1iqM-0004Vt-Hf
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:22 -0400
Received: by mail-pf0-x22f.google.com with SMTP id n73so8794306pfg.10
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 17:56:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  9 Oct 2017 17:55:51 -0700
Message-Id: <20171010005600.28735-15-richard.henderson@linaro.org>
In-Reply-To: <20171010005600.28735-1-richard.henderson@linaro.org>
References: <20171010005600.28735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/23] translate-all: define and use
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
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

This prevents bit rot by ensuring the debug code is compiled when
building a user-mode target.

Unfortunately the helpers are user-mode-only so we cannot fully
get rid of the ifdef checks. Add a comment to explain this.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 6b853b329c..26efad302d 100644
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
@@ -1236,8 +1248,10 @@ static void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
     h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->trace_vcpu_dstate);
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
2.13.6
