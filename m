Received: from eggs.gnu.org ([2001:4830:134:3::10]:60509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cWBAn-0008Lx-3b
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 19:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cWBAj-0006OA-RI
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 19:10:49 -0500
Received: from mail-yb0-x242.google.com ([2607:f8b0:4002:c09::242]:34525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cWBAj-0006Nx-Lo
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 19:10:45 -0500
Received: by mail-yb0-x242.google.com with SMTP id w194so13941309ybe.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 16:10:44 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 24 Jan 2017 19:10:41 -0500
Message-Id: <20170125001041.14029-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [RFC PATCH] linux-user: Add signal handling for x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Allan Wirth <awirth@akamai.com>, Peter Maydell <peter.maydell@linaro.org>

Adopted from a previous patch posting:
https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg02079.html

CC: Allan Wirth <awirth@akamai.com>
CC: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 linux-user/signal.c      | 264 ++++++++++++++++++++++++++++++++++++++++-------
 target/i386/cpu.h        |   2 +
 target/i386/fpu_helper.c |  12 +++
 3 files changed, 242 insertions(+), 36 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 0a5bb4e26b..0248621d66 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -253,8 +253,7 @@ int do_sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
     return 0;
 }
 
-#if !defined(TARGET_OPENRISC) && !defined(TARGET_UNICORE32) && \
-    !defined(TARGET_X86_64)
+#if !defined(TARGET_OPENRISC) && !defined(TARGET_UNICORE32)
 /* Just set the guest's signal mask to the specified value; the
  * caller is assumed to have called block_signals() already.
  */
@@ -512,7 +511,7 @@ void signal_init(void)
     }
 }
 
