Received: from eggs.gnu.org ([2001:4830:134:3::10]:38112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDYuV-0000mQ-89
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDYuT-00037d-Nb
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:50:07 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDYuT-00031C-82
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:50:05 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 18:49:57 +0100
Message-Id: <20181019174958.26616-2-peter.maydell@linaro.org>
In-Reply-To: <20181019174958.26616-1-peter.maydell@linaro.org>
References: <20181019174958.26616-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] linux-user: Don't call gdb_handlesig()
 before queue_signal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

The CPU main-loop routines for linux-user generally
call gdb_handlesig() when they're about to queue a
SIGTRAP signal. This is wrong, because queue_signal()
will cause us to pend a signal, and process_pending_signals()
will then call gdb_handlesig() itself. So the effect is that
we notify gdb of the SIGTRAP, and then if gdb says "OK,
continue with signal X" we will incorrectly notify
gdb of the signal X as well. We don't do this double-notify
for anything else, only SIGTRAP.

Remove this unnecessary and incorrect code from all
the targets except for nios2 (whose main loop is
doing something different and broken, and will be handled
in a separate patch).

This bug only manifests if the user responds to the reported
SIGTRAP using "signal SIGFOO" rather than "continue"; since
the latter is the overwhelmingly common thing to do after a
breakpoint most people won't have hit this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/aarch64/cpu_loop.c    | 13 +++++--------
 linux-user/alpha/cpu_loop.c      | 12 ++++--------
 linux-user/arm/cpu_loop.c        | 16 ++++------------
 linux-user/cris/cpu_loop.c       | 16 ++++------------
 linux-user/hppa/cpu_loop.c       | 11 ++++-------
 linux-user/i386/cpu_loop.c       | 16 ++++------------
 linux-user/m68k/cpu_loop.c       | 16 ++++------------
 linux-user/microblaze/cpu_loop.c | 16 ++++------------
 linux-user/mips/cpu_loop.c       | 16 ++++------------
 linux-user/openrisc/cpu_loop.c   | 11 ++++-------
 linux-user/ppc/cpu_loop.c        | 15 +++++----------
 linux-user/riscv/cpu_loop.c      |  2 +-
 linux-user/s390x/cpu_loop.c      |  9 +++------
 linux-user/sh4/cpu_loop.c        | 17 ++++-------------
 linux-user/sparc/cpu_loop.c      | 16 ++++------------
 linux-user/xtensa/cpu_loop.c     | 11 ++++-------
 16 files changed, 62 insertions(+), 151 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index c97a6465464..65d815f0300 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -73,7 +73,7 @@
 void cpu_loop(CPUARMState *env)
 {
     CPUState *cs = CPU(arm_env_get_cpu(env));
-    int trapnr, sig;
+    int trapnr;
     abi_long ret;
     target_siginfo_t info;
 
@@ -121,13 +121,10 @@ void cpu_loop(CPUARMState *env)
             break;
         case EXCP_DEBUG:
         case EXCP_BKPT:
-            sig = gdb_handlesig(cs, TARGET_SIGTRAP);
-            if (sig) {
-                info.si_signo = sig;
-                info.si_errno = 0;
-                info.si_code = TARGET_TRAP_BRKPT;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            }
+            info.si_signo = TARGET_SIGTRAP;
+            info.si_errno = 0;
+            info.si_code = TARGET_TRAP_BRKPT;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case EXCP_SEMIHOST:
             env->xregs[0] = do_arm_semihosting(env);
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index c1a98c8cbfb..824b6d66588 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -179,14 +179,10 @@ void cpu_loop(CPUAlphaState *env)
             }
             break;
         case EXCP_DEBUG:
-            info.si_signo = gdb_handlesig(cs, TARGET_SIGTRAP);
-            if (info.si_signo) {
-                info.si_errno = 0;
-                info.si_code = TARGET_TRAP_BRKPT;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            } else {
-                arch_interrupt = false;
-            }
+            info.si_signo = TARGET_SIGTRAP;
+            info.si_errno = 0;
+            info.si_code = TARGET_TRAP_BRKPT;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case EXCP_INTERRUPT:
             /* Just indicate that signals should be handled asap.  */
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 26928fbbb2c..ee68aa60bf3 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -397,18 +397,10 @@ void cpu_loop(CPUARMState *env)
             break;
         case EXCP_DEBUG:
         excp_debug:
-            {
-                int sig;
-
-                sig = gdb_handlesig(cs, TARGET_SIGTRAP);
-                if (sig)
-                  {
-                    info.si_signo = sig;
-                    info.si_errno = 0;
-                    info.si_code = TARGET_TRAP_BRKPT;
-                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                  }
-            }
+            info.si_signo = TARGET_SIGTRAP;
+            info.si_errno = 0;
+            info.si_code = TARGET_TRAP_BRKPT;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case EXCP_KERNEL_TRAP:
             if (do_kernel_trap(env))
