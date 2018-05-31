Received: from eggs.gnu.org ([2001:4830:134:3::10]:35040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOF2k-0007CT-HJ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 00:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOF2i-0004Ca-Lc
	for qemu-devel@nongnu.org; Thu, 31 May 2018 00:18:30 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:43160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOF2i-0004C2-C8
	for qemu-devel@nongnu.org; Thu, 31 May 2018 00:18:28 -0400
Received: by mail-pf0-x244.google.com with SMTP id j20-v6so10096316pff.10
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 21:18:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 30 May 2018 21:18:21 -0700
Message-Id: <20180531041822.5761-2-richard.henderson@linaro.org>
In-Reply-To: <20180531041822.5761-1-richard.henderson@linaro.org>
References: <20180531041822.5761-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] linux-user: Implement signals for openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, shorne@gmail.com

All of the existing code was boilerplate from elsewhere,
and would crash the guest upon the first signal.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/openrisc/target_syscall.h |  23 +--
 linux-user/openrisc/signal.c         | 210 +++++++++++----------------
 linux-user/signal.c                  |   2 +-
 target/openrisc/cpu.c                |   1 +
 4 files changed, 87 insertions(+), 149 deletions(-)

diff --git a/linux-user/openrisc/target_syscall.h b/linux-user/openrisc/target_syscall.h
index 03104f80af..f21fab3192 100644
--- a/linux-user/openrisc/target_syscall.h
+++ b/linux-user/openrisc/target_syscall.h
@@ -2,26 +2,9 @@
 #define OPENRISC_TARGET_SYSCALL_H
 
 struct target_pt_regs {
-    union {
-        struct {
-            /* Named registers */
-            uint32_t sr;       /* Stored in place of r0 */
-            target_ulong sp;   /* r1 */
-        };
-        struct {
-            /* Old style */
-            target_ulong offset[2];
-            target_ulong gprs[30];
-        };
-        struct {
-            /* New style */
-            target_ulong gpr[32];
-        };
-    };
-    target_ulong pc;
-    target_ulong orig_gpr11;   /* For restarting system calls */
-    uint32_t syscallno;        /* Syscall number (used by strace) */
-    target_ulong dummy;     /* Cheap alignment fix */
+    abi_ulong gpr[32];
+    abi_ulong pc;
+    abi_ulong sr;
 };
 
 #define UNAME_MACHINE "openrisc"
diff --git a/linux-user/openrisc/signal.c b/linux-user/openrisc/signal.c
index ecf2897ccd..387fa63174 100644
--- a/linux-user/openrisc/signal.c
+++ b/linux-user/openrisc/signal.c
@@ -22,125 +22,79 @@
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
-struct target_sigcontext {
+typedef struct target_sigcontext {
     struct target_pt_regs regs;
     abi_ulong oldmask;
-    abi_ulong usp;
-};
+} target_sigcontext;
 
-struct target_ucontext {
+typedef struct target_ucontext {
     abi_ulong tuc_flags;
     abi_ulong tuc_link;
     target_stack_t tuc_stack;
-    struct target_sigcontext tuc_mcontext;
+    target_sigcontext tuc_mcontext;
     target_sigset_t tuc_sigmask;   /* mask last for extensibility */
-};
+} target_ucontext;
 
-struct target_rt_sigframe {
-    abi_ulong pinfo;
-    uint64_t puc;
+typedef struct target_rt_sigframe {
     struct target_siginfo info;
-    struct target_sigcontext sc;
-    struct target_ucontext uc;
-    unsigned char retcode[16];  /* trampoline code */
-};
+    target_ucontext uc;
+    uint32_t retcode[4];  /* trampoline code */
+} target_rt_sigframe;
 
