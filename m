Received: from eggs.gnu.org ([2001:4830:134:3::10]:45684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdu-0005Ac-MB
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdq-0000ua-65
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:38 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 23 Mar 2018 23:57:26 +0100
Message-Id: <20180323225739.17329-8-laurent@vivier.eu>
In-Reply-To: <20180323225739.17329-1-laurent@vivier.eu>
References: <20180323225739.17329-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 v2 07/20] linux-user: move nios2
 signal.c parts to nios2 directory
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
nios2/signal.c, except adding includes and
exporting setup_rt_frame().

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/nios2/signal.c        | 236 +++++++++++++++++++++++++++++++++++++++
 linux-user/nios2/target_signal.h |   4 +
 linux-user/signal.c              | 234 --------------------------------------
 3 files changed, 240 insertions(+), 234 deletions(-)

diff --git a/linux-user/nios2/signal.c b/linux-user/nios2/signal.c
index 02ca338b6c..816eed90f1 100644
--- a/linux-user/nios2/signal.c
+++ b/linux-user/nios2/signal.c
@@ -16,3 +16,239 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "target_signal.h"
+#include "signal-common.h"
+#include "linux-user/trace.h"
+
+#define MCONTEXT_VERSION 2
+
+struct target_sigcontext {
+    int version;
+    unsigned long gregs[32];
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
+    struct target_siginfo info;
+    struct target_ucontext uc;
+};
+
+static unsigned long sigsp(unsigned long sp, struct target_sigaction *ka)
+{
+    if (unlikely((ka->sa_flags & SA_ONSTACK)) && !sas_ss_flags(sp)) {
+#ifdef CONFIG_STACK_GROWSUP
+        return target_sigaltstack_used.ss_sp;
+#else
+        return target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
+#endif
+    }
+    return sp;
+}
+
+static int rt_setup_ucontext(struct target_ucontext *uc, CPUNios2State *env)
+{
+    unsigned long *gregs = uc->tuc_mcontext.gregs;
+
+    __put_user(MCONTEXT_VERSION, &uc->tuc_mcontext.version);
+    __put_user(env->regs[1], &gregs[0]);
+    __put_user(env->regs[2], &gregs[1]);
+    __put_user(env->regs[3], &gregs[2]);
+    __put_user(env->regs[4], &gregs[3]);
+    __put_user(env->regs[5], &gregs[4]);
+    __put_user(env->regs[6], &gregs[5]);
+    __put_user(env->regs[7], &gregs[6]);
+    __put_user(env->regs[8], &gregs[7]);
+    __put_user(env->regs[9], &gregs[8]);
+    __put_user(env->regs[10], &gregs[9]);
+    __put_user(env->regs[11], &gregs[10]);
+    __put_user(env->regs[12], &gregs[11]);
+    __put_user(env->regs[13], &gregs[12]);
+    __put_user(env->regs[14], &gregs[13]);
+    __put_user(env->regs[15], &gregs[14]);
+    __put_user(env->regs[16], &gregs[15]);
+    __put_user(env->regs[17], &gregs[16]);
+    __put_user(env->regs[18], &gregs[17]);
+    __put_user(env->regs[19], &gregs[18]);
+    __put_user(env->regs[20], &gregs[19]);
+    __put_user(env->regs[21], &gregs[20]);
+    __put_user(env->regs[22], &gregs[21]);
+    __put_user(env->regs[23], &gregs[22]);
+    __put_user(env->regs[R_RA], &gregs[23]);
+    __put_user(env->regs[R_FP], &gregs[24]);
+    __put_user(env->regs[R_GP], &gregs[25]);
+    __put_user(env->regs[R_EA], &gregs[27]);
+    __put_user(env->regs[R_SP], &gregs[28]);
+
+    return 0;
+}
+
+static int rt_restore_ucontext(CPUNios2State *env, struct target_ucontext *uc,
+                               int *pr2)
+{
+    int temp;
+    abi_ulong off, frame_addr = env->regs[R_SP];
+    unsigned long *gregs = uc->tuc_mcontext.gregs;
+    int err;
+
+    /* Always make any pending restarted system calls return -EINTR */
+    /* current->restart_block.fn = do_no_restart_syscall; */
+
+    __get_user(temp, &uc->tuc_mcontext.version);
+    if (temp != MCONTEXT_VERSION) {
+        return 1;
+    }
+
+    /* restore passed registers */
+    __get_user(env->regs[1], &gregs[0]);
+    __get_user(env->regs[2], &gregs[1]);
+    __get_user(env->regs[3], &gregs[2]);
+    __get_user(env->regs[4], &gregs[3]);
+    __get_user(env->regs[5], &gregs[4]);
+    __get_user(env->regs[6], &gregs[5]);
+    __get_user(env->regs[7], &gregs[6]);
+    __get_user(env->regs[8], &gregs[7]);
+    __get_user(env->regs[9], &gregs[8]);
+    __get_user(env->regs[10], &gregs[9]);
+    __get_user(env->regs[11], &gregs[10]);
+    __get_user(env->regs[12], &gregs[11]);
+    __get_user(env->regs[13], &gregs[12]);
+    __get_user(env->regs[14], &gregs[13]);
+    __get_user(env->regs[15], &gregs[14]);
+    __get_user(env->regs[16], &gregs[15]);
+    __get_user(env->regs[17], &gregs[16]);
+    __get_user(env->regs[18], &gregs[17]);
+    __get_user(env->regs[19], &gregs[18]);
+    __get_user(env->regs[20], &gregs[19]);
+    __get_user(env->regs[21], &gregs[20]);
+    __get_user(env->regs[22], &gregs[21]);
+    __get_user(env->regs[23], &gregs[22]);
+    /* gregs[23] is handled below */
+    /* Verify, should this be settable */
+    __get_user(env->regs[R_FP], &gregs[24]);
+    /* Verify, should this be settable */
+    __get_user(env->regs[R_GP], &gregs[25]);
+    /* Not really necessary no user settable bits */
+    __get_user(temp, &gregs[26]);
+    __get_user(env->regs[R_EA], &gregs[27]);
+
+    __get_user(env->regs[R_RA], &gregs[23]);
+    __get_user(env->regs[R_SP], &gregs[28]);
+
+    off = offsetof(struct target_rt_sigframe, uc.tuc_stack);
+    err = do_sigaltstack(frame_addr + off, 0, get_sp_from_cpustate(env));
+    if (err == -EFAULT) {
+        return 1;
+    }
+
+    *pr2 = env->regs[2];
+    return 0;
+}
+
+static void *get_sigframe(struct target_sigaction *ka, CPUNios2State *env,
+                          size_t frame_size)
+{
+    unsigned long usp;
+
+    /* Default to using normal stack.  */
+    usp = env->regs[R_SP];
+
+    /* This is the X/Open sanctioned signal stack switching.  */
+    usp = sigsp(usp, ka);
+
+    /* Verify, is it 32 or 64 bit aligned */
+    return (void *)((usp - frame_size) & -8UL);
+}
+
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                    target_sigset_t *set,
+                    CPUNios2State *env)
+{
+    struct target_rt_sigframe *frame;
+    int i, err = 0;
+
+    frame = get_sigframe(ka, env, sizeof(*frame));
+
+    if (ka->sa_flags & SA_SIGINFO) {
+        tswap_siginfo(&frame->info, info);
+    }
+
+    /* Create the ucontext.  */
+    __put_user(0, &frame->uc.tuc_flags);
+    __put_user(0, &frame->uc.tuc_link);
+    __put_user(target_sigaltstack_used.ss_sp, &frame->uc.tuc_stack.ss_sp);
+    __put_user(sas_ss_flags(env->regs[R_SP]), &frame->uc.tuc_stack.ss_flags);
+    __put_user(target_sigaltstack_used.ss_size, &frame->uc.tuc_stack.ss_size);
+    err |= rt_setup_ucontext(&frame->uc, env);
+    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
+        __put_user((abi_ulong)set->sig[i],
+            (abi_ulong *)&frame->uc.tuc_sigmask.sig[i]);
+    }
+
+    if (err) {
+        goto give_sigsegv;
+    }
+
+    /* Set up to return from userspace; jump to fixed address sigreturn
+       trampoline on kuser page.  */
+    env->regs[R_RA] = (unsigned long) (0x1044);
+
+    /* Set up registers for signal handler */
+    env->regs[R_SP] = (unsigned long) frame;
+    env->regs[4] = (unsigned long) sig;
+    env->regs[5] = (unsigned long) &frame->info;
+    env->regs[6] = (unsigned long) &frame->uc;
+    env->regs[R_EA] = (unsigned long) ka->_sa_handler;
+    return;
+
+give_sigsegv:
+    if (sig == TARGET_SIGSEGV) {
+        ka->_sa_handler = TARGET_SIG_DFL;
+    }
+    force_sigsegv(sig);
+    return;
+}
+
+long do_sigreturn(CPUNios2State *env)
+{
+    trace_user_do_sigreturn(env, 0);
+    fprintf(stderr, "do_sigreturn: not implemented\n");
+    return -TARGET_ENOSYS;
+}
+
+long do_rt_sigreturn(CPUNios2State *env)
+{
+    /* Verify, can we follow the stack back */
+    abi_ulong frame_addr = env->regs[R_SP];
+    struct target_rt_sigframe *frame;
+    sigset_t set;
+    int rval;
+
+    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
+        goto badframe;
+    }
+
+    target_to_host_sigset(&set, &frame->uc.tuc_sigmask);
+    do_sigprocmask(SIG_SETMASK, &set, NULL);
+
+    if (rt_restore_ucontext(env, &frame->uc, &rval)) {
+        goto badframe;
+    }
+
+    unlock_user_struct(frame, frame_addr, 0);
+    return rval;
+
+badframe:
+    unlock_user_struct(frame, frame_addr, 0);
+    force_sig(TARGET_SIGSEGV);
+    return 0;
+}
diff --git a/linux-user/nios2/target_signal.h b/linux-user/nios2/target_signal.h
index 23a8267696..aa78519025 100644
--- a/linux-user/nios2/target_signal.h
+++ b/linux-user/nios2/target_signal.h
@@ -23,4 +23,8 @@ static inline abi_ulong get_sp_from_cpustate(CPUNios2State *state)
     return state->regs[R_SP];
 }
 
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                    target_sigset_t *set,
+                    CPUNios2State *env);
 #endif /* TARGET_SIGNAL_H */
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 38ce20ce6c..a4d19fcac7 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -2364,240 +2364,6 @@ badframe:
     return -TARGET_QEMU_ESIGRETURN;
 }
 
