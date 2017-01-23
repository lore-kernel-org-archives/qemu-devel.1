Received: from eggs.gnu.org ([2001:4830:134:3::10]:46649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUD0-0007o0-92
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUCz-0004vM-0A
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:14 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVUCy-0004vH-RL
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:12 -0500
Received: by mail-qt0-x242.google.com with SMTP id f4so14077454qte.2
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 18:18:12 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun, 22 Jan 2017 18:17:37 -0800
Message-Id: <20170123021748.13170-16-rth@twiddle.net>
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 15/26] linux-user: Add HPPA signal handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/signal.c | 191 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 190 insertions(+), 1 deletion(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index c750053..0a5bb4e 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -5888,6 +5888,195 @@ long do_rt_sigreturn(CPUTLGState *env)
     return -TARGET_QEMU_ESIGRETURN;
 }
 
+#elif defined(TARGET_HPPA)
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
+    __put_user(env->sar, &sc->sc_sar);
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
+    __get_user(env->sar, &sc->sc_sar);
+}
+
+/* No, this doesn't look right, but it's copied straight from the kernel.  */
+#define PARISC_RT_SIGFRAME_SIZE32 \
+    ((sizeof(struct target_rt_sigframe) + 48 + 64) & -64)
+
+static void setup_rt_frame(int sig, struct target_sigaction *ka,
+                           target_siginfo_t *info,
+                           target_sigset_t *set, CPUArchState *env)
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
+    env->iaoq_b = haddr + 4;;
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
+
 #else
 
 static void setup_frame(int sig, struct target_sigaction *ka,
@@ -5989,7 +6178,7 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
         /* prepare the stack frame of the virtual CPU */
 #if defined(TARGET_ABI_MIPSN32) || defined(TARGET_ABI_MIPSN64) \
         || defined(TARGET_OPENRISC) || defined(TARGET_TILEGX) \
-        || defined(TARGET_PPC64)
+        || defined(TARGET_PPC64) || defined(TARGET_HPPA)
         /* These targets do not have traditional signals.  */
         setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
 #else
-- 
2.9.3
