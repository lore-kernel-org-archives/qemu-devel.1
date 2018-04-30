Received: from eggs.gnu.org ([2001:4830:134:3::10]:33360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4qX-0006mu-3K
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4qP-0006a8-Id
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:11:44 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Apr 2018 11:10:29 +0200
Message-Id: <20180430091037.13878-35-laurent@vivier.eu>
In-Reply-To: <20180430091037.13878-1-laurent@vivier.eu>
References: <20180430091037.13878-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 34/42] linux-user: move microblaze cpu loop to
 microblaze directory
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
microblaze/cpu_loop.c.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180411185651.21351-13-laurent@vivier.eu>
---
 linux-user/main.c                | 155 ---------------------------------------
 linux-user/microblaze/cpu_loop.c | 150 +++++++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+), 155 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 9e01325d6a..9e49c8a30c 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -149,125 +149,6 @@ void fork_end(int child)
     }
 }
 
-#ifdef TARGET_MICROBLAZE
-void cpu_loop(CPUMBState *env)
-{
-    CPUState *cs = CPU(mb_env_get_cpu(env));
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
-                info._sifields._sigfault._addr = 0;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            }
-            break;
-	case EXCP_INTERRUPT:
-	  /* just indicate that signals should be handled asap */
-	  break;
-        case EXCP_BREAK:
-            /* Return address is 4 bytes after the call.  */
-            env->regs[14] += 4;
-            env->sregs[SR_PC] = env->regs[14];
-            ret = do_syscall(env, 
-                             env->regs[12], 
-                             env->regs[5], 
-                             env->regs[6], 
-                             env->regs[7], 
-                             env->regs[8], 
-                             env->regs[9], 
-                             env->regs[10],
-                             0, 0);
-            if (ret == -TARGET_ERESTARTSYS) {
-                /* Wind back to before the syscall. */
-                env->sregs[SR_PC] -= 4;
-            } else if (ret != -TARGET_QEMU_ESIGRETURN) {
-                env->regs[3] = ret;
-            }
-            /* All syscall exits result in guest r14 being equal to the
-             * PC we return to, because the kernel syscall exit "rtbd" does
-             * this. (This is true even for sigreturn(); note that r14 is
-             * not a userspace-usable register, as the kernel may clobber it
-             * at any point.)
-             */
-            env->regs[14] = env->sregs[SR_PC];
-            break;
-        case EXCP_HW_EXCP:
-            env->regs[17] = env->sregs[SR_PC] + 4;
-            if (env->iflags & D_FLAG) {
-                env->sregs[SR_ESR] |= 1 << 12;
-                env->sregs[SR_PC] -= 4;
-                /* FIXME: if branch was immed, replay the imm as well.  */
-            }
-
-            env->iflags &= ~(IMM_FLAG | D_FLAG);
-
-            switch (env->sregs[SR_ESR] & 31) {
-                case ESR_EC_DIVZERO:
-                    info.si_signo = TARGET_SIGFPE;
-                    info.si_errno = 0;
-                    info.si_code = TARGET_FPE_FLTDIV;
-                    info._sifields._sigfault._addr = 0;
-                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                    break;
-                case ESR_EC_FPU:
-                    info.si_signo = TARGET_SIGFPE;
-                    info.si_errno = 0;
-                    if (env->sregs[SR_FSR] & FSR_IO) {
-                        info.si_code = TARGET_FPE_FLTINV;
-                    }
-                    if (env->sregs[SR_FSR] & FSR_DZ) {
-                        info.si_code = TARGET_FPE_FLTDIV;
-                    }
-                    info._sifields._sigfault._addr = 0;
-                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                    break;
-                default:
-                    printf ("Unhandled hw-exception: 0x%x\n",
-                            env->sregs[SR_ESR] & ESR_EC_MASK);
-                    cpu_dump_state(cs, stderr, fprintf, 0);
-                    exit(EXIT_FAILURE);
-                    break;
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
 #ifdef TARGET_M68K
 
 void cpu_loop(CPUM68KState *env)
@@ -2169,42 +2050,6 @@ int main(int argc, char **argv, char **envp)
         env->sr = regs->sr;
         ts->sim_syscalls = 1;
     }
