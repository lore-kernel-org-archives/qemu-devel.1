Received: from eggs.gnu.org ([2001:4830:134:3::10]:45762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVe0-0005IL-0p
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdw-0000zK-5f
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:44 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 23 Mar 2018 23:57:37 +0100
Message-Id: <20180323225739.17329-19-laurent@vivier.eu>
In-Reply-To: <20180323225739.17329-1-laurent@vivier.eu>
References: <20180323225739.17329-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 v2 18/20] linux-user: move mips/mips64
 signal.c parts to mips directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, qemu-s390x@nongnu.org

No code change, only move code from signal.c to
mips/signal.c, except adding includes and
exporting setup_frame() and setup_rt_frame().

mips64/signal.c includes mips/signal.c

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mips/signal.c          | 382 ++++++++++++++++++++++++++++++++++++++
 linux-user/mips/target_signal.h   |   9 +-
 linux-user/mips64/signal.c        |   2 +
 linux-user/mips64/target_signal.h |   4 +-
 linux-user/signal.c               | 381 +------------------------------------
 5 files changed, 396 insertions(+), 382 deletions(-)

diff --git a/linux-user/mips/signal.c b/linux-user/mips/signal.c
index 02ca338b6c..a44e5b59e9 100644
--- a/linux-user/mips/signal.c
+++ b/linux-user/mips/signal.c
@@ -16,3 +16,385 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "target_signal.h"
+#include "signal-common.h"
+#include "linux-user/trace.h"
+
+# if defined(TARGET_ABI_MIPSO32)
+struct target_sigcontext {
+    uint32_t   sc_regmask;     /* Unused */
+    uint32_t   sc_status;
+    uint64_t   sc_pc;
+    uint64_t   sc_regs[32];
+    uint64_t   sc_fpregs[32];
+    uint32_t   sc_ownedfp;     /* Unused */
+    uint32_t   sc_fpc_csr;
+    uint32_t   sc_fpc_eir;     /* Unused */
+    uint32_t   sc_used_math;
+    uint32_t   sc_dsp;         /* dsp status, was sc_ssflags */
+    uint32_t   pad0;
+    uint64_t   sc_mdhi;
+    uint64_t   sc_mdlo;
+    target_ulong   sc_hi1;         /* Was sc_cause */
+    target_ulong   sc_lo1;         /* Was sc_badvaddr */
+    target_ulong   sc_hi2;         /* Was sc_sigset[4] */
+    target_ulong   sc_lo2;
+    target_ulong   sc_hi3;
+    target_ulong   sc_lo3;
+};
+# else /* N32 || N64 */
+struct target_sigcontext {
+    uint64_t sc_regs[32];
+    uint64_t sc_fpregs[32];
+    uint64_t sc_mdhi;
+    uint64_t sc_hi1;
+    uint64_t sc_hi2;
+    uint64_t sc_hi3;
+    uint64_t sc_mdlo;
+    uint64_t sc_lo1;
+    uint64_t sc_lo2;
+    uint64_t sc_lo3;
+    uint64_t sc_pc;
+    uint32_t sc_fpc_csr;
+    uint32_t sc_used_math;
+    uint32_t sc_dsp;
+    uint32_t sc_reserved;
+};
+# endif /* O32 */
+
+struct sigframe {
+    uint32_t sf_ass[4];			/* argument save space for o32 */
+    uint32_t sf_code[2];			/* signal trampoline */
+    struct target_sigcontext sf_sc;
+    target_sigset_t sf_mask;
+};
+
+struct target_ucontext {
+    target_ulong tuc_flags;
+    target_ulong tuc_link;
+    target_stack_t tuc_stack;
+    target_ulong pad0;
+    struct target_sigcontext tuc_mcontext;
+    target_sigset_t tuc_sigmask;
+};
+
+struct target_rt_sigframe {
+    uint32_t rs_ass[4];               /* argument save space for o32 */
+    uint32_t rs_code[2];              /* signal trampoline */
+    struct target_siginfo rs_info;
+    struct target_ucontext rs_uc;
+};
+
+/* Install trampoline to jump back from signal handler */
+static inline int install_sigtramp(unsigned int *tramp,   unsigned int syscall)
+{
+    int err = 0;
+
+    /*
+     * Set up the return code ...
+     *
+     *         li      v0, __NR__foo_sigreturn
+     *         syscall
+     */
+
+    __put_user(0x24020000 + syscall, tramp + 0);
+    __put_user(0x0000000c          , tramp + 1);
+    return err;
+}
+
+static inline void setup_sigcontext(CPUMIPSState *regs,
+                                    struct target_sigcontext *sc)
+{
+    int i;
+
+    __put_user(exception_resume_pc(regs), &sc->sc_pc);
+    regs->hflags &= ~MIPS_HFLAG_BMASK;
+
+    __put_user(0, &sc->sc_regs[0]);
+    for (i = 1; i < 32; ++i) {
+        __put_user(regs->active_tc.gpr[i], &sc->sc_regs[i]);
+    }
+
+    __put_user(regs->active_tc.HI[0], &sc->sc_mdhi);
+    __put_user(regs->active_tc.LO[0], &sc->sc_mdlo);
+
+    /* Rather than checking for dsp existence, always copy.  The storage
+       would just be garbage otherwise.  */
+    __put_user(regs->active_tc.HI[1], &sc->sc_hi1);
+    __put_user(regs->active_tc.HI[2], &sc->sc_hi2);
+    __put_user(regs->active_tc.HI[3], &sc->sc_hi3);
+    __put_user(regs->active_tc.LO[1], &sc->sc_lo1);
+    __put_user(regs->active_tc.LO[2], &sc->sc_lo2);
+    __put_user(regs->active_tc.LO[3], &sc->sc_lo3);
+    {
+        uint32_t dsp = cpu_rddsp(0x3ff, regs);
+        __put_user(dsp, &sc->sc_dsp);
+    }
+
+    __put_user(1, &sc->sc_used_math);
+
+    for (i = 0; i < 32; ++i) {
+        __put_user(regs->active_fpu.fpr[i].d, &sc->sc_fpregs[i]);
+    }
+}
+
+static inline void
+restore_sigcontext(CPUMIPSState *regs, struct target_sigcontext *sc)
+{
+    int i;
+
+    __get_user(regs->CP0_EPC, &sc->sc_pc);
+
+    __get_user(regs->active_tc.HI[0], &sc->sc_mdhi);
+    __get_user(regs->active_tc.LO[0], &sc->sc_mdlo);
+
+    for (i = 1; i < 32; ++i) {
+        __get_user(regs->active_tc.gpr[i], &sc->sc_regs[i]);
+    }
+
+    __get_user(regs->active_tc.HI[1], &sc->sc_hi1);
+    __get_user(regs->active_tc.HI[2], &sc->sc_hi2);
+    __get_user(regs->active_tc.HI[3], &sc->sc_hi3);
+    __get_user(regs->active_tc.LO[1], &sc->sc_lo1);
+    __get_user(regs->active_tc.LO[2], &sc->sc_lo2);
+    __get_user(regs->active_tc.LO[3], &sc->sc_lo3);
+    {
+        uint32_t dsp;
+        __get_user(dsp, &sc->sc_dsp);
+        cpu_wrdsp(dsp, 0x3ff, regs);
+    }
+
+    for (i = 0; i < 32; ++i) {
+        __get_user(regs->active_fpu.fpr[i].d, &sc->sc_fpregs[i]);
+    }
+}
+
+/*
+ * Determine which stack to use..
+ */
+static inline abi_ulong
+get_sigframe(struct target_sigaction *ka, CPUMIPSState *regs, size_t frame_size)
+{
+    unsigned long sp;
+
+    /* Default to using normal stack */
+    sp = regs->active_tc.gpr[29];
+
+    /*
+     * FPU emulator may have its own trampoline active just
+     * above the user stack, 16-bytes before the next lowest
+     * 16 byte boundary.  Try to avoid trashing it.
+     */
+    sp -= 32;
+
+    /* This is the X/Open sanctioned signal stack switching.  */
+    if ((ka->sa_flags & TARGET_SA_ONSTACK) && (sas_ss_flags (sp) == 0)) {
+        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
+    }
+
+    return (sp - frame_size) & ~7;
+}
+
+static void mips_set_hflags_isa_mode_from_pc(CPUMIPSState *env)
+{
+    if (env->insn_flags & (ASE_MIPS16 | ASE_MICROMIPS)) {
+        env->hflags &= ~MIPS_HFLAG_M16;
+        env->hflags |= (env->active_tc.PC & 1) << MIPS_HFLAG_M16_SHIFT;
+        env->active_tc.PC &= ~(target_ulong) 1;
+    }
+}
+
+# if defined(TARGET_ABI_MIPSO32)
+/* compare linux/arch/mips/kernel/signal.c:setup_frame() */
+void setup_frame(int sig, struct target_sigaction * ka,
+                 target_sigset_t *set, CPUMIPSState *regs)
+{
+    struct sigframe *frame;
+    abi_ulong frame_addr;
+    int i;
+
+    frame_addr = get_sigframe(ka, regs, sizeof(*frame));
+    trace_user_setup_frame(regs, frame_addr);
+    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
+        goto give_sigsegv;
+    }
+
+    install_sigtramp(frame->sf_code, TARGET_NR_sigreturn);
+
+    setup_sigcontext(regs, &frame->sf_sc);
+
+    for(i = 0; i < TARGET_NSIG_WORDS; i++) {
+        __put_user(set->sig[i], &frame->sf_mask.sig[i]);
+    }
+
+    /*
+    * Arguments to signal handler:
+    *
+    *   a0 = signal number
+    *   a1 = 0 (should be cause)
+    *   a2 = pointer to struct sigcontext
+    *
+    * $25 and PC point to the signal handler, $29 points to the
+    * struct sigframe.
+    */
+    regs->active_tc.gpr[ 4] = sig;
+    regs->active_tc.gpr[ 5] = 0;
+    regs->active_tc.gpr[ 6] = frame_addr + offsetof(struct sigframe, sf_sc);
+    regs->active_tc.gpr[29] = frame_addr;
+    regs->active_tc.gpr[31] = frame_addr + offsetof(struct sigframe, sf_code);
+    /* The original kernel code sets CP0_EPC to the handler
+    * since it returns to userland using eret
+    * we cannot do this here, and we must set PC directly */
+    regs->active_tc.PC = regs->active_tc.gpr[25] = ka->_sa_handler;
+    mips_set_hflags_isa_mode_from_pc(regs);
+    unlock_user_struct(frame, frame_addr, 1);
+    return;
+
+give_sigsegv:
+    force_sigsegv(sig);
+}
+
+long do_sigreturn(CPUMIPSState *regs)
+{
+    struct sigframe *frame;
+    abi_ulong frame_addr;
+    sigset_t blocked;
+    target_sigset_t target_set;
+    int i;
+
+    frame_addr = regs->active_tc.gpr[29];
+    trace_user_do_sigreturn(regs, frame_addr);
+    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1))
+        goto badframe;
+
+    for(i = 0; i < TARGET_NSIG_WORDS; i++) {
+        __get_user(target_set.sig[i], &frame->sf_mask.sig[i]);
+    }
+
+    target_to_host_sigset_internal(&blocked, &target_set);
+    set_sigmask(&blocked);
+
+    restore_sigcontext(regs, &frame->sf_sc);
+
+#if 0
+    /*
+     * Don't let your children do this ...
+     */
+    __asm__ __volatile__(
+   	"move\t$29, %0\n\t"
+   	"j\tsyscall_exit"
+   	:/* no outputs */
+   	:"r" (&regs));
+    /* Unreached */
+#endif
+
+    regs->active_tc.PC = regs->CP0_EPC;
+    mips_set_hflags_isa_mode_from_pc(regs);
+    /* I am not sure this is right, but it seems to work
+    * maybe a problem with nested signals ? */
+    regs->CP0_EPC = 0;
+    return -TARGET_QEMU_ESIGRETURN;
+
+badframe:
+    force_sig(TARGET_SIGSEGV);
+    return -TARGET_QEMU_ESIGRETURN;
+}
+# endif /* O32 */
+
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                    target_sigset_t *set, CPUMIPSState *env)
+{
+    struct target_rt_sigframe *frame;
+    abi_ulong frame_addr;
+    int i;
+
+    frame_addr = get_sigframe(ka, env, sizeof(*frame));
+    trace_user_setup_rt_frame(env, frame_addr);
+    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
+        goto give_sigsegv;
+    }
+
+    install_sigtramp(frame->rs_code, TARGET_NR_rt_sigreturn);
+
+    tswap_siginfo(&frame->rs_info, info);
+
+    __put_user(0, &frame->rs_uc.tuc_flags);
+    __put_user(0, &frame->rs_uc.tuc_link);
+    __put_user(target_sigaltstack_used.ss_sp, &frame->rs_uc.tuc_stack.ss_sp);
+    __put_user(target_sigaltstack_used.ss_size, &frame->rs_uc.tuc_stack.ss_size);
+    __put_user(sas_ss_flags(get_sp_from_cpustate(env)),
+               &frame->rs_uc.tuc_stack.ss_flags);
+
+    setup_sigcontext(env, &frame->rs_uc.tuc_mcontext);
+
+    for(i = 0; i < TARGET_NSIG_WORDS; i++) {
+        __put_user(set->sig[i], &frame->rs_uc.tuc_sigmask.sig[i]);
+    }
+
+    /*
+    * Arguments to signal handler:
+    *
+    *   a0 = signal number
+    *   a1 = pointer to siginfo_t
+    *   a2 = pointer to ucontext_t
+    *
+    * $25 and PC point to the signal handler, $29 points to the
+    * struct sigframe.
+    */
+    env->active_tc.gpr[ 4] = sig;
+    env->active_tc.gpr[ 5] = frame_addr
+                             + offsetof(struct target_rt_sigframe, rs_info);
+    env->active_tc.gpr[ 6] = frame_addr
+                             + offsetof(struct target_rt_sigframe, rs_uc);
+    env->active_tc.gpr[29] = frame_addr;
+    env->active_tc.gpr[31] = frame_addr
+                             + offsetof(struct target_rt_sigframe, rs_code);
+    /* The original kernel code sets CP0_EPC to the handler
+    * since it returns to userland using eret
+    * we cannot do this here, and we must set PC directly */
+    env->active_tc.PC = env->active_tc.gpr[25] = ka->_sa_handler;
+    mips_set_hflags_isa_mode_from_pc(env);
+    unlock_user_struct(frame, frame_addr, 1);
+    return;
+
+give_sigsegv:
+    unlock_user_struct(frame, frame_addr, 1);
+    force_sigsegv(sig);
+}
+
+long do_rt_sigreturn(CPUMIPSState *env)
+{
+    struct target_rt_sigframe *frame;
+    abi_ulong frame_addr;
+    sigset_t blocked;
+
+    frame_addr = env->active_tc.gpr[29];
+    trace_user_do_rt_sigreturn(env, frame_addr);
+    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
+        goto badframe;
+    }
+
+    target_to_host_sigset(&blocked, &frame->rs_uc.tuc_sigmask);
+    set_sigmask(&blocked);
+
+    restore_sigcontext(env, &frame->rs_uc.tuc_mcontext);
+
+    if (do_sigaltstack(frame_addr +
+                       offsetof(struct target_rt_sigframe, rs_uc.tuc_stack),
+                       0, get_sp_from_cpustate(env)) == -EFAULT)
+        goto badframe;
+
+    env->active_tc.PC = env->CP0_EPC;
+    mips_set_hflags_isa_mode_from_pc(env);
+    /* I am not sure this is right, but it seems to work
+    * maybe a problem with nested signals ? */
+    env->CP0_EPC = 0;
+    return -TARGET_QEMU_ESIGRETURN;
+
+badframe:
+    force_sig(TARGET_SIGSEGV);
+    return -TARGET_QEMU_ESIGRETURN;
+}
diff --git a/linux-user/mips/target_signal.h b/linux-user/mips/target_signal.h
index 8dd27cef35..22ab3e4a94 100644
--- a/linux-user/mips/target_signal.h
+++ b/linux-user/mips/target_signal.h
@@ -26,5 +26,12 @@ static inline abi_ulong get_sp_from_cpustate(CPUMIPSState *state)
     return state->active_tc.gpr[29];
 }
 
