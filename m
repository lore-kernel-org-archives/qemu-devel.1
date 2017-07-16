Received: from eggs.gnu.org ([2001:4830:134:3::10]:46130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmZ-0001Aj-Dj
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmU-0008HG-Qa
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:47 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39909)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmU-0008GA-Jz
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:42 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:03:54 -0400
Message-Id: <1500235468-15341-12-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 11/45] exec-all: bring tb->invalid into
 tb->cflags
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

This gets rid of a hole in struct TranslationBlock.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h   | 3 +--
 accel/tcg/cpu-exec.c      | 2 +-
 accel/tcg/translate-all.c | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 28e3a24..78a1714 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -326,12 +326,11 @@ struct TranslationBlock {
 #define CF_NOCACHE     0x10000 /* To be freed after execution */
 #define CF_USE_ICOUNT  0x20000
 #define CF_IGNORE_ICOUNT 0x40000 /* Do not generate icount code */
+#define CF_INVALID     0x80000 /* Protected by tb_lock */
 
     /* Per-vCPU dynamic tracing state used to generate this TB */
     uint32_t trace_vcpu_dstate;
 
-    uint16_t invalid;
-
     void *tc_ptr;    /* pointer to the translated code */
     uint8_t *tc_search;  /* pointer to search data */
     /* original tb when cflags has CF_NOCACHE */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 9b5ce13..34841cd 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -387,7 +387,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
             tb_lock();
             acquired_tb_lock = true;
         }
-        if (!tb->invalid) {
+        if (!(tb->cflags & CF_INVALID)) {
             tb_add_jump(last_tb, tb_exit, tb);
         }
     }
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 6d4c05f..53fbb06 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1082,7 +1082,7 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
      * Mark the TB as invalid *after* it's been removed from tb_hash, which
      * eliminates the need to check this bit on lookups.
      */
-    tb->invalid = true;
+    tb->cflags |= CF_INVALID;
 
     /* remove the TB from the page list */
     if (tb->page_addr[0] != page_addr) {
@@ -1273,7 +1273,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->flags = flags;
     tb->cflags = cflags;
     tb->trace_vcpu_dstate = *cpu->trace_dstate;
-    tb->invalid = false;
 
 #ifdef CONFIG_PROFILER
     tcg_ctx.tb_count1++; /* includes aborted translations because of
-- 
2.7.4
