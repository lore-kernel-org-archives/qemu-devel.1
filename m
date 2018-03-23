Received: from eggs.gnu.org ([2001:4830:134:3::10]:45626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdq-00057B-VP
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdm-0000qb-0G
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:34 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 23 Mar 2018 23:57:27 +0100
Message-Id: <20180323225739.17329-9-laurent@vivier.eu>
In-Reply-To: <20180323225739.17329-1-laurent@vivier.eu>
References: <20180323225739.17329-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 v2 08/20] linux-user: move openrisc
 signal.c parts to openrisc directory
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
openrisc/signal.c, except adding includes and
exporting setup_rt_frame().

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/openrisc/signal.c        | 213 ++++++++++++++++++++++++++++++++++++
 linux-user/openrisc/target_signal.h |   4 +-
 linux-user/signal.c                 | 211 -----------------------------------
 3 files changed, 216 insertions(+), 212 deletions(-)

diff --git a/linux-user/openrisc/signal.c b/linux-user/openrisc/signal.c
index 02ca338b6c..0276808b59 100644
--- a/linux-user/openrisc/signal.c
+++ b/linux-user/openrisc/signal.c
@@ -16,3 +16,216 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "target_signal.h"
+#include "signal-common.h"
+#include "linux-user/trace.h"
+
+struct target_sigcontext {
+    struct target_pt_regs regs;
+    abi_ulong oldmask;
+    abi_ulong usp;
+};
+
+struct target_ucontext {
+    abi_ulong tuc_flags;
+    abi_ulong tuc_link;
+    target_stack_t tuc_stack;
+    struct target_sigcontext tuc_mcontext;
+    target_sigset_t tuc_sigmask;   /* mask last for extensibility */
+};
+
+struct target_rt_sigframe {
+    abi_ulong pinfo;
+    uint64_t puc;
+    struct target_siginfo info;
+    struct target_sigcontext sc;
+    struct target_ucontext uc;
+    unsigned char retcode[16];  /* trampoline code */
+};
+
+/* This is the asm-generic/ucontext.h version */
+#if 0
+static int restore_sigcontext(CPUOpenRISCState *regs,
+                              struct target_sigcontext *sc)
+{
+    unsigned int err = 0;
+    unsigned long old_usp;
+
+    /* Alwys make any pending restarted system call return -EINTR */
+    current_thread_info()->restart_block.fn = do_no_restart_syscall;
+
+    /* restore the regs from &sc->regs (same as sc, since regs is first)
+     * (sc is already checked for VERIFY_READ since the sigframe was
+     *  checked in sys_sigreturn previously)
+     */
+
+    if (copy_from_user(regs, &sc, sizeof(struct target_pt_regs))) {
+        goto badframe;
+    }
+
+    /* make sure the U-flag is set so user-mode cannot fool us */
+
+    regs->sr &= ~SR_SM;
+
+    /* restore the old USP as it was before we stacked the sc etc.
+     * (we cannot just pop the sigcontext since we aligned the sp and
+     *  stuff after pushing it)
+     */
+
+    __get_user(old_usp, &sc->usp);
+    phx_signal("old_usp 0x%lx", old_usp);
+
+    __PHX__ REALLY           /* ??? */
+    wrusp(old_usp);
+    regs->gpr[1] = old_usp;
+
+    /* TODO: the other ports use regs->orig_XX to disable syscall checks
+     * after this completes, but we don't use that mechanism. maybe we can
+     * use it now ?
+     */
+
+    return err;
+
+badframe:
+    return 1;
+}
+#endif
+
+/* Set up a signal frame.  */
+
+static void setup_sigcontext(struct target_sigcontext *sc,
+                             CPUOpenRISCState *regs,
+                             unsigned long mask)
+{
+    unsigned long usp = cpu_get_gpr(regs, 1);
+
+    /* copy the regs. they are first in sc so we can use sc directly */
+
+    /*copy_to_user(&sc, regs, sizeof(struct target_pt_regs));*/
+
+    /* Set the frametype to CRIS_FRAME_NORMAL for the execution of
+       the signal handler. The frametype will be restored to its previous
+       value in restore_sigcontext. */
+    /*regs->frametype = CRIS_FRAME_NORMAL;*/
+
+    /* then some other stuff */
+    __put_user(mask, &sc->oldmask);
+    __put_user(usp, &sc->usp);
+}
+
+static inline unsigned long align_sigframe(unsigned long sp)
+{
+    return sp & ~3UL;
+}
+
+static inline abi_ulong get_sigframe(struct target_sigaction *ka,
+                                     CPUOpenRISCState *regs,
+                                     size_t frame_size)
+{
+    unsigned long sp = cpu_get_gpr(regs, 1);
+    int onsigstack = on_sig_stack(sp);
+
+    /* redzone */
+    /* This is the X/Open sanctioned signal stack switching.  */
+    if ((ka->sa_flags & TARGET_SA_ONSTACK) != 0 && !onsigstack) {
+        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
+    }
+
+    sp = align_sigframe(sp - frame_size);
+
+    /*
+     * If we are on the alternate signal stack and would overflow it, don't.
+     * Return an always-bogus address instead so we will die with SIGSEGV.
+     */
+
+    if (onsigstack && !likely(on_sig_stack(sp))) {
+        return -1L;
+    }
+
+    return sp;
+}
+
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                    target_sigset_t *set, CPUOpenRISCState *env)
+{
+    int err = 0;
+    abi_ulong frame_addr;
+    unsigned long return_ip;
+    struct target_rt_sigframe *frame;
+    abi_ulong info_addr, uc_addr;
+
+    frame_addr = get_sigframe(ka, env, sizeof(*frame));
+    trace_user_setup_rt_frame(env, frame_addr);
+    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
+        goto give_sigsegv;
+    }
+
+    info_addr = frame_addr + offsetof(struct target_rt_sigframe, info);
+    __put_user(info_addr, &frame->pinfo);
+    uc_addr = frame_addr + offsetof(struct target_rt_sigframe, uc);
+    __put_user(uc_addr, &frame->puc);
+
+    if (ka->sa_flags & SA_SIGINFO) {
+        tswap_siginfo(&frame->info, info);
+    }
+
+    /*err |= __clear_user(&frame->uc, offsetof(ucontext_t, uc_mcontext));*/
+    __put_user(0, &frame->uc.tuc_flags);
+    __put_user(0, &frame->uc.tuc_link);
+    __put_user(target_sigaltstack_used.ss_sp,
+               &frame->uc.tuc_stack.ss_sp);
+    __put_user(sas_ss_flags(cpu_get_gpr(env, 1)),
+               &frame->uc.tuc_stack.ss_flags);
+    __put_user(target_sigaltstack_used.ss_size,
+               &frame->uc.tuc_stack.ss_size);
+    setup_sigcontext(&frame->sc, env, set->sig[0]);
+
+    /*err |= copy_to_user(frame->uc.tuc_sigmask, set, sizeof(*set));*/
+
+    /* trampoline - the desired return ip is the retcode itself */
+    return_ip = (unsigned long)&frame->retcode;
+    /* This is l.ori r11,r0,__NR_sigreturn, l.sys 1 */
+    __put_user(0xa960, (short *)(frame->retcode + 0));
+    __put_user(TARGET_NR_rt_sigreturn, (short *)(frame->retcode + 2));
+    __put_user(0x20000001, (unsigned long *)(frame->retcode + 4));
+    __put_user(0x15000000, (unsigned long *)(frame->retcode + 8));
+
+    if (err) {
+        goto give_sigsegv;
+    }
+
+    /* TODO what is the current->exec_domain stuff and invmap ? */
+
+    /* Set up registers for signal handler */
+    env->pc = (unsigned long)ka->_sa_handler; /* what we enter NOW */
+    cpu_set_gpr(env, 9, (unsigned long)return_ip);     /* what we enter LATER */
+    cpu_set_gpr(env, 3, (unsigned long)sig);           /* arg 1: signo */
+    cpu_set_gpr(env, 4, (unsigned long)&frame->info);  /* arg 2: (siginfo_t*) */
+    cpu_set_gpr(env, 5, (unsigned long)&frame->uc);    /* arg 3: ucontext */
+
+    /* actually move the usp to reflect the stacked frame */
+    cpu_set_gpr(env, 1, (unsigned long)frame);
+
+    return;
+
+give_sigsegv:
+    unlock_user_struct(frame, frame_addr, 1);
+    force_sigsegv(sig);
+}
+
+long do_sigreturn(CPUOpenRISCState *env)
+{
+    trace_user_do_sigreturn(env, 0);
+    fprintf(stderr, "do_sigreturn: not implemented\n");
+    return -TARGET_ENOSYS;
+}
+
+long do_rt_sigreturn(CPUOpenRISCState *env)
+{
+    trace_user_do_rt_sigreturn(env, 0);
+    fprintf(stderr, "do_rt_sigreturn: not implemented\n");
+    return -TARGET_ENOSYS;
+}
diff --git a/linux-user/openrisc/target_signal.h b/linux-user/openrisc/target_signal.h
index 95a733e15a..6c47ddf74e 100644
--- a/linux-user/openrisc/target_signal.h
+++ b/linux-user/openrisc/target_signal.h
@@ -23,5 +23,7 @@ static inline abi_ulong get_sp_from_cpustate(CPUOpenRISCState *state)
     return cpu_get_gpr(state, 1);
 }
 
