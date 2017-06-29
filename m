Received: from eggs.gnu.org ([2001:4830:134:3::10]:43346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQg4q-0007E2-AL
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQg4n-0000zr-Cv
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:30:12 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51713)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQg4n-0000zH-9H
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:30:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 29 Jun 2017 16:28:29 -0400
Message-Id: <1498768109-4092-8-git-send-email-cota@braap.org>
In-Reply-To: <1498768109-4092-1-git-send-email-cota@braap.org>
References: <1498768109-4092-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [RFC 7/7] [XXX] translate-all: generate TCG code
 without holding tb_lock
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

Generate new TBs without holding tb_lock, which should increase
scalability when running MTTCG for workloads that generate a lot
of code (e.g. booting linux).

XXX: Doesn't work :-) See the commit log from the previous patch.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cpu-exec.c      |  8 +++++++-
 accel/tcg/translate-all.c | 18 ++++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 54ecae2..47f0882 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -351,6 +351,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
              * single threaded the locks are NOPs.
              */
             mmap_lock();
+#ifdef CONFIG_USER_ONLY
             tb_lock();
             have_tb_lock = true;
 
@@ -362,7 +363,12 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
                 /* if no translated code available, then translate it now */
                 tb = tb_gen_code(cpu, pc, cs_base, flags, 0);
             }
-
+#else
+            /* tb_gen_code will acquire tb_lock.
+             * Just for the diff: note that have_tb_lock is local to tb_find! */
+            have_tb_lock = true;
+            tb = tb_gen_code(cpu, pc, cs_base, flags, 0);
+#endif
             mmap_unlock();
         }
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 125b1a8..da29bcc 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -878,8 +878,6 @@ static TranslationBlock *tb_alloc(target_ulong pc)
 {
     TranslationBlock *tb;
 
-    assert_tb_locked();
-
     tb = tcg_tb_alloc(&tcg_ctx);
     if (unlikely(tb == NULL)) {
         return NULL;
@@ -1314,7 +1312,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 #ifdef CONFIG_PROFILER
     int64_t ti;
 #endif
+#ifdef CONFIG_USER_ONLY
     assert_memory_lock();
+#endif
 
     phys_pc = get_page_addr_code(env, pc);
     if (use_icount && !(cflags & CF_IGNORE_ICOUNT)) {
@@ -1429,6 +1429,20 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     if ((pc & TARGET_PAGE_MASK) != virt_page2) {
         phys_page2 = get_page_addr_code(env, virt_page2);
     }
+    if (!have_tb_lock) {
+        TranslationBlock *t;
+
+        tb_lock();
+        /*
+         * There's a chance that our desired tb has been translated while
+         * we were translating it.
+         */
+        t = tb_htable_lookup(cpu, pc, cs_base, flags);
+        if (unlikely(t)) {
+            /* this is very unlikely so just waste the TB space we just used */
+            return t;
+        }
+    }
     /* As long as consistency of the TB stuff is provided by tb_lock in user
      * mode and is implicit in single-threaded softmmu emulation, no explicit
      * memory barrier is required before tb_link_page() makes the TB visible
-- 
2.7.4