-#if !(defined(TARGET_X86_64) || defined(TARGET_UNICORE32))
+#ifndef TARGET_UNICORE32
 /* Force a synchronously taken signal. The kernel force_sig() function
  * also forces the signal to "not blocked, not ignored", but for QEMU
  * that work is done in process_pending_signals().
@@ -819,9 +818,8 @@ int do_sigaction(int sig, const struct target_sigaction *act,
     return ret;
 }
 
-#if defined(TARGET_I386) && TARGET_ABI_BITS == 32
-
-/* from the Linux kernel */
+#if defined(TARGET_I386)
+/* from the Linux kernel - /arch/x86/include/uapi/asm/sigcontext.h */
 
 struct target_fpreg {
     uint16_t significand[4];
@@ -835,7 +833,7 @@ struct target_fpxreg {
 };
 
 struct target_xmmreg {
-    abi_ulong element[4];
+    uint32_t element[4];
 };
 
 struct target_fpstate {
@@ -860,33 +858,117 @@ struct target_fpstate {
     abi_ulong padding[56];
 };
 
-#define X86_FXSR_MAGIC		0x0000
+struct target_fpstate_32 {
+    /* Regular FPU environment */
+    uint32_t cw;
+    uint32_t sw;
+    uint32_t tag;
+    uint32_t ipoff;
+    uint32_t cssel;
+    uint32_t dataoff;
+    uint32_t datasel;
+    struct target_fpreg _st[8];
+    uint16_t  status;
+    uint16_t  magic;          /* 0xffff = regular FPU data only */
 
-struct target_sigcontext {
+    /* FXSR FPU environment */
+    uint32_t _fxsr_env[6];   /* FXSR FPU env is ignored */
+    uint32_t mxcsr;
+    uint32_t reserved;
+    struct target_fpxreg _fxsr_st[8]; /* FXSR FPU reg data is ignored */
+    struct target_xmmreg _xmm[8];
+    uint32_t padding[56];
+};
+
+struct target_fpstate_64 {
+    /* FXSAVE format */
+    uint16_t cw;
+    uint16_t sw;
+    uint16_t twd;
+    uint16_t fop;
+    uint64_t rip;
+    uint64_t rdp;
+    uint32_t mxcsr;
+    uint32_t mxcsr_mask;
+    uint32_t st_space[32];
+    uint32_t xmm_space[64];
+    uint32_t reserved[24];
+};
+
+#ifndef TARGET_X86_64
+# define target_fpstate target_fpstate_32
+#else
+# define target_fpstate target_fpstate_64
+#endif
+
+struct target_sigcontext_32 {
     uint16_t gs, __gsh;
     uint16_t fs, __fsh;
     uint16_t es, __esh;
     uint16_t ds, __dsh;
-    abi_ulong edi;
-    abi_ulong esi;
-    abi_ulong ebp;
-    abi_ulong esp;
-    abi_ulong ebx;
-    abi_ulong edx;
-    abi_ulong ecx;
-    abi_ulong eax;
-    abi_ulong trapno;
-    abi_ulong err;
-    abi_ulong eip;
+    uint32_t edi;
+    uint32_t esi;
+    uint32_t ebp;
+    uint32_t esp;
+    uint32_t ebx;
+    uint32_t edx;
+    uint32_t ecx;
+    uint32_t eax;
+    uint32_t trapno;
+    uint32_t err;
+    uint32_t eip;
     uint16_t cs, __csh;
-    abi_ulong eflags;
-    abi_ulong esp_at_signal;
+    uint32_t eflags;
+    uint32_t esp_at_signal;
     uint16_t ss, __ssh;
-    abi_ulong fpstate; /* pointer */
-    abi_ulong oldmask;
-    abi_ulong cr2;
+    uint32_t fpstate; /* pointer */
+    uint32_t oldmask;
+    uint32_t cr2;
+};
+
+struct target_sigcontext_64 {
+    uint64_t r8;
+    uint64_t r9;
+    uint64_t r10;
+    uint64_t r11;
+    uint64_t r12;
+    uint64_t r13;
+    uint64_t r14;
+    uint64_t r15;
+
+    uint64_t rdi;
+    uint64_t rsi;
+    uint64_t rbp;
+    uint64_t rbx;
+    uint64_t rdx;
+    uint64_t rax;
+    uint64_t rcx;
+    uint64_t rsp;
+    uint64_t rip;
+
+    uint64_t eflags;
+
+    uint16_t cs;
+    uint16_t gs;
+    uint16_t fs;
+    uint16_t ss;
+
+    uint64_t err;
+    uint64_t trapno;
+    uint64_t oldmask;
+    uint64_t cr2;
+
+    uint64_t fpstate; /* pointer */
+    uint64_t padding[8];
 };
 
+#ifndef TARGET_X86_64
+# define target_sigcontext target_sigcontext_32
+#else
+# define target_sigcontext target_sigcontext_64
+#endif
+
+/* see Linux/include/uapi/asm-generic/ucontext.h */
 struct target_ucontext {
     abi_ulong         tuc_flags;
     abi_ulong         tuc_link;
@@ -895,8 +977,8 @@ struct target_ucontext {
     target_sigset_t   tuc_sigmask;  /* mask last for extensibility */
 };
 
-struct sigframe
-{
+#ifndef TARGET_X86_64
+struct sigframe {
     abi_ulong pretcode;
     int sig;
     struct target_sigcontext sc;
@@ -905,8 +987,7 @@ struct sigframe
     char retcode[8];
 };
 
-struct rt_sigframe
-{
+struct rt_sigframe {
     abi_ulong pretcode;
     int sig;
     abi_ulong pinfo;
@@ -917,6 +998,17 @@ struct rt_sigframe
     char retcode[8];
 };
 
+#else
+
+struct rt_sigframe {
+    abi_ulong pretcode;
+    struct target_ucontext uc;
+    struct target_siginfo info;
+    struct target_fpstate fpstate;
+};
+
+#endif
+
 /*
  * Set up a signal frame.
  */
@@ -927,6 +1019,7 @@ static void setup_sigcontext(struct target_sigcontext *sc,
         abi_ulong fpstate_addr)
 {
     CPUState *cs = CPU(x86_env_get_cpu(env));
+#ifndef TARGET_X86_64
     uint16_t magic;
 
     /* already locked in setup_frame() */
@@ -959,12 +1052,49 @@ static void setup_sigcontext(struct target_sigcontext *sc,
     /* non-iBCS2 extensions.. */
     __put_user(mask, &sc->oldmask);
     __put_user(env->cr[2], &sc->cr2);
+#else
+    __put_user(env->regs[8], &sc->r8);
+    __put_user(env->regs[9], &sc->r9);
+    __put_user(env->regs[10], &sc->r10);
+    __put_user(env->regs[11], &sc->r11);
+    __put_user(env->regs[12], &sc->r12);
+    __put_user(env->regs[13], &sc->r13);
+    __put_user(env->regs[14], &sc->r14);
+    __put_user(env->regs[15], &sc->r15);
+
+    __put_user(env->regs[R_EDI], &sc->rdi);
+    __put_user(env->regs[R_ESI], &sc->rsi);
+    __put_user(env->regs[R_EBP], &sc->rbp);
+    __put_user(env->regs[R_EBX], &sc->rbx);
+    __put_user(env->regs[R_EDX], &sc->rdx);
+    __put_user(env->regs[R_EAX], &sc->rax);
+    __put_user(env->regs[R_ECX], &sc->rcx);
+    __put_user(env->regs[R_ESP], &sc->rsp);
+    __put_user(env->eip, &sc->rip);
+
+    __put_user(env->eflags, &sc->eflags);
+
+    __put_user(env->segs[R_CS].selector, &sc->cs);
+    __put_user((uint16_t)0, &sc->gs);
+    __put_user((uint16_t)0, &sc->fs);
+    __put_user(env->segs[R_SS].selector, &sc->ss);
+
+    __put_user(env->error_code, &sc->err);
+    __put_user(cs->exception_index, &sc->trapno);
+    __put_user(mask, &sc->oldmask);
+    __put_user(env->cr[2], &sc->cr2);
+
+    /* fpstate_addr must be 16 byte aligned for fxsave */
+    assert(!(fpstate_addr & 0xf));
+
+    cpu_x86_fxsave(env, fpstate_addr);
+    __put_user(fpstate_addr, &sc->fpstate);
+#endif
 }
 
 /*
  * Determine which stack to use..
  */
-
 static inline abi_ulong
 get_sigframe(struct target_sigaction *ka, CPUX86State *env, size_t frame_size)
 {
@@ -972,23 +1102,34 @@ get_sigframe(struct target_sigaction *ka, CPUX86State *env, size_t frame_size)
 
     /* Default to using normal stack */
     esp = env->regs[R_ESP];
+#ifdef TARGET_X86_64
+    esp -= 128; /* this is the redzone */
+#endif
+
     /* This is the X/Open sanctioned signal stack switching.  */
     if (ka->sa_flags & TARGET_SA_ONSTACK) {
         if (sas_ss_flags(esp) == 0) {
             esp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
         }
     } else {
-
+#ifndef TARGET_X86_64
         /* This is the legacy signal stack switching. */
         if ((env->segs[R_SS].selector & 0xffff) != __USER_DS &&
                 !(ka->sa_flags & TARGET_SA_RESTORER) &&
                 ka->sa_restorer) {
             esp = (unsigned long) ka->sa_restorer;
         }
+#endif
     }
+
+#ifndef TARGET_X86_64
     return (esp - frame_size) & -8ul;
+#else
+    return ((esp - frame_size) & (~15ul)) - 8;
+#endif
 }
 
+#ifndef TARGET_X86_64
 /* compare linux/arch/i386/kernel/signal.c:setup_frame() */
 static void setup_frame(int sig, struct target_sigaction *ka,
                         target_sigset_t *set, CPUX86State *env)
@@ -1029,7 +1170,6 @@ static void setup_frame(int sig, struct target_sigaction *ka,
         __put_user(val16, (uint16_t *)(frame->retcode+6));
     }
 
-
     /* Set up registers for signal handler */
     env->regs[R_ESP] = frame_addr;
     env->eip = ka->_sa_handler;
@@ -1047,13 +1187,17 @@ static void setup_frame(int sig, struct target_sigaction *ka,
 give_sigsegv:
     force_sigsegv(sig);
 }
+#endif
 
 /* compare linux/arch/i386/kernel/signal.c:setup_rt_frame() */
 static void setup_rt_frame(int sig, struct target_sigaction *ka,
                            target_siginfo_t *info,
                            target_sigset_t *set, CPUX86State *env)
 {
-    abi_ulong frame_addr, addr;
+    abi_ulong frame_addr;
+#ifndef TARGET_X86_64
+    abi_ulong addr;
+#endif
     struct rt_sigframe *frame;
     int i;
 
@@ -1063,12 +1207,17 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
         goto give_sigsegv;
 
+    /* These fields are only in rt_sigframe on 32 bit */
+#ifndef TARGET_X86_64
     __put_user(sig, &frame->sig);
     addr = frame_addr + offsetof(struct rt_sigframe, info);
     __put_user(addr, &frame->pinfo);
     addr = frame_addr + offsetof(struct rt_sigframe, uc);
     __put_user(addr, &frame->puc);
-    tswap_siginfo(&frame->info, info);
+#endif
+    if (info) {
+        tswap_siginfo(&frame->info, info);
+    }
 
     /* Create the ucontext.  */
     __put_user(0, &frame->uc.tuc_flags);
@@ -1087,6 +1236,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
 
     /* Set up to return from userspace.  If provided, use a stub
        already in userspace.  */
+#ifndef TARGET_X86_64
     if (ka->sa_flags & TARGET_SA_RESTORER) {
         __put_user(ka->sa_restorer, &frame->pretcode);
     } else {
@@ -1099,9 +1249,18 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
         val16 = 0x80cd;
         __put_user(val16, (uint16_t *)(frame->retcode+5));
     }
+#else
+    /* XXX: Would be slightly better to return -EFAULT here if test fails
+       assert(ka->sa_flags & TARGET_SA_RESTORER); */
+    __put_user(ka->sa_restorer, &frame->pretcode);
+#endif
 
     /* Set up registers for signal handler */
     env->regs[R_ESP] = frame_addr;
+    env->regs[R_EAX] = 0;
+    env->regs[R_EDI] = sig;
+    env->regs[R_ESI] = (unsigned long)&frame->info;
+    env->regs[R_EDX] = (unsigned long)&frame->uc;
     env->eip = ka->_sa_handler;
 
     cpu_x86_load_seg(env, R_DS, __USER_DS);
@@ -1125,6 +1284,7 @@ restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
     abi_ulong fpstate_addr;
     unsigned int tmpflags;
 
+#ifndef TARGET_X86_64
     cpu_x86_load_seg(env, R_GS, tswap16(sc->gs));
     cpu_x86_load_seg(env, R_FS, tswap16(sc->fs));
     cpu_x86_load_seg(env, R_ES, tswap16(sc->es));
@@ -1138,7 +1298,29 @@ restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
     env->regs[R_EDX] = tswapl(sc->edx);
     env->regs[R_ECX] = tswapl(sc->ecx);
     env->regs[R_EAX] = tswapl(sc->eax);
+
     env->eip = tswapl(sc->eip);
+#else
+    env->regs[8] = tswapl(sc->r8);
+    env->regs[9] = tswapl(sc->r9);
+    env->regs[10] = tswapl(sc->r10);
+    env->regs[11] = tswapl(sc->r11);
+    env->regs[12] = tswapl(sc->r12);
+    env->regs[13] = tswapl(sc->r13);
+    env->regs[14] = tswapl(sc->r14);
+    env->regs[15] = tswapl(sc->r15);
+
+    env->regs[R_EDI] = tswapl(sc->rdi);
+    env->regs[R_ESI] = tswapl(sc->rsi);
+    env->regs[R_EBP] = tswapl(sc->rbp);
+    env->regs[R_EBX] = tswapl(sc->rbx);
+    env->regs[R_EDX] = tswapl(sc->rdx);
+    env->regs[R_EAX] = tswapl(sc->rax);
+    env->regs[R_ECX] = tswapl(sc->rcx);
+    env->regs[R_ESP] = tswapl(sc->rsp);
+
+    env->eip = tswapl(sc->rip);
+#endif
 
     cpu_x86_load_seg(env, R_CS, lduw_p(&sc->cs) | 3);
     cpu_x86_load_seg(env, R_SS, lduw_p(&sc->ss) | 3);
@@ -1152,14 +1334,21 @@ restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
         if (!access_ok(VERIFY_READ, fpstate_addr,
                        sizeof(struct target_fpstate)))
             goto badframe;
+#ifndef TARGET_X86_64
         cpu_x86_frstor(env, fpstate_addr, 1);
+#else
+        cpu_x86_fxrstor(env, fpstate_addr);
+#endif
     }
 
     return err;
+
 badframe:
     return 1;
 }
 
+/* Note: there is no sigreturn on x86_64, there is only rt_sigreturn */
+#ifndef TARGET_X86_64
 long do_sigreturn(CPUX86State *env)
 {
     struct sigframe *frame;
@@ -1191,6 +1380,7 @@ badframe:
     force_sig(TARGET_SIGSEGV);
     return -TARGET_QEMU_ESIGRETURN;
 }
+#endif
 
 long do_rt_sigreturn(CPUX86State *env)
 {
@@ -1198,7 +1388,7 @@ long do_rt_sigreturn(CPUX86State *env)
     struct rt_sigframe *frame;
     sigset_t set;
 
-    frame_addr = env->regs[R_ESP] - 4;
+    frame_addr = env->regs[R_ESP] - sizeof(abi_ulong);
     trace_user_do_rt_sigreturn(env, frame_addr);
     if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1))
         goto badframe;
@@ -6181,11 +6371,13 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
         || defined(TARGET_PPC64) || defined(TARGET_HPPA)
         /* These targets do not have traditional signals.  */
         setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
-#else
+#elif !defined(TARGET_X86_64)
         if (sa->sa_flags & TARGET_SA_SIGINFO)
             setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
         else
             setup_frame(sig, sa, &target_old_set, cpu_env);
+#else
+        setup_rt_frame(sig, sa, 0, &target_old_set, cpu_env);
 #endif
         if (sa->sa_flags & TARGET_SA_RESETHAND) {
             sa->_sa_handler = TARGET_SIG_DFL;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 10c5a3538d..e303b43bc6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1413,6 +1413,8 @@ floatx80 cpu_set_fp80(uint64_t mant, uint16_t upper);
 void cpu_x86_load_seg(CPUX86State *s, int seg_reg, int selector);
 void cpu_x86_fsave(CPUX86State *s, target_ulong ptr, int data32);
 void cpu_x86_frstor(CPUX86State *s, target_ulong ptr, int data32);
+void cpu_x86_fxsave(CPUX86State *s, target_ulong ptr);
+void cpu_x86_fxrstor(CPUX86State *s, target_ulong ptr);
 
 /* you can call this signal handler from your SIGBUS and SIGSEGV
    signal handlers to inform the virtual CPU of exceptions. non zero
diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 66474ad98e..69ea33a5c2 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -1377,6 +1377,18 @@ void helper_fxrstor(CPUX86State *env, target_ulong ptr)
     }
 }
 
+#if defined(CONFIG_USER_ONLY)
+void cpu_x86_fxsave(CPUX86State *env, target_ulong ptr)
+{
+    helper_fxsave(env, ptr);
+}
+
+void cpu_x86_fxrstor(CPUX86State *env, target_ulong ptr)
+{
+    helper_fxrstor(env, ptr);
+}
+#endif
+
 void helper_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
     uintptr_t ra = GETPC();
-- 
2.11.0
