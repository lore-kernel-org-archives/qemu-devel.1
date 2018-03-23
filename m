Received: from eggs.gnu.org ([2001:4830:134:3::10]:45326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdY-0004jW-DW
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdV-0000Zq-7J
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:16 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 23 Mar 2018 23:57:24 +0100
Message-Id: <20180323225739.17329-6-laurent@vivier.eu>
In-Reply-To: <20180323225739.17329-1-laurent@vivier.eu>
References: <20180323225739.17329-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 v2 05/20] linux-user: move microblaze
 signal.c parts to microblaze directory
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
microblaze/signal.c, except adding includes and
exporting setup_frame() and setup_rt_frame().

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/microblaze/signal.c        | 230 ++++++++++++++++++++++++++++++++++
 linux-user/microblaze/target_signal.h |   6 +-
 linux-user/signal.c                   | 227 ---------------------------------
 3 files changed, 235 insertions(+), 228 deletions(-)

diff --git a/linux-user/microblaze/signal.c b/linux-user/microblaze/signal.c
index 02ca338b6c..5572baa7dc 100644
--- a/linux-user/microblaze/signal.c
+++ b/linux-user/microblaze/signal.c
@@ -16,3 +16,233 @@
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
+};
+
+struct target_stack_t {
+    abi_ulong ss_sp;
+    int ss_flags;
+    unsigned int ss_size;
+};
+
+struct target_ucontext {
+    abi_ulong tuc_flags;
+    abi_ulong tuc_link;
+    struct target_stack_t tuc_stack;
+    struct target_sigcontext tuc_mcontext;
+    uint32_t tuc_extramask[TARGET_NSIG_WORDS - 1];
+};
+
+/* Signal frames. */
+struct target_signal_frame {
+    struct target_ucontext uc;
+    uint32_t extramask[TARGET_NSIG_WORDS - 1];
+    uint32_t tramp[2];
+};
+
+struct rt_signal_frame {
+    siginfo_t info;
+    ucontext_t uc;
+    uint32_t tramp[2];
+};
+
+static void setup_sigcontext(struct target_sigcontext *sc, CPUMBState *env)
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
+    __put_user(env->regs[14], &sc->regs.r14);
+    __put_user(env->regs[15], &sc->regs.r15);
+    __put_user(env->regs[16], &sc->regs.r16);
+    __put_user(env->regs[17], &sc->regs.r17);
+    __put_user(env->regs[18], &sc->regs.r18);
+    __put_user(env->regs[19], &sc->regs.r19);
+    __put_user(env->regs[20], &sc->regs.r20);
+    __put_user(env->regs[21], &sc->regs.r21);
+    __put_user(env->regs[22], &sc->regs.r22);
+    __put_user(env->regs[23], &sc->regs.r23);
+    __put_user(env->regs[24], &sc->regs.r24);
+    __put_user(env->regs[25], &sc->regs.r25);
+    __put_user(env->regs[26], &sc->regs.r26);
+    __put_user(env->regs[27], &sc->regs.r27);
+    __put_user(env->regs[28], &sc->regs.r28);
+    __put_user(env->regs[29], &sc->regs.r29);
+    __put_user(env->regs[30], &sc->regs.r30);
+    __put_user(env->regs[31], &sc->regs.r31);
+    __put_user(env->sregs[SR_PC], &sc->regs.pc);
+}
+
+static void restore_sigcontext(struct target_sigcontext *sc, CPUMBState *env)
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
+    __get_user(env->regs[14], &sc->regs.r14);
+    __get_user(env->regs[15], &sc->regs.r15);
+    __get_user(env->regs[16], &sc->regs.r16);
+    __get_user(env->regs[17], &sc->regs.r17);
+    __get_user(env->regs[18], &sc->regs.r18);
+    __get_user(env->regs[19], &sc->regs.r19);
+    __get_user(env->regs[20], &sc->regs.r20);
+    __get_user(env->regs[21], &sc->regs.r21);
+    __get_user(env->regs[22], &sc->regs.r22);
+    __get_user(env->regs[23], &sc->regs.r23);
+    __get_user(env->regs[24], &sc->regs.r24);
+    __get_user(env->regs[25], &sc->regs.r25);
+    __get_user(env->regs[26], &sc->regs.r26);
+    __get_user(env->regs[27], &sc->regs.r27);
+    __get_user(env->regs[28], &sc->regs.r28);
+    __get_user(env->regs[29], &sc->regs.r29);
+    __get_user(env->regs[30], &sc->regs.r30);
+    __get_user(env->regs[31], &sc->regs.r31);
+    __get_user(env->sregs[SR_PC], &sc->regs.pc);
+}
+
+static abi_ulong get_sigframe(struct target_sigaction *ka,
+                              CPUMBState *env, int frame_size)
+{
+    abi_ulong sp = env->regs[1];
+
+    if ((ka->sa_flags & TARGET_SA_ONSTACK) != 0 && !on_sig_stack(sp)) {
+        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
+    }
+
+    return ((sp - frame_size) & -8UL);
+}
+
+void setup_frame(int sig, struct target_sigaction *ka,
+                 target_sigset_t *set, CPUMBState *env)
+{
+    struct target_signal_frame *frame;
+    abi_ulong frame_addr;
+    int i;
+
+    frame_addr = get_sigframe(ka, env, sizeof *frame);
+    trace_user_setup_frame(env, frame_addr);
+    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
+        goto badframe;
+
+    /* Save the mask.  */
+    __put_user(set->sig[0], &frame->uc.tuc_mcontext.oldmask);
+
+    for(i = 1; i < TARGET_NSIG_WORDS; i++) {
+        __put_user(set->sig[i], &frame->extramask[i - 1]);
+    }
+
+    setup_sigcontext(&frame->uc.tuc_mcontext, env);
+
+    /* Set up to return from userspace. If provided, use a stub
+       already in userspace. */
+    /* minus 8 is offset to cater for "rtsd r15,8" offset */
+    if (ka->sa_flags & TARGET_SA_RESTORER) {
+        env->regs[15] = ((unsigned long)ka->sa_restorer)-8;
+    } else {
+        uint32_t t;
+        /* Note, these encodings are _big endian_! */
+        /* addi r12, r0, __NR_sigreturn */
+        t = 0x31800000UL | TARGET_NR_sigreturn;
+        __put_user(t, frame->tramp + 0);
+        /* brki r14, 0x8 */
+        t = 0xb9cc0008UL;
+        __put_user(t, frame->tramp + 1);
+
+        /* Return from sighandler will jump to the tramp.
+           Negative 8 offset because return is rtsd r15, 8 */
+        env->regs[15] = frame_addr + offsetof(struct target_signal_frame, tramp)
+                                   - 8;
+    }
+
+    /* Set up registers for signal handler */
+    env->regs[1] = frame_addr;
+    /* Signal handler args: */
+    env->regs[5] = sig; /* Arg 0: signum */
+    env->regs[6] = 0;
+    /* arg 1: sigcontext */
+    env->regs[7] = frame_addr += offsetof(typeof(*frame), uc);
+
+    /* Offset of 4 to handle microblaze rtid r14, 0 */
+    env->sregs[SR_PC] = (unsigned long)ka->_sa_handler;
+
+    unlock_user_struct(frame, frame_addr, 1);
+    return;
+badframe:
+    force_sigsegv(sig);
+}
+
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                    target_sigset_t *set, CPUMBState *env)
+{
+    fprintf(stderr, "Microblaze setup_rt_frame: not implemented\n");
+}
+
+long do_sigreturn(CPUMBState *env)
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
+    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 1))
+        goto badframe;
+
+    /* Restore blocked signals */
+    __get_user(target_set.sig[0], &frame->uc.tuc_mcontext.oldmask);
+    for(i = 1; i < TARGET_NSIG_WORDS; i++) {
+        __get_user(target_set.sig[i], &frame->extramask[i - 1]);
+    }
+    target_to_host_sigset_internal(&set, &target_set);
+    set_sigmask(&set);
+
+    restore_sigcontext(&frame->uc.tuc_mcontext, env);
+    /* We got here through a sigreturn syscall, our path back is via an
+       rtb insn so setup r14 for that.  */
+    env->regs[14] = env->sregs[SR_PC];
+
+    unlock_user_struct(frame, frame_addr, 0);
+    return -TARGET_QEMU_ESIGRETURN;
+badframe:
+    force_sig(TARGET_SIGSEGV);
+    return -TARGET_QEMU_ESIGRETURN;
+}
+
+long do_rt_sigreturn(CPUMBState *env)
+{
+    trace_user_do_rt_sigreturn(env, 0);
+    fprintf(stderr, "Microblaze do_rt_sigreturn: not implemented\n");
+    return -TARGET_ENOSYS;
+}
diff --git a/linux-user/microblaze/target_signal.h b/linux-user/microblaze/target_signal.h
index de2b0f49d5..7b25a34256 100644
--- a/linux-user/microblaze/target_signal.h
+++ b/linux-user/microblaze/target_signal.h
@@ -26,5 +26,9 @@ static inline abi_ulong get_sp_from_cpustate(CPUMBState *state)
     return state->regs[14];
 }
 
