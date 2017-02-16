Received: from eggs.gnu.org ([2001:4830:134:3::10]:51029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceQ11-0007jy-2r
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:38:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceQ0y-0002IB-N3
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:38:47 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 18:38:38 +0100
Message-Id: <1487266718-108184-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487266718-108184-1-git-send-email-pbonzini@redhat.com>
References: <1487266718-108184-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 23/23] target-i386: correctly propagate retaddr
 into SVM helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

Commit 2afbdf8 ("target-i386: exception handling for memory helpers",
2015-09-15) changed tlb_fill's cpu_restore_state+raise_exception_err
to raise_exception_err_ra.  After this change, the cpu_restore_state
and raise_exception_err's cpu_loop_exit are merged into
raise_exception_err_ra's cpu_loop_exit_restore.

This actually fixed some bugs, but when SVM is enabled there is a
second path from raise_exception_err_ra to cpu_loop_exit.  This is
the VMEXIT path, and now cpu_vmexit is called without a
cpu_restore_state before.

The fix is to pass the retaddr to cpu_vmexit (via
cpu_svm_check_intercept_param).  All helpers can now use GETPC() to pass
the correct retaddr, too.

Cc: qemu-stable@nongnu.org
Fixes: 2afbdf84807d673eb682cb78158e11cdacbf4673
Reported-by: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Tested-by: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-exec.c                |  2 +-
 target/i386/cpu.h         |  5 ++--
 target/i386/excp_helper.c | 11 ++++----
 target/i386/helper.h      |  1 -
 target/i386/misc_helper.c | 24 ++++++++---------
 target/i386/seg_helper.c  |  6 ++---
 target/i386/svm_helper.c  | 65 ++++++++++++++++++++++-------------------------
 7 files changed, 56 insertions(+), 58 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index b8ebb5c..142a586 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -491,7 +491,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             X86CPU *x86_cpu = X86_CPU(cpu);
             CPUArchState *env = &x86_cpu->env;
             replay_interrupt();
-            cpu_svm_check_intercept_param(env, SVM_EXIT_INIT, 0);
+            cpu_svm_check_intercept_param(env, SVM_EXIT_INIT, 0, 0);
             do_cpu_init(x86_cpu);
             cpu->exception_index = EXCP_HALTED;
             return true;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4d788d5..8df124f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1621,8 +1621,9 @@ void helper_lock_init(void);
 
 /* svm_helper.c */
 void cpu_svm_check_intercept_param(CPUX86State *env1, uint32_t type,
-                                   uint64_t param);
-void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code, uint64_t exit_info_1);
+                                   uint64_t param, uintptr_t retaddr);
+void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code, uint64_t exit_info_1,
+                uintptr_t retaddr);
 
 /* seg_helper.c */
 void do_interrupt_x86_hardirq(CPUX86State *env, int intno, int is_hw);
diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
index f0dc499..ee596c6 100644
--- a/target/i386/excp_helper.c
+++ b/target/i386/excp_helper.c
@@ -39,7 +39,8 @@ void helper_raise_exception(CPUX86State *env, int exception_index)
  * needed. It should only be called, if this is not an interrupt.
  * Returns the new exception number.
  */
