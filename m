Received: from eggs.gnu.org ([2001:4830:134:3::10]:45635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdr-00057z-OU
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdn-0000ru-67
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:35 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 23 Mar 2018 23:57:33 +0100
Message-Id: <20180323225739.17329-15-laurent@vivier.eu>
In-Reply-To: <20180323225739.17329-1-laurent@vivier.eu>
References: <20180323225739.17329-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 v2 14/20] linux-user: move hppa
 signal.c parts to hppa directory
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
hppa/signal.c, except adding includes and
exporting setup_rt_frame().

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/hppa/signal.c        | 192 ++++++++++++++++++++++++++++++++++++++++
 linux-user/hppa/target_signal.h |   3 +
 linux-user/signal.c             | 189 ---------------------------------------
 3 files changed, 195 insertions(+), 189 deletions(-)

diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
index 02ca338b6c..585af3a37f 100644
--- a/linux-user/hppa/signal.c
+++ b/linux-user/hppa/signal.c
@@ -16,3 +16,195 @@
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
+    abi_ulong sc_flags;
+    abi_ulong sc_gr[32];
+    uint64_t sc_fr[32];
+    abi_ulong sc_iasq[2];
+    abi_ulong sc_iaoq[2];
+    abi_ulong sc_sar;
+};
+
+struct target_ucontext {
+    abi_uint tuc_flags;
+    abi_ulong tuc_link;
+    target_stack_t tuc_stack;
+    abi_uint pad[1];
+    struct target_sigcontext tuc_mcontext;
+    target_sigset_t tuc_sigmask;
+};
+
+struct target_rt_sigframe {
+    abi_uint tramp[9];
+    target_siginfo_t info;
+    struct target_ucontext uc;
+    /* hidden location of upper halves of pa2.0 64-bit gregs */
+};
+
+static void setup_sigcontext(struct target_sigcontext *sc, CPUArchState *env)
+{
+    int flags = 0;
+    int i;
+
+    /* ??? if on_sig_stack, flags |= 1 (PARISC_SC_FLAG_ONSTACK).  */
+
+    if (env->iaoq_f < TARGET_PAGE_SIZE) {
+        /* In the gateway page, executing a syscall.  */
+        flags |= 2; /* PARISC_SC_FLAG_IN_SYSCALL */
+        __put_user(env->gr[31], &sc->sc_iaoq[0]);
+        __put_user(env->gr[31] + 4, &sc->sc_iaoq[1]);
+    } else {
+        __put_user(env->iaoq_f, &sc->sc_iaoq[0]);
+        __put_user(env->iaoq_b, &sc->sc_iaoq[1]);
+    }
+    __put_user(0, &sc->sc_iasq[0]);
+    __put_user(0, &sc->sc_iasq[1]);
+    __put_user(flags, &sc->sc_flags);
+
+    __put_user(cpu_hppa_get_psw(env), &sc->sc_gr[0]);
+    for (i = 1; i < 32; ++i) {
+        __put_user(env->gr[i], &sc->sc_gr[i]);
+    }
+
+    __put_user((uint64_t)env->fr0_shadow << 32, &sc->sc_fr[0]);
+    for (i = 1; i < 32; ++i) {
+        __put_user(env->fr[i], &sc->sc_fr[i]);
+    }
+
+    __put_user(env->cr[CR_SAR], &sc->sc_sar);
+}
+
+static void restore_sigcontext(CPUArchState *env, struct target_sigcontext *sc)
+{
+    target_ulong psw;
+    int i;
+
+    __get_user(psw, &sc->sc_gr[0]);
+    cpu_hppa_put_psw(env, psw);
+
+    for (i = 1; i < 32; ++i) {
+        __get_user(env->gr[i], &sc->sc_gr[i]);
+    }
+    for (i = 0; i < 32; ++i) {
+        __get_user(env->fr[i], &sc->sc_fr[i]);
+    }
+    cpu_hppa_loaded_fr0(env);
+
+    __get_user(env->iaoq_f, &sc->sc_iaoq[0]);
+    __get_user(env->iaoq_b, &sc->sc_iaoq[1]);
+    __get_user(env->cr[CR_SAR], &sc->sc_sar);
+}
+
+/* No, this doesn't look right, but it's copied straight from the kernel.  */
+#define PARISC_RT_SIGFRAME_SIZE32 \
+    ((sizeof(struct target_rt_sigframe) + 48 + 64) & -64)
+
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                    target_sigset_t *set, CPUArchState *env)
+{
+    abi_ulong frame_addr, sp, haddr;
+    struct target_rt_sigframe *frame;
+    int i;
+
+    sp = env->gr[30];
+    if (ka->sa_flags & TARGET_SA_ONSTACK) {
+        if (sas_ss_flags(sp) == 0) {
+            sp = (target_sigaltstack_used.ss_sp + 0x7f) & ~0x3f;
+        }
+    }
+    frame_addr = QEMU_ALIGN_UP(sp, 64);
+    sp = frame_addr + PARISC_RT_SIGFRAME_SIZE32;
+
+    trace_user_setup_rt_frame(env, frame_addr);
+
+    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
+        goto give_sigsegv;
+    }
+
+    tswap_siginfo(&frame->info, info);
+    frame->uc.tuc_flags = 0;
+    frame->uc.tuc_link = 0;
+
+    __put_user(target_sigaltstack_used.ss_sp, &frame->uc.tuc_stack.ss_sp);
+    __put_user(sas_ss_flags(get_sp_from_cpustate(env)),
+               &frame->uc.tuc_stack.ss_flags);
+    __put_user(target_sigaltstack_used.ss_size,
+               &frame->uc.tuc_stack.ss_size);
+
+    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
+        __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
+    }
+
+    setup_sigcontext(&frame->uc.tuc_mcontext, env);
+
+    __put_user(0x34190000, frame->tramp + 0); /* ldi 0,%r25 */
+    __put_user(0x3414015a, frame->tramp + 1); /* ldi __NR_rt_sigreturn,%r20 */
+    __put_user(0xe4008200, frame->tramp + 2); /* be,l 0x100(%sr2,%r0) */
+    __put_user(0x08000240, frame->tramp + 3); /* nop */
+
+    unlock_user_struct(frame, frame_addr, 1);
+
+    env->gr[2] = h2g(frame->tramp);
+    env->gr[30] = sp;
+    env->gr[26] = sig;
+    env->gr[25] = h2g(&frame->info);
+    env->gr[24] = h2g(&frame->uc);
+
+    haddr = ka->_sa_handler;
+    if (haddr & 2) {
+        /* Function descriptor.  */
+        target_ulong *fdesc, dest;
+
+        haddr &= -4;
+        if (!lock_user_struct(VERIFY_READ, fdesc, haddr, 1)) {
+            goto give_sigsegv;
+        }
+        __get_user(dest, fdesc);
+        __get_user(env->gr[19], fdesc + 1);
+        unlock_user_struct(fdesc, haddr, 1);
+        haddr = dest;
+    }
+    env->iaoq_f = haddr;
+    env->iaoq_b = haddr + 4;
+    return;
+
+ give_sigsegv:
+    force_sigsegv(sig);
+}
+
+long do_rt_sigreturn(CPUArchState *env)
+{
+    abi_ulong frame_addr = env->gr[30] - PARISC_RT_SIGFRAME_SIZE32;
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
+    unlock_user_struct(frame, frame_addr, 0);
+
+    if (do_sigaltstack(frame_addr + offsetof(struct target_rt_sigframe,
+                                             uc.tuc_stack),
+                       0, env->gr[30]) == -EFAULT) {
+        goto badframe;
+    }
+
+    unlock_user_struct(frame, frame_addr, 0);
+    return -TARGET_QEMU_ESIGRETURN;
+
+ badframe:
+    force_sig(TARGET_SIGSEGV);
+    return -TARGET_QEMU_ESIGRETURN;
+}
diff --git a/linux-user/hppa/target_signal.h b/linux-user/hppa/target_signal.h
index e115890b48..f19aed93dd 100644
--- a/linux-user/hppa/target_signal.h
+++ b/linux-user/hppa/target_signal.h
@@ -26,4 +26,7 @@ static inline abi_ulong get_sp_from_cpustate(CPUHPPAState *state)
     return state->gr[30];
 }
 
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                    target_sigset_t *set, CPUArchState *env);
 #endif /* HPPA_TARGET_SIGNAL_H */