-
+# if defined(TARGET_ABI_MIPSO32)
+/* compare linux/arch/mips/kernel/signal.c:setup_frame() */
+void setup_frame(int sig, struct target_sigaction * ka,
+                 target_sigset_t *set, CPUMIPSState *regs);
+#endif
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                    target_sigset_t *set, CPUMIPSState *env);
 #endif /* MIPS_TARGET_SIGNAL_H */
diff --git a/linux-user/mips64/signal.c b/linux-user/mips64/signal.c
index 02ca338b6c..4ed0ed90b3 100644
--- a/linux-user/mips64/signal.c
+++ b/linux-user/mips64/signal.c
@@ -16,3 +16,5 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+#define MIPS_TARGET_SIGNAL_H /* to only include mips64/target_signal.h */
+#include "../mips/signal.c"
diff --git a/linux-user/mips64/target_signal.h b/linux-user/mips64/target_signal.h
index 67ef5a18f4..70dfe40978 100644
--- a/linux-user/mips64/target_signal.h
+++ b/linux-user/mips64/target_signal.h
@@ -26,5 +26,7 @@ static inline abi_ulong get_sp_from_cpustate(CPUMIPSState *state)
     return state->active_tc.gpr[29];
 }
 
-
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                    target_sigset_t *set, CPUMIPSState *env);
 #endif /* MIPS64_TARGET_SIGNAL_H */
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 2bcb32a7ce..92d7347b14 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -803,386 +803,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
     return ret;
 }
 
