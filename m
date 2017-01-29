Received: from eggs.gnu.org ([2001:4830:134:3::10]:46901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cXwis-00080R-84
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cXwin-0002Az-Bp
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:18 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 29 Jan 2017 22:09:04 +0100
Message-Id: <20170129210910.6333-2-pbonzini@redhat.com>
In-Reply-To: <20170129210910.6333-1-pbonzini@redhat.com>
References: <20170129210910.6333-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/7] cpu-exec: fix jmp_first out-of-bounds
 access with icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: serge.fdrv@gmail.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru, qemu-stable@nongnu.org

When icount is active, tb_add_jump is surprisingly called with an out of
bounds basic block index.  I have no idea how that can work (it overwrites
jmp_first so at least it doesn't cause an immediate segv), but it does
not seem like a good idea.  Clear *last_tb for all TB_EXIT_ICOUNT_EXPIRED
cases, even when all you have to do is refill icount_extra.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-exec.c              | 7 ++++---
 include/exec/exec-all.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index fa08c73..2dc10c1 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -542,7 +542,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
 
     trace_exec_tb(tb, tb->pc);
     ret = cpu_tb_exec(cpu, tb);
-    *last_tb = (TranslationBlock *)(ret & ~TB_EXIT_MASK);
+    tb = (TranslationBlock *)(ret & ~TB_EXIT_MASK);
     *tb_exit = ret & TB_EXIT_MASK;
     switch (*tb_exit) {
     case TB_EXIT_REQUESTED:
@@ -566,6 +566,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
         abort();
 #else
         int insns_left = cpu->icount_decr.u32;
+        *last_tb = NULL;
         if (cpu->icount_extra && insns_left >= 0) {
             /* Refill decrementer and continue execution.  */
             cpu->icount_extra += insns_left;
@@ -575,17 +576,17 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
         } else {
             if (insns_left > 0) {
                 /* Execute remaining instructions.  */
-                cpu_exec_nocache(cpu, insns_left, *last_tb, false);
+                cpu_exec_nocache(cpu, insns_left, tb, false);
                 align_clocks(sc, cpu);
             }
             cpu->exception_index = EXCP_INTERRUPT;
-            *last_tb = NULL;
             cpu_loop_exit(cpu);
         }
         break;
 #endif
     }
     default:
+        *last_tb = tb;
         break;
     }
 }
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index bbc9478..21ab7bf 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -318,6 +318,7 @@ static inline void tb_set_jmp_target(TranslationBlock *tb,
 static inline void tb_add_jump(TranslationBlock *tb, int n,
                                TranslationBlock *tb_next)
 {
+    assert(n < ARRAY_SIZE(tb->jmp_list_next));
     if (tb->jmp_list_next[n]) {
         /* Another thread has already done this while we were
          * outside of the lock; nothing to do in this case */
-- 
2.9.3