-
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                    target_sigset_t *set, CPUOpenRISCState *env);
 #endif /* OPENRISC_TARGET_SIGNAL_H */
diff --git a/linux-user/signal.c b/linux-user/signal.c
index a4d19fcac7..f4f6e69788 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -2364,217 +2364,6 @@ badframe:
     return -TARGET_QEMU_ESIGRETURN;
 }
 
-#elif defined(TARGET_OPENRISC)
-
-struct target_sigcontext {
-    struct target_pt_regs regs;
-    abi_ulong oldmask;
-    abi_ulong usp;
-};
-
-struct target_ucontext {
-    abi_ulong tuc_flags;
-    abi_ulong tuc_link;
-    target_stack_t tuc_stack;
-    struct target_sigcontext tuc_mcontext;
-    target_sigset_t tuc_sigmask;   /* mask last for extensibility */
-};
-
-struct target_rt_sigframe {
-    abi_ulong pinfo;
-    uint64_t puc;
-    struct target_siginfo info;
-    struct target_sigcontext sc;
-    struct target_ucontext uc;
-    unsigned char retcode[16];  /* trampoline code */
-};
-
-/* This is the asm-generic/ucontext.h version */
-#if 0
-static int restore_sigcontext(CPUOpenRISCState *regs,
-                              struct target_sigcontext *sc)
-{
-    unsigned int err = 0;
-    unsigned long old_usp;
-
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
-    }
-
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
-}
-#endif
-
-/* Set up a signal frame.  */
-
-static void setup_sigcontext(struct target_sigcontext *sc,
-                             CPUOpenRISCState *regs,
-                             unsigned long mask)
-{
-    unsigned long usp = cpu_get_gpr(regs, 1);
-
-    /* copy the regs. they are first in sc so we can use sc directly */
-
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
-}
-
-static inline unsigned long align_sigframe(unsigned long sp)
-{
-    return sp & ~3UL;
-}
-
-static inline abi_ulong get_sigframe(struct target_sigaction *ka,
-                                     CPUOpenRISCState *regs,
-                                     size_t frame_size)
-{
-    unsigned long sp = cpu_get_gpr(regs, 1);
-    int onsigstack = on_sig_stack(sp);
-
-    /* redzone */
-    /* This is the X/Open sanctioned signal stack switching.  */
-    if ((ka->sa_flags & TARGET_SA_ONSTACK) != 0 && !onsigstack) {
-        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-    }
-
-    sp = align_sigframe(sp - frame_size);
-
-    /*
-     * If we are on the alternate signal stack and would overflow it, don't.
-     * Return an always-bogus address instead so we will die with SIGSEGV.
-     */
-
-    if (onsigstack && !likely(on_sig_stack(sp))) {
-        return -1L;
-    }
-
-    return sp;
-}
-
-static void setup_rt_frame(int sig, struct target_sigaction *ka,
-                           target_siginfo_t *info,
-                           target_sigset_t *set, CPUOpenRISCState *env)
-{
-    int err = 0;
-    abi_ulong frame_addr;
-    unsigned long return_ip;
-    struct target_rt_sigframe *frame;
-    abi_ulong info_addr, uc_addr;
-
-    frame_addr = get_sigframe(ka, env, sizeof(*frame));
-    trace_user_setup_rt_frame(env, frame_addr);
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
-        goto give_sigsegv;
-    }
-
-    info_addr = frame_addr + offsetof(struct target_rt_sigframe, info);
-    __put_user(info_addr, &frame->pinfo);
-    uc_addr = frame_addr + offsetof(struct target_rt_sigframe, uc);
-    __put_user(uc_addr, &frame->puc);
-
-    if (ka->sa_flags & SA_SIGINFO) {
-        tswap_siginfo(&frame->info, info);
-    }
-
-    /*err |= __clear_user(&frame->uc, offsetof(ucontext_t, uc_mcontext));*/
-    __put_user(0, &frame->uc.tuc_flags);
-    __put_user(0, &frame->uc.tuc_link);
-    __put_user(target_sigaltstack_used.ss_sp,
-               &frame->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(cpu_get_gpr(env, 1)),
-               &frame->uc.tuc_stack.ss_flags);
-    __put_user(target_sigaltstack_used.ss_size,
-               &frame->uc.tuc_stack.ss_size);
-    setup_sigcontext(&frame->sc, env, set->sig[0]);
-
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
-
-    /* Set up registers for signal handler */
-    env->pc = (unsigned long)ka->_sa_handler; /* what we enter NOW */
-    cpu_set_gpr(env, 9, (unsigned long)return_ip);     /* what we enter LATER */
-    cpu_set_gpr(env, 3, (unsigned long)sig);           /* arg 1: signo */
-    cpu_set_gpr(env, 4, (unsigned long)&frame->info);  /* arg 2: (siginfo_t*) */
-    cpu_set_gpr(env, 5, (unsigned long)&frame->uc);    /* arg 3: ucontext */
-
-    /* actually move the usp to reflect the stacked frame */
-    cpu_set_gpr(env, 1, (unsigned long)frame);
-
-    return;
-
-give_sigsegv:
-    unlock_user_struct(frame, frame_addr, 1);
-    force_sigsegv(sig);
-}
-
-long do_sigreturn(CPUOpenRISCState *env)
-{
-    trace_user_do_sigreturn(env, 0);
-    fprintf(stderr, "do_sigreturn: not implemented\n");
-    return -TARGET_ENOSYS;
-}
-
-long do_rt_sigreturn(CPUOpenRISCState *env)
-{
-    trace_user_do_rt_sigreturn(env, 0);
-    fprintf(stderr, "do_rt_sigreturn: not implemented\n");
-    return -TARGET_ENOSYS;
-}
-/* TARGET_OPENRISC */
-
 #elif defined(TARGET_S390X)
 
 #define __NUM_GPRS 16
-- 
2.14.3
