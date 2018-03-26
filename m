Received: from eggs.gnu.org ([2001:4830:134:3::10]:58588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0Xbu-0003PQ-B4
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0Xbq-0001dh-8O
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:16:50 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 26 Mar 2018 21:15:54 +0200
Message-Id: <20180326191603.10217-11-laurent@vivier.eu>
In-Reply-To: <20180326191603.10217-1-laurent@vivier.eu>
References: <20180326191603.10217-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 10/19] linux-user: move sh4 cpu loop
 to sh4 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>

No code change, only move code from main.c to
sh4/cpu_loop.c.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c         | 90 -----------------------------------------------
 linux-user/sh4/cpu_loop.c | 85 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 90 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 8530dbfdf1..211148858e 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -149,87 +149,6 @@ void fork_end(int child)
     }
 }
 
-#ifdef TARGET_SH4
-void cpu_loop(CPUSH4State *env)
-{
-    CPUState *cs = CPU(sh_env_get_cpu(env));
-    int trapnr, ret;
-    target_siginfo_t info;
-
-    while (1) {
-        bool arch_interrupt = true;
-
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
-
-        switch (trapnr) {
-        case 0x160:
-            env->pc += 2;
-            ret = do_syscall(env,
-                             env->gregs[3],
-                             env->gregs[4],
-                             env->gregs[5],
-                             env->gregs[6],
-                             env->gregs[7],
-                             env->gregs[0],
-                             env->gregs[1],
-                             0, 0);
-            if (ret == -TARGET_ERESTARTSYS) {
-                env->pc -= 2;
-            } else if (ret != -TARGET_QEMU_ESIGRETURN) {
-                env->gregs[0] = ret;
-            }
-            break;
-        case EXCP_INTERRUPT:
-            /* just indicate that signals should be handled asap */
-            break;
-        case EXCP_DEBUG:
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
-            break;
-	case 0xa0:
-	case 0xc0:
-            info.si_signo = TARGET_SIGSEGV;
-            info.si_errno = 0;
-            info.si_code = TARGET_SEGV_MAPERR;
-            info._sifields._sigfault._addr = env->tea;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-	    break;
-        case EXCP_ATOMIC:
-            cpu_exec_step_atomic(cs);
-            arch_interrupt = false;
-            break;
-        default:
-            printf ("Unhandled trap: 0x%x\n", trapnr);
-            cpu_dump_state(cs, stderr, fprintf, 0);
-            exit(EXIT_FAILURE);
-        }
-        process_pending_signals (env);
-
-        /* Most of the traps imply an exception or interrupt, which
-           implies an REI instruction has been executed.  Which means
-           that LDST (aka LOK_ADDR) should be cleared.  But there are
-           a few exceptions for traps internal to QEMU.  */
-        if (arch_interrupt) {
-            env->lock_addr = -1;
-        }
-    }
-}
-#endif
-
 #ifdef TARGET_CRIS
 void cpu_loop(CPUCRISState *env)
 {
@@ -2358,15 +2277,6 @@ int main(int argc, char **argv, char **envp)
         env->pc = regs->sepc;
         env->gpr[xSP] = regs->sp;
     }
-#elif defined(TARGET_SH4)
-    {
-        int i;
-
-        for(i = 0; i < 16; i++) {
-            env->gregs[i] = regs->regs[i];
-        }
-        env->pc = regs->pc;
-    }
 #elif defined(TARGET_ALPHA)
     {
         int i;
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index b7700a5561..3f0b9320e7 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -21,6 +21,91 @@
 #include "qemu.h"
 #include "cpu_loop-common.h"
 
+void cpu_loop(CPUSH4State *env)
+{
+    CPUState *cs = CPU(sh_env_get_cpu(env));
+    int trapnr, ret;
+    target_siginfo_t info;
+
+    while (1) {
+        bool arch_interrupt = true;
+
+        cpu_exec_start(cs);
+        trapnr = cpu_exec(cs);
+        cpu_exec_end(cs);
+        process_queued_cpu_work(cs);
+
+        switch (trapnr) {
+        case 0x160:
+            env->pc += 2;
+            ret = do_syscall(env,
+                             env->gregs[3],
+                             env->gregs[4],
+                             env->gregs[5],
+                             env->gregs[6],
+                             env->gregs[7],
+                             env->gregs[0],
+                             env->gregs[1],
+                             0, 0);
+            if (ret == -TARGET_ERESTARTSYS) {
+                env->pc -= 2;
+            } else if (ret != -TARGET_QEMU_ESIGRETURN) {
+                env->gregs[0] = ret;
+            }
+            break;
+        case EXCP_INTERRUPT:
+            /* just indicate that signals should be handled asap */
+            break;
+        case EXCP_DEBUG:
+            {
+                int sig;
+
+                sig = gdb_handlesig(cs, TARGET_SIGTRAP);
+                if (sig) {
+                    info.si_signo = sig;
+                    info.si_errno = 0;
+                    info.si_code = TARGET_TRAP_BRKPT;
+                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                } else {
+                    arch_interrupt = false;
+                }
+            }
+            break;
+	case 0xa0:
+	case 0xc0:
+            info.si_signo = TARGET_SIGSEGV;
+            info.si_errno = 0;
+            info.si_code = TARGET_SEGV_MAPERR;
+            info._sifields._sigfault._addr = env->tea;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+	    break;
+        case EXCP_ATOMIC:
+            cpu_exec_step_atomic(cs);
+            arch_interrupt = false;
+            break;
+        default:
+            printf ("Unhandled trap: 0x%x\n", trapnr);
+            cpu_dump_state(cs, stderr, fprintf, 0);
+            exit(EXIT_FAILURE);
+        }
+        process_pending_signals (env);
+
+        /* Most of the traps imply an exception or interrupt, which
+           implies an REI instruction has been executed.  Which means
+           that LDST (aka LOK_ADDR) should be cleared.  But there are
+           a few exceptions for traps internal to QEMU.  */
+        if (arch_interrupt) {
+            env->lock_addr = -1;
+        }
+    }
+}
+
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
+    int i;
+
+    for(i = 0; i < 16; i++) {
+        env->gregs[i] = regs->regs[i];
+    }
+    env->pc = regs->pc;
 }
-- 
2.14.3
