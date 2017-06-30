Received: from eggs.gnu.org ([2001:4830:134:3::10]:48393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dR1I1-0006V5-A9
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dR1I0-00037u-1r
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:09:13 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dR1Hz-00037c-TL
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:09:11 -0400
Received: by mail-qt0-x241.google.com with SMTP id m54so13667206qtb.1
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 12:09:11 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 30 Jun 2017 12:09:03 -0700
Message-Id: <20170630190903.9886-4-rth@twiddle.net>
In-Reply-To: <20170630190903.9886-1-rth@twiddle.net>
References: <20170630190903.9886-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 3/3] tcg: consistently access cpu->tb_jmp_cache
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
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

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

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1497486973-25845-1-git-send-email-cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/qom/cpu.h         | 11 ++++++++++-
 accel/tcg/cputlb.c        |  4 ++--
 accel/tcg/translate-all.c | 26 ++++++++++++--------------
 qom/cpu.c                 |  5 +----
 4 files changed, 25 insertions(+), 21 deletions(-)

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
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 1900936..85635ae 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
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
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f6ad46b..93fb923 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -928,11 +928,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
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
@@ -1813,19 +1809,21 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     cpu_loop_exit_noexc(cpu);
 }
 
-void tb_flush_jmp_cache(CPUState *cpu, target_ulong addr)
+static void tb_jmp_cache_clear_page(CPUState *cpu, target_ulong page_addr)
 {
-    unsigned int i;
+    unsigned int i, i0 = tb_jmp_cache_hash_page(page_addr);
 
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
-- 
2.9.4