diff --git a/linux-user/cris/cpu_loop.c b/linux-user/cris/cpu_loop.c
index 37bdcfa8cc3..dacf604c7df 100644
--- a/linux-user/cris/cpu_loop.c
+++ b/linux-user/cris/cpu_loop.c
@@ -64,18 +64,10 @@ void cpu_loop(CPUCRISState *env)
             }
             break;
         case EXCP_DEBUG:
-            {
-                int sig;
-
-                sig = gdb_handlesig(cs, TARGET_SIGTRAP);
-                if (sig)
-                  {
-                    info.si_signo = sig;
-                    info.si_errno = 0;
-                    info.si_code = TARGET_TRAP_BRKPT;
-                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                  }
-            }
+            info.si_signo = TARGET_SIGTRAP;
+            info.si_errno = 0;
+            info.si_code = TARGET_TRAP_BRKPT;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case EXCP_ATOMIC:
             cpu_exec_step_atomic(cs);
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 0301c766c6f..880955fdefd 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -182,13 +182,10 @@ void cpu_loop(CPUHPPAState *env)
             queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case EXCP_DEBUG:
-            trapnr = gdb_handlesig(cs, TARGET_SIGTRAP);
-            if (trapnr) {
-                info.si_signo = trapnr;
-                info.si_errno = 0;
-                info.si_code = TARGET_TRAP_BRKPT;
-                queue_signal(env, trapnr, QEMU_SI_FAULT, &info);
-            }
+            info.si_signo = TARGET_SIGTRAP;
+            info.si_errno = 0;
+            info.si_code = TARGET_TRAP_BRKPT;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case EXCP_INTERRUPT:
             /* just indicate that signals should be handled asap */
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 2374abfd0bd..51cfa006c97 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -225,18 +225,10 @@ void cpu_loop(CPUX86State *env)
             /* just indicate that signals should be handled asap */
             break;
         case EXCP_DEBUG:
-            {
-                int sig;
-
-                sig = gdb_handlesig(cs, TARGET_SIGTRAP);
-                if (sig)
-                  {
-                    info.si_signo = sig;
-                    info.si_errno = 0;
-                    info.si_code = TARGET_TRAP_BRKPT;
-                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                  }
-            }
+            info.si_signo = TARGET_SIGTRAP;
+            info.si_errno = 0;
+            info.si_code = TARGET_TRAP_BRKPT;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case EXCP_ATOMIC:
             cpu_exec_step_atomic(cs);
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index b4d3d8af3dc..2ab5b9c8f8c 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -113,18 +113,10 @@ void cpu_loop(CPUM68KState *env)
             }
             break;
         case EXCP_DEBUG:
-            {
-                int sig;
-
-                sig = gdb_handlesig(cs, TARGET_SIGTRAP);
-                if (sig)
-                  {
-                    info.si_signo = sig;
-                    info.si_errno = 0;
-                    info.si_code = TARGET_TRAP_BRKPT;
-                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                  }
-            }
+            info.si_signo = TARGET_SIGTRAP;
+            info.si_errno = 0;
+            info.si_code = TARGET_TRAP_BRKPT;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case EXCP_ATOMIC:
             cpu_exec_step_atomic(cs);
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index 2af93eb39a6..c2190e15fdc 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -113,18 +113,10 @@ void cpu_loop(CPUMBState *env)
             }
             break;
         case EXCP_DEBUG:
-            {
-                int sig;
-
-                sig = gdb_handlesig(cs, TARGET_SIGTRAP);
-                if (sig)
-                  {
-                    info.si_signo = sig;
-                    info.si_errno = 0;
-                    info.si_code = TARGET_TRAP_BRKPT;
-                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                  }
-            }
+            info.si_signo = TARGET_SIGTRAP;
+            info.si_errno = 0;
+            info.si_code = TARGET_TRAP_BRKPT;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case EXCP_ATOMIC:
             cpu_exec_step_atomic(cs);
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index c9c20cf8b7d..417f33c6ba8 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -592,18 +592,10 @@ done_syscall:
             /* just indicate that signals should be handled asap */
             break;
         case EXCP_DEBUG:
