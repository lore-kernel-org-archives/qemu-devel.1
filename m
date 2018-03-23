Received: from eggs.gnu.org ([2001:4830:134:3::10]:45439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdg-0004pE-Vb
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdd-0000iX-JY
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:25 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 23 Mar 2018 23:57:31 +0100
Message-Id: <20180323225739.17329-13-laurent@vivier.eu>
In-Reply-To: <20180323225739.17329-1-laurent@vivier.eu>
References: <20180323225739.17329-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 v2 12/20] linux-user: move tilegx
 signal.c parts to tilegx directory
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
tilegx/signal.c, except adding includes and
exporting setup_rt_frame().

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/signal.c               | 165 -------------------------------------
 linux-user/tilegx/signal.c        | 168 ++++++++++++++++++++++++++++++++++++++
 linux-user/tilegx/target_signal.h |   4 +-
 3 files changed, 171 insertions(+), 166 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index dab405fb43..5f05683b30 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -3032,171 +3032,6 @@ sigsegv:
     return -TARGET_QEMU_ESIGRETURN;
 }
 
-#elif defined(TARGET_TILEGX)
-
-struct target_sigcontext {
-    union {
-        /* General-purpose registers.  */
-        abi_ulong gregs[56];
-        struct {
-            abi_ulong __gregs[53];
-            abi_ulong tp;        /* Aliases gregs[TREG_TP].  */
-            abi_ulong sp;        /* Aliases gregs[TREG_SP].  */
-            abi_ulong lr;        /* Aliases gregs[TREG_LR].  */
-        };
-    };
-    abi_ulong pc;        /* Program counter.  */
-    abi_ulong ics;       /* In Interrupt Critical Section?  */
-    abi_ulong faultnum;  /* Fault number.  */
-    abi_ulong pad[5];
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
-    unsigned char save_area[16]; /* caller save area */
-    struct target_siginfo info;
-    struct target_ucontext uc;
-    abi_ulong retcode[2];
-};
-
-#define INSN_MOVELI_R10_139  0x00045fe551483000ULL /* { moveli r10, 139 } */
-#define INSN_SWINT1          0x286b180051485000ULL /* { swint1 } */
-
-
-static void setup_sigcontext(struct target_sigcontext *sc,
-                             CPUArchState *env, int signo)
-{
-    int i;
-
-    for (i = 0; i < TILEGX_R_COUNT; ++i) {
-        __put_user(env->regs[i], &sc->gregs[i]);
-    }
-
-    __put_user(env->pc, &sc->pc);
-    __put_user(0, &sc->ics);
-    __put_user(signo, &sc->faultnum);
-}
-
-static void restore_sigcontext(CPUTLGState *env, struct target_sigcontext *sc)
-{
-    int i;
-
-    for (i = 0; i < TILEGX_R_COUNT; ++i) {
-        __get_user(env->regs[i], &sc->gregs[i]);
-    }
-
-    __get_user(env->pc, &sc->pc);
-}
-
-static abi_ulong get_sigframe(struct target_sigaction *ka, CPUArchState *env,
-                              size_t frame_size)
-{
-    unsigned long sp = env->regs[TILEGX_R_SP];
-
-    if (on_sig_stack(sp) && !likely(on_sig_stack(sp - frame_size))) {
-        return -1UL;
-    }
-
-    if ((ka->sa_flags & SA_ONSTACK) && !sas_ss_flags(sp)) {
-        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-    }
-
-    sp -= frame_size;
-    sp &= -16UL;
-    return sp;
-}
-
-static void setup_rt_frame(int sig, struct target_sigaction *ka,
-                           target_siginfo_t *info,
-                           target_sigset_t *set, CPUArchState *env)
-{
-    abi_ulong frame_addr;
-    struct target_rt_sigframe *frame;
-    unsigned long restorer;
-
-    frame_addr = get_sigframe(ka, env, sizeof(*frame));
-    trace_user_setup_rt_frame(env, frame_addr);
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
-        goto give_sigsegv;
-    }
-
-    /* Always write at least the signal number for the stack backtracer. */
-    if (ka->sa_flags & TARGET_SA_SIGINFO) {
-        /* At sigreturn time, restore the callee-save registers too. */
-        tswap_siginfo(&frame->info, info);
-        /* regs->flags |= PT_FLAGS_RESTORE_REGS; FIXME: we can skip it? */
-    } else {
-        __put_user(info->si_signo, &frame->info.si_signo);
-    }
-
-    /* Create the ucontext.  */
-    __put_user(0, &frame->uc.tuc_flags);
-    __put_user(0, &frame->uc.tuc_link);
-    __put_user(target_sigaltstack_used.ss_sp, &frame->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(env->regs[TILEGX_R_SP]),
-               &frame->uc.tuc_stack.ss_flags);
-    __put_user(target_sigaltstack_used.ss_size, &frame->uc.tuc_stack.ss_size);
-    setup_sigcontext(&frame->uc.tuc_mcontext, env, info->si_signo);
-
-    if (ka->sa_flags & TARGET_SA_RESTORER) {
-        restorer = (unsigned long) ka->sa_restorer;
-    } else {
-        __put_user(INSN_MOVELI_R10_139, &frame->retcode[0]);
-        __put_user(INSN_SWINT1, &frame->retcode[1]);
-        restorer = frame_addr + offsetof(struct target_rt_sigframe, retcode);
-    }
-    env->pc = (unsigned long) ka->_sa_handler;
-    env->regs[TILEGX_R_SP] = (unsigned long) frame;
-    env->regs[TILEGX_R_LR] = restorer;
-    env->regs[0] = (unsigned long) sig;
-    env->regs[1] = (unsigned long) &frame->info;
-    env->regs[2] = (unsigned long) &frame->uc;
-    /* regs->flags |= PT_FLAGS_CALLER_SAVES; FIXME: we can skip it? */
-
-    unlock_user_struct(frame, frame_addr, 1);
-    return;
-
-give_sigsegv:
-    force_sigsegv(sig);
-}
-
-long do_rt_sigreturn(CPUTLGState *env)
-{
-    abi_ulong frame_addr = env->regs[TILEGX_R_SP];
-    struct target_rt_sigframe *frame;
-    sigset_t set;
-
-    trace_user_do_rt_sigreturn(env, frame_addr);
-    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
-        goto badframe;
-    }
-    target_to_host_sigset(&set, &frame->uc.tuc_sigmask);
-    set_sigmask(&set);
-
-    restore_sigcontext(env, &frame->uc.tuc_mcontext);
-    if (do_sigaltstack(frame_addr + offsetof(struct target_rt_sigframe,
-                                             uc.tuc_stack),
-                       0, env->regs[TILEGX_R_SP]) == -EFAULT) {
-        goto badframe;
-    }
-
-    unlock_user_struct(frame, frame_addr, 0);
-    return -TARGET_QEMU_ESIGRETURN;
-
-
- badframe:
-    unlock_user_struct(frame, frame_addr, 0);
-    force_sig(TARGET_SIGSEGV);
-    return -TARGET_QEMU_ESIGRETURN;
-}
-
 #elif defined(TARGET_RISCV)
 
 /* Signal handler invocation must be transparent for the code being
diff --git a/linux-user/tilegx/signal.c b/linux-user/tilegx/signal.c
index 02ca338b6c..8f54f54f95 100644
--- a/linux-user/tilegx/signal.c
+++ b/linux-user/tilegx/signal.c
@@ -16,3 +16,171 @@
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
+    union {
+        /* General-purpose registers.  */
+        abi_ulong gregs[56];
+        struct {
+            abi_ulong __gregs[53];
+            abi_ulong tp;        /* Aliases gregs[TREG_TP].  */
+            abi_ulong sp;        /* Aliases gregs[TREG_SP].  */
+            abi_ulong lr;        /* Aliases gregs[TREG_LR].  */
+        };
+    };
+    abi_ulong pc;        /* Program counter.  */
+    abi_ulong ics;       /* In Interrupt Critical Section?  */
+    abi_ulong faultnum;  /* Fault number.  */
+    abi_ulong pad[5];
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
+    unsigned char save_area[16]; /* caller save area */
+    struct target_siginfo info;
+    struct target_ucontext uc;
+    abi_ulong retcode[2];
+};
+
+#define INSN_MOVELI_R10_139  0x00045fe551483000ULL /* { moveli r10, 139 } */
+#define INSN_SWINT1          0x286b180051485000ULL /* { swint1 } */
+
+
+static void setup_sigcontext(struct target_sigcontext *sc,
+                             CPUArchState *env, int signo)
+{
+    int i;
+
+    for (i = 0; i < TILEGX_R_COUNT; ++i) {
+        __put_user(env->regs[i], &sc->gregs[i]);
+    }
+
+    __put_user(env->pc, &sc->pc);
+    __put_user(0, &sc->ics);
+    __put_user(signo, &sc->faultnum);
+}
+
+static void restore_sigcontext(CPUTLGState *env, struct target_sigcontext *sc)
+{
+    int i;
+
+    for (i = 0; i < TILEGX_R_COUNT; ++i) {
+        __get_user(env->regs[i], &sc->gregs[i]);
+    }
+
+    __get_user(env->pc, &sc->pc);
+}
+
+static abi_ulong get_sigframe(struct target_sigaction *ka, CPUArchState *env,
+                              size_t frame_size)
+{
+    unsigned long sp = env->regs[TILEGX_R_SP];
+
+    if (on_sig_stack(sp) && !likely(on_sig_stack(sp - frame_size))) {
+        return -1UL;
+    }
+
+    if ((ka->sa_flags & SA_ONSTACK) && !sas_ss_flags(sp)) {
+        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
+    }
+
+    sp -= frame_size;
+    sp &= -16UL;
+    return sp;
+}
+
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                    target_sigset_t *set, CPUArchState *env)
+{
+    abi_ulong frame_addr;
+    struct target_rt_sigframe *frame;
+    unsigned long restorer;
+
+    frame_addr = get_sigframe(ka, env, sizeof(*frame));
+    trace_user_setup_rt_frame(env, frame_addr);
+    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
+        goto give_sigsegv;
+    }
+
+    /* Always write at least the signal number for the stack backtracer. */
+    if (ka->sa_flags & TARGET_SA_SIGINFO) {
+        /* At sigreturn time, restore the callee-save registers too. */
+        tswap_siginfo(&frame->info, info);
+        /* regs->flags |= PT_FLAGS_RESTORE_REGS; FIXME: we can skip it? */
+    } else {
+        __put_user(info->si_signo, &frame->info.si_signo);
+    }
+
+    /* Create the ucontext.  */
+    __put_user(0, &frame->uc.tuc_flags);
+    __put_user(0, &frame->uc.tuc_link);
+    __put_user(target_sigaltstack_used.ss_sp, &frame->uc.tuc_stack.ss_sp);
+    __put_user(sas_ss_flags(env->regs[TILEGX_R_SP]),
+               &frame->uc.tuc_stack.ss_flags);
+    __put_user(target_sigaltstack_used.ss_size, &frame->uc.tuc_stack.ss_size);
+    setup_sigcontext(&frame->uc.tuc_mcontext, env, info->si_signo);
+
+    if (ka->sa_flags & TARGET_SA_RESTORER) {
+        restorer = (unsigned long) ka->sa_restorer;
+    } else {
+        __put_user(INSN_MOVELI_R10_139, &frame->retcode[0]);
+        __put_user(INSN_SWINT1, &frame->retcode[1]);
+        restorer = frame_addr + offsetof(struct target_rt_sigframe, retcode);
+    }
+    env->pc = (unsigned long) ka->_sa_handler;
+    env->regs[TILEGX_R_SP] = (unsigned long) frame;
+    env->regs[TILEGX_R_LR] = restorer;
+    env->regs[0] = (unsigned long) sig;
+    env->regs[1] = (unsigned long) &frame->info;
+    env->regs[2] = (unsigned long) &frame->uc;
+    /* regs->flags |= PT_FLAGS_CALLER_SAVES; FIXME: we can skip it? */
+
+    unlock_user_struct(frame, frame_addr, 1);
+    return;
+
+give_sigsegv:
+    force_sigsegv(sig);
+}
+
+long do_rt_sigreturn(CPUTLGState *env)
+{
+    abi_ulong frame_addr = env->regs[TILEGX_R_SP];
+    struct target_rt_sigframe *frame;
+    sigset_t set;
+
+    trace_user_do_rt_sigreturn(env, frame_addr);
+    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
+        goto badframe;
+    }
+    target_to_host_sigset(&set, &frame->uc.tuc_sigmask);
+    set_sigmask(&set);
+
+    restore_sigcontext(env, &frame->uc.tuc_mcontext);
+    if (do_sigaltstack(frame_addr + offsetof(struct target_rt_sigframe,
+                                             uc.tuc_stack),
+                       0, env->regs[TILEGX_R_SP]) == -EFAULT) {
+        goto badframe;
+    }
+
+    unlock_user_struct(frame, frame_addr, 0);
+    return -TARGET_QEMU_ESIGRETURN;
+
+
+ badframe:
+    unlock_user_struct(frame, frame_addr, 0);
+    force_sig(TARGET_SIGSEGV);
+    return -TARGET_QEMU_ESIGRETURN;
+}
diff --git a/linux-user/tilegx/target_signal.h b/linux-user/tilegx/target_signal.h
index f64551a8cf..132d7781fe 100644
--- a/linux-user/tilegx/target_signal.h
+++ b/linux-user/tilegx/target_signal.h
@@ -25,5 +25,7 @@ static inline abi_ulong get_sp_from_cpustate(CPUTLGState *state)
     return state->regs[TILEGX_R_SP];
 }
 
-
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                    target_sigset_t *set, CPUArchState *env);
 #endif /* TILEGX_TARGET_SIGNAL_H */
-- 
2.14.3
