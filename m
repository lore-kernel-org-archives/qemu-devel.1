Received: from eggs.gnu.org ([2001:4830:134:3::10]:45675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6c-0008NS-Gu
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6a-0008Jr-Sa
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:10 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:54075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6a-0008Ik-J8
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:08 -0400
Received: by mail-wr0-x243.google.com with SMTP id u40so17445468wrf.10
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:07 +0200
Message-Id: <20171025093535.10175-24-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 23/51] tcg: Add CPUState cflags_next_tb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

We were generating code during tb_invalidate_phys_page_range,
check_watchpoint, cpu_io_recompile, and (seemingly) discarding
the TB, assuming that it would magically be picked up during
the next iteration through the cpu_exec loop.

Instead, record the desired cflags in CPUState so that we request
the proper TB so that there is no more magic.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qom/cpu.h         |  1 +
 accel/tcg/cpu-exec.c      | 21 +++++++++++++++++----
 accel/tcg/translate-all.c | 36 ++++++++++--------------------------
 exec.c                    |  7 ++-----
 qom/cpu.c                 |  1 +
 5 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index df0ba86202..fa4b0c9dba 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -344,6 +344,7 @@ struct CPUState {
     bool unplug;
     bool crash_occurred;
     bool exit_request;
+    uint32_t cflags_next_tb;
     /* updates protected by BQL */
     uint32_t interrupt_request;
     int singlestep_enabled;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 39ec9508d1..1c64977849 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -367,13 +367,12 @@ static inline void tb_add_jump(TranslationBlock *tb, int n,
 
 static inline TranslationBlock *tb_find(CPUState *cpu,
                                         TranslationBlock *last_tb,
-                                        int tb_exit)
+                                        int tb_exit, uint32_t cf_mask)
 {
     TranslationBlock *tb;
     target_ulong cs_base, pc;
     uint32_t flags;
     bool acquired_tb_lock = false;
-    uint32_t cf_mask = curr_cflags();
 
     tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, cf_mask);
     if (tb == NULL) {
@@ -501,7 +500,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     } else if (replay_has_exception()
                && cpu->icount_decr.u16.low + cpu->icount_extra == 0) {
         /* try to cause an exception pending in the log */
-        cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0), true);
+        cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0, curr_cflags()), true);
         *ret = -1;
         return true;
 #endif
