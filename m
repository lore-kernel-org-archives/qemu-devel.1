Received: from eggs.gnu.org ([2001:4830:134:3::10]:33287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4qT-0006ij-5x
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4qN-0006Xs-CJ
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:11:41 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Apr 2018 11:10:28 +0200
Message-Id: <20180430091037.13878-34-laurent@vivier.eu>
In-Reply-To: <20180430091037.13878-1-laurent@vivier.eu>
References: <20180430091037.13878-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 33/42] linux-user: move cris cpu loop to cris
 directory
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

No code change, only move code from main.c to
cris/cpu_loop.c.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180411185651.21351-12-laurent@vivier.eu>
---
 linux-user/cris/cpu_loop.c | 89 +++++++++++++++++++++++++++++++++++++++++++++
 linux-user/main.c          | 90 ----------------------------------------------
 2 files changed, 89 insertions(+), 90 deletions(-)

diff --git a/linux-user/cris/cpu_loop.c b/linux-user/cris/cpu_loop.c
index b7700a5561..1c5eca9f83 100644
--- a/linux-user/cris/cpu_loop.c
+++ b/linux-user/cris/cpu_loop.c
@@ -21,6 +21,95 @@
 #include "qemu.h"
 #include "cpu_loop-common.h"
 
+void cpu_loop(CPUCRISState *env)
+{
+    CPUState *cs = CPU(cris_env_get_cpu(env));
+    int trapnr, ret;
+    target_siginfo_t info;
+    
+    while (1) {
+        cpu_exec_start(cs);
+        trapnr = cpu_exec(cs);
+        cpu_exec_end(cs);
+        process_queued_cpu_work(cs);
+
+        switch (trapnr) {
+        case 0xaa:
+            {
+                info.si_signo = TARGET_SIGSEGV;
+                info.si_errno = 0;
+                /* XXX: check env->error_code */
+                info.si_code = TARGET_SEGV_MAPERR;
+                info._sifields._sigfault._addr = env->pregs[PR_EDA];
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            }
+            break;
+        case EXCP_INTERRUPT:
+          /* just indicate that signals should be handled asap */
+          break;
+        case EXCP_BREAK:
+            ret = do_syscall(env, 
+                             env->regs[9], 
+                             env->regs[10], 
+                             env->regs[11], 
+                             env->regs[12], 
+                             env->regs[13], 
+                             env->pregs[7], 
+                             env->pregs[11],
+                             0, 0);
+            if (ret == -TARGET_ERESTARTSYS) {
+                env->pc -= 2;
+            } else if (ret != -TARGET_QEMU_ESIGRETURN) {
+                env->regs[10] = ret;
+            }
+            break;
+        case EXCP_DEBUG:
+            {
+                int sig;
+
+                sig = gdb_handlesig(cs, TARGET_SIGTRAP);
+                if (sig)
+                  {
+                    info.si_signo = sig;
+                    info.si_errno = 0;
+                    info.si_code = TARGET_TRAP_BRKPT;
+                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                  }
+            }
+            break;
+        case EXCP_ATOMIC:
+            cpu_exec_step_atomic(cs);
+            break;
+        default:
+            printf ("Unhandled trap: 0x%x\n", trapnr);
+            cpu_dump_state(cs, stderr, fprintf, 0);
+            exit(EXIT_FAILURE);
+        }
+        process_pending_signals (env);
+    }
+}
+
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
+    CPUState *cpu = ENV_GET_CPU(env);
+    TaskState *ts = cpu->opaque;
+    struct image_info *info = ts->info;
+
+    env->regs[0] = regs->r0;
+    env->regs[1] = regs->r1;
+    env->regs[2] = regs->r2;
+    env->regs[3] = regs->r3;
+    env->regs[4] = regs->r4;
+    env->regs[5] = regs->r5;
+    env->regs[6] = regs->r6;
+    env->regs[7] = regs->r7;
+    env->regs[8] = regs->r8;
+    env->regs[9] = regs->r9;
+    env->regs[10] = regs->r10;
+    env->regs[11] = regs->r11;
+    env->regs[12] = regs->r12;
+    env->regs[13] = regs->r13;
+    env->regs[14] = info->start_stack;
+    env->regs[15] = regs->acr;
+    env->pc = regs->erp;
 }
diff --git a/linux-user/main.c b/linux-user/main.c
index d7fee3e3db..9e01325d6a 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -149,76 +149,6 @@ void fork_end(int child)
     }
 }
 
-#ifdef TARGET_CRIS
-void cpu_loop(CPUCRISState *env)
-{
-    CPUState *cs = CPU(cris_env_get_cpu(env));
-    int trapnr, ret;
-    target_siginfo_t info;
-    
-    while (1) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
-
-        switch (trapnr) {
-        case 0xaa:
-            {
-                info.si_signo = TARGET_SIGSEGV;
-                info.si_errno = 0;
-                /* XXX: check env->error_code */
-                info.si_code = TARGET_SEGV_MAPERR;
-                info._sifields._sigfault._addr = env->pregs[PR_EDA];
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            }
-            break;
-	case EXCP_INTERRUPT:
-	  /* just indicate that signals should be handled asap */
-	  break;
-        case EXCP_BREAK:
-            ret = do_syscall(env, 
-                             env->regs[9], 
-                             env->regs[10], 
-                             env->regs[11], 
-                             env->regs[12], 
-                             env->regs[13], 
-                             env->pregs[7], 
-                             env->pregs[11],
-                             0, 0);
-            if (ret == -TARGET_ERESTARTSYS) {
-                env->pc -= 2;
-            } else if (ret != -TARGET_QEMU_ESIGRETURN) {
-                env->regs[10] = ret;
-            }
-            break;
-        case EXCP_DEBUG:
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
-            break;
-        case EXCP_ATOMIC:
-            cpu_exec_step_atomic(cs);
-            break;
-        default:
-            printf ("Unhandled trap: 0x%x\n", trapnr);
-            cpu_dump_state(cs, stderr, fprintf, 0);
-            exit(EXIT_FAILURE);
-        }
-        process_pending_signals (env);
-    }
-}
-#endif
-
 #ifdef TARGET_MICROBLAZE
 void cpu_loop(CPUMBState *env)
 {
@@ -2290,26 +2220,6 @@ int main(int argc, char **argv, char **envp)
         env->ir[IR_SP] = regs->usp;
         env->pc = regs->pc;
     }
-#elif defined(TARGET_CRIS)
-    {
-	    env->regs[0] = regs->r0;
-	    env->regs[1] = regs->r1;
-	    env->regs[2] = regs->r2;
-	    env->regs[3] = regs->r3;
-	    env->regs[4] = regs->r4;
-	    env->regs[5] = regs->r5;
-	    env->regs[6] = regs->r6;
-	    env->regs[7] = regs->r7;
-	    env->regs[8] = regs->r8;
-	    env->regs[9] = regs->r9;
-	    env->regs[10] = regs->r10;
-	    env->regs[11] = regs->r11;
-	    env->regs[12] = regs->r12;
-	    env->regs[13] = regs->r13;
-	    env->regs[14] = info->start_stack;
-	    env->regs[15] = regs->acr;	    
-	    env->pc = regs->erp;
-    }
 #elif defined(TARGET_S390X)
     {
             int i;
-- 
2.14.3