-#if defined(TARGET_MIPS) || defined(TARGET_MIPS64)
-
-# if defined(TARGET_ABI_MIPSO32)
-struct target_sigcontext {
-    uint32_t   sc_regmask;     /* Unused */
-    uint32_t   sc_status;
-    uint64_t   sc_pc;
-    uint64_t   sc_regs[32];
-    uint64_t   sc_fpregs[32];
-    uint32_t   sc_ownedfp;     /* Unused */
-    uint32_t   sc_fpc_csr;
-    uint32_t   sc_fpc_eir;     /* Unused */
-    uint32_t   sc_used_math;
-    uint32_t   sc_dsp;         /* dsp status, was sc_ssflags */
-    uint32_t   pad0;
-    uint64_t   sc_mdhi;
-    uint64_t   sc_mdlo;
-    target_ulong   sc_hi1;         /* Was sc_cause */
-    target_ulong   sc_lo1;         /* Was sc_badvaddr */
-    target_ulong   sc_hi2;         /* Was sc_sigset[4] */
-    target_ulong   sc_lo2;
-    target_ulong   sc_hi3;
-    target_ulong   sc_lo3;
-};
-# else /* N32 || N64 */
-struct target_sigcontext {
-    uint64_t sc_regs[32];
-    uint64_t sc_fpregs[32];
-    uint64_t sc_mdhi;
-    uint64_t sc_hi1;
-    uint64_t sc_hi2;
-    uint64_t sc_hi3;
-    uint64_t sc_mdlo;
-    uint64_t sc_lo1;
-    uint64_t sc_lo2;
-    uint64_t sc_lo3;
-    uint64_t sc_pc;
-    uint32_t sc_fpc_csr;
-    uint32_t sc_used_math;
-    uint32_t sc_dsp;
-    uint32_t sc_reserved;
-};
-# endif /* O32 */
-
-struct sigframe {
-    uint32_t sf_ass[4];			/* argument save space for o32 */
-    uint32_t sf_code[2];			/* signal trampoline */
-    struct target_sigcontext sf_sc;
-    target_sigset_t sf_mask;
-};
-
-struct target_ucontext {
-    target_ulong tuc_flags;
-    target_ulong tuc_link;
-    target_stack_t tuc_stack;
-    target_ulong pad0;
-    struct target_sigcontext tuc_mcontext;
-    target_sigset_t tuc_sigmask;
-};
-
-struct target_rt_sigframe {
-    uint32_t rs_ass[4];               /* argument save space for o32 */
-    uint32_t rs_code[2];              /* signal trampoline */
-    struct target_siginfo rs_info;
-    struct target_ucontext rs_uc;
-};
-
-/* Install trampoline to jump back from signal handler */
-static inline int install_sigtramp(unsigned int *tramp,   unsigned int syscall)
-{
-    int err = 0;
-
-    /*
-     * Set up the return code ...
-     *
-     *         li      v0, __NR__foo_sigreturn
-     *         syscall
-     */
-
-    __put_user(0x24020000 + syscall, tramp + 0);
-    __put_user(0x0000000c          , tramp + 1);
-    return err;
-}
-
-static inline void setup_sigcontext(CPUMIPSState *regs,
-                                    struct target_sigcontext *sc)
-{
-    int i;
-
-    __put_user(exception_resume_pc(regs), &sc->sc_pc);
-    regs->hflags &= ~MIPS_HFLAG_BMASK;
-
-    __put_user(0, &sc->sc_regs[0]);
-    for (i = 1; i < 32; ++i) {
-        __put_user(regs->active_tc.gpr[i], &sc->sc_regs[i]);
-    }
-
-    __put_user(regs->active_tc.HI[0], &sc->sc_mdhi);
-    __put_user(regs->active_tc.LO[0], &sc->sc_mdlo);
-
-    /* Rather than checking for dsp existence, always copy.  The storage
-       would just be garbage otherwise.  */
-    __put_user(regs->active_tc.HI[1], &sc->sc_hi1);
-    __put_user(regs->active_tc.HI[2], &sc->sc_hi2);
-    __put_user(regs->active_tc.HI[3], &sc->sc_hi3);
-    __put_user(regs->active_tc.LO[1], &sc->sc_lo1);
-    __put_user(regs->active_tc.LO[2], &sc->sc_lo2);
-    __put_user(regs->active_tc.LO[3], &sc->sc_lo3);
-    {
-        uint32_t dsp = cpu_rddsp(0x3ff, regs);
-        __put_user(dsp, &sc->sc_dsp);
-    }
-
-    __put_user(1, &sc->sc_used_math);
-
-    for (i = 0; i < 32; ++i) {
-        __put_user(regs->active_fpu.fpr[i].d, &sc->sc_fpregs[i]);
-    }
-}
-
-static inline void
-restore_sigcontext(CPUMIPSState *regs, struct target_sigcontext *sc)
-{
-    int i;
-
-    __get_user(regs->CP0_EPC, &sc->sc_pc);
-
-    __get_user(regs->active_tc.HI[0], &sc->sc_mdhi);
-    __get_user(regs->active_tc.LO[0], &sc->sc_mdlo);
-
-    for (i = 1; i < 32; ++i) {
-        __get_user(regs->active_tc.gpr[i], &sc->sc_regs[i]);
-    }
-
-    __get_user(regs->active_tc.HI[1], &sc->sc_hi1);
-    __get_user(regs->active_tc.HI[2], &sc->sc_hi2);
-    __get_user(regs->active_tc.HI[3], &sc->sc_hi3);
-    __get_user(regs->active_tc.LO[1], &sc->sc_lo1);
-    __get_user(regs->active_tc.LO[2], &sc->sc_lo2);
-    __get_user(regs->active_tc.LO[3], &sc->sc_lo3);
-    {
-        uint32_t dsp;
-        __get_user(dsp, &sc->sc_dsp);
-        cpu_wrdsp(dsp, 0x3ff, regs);
-    }
-
-    for (i = 0; i < 32; ++i) {
-        __get_user(regs->active_fpu.fpr[i].d, &sc->sc_fpregs[i]);
-    }
-}
-
-/*
- * Determine which stack to use..
- */
-static inline abi_ulong
-get_sigframe(struct target_sigaction *ka, CPUMIPSState *regs, size_t frame_size)
-{
-    unsigned long sp;
-
-    /* Default to using normal stack */
-    sp = regs->active_tc.gpr[29];
-
-    /*
-     * FPU emulator may have its own trampoline active just
-     * above the user stack, 16-bytes before the next lowest
-     * 16 byte boundary.  Try to avoid trashing it.
-     */
-    sp -= 32;
-
-    /* This is the X/Open sanctioned signal stack switching.  */
-    if ((ka->sa_flags & TARGET_SA_ONSTACK) && (sas_ss_flags (sp) == 0)) {
-        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-    }
-
-    return (sp - frame_size) & ~7;
-}
-
-static void mips_set_hflags_isa_mode_from_pc(CPUMIPSState *env)
-{
-    if (env->insn_flags & (ASE_MIPS16 | ASE_MICROMIPS)) {
-        env->hflags &= ~MIPS_HFLAG_M16;
-        env->hflags |= (env->active_tc.PC & 1) << MIPS_HFLAG_M16_SHIFT;
-        env->active_tc.PC &= ~(target_ulong) 1;
-    }
-}
-
-# if defined(TARGET_ABI_MIPSO32)
-/* compare linux/arch/mips/kernel/signal.c:setup_frame() */
-static void setup_frame(int sig, struct target_sigaction * ka,
-                        target_sigset_t *set, CPUMIPSState *regs)
-{
-    struct sigframe *frame;
-    abi_ulong frame_addr;
-    int i;
-
-    frame_addr = get_sigframe(ka, regs, sizeof(*frame));
-    trace_user_setup_frame(regs, frame_addr);
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
-        goto give_sigsegv;
-    }
-
-    install_sigtramp(frame->sf_code, TARGET_NR_sigreturn);
-
-    setup_sigcontext(regs, &frame->sf_sc);
-
-    for(i = 0; i < TARGET_NSIG_WORDS; i++) {
-        __put_user(set->sig[i], &frame->sf_mask.sig[i]);
-    }
-
-    /*
-    * Arguments to signal handler:
-    *
-    *   a0 = signal number
-    *   a1 = 0 (should be cause)
-    *   a2 = pointer to struct sigcontext
-    *
-    * $25 and PC point to the signal handler, $29 points to the
-    * struct sigframe.
-    */
-    regs->active_tc.gpr[ 4] = sig;
-    regs->active_tc.gpr[ 5] = 0;
-    regs->active_tc.gpr[ 6] = frame_addr + offsetof(struct sigframe, sf_sc);
-    regs->active_tc.gpr[29] = frame_addr;
-    regs->active_tc.gpr[31] = frame_addr + offsetof(struct sigframe, sf_code);
-    /* The original kernel code sets CP0_EPC to the handler
-    * since it returns to userland using eret
-    * we cannot do this here, and we must set PC directly */
-    regs->active_tc.PC = regs->active_tc.gpr[25] = ka->_sa_handler;
-    mips_set_hflags_isa_mode_from_pc(regs);
-    unlock_user_struct(frame, frame_addr, 1);
-    return;
-
-give_sigsegv:
-    force_sigsegv(sig);
-}
-
-long do_sigreturn(CPUMIPSState *regs)
-{
-    struct sigframe *frame;
-    abi_ulong frame_addr;
-    sigset_t blocked;
-    target_sigset_t target_set;
-    int i;
-
-    frame_addr = regs->active_tc.gpr[29];
-    trace_user_do_sigreturn(regs, frame_addr);
-    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1))
-        goto badframe;
-
-    for(i = 0; i < TARGET_NSIG_WORDS; i++) {
-        __get_user(target_set.sig[i], &frame->sf_mask.sig[i]);
-    }
-
-    target_to_host_sigset_internal(&blocked, &target_set);
-    set_sigmask(&blocked);
-
-    restore_sigcontext(regs, &frame->sf_sc);
-
-#if 0
-    /*
-     * Don't let your children do this ...
-     */
-    __asm__ __volatile__(
-   	"move\t$29, %0\n\t"
-   	"j\tsyscall_exit"
-   	:/* no outputs */
-   	:"r" (&regs));
-    /* Unreached */
-#endif
-
-    regs->active_tc.PC = regs->CP0_EPC;
-    mips_set_hflags_isa_mode_from_pc(regs);
-    /* I am not sure this is right, but it seems to work
-    * maybe a problem with nested signals ? */
-    regs->CP0_EPC = 0;
-    return -TARGET_QEMU_ESIGRETURN;
-
-badframe:
-    force_sig(TARGET_SIGSEGV);
-    return -TARGET_QEMU_ESIGRETURN;
-}
-# endif /* O32 */
-
-static void setup_rt_frame(int sig, struct target_sigaction *ka,
-                           target_siginfo_t *info,
-                           target_sigset_t *set, CPUMIPSState *env)
-{
-    struct target_rt_sigframe *frame;
-    abi_ulong frame_addr;
-    int i;
-
-    frame_addr = get_sigframe(ka, env, sizeof(*frame));
-    trace_user_setup_rt_frame(env, frame_addr);
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
-        goto give_sigsegv;
-    }
-
-    install_sigtramp(frame->rs_code, TARGET_NR_rt_sigreturn);
-
-    tswap_siginfo(&frame->rs_info, info);
-
-    __put_user(0, &frame->rs_uc.tuc_flags);
-    __put_user(0, &frame->rs_uc.tuc_link);
-    __put_user(target_sigaltstack_used.ss_sp, &frame->rs_uc.tuc_stack.ss_sp);
-    __put_user(target_sigaltstack_used.ss_size, &frame->rs_uc.tuc_stack.ss_size);
-    __put_user(sas_ss_flags(get_sp_from_cpustate(env)),
-               &frame->rs_uc.tuc_stack.ss_flags);
-
-    setup_sigcontext(env, &frame->rs_uc.tuc_mcontext);
-
-    for(i = 0; i < TARGET_NSIG_WORDS; i++) {
-        __put_user(set->sig[i], &frame->rs_uc.tuc_sigmask.sig[i]);
-    }
-
-    /*
-    * Arguments to signal handler:
-    *
-    *   a0 = signal number
-    *   a1 = pointer to siginfo_t
-    *   a2 = pointer to ucontext_t
-    *
-    * $25 and PC point to the signal handler, $29 points to the
-    * struct sigframe.
-    */
-    env->active_tc.gpr[ 4] = sig;
-    env->active_tc.gpr[ 5] = frame_addr
-                             + offsetof(struct target_rt_sigframe, rs_info);
-    env->active_tc.gpr[ 6] = frame_addr
-                             + offsetof(struct target_rt_sigframe, rs_uc);
-    env->active_tc.gpr[29] = frame_addr;
-    env->active_tc.gpr[31] = frame_addr
-                             + offsetof(struct target_rt_sigframe, rs_code);
-    /* The original kernel code sets CP0_EPC to the handler
-    * since it returns to userland using eret
-    * we cannot do this here, and we must set PC directly */
-    env->active_tc.PC = env->active_tc.gpr[25] = ka->_sa_handler;
-    mips_set_hflags_isa_mode_from_pc(env);
-    unlock_user_struct(frame, frame_addr, 1);
-    return;
-
-give_sigsegv:
-    unlock_user_struct(frame, frame_addr, 1);
-    force_sigsegv(sig);
-}
-
-long do_rt_sigreturn(CPUMIPSState *env)
-{
-    struct target_rt_sigframe *frame;
-    abi_ulong frame_addr;
-    sigset_t blocked;
-
-    frame_addr = env->active_tc.gpr[29];
-    trace_user_do_rt_sigreturn(env, frame_addr);
-    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
-        goto badframe;
-    }
-
-    target_to_host_sigset(&blocked, &frame->rs_uc.tuc_sigmask);
-    set_sigmask(&blocked);
-
-    restore_sigcontext(env, &frame->rs_uc.tuc_mcontext);
-
-    if (do_sigaltstack(frame_addr +
-                       offsetof(struct target_rt_sigframe, rs_uc.tuc_stack),
-                       0, get_sp_from_cpustate(env)) == -EFAULT)
-        goto badframe;
-
-    env->active_tc.PC = env->CP0_EPC;
-    mips_set_hflags_isa_mode_from_pc(env);
-    /* I am not sure this is right, but it seems to work
-    * maybe a problem with nested signals ? */
-    env->CP0_EPC = 0;
-    return -TARGET_QEMU_ESIGRETURN;
-
-badframe:
-    force_sig(TARGET_SIGSEGV);
-    return -TARGET_QEMU_ESIGRETURN;
-}
-
-#elif defined(TARGET_PPC)
+#if defined(TARGET_PPC)
 
 /* Size of dummy stack frame allocated when calling signal handler.
    See arch/powerpc/include/asm/ptrace.h.  */
-- 
2.14.3