-#elif defined(TARGET_NIOS2)
-
-#define MCONTEXT_VERSION 2
-
-struct target_sigcontext {
-    int version;
-    unsigned long gregs[32];
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
-    struct target_siginfo info;
-    struct target_ucontext uc;
-};
-
-static unsigned long sigsp(unsigned long sp, struct target_sigaction *ka)
-{
-    if (unlikely((ka->sa_flags & SA_ONSTACK)) && !sas_ss_flags(sp)) {
-#ifdef CONFIG_STACK_GROWSUP
-        return target_sigaltstack_used.ss_sp;
-#else
-        return target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-#endif
-    }
-    return sp;
-}
-
-static int rt_setup_ucontext(struct target_ucontext *uc, CPUNios2State *env)
-{
-    unsigned long *gregs = uc->tuc_mcontext.gregs;
-
-    __put_user(MCONTEXT_VERSION, &uc->tuc_mcontext.version);
-    __put_user(env->regs[1], &gregs[0]);
-    __put_user(env->regs[2], &gregs[1]);
-    __put_user(env->regs[3], &gregs[2]);
-    __put_user(env->regs[4], &gregs[3]);
-    __put_user(env->regs[5], &gregs[4]);
-    __put_user(env->regs[6], &gregs[5]);
-    __put_user(env->regs[7], &gregs[6]);
-    __put_user(env->regs[8], &gregs[7]);
-    __put_user(env->regs[9], &gregs[8]);
-    __put_user(env->regs[10], &gregs[9]);
-    __put_user(env->regs[11], &gregs[10]);
-    __put_user(env->regs[12], &gregs[11]);
-    __put_user(env->regs[13], &gregs[12]);
-    __put_user(env->regs[14], &gregs[13]);
-    __put_user(env->regs[15], &gregs[14]);
-    __put_user(env->regs[16], &gregs[15]);
-    __put_user(env->regs[17], &gregs[16]);
-    __put_user(env->regs[18], &gregs[17]);
-    __put_user(env->regs[19], &gregs[18]);
-    __put_user(env->regs[20], &gregs[19]);
-    __put_user(env->regs[21], &gregs[20]);
-    __put_user(env->regs[22], &gregs[21]);
-    __put_user(env->regs[23], &gregs[22]);
-    __put_user(env->regs[R_RA], &gregs[23]);
-    __put_user(env->regs[R_FP], &gregs[24]);
-    __put_user(env->regs[R_GP], &gregs[25]);
-    __put_user(env->regs[R_EA], &gregs[27]);
-    __put_user(env->regs[R_SP], &gregs[28]);
-
-    return 0;
-}
-
-static int rt_restore_ucontext(CPUNios2State *env, struct target_ucontext *uc,
-                               int *pr2)
-{
-    int temp;
-    abi_ulong off, frame_addr = env->regs[R_SP];
-    unsigned long *gregs = uc->tuc_mcontext.gregs;
-    int err;
-
-    /* Always make any pending restarted system calls return -EINTR */
-    /* current->restart_block.fn = do_no_restart_syscall; */
-
-    __get_user(temp, &uc->tuc_mcontext.version);
-    if (temp != MCONTEXT_VERSION) {
-        return 1;
-    }
-
-    /* restore passed registers */
-    __get_user(env->regs[1], &gregs[0]);
-    __get_user(env->regs[2], &gregs[1]);
-    __get_user(env->regs[3], &gregs[2]);
-    __get_user(env->regs[4], &gregs[3]);
-    __get_user(env->regs[5], &gregs[4]);
-    __get_user(env->regs[6], &gregs[5]);
-    __get_user(env->regs[7], &gregs[6]);
-    __get_user(env->regs[8], &gregs[7]);
-    __get_user(env->regs[9], &gregs[8]);
-    __get_user(env->regs[10], &gregs[9]);
-    __get_user(env->regs[11], &gregs[10]);
-    __get_user(env->regs[12], &gregs[11]);
-    __get_user(env->regs[13], &gregs[12]);
-    __get_user(env->regs[14], &gregs[13]);
-    __get_user(env->regs[15], &gregs[14]);
-    __get_user(env->regs[16], &gregs[15]);
-    __get_user(env->regs[17], &gregs[16]);
-    __get_user(env->regs[18], &gregs[17]);
-    __get_user(env->regs[19], &gregs[18]);
-    __get_user(env->regs[20], &gregs[19]);
-    __get_user(env->regs[21], &gregs[20]);
-    __get_user(env->regs[22], &gregs[21]);
-    __get_user(env->regs[23], &gregs[22]);
-    /* gregs[23] is handled below */
-    /* Verify, should this be settable */
-    __get_user(env->regs[R_FP], &gregs[24]);
-    /* Verify, should this be settable */
-    __get_user(env->regs[R_GP], &gregs[25]);
-    /* Not really necessary no user settable bits */
-    __get_user(temp, &gregs[26]);
-    __get_user(env->regs[R_EA], &gregs[27]);
-
-    __get_user(env->regs[R_RA], &gregs[23]);
-    __get_user(env->regs[R_SP], &gregs[28]);
-
-    off = offsetof(struct target_rt_sigframe, uc.tuc_stack);
-    err = do_sigaltstack(frame_addr + off, 0, get_sp_from_cpustate(env));
-    if (err == -EFAULT) {
-        return 1;
-    }
-
-    *pr2 = env->regs[2];
-    return 0;
-}
-
-static void *get_sigframe(struct target_sigaction *ka, CPUNios2State *env,
-                          size_t frame_size)
-{
-    unsigned long usp;
-
-    /* Default to using normal stack.  */
-    usp = env->regs[R_SP];
-
-    /* This is the X/Open sanctioned signal stack switching.  */
-    usp = sigsp(usp, ka);
-
-    /* Verify, is it 32 or 64 bit aligned */
-    return (void *)((usp - frame_size) & -8UL);
-}
-
-static void setup_rt_frame(int sig, struct target_sigaction *ka,
-                           target_siginfo_t *info,
-                           target_sigset_t *set,
-                           CPUNios2State *env)
-{
-    struct target_rt_sigframe *frame;
-    int i, err = 0;
-
-    frame = get_sigframe(ka, env, sizeof(*frame));
-
-    if (ka->sa_flags & SA_SIGINFO) {
-        tswap_siginfo(&frame->info, info);
-    }
-
-    /* Create the ucontext.  */
-    __put_user(0, &frame->uc.tuc_flags);
-    __put_user(0, &frame->uc.tuc_link);
-    __put_user(target_sigaltstack_used.ss_sp, &frame->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(env->regs[R_SP]), &frame->uc.tuc_stack.ss_flags);
-    __put_user(target_sigaltstack_used.ss_size, &frame->uc.tuc_stack.ss_size);
-    err |= rt_setup_ucontext(&frame->uc, env);
-    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
-        __put_user((abi_ulong)set->sig[i],
-            (abi_ulong *)&frame->uc.tuc_sigmask.sig[i]);
-    }
-
-    if (err) {
-        goto give_sigsegv;
-    }
-
-    /* Set up to return from userspace; jump to fixed address sigreturn
-       trampoline on kuser page.  */
-    env->regs[R_RA] = (unsigned long) (0x1044);
-
-    /* Set up registers for signal handler */
-    env->regs[R_SP] = (unsigned long) frame;
-    env->regs[4] = (unsigned long) sig;
-    env->regs[5] = (unsigned long) &frame->info;
-    env->regs[6] = (unsigned long) &frame->uc;
-    env->regs[R_EA] = (unsigned long) ka->_sa_handler;
-    return;
-
-give_sigsegv:
-    if (sig == TARGET_SIGSEGV) {
-        ka->_sa_handler = TARGET_SIG_DFL;
-    }
-    force_sigsegv(sig);
-    return;
-}
-
-long do_sigreturn(CPUNios2State *env)
-{
-    trace_user_do_sigreturn(env, 0);
-    fprintf(stderr, "do_sigreturn: not implemented\n");
-    return -TARGET_ENOSYS;
-}
-
-long do_rt_sigreturn(CPUNios2State *env)
-{
-    /* Verify, can we follow the stack back */
-    abi_ulong frame_addr = env->regs[R_SP];
-    struct target_rt_sigframe *frame;
-    sigset_t set;
-    int rval;
-
-    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
-        goto badframe;
-    }
-
-    target_to_host_sigset(&set, &frame->uc.tuc_sigmask);
-    do_sigprocmask(SIG_SETMASK, &set, NULL);
-
-    if (rt_restore_ucontext(env, &frame->uc, &rval)) {
-        goto badframe;
-    }
-
-    unlock_user_struct(frame, frame_addr, 0);
-    return rval;
-
-badframe:
-    unlock_user_struct(frame, frame_addr, 0);
-    force_sig(TARGET_SIGSEGV);
-    return 0;
-}
-/* TARGET_NIOS2 */
-
 #elif defined(TARGET_OPENRISC)
 
 struct target_sigcontext {
-- 
2.14.3
