Received: from eggs.gnu.org ([2001:4830:134:3::10]:43507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzs5-00077y-KJ
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzs1-0002RE-8W
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:21 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:60970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1edzs0-0002Pu-Te
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:17 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 23 Jan 2018 15:48:05 +0100
Message-Id: <20180123144807.5618-12-laurent@vivier.eu>
In-Reply-To: <20180123144807.5618-1-laurent@vivier.eu>
References: <20180123144807.5618-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 11/13] linux-user: Propagate siginfo_t through
 to handle_cpu_signal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>

From: Peter Maydell <peter.maydell@linaro.org>

Currently all the architecture/OS specific cpu_signal_handler()
functions call handle_cpu_signal() without passing it the
siginfo_t. We're going to want that so we can look at the si_code
to determine whether this is a SEGV_ACCERR access violation or
some other kind of fault, so change the functions to pass through
the pointer to the siginfo_t rather than just the si_addr value.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <1511879725-9576-2-git-send-email-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 accel/tcg/user-exec.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index f42285ea1c..e8f26ff0cb 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -57,12 +57,13 @@ static void cpu_exit_tb_from_sighandler(CPUState *cpu, sigset_t *old_set)
    the effective address of the memory exception. 'is_write' is 1 if a
    write caused the exception and otherwise 0'. 'old_set' is the
    signal set which should be restored */
-static inline int handle_cpu_signal(uintptr_t pc, unsigned long address,
+static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
                                     int is_write, sigset_t *old_set)
 {
     CPUState *cpu = current_cpu;
     CPUClass *cc;
     int ret;
+    unsigned long address = (unsigned long)info->si_addr;
 
     /* We must handle PC addresses from two different sources:
      * a call return address and a signal frame address.
@@ -215,9 +216,8 @@ int cpu_signal_handler(int host_signum, void *pinfo,
 #endif
     pc = EIP_sig(uc);
     trapno = TRAP_sig(uc);
-    return handle_cpu_signal(pc, (unsigned long)info->si_addr,
-                             trapno == 0xe ?
-                             (ERROR_sig(uc) >> 1) & 1 : 0,
+    return handle_cpu_signal(pc, info,
+                             trapno == 0xe ? (ERROR_sig(uc) >> 1) & 1 : 0,
                              &MASK_sig(uc));
 }
 
@@ -261,9 +261,8 @@ int cpu_signal_handler(int host_signum, void *pinfo,
 #endif
 
     pc = PC_sig(uc);
-    return handle_cpu_signal(pc, (unsigned long)info->si_addr,
-                             TRAP_sig(uc) == 0xe ?
-                             (ERROR_sig(uc) >> 1) & 1 : 0,
+    return handle_cpu_signal(pc, info,
+                             TRAP_sig(uc) == 0xe ? (ERROR_sig(uc) >> 1) & 1 : 0,
                              &MASK_sig(uc));
 }
 
@@ -341,8 +340,7 @@ int cpu_signal_handler(int host_signum, void *pinfo,
         is_write = 1;
     }
 #endif
-    return handle_cpu_signal(pc, (unsigned long)info->si_addr,
-                             is_write, &uc->uc_sigmask);
+    return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
 }
 
 #elif defined(__alpha__)
@@ -372,8 +370,7 @@ int cpu_signal_handler(int host_signum, void *pinfo,
         is_write = 1;
     }
 
-    return handle_cpu_signal(pc, (unsigned long)info->si_addr,
-                             is_write, &uc->uc_sigmask);
+    return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
 }
 #elif defined(__sparc__)
 
@@ -432,8 +429,7 @@ int cpu_signal_handler(int host_signum, void *pinfo,
             break;
         }
     }
-    return handle_cpu_signal(pc, (unsigned long)info->si_addr,
-                             is_write, sigmask);
+    return handle_cpu_signal(pc, info, is_write, sigmask);
 }
 
 #elif defined(__arm__)
@@ -466,9 +462,7 @@ int cpu_signal_handler(int host_signum, void *pinfo,
      * later processor; on v5 we will always report this as a read).
      */
     is_write = extract32(uc->uc_mcontext.error_code, 11, 1);
-    return handle_cpu_signal(pc, (unsigned long)info->si_addr,
-                             is_write,
-                             &uc->uc_sigmask);
+    return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
 }
 
 #elif defined(__aarch64__)
@@ -495,8 +489,7 @@ int cpu_signal_handler(int host_signum, void *pinfo, void *puc)
                 /* Ignore bits 23 & 24, controlling indexing.  */
                 || (insn & 0x3a400000) == 0x28000000); /* C3.3.7,14-16 */
 
-    return handle_cpu_signal(pc, (uintptr_t)info->si_addr,
-                             is_write, &uc->uc_sigmask);
+    return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
 }
 
 #elif defined(__ia64)
@@ -529,9 +522,7 @@ int cpu_signal_handler(int host_signum, void *pinfo, void *puc)
     default:
         break;
     }
-    return handle_cpu_signal(ip, (unsigned long)info->si_addr,
-                             is_write,
-                             (sigset_t *)&uc->uc_sigmask);
+    return handle_cpu_signal(ip, info, is_write, (sigset_t *)&uc->uc_sigmask);
 }
 
 #elif defined(__s390__)
@@ -583,8 +574,7 @@ int cpu_signal_handler(int host_signum, void *pinfo,
         }
         break;
     }
-    return handle_cpu_signal(pc, (unsigned long)info->si_addr,
-                             is_write, &uc->uc_sigmask);
+    return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
 }
 
 #elif defined(__mips__)
@@ -599,8 +589,7 @@ int cpu_signal_handler(int host_signum, void *pinfo,
 
     /* XXX: compute is_write */
     is_write = 0;
-    return handle_cpu_signal(pc, (unsigned long)info->si_addr,
-                             is_write, &uc->uc_sigmask);
+    return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
 }
 
 #else
-- 
2.14.3