-
+void setup_frame(int sig, struct target_sigaction *ka,
+                 target_sigset_t *set, CPUMBState *env);
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                    target_sigset_t *set, CPUMBState *env);
 #endif /* MICROBLAZE_TARGET_SIGNAL_H */
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 1302d2c716..11c3062f0d 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -2364,233 +2364,6 @@ badframe:
     return -TARGET_QEMU_ESIGRETURN;
 }
 
-#elif defined(TARGET_MICROBLAZE)
-
-struct target_sigcontext {
-    struct target_pt_regs regs;  /* needs to be first */
-    uint32_t oldmask;
-};
-
-struct target_stack_t {
-    abi_ulong ss_sp;
-    int ss_flags;
-    unsigned int ss_size;
-};
-
-struct target_ucontext {
-    abi_ulong tuc_flags;
-    abi_ulong tuc_link;
-    struct target_stack_t tuc_stack;
-    struct target_sigcontext tuc_mcontext;
-    uint32_t tuc_extramask[TARGET_NSIG_WORDS - 1];
-};
-
-/* Signal frames. */
-struct target_signal_frame {
-    struct target_ucontext uc;
-    uint32_t extramask[TARGET_NSIG_WORDS - 1];
-    uint32_t tramp[2];
-};
-
-struct rt_signal_frame {
-    siginfo_t info;
-    ucontext_t uc;
-    uint32_t tramp[2];
-};
-
-static void setup_sigcontext(struct target_sigcontext *sc, CPUMBState *env)
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
-    __put_user(env->regs[14], &sc->regs.r14);
-    __put_user(env->regs[15], &sc->regs.r15);
-    __put_user(env->regs[16], &sc->regs.r16);
-    __put_user(env->regs[17], &sc->regs.r17);
-    __put_user(env->regs[18], &sc->regs.r18);
-    __put_user(env->regs[19], &sc->regs.r19);
-    __put_user(env->regs[20], &sc->regs.r20);
-    __put_user(env->regs[21], &sc->regs.r21);
-    __put_user(env->regs[22], &sc->regs.r22);
-    __put_user(env->regs[23], &sc->regs.r23);
-    __put_user(env->regs[24], &sc->regs.r24);
-    __put_user(env->regs[25], &sc->regs.r25);
-    __put_user(env->regs[26], &sc->regs.r26);
-    __put_user(env->regs[27], &sc->regs.r27);
-    __put_user(env->regs[28], &sc->regs.r28);
-    __put_user(env->regs[29], &sc->regs.r29);
-    __put_user(env->regs[30], &sc->regs.r30);
-    __put_user(env->regs[31], &sc->regs.r31);
-    __put_user(env->sregs[SR_PC], &sc->regs.pc);
-}
-
-static void restore_sigcontext(struct target_sigcontext *sc, CPUMBState *env)
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
-    __get_user(env->regs[14], &sc->regs.r14);
-    __get_user(env->regs[15], &sc->regs.r15);
-    __get_user(env->regs[16], &sc->regs.r16);
-    __get_user(env->regs[17], &sc->regs.r17);
-    __get_user(env->regs[18], &sc->regs.r18);
-    __get_user(env->regs[19], &sc->regs.r19);
-    __get_user(env->regs[20], &sc->regs.r20);
-    __get_user(env->regs[21], &sc->regs.r21);
-    __get_user(env->regs[22], &sc->regs.r22);
-    __get_user(env->regs[23], &sc->regs.r23);
-    __get_user(env->regs[24], &sc->regs.r24);
-    __get_user(env->regs[25], &sc->regs.r25);
-    __get_user(env->regs[26], &sc->regs.r26);
-    __get_user(env->regs[27], &sc->regs.r27);
-    __get_user(env->regs[28], &sc->regs.r28);
-    __get_user(env->regs[29], &sc->regs.r29);
-    __get_user(env->regs[30], &sc->regs.r30);
-    __get_user(env->regs[31], &sc->regs.r31);
-    __get_user(env->sregs[SR_PC], &sc->regs.pc);
-}
-
-static abi_ulong get_sigframe(struct target_sigaction *ka,
-                              CPUMBState *env, int frame_size)
-{
-    abi_ulong sp = env->regs[1];
-
-    if ((ka->sa_flags & TARGET_SA_ONSTACK) != 0 && !on_sig_stack(sp)) {
-        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-    }
-
-    return ((sp - frame_size) & -8UL);
-}
-
-static void setup_frame(int sig, struct target_sigaction *ka,
-                        target_sigset_t *set, CPUMBState *env)
-{
-    struct target_signal_frame *frame;
-    abi_ulong frame_addr;
-    int i;
-
-    frame_addr = get_sigframe(ka, env, sizeof *frame);
-    trace_user_setup_frame(env, frame_addr);
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
-        goto badframe;
-
-    /* Save the mask.  */
-    __put_user(set->sig[0], &frame->uc.tuc_mcontext.oldmask);
-
-    for(i = 1; i < TARGET_NSIG_WORDS; i++) {
-        __put_user(set->sig[i], &frame->extramask[i - 1]);
-    }
-
-    setup_sigcontext(&frame->uc.tuc_mcontext, env);
-
-    /* Set up to return from userspace. If provided, use a stub
-       already in userspace. */
-    /* minus 8 is offset to cater for "rtsd r15,8" offset */
-    if (ka->sa_flags & TARGET_SA_RESTORER) {
-        env->regs[15] = ((unsigned long)ka->sa_restorer)-8;
-    } else {
-        uint32_t t;
-        /* Note, these encodings are _big endian_! */
-        /* addi r12, r0, __NR_sigreturn */
-        t = 0x31800000UL | TARGET_NR_sigreturn;
-        __put_user(t, frame->tramp + 0);
-        /* brki r14, 0x8 */
-        t = 0xb9cc0008UL;
-        __put_user(t, frame->tramp + 1);
-
-        /* Return from sighandler will jump to the tramp.
-           Negative 8 offset because return is rtsd r15, 8 */
-        env->regs[15] = frame_addr + offsetof(struct target_signal_frame, tramp)
-                                   - 8;
-    }
-
-    /* Set up registers for signal handler */
-    env->regs[1] = frame_addr;
-    /* Signal handler args: */
-    env->regs[5] = sig; /* Arg 0: signum */
-    env->regs[6] = 0;
-    /* arg 1: sigcontext */
-    env->regs[7] = frame_addr += offsetof(typeof(*frame), uc);
-
-    /* Offset of 4 to handle microblaze rtid r14, 0 */
-    env->sregs[SR_PC] = (unsigned long)ka->_sa_handler;
-
-    unlock_user_struct(frame, frame_addr, 1);
-    return;
-badframe:
-    force_sigsegv(sig);
-}
-
-static void setup_rt_frame(int sig, struct target_sigaction *ka,
-                           target_siginfo_t *info,
-                           target_sigset_t *set, CPUMBState *env)
-{
-    fprintf(stderr, "Microblaze setup_rt_frame: not implemented\n");
-}
-
-long do_sigreturn(CPUMBState *env)
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
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 1))
-        goto badframe;
-
-    /* Restore blocked signals */
-    __get_user(target_set.sig[0], &frame->uc.tuc_mcontext.oldmask);
-    for(i = 1; i < TARGET_NSIG_WORDS; i++) {
-        __get_user(target_set.sig[i], &frame->extramask[i - 1]);
-    }
-    target_to_host_sigset_internal(&set, &target_set);
-    set_sigmask(&set);
-
-    restore_sigcontext(&frame->uc.tuc_mcontext, env);
-    /* We got here through a sigreturn syscall, our path back is via an
-       rtb insn so setup r14 for that.  */
-    env->regs[14] = env->sregs[SR_PC];
-
-    unlock_user_struct(frame, frame_addr, 0);
-    return -TARGET_QEMU_ESIGRETURN;
-badframe:
-    force_sig(TARGET_SIGSEGV);
-    return -TARGET_QEMU_ESIGRETURN;
-}
-
-long do_rt_sigreturn(CPUMBState *env)
-{
-    trace_user_do_rt_sigreturn(env, 0);
-    fprintf(stderr, "Microblaze do_rt_sigreturn: not implemented\n");
-    return -TARGET_ENOSYS;
-}
-
 #elif defined(TARGET_CRIS)
 
 struct target_sigcontext {
-- 
2.14.3