-/* This is the asm-generic/ucontext.h version */
-#if 0
-static int restore_sigcontext(CPUOpenRISCState *regs,
-                              struct target_sigcontext *sc)
+static void restore_sigcontext(CPUOpenRISCState *env, target_sigcontext *sc)
 {
-    unsigned int err = 0;
-    unsigned long old_usp;
+    int i;
+    abi_ulong v;
 
-    /* Alwys make any pending restarted system call return -EINTR */
-    current_thread_info()->restart_block.fn = do_no_restart_syscall;
-
-    /* restore the regs from &sc->regs (same as sc, since regs is first)
-     * (sc is already checked for VERIFY_READ since the sigframe was
-     *  checked in sys_sigreturn previously)
-     */
-
-    if (copy_from_user(regs, &sc, sizeof(struct target_pt_regs))) {
-        goto badframe;
+    for (i = 0; i < 32; ++i) {
+        __get_user(v, &sc->regs.gpr[i]);
+        cpu_set_gpr(env, i, v);
     }
+    __get_user(env->pc, &sc->regs.pc);
 
-    /* make sure the U-flag is set so user-mode cannot fool us */
-
-    regs->sr &= ~SR_SM;
-
-    /* restore the old USP as it was before we stacked the sc etc.
-     * (we cannot just pop the sigcontext since we aligned the sp and
-     *  stuff after pushing it)
-     */
-
-    __get_user(old_usp, &sc->usp);
-    phx_signal("old_usp 0x%lx", old_usp);
-
-    __PHX__ REALLY           /* ??? */
-    wrusp(old_usp);
-    regs->gpr[1] = old_usp;
-
-    /* TODO: the other ports use regs->orig_XX to disable syscall checks
-     * after this completes, but we don't use that mechanism. maybe we can
-     * use it now ?
-     */
-
-    return err;
-
-badframe:
-    return 1;
+    /* Make sure the supervisor flag is clear.  */
+    __get_user(v, &sc->regs.sr);
+    cpu_set_sr(env, v & ~SR_SM);
 }
-#endif
 
 /* Set up a signal frame.  */
 
-static void setup_sigcontext(struct target_sigcontext *sc,
-                             CPUOpenRISCState *regs,
-                             unsigned long mask)
+static void setup_sigcontext(target_sigcontext *sc, CPUOpenRISCState *env)
 {
-    unsigned long usp = cpu_get_gpr(regs, 1);
+    int i;
 
-    /* copy the regs. they are first in sc so we can use sc directly */
+    for (i = 0; i < 32; ++i) {
+        __put_user(cpu_get_gpr(env, i), &sc->regs.gpr[i]);
+    }
 
-    /*copy_to_user(&sc, regs, sizeof(struct target_pt_regs));*/
-
-    /* Set the frametype to CRIS_FRAME_NORMAL for the execution of
-       the signal handler. The frametype will be restored to its previous
-       value in restore_sigcontext. */
-    /*regs->frametype = CRIS_FRAME_NORMAL;*/
-
-    /* then some other stuff */
-    __put_user(mask, &sc->oldmask);
-    __put_user(usp, &sc->usp);
+    __put_user(env->pc, &sc->regs.pc);
+    __put_user(cpu_get_sr(env), &sc->regs.sr);
 }
 
-static inline unsigned long align_sigframe(unsigned long sp)
+static inline target_ulong align_sigframe(target_ulong sp)
 {
-    return sp & ~3UL;
+    return QEMU_ALIGN_DOWN(sp, 4);
 }
 
 static inline abi_ulong get_sigframe(struct target_sigaction *ka,
-                                     CPUOpenRISCState *regs,
+                                     CPUOpenRISCState *env,
                                      size_t frame_size)
 {
-    unsigned long sp = get_sp_from_cpustate(regs);
+    target_ulong sp = get_sp_from_cpustate(env);
     int onsigstack = on_sig_stack(sp);
 
-    /* redzone */
-    sp = target_sigsp(sp, ka);
-
+    /* Honor redzone now.  If we swap to signal stack, no need to waste
+     * the 128 bytes by subtracting afterward.
+     */
+    sp = target_sigsp(sp - 128, ka);
     sp = align_sigframe(sp - frame_size);
 
-    /*
-     * If we are on the alternate signal stack and would overflow it, don't.
+    /* If we are on the alternate signal stack and would overflow it, don't.
      * Return an always-bogus address instead so we will die with SIGSEGV.
      */
-
-    if (onsigstack && !likely(on_sig_stack(sp))) {
+    if (onsigstack && !on_sig_stack(sp)) {
         return -1L;
     }
-
     return sp;
 }
 
@@ -148,11 +102,8 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
                     target_siginfo_t *info,
                     target_sigset_t *set, CPUOpenRISCState *env)
 {
-    int err = 0;
     abi_ulong frame_addr;
-    unsigned long return_ip;
-    struct target_rt_sigframe *frame;
-    abi_ulong info_addr, uc_addr;
+    target_rt_sigframe *frame;
 
     frame_addr = get_sigframe(ka, env, sizeof(*frame));
     trace_user_setup_rt_frame(env, frame_addr);
@@ -160,47 +111,32 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         goto give_sigsegv;
     }
 
-    info_addr = frame_addr + offsetof(struct target_rt_sigframe, info);
-    __put_user(info_addr, &frame->pinfo);
-    uc_addr = frame_addr + offsetof(struct target_rt_sigframe, uc);
-    __put_user(uc_addr, &frame->puc);
+    tswap_siginfo(&frame->info, info);
 
-    if (ka->sa_flags & SA_SIGINFO) {
-        tswap_siginfo(&frame->info, info);
-    }
-
-    /*err |= __clear_user(&frame->uc, offsetof(ucontext_t, uc_mcontext));*/
     __put_user(0, &frame->uc.tuc_flags);
     __put_user(0, &frame->uc.tuc_link);
+
     target_save_altstack(&frame->uc.tuc_stack, env);
-    setup_sigcontext(&frame->sc, env, set->sig[0]);
+    setup_sigcontext(&frame->uc.tuc_mcontext, env);
 
-    /*err |= copy_to_user(frame->uc.tuc_sigmask, set, sizeof(*set));*/
-
-    /* trampoline - the desired return ip is the retcode itself */
-    return_ip = (unsigned long)&frame->retcode;
-    /* This is l.ori r11,r0,__NR_sigreturn, l.sys 1 */
-    __put_user(0xa960, (short *)(frame->retcode + 0));
-    __put_user(TARGET_NR_rt_sigreturn, (short *)(frame->retcode + 2));
-    __put_user(0x20000001, (unsigned long *)(frame->retcode + 4));
-    __put_user(0x15000000, (unsigned long *)(frame->retcode + 8));
-
-    if (err) {
-        goto give_sigsegv;
-    }
-
-    /* TODO what is the current->exec_domain stuff and invmap ? */
+    /* This is l.ori r11,r0,__NR_sigreturn; l.sys 1; l.nop; l.nop */
+    __put_user(0xa9600000 | TARGET_NR_rt_sigreturn, frame->retcode + 0);
+    __put_user(0x20000001, frame->retcode + 1);
+    __put_user(0x15000000, frame->retcode + 2);
+    __put_user(0x15000000, frame->retcode + 3);
 
     /* Set up registers for signal handler */
-    env->pc = (unsigned long)ka->_sa_handler; /* what we enter NOW */
-    cpu_set_gpr(env, 9, (unsigned long)return_ip);     /* what we enter LATER */
-    cpu_set_gpr(env, 3, (unsigned long)sig);           /* arg 1: signo */
-    cpu_set_gpr(env, 4, (unsigned long)&frame->info);  /* arg 2: (siginfo_t*) */
-    cpu_set_gpr(env, 5, (unsigned long)&frame->uc);    /* arg 3: ucontext */
-
-    /* actually move the usp to reflect the stacked frame */
-    cpu_set_gpr(env, 1, (unsigned long)frame);
+    cpu_set_gpr(env, 9, frame_addr + offsetof(target_rt_sigframe, retcode));
+    cpu_set_gpr(env, 3, sig);
+    cpu_set_gpr(env, 4, frame_addr + offsetof(target_rt_sigframe, info));
+    cpu_set_gpr(env, 5, frame_addr + offsetof(target_rt_sigframe, uc));
+    cpu_set_gpr(env, 1, frame_addr);
 
+    /* For debugging convenience, set ppc to the insn that faulted.  */
+    env->ppc = env->pc;
+    /* When setting the PC for the signal handler, exit delay slot.  */
+    env->pc = ka->_sa_handler;
+    env->dflag = 0;
     return;
 
 give_sigsegv:
@@ -208,16 +144,34 @@ give_sigsegv:
     force_sigsegv(sig);
 }
 