-static int check_exception(CPUX86State *env, int intno, int *error_code)
+static int check_exception(CPUX86State *env, int intno, int *error_code,
+                           uintptr_t retaddr)
 {
     int first_contributory = env->old_exception == 0 ||
                               (env->old_exception >= 10 &&
@@ -53,7 +54,7 @@ static int check_exception(CPUX86State *env, int intno, int *error_code)
 #if !defined(CONFIG_USER_ONLY)
     if (env->old_exception == EXCP08_DBLE) {
         if (env->hflags & HF_SVMI_MASK) {
-            cpu_vmexit(env, SVM_EXIT_SHUTDOWN, 0); /* does not return */
+            cpu_vmexit(env, SVM_EXIT_SHUTDOWN, 0, retaddr); /* does not return */
         }
 
         qemu_log_mask(CPU_LOG_RESET, "Triple fault\n");
@@ -93,10 +94,10 @@ static void QEMU_NORETURN raise_interrupt2(CPUX86State *env, int intno,
 
     if (!is_int) {
         cpu_svm_check_intercept_param(env, SVM_EXIT_EXCP_BASE + intno,
-                                      error_code);
-        intno = check_exception(env, intno, &error_code);
+                                      error_code, retaddr);
+        intno = check_exception(env, intno, &error_code, retaddr);
     } else {
-        cpu_svm_check_intercept_param(env, SVM_EXIT_SWINT, 0);
+        cpu_svm_check_intercept_param(env, SVM_EXIT_SWINT, 0, retaddr);
     }
 
     cs->exception_index = intno;
diff --git a/target/i386/helper.h b/target/i386/helper.h
index 4c1aaff..6fb8fb9 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -99,7 +99,6 @@ DEF_HELPER_2(inl, tl, env, i32)
 DEF_HELPER_FLAGS_4(bpt_io, TCG_CALL_NO_WG, void, env, i32, i32, tl)
 
 DEF_HELPER_3(svm_check_intercept_param, void, env, i32, i64)
-DEF_HELPER_3(vmexit, void, env, i32, i64)
 DEF_HELPER_4(svm_check_io, void, env, i32, i32, i32)
 DEF_HELPER_3(vmrun, void, env, int, int)
 DEF_HELPER_1(vmmcall, void, env)
diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index 5029efe..ca2ea09 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -101,7 +101,7 @@ void helper_cpuid(CPUX86State *env)
 {
     uint32_t eax, ebx, ecx, edx;
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_CPUID, 0);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_CPUID, 0, GETPC());
 
     cpu_x86_cpuid(env, (uint32_t)env->regs[R_EAX], (uint32_t)env->regs[R_ECX],
                   &eax, &ebx, &ecx, &edx);
@@ -125,7 +125,7 @@ target_ulong helper_read_crN(CPUX86State *env, int reg)
 {
     target_ulong val;
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_READ_CR0 + reg, 0);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_READ_CR0 + reg, 0, GETPC());
     switch (reg) {
     default:
         val = env->cr[reg];
@@ -143,7 +143,7 @@ target_ulong helper_read_crN(CPUX86State *env, int reg)
 
 void helper_write_crN(CPUX86State *env, int reg, target_ulong t0)
 {
-    cpu_svm_check_intercept_param(env, SVM_EXIT_WRITE_CR0 + reg, 0);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_WRITE_CR0 + reg, 0, GETPC());
     switch (reg) {
     case 0:
         cpu_x86_update_cr0(env, t0);
@@ -179,7 +179,7 @@ void helper_invlpg(CPUX86State *env, target_ulong addr)
 {
     X86CPU *cpu = x86_env_get_cpu(env);
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_INVLPG, 0);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_INVLPG, 0, GETPC());
     tlb_flush_page(CPU(cpu), addr);
 }
 
@@ -190,7 +190,7 @@ void helper_rdtsc(CPUX86State *env)
     if ((env->cr[4] & CR4_TSD_MASK) && ((env->hflags & HF_CPL_MASK) != 0)) {
         raise_exception_ra(env, EXCP0D_GPF, GETPC());
     }
-    cpu_svm_check_intercept_param(env, SVM_EXIT_RDTSC, 0);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_RDTSC, 0, GETPC());
 
     val = cpu_get_tsc(env) + env->tsc_offset;
     env->regs[R_EAX] = (uint32_t)(val);
@@ -208,7 +208,7 @@ void helper_rdpmc(CPUX86State *env)
     if ((env->cr[4] & CR4_PCE_MASK) && ((env->hflags & HF_CPL_MASK) != 0)) {
         raise_exception_ra(env, EXCP0D_GPF, GETPC());
     }
-    cpu_svm_check_intercept_param(env, SVM_EXIT_RDPMC, 0);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_RDPMC, 0, GETPC());
 
     /* currently unimplemented */
     qemu_log_mask(LOG_UNIMP, "x86: unimplemented rdpmc\n");