-            {
-                int sig;
-
-                sig = gdb_handlesig(cs, TARGET_SIGTRAP);
-                if (sig)
-                  {
-                    info.si_signo = sig;
-                    info.si_errno = 0;
-                    info.si_code = TARGET_TRAP_BRKPT;
-                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                  }
-            }
+            info.si_signo = TARGET_SIGTRAP;
+            info.si_errno = 0;
+            info.si_code = TARGET_TRAP_BRKPT;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case EXCP_SC:
             if (do_store_exclusive(env)) {
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loop.c
index 6c6ea871e16..f496e4b48ad 100644
--- a/linux-user/openrisc/cpu_loop.c
+++ b/linux-user/openrisc/cpu_loop.c
@@ -85,13 +85,10 @@ void cpu_loop(CPUOpenRISCState *env)
             /* We processed the pending cpu work above.  */
             break;
         case EXCP_DEBUG:
-            trapnr = gdb_handlesig(cs, TARGET_SIGTRAP);
-            if (trapnr) {
-                info.si_signo = trapnr;
-                info.si_errno = 0;
-                info.si_code = TARGET_TRAP_BRKPT;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            }
+            info.si_signo = TARGET_SIGTRAP;
+            info.si_errno = 0;
+            info.si_code = TARGET_TRAP_BRKPT;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case EXCP_ATOMIC:
             cpu_exec_step_atomic(cs);
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index 133a87f349b..801f5ace29f 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -69,7 +69,7 @@ void cpu_loop(CPUPPCState *env)
 {
     CPUState *cs = CPU(ppc_env_get_cpu(env));
     target_siginfo_t info;
-    int trapnr, sig;
+    int trapnr;
     target_ulong ret;
 
     for(;;) {
@@ -449,15 +449,10 @@ void cpu_loop(CPUPPCState *env)
             env->gpr[3] = ret;
             break;
         case EXCP_DEBUG:
-            sig = gdb_handlesig(cs, TARGET_SIGTRAP);
-            if (sig) {
-                info.si_signo = sig;
-                info.si_errno = 0;
-                info.si_code = TARGET_TRAP_BRKPT;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            } else {
-                arch_interrupt = false;
-            }
+            info.si_signo = TARGET_SIGTRAP;
+            info.si_errno = 0;
+            info.si_code = TARGET_TRAP_BRKPT;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case EXCP_INTERRUPT:
             /* just indicate that signals should be handled asap */
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index f137d39d7e8..4cf3e946324 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -88,7 +88,7 @@ void cpu_loop(CPURISCVState *env)
             break;
         case EXCP_DEBUG:
         gdbstep:
-            signum = gdb_handlesig(cs, TARGET_SIGTRAP);
+            signum = TARGET_SIGTRAP;
             sigcode = TARGET_TRAP_BRKPT;
             break;
         default:
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index 99f5f1594f4..51b5412ea27 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -61,12 +61,9 @@ void cpu_loop(CPUS390XState *env)
             break;
 
         case EXCP_DEBUG:
-            sig = gdb_handlesig(cs, TARGET_SIGTRAP);
-            if (sig) {
-                n = TARGET_TRAP_BRKPT;
-                goto do_signal_pc;
-            }
-            break;
+            sig = TARGET_SIGTRAP;
+            n = TARGET_TRAP_BRKPT;
+            goto do_signal_pc;
         case EXCP_PGM:
             n = env->int_pgm_code;
             switch (n) {
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index fdd348170b9..47e54b9b61a 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -57,19 +57,10 @@ void cpu_loop(CPUSH4State *env)
             /* just indicate that signals should be handled asap */
             break;
         case EXCP_DEBUG:
-            {
-                int sig;
-
-                sig = gdb_handlesig(cs, TARGET_SIGTRAP);
-                if (sig) {
-                    info.si_signo = sig;
-                    info.si_errno = 0;
-                    info.si_code = TARGET_TRAP_BRKPT;
-                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                } else {
-                    arch_interrupt = false;
-                }
-            }
+            info.si_signo = TARGET_SIGTRAP;
+            info.si_errno = 0;
+            info.si_code = TARGET_TRAP_BRKPT;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case 0xa0:
         case 0xc0:
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 91f714afc6c..7d5b337b972 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -268,18 +268,10 @@ void cpu_loop (CPUSPARCState *env)
             }
             break;
         case EXCP_DEBUG:
-            {
-                int sig;
-
-                sig = gdb_handlesig(cs, TARGET_SIGTRAP);
-                if (sig)
-                  {
-                    info.si_signo = sig;
-                    info.si_errno = 0;
-                    info.si_code = TARGET_TRAP_BRKPT;
-                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                  }
-            }
+            info.si_signo = TARGET_SIGTRAP;
+            info.si_errno = 0;
+            info.si_code = TARGET_TRAP_BRKPT;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case EXCP_ATOMIC:
             cpu_exec_step_atomic(cs);
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index d142988ebe1..bee78edb8a9 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -239,13 +239,10 @@ void cpu_loop(CPUXtensaState *env)
             }
             break;
         case EXCP_DEBUG:
-            trapnr = gdb_handlesig(cs, TARGET_SIGTRAP);
-            if (trapnr) {
-                info.si_signo = trapnr;
-                info.si_errno = 0;
-                info.si_code = TARGET_TRAP_BRKPT;
-                queue_signal(env, trapnr, QEMU_SI_FAULT, &info);
-            }
+            info.si_signo = TARGET_SIGTRAP;
+            info.si_errno = 0;
+            info.si_code = TARGET_TRAP_BRKPT;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case EXC_DEBUG:
         default:
-- 
2.19.1
