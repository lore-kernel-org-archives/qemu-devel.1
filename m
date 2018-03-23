Received: from eggs.gnu.org ([2001:4830:134:3::10]:45403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdf-0004nk-0R
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdc-0000hK-Si
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:23 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 23 Mar 2018 23:57:25 +0100
Message-Id: <20180323225739.17329-7-laurent@vivier.eu>
In-Reply-To: <20180323225739.17329-1-laurent@vivier.eu>
References: <20180323225739.17329-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 v2 06/20] linux-user: move cris
 signal.c parts to cris directory
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
cris/signal.c, except adding includes and
exporting setup_frame() and setup_rt_frame().

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/cris/signal.c        | 171 ++++++++++++++++++++++++++++++++++++++++
 linux-user/cris/target_signal.h |   6 +-
 linux-user/signal.c             | 168 ---------------------------------------
 3 files changed, 176 insertions(+), 169 deletions(-)

diff --git a/linux-user/cris/signal.c b/linux-user/cris/signal.c
index 02ca338b6c..322d9db1a7 100644
--- a/linux-user/cris/signal.c
+++ b/linux-user/cris/signal.c
@@ -16,3 +16,174 @@
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
+    struct target_pt_regs regs;  /* needs to be first */
+    uint32_t oldmask;
+    uint32_t usp;    /* usp before stacking this gunk on it */
+};
+
+/* Signal frames. */
+struct target_signal_frame {
+    struct target_sigcontext sc;
+    uint32_t extramask[TARGET_NSIG_WORDS - 1];
+    uint16_t retcode[4];      /* Trampoline code. */
+};
+
+struct rt_signal_frame {
+    siginfo_t *pinfo;
+    void *puc;
+    siginfo_t info;
+    ucontext_t uc;
+    uint16_t retcode[4];      /* Trampoline code. */
+};
+
+static void setup_sigcontext(struct target_sigcontext *sc, CPUCRISState *env)
+{
+    __put_user(env->regs[0], &sc->regs.r0);
+    __put_user(env->regs[1], &sc->regs.r1);
+    __put_user(env->regs[2], &sc->regs.r2);
+    __put_user(env->regs[3], &sc->regs.r3);
+    __put_user(env->regs[4], &sc->regs.r4);
+    __put_user(env->regs[5], &sc->regs.r5);
+    __put_user(env->regs[6], &sc->regs.r6);
+    __put_user(env->regs[7], &sc->regs.r7);
+    __put_user(env->regs[8], &sc->regs.r8);
+    __put_user(env->regs[9], &sc->regs.r9);
+    __put_user(env->regs[10], &sc->regs.r10);
+    __put_user(env->regs[11], &sc->regs.r11);
+    __put_user(env->regs[12], &sc->regs.r12);
+    __put_user(env->regs[13], &sc->regs.r13);
+    __put_user(env->regs[14], &sc->usp);
+    __put_user(env->regs[15], &sc->regs.acr);
+    __put_user(env->pregs[PR_MOF], &sc->regs.mof);
+    __put_user(env->pregs[PR_SRP], &sc->regs.srp);
+    __put_user(env->pc, &sc->regs.erp);
+}
+
+static void restore_sigcontext(struct target_sigcontext *sc, CPUCRISState *env)
+{
+    __get_user(env->regs[0], &sc->regs.r0);
+    __get_user(env->regs[1], &sc->regs.r1);
+    __get_user(env->regs[2], &sc->regs.r2);
+    __get_user(env->regs[3], &sc->regs.r3);
+    __get_user(env->regs[4], &sc->regs.r4);
+    __get_user(env->regs[5], &sc->regs.r5);
+    __get_user(env->regs[6], &sc->regs.r6);
+    __get_user(env->regs[7], &sc->regs.r7);
+    __get_user(env->regs[8], &sc->regs.r8);
+    __get_user(env->regs[9], &sc->regs.r9);
+    __get_user(env->regs[10], &sc->regs.r10);
+    __get_user(env->regs[11], &sc->regs.r11);
+    __get_user(env->regs[12], &sc->regs.r12);
+    __get_user(env->regs[13], &sc->regs.r13);
+    __get_user(env->regs[14], &sc->usp);
+    __get_user(env->regs[15], &sc->regs.acr);
+    __get_user(env->pregs[PR_MOF], &sc->regs.mof);
+    __get_user(env->pregs[PR_SRP], &sc->regs.srp);
+    __get_user(env->pc, &sc->regs.erp);
+}
+
+static abi_ulong get_sigframe(CPUCRISState *env, int framesize)
+{
+    abi_ulong sp;
+    /* Align the stack downwards to 4.  */
+    sp = (env->regs[R_SP] & ~3);
+    return sp - framesize;
+}
+
+void setup_frame(int sig, struct target_sigaction *ka,
+                 target_sigset_t *set, CPUCRISState *env)
+{
+    struct target_signal_frame *frame;
+    abi_ulong frame_addr;
+    int i;
+
+    frame_addr = get_sigframe(env, sizeof *frame);
+    trace_user_setup_frame(env, frame_addr);
+    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
+        goto badframe;
+
+    /*
+     * The CRIS signal return trampoline. A real linux/CRIS kernel doesn't
+     * use this trampoline anymore but it sets it up for GDB.
+     * In QEMU, using the trampoline simplifies things a bit so we use it.
+     *
+     * This is movu.w __NR_sigreturn, r9; break 13;
+     */
+    __put_user(0x9c5f, frame->retcode+0);
+    __put_user(TARGET_NR_sigreturn,
+               frame->retcode + 1);
+    __put_user(0xe93d, frame->retcode + 2);
+
+    /* Save the mask.  */
+    __put_user(set->sig[0], &frame->sc.oldmask);
+
+    for(i = 1; i < TARGET_NSIG_WORDS; i++) {
+        __put_user(set->sig[i], &frame->extramask[i - 1]);
+    }
+
+    setup_sigcontext(&frame->sc, env);
+
+    /* Move the stack and setup the arguments for the handler.  */
+    env->regs[R_SP] = frame_addr;
+    env->regs[10] = sig;
+    env->pc = (unsigned long) ka->_sa_handler;
+    /* Link SRP so the guest returns through the trampoline.  */
+    env->pregs[PR_SRP] = frame_addr + offsetof(typeof(*frame), retcode);
+
+    unlock_user_struct(frame, frame_addr, 1);
+    return;
+badframe:
+    force_sigsegv(sig);
+}
+
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                     target_sigset_t *set, CPUCRISState *env)
+{
+    fprintf(stderr, "CRIS setup_rt_frame: not implemented\n");
+}
+
+long do_sigreturn(CPUCRISState *env)
+{
+    struct target_signal_frame *frame;
+    abi_ulong frame_addr;
+    target_sigset_t target_set;
+    sigset_t set;
+    int i;
+
+    frame_addr = env->regs[R_SP];
+    trace_user_do_sigreturn(env, frame_addr);
+    /* Make sure the guest isn't playing games.  */
+    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 1)) {
+        goto badframe;
+    }
+
+    /* Restore blocked signals */
+    __get_user(target_set.sig[0], &frame->sc.oldmask);
+    for(i = 1; i < TARGET_NSIG_WORDS; i++) {
+        __get_user(target_set.sig[i], &frame->extramask[i - 1]);
+    }
+    target_to_host_sigset_internal(&set, &target_set);
+    set_sigmask(&set);
+
+    restore_sigcontext(&frame->sc, env);
+    unlock_user_struct(frame, frame_addr, 0);
+    return -TARGET_QEMU_ESIGRETURN;
+badframe:
+    force_sig(TARGET_SIGSEGV);
+    return -TARGET_QEMU_ESIGRETURN;
+}
+
+long do_rt_sigreturn(CPUCRISState *env)
+{
+    trace_user_do_rt_sigreturn(env, 0);
+    fprintf(stderr, "CRIS do_rt_sigreturn: not implemented\n");
+    return -TARGET_ENOSYS;
+}
diff --git a/linux-user/cris/target_signal.h b/linux-user/cris/target_signal.h
index 664621bbcd..19c0d7b539 100644
--- a/linux-user/cris/target_signal.h
+++ b/linux-user/cris/target_signal.h
@@ -26,5 +26,9 @@ static inline abi_ulong get_sp_from_cpustate(CPUCRISState *state)
     return state->regs[14];
 }
 
