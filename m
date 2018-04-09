Received: from eggs.gnu.org ([2001:4830:134:3::10]:36112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1f5Srf-000828-7Q
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1f5Sra-00060I-7A
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:13:27 -0400
Received: from mail.ispras.ru ([83.149.199.45]:36790)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1f5SrZ-0005zR-Lv
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:13:22 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Mon, 09 Apr 2018 12:13:20 +0300
Message-ID: <20180409091320.12504.35329.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] icount: fix cpu_restore_state_from_tb for
 non-tb-exit cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, crosthwaite.peter@gmail.com, kbastian@mail.uni-paderborn.de, green@moxielogic.com, laurent@vivier.eu, jcmvbkbc@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru, edgar.iglesias@gmail.com, pbonzini@redhat.com, shorne@gmail.com, yongbok.kim@mips.com, aurelien@aurel32.net, rth@twiddle.net

In icount mode instructions, that access io memory spaces in the middle
of the translation blocks, invoke TB recompilation.
After recompilation such instructions become last in the TB and are
allowed to access io memory spaces.
When the code includes instruction like i386 'xchg eax, 0xffffd080'
which accesses APIC, QEMU goes into the infinite loop of the recompilation.
This instruction includes two memory accesses - one read and one write.
After first access APIC calls cpu_report_tpr_access, which restores
the CPU state to get the current eip. But cpu_restore_state_from_tb
resets cpu->can_do_io flag and makes second memory access invalid.
Therefore second memory access causes a recompilation of the block.
Then these operations repeat again and again.

This patch moves resetting cpu->can_do_io flag from cpu_restore_state_from_tb
to cpu_loop_exit* functions. It also adds a parameter for cpu_restore_state*()
which controls restoring icount. There is no need in restoring icount,
when we only query CPU state without breaking the TB. Restoring it in such
cases leads to the incorrect flow of the virtual time.

In most cases new parameter is true (icount should be recalculated).
But there are two cases in i386 and openrisc when the CPU state is only
queued without the need to break the TB. This patch fixes both
of these cases.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 accel/tcg/cpu-exec-common.c  |    5 ++++-
 accel/tcg/translate-all.c    |   27 ++++++++++++++-------------
 accel/tcg/user-exec.c        |    2 +-
 hw/misc/mips_itu.c           |    3 +--
 include/exec/exec-all.h      |    5 ++++-
 target/alpha/helper.c        |    2 +-
 target/alpha/mem_helper.c    |    6 ++----
 target/arm/op_helper.c       |    6 +++---
 target/cris/op_helper.c      |    4 ++--
 target/i386/helper.c         |    2 +-
 target/i386/svm_helper.c     |    2 +-
 target/m68k/op_helper.c      |    4 ++--
 target/moxie/helper.c        |    2 +-
 target/openrisc/sys_helper.c |    8 ++++----
 target/tricore/op_helper.c   |    2 +-
 target/xtensa/op_helper.c    |    4 ++--
 16 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index dac5aac..50c4845 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -29,6 +29,7 @@ void cpu_loop_exit_noexc(CPUState *cpu)
 {
     /* XXX: restore cpu registers saved in host registers */
 
+    cpu->can_do_io = !use_icount;
     cpu->exception_index = -1;
     siglongjmp(cpu->jmp_env, 1);
 }
@@ -65,14 +66,16 @@ void cpu_reloading_memory_map(void)
 
 void cpu_loop_exit(CPUState *cpu)
 {
+    cpu->can_do_io = !use_icount;
     siglongjmp(cpu->jmp_env, 1);
 }
 
 void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc)
 {
     if (pc) {
-        cpu_restore_state(cpu, pc);
+        cpu_restore_state(cpu, pc, true);
     }
+    cpu->can_do_io = !use_icount;
     siglongjmp(cpu->jmp_env, 1);
 }
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d419060..f409d42 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -299,9 +299,11 @@ static int encode_search(TranslationBlock *tb, uint8_t *block)
 
 /* The cpu state corresponding to 'searched_pc' is restored.
  * Called with tb_lock held.
+ * When reset_icount is true, current TB will be interrupted and
+ * icount should be recalculated.
  */
 static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
