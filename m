Received: from eggs.gnu.org ([2001:4830:134:3::10]:52456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AA-0002OE-C6
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49A9-0003da-3t
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:50 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:54267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e49A8-0003d7-Sl
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:49 -0400
Received: by mail-pf0-x22c.google.com with SMTP id t188so13794023pfd.10
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:26:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:43 -0700
Message-Id: <20171016172609.23422-25-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 24/50] tcg: Add CPUState step_next_tb
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

We were generating code during tb_invalidate_phys_page_range and
check_watchpoint, and (seemingly) discarding the TB, assuming that
it would magically be picked up during the next iteration through
the cpu_exec loop.

Instead, set a flag in CPUState so that we set cflags to properly
request a TB with a single guest insn so that there is no more magic.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qom/cpu.h         |  1 +
 accel/tcg/cpu-exec.c      | 19 +++++++++++++++----
 accel/tcg/translate-all.c | 18 ++++--------------
 exec.c                    |  6 +-----
 4 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index df0ba86202..1fb165a43c 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -344,6 +344,7 @@ struct CPUState {
     bool unplug;
     bool crash_occurred;
     bool exit_request;
+    bool step_next_tb;
     /* updates protected by BQL */
     uint32_t interrupt_request;
     int singlestep_enabled;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 99f1d519c5..df410a8d6e 100644
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
@@ -697,7 +696,19 @@ int cpu_exec(CPUState *cpu)
         int tb_exit = 0;
 
         while (!cpu_handle_interrupt(cpu, &last_tb)) {
-            TranslationBlock *tb = tb_find(cpu, last_tb, tb_exit);
+            uint32_t cf_mask = curr_cflags();
+            TranslationBlock *tb;
+
+            /* For precise smc, we generate a block containing just the
+               instruction modifying the memory, ensuring that it cannot
+               modify itself.  We also need to single-step past a
+               stop-after-access watchpoint.  */
+            if (cpu->step_next_tb) {
+                cf_mask |= 1;
+                cpu->step_next_tb = false;
+            }
+
+            tb = tb_find(cpu, last_tb, tb_exit, cf_mask);
             cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit);
             /* Try to align the host and virtual clocks
                if the guest is in advance */
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 1271944ae8..a7415c8661 100644
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
@@ -1547,11 +1545,7 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
 #endif
 #ifdef TARGET_HAS_PRECISE_SMC
     if (current_tb_modified) {
-        /* we generate a block containing just the instruction
-           modifying the memory. It will ensure that it cannot modify
-           itself */
-        tb_gen_code(cpu, current_pc, current_cs_base, current_flags,
-                    1 | curr_cflags());
+        cpu->step_next_tb = true;
         cpu_loop_exit_noexc(cpu);
     }
 #endif
@@ -1666,11 +1660,7 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
     p->first_tb = NULL;
 #ifdef TARGET_HAS_PRECISE_SMC
     if (current_tb_modified) {
-        /* we generate a block containing just the instruction
-           modifying the memory. It will ensure that it cannot modify
-           itself */
-        tb_gen_code(cpu, current_pc, current_cs_base, current_flags,
-                    1 | curr_cflags());
+        cpu->step_next_tb = true;
         /* tb_lock will be reset after cpu_loop_exit_noexc longjmps
          * back into the cpu_exec loop. */
         return true;
diff --git a/exec.c b/exec.c
index 5d43d9541f..a9737ba5e9 100644
--- a/exec.c
+++ b/exec.c
@@ -2390,11 +2390,8 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
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
@@ -2434,8 +2431,7 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
                     cpu->exception_index = EXCP_DEBUG;
                     cpu_loop_exit(cpu);
                 } else {
-                    cpu_get_tb_cpu_state(env, &pc, &cs_base, &cpu_flags);
-                    tb_gen_code(cpu, pc, cs_base, cpu_flags, 1 | curr_cflags());
+                    cpu->step_next_tb = true;
                     cpu_loop_exit_noexc(cpu);
                 }
             }
-- 
2.13.6