diff --git a/linux-user/signal.c b/linux-user/signal.c
index cc5b7d1456..fc81ec87b6 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -3032,195 +3032,6 @@ sigsegv:
     return -TARGET_QEMU_ESIGRETURN;
 }
 
-#elif defined(TARGET_HPPA)
-
-struct target_sigcontext {
-    abi_ulong sc_flags;
-    abi_ulong sc_gr[32];
-    uint64_t sc_fr[32];
-    abi_ulong sc_iasq[2];
-    abi_ulong sc_iaoq[2];
-    abi_ulong sc_sar;
-};
-
-struct target_ucontext {
-    abi_uint tuc_flags;
-    abi_ulong tuc_link;
-    target_stack_t tuc_stack;
-    abi_uint pad[1];
-    struct target_sigcontext tuc_mcontext;
-    target_sigset_t tuc_sigmask;
-};
-
-struct target_rt_sigframe {
-    abi_uint tramp[9];
-    target_siginfo_t info;
-    struct target_ucontext uc;
-    /* hidden location of upper halves of pa2.0 64-bit gregs */
-};
-
-static void setup_sigcontext(struct target_sigcontext *sc, CPUArchState *env)
-{
-    int flags = 0;
-    int i;
-
-    /* ??? if on_sig_stack, flags |= 1 (PARISC_SC_FLAG_ONSTACK).  */
-
-    if (env->iaoq_f < TARGET_PAGE_SIZE) {
-        /* In the gateway page, executing a syscall.  */
-        flags |= 2; /* PARISC_SC_FLAG_IN_SYSCALL */
-        __put_user(env->gr[31], &sc->sc_iaoq[0]);
-        __put_user(env->gr[31] + 4, &sc->sc_iaoq[1]);
-    } else {
-        __put_user(env->iaoq_f, &sc->sc_iaoq[0]);
-        __put_user(env->iaoq_b, &sc->sc_iaoq[1]);
-    }
-    __put_user(0, &sc->sc_iasq[0]);
-    __put_user(0, &sc->sc_iasq[1]);
-    __put_user(flags, &sc->sc_flags);
-
-    __put_user(cpu_hppa_get_psw(env), &sc->sc_gr[0]);
-    for (i = 1; i < 32; ++i) {
-        __put_user(env->gr[i], &sc->sc_gr[i]);
-    }
-
-    __put_user((uint64_t)env->fr0_shadow << 32, &sc->sc_fr[0]);
-    for (i = 1; i < 32; ++i) {
-        __put_user(env->fr[i], &sc->sc_fr[i]);
-    }
-
-    __put_user(env->cr[CR_SAR], &sc->sc_sar);
-}
-
-static void restore_sigcontext(CPUArchState *env, struct target_sigcontext *sc)
-{
-    target_ulong psw;
-    int i;
-
-    __get_user(psw, &sc->sc_gr[0]);
-    cpu_hppa_put_psw(env, psw);
-
-    for (i = 1; i < 32; ++i) {
-        __get_user(env->gr[i], &sc->sc_gr[i]);
-    }
-    for (i = 0; i < 32; ++i) {
-        __get_user(env->fr[i], &sc->sc_fr[i]);
-    }
-    cpu_hppa_loaded_fr0(env);
-
-    __get_user(env->iaoq_f, &sc->sc_iaoq[0]);
-    __get_user(env->iaoq_b, &sc->sc_iaoq[1]);
-    __get_user(env->cr[CR_SAR], &sc->sc_sar);
-}
-
-/* No, this doesn't look right, but it's copied straight from the kernel.  */
-#define PARISC_RT_SIGFRAME_SIZE32 \
-    ((sizeof(struct target_rt_sigframe) + 48 + 64) & -64)
-
-static void setup_rt_frame(int sig, struct target_sigaction *ka,
-                           target_siginfo_t *info,
-                           target_sigset_t *set, CPUArchState *env)
-{
-    abi_ulong frame_addr, sp, haddr;
-    struct target_rt_sigframe *frame;
-    int i;
-
-    sp = env->gr[30];
-    if (ka->sa_flags & TARGET_SA_ONSTACK) {
-        if (sas_ss_flags(sp) == 0) {
-            sp = (target_sigaltstack_used.ss_sp + 0x7f) & ~0x3f;
-        }
-    }
-    frame_addr = QEMU_ALIGN_UP(sp, 64);
-    sp = frame_addr + PARISC_RT_SIGFRAME_SIZE32;
-
-    trace_user_setup_rt_frame(env, frame_addr);
-
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
-        goto give_sigsegv;
-    }
-
-    tswap_siginfo(&frame->info, info);
-    frame->uc.tuc_flags = 0;
-    frame->uc.tuc_link = 0;
-
-    __put_user(target_sigaltstack_used.ss_sp, &frame->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(get_sp_from_cpustate(env)),
-               &frame->uc.tuc_stack.ss_flags);
-    __put_user(target_sigaltstack_used.ss_size,
-               &frame->uc.tuc_stack.ss_size);
-
-    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
-        __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
-    }
-
-    setup_sigcontext(&frame->uc.tuc_mcontext, env);
-
-    __put_user(0x34190000, frame->tramp + 0); /* ldi 0,%r25 */
-    __put_user(0x3414015a, frame->tramp + 1); /* ldi __NR_rt_sigreturn,%r20 */
-    __put_user(0xe4008200, frame->tramp + 2); /* be,l 0x100(%sr2,%r0) */
-    __put_user(0x08000240, frame->tramp + 3); /* nop */
-
-    unlock_user_struct(frame, frame_addr, 1);
-
-    env->gr[2] = h2g(frame->tramp);
-    env->gr[30] = sp;
-    env->gr[26] = sig;
-    env->gr[25] = h2g(&frame->info);
-    env->gr[24] = h2g(&frame->uc);
-
-    haddr = ka->_sa_handler;
-    if (haddr & 2) {
-        /* Function descriptor.  */
-        target_ulong *fdesc, dest;
-
-        haddr &= -4;
-        if (!lock_user_struct(VERIFY_READ, fdesc, haddr, 1)) {
-            goto give_sigsegv;
-        }
-        __get_user(dest, fdesc);
-        __get_user(env->gr[19], fdesc + 1);
-        unlock_user_struct(fdesc, haddr, 1);
-        haddr = dest;
-    }
-    env->iaoq_f = haddr;
-    env->iaoq_b = haddr + 4;
-    return;
-
- give_sigsegv:
-    force_sigsegv(sig);
-}
-
-long do_rt_sigreturn(CPUArchState *env)
-{
-    abi_ulong frame_addr = env->gr[30] - PARISC_RT_SIGFRAME_SIZE32;
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
-    unlock_user_struct(frame, frame_addr, 0);
-
-    if (do_sigaltstack(frame_addr + offsetof(struct target_rt_sigframe,
-                                             uc.tuc_stack),
-                       0, env->gr[30]) == -EFAULT) {
-        goto badframe;
-    }
-
-    unlock_user_struct(frame, frame_addr, 0);
-    return -TARGET_QEMU_ESIGRETURN;
-
- badframe:
-    force_sig(TARGET_SIGSEGV);
-    return -TARGET_QEMU_ESIGRETURN;
-}
-
 #elif defined(TARGET_XTENSA)
 
 struct target_sigcontext {
-- 
2.14.3