-long do_sigreturn(CPUOpenRISCState *env)
-{
-    trace_user_do_sigreturn(env, 0);
-    fprintf(stderr, "do_sigreturn: not implemented\n");
-    return -TARGET_ENOSYS;
-}
-
 long do_rt_sigreturn(CPUOpenRISCState *env)
 {
+    abi_ulong frame_addr = cpu_get_gpr(env, 1);
+    target_rt_sigframe *frame;
+    sigset_t set;
+
     trace_user_do_rt_sigreturn(env, 0);
-    fprintf(stderr, "do_rt_sigreturn: not implemented\n");
-    return -TARGET_ENOSYS;
+    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
+        goto badframe;
+    }
+    if (frame_addr & 3) {
+        goto badframe;
+    }
+
+    target_to_host_sigset(&set, &frame->uc.tuc_sigmask);
+    set_sigmask(&set);
+
+    restore_sigcontext(env, &frame->uc.tuc_mcontext);
+    if (do_sigaltstack(frame_addr + offsetof(target_rt_sigframe, uc.tuc_stack),
+                       0, frame_addr) == -EFAULT) {
+        goto badframe;
+    }
+
+    unlock_user_struct(frame, frame_addr, 0);
+    return cpu_get_gpr(env, 11);
+
+ badframe:
+    unlock_user_struct(frame, frame_addr, 0);
+    force_sig(TARGET_SIGSEGV);
+    return 0;
 }
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 01de433e3a..a8d1f7a284 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -237,7 +237,7 @@ int do_sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
     return 0;
 }
 
-#if !defined(TARGET_OPENRISC) && !defined(TARGET_NIOS2)
+#if !defined(TARGET_NIOS2)
 /* Just set the guest's signal mask to the specified value; the
  * caller is assumed to have called block_signals() already.
  */
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index d1ef4c737c..7648a74636 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -28,6 +28,7 @@ static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
 
     cpu->env.pc = value;
+    cpu->env.dflag = 0;
 }
 
 static bool openrisc_cpu_has_work(CPUState *cs)
-- 
2.17.0
