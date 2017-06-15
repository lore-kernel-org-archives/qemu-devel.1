Received: from eggs.gnu.org ([2001:4830:134:3::10]:48191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLIlp-0004GE-AA
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 20:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLIlk-0005dE-9R
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 20:36:21 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33037)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dLIlk-0005bf-2h
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 20:36:16 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 14 Jun 2017 20:36:13 -0400
Message-Id: <1497486973-25845-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH] tcg: consistently access cpu->tb_jmp_cache
 atomically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Some code paths can lead to atomic accesses racing with memset()
on cpu->tb_jmp_cache, which can result in torn reads/writes
and is undefined behaviour in C11.

These torn accesses are unlikely to show up as bugs, but from code
inspection they seem possible. For example, tb_phys_invalidate does:
    /* remove the TB from the hash list */
    h = tb_jmp_cache_hash_func(tb->pc);
    CPU_FOREACH(cpu) {
        if (atomic_read(&cpu->tb_jmp_cache[h]) == tb) {
            atomic_set(&cpu->tb_jmp_cache[h], NULL);
        }
    }
Here atomic_set might race with a concurrent memset (such as the
ones scheduled via "unsafe" async work, e.g. tlb_flush_page) and
therefore we might end up with a torn pointer (or who knows what,
because we are under undefined behaviour).

This patch converts parallel accesses to cpu->tb_jmp_cache to use
atomic primitives, thereby bringing these accesses back to defined
behaviour. The price to pay is to potentially execute more instructions
when clearing cpu->tb_jmp_cache, but given how infrequently they happen
and the small size of the cache, the performance impact I have measured
is within noise range when booting debian-arm.

Note that under "safe async" work (e.g. do_tb_flush) we could use memset
because no other vcpus are running. However I'm keeping these accesses
atomic as well to keep things simple and to avoid confusing analysis
tools such as ThreadSanitizer.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cputlb.c          |  4 ++--
 include/qom/cpu.h | 11 ++++++++++-
 qom/cpu.c         |  5 +----
 translate-all.c   | 25 ++++++++++++-------------
 4 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index 743776a..e85b6d3 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -118,7 +118,7 @@ static void tlb_flush_nocheck(CPUState *cpu)
 
     memset(env->tlb_table, -1, sizeof(env->tlb_table));
     memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
-    memset(cpu->tb_jmp_cache, 0, sizeof(cpu->tb_jmp_cache));
+    cpu_tb_jmp_cache_clear(cpu);
 
     env->vtlb_index = 0;
     env->tlb_flush_addr = -1;
@@ -183,7 +183,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
         }
     }
 
-    memset(cpu->tb_jmp_cache, 0, sizeof(cpu->tb_jmp_cache));
+    cpu_tb_jmp_cache_clear(cpu);
 
     tlb_debug("done\n");
 
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 89ddb68..2fe7cff 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -346,7 +346,7 @@ struct CPUState {
 
     void *env_ptr; /* CPUArchState */
 
-    /* Writes protected by tb_lock, reads not thread-safe  */
+    /* Accessed in parallel; all accesses must be atomic */
     struct TranslationBlock *tb_jmp_cache[TB_JMP_CACHE_SIZE];
 
     struct GDBRegisterState *gdb_regs;
@@ -422,6 +422,15 @@ extern struct CPUTailQ cpus;
 
 extern __thread CPUState *current_cpu;
 
+static inline void cpu_tb_jmp_cache_clear(CPUState *cpu)
+{
+    unsigned int i;
+
+    for (i = 0; i < TB_JMP_CACHE_SIZE; i++) {
+        atomic_set(&cpu->tb_jmp_cache[i], NULL);
+    }
+}
+
 /**
  * qemu_tcg_mttcg_enabled:
  * Check whether we are running MultiThread TCG or not.
diff --git a/qom/cpu.c b/qom/cpu.c
index 5069876..585419b 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -274,7 +274,6 @@ void cpu_reset(CPUState *cpu)
 static void cpu_common_reset(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
-    int i;
 
     if (qemu_loglevel_mask(CPU_LOG_RESET)) {
         qemu_log("CPU Reset (CPU %d)\n", cpu->cpu_index);
@@ -292,9 +291,7 @@ static void cpu_common_reset(CPUState *cpu)
     cpu->crash_occurred = false;
 
     if (tcg_enabled()) {
-        for (i = 0; i < TB_JMP_CACHE_SIZE; ++i) {
-            atomic_set(&cpu->tb_jmp_cache[i], NULL);
-        }
+        cpu_tb_jmp_cache_clear(cpu);
 
 #ifdef CONFIG_SOFTMMU
         tlb_flush(cpu, 0);
diff --git a/translate-all.c b/translate-all.c
index b3ee876..af3c4df 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -923,11 +923,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     }
 
     CPU_FOREACH(cpu) {
-        int i;
-
-        for (i = 0; i < TB_JMP_CACHE_SIZE; ++i) {
-            atomic_set(&cpu->tb_jmp_cache[i], NULL);
-        }
+        cpu_tb_jmp_cache_clear(cpu);
     }
 
     tcg_ctx.tb_ctx.nb_tbs = 0;
@@ -1806,19 +1802,22 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     cpu_loop_exit_noexc(cpu);
 }
 
-void tb_flush_jmp_cache(CPUState *cpu, target_ulong addr)
+static void tb_jmp_cache_clear_page(CPUState *cpu, target_ulong page_addr)
 {
+    unsigned int i0 = tb_jmp_cache_hash_page(page_addr);
     unsigned int i;
 
+    for (i = 0; i < TB_JMP_PAGE_SIZE; i++) {
+        atomic_set(&cpu->tb_jmp_cache[i0 + i], NULL);
+    }
+}
+
+void tb_flush_jmp_cache(CPUState *cpu, target_ulong addr)
+{
     /* Discard jump cache entries for any tb which might potentially
        overlap the flushed page.  */
-    i = tb_jmp_cache_hash_page(addr - TARGET_PAGE_SIZE);
-    memset(&cpu->tb_jmp_cache[i], 0,
-           TB_JMP_PAGE_SIZE * sizeof(TranslationBlock *));
-
-    i = tb_jmp_cache_hash_page(addr);
-    memset(&cpu->tb_jmp_cache[i], 0,
-           TB_JMP_PAGE_SIZE * sizeof(TranslationBlock *));
+    tb_jmp_cache_clear_page(cpu, addr - TARGET_PAGE_SIZE);
+    tb_jmp_cache_clear_page(cpu, addr);
 }
 
 static void print_qht_statistics(FILE *f, fprintf_function cpu_fprintf,
-- 
2.7.4
