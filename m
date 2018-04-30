Received: from eggs.gnu.org ([2001:4830:134:3::10]:32901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4q6-0006KO-Ar
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4q2-0006BA-K9
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:11:18 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Apr 2018 11:10:17 +0200
Message-Id: <20180430091037.13878-23-laurent@vivier.eu>
In-Reply-To: <20180430091037.13878-1-laurent@vivier.eu>
References: <20180430091037.13878-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 22/42] linux-user: define
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
Cc: qemu-s390x@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Cornelia Huck <cohuck@redhat.com>

Instead of calling setup_frame() conditionally to a list of known targets,
define TARGET_ARCH_HAS_SETUP_FRAME if the target provides the function
and call it only if the macro is defined.

Move declarations of setup_frame() and setup_rt_frame() to
linux-user/signal-common.h

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180424192635.6027-21-laurent@vivier.eu>
---
 linux-user/aarch64/target_signal.h    |  6 +-----
 linux-user/alpha/target_signal.h      |  6 +-----
 linux-user/arm/target_signal.h        |  6 +-----
 linux-user/cris/target_signal.h       |  6 +-----
 linux-user/hppa/target_signal.h       |  4 ----
 linux-user/i386/target_signal.h       |  6 +-----
 linux-user/m68k/target_signal.h       |  6 +-----
 linux-user/microblaze/target_signal.h |  6 +-----
 linux-user/mips/target_signal.h       |  8 ++------
 linux-user/mips64/target_signal.h     |  4 ----
 linux-user/nios2/target_signal.h      |  5 -----
 linux-user/openrisc/target_signal.h   |  4 ----
 linux-user/ppc/target_signal.h        |  6 +-----
 linux-user/riscv/target_signal.h      |  4 ----
 linux-user/s390x/target_signal.h      |  6 +-----
 linux-user/sh4/target_signal.h        |  7 +------
 linux-user/signal-common.h            |  7 +++++++
 linux-user/signal.c                   | 17 +++++++----------
 linux-user/sparc/target_signal.h      |  6 +-----
 linux-user/sparc64/target_signal.h    |  6 +-----
 linux-user/tilegx/target_signal.h     |  4 ----
 linux-user/x86_64/target_signal.h     |  4 ----
 linux-user/xtensa/target_signal.h     |  4 ----
 23 files changed, 28 insertions(+), 110 deletions(-)

diff --git a/linux-user/aarch64/target_signal.h b/linux-user/aarch64/target_signal.h
index af1f1320e2..0b7ae25120 100644
--- a/linux-user/aarch64/target_signal.h
+++ b/linux-user/aarch64/target_signal.h
@@ -26,9 +26,5 @@ static inline abi_ulong get_sp_from_cpustate(CPUARMState *state)
    return state->xregs[31];
 }
 
-void setup_frame(int sig, struct target_sigaction *ka,
-                 target_sigset_t *set, CPUARMState *env);
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info, target_sigset_t *set,
-                    CPUARMState *env);
+#define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* AARCH64_TARGET_SIGNAL_H */
diff --git a/linux-user/alpha/target_signal.h b/linux-user/alpha/target_signal.h
index 42343a1ae6..4e912e1cf9 100644
--- a/linux-user/alpha/target_signal.h
+++ b/linux-user/alpha/target_signal.h
@@ -55,9 +55,5 @@ static inline abi_ulong get_sp_from_cpustate(CPUAlphaState *state)
 #define TARGET_GEN_SUBRNG6     -24
 #define TARGET_GEN_SUBRNG7     -25
 
-void setup_frame(int sig, struct target_sigaction *ka,
-                 target_sigset_t *set, CPUAlphaState *env);
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                    target_sigset_t *set, CPUAlphaState *env);
+#define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* ALPHA_TARGET_SIGNAL_H */
diff --git a/linux-user/arm/target_signal.h b/linux-user/arm/target_signal.h
index 4b542c324f..d6a03ec87d 100644
--- a/linux-user/arm/target_signal.h
+++ b/linux-user/arm/target_signal.h
@@ -26,9 +26,5 @@ static inline abi_ulong get_sp_from_cpustate(CPUARMState *state)
    return state->regs[13];
 }
 
