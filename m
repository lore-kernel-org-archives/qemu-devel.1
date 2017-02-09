Received: from eggs.gnu.org ([2001:4830:134:3::10]:37962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgiM-00020U-Ju
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgiL-0007iu-Jl
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:14 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cbgiL-0007il-CB
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:13 -0500
Received: by mail-pg0-x241.google.com with SMTP id 75so16789762pgf.3
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 20:52:13 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  8 Feb 2017 20:51:35 -0800
Message-Id: <20170209045154.16868-4-rth@twiddle.net>
In-Reply-To: <20170209045154.16868-1-rth@twiddle.net>
References: <20170209045154.16868-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 03/22] linux-user: Fix openrisc cpu_loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

We need to handle EXCP_DEBUG and EXCP_INTERRUPT.
We need to send signals to the guest using queue_signal.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/main.c | 95 ++++++++++++++++++++++++-------------------------------
 1 file changed, 41 insertions(+), 54 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index e588f58..001f71c 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -2574,52 +2574,17 @@ kuser_fail:
 void cpu_loop(CPUOpenRISCState *env)
 {
     CPUState *cs = CPU(openrisc_env_get_cpu(env));
-    int trapnr, gdbsig;
+    int trapnr;
     abi_long ret;
+    target_siginfo_t info;
 
     for (;;) {
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
         process_queued_cpu_work(cs);
-        gdbsig = 0;
 
         switch (trapnr) {
-        case EXCP_RESET:
-            qemu_log_mask(CPU_LOG_INT, "\nReset request, exit, pc is %#x\n", env->pc);
-            exit(EXIT_FAILURE);
-            break;
-        case EXCP_BUSERR:
-            qemu_log_mask(CPU_LOG_INT, "\nBus error, exit, pc is %#x\n", env->pc);
-            gdbsig = TARGET_SIGBUS;
-            break;
-        case EXCP_DPF:
-        case EXCP_IPF:
-            cpu_dump_state(cs, stderr, fprintf, 0);
-            gdbsig = TARGET_SIGSEGV;
-            break;
-        case EXCP_TICK:
-            qemu_log_mask(CPU_LOG_INT, "\nTick time interrupt pc is %#x\n", env->pc);
-            break;
-        case EXCP_ALIGN:
-            qemu_log_mask(CPU_LOG_INT, "\nAlignment pc is %#x\n", env->pc);
-            gdbsig = TARGET_SIGBUS;
-            break;
-        case EXCP_ILLEGAL:
-            qemu_log_mask(CPU_LOG_INT, "\nIllegal instructionpc is %#x\n", env->pc);
-            gdbsig = TARGET_SIGILL;
-            break;
-        case EXCP_INT:
-            qemu_log_mask(CPU_LOG_INT, "\nExternal interruptpc is %#x\n", env->pc);
-            break;
-        case EXCP_DTLBMISS:
-        case EXCP_ITLBMISS:
-            qemu_log_mask(CPU_LOG_INT, "\nTLB miss\n");
-            break;
-        case EXCP_RANGE:
-            qemu_log_mask(CPU_LOG_INT, "\nRange\n");
-            gdbsig = TARGET_SIGSEGV;
-            break;
         case EXCP_SYSCALL:
             env->pc += 4;   /* 0xc00; */
             ret = do_syscall(env,
@@ -2636,32 +2601,54 @@ void cpu_loop(CPUOpenRISCState *env)
                 env->gpr[11] = ret;
             }
             break;
+        case EXCP_DPF:
+        case EXCP_IPF:
+        case EXCP_RANGE:
+            info.si_signo = TARGET_SIGSEGV;
+            info.si_errno = 0;
+            info.si_code = TARGET_SEGV_MAPERR;
+            info._sifields._sigfault._addr = env->pc;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
+        case EXCP_ALIGN:
+            info.si_signo = TARGET_SIGBUS;
+            info.si_errno = 0;
+            info.si_code = TARGET_BUS_ADRALN;
+            info._sifields._sigfault._addr = env->pc;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
+        case EXCP_ILLEGAL:
+            info.si_signo = TARGET_SIGILL;
+            info.si_errno = 0;
+            info.si_code = TARGET_ILL_ILLOPC;
+            info._sifields._sigfault._addr = env->pc;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
         case EXCP_FPE:
-            qemu_log_mask(CPU_LOG_INT, "\nFloating point error\n");
+            info.si_signo = TARGET_SIGFPE;
+            info.si_errno = 0;
+            info.si_code = 0;
+            info._sifields._sigfault._addr = env->pc;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
-        case EXCP_TRAP:
-            qemu_log_mask(CPU_LOG_INT, "\nTrap\n");
-            gdbsig = TARGET_SIGTRAP;
+        case EXCP_INTERRUPT:
+            /* We processed the pending cpu work above.  */
             break;
-        case EXCP_NR:
-            qemu_log_mask(CPU_LOG_INT, "\nNR\n");
+        case EXCP_DEBUG:
+            trapnr = gdb_handlesig(cs, TARGET_SIGTRAP);
+            if (trapnr) {
+                info.si_signo = trapnr;
+                info.si_errno = 0;
+                info.si_code = TARGET_TRAP_BRKPT;
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            }
             break;
         case EXCP_ATOMIC:
             cpu_exec_step_atomic(cs);
             break;
         default:
-            EXCP_DUMP(env, "\nqemu: unhandled CPU exception %#x - aborting\n",
-                     trapnr);
-            gdbsig = TARGET_SIGILL;
-            break;
-        }
-        if (gdbsig) {
-            gdb_handlesig(cs, gdbsig);
-            if (gdbsig != TARGET_SIGTRAP) {
-                exit(EXIT_FAILURE);
-            }
+            g_assert_not_reached();
         }
-
         process_pending_signals(env);
     }
 }
-- 
2.9.3