@@ -228,7 +228,7 @@ void helper_wrmsr(CPUX86State *env)
 {
     uint64_t val;
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 1);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 1, GETPC());
 
     val = ((uint32_t)env->regs[R_EAX]) |
         ((uint64_t)((uint32_t)env->regs[R_EDX]) << 32);
@@ -388,7 +388,7 @@ void helper_rdmsr(CPUX86State *env)
 {
     uint64_t val;
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 0);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 0, GETPC());
 
     switch ((uint32_t)env->regs[R_ECX]) {
     case MSR_IA32_SYSENTER_CS:
@@ -557,7 +557,7 @@ void helper_hlt(CPUX86State *env, int next_eip_addend)
 {
     X86CPU *cpu = x86_env_get_cpu(env);
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_HLT, 0);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_HLT, 0, GETPC());
     env->eip += next_eip_addend;
 
     do_hlt(cpu);
@@ -569,7 +569,7 @@ void helper_monitor(CPUX86State *env, target_ulong ptr)
         raise_exception_ra(env, EXCP0D_GPF, GETPC());
     }
     /* XXX: store address? */
-    cpu_svm_check_intercept_param(env, SVM_EXIT_MONITOR, 0);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_MONITOR, 0, GETPC());
 }
 
 void helper_mwait(CPUX86State *env, int next_eip_addend)
@@ -580,7 +580,7 @@ void helper_mwait(CPUX86State *env, int next_eip_addend)
     if ((uint32_t)env->regs[R_ECX] != 0) {
         raise_exception_ra(env, EXCP0D_GPF, GETPC());
     }
-    cpu_svm_check_intercept_param(env, SVM_EXIT_MWAIT, 0);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_MWAIT, 0, GETPC());
     env->eip += next_eip_addend;
 
     cpu = x86_env_get_cpu(env);
@@ -597,7 +597,7 @@ void helper_pause(CPUX86State *env, int next_eip_addend)
 {
     X86CPU *cpu = x86_env_get_cpu(env);
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_PAUSE, 0);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_PAUSE, 0, GETPC());
     env->eip += next_eip_addend;
 
     do_pause(cpu);
diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index d24574d..5c845dc 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -1335,7 +1335,7 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     } else if (env->hflags2 & HF2_GIF_MASK) {
         if ((interrupt_request & CPU_INTERRUPT_SMI) &&
             !(env->hflags & HF_SMM_MASK)) {
-            cpu_svm_check_intercept_param(env, SVM_EXIT_SMI, 0);
+            cpu_svm_check_intercept_param(env, SVM_EXIT_SMI, 0, 0);
             cs->interrupt_request &= ~CPU_INTERRUPT_SMI;
             do_smm_enter(cpu);
             ret = true;
@@ -1356,7 +1356,7 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
                      (env->eflags & IF_MASK &&
                       !(env->hflags & HF_INHIBIT_IRQ_MASK))))) {
             int intno;
-            cpu_svm_check_intercept_param(env, SVM_EXIT_INTR, 0);
+            cpu_svm_check_intercept_param(env, SVM_EXIT_INTR, 0, 0);
             cs->interrupt_request &= ~(CPU_INTERRUPT_HARD |
                                        CPU_INTERRUPT_VIRQ);
             intno = cpu_get_pic_interrupt(env);
@@ -1372,7 +1372,7 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
                    !(env->hflags & HF_INHIBIT_IRQ_MASK)) {
             int intno;
             /* FIXME: this should respect TPR */
-            cpu_svm_check_intercept_param(env, SVM_EXIT_VINTR, 0);
+            cpu_svm_check_intercept_param(env, SVM_EXIT_VINTR, 0, 0);
             intno = x86_ldl_phys(cs, env->vm_vmcb
                              + offsetof(struct vmcb, control.int_vector));
             qemu_log_mask(CPU_LOG_TB_IN_ASM,
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index 210f6aa..78d8df4 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -60,11 +60,8 @@ void helper_invlpga(CPUX86State *env, int aflag)
 {
 }
 
-void helper_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1)
-{
-}
-
-void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code, uint64_t exit_info_1)
+void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code, uint64_t exit_info_1,
+                uintptr_t retaddr)
 {
 }
 