-                                     uintptr_t searched_pc)
+                                     uintptr_t searched_pc, bool reset_icount)
 {
     target_ulong data[TARGET_INSN_START_WORDS] = { tb->pc };
     uintptr_t host_pc = (uintptr_t)tb->tc.ptr;
@@ -333,14 +335,12 @@ static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
     return -1;
 
  found:
-    if (tb->cflags & CF_USE_ICOUNT) {
+    if (reset_icount && (tb->cflags & CF_USE_ICOUNT)) {
         assert(use_icount);
-        /* Reset the cycle counter to the start of the block.  */
-        cpu->icount_decr.u16.low += num_insns;
-        /* Clear the IO flag.  */
-        cpu->can_do_io = 0;
+        /* Reset the cycle counter to the start of the block
+           and shift if to the number of actually executed instructions */
+        cpu->icount_decr.u16.low += num_insns - i;
     }
-    cpu->icount_decr.u16.low -= i;
     restore_state_to_opc(env, tb, data);
 
 #ifdef CONFIG_PROFILER
@@ -351,7 +351,7 @@ static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
     return 0;
 }
 
-bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc)
+bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc, bool will_exit)
 {
     TranslationBlock *tb;
     bool r = false;
@@ -377,7 +377,7 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc)
         tb_lock();
         tb = tb_find_pc(host_pc);
         if (tb) {
-            cpu_restore_state_from_tb(cpu, tb, host_pc);
+            cpu_restore_state_from_tb(cpu, tb, host_pc, will_exit);
             if (tb->cflags & CF_NOCACHE) {
                 /* one-shot translation, invalidate it immediately */
                 tb_phys_invalidate(tb, -1);
@@ -1511,7 +1511,8 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
                 restore the CPU state */
 
                 current_tb_modified = 1;
-                cpu_restore_state_from_tb(cpu, current_tb, cpu->mem_io_pc);
+                cpu_restore_state_from_tb(cpu, current_tb,
+                                          cpu->mem_io_pc, true);
                 cpu_get_tb_cpu_state(env, &current_pc, &current_cs_base,
                                      &current_flags);
             }
@@ -1634,7 +1635,7 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
                    restore the CPU state */
 
             current_tb_modified = 1;
-            cpu_restore_state_from_tb(cpu, current_tb, pc);
+            cpu_restore_state_from_tb(cpu, current_tb, pc, true);
             cpu_get_tb_cpu_state(env, &current_pc, &current_cs_base,
                                  &current_flags);
         }
