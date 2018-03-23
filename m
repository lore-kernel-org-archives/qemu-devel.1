Received: from eggs.gnu.org ([2001:4830:134:3::10]:45333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdY-0004jq-P1
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdW-0000b2-10
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:16 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 23 Mar 2018 23:57:23 +0100
Message-Id: <20180323225739.17329-5-laurent@vivier.eu>
In-Reply-To: <20180323225739.17329-1-laurent@vivier.eu>
References: <20180323225739.17329-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 v2 04/20] linux-user: move sh4
 signal.c parts to sh4 directory
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
sh4/signal.c, except adding includes and
exporting setup_frame() and setup_rt_frame().

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/sh4/signal.c        | 332 +++++++++++++++++++++++++++++++++++++++++
 linux-user/sh4/target_signal.h |   5 +
 linux-user/signal.c            | 328 ----------------------------------------
 3 files changed, 337 insertions(+), 328 deletions(-)

diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index 02ca338b6c..3a978a2a77 100644
--- a/linux-user/sh4/signal.c
+++ b/linux-user/sh4/signal.c
@@ -16,3 +16,335 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "target_signal.h"
+#include "signal-common.h"
+#include "linux-user/trace.h"
+
+/*
+ * code and data structures from linux kernel:
+ * include/asm-sh/sigcontext.h
+ * arch/sh/kernel/signal.c
+ */
+
+struct target_sigcontext {
+    target_ulong  oldmask;
+
+    /* CPU registers */
+    target_ulong  sc_gregs[16];
+    target_ulong  sc_pc;
+    target_ulong  sc_pr;
+    target_ulong  sc_sr;
+    target_ulong  sc_gbr;
+    target_ulong  sc_mach;
+    target_ulong  sc_macl;
+
+    /* FPU registers */
+    target_ulong  sc_fpregs[16];
+    target_ulong  sc_xfpregs[16];
+    unsigned int sc_fpscr;
+    unsigned int sc_fpul;
+    unsigned int sc_ownedfp;
+};
+
+struct target_sigframe
+{
+    struct target_sigcontext sc;
+    target_ulong extramask[TARGET_NSIG_WORDS-1];
+    uint16_t retcode[3];
+};
+
+
+struct target_ucontext {
+    target_ulong tuc_flags;
+    struct target_ucontext *tuc_link;
+    target_stack_t tuc_stack;
+    struct target_sigcontext tuc_mcontext;
+    target_sigset_t tuc_sigmask;	/* mask last for extensibility */
+};
+
+struct target_rt_sigframe
+{
+    struct target_siginfo info;
+    struct target_ucontext uc;
+    uint16_t retcode[3];
+};
+
+
+#define MOVW(n)  (0x9300|((n)-2)) /* Move mem word at PC+n to R3 */
+#define TRAP_NOARG 0xc310         /* Syscall w/no args (NR in R3) SH3/4 */
+
+static abi_ulong get_sigframe(struct target_sigaction *ka,
+                              unsigned long sp, size_t frame_size)
+{
+    if ((ka->sa_flags & TARGET_SA_ONSTACK) && (sas_ss_flags(sp) == 0)) {
+        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
+    }
+
+    return (sp - frame_size) & -8ul;
+}
+
+/* Notice when we're in the middle of a gUSA region and reset.
+   Note that this will only occur for !parallel_cpus, as we will
+   translate such sequences differently in a parallel context.  */
+static void unwind_gusa(CPUSH4State *regs)
+{
+    /* If the stack pointer is sufficiently negative, and we haven't
+       completed the sequence, then reset to the entry to the region.  */
+    /* ??? The SH4 kernel checks for and address above 0xC0000000.
+       However, the page mappings in qemu linux-user aren't as restricted
+       and we wind up with the normal stack mapped above 0xF0000000.
+       That said, there is no reason why the kernel should be allowing
+       a gUSA region that spans 1GB.  Use a tighter check here, for what
+       can actually be enabled by the immediate move.  */
+    if (regs->gregs[15] >= -128u && regs->pc < regs->gregs[0]) {
+        /* Reset the PC to before the gUSA region, as computed from
+           R0 = region end, SP = -(region size), plus one more for the
+           insn that actually initializes SP to the region size.  */
+        regs->pc = regs->gregs[0] + regs->gregs[15] - 2;
+
+        /* Reset the SP to the saved version in R1.  */
+        regs->gregs[15] = regs->gregs[1];
+    }
+}
+
+static void setup_sigcontext(struct target_sigcontext *sc,
+                             CPUSH4State *regs, unsigned long mask)
+{
+    int i;
+
+#define COPY(x)         __put_user(regs->x, &sc->sc_##x)
+    COPY(gregs[0]); COPY(gregs[1]);
+    COPY(gregs[2]); COPY(gregs[3]);
+    COPY(gregs[4]); COPY(gregs[5]);
+    COPY(gregs[6]); COPY(gregs[7]);
+    COPY(gregs[8]); COPY(gregs[9]);
+    COPY(gregs[10]); COPY(gregs[11]);
+    COPY(gregs[12]); COPY(gregs[13]);
+    COPY(gregs[14]); COPY(gregs[15]);
+    COPY(gbr); COPY(mach);
+    COPY(macl); COPY(pr);
+    COPY(sr); COPY(pc);
+#undef COPY
+
+    for (i=0; i<16; i++) {
+        __put_user(regs->fregs[i], &sc->sc_fpregs[i]);
+    }
+    __put_user(regs->fpscr, &sc->sc_fpscr);
+    __put_user(regs->fpul, &sc->sc_fpul);
+
+    /* non-iBCS2 extensions.. */
+    __put_user(mask, &sc->oldmask);
+}
+
+static void restore_sigcontext(CPUSH4State *regs, struct target_sigcontext *sc)
+{
+    int i;
+
+#define COPY(x)         __get_user(regs->x, &sc->sc_##x)
+    COPY(gregs[0]); COPY(gregs[1]);
+    COPY(gregs[2]); COPY(gregs[3]);
+    COPY(gregs[4]); COPY(gregs[5]);
+    COPY(gregs[6]); COPY(gregs[7]);
+    COPY(gregs[8]); COPY(gregs[9]);
+    COPY(gregs[10]); COPY(gregs[11]);
+    COPY(gregs[12]); COPY(gregs[13]);
+    COPY(gregs[14]); COPY(gregs[15]);
+    COPY(gbr); COPY(mach);
+    COPY(macl); COPY(pr);
+    COPY(sr); COPY(pc);
+#undef COPY
+
+    for (i=0; i<16; i++) {
+        __get_user(regs->fregs[i], &sc->sc_fpregs[i]);
+    }
+    __get_user(regs->fpscr, &sc->sc_fpscr);
+    __get_user(regs->fpul, &sc->sc_fpul);
+
+    regs->tra = -1;         /* disable syscall checks */
+    regs->flags &= ~(DELAY_SLOT_MASK | GUSA_MASK);
+}
+
+void setup_frame(int sig, struct target_sigaction *ka,
+                 target_sigset_t *set, CPUSH4State *regs)
+{
+    struct target_sigframe *frame;
+    abi_ulong frame_addr;
+    int i;
+
+    unwind_gusa(regs);
+
+    frame_addr = get_sigframe(ka, regs->gregs[15], sizeof(*frame));
+    trace_user_setup_frame(regs, frame_addr);
+    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
+        goto give_sigsegv;
+    }
+
+    setup_sigcontext(&frame->sc, regs, set->sig[0]);
+
+    for (i = 0; i < TARGET_NSIG_WORDS - 1; i++) {
+        __put_user(set->sig[i + 1], &frame->extramask[i]);
+    }
+
+    /* Set up to return from userspace.  If provided, use a stub
+       already in userspace.  */
+    if (ka->sa_flags & TARGET_SA_RESTORER) {
+        regs->pr = (unsigned long) ka->sa_restorer;
+    } else {
+        /* Generate return code (system call to sigreturn) */
+        abi_ulong retcode_addr = frame_addr +
+                                 offsetof(struct target_sigframe, retcode);
+        __put_user(MOVW(2), &frame->retcode[0]);
+        __put_user(TRAP_NOARG, &frame->retcode[1]);
+        __put_user((TARGET_NR_sigreturn), &frame->retcode[2]);
+        regs->pr = (unsigned long) retcode_addr;
+    }
+
+    /* Set up registers for signal handler */
+    regs->gregs[15] = frame_addr;
+    regs->gregs[4] = sig; /* Arg for signal handler */
+    regs->gregs[5] = 0;
+    regs->gregs[6] = frame_addr += offsetof(typeof(*frame), sc);
+    regs->pc = (unsigned long) ka->_sa_handler;
+    regs->flags &= ~(DELAY_SLOT_MASK | GUSA_MASK);
+
+    unlock_user_struct(frame, frame_addr, 1);
+    return;
+
+give_sigsegv:
+    unlock_user_struct(frame, frame_addr, 1);
+    force_sigsegv(sig);
+}
+
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                    target_sigset_t *set, CPUSH4State *regs)
+{
+    struct target_rt_sigframe *frame;
+    abi_ulong frame_addr;
+    int i;
+
+    unwind_gusa(regs);
+
+    frame_addr = get_sigframe(ka, regs->gregs[15], sizeof(*frame));
+    trace_user_setup_rt_frame(regs, frame_addr);
+    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
+        goto give_sigsegv;
+    }
+
+    tswap_siginfo(&frame->info, info);
+
+    /* Create the ucontext.  */
+    __put_user(0, &frame->uc.tuc_flags);
+    __put_user(0, (unsigned long *)&frame->uc.tuc_link);
+    __put_user((unsigned long)target_sigaltstack_used.ss_sp,
+               &frame->uc.tuc_stack.ss_sp);
+    __put_user(sas_ss_flags(regs->gregs[15]),
+               &frame->uc.tuc_stack.ss_flags);
+    __put_user(target_sigaltstack_used.ss_size,
+               &frame->uc.tuc_stack.ss_size);
+    setup_sigcontext(&frame->uc.tuc_mcontext,
+                     regs, set->sig[0]);
+    for(i = 0; i < TARGET_NSIG_WORDS; i++) {
+        __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
+    }
+
+    /* Set up to return from userspace.  If provided, use a stub
+       already in userspace.  */
+    if (ka->sa_flags & TARGET_SA_RESTORER) {
+        regs->pr = (unsigned long) ka->sa_restorer;
+    } else {
+        /* Generate return code (system call to sigreturn) */
+        abi_ulong retcode_addr = frame_addr +
+                                 offsetof(struct target_rt_sigframe, retcode);
+        __put_user(MOVW(2), &frame->retcode[0]);
+        __put_user(TRAP_NOARG, &frame->retcode[1]);
+        __put_user((TARGET_NR_rt_sigreturn), &frame->retcode[2]);
+        regs->pr = (unsigned long) retcode_addr;
+    }
+
+    /* Set up registers for signal handler */
+    regs->gregs[15] = frame_addr;
+    regs->gregs[4] = sig; /* Arg for signal handler */
+    regs->gregs[5] = frame_addr + offsetof(typeof(*frame), info);
+    regs->gregs[6] = frame_addr + offsetof(typeof(*frame), uc);
+    regs->pc = (unsigned long) ka->_sa_handler;
+    regs->flags &= ~(DELAY_SLOT_MASK | GUSA_MASK);
+
+    unlock_user_struct(frame, frame_addr, 1);
+    return;
+
+give_sigsegv:
+    unlock_user_struct(frame, frame_addr, 1);
+    force_sigsegv(sig);
+}
+
+long do_sigreturn(CPUSH4State *regs)
+{
+    struct target_sigframe *frame;
+    abi_ulong frame_addr;
+    sigset_t blocked;
+    target_sigset_t target_set;
+    int i;
+    int err = 0;
+
+    frame_addr = regs->gregs[15];
+    trace_user_do_sigreturn(regs, frame_addr);
+    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
+        goto badframe;
+    }
+
+    __get_user(target_set.sig[0], &frame->sc.oldmask);
+    for(i = 1; i < TARGET_NSIG_WORDS; i++) {
+        __get_user(target_set.sig[i], &frame->extramask[i - 1]);
+    }
+
+    if (err)
+        goto badframe;
+
+    target_to_host_sigset_internal(&blocked, &target_set);
+    set_sigmask(&blocked);
+
+    restore_sigcontext(regs, &frame->sc);
+
+    unlock_user_struct(frame, frame_addr, 0);
+    return -TARGET_QEMU_ESIGRETURN;
+
+badframe:
+    unlock_user_struct(frame, frame_addr, 0);
+    force_sig(TARGET_SIGSEGV);
+    return -TARGET_QEMU_ESIGRETURN;
+}
+
+long do_rt_sigreturn(CPUSH4State *regs)
+{
+    struct target_rt_sigframe *frame;
+    abi_ulong frame_addr;
+    sigset_t blocked;
+
+    frame_addr = regs->gregs[15];
+    trace_user_do_rt_sigreturn(regs, frame_addr);
+    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
+        goto badframe;
+    }
+
+    target_to_host_sigset(&blocked, &frame->uc.tuc_sigmask);
+    set_sigmask(&blocked);
+
+    restore_sigcontext(regs, &frame->uc.tuc_mcontext);
+
+    if (do_sigaltstack(frame_addr +
+                       offsetof(struct target_rt_sigframe, uc.tuc_stack),
+                       0, get_sp_from_cpustate(regs)) == -EFAULT) {
+        goto badframe;
+    }
+
+    unlock_user_struct(frame, frame_addr, 0);
+    return -TARGET_QEMU_ESIGRETURN;
+
+badframe:
+    unlock_user_struct(frame, frame_addr, 0);
+    force_sig(TARGET_SIGSEGV);
+    return -TARGET_QEMU_ESIGRETURN;
+}
diff --git a/linux-user/sh4/target_signal.h b/linux-user/sh4/target_signal.h
index cbf23b6a31..a2a93fa04a 100644
--- a/linux-user/sh4/target_signal.h
+++ b/linux-user/sh4/target_signal.h
@@ -26,5 +26,10 @@ static inline abi_ulong get_sp_from_cpustate(CPUSH4State *state)
     return state->gregs[15];
 }
 
