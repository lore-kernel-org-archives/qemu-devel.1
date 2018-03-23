Received: from eggs.gnu.org ([2001:4830:134:3::10]:45740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdx-0005FS-U5
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdt-0000wu-H3
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:41 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 23 Mar 2018 23:57:34 +0100
Message-Id: <20180323225739.17329-16-laurent@vivier.eu>
In-Reply-To: <20180323225739.17329-1-laurent@vivier.eu>
References: <20180323225739.17329-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 v2 15/20] linux-user: move xtensa
 signal.c parts to xtensa directory
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
xtensa/signal.c, except adding includes and
exporting setup_rt_frame().

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/signal.c               | 253 -------------------------------------
 linux-user/xtensa/signal.c        | 257 ++++++++++++++++++++++++++++++++++++++
 linux-user/xtensa/target_signal.h |   3 +
 3 files changed, 260 insertions(+), 253 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index fc81ec87b6..f039157970 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -3032,259 +3032,6 @@ sigsegv:
     return -TARGET_QEMU_ESIGRETURN;
 }
 
-#elif defined(TARGET_XTENSA)
-
-struct target_sigcontext {
-    abi_ulong sc_pc;
-    abi_ulong sc_ps;
-    abi_ulong sc_lbeg;
-    abi_ulong sc_lend;
-    abi_ulong sc_lcount;
-    abi_ulong sc_sar;
-    abi_ulong sc_acclo;
-    abi_ulong sc_acchi;
-    abi_ulong sc_a[16];
-    abi_ulong sc_xtregs;
-};
-
-struct target_ucontext {
-    abi_ulong tuc_flags;
-    abi_ulong tuc_link;
-    target_stack_t tuc_stack;
-    struct target_sigcontext tuc_mcontext;
-    target_sigset_t tuc_sigmask;
-};
-
-struct target_rt_sigframe {
-    target_siginfo_t info;
-    struct target_ucontext uc;
-    /* TODO: xtregs */
-    uint8_t retcode[6];
-    abi_ulong window[4];
-};
-
-static abi_ulong get_sigframe(struct target_sigaction *sa,
-                              CPUXtensaState *env,
-                              unsigned long framesize)
-{
-    abi_ulong sp = env->regs[1];
-
-    /* This is the X/Open sanctioned signal stack switching.  */
-    if ((sa->sa_flags & TARGET_SA_ONSTACK) != 0 && !sas_ss_flags(sp)) {
-        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-    }
-    return (sp - framesize) & -16;
-}
-
-static int flush_window_regs(CPUXtensaState *env)
-{
-    const uint32_t nareg_mask = env->config->nareg - 1;
-    uint32_t wb = env->sregs[WINDOW_BASE];
-    uint32_t ws = (xtensa_replicate_windowstart(env) >> (wb + 1)) &
-        ((1 << env->config->nareg / 4) - 1);
-    uint32_t d = ctz32(ws) + 1;
-    uint32_t sp;
-    abi_long ret = 0;
-
-    wb += d;
-    ws >>= d;
-
-    xtensa_sync_phys_from_window(env);
-    sp = env->phys_regs[(wb * 4 + 1) & nareg_mask];
-
-    while (ws && ret == 0) {
-        int d;
-        int i;
-        int idx;
-
-        if (ws & 0x1) {
-            ws >>= 1;
-            d = 1;
-        } else if (ws & 0x2) {
-            ws >>= 2;
-            d = 2;
-            for (i = 0; i < 4; ++i) {
-                idx = (wb * 4 + 4 + i) & nareg_mask;
-                ret |= put_user_ual(env->phys_regs[idx], sp + (i - 12) * 4);
-            }
-        } else if (ws & 0x4) {
-            ws >>= 3;
-            d = 3;
-            for (i = 0; i < 8; ++i) {
-                idx = (wb * 4 + 4 + i) & nareg_mask;
-                ret |= put_user_ual(env->phys_regs[idx], sp + (i - 16) * 4);
-            }
-        } else {
-            g_assert_not_reached();
-        }
-        sp = env->phys_regs[((wb + d) * 4 + 1) & nareg_mask];
-        for (i = 0; i < 4; ++i) {
-            idx = (wb * 4 + i) & nareg_mask;
-            ret |= put_user_ual(env->phys_regs[idx], sp + (i - 4) * 4);
-        }
-        wb += d;
-    }
-    return ret == 0;
-}
-
-static int setup_sigcontext(struct target_rt_sigframe *frame,
-                            CPUXtensaState *env)
-{
-    struct target_sigcontext *sc = &frame->uc.tuc_mcontext;
-    int i;
-
-    __put_user(env->pc, &sc->sc_pc);
-    __put_user(env->sregs[PS], &sc->sc_ps);
-    __put_user(env->sregs[LBEG], &sc->sc_lbeg);
-    __put_user(env->sregs[LEND], &sc->sc_lend);
-    __put_user(env->sregs[LCOUNT], &sc->sc_lcount);
-    if (!flush_window_regs(env)) {
-        return 0;
-    }
-    for (i = 0; i < 16; ++i) {
-        __put_user(env->regs[i], sc->sc_a + i);
-    }
-    __put_user(0, &sc->sc_xtregs);
-    /* TODO: xtregs */
-    return 1;
-}
-
-static void setup_rt_frame(int sig, struct target_sigaction *ka,
-                           target_siginfo_t *info,
-                           target_sigset_t *set, CPUXtensaState *env)
-{
-    abi_ulong frame_addr;
-    struct target_rt_sigframe *frame;
-    uint32_t ra;
-    int i;
-
-    frame_addr = get_sigframe(ka, env, sizeof(*frame));
-    trace_user_setup_rt_frame(env, frame_addr);
-
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
-        goto give_sigsegv;
-    }
-
-    if (ka->sa_flags & SA_SIGINFO) {
-        tswap_siginfo(&frame->info, info);
-    }
-
-    __put_user(0, &frame->uc.tuc_flags);
-    __put_user(0, &frame->uc.tuc_link);
-    __put_user(target_sigaltstack_used.ss_sp,
-               &frame->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(env->regs[1]),
-               &frame->uc.tuc_stack.ss_flags);
-    __put_user(target_sigaltstack_used.ss_size,
-               &frame->uc.tuc_stack.ss_size);
-    if (!setup_sigcontext(frame, env)) {
-        unlock_user_struct(frame, frame_addr, 0);
-        goto give_sigsegv;
-    }
-    for (i = 0; i < TARGET_NSIG_WORDS; ++i) {
-        __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
-    }
-
-    if (ka->sa_flags & TARGET_SA_RESTORER) {
-        ra = ka->sa_restorer;
-    } else {
-        ra = frame_addr + offsetof(struct target_rt_sigframe, retcode);
-#ifdef TARGET_WORDS_BIGENDIAN
-        /* Generate instruction:  MOVI a2, __NR_rt_sigreturn */
-        __put_user(0x22, &frame->retcode[0]);
-        __put_user(0x0a, &frame->retcode[1]);
-        __put_user(TARGET_NR_rt_sigreturn, &frame->retcode[2]);
-        /* Generate instruction:  SYSCALL */
-        __put_user(0x00, &frame->retcode[3]);
-        __put_user(0x05, &frame->retcode[4]);
-        __put_user(0x00, &frame->retcode[5]);
-#else
-        /* Generate instruction:  MOVI a2, __NR_rt_sigreturn */
-        __put_user(0x22, &frame->retcode[0]);
-        __put_user(0xa0, &frame->retcode[1]);
-        __put_user(TARGET_NR_rt_sigreturn, &frame->retcode[2]);
-        /* Generate instruction:  SYSCALL */
-        __put_user(0x00, &frame->retcode[3]);
-        __put_user(0x50, &frame->retcode[4]);
-        __put_user(0x00, &frame->retcode[5]);
-#endif
-    }
-    env->sregs[PS] = PS_UM | (3 << PS_RING_SHIFT);
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_WINDOWED_REGISTER)) {
-        env->sregs[PS] |= PS_WOE | (1 << PS_CALLINC_SHIFT);
-    }
-    memset(env->regs, 0, sizeof(env->regs));
-    env->pc = ka->_sa_handler;
-    env->regs[1] = frame_addr;
-    env->sregs[WINDOW_BASE] = 0;
-    env->sregs[WINDOW_START] = 1;
-
-    env->regs[4] = (ra & 0x3fffffff) | 0x40000000;
-    env->regs[6] = sig;
-    env->regs[7] = frame_addr + offsetof(struct target_rt_sigframe, info);
-    env->regs[8] = frame_addr + offsetof(struct target_rt_sigframe, uc);
-    unlock_user_struct(frame, frame_addr, 1);
-    return;
-
-give_sigsegv:
-    force_sigsegv(sig);
-    return;
-}
-
-static void restore_sigcontext(CPUXtensaState *env,
-                               struct target_rt_sigframe *frame)
-{
-    struct target_sigcontext *sc = &frame->uc.tuc_mcontext;
-    uint32_t ps;
-    int i;
-
-    __get_user(env->pc, &sc->sc_pc);
-    __get_user(ps, &sc->sc_ps);
-    __get_user(env->sregs[LBEG], &sc->sc_lbeg);
-    __get_user(env->sregs[LEND], &sc->sc_lend);
-    __get_user(env->sregs[LCOUNT], &sc->sc_lcount);
-
-    env->sregs[WINDOW_BASE] = 0;
-    env->sregs[WINDOW_START] = 1;
-    env->sregs[PS] = deposit32(env->sregs[PS],
-                               PS_CALLINC_SHIFT,
-                               PS_CALLINC_LEN,
-                               extract32(ps, PS_CALLINC_SHIFT,
-                                         PS_CALLINC_LEN));
-    for (i = 0; i < 16; ++i) {
-        __get_user(env->regs[i], sc->sc_a + i);
-    }
-    /* TODO: xtregs */
-}
-
-long do_rt_sigreturn(CPUXtensaState *env)
-{
-    abi_ulong frame_addr = env->regs[1];
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
-    restore_sigcontext(env, frame);
-
-    if (do_sigaltstack(frame_addr +
-                       offsetof(struct target_rt_sigframe, uc.tuc_stack),
-                       0, get_sp_from_cpustate(env)) == -TARGET_EFAULT) {
-        goto badframe;
-    }
-    unlock_user_struct(frame, frame_addr, 0);
-    return -TARGET_QEMU_ESIGRETURN;
-
-badframe:
-    unlock_user_struct(frame, frame_addr, 0);
-    force_sig(TARGET_SIGSEGV);
-    return -TARGET_QEMU_ESIGRETURN;
-}
 #endif
 
 static void handle_pending_signal(CPUArchState *cpu_env, int sig,
diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
index 02ca338b6c..e4e032e954 100644
--- a/linux-user/xtensa/signal.c
+++ b/linux-user/xtensa/signal.c
@@ -16,3 +16,260 @@
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
+    abi_ulong sc_pc;
+    abi_ulong sc_ps;
+    abi_ulong sc_lbeg;
+    abi_ulong sc_lend;
+    abi_ulong sc_lcount;
+    abi_ulong sc_sar;
+    abi_ulong sc_acclo;
+    abi_ulong sc_acchi;
+    abi_ulong sc_a[16];
+    abi_ulong sc_xtregs;
+};
+
+struct target_ucontext {
+    abi_ulong tuc_flags;
+    abi_ulong tuc_link;
+    target_stack_t tuc_stack;
+    struct target_sigcontext tuc_mcontext;
+    target_sigset_t tuc_sigmask;
+};
+
+struct target_rt_sigframe {
+    target_siginfo_t info;
+    struct target_ucontext uc;
+    /* TODO: xtregs */
+    uint8_t retcode[6];
+    abi_ulong window[4];
+};
+
+static abi_ulong get_sigframe(struct target_sigaction *sa,
+                              CPUXtensaState *env,
+                              unsigned long framesize)
+{
+    abi_ulong sp = env->regs[1];
+
+    /* This is the X/Open sanctioned signal stack switching.  */
+    if ((sa->sa_flags & TARGET_SA_ONSTACK) != 0 && !sas_ss_flags(sp)) {
+        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
+    }
+    return (sp - framesize) & -16;
+}
+
+static int flush_window_regs(CPUXtensaState *env)
+{
+    const uint32_t nareg_mask = env->config->nareg - 1;
+    uint32_t wb = env->sregs[WINDOW_BASE];
+    uint32_t ws = (xtensa_replicate_windowstart(env) >> (wb + 1)) &
+        ((1 << env->config->nareg / 4) - 1);
+    uint32_t d = ctz32(ws) + 1;
+    uint32_t sp;
+    abi_long ret = 0;
+
+    wb += d;
+    ws >>= d;
+
+    xtensa_sync_phys_from_window(env);
+    sp = env->phys_regs[(wb * 4 + 1) & nareg_mask];
+
+    while (ws && ret == 0) {
+        int d;
+        int i;
+        int idx;
+
+        if (ws & 0x1) {
+            ws >>= 1;
+            d = 1;
+        } else if (ws & 0x2) {
+            ws >>= 2;
+            d = 2;
+            for (i = 0; i < 4; ++i) {
+                idx = (wb * 4 + 4 + i) & nareg_mask;
+                ret |= put_user_ual(env->phys_regs[idx], sp + (i - 12) * 4);
+            }
+        } else if (ws & 0x4) {
+            ws >>= 3;
+            d = 3;
+            for (i = 0; i < 8; ++i) {
+                idx = (wb * 4 + 4 + i) & nareg_mask;
+                ret |= put_user_ual(env->phys_regs[idx], sp + (i - 16) * 4);
+            }
+        } else {
+            g_assert_not_reached();
+        }
+        sp = env->phys_regs[((wb + d) * 4 + 1) & nareg_mask];
+        for (i = 0; i < 4; ++i) {
+            idx = (wb * 4 + i) & nareg_mask;
+            ret |= put_user_ual(env->phys_regs[idx], sp + (i - 4) * 4);
+        }
+        wb += d;
+    }
+    return ret == 0;
+}
+
+static int setup_sigcontext(struct target_rt_sigframe *frame,
+                            CPUXtensaState *env)
+{
+    struct target_sigcontext *sc = &frame->uc.tuc_mcontext;
+    int i;
+
+    __put_user(env->pc, &sc->sc_pc);
+    __put_user(env->sregs[PS], &sc->sc_ps);
+    __put_user(env->sregs[LBEG], &sc->sc_lbeg);
+    __put_user(env->sregs[LEND], &sc->sc_lend);
+    __put_user(env->sregs[LCOUNT], &sc->sc_lcount);
+    if (!flush_window_regs(env)) {
+        return 0;
+    }
+    for (i = 0; i < 16; ++i) {
+        __put_user(env->regs[i], sc->sc_a + i);
+    }
+    __put_user(0, &sc->sc_xtregs);
+    /* TODO: xtregs */
+    return 1;
+}
+
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                    target_sigset_t *set, CPUXtensaState *env)
+{
+    abi_ulong frame_addr;
+    struct target_rt_sigframe *frame;
+    uint32_t ra;
+    int i;
+
+    frame_addr = get_sigframe(ka, env, sizeof(*frame));
+    trace_user_setup_rt_frame(env, frame_addr);
+
+    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
+        goto give_sigsegv;
+    }
+
+    if (ka->sa_flags & SA_SIGINFO) {
+        tswap_siginfo(&frame->info, info);
+    }
+
+    __put_user(0, &frame->uc.tuc_flags);
+    __put_user(0, &frame->uc.tuc_link);
+    __put_user(target_sigaltstack_used.ss_sp,
+               &frame->uc.tuc_stack.ss_sp);
+    __put_user(sas_ss_flags(env->regs[1]),
+               &frame->uc.tuc_stack.ss_flags);
+    __put_user(target_sigaltstack_used.ss_size,
+               &frame->uc.tuc_stack.ss_size);
+    if (!setup_sigcontext(frame, env)) {
+        unlock_user_struct(frame, frame_addr, 0);
+        goto give_sigsegv;
+    }
+    for (i = 0; i < TARGET_NSIG_WORDS; ++i) {
+        __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
+    }
+
+    if (ka->sa_flags & TARGET_SA_RESTORER) {
+        ra = ka->sa_restorer;
+    } else {
+        ra = frame_addr + offsetof(struct target_rt_sigframe, retcode);
+#ifdef TARGET_WORDS_BIGENDIAN
+        /* Generate instruction:  MOVI a2, __NR_rt_sigreturn */
+        __put_user(0x22, &frame->retcode[0]);
+        __put_user(0x0a, &frame->retcode[1]);
+        __put_user(TARGET_NR_rt_sigreturn, &frame->retcode[2]);
+        /* Generate instruction:  SYSCALL */
+        __put_user(0x00, &frame->retcode[3]);
+        __put_user(0x05, &frame->retcode[4]);
+        __put_user(0x00, &frame->retcode[5]);
+#else
+        /* Generate instruction:  MOVI a2, __NR_rt_sigreturn */
+        __put_user(0x22, &frame->retcode[0]);
+        __put_user(0xa0, &frame->retcode[1]);
+        __put_user(TARGET_NR_rt_sigreturn, &frame->retcode[2]);
+        /* Generate instruction:  SYSCALL */
+        __put_user(0x00, &frame->retcode[3]);
+        __put_user(0x50, &frame->retcode[4]);
+        __put_user(0x00, &frame->retcode[5]);
+#endif
+    }
+    env->sregs[PS] = PS_UM | (3 << PS_RING_SHIFT);
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_WINDOWED_REGISTER)) {
+        env->sregs[PS] |= PS_WOE | (1 << PS_CALLINC_SHIFT);
+    }
+    memset(env->regs, 0, sizeof(env->regs));
+    env->pc = ka->_sa_handler;
+    env->regs[1] = frame_addr;
+    env->sregs[WINDOW_BASE] = 0;
+    env->sregs[WINDOW_START] = 1;
+
+    env->regs[4] = (ra & 0x3fffffff) | 0x40000000;
+    env->regs[6] = sig;
+    env->regs[7] = frame_addr + offsetof(struct target_rt_sigframe, info);
+    env->regs[8] = frame_addr + offsetof(struct target_rt_sigframe, uc);
+    unlock_user_struct(frame, frame_addr, 1);
+    return;
+
+give_sigsegv:
+    force_sigsegv(sig);
+    return;
+}
+
+static void restore_sigcontext(CPUXtensaState *env,
+                               struct target_rt_sigframe *frame)
+{
+    struct target_sigcontext *sc = &frame->uc.tuc_mcontext;
+    uint32_t ps;
+    int i;
+
+    __get_user(env->pc, &sc->sc_pc);
+    __get_user(ps, &sc->sc_ps);
+    __get_user(env->sregs[LBEG], &sc->sc_lbeg);
+    __get_user(env->sregs[LEND], &sc->sc_lend);
+    __get_user(env->sregs[LCOUNT], &sc->sc_lcount);
+
+    env->sregs[WINDOW_BASE] = 0;
+    env->sregs[WINDOW_START] = 1;
+    env->sregs[PS] = deposit32(env->sregs[PS],
+                               PS_CALLINC_SHIFT,
+                               PS_CALLINC_LEN,
+                               extract32(ps, PS_CALLINC_SHIFT,
+                                         PS_CALLINC_LEN));
+    for (i = 0; i < 16; ++i) {
+        __get_user(env->regs[i], sc->sc_a + i);
+    }
+    /* TODO: xtregs */
+}
+
+long do_rt_sigreturn(CPUXtensaState *env)
+{
+    abi_ulong frame_addr = env->regs[1];
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
+    restore_sigcontext(env, frame);
+
+    if (do_sigaltstack(frame_addr +
+                       offsetof(struct target_rt_sigframe, uc.tuc_stack),
+                       0, get_sp_from_cpustate(env)) == -TARGET_EFAULT) {
+        goto badframe;
+    }
+    unlock_user_struct(frame, frame_addr, 0);
+    return -TARGET_QEMU_ESIGRETURN;
+
+badframe:
+    unlock_user_struct(frame, frame_addr, 0);
+    force_sig(TARGET_SIGSEGV);
+    return -TARGET_QEMU_ESIGRETURN;
+}
diff --git a/linux-user/xtensa/target_signal.h b/linux-user/xtensa/target_signal.h
index c6962e70af..f6545903a4 100644
--- a/linux-user/xtensa/target_signal.h
+++ b/linux-user/xtensa/target_signal.h
@@ -25,4 +25,7 @@ static inline abi_ulong get_sp_from_cpustate(CPUXtensaState *state)
     return state->regs[1];
 }
 
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                    target_sigset_t *set, CPUXtensaState *env);
 #endif
-- 
2.14.3