@@ -74,7 +71,7 @@ void helper_svm_check_intercept_param(CPUX86State *env, uint32_t type,
 }
 
 void cpu_svm_check_intercept_param(CPUX86State *env, uint32_t type,
-                                   uint64_t param)
+                                   uint64_t param, uintptr_t retaddr)
 {
 }
 
@@ -130,7 +127,7 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
     uint32_t event_inj;
     uint32_t int_ctl;
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_VMRUN, 0);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_VMRUN, 0, GETPC());
 
     if (aflag == 2) {
         addr = env->regs[R_EAX];
@@ -355,7 +352,7 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
 
 void helper_vmmcall(CPUX86State *env)
 {
-    cpu_svm_check_intercept_param(env, SVM_EXIT_VMMCALL, 0);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_VMMCALL, 0, GETPC());
     raise_exception(env, EXCP06_ILLOP);
 }
 
@@ -364,7 +361,7 @@ void helper_vmload(CPUX86State *env, int aflag)
     CPUState *cs = CPU(x86_env_get_cpu(env));
     target_ulong addr;
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_VMLOAD, 0);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_VMLOAD, 0, GETPC());
 
     if (aflag == 2) {
         addr = env->regs[R_EAX];
@@ -404,7 +401,7 @@ void helper_vmsave(CPUX86State *env, int aflag)
     CPUState *cs = CPU(x86_env_get_cpu(env));
     target_ulong addr;
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_VMSAVE, 0);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_VMSAVE, 0, GETPC());
 
     if (aflag == 2) {
         addr = env->regs[R_EAX];
@@ -445,19 +442,19 @@ void helper_vmsave(CPUX86State *env, int aflag)
 
 void helper_stgi(CPUX86State *env)
 {
-    cpu_svm_check_intercept_param(env, SVM_EXIT_STGI, 0);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_STGI, 0, GETPC());
     env->hflags2 |= HF2_GIF_MASK;
 }
 
 void helper_clgi(CPUX86State *env)
 {
-    cpu_svm_check_intercept_param(env, SVM_EXIT_CLGI, 0);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_CLGI, 0, GETPC());
     env->hflags2 &= ~HF2_GIF_MASK;
 }
 
 void helper_skinit(CPUX86State *env)
 {
-    cpu_svm_check_intercept_param(env, SVM_EXIT_SKINIT, 0);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_SKINIT, 0, GETPC());
     /* XXX: not implemented */
     raise_exception(env, EXCP06_ILLOP);
 }
@@ -467,7 +464,7 @@ void helper_invlpga(CPUX86State *env, int aflag)
     X86CPU *cpu = x86_env_get_cpu(env);
     target_ulong addr;
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_INVLPGA, 0);
+    cpu_svm_check_intercept_param(env, SVM_EXIT_INVLPGA, 0, GETPC());
 
     if (aflag == 2) {
         addr = env->regs[R_EAX];
@@ -480,8 +477,8 @@ void helper_invlpga(CPUX86State *env, int aflag)
     tlb_flush_page(CPU(cpu), addr);
 }
 