@@ -1700,7 +1701,7 @@ void tb_check_watchpoint(CPUState *cpu)
     tb = tb_find_pc(cpu->mem_io_pc);
     if (tb) {
         /* We can use retranslation to find the PC.  */
-        cpu_restore_state_from_tb(cpu, tb, cpu->mem_io_pc);
+        cpu_restore_state_from_tb(cpu, tb, cpu->mem_io_pc, true);
         tb_phys_invalidate(tb, -1);
     } else {
         /* The exception probably happened in a helper.  The CPU state should
@@ -1736,7 +1737,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
         cpu_abort(cpu, "cpu_io_recompile: could not find TB for pc=%p",
                   (void *)retaddr);
     }
-    cpu_restore_state_from_tb(cpu, tb, retaddr);
+    cpu_restore_state_from_tb(cpu, tb, retaddr, true);
 
     /* On MIPS and SH, delay slot instructions can only be restarted if
        they were already the first instruction in the TB.  If this is not
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 7789958..26a3ffb 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -168,7 +168,7 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
     }
 
     /* Now we have a real cpu fault.  */
-    cpu_restore_state(cpu, pc);
+    cpu_restore_state(cpu, pc, true);
 
     sigprocmask(SIG_SETMASK, old_set, NULL);
     cpu_loop_exit(cpu);
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index ef935b5..c84a48b 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -174,10 +174,9 @@ static void wake_blocked_threads(ITCStorageCell *c)
 static void QEMU_NORETURN block_thread_and_exit(ITCStorageCell *c)
 {
     c->blocked_threads |= 1ULL << current_cpu->cpu_index;
-    cpu_restore_state(current_cpu, current_cpu->mem_io_pc);
     current_cpu->halted = 1;
     current_cpu->exception_index = EXCP_HLT;
-    cpu_loop_exit(current_cpu);
+    cpu_loop_exit_restore(current_cpu, current_cpu->mem_io_pc);
 }
 
 /* ITC Bypass View */
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index e5afd2e..bd68328 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -50,13 +50,16 @@ void cpu_gen_init(void);
  * cpu_restore_state:
  * @cpu: the vCPU state is to be restore to
  * @searched_pc: the host PC the fault occurred at
+ * @will_exit: true if the TB executed will be interrupted after some
+               cpu adjustments. Required for maintaining the correct
+               icount valus
  * @return: true if state was restored, false otherwise
  *
  * Attempt to restore the state for a fault occurring in translated
  * code. If the searched_pc is not in translated code no state is
  * restored and the function returns false.
  */
-bool cpu_restore_state(CPUState *cpu, uintptr_t searched_pc);
+bool cpu_restore_state(CPUState *cpu, uintptr_t searched_pc, bool will_exit);
 
 void QEMU_NORETURN cpu_loop_exit_noexc(CPUState *cpu);
 void QEMU_NORETURN cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index bbf72ca..8a6a948 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -482,7 +482,7 @@ void QEMU_NORETURN dynamic_excp(CPUAlphaState *env, uintptr_t retaddr,
     cs->exception_index = excp;
     env->error_code = error;
     if (retaddr) {
-        cpu_restore_state(cs, retaddr);
+        cpu_restore_state(cs, retaddr, true);
         /* Floating-point exceptions (our only users) point to the next PC.  */
         env->pc += 4;
     }
diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index e19ab91..011bc73 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -34,7 +34,7 @@ void alpha_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     uint64_t pc;
     uint32_t insn;
 
-    cpu_restore_state(cs, retaddr);
+    cpu_restore_state(cs, retaddr, true);
 
     pc = env->pc;
     insn = cpu_ldl_code(env, pc);
@@ -56,13 +56,11 @@ void alpha_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     AlphaCPU *cpu = ALPHA_CPU(cs);
     CPUAlphaState *env = &cpu->env;
 
-    cpu_restore_state(cs, retaddr);
-
     env->trap_arg0 = addr;
     env->trap_arg1 = access_type == MMU_DATA_STORE ? 1 : 0;
     cs->exception_index = EXCP_MCHK;
     env->error_code = 0;
-    cpu_loop_exit(cs);
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
 /* try to fill the TLB and return an exception if error. If retaddr is
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 7a88fd2..55c6563 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -180,7 +180,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
         ARMCPU *cpu = ARM_CPU(cs);
 
         /* now we have a real cpu fault */
-        cpu_restore_state(cs, retaddr);
+        cpu_restore_state(cs, retaddr, true);
 
         deliver_fault(cpu, addr, access_type, mmu_idx, &fi);
     }
@@ -195,7 +195,7 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     ARMMMUFaultInfo fi = {};
 
     /* now we have a real cpu fault */
-    cpu_restore_state(cs, retaddr);
+    cpu_restore_state(cs, retaddr, true);
 
     fi.type = ARMFault_Alignment;
     deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
@@ -215,7 +215,7 @@ void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     ARMMMUFaultInfo fi = {};
 
     /* now we have a real cpu fault */
-    cpu_restore_state(cs, retaddr);
+    cpu_restore_state(cs, retaddr, true);
 
     fi.ea = arm_extabort_type(response);
     fi.type = ARMFault_SyncExternal;
diff --git a/target/cris/op_helper.c b/target/cris/op_helper.c
index becd831..0ee3a31 100644
--- a/target/cris/op_helper.c
+++ b/target/cris/op_helper.c
@@ -54,8 +54,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
     if (unlikely(ret)) {
         if (retaddr) {
             /* now we have a real cpu fault */
-            if (cpu_restore_state(cs, retaddr)) {
-		/* Evaluate flags after retranslation.  */
+            if (cpu_restore_state(cs, retaddr, true)) {
+                /* Evaluate flags after retranslation. */
                 helper_top_evaluate_flags(env);
             }
         }
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 9fba146..e695f8b 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -991,7 +991,7 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess access)
 
         cpu_interrupt(cs, CPU_INTERRUPT_TPR);
     } else if (tcg_enabled()) {
-        cpu_restore_state(cs, cs->mem_io_pc);
+        cpu_restore_state(cs, cs->mem_io_pc, false);
 
         apic_handle_tpr_access_report(cpu->apic_state, env->eip, access);
     }
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index 3031069..3504923 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -584,7 +584,7 @@ void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
 {
     CPUState *cs = CPU(x86_env_get_cpu(env));
 
-    cpu_restore_state(cs, retaddr);
+    cpu_restore_state(cs, retaddr, true);
 
     qemu_log_mask(CPU_LOG_TB_IN_ASM, "vmexit(%08x, %016" PRIx64 ", %016"
                   PRIx64 ", " TARGET_FMT_lx ")!\n",
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index ffea969..3a7f7f2 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -1056,7 +1056,7 @@ void HELPER(chk)(CPUM68KState *env, int32_t val, int32_t ub)
         CPUState *cs = CPU(m68k_env_get_cpu(env));
 
         /* Recover PC and CC_OP for the beginning of the insn.  */
-        cpu_restore_state(cs, GETPC());
+        cpu_restore_state(cs, GETPC(), true);
 
         /* flags have been modified by gen_flush_flags() */
         env->cc_op = CC_OP_FLAGS;
@@ -1087,7 +1087,7 @@ void HELPER(chk2)(CPUM68KState *env, int32_t val, int32_t lb, int32_t ub)
         CPUState *cs = CPU(m68k_env_get_cpu(env));
 
         /* Recover PC and CC_OP for the beginning of the insn.  */
-        cpu_restore_state(cs, GETPC());
+        cpu_restore_state(cs, GETPC(), true);
 
         /* flags have been modified by gen_flush_flags() */
         env->cc_op = CC_OP_FLAGS;
diff --git a/target/moxie/helper.c b/target/moxie/helper.c
index b8e8656..5b1532b 100644
--- a/target/moxie/helper.c
+++ b/target/moxie/helper.c
@@ -48,7 +48,7 @@ void helper_raise_exception(CPUMoxieState *env, int ex)
     /* Stash the exception type.  */
     env->sregs[2] = ex;
     /* Stash the address where the exception occurred.  */
-    cpu_restore_state(cs, GETPC());
+    cpu_restore_state(cs, GETPC(), true);
     env->sregs[5] = env->pc;
     /* Jump to the exception handline routine.  */
     env->pc = env->sregs[1];
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 9fb7d86..b284064 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -46,7 +46,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
         break;
 
     case TO_SPR(0, 16): /* NPC */
-        cpu_restore_state(cs, GETPC());
+        cpu_restore_state(cs, GETPC(), true);
         /* ??? Mirror or1ksim in not trashing delayed branch state
            when "jumping" to the current instruction.  */
         if (env->pc != rb) {
@@ -146,7 +146,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
     case TO_SPR(8, 0):  /* PMR */
         env->pmr = rb;
         if (env->pmr & PMR_DME || env->pmr & PMR_SME) {
-            cpu_restore_state(cs, GETPC());
+            cpu_restore_state(cs, GETPC(), true);
             env->pc += 4;
             cs->halted = 1;
             raise_exception(cpu, EXCP_HALTED);
@@ -230,14 +230,14 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
         return env->evbar;
 
     case TO_SPR(0, 16): /* NPC (equals PC) */
-        cpu_restore_state(cs, GETPC());
+        cpu_restore_state(cs, GETPC(), false);
         return env->pc;
 
     case TO_SPR(0, 17): /* SR */
         return cpu_get_sr(env);
 
     case TO_SPR(0, 18): /* PPC */
-        cpu_restore_state(cs, GETPC());
+        cpu_restore_state(cs, GETPC(), false);
         return env->ppc;
 
     case TO_SPR(0, 32): /* EPCR */
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 16955f2..b57f353 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -31,7 +31,7 @@ raise_exception_sync_internal(CPUTriCoreState *env, uint32_t class, int tin,
 {
     CPUState *cs = CPU(tricore_env_get_cpu(env));
     /* in case we come from a helper-call we need to restore the PC */
-    cpu_restore_state(cs, pc);
+    cpu_restore_state(cs, pc, true);
 
     /* Tin is loaded into d[15] */
     env->gpr_d[15] = tin;
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index d401105..e3bcbe1 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -52,7 +52,7 @@ void xtensa_cpu_do_unaligned_access(CPUState *cs,
 
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_UNALIGNED_EXCEPTION) &&
             !xtensa_option_enabled(env->config, XTENSA_OPTION_HW_ALIGNMENT)) {
-        cpu_restore_state(CPU(cpu), retaddr);
+        cpu_restore_state(CPU(cpu), retaddr, true);
         HELPER(exception_cause_vaddr)(env,
                 env->pc, LOAD_STORE_ALIGNMENT_CAUSE, addr);
     }
@@ -78,7 +78,7 @@ void tlb_fill(CPUState *cs, target_ulong vaddr, int size,
                      paddr & TARGET_PAGE_MASK,
                      access, mmu_idx, page_size);
     } else {
-        cpu_restore_state(cs, retaddr);
+        cpu_restore_state(cs, retaddr, true);
         HELPER(exception_cause_vaddr)(env, env->pc, ret, vaddr);
     }
 }