+void setup_frame(int sig, struct target_sigaction *ka,
+                 target_sigset_t *set, CPUSH4State *regs);
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                    target_sigset_t *set, CPUSH4State *regs);
 
 #endif /* SH4_TARGET_SIGNAL_H */
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 38ebba9cf6..1302d2c716 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -2364,334 +2364,6 @@ badframe:
     return -TARGET_QEMU_ESIGRETURN;
 }
 
-#elif defined(TARGET_SH4)
-
-/*
- * code and data structures from linux kernel:
- * include/asm-sh/sigcontext.h
- * arch/sh/kernel/signal.c
- */
-
-struct target_sigcontext {
-    target_ulong  oldmask;
-
-    /* CPU registers */
-    target_ulong  sc_gregs[16];
-    target_ulong  sc_pc;
-    target_ulong  sc_pr;
-    target_ulong  sc_sr;
-    target_ulong  sc_gbr;
-    target_ulong  sc_mach;
-    target_ulong  sc_macl;
-
-    /* FPU registers */
-    target_ulong  sc_fpregs[16];
-    target_ulong  sc_xfpregs[16];
-    unsigned int sc_fpscr;
-    unsigned int sc_fpul;
-    unsigned int sc_ownedfp;
-};
-
-struct target_sigframe
-{
-    struct target_sigcontext sc;
-    target_ulong extramask[TARGET_NSIG_WORDS-1];
-    uint16_t retcode[3];
-};
-
-
-struct target_ucontext {
-    target_ulong tuc_flags;
-    struct target_ucontext *tuc_link;
-    target_stack_t tuc_stack;
-    struct target_sigcontext tuc_mcontext;
-    target_sigset_t tuc_sigmask;	/* mask last for extensibility */
-};
-
-struct target_rt_sigframe
-{
-    struct target_siginfo info;
-    struct target_ucontext uc;
-    uint16_t retcode[3];
-};
-
-
-#define MOVW(n)  (0x9300|((n)-2)) /* Move mem word at PC+n to R3 */
-#define TRAP_NOARG 0xc310         /* Syscall w/no args (NR in R3) SH3/4 */
-
-static abi_ulong get_sigframe(struct target_sigaction *ka,
-                              unsigned long sp, size_t frame_size)
-{
-    if ((ka->sa_flags & TARGET_SA_ONSTACK) && (sas_ss_flags(sp) == 0)) {
-        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-    }
-
-    return (sp - frame_size) & -8ul;
-}
-
-/* Notice when we're in the middle of a gUSA region and reset.
-   Note that this will only occur for !parallel_cpus, as we will
-   translate such sequences differently in a parallel context.  */
-static void unwind_gusa(CPUSH4State *regs)
-{
-    /* If the stack pointer is sufficiently negative, and we haven't
-       completed the sequence, then reset to the entry to the region.  */
-    /* ??? The SH4 kernel checks for and address above 0xC0000000.
-       However, the page mappings in qemu linux-user aren't as restricted
-       and we wind up with the normal stack mapped above 0xF0000000.
-       That said, there is no reason why the kernel should be allowing
-       a gUSA region that spans 1GB.  Use a tighter check here, for what
-       can actually be enabled by the immediate move.  */
-    if (regs->gregs[15] >= -128u && regs->pc < regs->gregs[0]) {
-        /* Reset the PC to before the gUSA region, as computed from
-           R0 = region end, SP = -(region size), plus one more for the
-           insn that actually initializes SP to the region size.  */
-        regs->pc = regs->gregs[0] + regs->gregs[15] - 2;
-
-        /* Reset the SP to the saved version in R1.  */
-        regs->gregs[15] = regs->gregs[1];
-    }
-}
-
-static void setup_sigcontext(struct target_sigcontext *sc,
-                             CPUSH4State *regs, unsigned long mask)
-{
-    int i;
-
-#define COPY(x)         __put_user(regs->x, &sc->sc_##x)
-    COPY(gregs[0]); COPY(gregs[1]);
-    COPY(gregs[2]); COPY(gregs[3]);
-    COPY(gregs[4]); COPY(gregs[5]);
-    COPY(gregs[6]); COPY(gregs[7]);
-    COPY(gregs[8]); COPY(gregs[9]);
-    COPY(gregs[10]); COPY(gregs[11]);
-    COPY(gregs[12]); COPY(gregs[13]);
-    COPY(gregs[14]); COPY(gregs[15]);
-    COPY(gbr); COPY(mach);
-    COPY(macl); COPY(pr);
-    COPY(sr); COPY(pc);
-#undef COPY
-
-    for (i=0; i<16; i++) {
-        __put_user(regs->fregs[i], &sc->sc_fpregs[i]);
-    }
-    __put_user(regs->fpscr, &sc->sc_fpscr);
-    __put_user(regs->fpul, &sc->sc_fpul);
-
-    /* non-iBCS2 extensions.. */
-    __put_user(mask, &sc->oldmask);
-}
-
-static void restore_sigcontext(CPUSH4State *regs, struct target_sigcontext *sc)
-{
-    int i;
-
-#define COPY(x)         __get_user(regs->x, &sc->sc_##x)
-    COPY(gregs[0]); COPY(gregs[1]);
-    COPY(gregs[2]); COPY(gregs[3]);
-    COPY(gregs[4]); COPY(gregs[5]);
-    COPY(gregs[6]); COPY(gregs[7]);
-    COPY(gregs[8]); COPY(gregs[9]);
-    COPY(gregs[10]); COPY(gregs[11]);
-    COPY(gregs[12]); COPY(gregs[13]);
-    COPY(gregs[14]); COPY(gregs[15]);
-    COPY(gbr); COPY(mach);
-    COPY(macl); COPY(pr);
-    COPY(sr); COPY(pc);
-#undef COPY
-
-    for (i=0; i<16; i++) {
-        __get_user(regs->fregs[i], &sc->sc_fpregs[i]);
-    }
-    __get_user(regs->fpscr, &sc->sc_fpscr);
-    __get_user(regs->fpul, &sc->sc_fpul);
-
-    regs->tra = -1;         /* disable syscall checks */
-    regs->flags &= ~(DELAY_SLOT_MASK | GUSA_MASK);
-}
-
-static void setup_frame(int sig, struct target_sigaction *ka,
-                        target_sigset_t *set, CPUSH4State *regs)
-{
-    struct target_sigframe *frame;
-    abi_ulong frame_addr;
-    int i;
-
-    unwind_gusa(regs);
-
-    frame_addr = get_sigframe(ka, regs->gregs[15], sizeof(*frame));
-    trace_user_setup_frame(regs, frame_addr);
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
-        goto give_sigsegv;
-    }
-
-    setup_sigcontext(&frame->sc, regs, set->sig[0]);
-
-    for (i = 0; i < TARGET_NSIG_WORDS - 1; i++) {
-        __put_user(set->sig[i + 1], &frame->extramask[i]);
-    }
-
-    /* Set up to return from userspace.  If provided, use a stub
-       already in userspace.  */
-    if (ka->sa_flags & TARGET_SA_RESTORER) {
-        regs->pr = (unsigned long) ka->sa_restorer;
-    } else {
-        /* Generate return code (system call to sigreturn) */
-        abi_ulong retcode_addr = frame_addr +
-                                 offsetof(struct target_sigframe, retcode);
-        __put_user(MOVW(2), &frame->retcode[0]);
-        __put_user(TRAP_NOARG, &frame->retcode[1]);
-        __put_user((TARGET_NR_sigreturn), &frame->retcode[2]);
-        regs->pr = (unsigned long) retcode_addr;
-    }
-
-    /* Set up registers for signal handler */
-    regs->gregs[15] = frame_addr;
-    regs->gregs[4] = sig; /* Arg for signal handler */
-    regs->gregs[5] = 0;
-    regs->gregs[6] = frame_addr += offsetof(typeof(*frame), sc);
-    regs->pc = (unsigned long) ka->_sa_handler;
-    regs->flags &= ~(DELAY_SLOT_MASK | GUSA_MASK);
-
-    unlock_user_struct(frame, frame_addr, 1);
-    return;
-
-give_sigsegv:
-    unlock_user_struct(frame, frame_addr, 1);
-    force_sigsegv(sig);
-}
-
-static void setup_rt_frame(int sig, struct target_sigaction *ka,
-                           target_siginfo_t *info,
-                           target_sigset_t *set, CPUSH4State *regs)
-{
-    struct target_rt_sigframe *frame;
-    abi_ulong frame_addr;
-    int i;
-
-    unwind_gusa(regs);
-
-    frame_addr = get_sigframe(ka, regs->gregs[15], sizeof(*frame));
-    trace_user_setup_rt_frame(regs, frame_addr);
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
-        goto give_sigsegv;
-    }
-
-    tswap_siginfo(&frame->info, info);
-
-    /* Create the ucontext.  */
-    __put_user(0, &frame->uc.tuc_flags);
-    __put_user(0, (unsigned long *)&frame->uc.tuc_link);
-    __put_user((unsigned long)target_sigaltstack_used.ss_sp,
-               &frame->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(regs->gregs[15]),
-               &frame->uc.tuc_stack.ss_flags);
-    __put_user(target_sigaltstack_used.ss_size,
-               &frame->uc.tuc_stack.ss_size);
-    setup_sigcontext(&frame->uc.tuc_mcontext,
-                     regs, set->sig[0]);
-    for(i = 0; i < TARGET_NSIG_WORDS; i++) {
-        __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
-    }
-
-    /* Set up to return from userspace.  If provided, use a stub
-       already in userspace.  */
-    if (ka->sa_flags & TARGET_SA_RESTORER) {
-        regs->pr = (unsigned long) ka->sa_restorer;
-    } else {
-        /* Generate return code (system call to sigreturn) */
-        abi_ulong retcode_addr = frame_addr +
-                                 offsetof(struct target_rt_sigframe, retcode);
-        __put_user(MOVW(2), &frame->retcode[0]);
-        __put_user(TRAP_NOARG, &frame->retcode[1]);
-        __put_user((TARGET_NR_rt_sigreturn), &frame->retcode[2]);
-        regs->pr = (unsigned long) retcode_addr;
-    }
-
-    /* Set up registers for signal handler */
-    regs->gregs[15] = frame_addr;
-    regs->gregs[4] = sig; /* Arg for signal handler */
-    regs->gregs[5] = frame_addr + offsetof(typeof(*frame), info);
-    regs->gregs[6] = frame_addr + offsetof(typeof(*frame), uc);
-    regs->pc = (unsigned long) ka->_sa_handler;
-    regs->flags &= ~(DELAY_SLOT_MASK | GUSA_MASK);
-
-    unlock_user_struct(frame, frame_addr, 1);
-    return;
-
-give_sigsegv:
-    unlock_user_struct(frame, frame_addr, 1);
-    force_sigsegv(sig);
-}
-
-long do_sigreturn(CPUSH4State *regs)
-{
-    struct target_sigframe *frame;
-    abi_ulong frame_addr;
-    sigset_t blocked;
-    target_sigset_t target_set;
-    int i;
-    int err = 0;
-
-    frame_addr = regs->gregs[15];
-    trace_user_do_sigreturn(regs, frame_addr);
-    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
-        goto badframe;
-    }
-
-    __get_user(target_set.sig[0], &frame->sc.oldmask);
-    for(i = 1; i < TARGET_NSIG_WORDS; i++) {
-        __get_user(target_set.sig[i], &frame->extramask[i - 1]);
-    }
-
-    if (err)
-        goto badframe;
-
-    target_to_host_sigset_internal(&blocked, &target_set);
-    set_sigmask(&blocked);
-
-    restore_sigcontext(regs, &frame->sc);
-
-    unlock_user_struct(frame, frame_addr, 0);
-    return -TARGET_QEMU_ESIGRETURN;
-
-badframe:
-    unlock_user_struct(frame, frame_addr, 0);
-    force_sig(TARGET_SIGSEGV);
-    return -TARGET_QEMU_ESIGRETURN;
-}
-
-long do_rt_sigreturn(CPUSH4State *regs)
-{
-    struct target_rt_sigframe *frame;
-    abi_ulong frame_addr;
-    sigset_t blocked;
-
-    frame_addr = regs->gregs[15];
-    trace_user_do_rt_sigreturn(regs, frame_addr);
-    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
-        goto badframe;
-    }
-
-    target_to_host_sigset(&blocked, &frame->uc.tuc_sigmask);
-    set_sigmask(&blocked);
-
-    restore_sigcontext(regs, &frame->uc.tuc_mcontext);
-
-    if (do_sigaltstack(frame_addr +
-                       offsetof(struct target_rt_sigframe, uc.tuc_stack),
-                       0, get_sp_from_cpustate(regs)) == -EFAULT) {
-        goto badframe;
-    }
-
-    unlock_user_struct(frame, frame_addr, 0);
-    return -TARGET_QEMU_ESIGRETURN;
-
-badframe:
-    unlock_user_struct(frame, frame_addr, 0);
-    force_sig(TARGET_SIGSEGV);
-    return -TARGET_QEMU_ESIGRETURN;
-}
 #elif defined(TARGET_MICROBLAZE)
 
 struct target_sigcontext {
-- 
2.14.3