@@ -697,7 +696,21 @@ int cpu_exec(CPUState *cpu)
         int tb_exit = 0;
 
         while (!cpu_handle_interrupt(cpu, &last_tb)) {
-            TranslationBlock *tb = tb_find(cpu, last_tb, tb_exit);
+            uint32_t cflags = cpu->cflags_next_tb;
+            TranslationBlock *tb;
+
+            /* When requested, use an exact setting for cflags for the next
+               execution.  This is used for icount, precise smc, and stop-
+               after-access watchpoints.  Since this request should never
+               have CF_INVALID set, -1 is a convenient invalid value that
+               does not require tcg headers for cpu_common_reset.  */
+            if (cflags == -1) {
+                cflags = curr_cflags();
+            } else {
+                cpu->cflags_next_tb = -1;
+            }
+
+            tb = tb_find(cpu, last_tb, tb_exit, cflags);
             cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit);
             /* Try to align the host and virtual clocks
                if the guest is in advance */
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 7ad65bc705..91fd6e444b 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1463,14 +1463,12 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
                                    int is_cpu_write_access)
 {
     TranslationBlock *tb, *tb_next;
-#if defined(TARGET_HAS_PRECISE_SMC)
-    CPUState *cpu = current_cpu;
-    CPUArchState *env = NULL;
-#endif
     tb_page_addr_t tb_start, tb_end;
     PageDesc *p;
     int n;
 #ifdef TARGET_HAS_PRECISE_SMC
+    CPUState *cpu = current_cpu;
+    CPUArchState *env = NULL;
     int current_tb_not_found = is_cpu_write_access;
     TranslationBlock *current_tb = NULL;
     int current_tb_modified = 0;
@@ -1547,11 +1545,8 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
 #endif
 #ifdef TARGET_HAS_PRECISE_SMC
     if (current_tb_modified) {
-        /* we generate a block containing just the instruction
-           modifying the memory. It will ensure that it cannot modify
-           itself */
-        tb_gen_code(cpu, current_pc, current_cs_base, current_flags,
-                    1 | curr_cflags());
+        /* Force execution of one insn next time.  */
+        cpu->cflags_next_tb = 1 | curr_cflags();
         cpu_loop_exit_noexc(cpu);
     }
 #endif
@@ -1666,11 +1661,8 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
     p->first_tb = NULL;
 #ifdef TARGET_HAS_PRECISE_SMC
     if (current_tb_modified) {
-        /* we generate a block containing just the instruction
-           modifying the memory. It will ensure that it cannot modify
-           itself */
-        tb_gen_code(cpu, current_pc, current_cs_base, current_flags,
-                    1 | curr_cflags());
+        /* Force execution of one insn next time.  */
+        cpu->cflags_next_tb = 1 | curr_cflags();
         /* tb_lock will be reset after cpu_loop_exit_noexc longjmps
          * back into the cpu_exec loop. */
         return true;
@@ -1773,9 +1765,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     CPUArchState *env = cpu->env_ptr;
 #endif
     TranslationBlock *tb;
-    uint32_t n, cflags;
-    target_ulong pc, cs_base;
-    uint32_t flags;
+    uint32_t n;
 
     tb_lock();
     tb = tb_find_pc(retaddr);
@@ -1813,12 +1803,9 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
         cpu_abort(cpu, "TB too big during recompile");
     }
 
-    cflags = n | CF_LAST_IO;
-    cflags |= curr_cflags();
-    pc = tb->pc;
-    cs_base = tb->cs_base;
-    flags = tb->flags;
-    tb_phys_invalidate(tb, -1);
+    /* Adjust the execution state of the next TB.  */
+    cpu->cflags_next_tb = curr_cflags() | CF_LAST_IO | n;
+
     if (tb->cflags & CF_NOCACHE) {
         if (tb->orig_tb) {
             /* Invalidate original TB if this TB was generated in
@@ -1827,9 +1814,6 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
         }
         tb_free(tb);
     }
-    /* FIXME: In theory this could raise an exception.  In practice
-       we have already translated the block once so it's probably ok.  */
-    tb_gen_code(cpu, pc, cs_base, flags, cflags);
 
     /* TODO: If env->pc != tb->pc (i.e. the faulting instruction was not
      * the first in the TB) then we end up generating a whole new TB and
diff --git a/exec.c b/exec.c
index 3e0a3dae46..97a24a875e 100644
--- a/exec.c
+++ b/exec.c
@@ -2431,11 +2431,8 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
 {
     CPUState *cpu = current_cpu;
     CPUClass *cc = CPU_GET_CLASS(cpu);
-    CPUArchState *env = cpu->env_ptr;
-    target_ulong pc, cs_base;
     target_ulong vaddr;
     CPUWatchpoint *wp;
-    uint32_t cpu_flags;
 
     assert(tcg_enabled());
     if (cpu->watchpoint_hit) {
@@ -2475,8 +2472,8 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
                     cpu->exception_index = EXCP_DEBUG;
                     cpu_loop_exit(cpu);
                 } else {
-                    cpu_get_tb_cpu_state(env, &pc, &cs_base, &cpu_flags);
-                    tb_gen_code(cpu, pc, cs_base, cpu_flags, 1 | curr_cflags());
+                    /* Force execution of one insn next time.  */
+                    cpu->cflags_next_tb = 1 | curr_cflags();
                     cpu_loop_exit_noexc(cpu);
                 }
             }
diff --git a/qom/cpu.c b/qom/cpu.c
index 54c9452b1c..e42d9a7f9e 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -301,6 +301,7 @@ static void cpu_common_reset(CPUState *cpu)
     cpu->can_do_io = 1;
     cpu->exception_index = -1;
     cpu->crash_occurred = false;
+    cpu->cflags_next_tb = -1;
 
     if (tcg_enabled()) {
         cpu_tb_jmp_cache_clear(cpu);
-- 
2.13.6