-void setup_frame(int usig, struct target_sigaction *ka,
-                 target_sigset_t *set, CPUARMState *regs);
-void setup_rt_frame(int usig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                    target_sigset_t *set, CPUARMState *env);
+#define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* ARM_TARGET_SIGNAL_H */
diff --git a/linux-user/cris/target_signal.h b/linux-user/cris/target_signal.h
index 19c0d7b539..74ff2f3382 100644
--- a/linux-user/cris/target_signal.h
+++ b/linux-user/cris/target_signal.h
@@ -26,9 +26,5 @@ static inline abi_ulong get_sp_from_cpustate(CPUCRISState *state)
     return state->regs[14];
 }
 
-void setup_frame(int sig, struct target_sigaction *ka,
-                 target_sigset_t *set, CPUCRISState *env);
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                     target_sigset_t *set, CPUCRISState *env);
+#define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* CRIS_TARGET_SIGNAL_H */
diff --git a/linux-user/hppa/target_signal.h b/linux-user/hppa/target_signal.h
index f19aed93dd..f28b4bf6e8 100644
--- a/linux-user/hppa/target_signal.h
+++ b/linux-user/hppa/target_signal.h
@@ -25,8 +25,4 @@ static inline abi_ulong get_sp_from_cpustate(CPUHPPAState *state)
 {
     return state->gr[30];
 }
-
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                    target_sigset_t *set, CPUArchState *env);
 #endif /* HPPA_TARGET_SIGNAL_H */
diff --git a/linux-user/i386/target_signal.h b/linux-user/i386/target_signal.h
index ec5a3e3373..6ad4089482 100644
--- a/linux-user/i386/target_signal.h
+++ b/linux-user/i386/target_signal.h
@@ -26,9 +26,5 @@ static inline abi_ulong get_sp_from_cpustate(CPUX86State *state)
     return state->regs[R_ESP];
 }
 
-void setup_frame(int sig, struct target_sigaction *ka,
-                 target_sigset_t *set, CPUX86State *env);
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                    target_sigset_t *set, CPUX86State *env);
+#define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* I386_TARGET_SIGNAL_H */
diff --git a/linux-user/m68k/target_signal.h b/linux-user/m68k/target_signal.h
index 29e0c01191..ff303f2b3c 100644
--- a/linux-user/m68k/target_signal.h
+++ b/linux-user/m68k/target_signal.h
@@ -26,9 +26,5 @@ static inline abi_ulong get_sp_from_cpustate(CPUM68KState *state)
     return state->aregs[7];
 }
 
-void setup_frame(int sig, struct target_sigaction *ka,
-                 target_sigset_t *set, CPUM68KState *env);
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                    target_sigset_t *set, CPUM68KState *env);
+#define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* M68K_TARGET_SIGNAL_H */
diff --git a/linux-user/microblaze/target_signal.h b/linux-user/microblaze/target_signal.h
index 02c5cc56fa..9fe4048292 100644
--- a/linux-user/microblaze/target_signal.h
+++ b/linux-user/microblaze/target_signal.h
@@ -26,9 +26,5 @@ static inline abi_ulong get_sp_from_cpustate(CPUMBState *state)
     return state->regs[1];
 }
 
-void setup_frame(int sig, struct target_sigaction *ka,
-                 target_sigset_t *set, CPUMBState *env);
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                    target_sigset_t *set, CPUMBState *env);
+#define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* MICROBLAZE_TARGET_SIGNAL_H */
diff --git a/linux-user/mips/target_signal.h b/linux-user/mips/target_signal.h
index 22ab3e4a94..d36f5da0a0 100644
--- a/linux-user/mips/target_signal.h
+++ b/linux-user/mips/target_signal.h
@@ -26,12 +26,8 @@ static inline abi_ulong get_sp_from_cpustate(CPUMIPSState *state)
     return state->active_tc.gpr[29];
 }
 
-# if defined(TARGET_ABI_MIPSO32)
+#if defined(TARGET_ABI_MIPSO32)
 /* compare linux/arch/mips/kernel/signal.c:setup_frame() */
-void setup_frame(int sig, struct target_sigaction * ka,
-                 target_sigset_t *set, CPUMIPSState *regs);
+#define TARGET_ARCH_HAS_SETUP_FRAME
 #endif
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                    target_sigset_t *set, CPUMIPSState *env);
 #endif /* MIPS_TARGET_SIGNAL_H */
