Received: from eggs.gnu.org ([2001:4830:134:3::10]:53334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ez8Ev-0004c0-2w
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 17:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ez8Er-0004GE-St
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 17:59:17 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:42127)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ez8Er-0004EJ-IX
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 17:59:13 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 22 Mar 2018 22:58:31 +0100
Message-Id: <20180322215833.7713-4-laurent@vivier.eu>
In-Reply-To: <20180322215833.7713-1-laurent@vivier.eu>
References: <20180322215833.7713-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 3/5] linux-user: define
 TARGET_ARCH_HAS_SETUP_FRAME
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

instead of calling setup_frame() conditionnaly to a list of knowm targets,
define TARGET_ARCH_HAS_SETUP_FRAME if the target provides the function
and call it only if the macro is defined

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/aarch64/signal.inc.c    |  1 +
 linux-user/alpha/signal.inc.c      |  1 +
 linux-user/arm/signal.inc.c        |  1 +
 linux-user/cris/signal.inc.c       |  1 +
 linux-user/i386/signal.inc.c       |  1 +
 linux-user/m68k/signal.inc.c       |  1 +
 linux-user/microblaze/signal.inc.c |  1 +
 linux-user/mips/signal.inc.c       |  1 +
 linux-user/ppc/signal.inc.c        |  1 +
 linux-user/s390x/signal.inc.c      |  1 +
 linux-user/sh4/signal.inc.c        |  1 +
 linux-user/signal.c                | 11 +++--------
 linux-user/sparc/signal.inc.c      |  1 +
 13 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/linux-user/aarch64/signal.inc.c b/linux-user/aarch64/signal.inc.c
