Received: from eggs.gnu.org ([2001:4830:134:3::10]:54892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fELwr-0004ji-KG
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fELwn-0005Bw-J9
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:39:33 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:59269)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fELwn-00059t-31
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:39:29 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  3 May 2018 23:39:02 +0200
Message-Id: <20180503213903.30335-6-laurent@vivier.eu>
In-Reply-To: <20180503213903.30335-1-laurent@vivier.eu>
References: <20180503213903.30335-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 5/6] linux-user: introduce target_sigsp() and
 target_save_altstack()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180411192347.30228-1-laurent@vivier.eu>
---
 linux-user/aarch64/signal.c    | 13 ++-----------
 linux-user/alpha/signal.c      | 17 ++++++-----------
 linux-user/arm/signal.c        | 17 ++++-------------
 linux-user/hppa/signal.c       | 14 ++++----------
 linux-user/i386/signal.c       | 12 +++---------
 linux-user/m68k/signal.c       | 15 +++------------
 linux-user/microblaze/signal.c |  4 +---
 linux-user/mips/signal.c       | 15 ++-------------
 linux-user/nios2/signal.c      | 21 ++-------------------
 linux-user/openrisc/signal.c   | 14 +++-----------
 linux-user/ppc/signal.c        | 15 ++-------------
 linux-user/riscv/signal.c      | 28 +++++++++-------------------
 linux-user/s390x/signal.c      | 12 +++---------
 linux-user/sh4/signal.c        | 11 ++---------
 linux-user/signal-common.h     | 15 ++++-----------
 linux-user/signal.c            | 32 ++++++++++++++++++++++++++++++++
 linux-user/sparc/signal.c      | 28 +++++++++++++++++++---------
 linux-user/tilegx/signal.c     | 13 +++----------
 linux-user/xtensa/signal.c     | 15 ++++-----------
 19 files changed, 108 insertions(+), 203 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index d90e10a113..f95dc61dfb 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -120,9 +120,7 @@ static void target_setup_general_frame(struct target_rt_sigframe *sf,
     __put_user(0, &sf->uc.tuc_flags);
     __put_user(0, &sf->uc.tuc_link);
 
-    __put_user(target_sigaltstack_used.ss_sp, &sf->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(env->xregs[31]), &sf->uc.tuc_stack.ss_flags);
-    __put_user(target_sigaltstack_used.ss_size, &sf->uc.tuc_stack.ss_size);
+    target_save_altstack(&sf->uc.tuc_stack, env);
 
     for (i = 0; i < 31; i++) {
         __put_user(env->xregs[i], &sf->uc.tuc_mcontext.regs[i]);
@@ -372,14 +370,7 @@ static abi_ulong get_sigframe(struct target_sigaction *ka,
 {
     abi_ulong sp;
 
-    sp = env->xregs[31];
-
-    /*
-     * This is the X/Open sanctioned signal stack switching.
-     */
-    if ((ka->sa_flags & TARGET_SA_ONSTACK) && !sas_ss_flags(sp)) {
-        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-    }
+    sp = target_sigsp(get_sp_from_cpustate(env), ka);
 
     sp = (sp - size) & ~15;
 
diff --git a/linux-user/alpha/signal.c b/linux-user/alpha/signal.c
index a8c718f2c6..f24de02c6f 100644
--- a/linux-user/alpha/signal.c
+++ b/linux-user/alpha/signal.c
@@ -117,12 +117,10 @@ static inline abi_ulong get_sigframe(struct target_sigaction *sa,
                                      CPUAlphaState *env,
                                      unsigned long framesize)
 {
-    abi_ulong sp = env->ir[IR_SP];
+    abi_ulong sp;
+
+    sp = target_sigsp(get_sp_from_cpustate(env), sa);
 
-    /* This is the X/Open sanctioned signal stack switching.  */
-    if ((sa->sa_flags & TARGET_SA_ONSTACK) != 0 && !sas_ss_flags(sp)) {
-        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-    }
     return (sp - framesize) & -32;
 }
 
@@ -187,12 +185,9 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     __put_user(0, &frame->uc.tuc_flags);
     __put_user(0, &frame->uc.tuc_link);
     __put_user(set->sig[0], &frame->uc.tuc_osf_sigmask);
-    __put_user(target_sigaltstack_used.ss_sp,
-               &frame->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(env->ir[IR_SP]),
-               &frame->uc.tuc_stack.ss_flags);
-    __put_user(target_sigaltstack_used.ss_size,
-               &frame->uc.tuc_stack.ss_size);
+
+    target_save_altstack(&frame->uc.tuc_stack, env);
+
     setup_sigcontext(&frame->uc.tuc_mcontext, env, frame_addr, set);
     for (i = 0; i < TARGET_NSIG_WORDS; ++i) {
         __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index eb72be5dd0..59b5b65ed1 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -201,14 +201,9 @@ setup_sigcontext(struct target_sigcontext *sc, /*struct _fpstate *fpstate,*/
 static inline abi_ulong
 get_sigframe(struct target_sigaction *ka, CPUARMState *regs, int framesize)
 {
-    unsigned long sp = regs->regs[13];
+    unsigned long sp;
 
-    /*
-     * This is the X/Open sanctioned signal stack switching.
-     */
-    if ((ka->sa_flags & TARGET_SA_ONSTACK) && !sas_ss_flags(sp)) {
-        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-    }
+    sp = target_sigsp(get_sp_from_cpustate(regs), ka);
     /*
      * ATPCS B01 mandates 8-byte alignment
      */
@@ -346,9 +341,7 @@ static void setup_sigframe_v2(struct target_ucontext_v2 *uc,
     memset(uc, 0, offsetof(struct target_ucontext_v2, tuc_mcontext));
 
     memset(&stack, 0, sizeof(stack));
-    __put_user(target_sigaltstack_used.ss_sp, &stack.ss_sp);
-    __put_user(target_sigaltstack_used.ss_size, &stack.ss_size);
-    __put_user(sas_ss_flags(get_sp_from_cpustate(env)), &stack.ss_flags);
+    target_save_altstack(&stack, env);
     memcpy(&uc->tuc_stack, &stack, sizeof(stack));
 
     setup_sigcontext(&uc->tuc_mcontext, env, set->sig[0]);
@@ -461,9 +454,7 @@ static void setup_rt_frame_v1(int usig, struct target_sigaction *ka,
     memset(&frame->uc, 0, offsetof(struct target_ucontext_v1, tuc_mcontext));
 
     memset(&stack, 0, sizeof(stack));
-    __put_user(target_sigaltstack_used.ss_sp, &stack.ss_sp);
-    __put_user(target_sigaltstack_used.ss_size, &stack.ss_size);
-    __put_user(sas_ss_flags(get_sp_from_cpustate(env)), &stack.ss_flags);
+    target_save_altstack(&stack, env);
     memcpy(&frame->uc.tuc_stack, &stack, sizeof(stack));
 
     setup_sigcontext(&frame->uc.tuc_mcontext, env, set->sig[0]);
diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
index 585af3a37f..6e7a295aee 100644
--- a/linux-user/hppa/signal.c
+++ b/linux-user/hppa/signal.c
@@ -113,11 +113,9 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     struct target_rt_sigframe *frame;
     int i;
 
-    sp = env->gr[30];
-    if (ka->sa_flags & TARGET_SA_ONSTACK) {
-        if (sas_ss_flags(sp) == 0) {
-            sp = (target_sigaltstack_used.ss_sp + 0x7f) & ~0x3f;
-        }
+    sp = get_sp_from_cpustate(env);
+    if ((ka->sa_flags & TARGET_SA_ONSTACK) && !sas_ss_flags(sp)) {
+        sp = (target_sigaltstack_used.ss_sp + 0x7f) & ~0x3f;
     }
     frame_addr = QEMU_ALIGN_UP(sp, 64);
     sp = frame_addr + PARISC_RT_SIGFRAME_SIZE32;
@@ -132,11 +130,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     frame->uc.tuc_flags = 0;
     frame->uc.tuc_link = 0;
 
-    __put_user(target_sigaltstack_used.ss_sp, &frame->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(get_sp_from_cpustate(env)),
-               &frame->uc.tuc_stack.ss_flags);
-    __put_user(target_sigaltstack_used.ss_size,
-               &frame->uc.tuc_stack.ss_size);
+    target_save_altstack(&frame->uc.tuc_stack, env);
 
     for (i = 0; i < TARGET_NSIG_WORDS; i++) {
         __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 4a190e6435..e9a23a2dec 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -283,16 +283,14 @@ get_sigframe(struct target_sigaction *ka, CPUX86State *env, size_t frame_size)
     unsigned long esp;
 
     /* Default to using normal stack */
-    esp = env->regs[R_ESP];
+    esp = get_sp_from_cpustate(env);
 #ifdef TARGET_X86_64
     esp -= 128; /* this is the redzone */
 #endif
 
     /* This is the X/Open sanctioned signal stack switching.  */
     if (ka->sa_flags & TARGET_SA_ONSTACK) {
-        if (sas_ss_flags(esp) == 0) {
-            esp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-        }
+        esp = target_sigsp(esp, ka);
     } else {
 #ifndef TARGET_X86_64
         /* This is the legacy signal stack switching. */
@@ -404,11 +402,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     /* Create the ucontext.  */
     __put_user(0, &frame->uc.tuc_flags);
     __put_user(0, &frame->uc.tuc_link);
-    __put_user(target_sigaltstack_used.ss_sp, &frame->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(get_sp_from_cpustate(env)),
-               &frame->uc.tuc_stack.ss_flags);
-    __put_user(target_sigaltstack_used.ss_size,
-               &frame->uc.tuc_stack.ss_size);
+    target_save_altstack(&frame->uc.tuc_stack, env);
     setup_sigcontext(&frame->uc.tuc_mcontext, &frame->fpstate, env,
             set->sig[0], frame_addr + offsetof(struct rt_sigframe, fpstate));
 
diff --git a/linux-user/m68k/signal.c b/linux-user/m68k/signal.c
index fc72468a81..5dd8bb5f99 100644
--- a/linux-user/m68k/signal.c
+++ b/linux-user/m68k/signal.c
@@ -117,14 +117,10 @@ static inline abi_ulong
 get_sigframe(struct target_sigaction *ka, CPUM68KState *regs,
              size_t frame_size)
 {
-    unsigned long sp;
+    abi_ulong sp;
 
-    sp = regs->aregs[7];
+    sp = target_sigsp(get_sp_from_cpustate(regs), ka);
 
-    /* This is the X/Open sanctioned signal stack switching.  */
-    if ((ka->sa_flags & TARGET_SA_ONSTACK) && (sas_ss_flags (sp) == 0)) {
-        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-    }
 
     return ((sp - frame_size) & -8UL);
 }
@@ -318,12 +314,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
 
     __put_user(0, &frame->uc.tuc_flags);
     __put_user(0, &frame->uc.tuc_link);
-    __put_user(target_sigaltstack_used.ss_sp,
-               &frame->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(env->aregs[7]),
-            &frame->uc.tuc_stack.ss_flags);
-    __put_user(target_sigaltstack_used.ss_size,
-               &frame->uc.tuc_stack.ss_size);
+    target_save_altstack(&frame->uc.tuc_stack, env);
     err |= target_rt_setup_ucontext(&frame->uc, env);
 
     if (err)
diff --git a/linux-user/microblaze/signal.c b/linux-user/microblaze/signal.c
index 5572baa7dc..fada0f1495 100644
--- a/linux-user/microblaze/signal.c
+++ b/linux-user/microblaze/signal.c
@@ -133,9 +133,7 @@ static abi_ulong get_sigframe(struct target_sigaction *ka,
 {
     abi_ulong sp = env->regs[1];
 
-    if ((ka->sa_flags & TARGET_SA_ONSTACK) != 0 && !on_sig_stack(sp)) {
-        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-    }
+    sp = target_sigsp(sp, ka);
 
     return ((sp - frame_size) & -8UL);
 }
diff --git a/linux-user/mips/signal.c b/linux-user/mips/signal.c
index adeb5a4241..ed9849c7f6 100644
--- a/linux-user/mips/signal.c
+++ b/linux-user/mips/signal.c
@@ -179,20 +179,12 @@ get_sigframe(struct target_sigaction *ka, CPUMIPSState *regs, size_t frame_size)
 {
     unsigned long sp;
 
-    /* Default to using normal stack */
-    sp = regs->active_tc.gpr[29];
-
     /*
      * FPU emulator may have its own trampoline active just
      * above the user stack, 16-bytes before the next lowest
      * 16 byte boundary.  Try to avoid trashing it.
      */
-    sp -= 32;
-
-    /* This is the X/Open sanctioned signal stack switching.  */
-    if ((ka->sa_flags & TARGET_SA_ONSTACK) && (sas_ss_flags (sp) == 0)) {
-        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-    }
+    sp = target_sigsp(get_sp_from_cpustate(regs) - 32, ka);
 
     return (sp - frame_size) & ~7;
 }
@@ -323,10 +315,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
 
     __put_user(0, &frame->rs_uc.tuc_flags);
     __put_user(0, &frame->rs_uc.tuc_link);
-    __put_user(target_sigaltstack_used.ss_sp, &frame->rs_uc.tuc_stack.ss_sp);
-    __put_user(target_sigaltstack_used.ss_size, &frame->rs_uc.tuc_stack.ss_size);
-    __put_user(sas_ss_flags(get_sp_from_cpustate(env)),
-               &frame->rs_uc.tuc_stack.ss_flags);
+    target_save_altstack(&frame->rs_uc.tuc_stack, env);
 
     setup_sigcontext(env, &frame->rs_uc.tuc_mcontext);
 
diff --git a/linux-user/nios2/signal.c b/linux-user/nios2/signal.c
index 816eed90f1..9a0b36e5ad 100644
--- a/linux-user/nios2/signal.c
+++ b/linux-user/nios2/signal.c
@@ -42,18 +42,6 @@ struct target_rt_sigframe {
     struct target_ucontext uc;
 };
 
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
 static int rt_setup_ucontext(struct target_ucontext *uc, CPUNios2State *env)
 {
     unsigned long *gregs = uc->tuc_mcontext.gregs;
@@ -158,11 +146,8 @@ static void *get_sigframe(struct target_sigaction *ka, CPUNios2State *env,
 {
     unsigned long usp;
 
-    /* Default to using normal stack.  */
-    usp = env->regs[R_SP];
-
     /* This is the X/Open sanctioned signal stack switching.  */
-    usp = sigsp(usp, ka);
+    usp = target_sigsp(get_sp_from_cpustate(env), ka);
 
     /* Verify, is it 32 or 64 bit aligned */
     return (void *)((usp - frame_size) & -8UL);
@@ -185,9 +170,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     /* Create the ucontext.  */
     __put_user(0, &frame->uc.tuc_flags);
     __put_user(0, &frame->uc.tuc_link);
-    __put_user(target_sigaltstack_used.ss_sp, &frame->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(env->regs[R_SP]), &frame->uc.tuc_stack.ss_flags);
-    __put_user(target_sigaltstack_used.ss_size, &frame->uc.tuc_stack.ss_size);
+    target_save_altstack(&frame->uc.tuc_stack, env);
     err |= rt_setup_ucontext(&frame->uc, env);
     for (i = 0; i < TARGET_NSIG_WORDS; i++) {
         __put_user((abi_ulong)set->sig[i],
diff --git a/linux-user/openrisc/signal.c b/linux-user/openrisc/signal.c
index 0276808b59..ecf2897ccd 100644
--- a/linux-user/openrisc/signal.c
+++ b/linux-user/openrisc/signal.c
@@ -124,14 +124,11 @@ static inline abi_ulong get_sigframe(struct target_sigaction *ka,
                                      CPUOpenRISCState *regs,
                                      size_t frame_size)
 {
-    unsigned long sp = cpu_get_gpr(regs, 1);
+    unsigned long sp = get_sp_from_cpustate(regs);
     int onsigstack = on_sig_stack(sp);
 
     /* redzone */
-    /* This is the X/Open sanctioned signal stack switching.  */
-    if ((ka->sa_flags & TARGET_SA_ONSTACK) != 0 && !onsigstack) {
-        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-    }
+    sp = target_sigsp(sp, ka);
 
     sp = align_sigframe(sp - frame_size);
 
@@ -175,12 +172,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     /*err |= __clear_user(&frame->uc, offsetof(ucontext_t, uc_mcontext));*/
     __put_user(0, &frame->uc.tuc_flags);
     __put_user(0, &frame->uc.tuc_link);
-    __put_user(target_sigaltstack_used.ss_sp,
-               &frame->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(cpu_get_gpr(env, 1)),
-               &frame->uc.tuc_stack.ss_flags);
-    __put_user(target_sigaltstack_used.ss_size,
-               &frame->uc.tuc_stack.ss_size);
+    target_save_altstack(&frame->uc.tuc_stack, env);
     setup_sigcontext(&frame->sc, env, set->sig[0]);
 
     /*err |= copy_to_user(frame->uc.tuc_sigmask, set, sizeof(*set));*/
diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index 15148d54a9..cacc9afb5a 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -217,13 +217,7 @@ static target_ulong get_sigframe(struct target_sigaction *ka,
 {
     target_ulong oldsp;
 
-    oldsp = env->gpr[1];
-
-    if ((ka->sa_flags & TARGET_SA_ONSTACK) &&
-            (sas_ss_flags(oldsp) == 0)) {
-        oldsp = (target_sigaltstack_used.ss_sp
-                 + target_sigaltstack_used.ss_size);
-    }
+    oldsp = target_sigsp(get_sp_from_cpustate(env), ka);
 
     return (oldsp - frame_size) & ~0xFUL;
 }
@@ -515,12 +509,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
 
     __put_user(0, &rt_sf->uc.tuc_flags);
     __put_user(0, &rt_sf->uc.tuc_link);
-    __put_user((target_ulong)target_sigaltstack_used.ss_sp,
-               &rt_sf->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(env->gpr[1]),
-               &rt_sf->uc.tuc_stack.ss_flags);
-    __put_user(target_sigaltstack_used.ss_size,
-               &rt_sf->uc.tuc_stack.ss_size);
+    target_save_altstack(&rt_sf->uc.tuc_stack, env);
 #if !defined(TARGET_PPC64)
     __put_user(h2g (&rt_sf->uc.tuc_mcontext),
                &rt_sf->uc.tuc_regs);
diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index 718f3a5679..ef599e319a 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -54,24 +54,20 @@ struct target_rt_sigframe {
 static abi_ulong get_sigframe(struct target_sigaction *ka,
                               CPURISCVState *regs, size_t framesize)
 {
-    abi_ulong sp = regs->gpr[xSP];
-    int onsigstack = on_sig_stack(sp);
-
-    /* redzone */
-    /* This is the X/Open sanctioned signal stack switching.  */
-    if ((ka->sa_flags & TARGET_SA_ONSTACK) != 0 && !onsigstack) {
-        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-    }
-
-    sp -= framesize;
-    sp &= ~3UL; /* align sp on 4-byte boundary */
+    abi_ulong sp = get_sp_from_cpustate(regs);
 
     /* If we are on the alternate signal stack and would overflow it, don't.
        Return an always-bogus address instead so we will die with SIGSEGV. */
-    if (onsigstack && !likely(on_sig_stack(sp))) {
+    if (on_sig_stack(sp) && !likely(on_sig_stack(sp - framesize))) {
         return -1L;
     }
 
+    /* This is the X/Open sanctioned signal stack switching.  */
+    sp = target_sigsp(sp, ka) - framesize;
+
+    /* XXX: kernel aligns with 0xf ? */
+    sp &= ~3UL; /* align sp on 4-byte boundary */
+
     return sp;
 }
 
@@ -95,16 +91,10 @@ static void setup_sigcontext(struct target_sigcontext *sc, CPURISCVState *env)
 static void setup_ucontext(struct target_ucontext *uc,
                            CPURISCVState *env, target_sigset_t *set)
 {
-    abi_ulong ss_sp = (target_ulong)target_sigaltstack_used.ss_sp;
-    abi_ulong ss_flags = sas_ss_flags(env->gpr[xSP]);
-    abi_ulong ss_size = target_sigaltstack_used.ss_size;
-
     __put_user(0,    &(uc->uc_flags));
     __put_user(0,    &(uc->uc_link));
 
-    __put_user(ss_sp,    &(uc->uc_stack.ss_sp));
-    __put_user(ss_flags, &(uc->uc_stack.ss_flags));
-    __put_user(ss_size,  &(uc->uc_stack.ss_size));
+    target_save_altstack(&uc->uc_stack, env);
 
     int i;
     for (i = 0; i < TARGET_NSIG_WORDS; i++) {
diff --git a/linux-user/s390x/signal.c b/linux-user/s390x/signal.c
index a204a85e4a..e35cbe6870 100644
--- a/linux-user/s390x/signal.c
+++ b/linux-user/s390x/signal.c
@@ -86,14 +86,11 @@ get_sigframe(struct target_sigaction *ka, CPUS390XState *env, size_t frame_size)
     abi_ulong sp;
 
     /* Default to using normal stack */
-    sp = env->regs[15];
+    sp = get_sp_from_cpustate(env);
 
     /* This is the X/Open sanctioned signal stack switching.  */
     if (ka->sa_flags & TARGET_SA_ONSTACK) {
-        if (!sas_ss_flags(sp)) {
-            sp = target_sigaltstack_used.ss_sp +
-                 target_sigaltstack_used.ss_size;
-        }
+        sp = target_sigsp(sp, ka);
     }
 
     /* This is the legacy signal stack switching. */
@@ -205,10 +202,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     /* Create the ucontext.  */
     __put_user(0, &frame->uc.tuc_flags);
     __put_user((abi_ulong)0, (abi_ulong *)&frame->uc.tuc_link);
-    __put_user(target_sigaltstack_used.ss_sp, &frame->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(get_sp_from_cpustate(env)),
-               &frame->uc.tuc_stack.ss_flags);
-    __put_user(target_sigaltstack_used.ss_size, &frame->uc.tuc_stack.ss_size);
+    target_save_altstack(&frame->uc.tuc_stack, env);
     save_sigregs(env, &frame->uc.tuc_mcontext);
     for (i = 0; i < TARGET_NSIG_WORDS; i++) {
         __put_user((abi_ulong)set->sig[i],
diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index 5ce182aff7..2a5378e16e 100644
--- a/linux-user/sh4/signal.c
+++ b/linux-user/sh4/signal.c
@@ -78,9 +78,7 @@ struct target_rt_sigframe
 static abi_ulong get_sigframe(struct target_sigaction *ka,
                               unsigned long sp, size_t frame_size)
 {
-    if ((ka->sa_flags & TARGET_SA_ONSTACK) && (sas_ss_flags(sp) == 0)) {
-        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-    }
+    sp = target_sigsp(sp, ka);
 
     return (sp - frame_size) & -8ul;
 }
@@ -238,12 +236,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     /* Create the ucontext.  */
     __put_user(0, &frame->uc.tuc_flags);
     __put_user(0, (unsigned long *)&frame->uc.tuc_link);
-    __put_user((unsigned long)target_sigaltstack_used.ss_sp,
-               &frame->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(regs->gregs[15]),
-               &frame->uc.tuc_stack.ss_flags);
-    __put_user(target_sigaltstack_used.ss_size,
-               &frame->uc.tuc_stack.ss_size);
+    target_save_altstack(&frame->uc.tuc_stack, regs);
     setup_sigcontext(&frame->uc.tuc_mcontext,
                      regs, set->sig[0]);
     for(i = 0; i < TARGET_NSIG_WORDS; i++) {
diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
index fbb8d4365c..51030a9306 100644
--- a/linux-user/signal-common.h
+++ b/linux-user/signal-common.h
@@ -21,17 +21,10 @@
 #define SIGNAL_COMMON_H
 extern struct target_sigaltstack target_sigaltstack_used;
 
-static inline int on_sig_stack(unsigned long sp)
-{
-    return (sp - target_sigaltstack_used.ss_sp
-            < target_sigaltstack_used.ss_size);
-}
-
-static inline int sas_ss_flags(unsigned long sp)
-{
-    return (target_sigaltstack_used.ss_size == 0 ? SS_DISABLE
-            : on_sig_stack(sp) ? SS_ONSTACK : 0);
-}
+int on_sig_stack(unsigned long sp);
+int sas_ss_flags(unsigned long sp);
+abi_ulong target_sigsp(abi_ulong sp, struct target_sigaction *ka);
+void target_save_altstack(target_stack_t *uss, CPUArchState *env);
 
 static inline void target_sigemptyset(target_sigset_t *set)
 {
diff --git a/linux-user/signal.c b/linux-user/signal.c
index a3022c2f04..01de433e3a 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -249,6 +249,38 @@ void set_sigmask(const sigset_t *set)
 }
 #endif
 
+/* sigaltstack management */
+
+int on_sig_stack(unsigned long sp)
+{
+    return (sp - target_sigaltstack_used.ss_sp
+            < target_sigaltstack_used.ss_size);
+}
+
+int sas_ss_flags(unsigned long sp)
+{
+    return (target_sigaltstack_used.ss_size == 0 ? SS_DISABLE
+            : on_sig_stack(sp) ? SS_ONSTACK : 0);
+}
+
+abi_ulong target_sigsp(abi_ulong sp, struct target_sigaction *ka)
+{
+    /*
+     * This is the X/Open sanctioned signal stack switching.
+     */
+    if ((ka->sa_flags & TARGET_SA_ONSTACK) && !sas_ss_flags(sp)) {
+        return target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
+    }
+    return sp;
+}
+
+void target_save_altstack(target_stack_t *uss, CPUArchState *env)
+{
+    __put_user(target_sigaltstack_used.ss_sp, &uss->ss_sp);
+    __put_user(sas_ss_flags(get_sp_from_cpustate(env)), &uss->ss_flags);
+    __put_user(target_sigaltstack_used.ss_size, &uss->ss_size);
+}
+
 /* siginfo conversion */
 
 static inline void host_to_target_siginfo_noswap(target_siginfo_t *tinfo,
diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index c823e61cee..45e922f328 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -123,18 +123,28 @@ static inline abi_ulong get_sigframe(struct target_sigaction *sa,
                                      CPUSPARCState *env,
                                      unsigned long framesize)
 {
-    abi_ulong sp;
+    abi_ulong sp = get_sp_from_cpustate(env);
 
-    sp = env->regwptr[UREG_FP];
+    /*
+     * If we are on the alternate signal stack and would overflow it, don't.
+     * Return an always-bogus address instead so we will die with SIGSEGV.
+         */
+    if (on_sig_stack(sp) && !likely(on_sig_stack(sp - framesize))) {
+            return -1;
+    }
 
     /* This is the X/Open sanctioned signal stack switching.  */
-    if (sa->sa_flags & TARGET_SA_ONSTACK) {
-        if (!on_sig_stack(sp)
-                && !((target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size) & 7)) {
-            sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-        }
-    }
-    return sp - framesize;
+    sp = target_sigsp(sp, sa) - framesize;
+
+    /* Always align the stack frame.  This handles two cases.  First,
+     * sigaltstack need not be mindful of platform specific stack
+     * alignment.  Second, if we took this signal because the stack
+     * is not aligned properly, we'd like to take the signal cleanly
+     * and report that.
+     */
+    sp &= ~15UL;
+
+    return sp;
 }
 
 static int
diff --git a/linux-user/tilegx/signal.c b/linux-user/tilegx/signal.c
index 8f54f54f95..d0ed3de569 100644
--- a/linux-user/tilegx/signal.c
+++ b/linux-user/tilegx/signal.c
@@ -86,17 +86,13 @@ static void restore_sigcontext(CPUTLGState *env, struct target_sigcontext *sc)
 static abi_ulong get_sigframe(struct target_sigaction *ka, CPUArchState *env,
                               size_t frame_size)
 {
-    unsigned long sp = env->regs[TILEGX_R_SP];
+    unsigned long sp = get_sp_from_cpustate(env);
 
     if (on_sig_stack(sp) && !likely(on_sig_stack(sp - frame_size))) {
         return -1UL;
     }
 
-    if ((ka->sa_flags & SA_ONSTACK) && !sas_ss_flags(sp)) {
-        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-    }
-
-    sp -= frame_size;
+    sp = target_sigsp(sp, ka) - frame_size;
     sp &= -16UL;
     return sp;
 }
@@ -127,10 +123,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     /* Create the ucontext.  */
     __put_user(0, &frame->uc.tuc_flags);
     __put_user(0, &frame->uc.tuc_link);
-    __put_user(target_sigaltstack_used.ss_sp, &frame->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(env->regs[TILEGX_R_SP]),
-               &frame->uc.tuc_stack.ss_flags);
-    __put_user(target_sigaltstack_used.ss_size, &frame->uc.tuc_stack.ss_size);
+    target_save_altstack(&frame->uc.tuc_stack, env);
     setup_sigcontext(&frame->uc.tuc_mcontext, env, info->si_signo);
 
     if (ka->sa_flags & TARGET_SA_RESTORER) {
diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
index 1e98910c1b..3e483efc61 100644
--- a/linux-user/xtensa/signal.c
+++ b/linux-user/xtensa/signal.c
@@ -55,12 +55,10 @@ static abi_ulong get_sigframe(struct target_sigaction *sa,
                               CPUXtensaState *env,
                               unsigned long framesize)
 {
-    abi_ulong sp = env->regs[1];
+    abi_ulong sp;
+
+    sp = target_sigsp(get_sp_from_cpustate(env), sa);
 
-    /* This is the X/Open sanctioned signal stack switching.  */
-    if ((sa->sa_flags & TARGET_SA_ONSTACK) != 0 && !sas_ss_flags(sp)) {
-        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
-    }
     return (sp - framesize) & -16;
 }
 
@@ -152,12 +150,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
 
     __put_user(0, &frame->uc.tuc_flags);
     __put_user(0, &frame->uc.tuc_link);
-    __put_user(target_sigaltstack_used.ss_sp,
-               &frame->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(env->regs[1]),
-               &frame->uc.tuc_stack.ss_flags);
-    __put_user(target_sigaltstack_used.ss_size,
-               &frame->uc.tuc_stack.ss_size);
+    target_save_altstack(&frame->uc.tuc_stack, env);
     if (!setup_sigcontext(frame, env)) {
         unlock_user_struct(frame, frame_addr, 0);
         goto give_sigsegv;
-- 
2.14.3