diff --git a/linux-user/mips64/target_signal.h b/linux-user/mips64/target_signal.h
index 70dfe40978..c074e1592f 100644
--- a/linux-user/mips64/target_signal.h
+++ b/linux-user/mips64/target_signal.h
@@ -25,8 +25,4 @@ static inline abi_ulong get_sp_from_cpustate(CPUMIPSState *state)
 {
     return state->active_tc.gpr[29];
 }
-
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                    target_sigset_t *set, CPUMIPSState *env);
 #endif /* MIPS64_TARGET_SIGNAL_H */
diff --git a/linux-user/nios2/target_signal.h b/linux-user/nios2/target_signal.h
index aa78519025..f4db4d6d62 100644
--- a/linux-user/nios2/target_signal.h
+++ b/linux-user/nios2/target_signal.h
@@ -22,9 +22,4 @@ static inline abi_ulong get_sp_from_cpustate(CPUNios2State *state)
 {
     return state->regs[R_SP];
 }
-
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                    target_sigset_t *set,
-                    CPUNios2State *env);
 #endif /* TARGET_SIGNAL_H */
diff --git a/linux-user/openrisc/target_signal.h b/linux-user/openrisc/target_signal.h
index 6c47ddf74e..2a4e00b035 100644
--- a/linux-user/openrisc/target_signal.h
+++ b/linux-user/openrisc/target_signal.h
@@ -22,8 +22,4 @@ static inline abi_ulong get_sp_from_cpustate(CPUOpenRISCState *state)
 {
     return cpu_get_gpr(state, 1);
 }
-
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                    target_sigset_t *set, CPUOpenRISCState *env);
 #endif /* OPENRISC_TARGET_SIGNAL_H */
diff --git a/linux-user/ppc/target_signal.h b/linux-user/ppc/target_signal.h
index 5e293e3b03..e3bf1d2856 100644
--- a/linux-user/ppc/target_signal.h
+++ b/linux-user/ppc/target_signal.h
@@ -27,10 +27,6 @@ static inline abi_ulong get_sp_from_cpustate(CPUPPCState *state)
 }
 
 #if !defined(TARGET_PPC64)
-void setup_frame(int sig, struct target_sigaction *ka,
-                 target_sigset_t *set, CPUPPCState *env);
+#define TARGET_ARCH_HAS_SETUP_FRAME
 #endif
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                    target_sigset_t *set, CPUPPCState *env);
 #endif /* PPC_TARGET_SIGNAL_H */
diff --git a/linux-user/riscv/target_signal.h b/linux-user/riscv/target_signal.h
index 6ac8a88de6..9dac002c0d 100644
--- a/linux-user/riscv/target_signal.h
+++ b/linux-user/riscv/target_signal.h
@@ -19,8 +19,4 @@ static inline abi_ulong get_sp_from_cpustate(CPURISCVState *state)
 {
    return state->gpr[xSP];
 }
-
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                    target_sigset_t *set, CPURISCVState *env);
 #endif /* TARGET_SIGNAL_H */
diff --git a/linux-user/s390x/target_signal.h b/linux-user/s390x/target_signal.h
index 9e3733bb38..4e99f8fadd 100644
--- a/linux-user/s390x/target_signal.h
+++ b/linux-user/s390x/target_signal.h
@@ -23,9 +23,5 @@ static inline abi_ulong get_sp_from_cpustate(CPUS390XState *state)
    return state->regs[15];
 }
 
-void setup_frame(int sig, struct target_sigaction *ka,
-                 target_sigset_t *set, CPUS390XState *env);
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                    target_sigset_t *set, CPUS390XState *env);
+#define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* S390X_TARGET_SIGNAL_H */
diff --git a/linux-user/sh4/target_signal.h b/linux-user/sh4/target_signal.h
index a2a93fa04a..e7b18a6db4 100644
--- a/linux-user/sh4/target_signal.h
+++ b/linux-user/sh4/target_signal.h
@@ -26,10 +26,5 @@ static inline abi_ulong get_sp_from_cpustate(CPUSH4State *state)
     return state->gregs[15];
 }
 