index 28fa0f2f22..369741eae1 100644
--- a/linux-user/aarch64/signal.inc.c
+++ b/linux-user/aarch64/signal.inc.c
@@ -510,6 +510,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     target_setup_frame(sig, ka, info, set, env);
 }
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 static void setup_frame(int sig, struct target_sigaction *ka,
                         target_sigset_t *set, CPUARMState *env)
 {
diff --git a/linux-user/alpha/signal.inc.c b/linux-user/alpha/signal.inc.c
index 52e379e214..5910a70ac6 100644
--- a/linux-user/alpha/signal.inc.c
+++ b/linux-user/alpha/signal.inc.c
@@ -103,6 +103,7 @@ static inline abi_ulong get_sigframe(struct target_sigaction *sa,
     return (sp - framesize) & -32;
 }
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 static void setup_frame(int sig, struct target_sigaction *ka,
                         target_sigset_t *set, CPUAlphaState *env)
 {
diff --git a/linux-user/arm/signal.inc.c b/linux-user/arm/signal.inc.c
index 1d6f9a1f7f..ecca4f2e7b 100644
--- a/linux-user/arm/signal.inc.c
+++ b/linux-user/arm/signal.inc.c
@@ -334,6 +334,7 @@ sigsegv:
     force_sigsegv(usig);
 }
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 static void setup_frame(int usig, struct target_sigaction *ka,
                         target_sigset_t *set, CPUARMState *regs)
 {
diff --git a/linux-user/cris/signal.inc.c b/linux-user/cris/signal.inc.c
index 3f68793727..d910eb5257 100644
--- a/linux-user/cris/signal.inc.c
+++ b/linux-user/cris/signal.inc.c
@@ -74,6 +74,7 @@ static abi_ulong get_sigframe(CPUCRISState *env, int framesize)
     return sp - framesize;
 }
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 static void setup_frame(int sig, struct target_sigaction *ka,
                         target_sigset_t *set, CPUCRISState *env)
 {
diff --git a/linux-user/i386/signal.inc.c b/linux-user/i386/signal.inc.c
index c522c449ae..8695806da9 100644
--- a/linux-user/i386/signal.inc.c
+++ b/linux-user/i386/signal.inc.c
@@ -289,6 +289,7 @@ get_sigframe(struct target_sigaction *ka, CPUX86State *env, size_t frame_size)
 
 #ifndef TARGET_X86_64
 /* compare linux/arch/i386/kernel/signal.c:setup_frame() */
+#define TARGET_ARCH_HAS_SETUP_FRAME
 static void setup_frame(int sig, struct target_sigaction *ka,
                         target_sigset_t *set, CPUX86State *env)
 {
diff --git a/linux-user/m68k/signal.inc.c b/linux-user/m68k/signal.inc.c
index 07db1cdeda..eabd4849e4 100644
--- a/linux-user/m68k/signal.inc.c
+++ b/linux-user/m68k/signal.inc.c
@@ -106,6 +106,7 @@ get_sigframe(struct target_sigaction *ka, CPUM68KState *regs,
     return ((sp - frame_size) & -8UL);
 }
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 static void setup_frame(int sig, struct target_sigaction *ka,
                         target_sigset_t *set, CPUM68KState *env)
 {
diff --git a/linux-user/microblaze/signal.inc.c b/linux-user/microblaze/signal.inc.c
index 728bd33273..b0db5ab8c4 100644
--- a/linux-user/microblaze/signal.inc.c
+++ b/linux-user/microblaze/signal.inc.c
@@ -117,6 +117,7 @@ static abi_ulong get_sigframe(struct target_sigaction *ka,
     return ((sp - frame_size) & -8UL);
 }
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 static void setup_frame(int sig, struct target_sigaction *ka,
                         target_sigset_t *set, CPUMBState *env)
 {
diff --git a/linux-user/mips/signal.inc.c b/linux-user/mips/signal.inc.c
index 19e5b3aad4..76e7ad77c2 100644
--- a/linux-user/mips/signal.inc.c
+++ b/linux-user/mips/signal.inc.c
@@ -185,6 +185,7 @@ static void mips_set_hflags_isa_mode_from_pc(CPUMIPSState *env)
 
 # if defined(TARGET_ABI_MIPSO32)
 /* compare linux/arch/mips/kernel/signal.c:setup_frame() */
+#define TARGET_ARCH_HAS_SETUP_FRAME
 static void setup_frame(int sig, struct target_sigaction * ka,
                         target_sigset_t *set, CPUMIPSState *regs)
 {
diff --git a/linux-user/ppc/signal.inc.c b/linux-user/ppc/signal.inc.c
index ea3ee45202..1aaef0dbd8 100644
--- a/linux-user/ppc/signal.inc.c
+++ b/linux-user/ppc/signal.inc.c
@@ -411,6 +411,7 @@ static void restore_user_regs(CPUPPCState *env,
 }
 
 #if !defined(TARGET_PPC64)
+#define TARGET_ARCH_HAS_SETUP_FRAME
 static void setup_frame(int sig, struct target_sigaction *ka,
                         target_sigset_t *set, CPUPPCState *env)
 {
diff --git a/linux-user/s390x/signal.inc.c b/linux-user/s390x/signal.inc.c
index d0f362084f..3c17bdea0b 100644
--- a/linux-user/s390x/signal.inc.c
+++ b/linux-user/s390x/signal.inc.c
@@ -108,6 +108,7 @@ static void save_sigregs(CPUS390XState *env, target_sigregs *sregs)
     }
 }
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 static void setup_frame(int sig, struct target_sigaction *ka,
                         target_sigset_t *set, CPUS390XState *env)
 {
diff --git a/linux-user/sh4/signal.inc.c b/linux-user/sh4/signal.inc.c
index 4c6369bbdb..496e6aef60 100644
--- a/linux-user/sh4/signal.inc.c
+++ b/linux-user/sh4/signal.inc.c
@@ -143,6 +143,7 @@ static void restore_sigcontext(CPUSH4State *regs, struct target_sigcontext *sc)
     regs->flags &= ~(DELAY_SLOT_MASK | GUSA_MASK);
 }
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 static void setup_frame(int sig, struct target_sigaction *ka,
                         target_sigset_t *set, CPUSH4State *regs)
 {
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 514145b299..6bd5f136c3 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -886,18 +886,13 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
         }
 #endif
         /* prepare the stack frame of the virtual CPU */
-#if defined(TARGET_ABI_MIPSN32) || defined(TARGET_ABI_MIPSN64) \
-        || defined(TARGET_OPENRISC) || defined(TARGET_TILEGX) \
-        || defined(TARGET_PPC64) || defined(TARGET_HPPA) \
-        || defined(TARGET_NIOS2) || defined(TARGET_X86_64) \
-        || defined(TARGET_RISCV) || defined(TARGET_XTENSA)
-        /* These targets do not have traditional signals.  */
-        setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
-#else
+#if defined(TARGET_ARCH_HAS_SETUP_FRAME)
         if (sa->sa_flags & TARGET_SA_SIGINFO)
             setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
         else
             setup_frame(sig, sa, &target_old_set, cpu_env);
+#else
+        setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
 #endif
         if (sa->sa_flags & TARGET_SA_RESETHAND) {
             sa->_sa_handler = TARGET_SIG_DFL;
diff --git a/linux-user/sparc/signal.inc.c b/linux-user/sparc/signal.inc.c
index fe5ab902f6..186376d240 100644
--- a/linux-user/sparc/signal.inc.c
+++ b/linux-user/sparc/signal.inc.c
@@ -153,6 +153,7 @@ setup_sigcontext(struct target_sigcontext *sc, /*struct _fpstate *fpstate,*/
 #endif
 #define NF_ALIGNEDSZ  (((sizeof(struct target_signal_frame) + 7) & (~7)))
 
+#define TARGET_ARCH_HAS_SETUP_FRAME
 static void setup_frame(int sig, struct target_sigaction *ka,
                         target_sigset_t *set, CPUSPARCState *env)
 {
-- 
2.14.3
