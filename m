Received: from eggs.gnu.org ([2001:4830:134:3::10]:52665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AR-0002hw-Mz
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AQ-0003rt-Gd
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:07 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:44288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e49AQ-0003rI-A2
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:06 -0400
Received: by mail-pf0-x236.google.com with SMTP id x7so16318020pfa.1
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:27:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:56 -0700
Message-Id: <20171016172609.23422-38-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 37/50] tcg: Remove CF_IGNORE_ICOUNT
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

Now that we have curr_cflags, we can include CF_USE_ICOUNT
early and then remove it as necessary.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h   | 17 +++++++++--------
 accel/tcg/cpu-exec.c      | 16 +++++++++-------
 accel/tcg/translate-all.c |  3 ---
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index a3bd3e7abd..f14c6a56eb 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -22,6 +22,7 @@
 
 #include "qemu-common.h"
 #include "exec/tb-context.h"
+#include "sysemu/cpus.h"
 
 /* allow to see translation results - the slowdown should be negligible, so we leave it */
 #define DEBUG_DISAS
@@ -319,13 +320,12 @@ struct TranslationBlock {
                            size <= TARGET_PAGE_SIZE) */
     uint16_t icount;
     uint32_t cflags;    /* compile flags */
-#define CF_COUNT_MASK  0x7fff
-#define CF_LAST_IO     0x8000 /* Last insn may be an IO access.  */
-#define CF_NOCACHE     0x10000 /* To be freed after execution */
-#define CF_USE_ICOUNT  0x20000
-#define CF_IGNORE_ICOUNT 0x40000 /* Do not generate icount code */
-#define CF_INVALID     0x80000 /* TB is stale. Setters must acquire tb_lock */
-#define CF_PARALLEL    0x100000 /* Generate code for a parallel context */
+#define CF_COUNT_MASK  0x00007fff
+#define CF_LAST_IO     0x00008000 /* Last insn may be an IO access.  */
+#define CF_NOCACHE     0x00010000 /* To be freed after execution */
+#define CF_USE_ICOUNT  0x00020000
+#define CF_INVALID     0x00040000 /* TB is stale. Setters need tb_lock */
+#define CF_PARALLEL    0x00080000 /* Generate code for a parallel context */
 /* cflags' mask for hashing/comparison */
 #define CF_HASH_MASK   \
     (CF_COUNT_MASK | CF_LAST_IO | CF_USE_ICOUNT | CF_PARALLEL)
@@ -380,7 +380,8 @@ static inline uint32_t tb_cflags(const TranslationBlock *tb)
 /* current cflags for hashing/comparison */
 static inline uint32_t curr_cflags(void)
 {
-    return parallel_cpus ? CF_PARALLEL : 0;
+    return (parallel_cpus ? CF_PARALLEL : 0)
+         | (use_icount ? CF_USE_ICOUNT : 0);
 }
 
 void tb_free(TranslationBlock *tb);
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 0eecbccebc..59fd784436 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -198,17 +198,19 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
                              TranslationBlock *orig_tb, bool ignore_icount)
 {
     TranslationBlock *tb;
+    uint32_t cflags = curr_cflags() | CF_NOCACHE;
+
+    if (ignore_icount) {
+        cflags &= ~CF_USE_ICOUNT;
+    }
 
     /* Should never happen.
        We only end up here when an existing TB is too long.  */
-    if (max_cycles > CF_COUNT_MASK)
-        max_cycles = CF_COUNT_MASK;
+    cflags |= MIN(max_cycles, CF_COUNT_MASK);
 
     tb_lock();
-    tb = tb_gen_code(cpu, orig_tb->pc, orig_tb->cs_base, orig_tb->flags,
-                     max_cycles | CF_NOCACHE
-                         | (ignore_icount ? CF_IGNORE_ICOUNT : 0)
-                         | curr_cflags());
+    tb = tb_gen_code(cpu, orig_tb->pc, orig_tb->cs_base,
+                     orig_tb->flags, cflags);
     tb->orig_tb = orig_tb;
     tb_unlock();
 
@@ -229,7 +231,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
     TranslationBlock *tb;
     target_ulong cs_base, pc;
     uint32_t flags;
-    uint32_t cflags = 1 | CF_IGNORE_ICOUNT;
+    uint32_t cflags = 1;
     uint32_t cf_mask = cflags & CF_HASH_MASK;
 
     if (sigsetjmp(cpu->jmp_env, 0) == 0) {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d3dee985b4..d6b3bc0a38 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1274,9 +1274,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     assert_memory_lock();
 
     phys_pc = get_page_addr_code(env, pc);
-    if (use_icount && !(cflags & CF_IGNORE_ICOUNT)) {
-        cflags |= CF_USE_ICOUNT;
-    }
 
     tb = tb_alloc(pc);
     if (unlikely(!tb)) {
-- 
2.13.6