-void setup_frame(int sig, struct target_sigaction *ka,
-                 target_sigset_t *set, CPUSH4State *regs);
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                    target_sigset_t *set, CPUSH4State *regs);
-
+#define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* SH4_TARGET_SIGNAL_H */
diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
index 838b6e9198..fbb8d4365c 100644
--- a/linux-user/signal-common.h
+++ b/linux-user/signal-common.h
@@ -47,4 +47,11 @@ void tswap_siginfo(target_siginfo_t *tinfo,
 void set_sigmask(const sigset_t *set);
 void force_sig(int sig);
 void force_sigsegv(int oldsig);
+#if defined(TARGET_ARCH_HAS_SETUP_FRAME)
+void setup_frame(int sig, struct target_sigaction *ka,
+                 target_sigset_t *set, CPUArchState *env);
+#endif
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                    target_sigset_t *set, CPUArchState *env);
 #endif
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 7f435c4606..a3022c2f04 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -873,18 +873,15 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
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
-        if (sa->sa_flags & TARGET_SA_SIGINFO)
+#if defined(TARGET_ARCH_HAS_SETUP_FRAME)
+        if (sa->sa_flags & TARGET_SA_SIGINFO) {
             setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
-        else
+        } else {
             setup_frame(sig, sa, &target_old_set, cpu_env);
+        }
+#else
+        /* These targets do not have traditional signals.  */
+        setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
 #endif
         if (sa->sa_flags & TARGET_SA_RESETHAND) {
             sa->_sa_handler = TARGET_SIG_DFL;
diff --git a/linux-user/sparc/target_signal.h b/linux-user/sparc/target_signal.h
index ea2c68c900..467abea49e 100644
--- a/linux-user/sparc/target_signal.h
+++ b/linux-user/sparc/target_signal.h
@@ -33,9 +33,5 @@ static inline abi_ulong get_sp_from_cpustate(CPUSPARCState *state)
     return state->regwptr[UREG_FP];
 }
 
-void setup_frame(int sig, struct target_sigaction *ka,
-                 target_sigset_t *set, CPUSPARCState *env);
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                    target_sigset_t *set, CPUSPARCState *env);
+#define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* SPARC_TARGET_SIGNAL_H */
diff --git a/linux-user/sparc64/target_signal.h b/linux-user/sparc64/target_signal.h
index 7f10db9ede..14b01d9632 100644
--- a/linux-user/sparc64/target_signal.h
+++ b/linux-user/sparc64/target_signal.h
@@ -33,9 +33,5 @@ static inline abi_ulong get_sp_from_cpustate(CPUSPARCState *state)
     return state->regwptr[UREG_FP];
 }
 
-void setup_frame(int sig, struct target_sigaction *ka,
-                 target_sigset_t *set, CPUSPARCState *env);
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                    target_sigset_t *set, CPUSPARCState *env);
+#define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* SPARC64_TARGET_SIGNAL_H */
diff --git a/linux-user/tilegx/target_signal.h b/linux-user/tilegx/target_signal.h
index 132d7781fe..a74fa37aac 100644
--- a/linux-user/tilegx/target_signal.h
+++ b/linux-user/tilegx/target_signal.h
@@ -24,8 +24,4 @@ static inline abi_ulong get_sp_from_cpustate(CPUTLGState *state)
 {
     return state->regs[TILEGX_R_SP];
 }
-
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                    target_sigset_t *set, CPUArchState *env);
 #endif /* TILEGX_TARGET_SIGNAL_H */
diff --git a/linux-user/x86_64/target_signal.h b/linux-user/x86_64/target_signal.h
index 26f96944e5..6b01b5acb7 100644
--- a/linux-user/x86_64/target_signal.h
+++ b/linux-user/x86_64/target_signal.h
@@ -25,8 +25,4 @@ static inline abi_ulong get_sp_from_cpustate(CPUX86State *state)
 {
     return state->regs[R_ESP];
 }
-
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                    target_sigset_t *set, CPUX86State *env);
 #endif /* X86_64_TARGET_SIGNAL_H */
diff --git a/linux-user/xtensa/target_signal.h b/linux-user/xtensa/target_signal.h
index f6545903a4..4376b2e538 100644
--- a/linux-user/xtensa/target_signal.h
+++ b/linux-user/xtensa/target_signal.h
@@ -24,8 +24,4 @@ static inline abi_ulong get_sp_from_cpustate(CPUXtensaState *state)
 {
     return state->regs[1];
 }
-
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                    target_sigset_t *set, CPUXtensaState *env);
 #endif
-- 
2.14.3