-
+void setup_frame(int sig, struct target_sigaction *ka,
+                 target_sigset_t *set, CPUCRISState *env);
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                     target_sigset_t *set, CPUCRISState *env);
 #endif /* CRIS_TARGET_SIGNAL_H */
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 11c3062f0d..38ce20ce6c 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -2364,174 +2364,6 @@ badframe:
     return -TARGET_QEMU_ESIGRETURN;
 }
 
-#elif defined(TARGET_CRIS)
-
-struct target_sigcontext {
-    struct target_pt_regs regs;  /* needs to be first */
-    uint32_t oldmask;
-    uint32_t usp;    /* usp before stacking this gunk on it */
-};
-
-/* Signal frames. */
-struct target_signal_frame {
-    struct target_sigcontext sc;
-    uint32_t extramask[TARGET_NSIG_WORDS - 1];
-    uint16_t retcode[4];      /* Trampoline code. */
-};
-
-struct rt_signal_frame {
-    siginfo_t *pinfo;
-    void *puc;
-    siginfo_t info;
-    ucontext_t uc;
-    uint16_t retcode[4];      /* Trampoline code. */
-};
-
-static void setup_sigcontext(struct target_sigcontext *sc, CPUCRISState *env)
-{
-    __put_user(env->regs[0], &sc->regs.r0);
-    __put_user(env->regs[1], &sc->regs.r1);
-    __put_user(env->regs[2], &sc->regs.r2);
-    __put_user(env->regs[3], &sc->regs.r3);
-    __put_user(env->regs[4], &sc->regs.r4);
-    __put_user(env->regs[5], &sc->regs.r5);
-    __put_user(env->regs[6], &sc->regs.r6);
-    __put_user(env->regs[7], &sc->regs.r7);
-    __put_user(env->regs[8], &sc->regs.r8);
-    __put_user(env->regs[9], &sc->regs.r9);
-    __put_user(env->regs[10], &sc->regs.r10);
-    __put_user(env->regs[11], &sc->regs.r11);
-    __put_user(env->regs[12], &sc->regs.r12);
-    __put_user(env->regs[13], &sc->regs.r13);
-    __put_user(env->regs[14], &sc->usp);
-    __put_user(env->regs[15], &sc->regs.acr);
-    __put_user(env->pregs[PR_MOF], &sc->regs.mof);
-    __put_user(env->pregs[PR_SRP], &sc->regs.srp);
-    __put_user(env->pc, &sc->regs.erp);
-}
-
-static void restore_sigcontext(struct target_sigcontext *sc, CPUCRISState *env)
-{
-    __get_user(env->regs[0], &sc->regs.r0);
-    __get_user(env->regs[1], &sc->regs.r1);
-    __get_user(env->regs[2], &sc->regs.r2);
-    __get_user(env->regs[3], &sc->regs.r3);
-    __get_user(env->regs[4], &sc->regs.r4);
-    __get_user(env->regs[5], &sc->regs.r5);
-    __get_user(env->regs[6], &sc->regs.r6);
-    __get_user(env->regs[7], &sc->regs.r7);
-    __get_user(env->regs[8], &sc->regs.r8);
-    __get_user(env->regs[9], &sc->regs.r9);
-    __get_user(env->regs[10], &sc->regs.r10);
-    __get_user(env->regs[11], &sc->regs.r11);
-    __get_user(env->regs[12], &sc->regs.r12);
-    __get_user(env->regs[13], &sc->regs.r13);
-    __get_user(env->regs[14], &sc->usp);
-    __get_user(env->regs[15], &sc->regs.acr);
-    __get_user(env->pregs[PR_MOF], &sc->regs.mof);
-    __get_user(env->pregs[PR_SRP], &sc->regs.srp);
-    __get_user(env->pc, &sc->regs.erp);
-}
-
-static abi_ulong get_sigframe(CPUCRISState *env, int framesize)
-{
-    abi_ulong sp;
-    /* Align the stack downwards to 4.  */
-    sp = (env->regs[R_SP] & ~3);
-    return sp - framesize;
-}
-
-static void setup_frame(int sig, struct target_sigaction *ka,
-                        target_sigset_t *set, CPUCRISState *env)
-{
-    struct target_signal_frame *frame;
-    abi_ulong frame_addr;
-    int i;
-
-    frame_addr = get_sigframe(env, sizeof *frame);
-    trace_user_setup_frame(env, frame_addr);
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
-        goto badframe;
-
-    /*
-     * The CRIS signal return trampoline. A real linux/CRIS kernel doesn't
-     * use this trampoline anymore but it sets it up for GDB.
-     * In QEMU, using the trampoline simplifies things a bit so we use it.
-     *
-     * This is movu.w __NR_sigreturn, r9; break 13;
-     */
-    __put_user(0x9c5f, frame->retcode+0);
-    __put_user(TARGET_NR_sigreturn,
-               frame->retcode + 1);
-    __put_user(0xe93d, frame->retcode + 2);
-
-    /* Save the mask.  */
-    __put_user(set->sig[0], &frame->sc.oldmask);
-
-    for(i = 1; i < TARGET_NSIG_WORDS; i++) {
-        __put_user(set->sig[i], &frame->extramask[i - 1]);
-    }
-
-    setup_sigcontext(&frame->sc, env);
-
-    /* Move the stack and setup the arguments for the handler.  */
-    env->regs[R_SP] = frame_addr;
-    env->regs[10] = sig;
-    env->pc = (unsigned long) ka->_sa_handler;
-    /* Link SRP so the guest returns through the trampoline.  */
-    env->pregs[PR_SRP] = frame_addr + offsetof(typeof(*frame), retcode);
-
-    unlock_user_struct(frame, frame_addr, 1);
-    return;
-badframe:
-    force_sigsegv(sig);
-}
-
-static void setup_rt_frame(int sig, struct target_sigaction *ka,
-                           target_siginfo_t *info,
-                           target_sigset_t *set, CPUCRISState *env)
-{
-    fprintf(stderr, "CRIS setup_rt_frame: not implemented\n");
-}
-
-long do_sigreturn(CPUCRISState *env)
-{
-    struct target_signal_frame *frame;
-    abi_ulong frame_addr;
-    target_sigset_t target_set;
-    sigset_t set;
-    int i;
-
-    frame_addr = env->regs[R_SP];
-    trace_user_do_sigreturn(env, frame_addr);
-    /* Make sure the guest isn't playing games.  */
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 1)) {
-        goto badframe;
-    }
-
-    /* Restore blocked signals */
-    __get_user(target_set.sig[0], &frame->sc.oldmask);
-    for(i = 1; i < TARGET_NSIG_WORDS; i++) {
-        __get_user(target_set.sig[i], &frame->extramask[i - 1]);
-    }
-    target_to_host_sigset_internal(&set, &target_set);
-    set_sigmask(&set);
-
-    restore_sigcontext(&frame->sc, env);
-    unlock_user_struct(frame, frame_addr, 0);
-    return -TARGET_QEMU_ESIGRETURN;
-badframe:
-    force_sig(TARGET_SIGSEGV);
-    return -TARGET_QEMU_ESIGRETURN;
-}
-
-long do_rt_sigreturn(CPUCRISState *env)
-{
-    trace_user_do_rt_sigreturn(env, 0);
-    fprintf(stderr, "CRIS do_rt_sigreturn: not implemented\n");
-    return -TARGET_ENOSYS;
-}
-
 #elif defined(TARGET_NIOS2)
 
 #define MCONTEXT_VERSION 2
-- 
2.14.3