-#elif defined(TARGET_MICROBLAZE)
-    {
-        env->regs[0] = regs->r0;
-        env->regs[1] = regs->r1;
-        env->regs[2] = regs->r2;
-        env->regs[3] = regs->r3;
-        env->regs[4] = regs->r4;
-        env->regs[5] = regs->r5;
-        env->regs[6] = regs->r6;
-        env->regs[7] = regs->r7;
-        env->regs[8] = regs->r8;
-        env->regs[9] = regs->r9;
-        env->regs[10] = regs->r10;
-        env->regs[11] = regs->r11;
-        env->regs[12] = regs->r12;
-        env->regs[13] = regs->r13;
-        env->regs[14] = regs->r14;
-        env->regs[15] = regs->r15;	    
-        env->regs[16] = regs->r16;	    
-        env->regs[17] = regs->r17;	    
-        env->regs[18] = regs->r18;	    
-        env->regs[19] = regs->r19;	    
-        env->regs[20] = regs->r20;	    
-        env->regs[21] = regs->r21;	    
-        env->regs[22] = regs->r22;	    
-        env->regs[23] = regs->r23;	    
-        env->regs[24] = regs->r24;	    
-        env->regs[25] = regs->r25;	    
-        env->regs[26] = regs->r26;	    
-        env->regs[27] = regs->r27;	    
-        env->regs[28] = regs->r28;	    
-        env->regs[29] = regs->r29;	    
-        env->regs[30] = regs->r30;	    
-        env->regs[31] = regs->r31;	    
-        env->sregs[SR_PC] = regs->pc;
-    }
 #elif defined(TARGET_RISCV)
     {
         env->pc = regs->sepc;
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index b7700a5561..5ffb83dea2 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -21,6 +21,156 @@
 #include "qemu.h"
 #include "cpu_loop-common.h"
 
+void cpu_loop(CPUMBState *env)
+{
+    CPUState *cs = CPU(mb_env_get_cpu(env));
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
+                info._sifields._sigfault._addr = 0;
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            }
+            break;
+        case EXCP_INTERRUPT:
+          /* just indicate that signals should be handled asap */
+          break;
+        case EXCP_BREAK:
+            /* Return address is 4 bytes after the call.  */
+            env->regs[14] += 4;
+            env->sregs[SR_PC] = env->regs[14];
+            ret = do_syscall(env, 
+                             env->regs[12], 
+                             env->regs[5], 
+                             env->regs[6], 
+                             env->regs[7], 
+                             env->regs[8], 
+                             env->regs[9], 
+                             env->regs[10],
+                             0, 0);
+            if (ret == -TARGET_ERESTARTSYS) {
+                /* Wind back to before the syscall. */
+                env->sregs[SR_PC] -= 4;
+            } else if (ret != -TARGET_QEMU_ESIGRETURN) {
+                env->regs[3] = ret;
+            }
+            /* All syscall exits result in guest r14 being equal to the
+             * PC we return to, because the kernel syscall exit "rtbd" does
+             * this. (This is true even for sigreturn(); note that r14 is
+             * not a userspace-usable register, as the kernel may clobber it
+             * at any point.)
+             */
+            env->regs[14] = env->sregs[SR_PC];
+            break;
+        case EXCP_HW_EXCP:
+            env->regs[17] = env->sregs[SR_PC] + 4;
+            if (env->iflags & D_FLAG) {
+                env->sregs[SR_ESR] |= 1 << 12;
+                env->sregs[SR_PC] -= 4;
+                /* FIXME: if branch was immed, replay the imm as well.  */
+            }
+
+            env->iflags &= ~(IMM_FLAG | D_FLAG);
+
+            switch (env->sregs[SR_ESR] & 31) {
+                case ESR_EC_DIVZERO:
+                    info.si_signo = TARGET_SIGFPE;
+                    info.si_errno = 0;
+                    info.si_code = TARGET_FPE_FLTDIV;
+                    info._sifields._sigfault._addr = 0;
+                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                    break;
+                case ESR_EC_FPU:
+                    info.si_signo = TARGET_SIGFPE;
+                    info.si_errno = 0;
+                    if (env->sregs[SR_FSR] & FSR_IO) {
+                        info.si_code = TARGET_FPE_FLTINV;
+                    }
+                    if (env->sregs[SR_FSR] & FSR_DZ) {
+                        info.si_code = TARGET_FPE_FLTDIV;
+                    }
+                    info._sifields._sigfault._addr = 0;
+                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                    break;
+                default:
+                    printf ("Unhandled hw-exception: 0x%x\n",
+                            env->sregs[SR_ESR] & ESR_EC_MASK);
+                    cpu_dump_state(cs, stderr, fprintf, 0);
+                    exit(EXIT_FAILURE);
+                    break;
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
+    env->regs[14] = regs->r14;
+    env->regs[15] = regs->r15;
+    env->regs[16] = regs->r16;
+    env->regs[17] = regs->r17;
+    env->regs[18] = regs->r18;
+    env->regs[19] = regs->r19;
+    env->regs[20] = regs->r20;
+    env->regs[21] = regs->r21;
+    env->regs[22] = regs->r22;
+    env->regs[23] = regs->r23;
+    env->regs[24] = regs->r24;
+    env->regs[25] = regs->r25;
+    env->regs[26] = regs->r26;
+    env->regs[27] = regs->r27;
+    env->regs[28] = regs->r28;
+    env->regs[29] = regs->r29;
+    env->regs[30] = regs->r30;
+    env->regs[31] = regs->r31;
+    env->sregs[SR_PC] = regs->pc;
 }
-- 
2.14.3