-void helper_svm_check_intercept_param(CPUX86State *env, uint32_t type,
-                                      uint64_t param)
+void cpu_svm_check_intercept_param(CPUX86State *env, uint32_t type,
+                                   uint64_t param, uintptr_t retaddr)
 {
     CPUState *cs = CPU(x86_env_get_cpu(env));
 
@@ -491,27 +488,27 @@ void helper_svm_check_intercept_param(CPUX86State *env, uint32_t type,
     switch (type) {
     case SVM_EXIT_READ_CR0 ... SVM_EXIT_READ_CR0 + 8:
         if (env->intercept_cr_read & (1 << (type - SVM_EXIT_READ_CR0))) {
-            helper_vmexit(env, type, param);
+            cpu_vmexit(env, type, param, retaddr);
         }
         break;
     case SVM_EXIT_WRITE_CR0 ... SVM_EXIT_WRITE_CR0 + 8:
         if (env->intercept_cr_write & (1 << (type - SVM_EXIT_WRITE_CR0))) {
-            helper_vmexit(env, type, param);
+            cpu_vmexit(env, type, param, retaddr);
         }
         break;
     case SVM_EXIT_READ_DR0 ... SVM_EXIT_READ_DR0 + 7:
         if (env->intercept_dr_read & (1 << (type - SVM_EXIT_READ_DR0))) {
-            helper_vmexit(env, type, param);
+            cpu_vmexit(env, type, param, retaddr);
         }
         break;
     case SVM_EXIT_WRITE_DR0 ... SVM_EXIT_WRITE_DR0 + 7:
         if (env->intercept_dr_write & (1 << (type - SVM_EXIT_WRITE_DR0))) {
-            helper_vmexit(env, type, param);
+            cpu_vmexit(env, type, param, retaddr);
         }
         break;
     case SVM_EXIT_EXCP_BASE ... SVM_EXIT_EXCP_BASE + 31:
         if (env->intercept_exceptions & (1 << (type - SVM_EXIT_EXCP_BASE))) {
-            helper_vmexit(env, type, param);
+            cpu_vmexit(env, type, param, retaddr);
         }
         break;
     case SVM_EXIT_MSR:
@@ -538,28 +535,28 @@ void helper_svm_check_intercept_param(CPUX86State *env, uint32_t type,
                 t0 %= 8;
                 break;
             default:
-                helper_vmexit(env, type, param);
+                cpu_vmexit(env, type, param, retaddr);
                 t0 = 0;
                 t1 = 0;
                 break;
             }
             if (x86_ldub_phys(cs, addr + t1) & ((1 << param) << t0)) {
-                helper_vmexit(env, type, param);
+                cpu_vmexit(env, type, param, retaddr);
             }
         }
         break;
     default:
         if (env->intercept & (1ULL << (type - SVM_EXIT_INTR))) {
-            helper_vmexit(env, type, param);
+            cpu_vmexit(env, type, param, retaddr);
         }
         break;
     }
 }
 
-void cpu_svm_check_intercept_param(CPUX86State *env, uint32_t type,
-                                   uint64_t param)
+void helper_svm_check_intercept_param(CPUX86State *env, uint32_t type,
+                                      uint64_t param)
 {
-    helper_svm_check_intercept_param(env, type, param);
+    cpu_svm_check_intercept_param(env, type, param, GETPC());
 }
 
 void helper_svm_check_io(CPUX86State *env, uint32_t port, uint32_t param,
@@ -578,17 +575,22 @@ void helper_svm_check_io(CPUX86State *env, uint32_t port, uint32_t param,
             x86_stq_phys(cs,
                      env->vm_vmcb + offsetof(struct vmcb, control.exit_info_2),
                      env->eip + next_eip_addend);
-            helper_vmexit(env, SVM_EXIT_IOIO, param | (port << 16));
+            cpu_vmexit(env, SVM_EXIT_IOIO, param | (port << 16), GETPC());
         }
     }
 }
 
 /* Note: currently only 32 bits of exit_code are used */
-void helper_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1)
+void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
+                uintptr_t retaddr)
 {
     CPUState *cs = CPU(x86_env_get_cpu(env));
     uint32_t int_ctl;
 
+    if (retaddr) {
+        cpu_restore_state(cs, retaddr);
+    }
+
     qemu_log_mask(CPU_LOG_TB_IN_ASM, "vmexit(%08x, %016" PRIx64 ", %016"
                   PRIx64 ", " TARGET_FMT_lx ")!\n",
                   exit_code, exit_info_1,
@@ -766,9 +768,4 @@ void helper_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1)
     cpu_loop_exit(cs);
 }
 
-void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1)
-{
-    helper_vmexit(env, exit_code, exit_info_1);
-}
-
 #endif
-- 
1.8.3.1
