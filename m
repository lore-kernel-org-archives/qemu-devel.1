Received: from eggs.gnu.org ([209.51.188.92]:56111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkh-0005Op-Mn
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkd-0004tD-QN
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:35 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbkd-0004oi-Ct
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:31 -0500
Received: by mail-pf1-x441.google.com with SMTP id q1so7203420pfi.5
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:58 +1100
Message-Id: <20190118213122.22865-25-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 25/49] linux-user: Implement execveat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

A trivial extension to our current execve implementation
to support the new(ish) syscall.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  1 +
 linux-user/syscall-proc.inc.c | 19 ++++++++++++++-----
 linux-user/syscall.c          |  3 ++-
 linux-user/strace.list        |  3 ---
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 58fef48666..392bd1579c 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -26,6 +26,7 @@ SYSCALL_DEF(creat, ARG_STR, ARG_MODEFLAG);
 #endif
 SYSCALL_DEF(exit, ARG_DEC);
 SYSCALL_DEF(execve, ARG_STR, ARG_PTR, ARG_PTR);
+SYSCALL_DEF(execveat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_PTR, ARG_ATFLAG);
 #ifdef TARGET_NR_fork
 SYSCALL_DEF(fork);
 #endif
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index 552aea60ae..699370c290 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -269,14 +269,13 @@ SYSCALL_IMPL(clone)
     return do_clone(cpu_env, arg1, arg2, arg3, arg4, arg5);
 }
 
-SYSCALL_IMPL(execve)
+static abi_long do_execveat(int dirfd, abi_ulong guest_path,
+                            abi_ulong guest_argp, abi_ulong guest_envp,
+                            int flags)
 {
     char **argp, **envp;
     int argc, envc;
     abi_ulong gp;
-    abi_ulong guest_path = arg1;
-    abi_ulong guest_argp = arg2;
-    abi_ulong guest_envp = arg3;
     abi_ulong addr;
     char **q, *p;
     int total_size = 0;
@@ -356,7 +355,7 @@ SYSCALL_IMPL(execve)
      * before the execve completes and makes it the other
      * program's problem.
      */
-    ret = get_errno(safe_execve(p, argp, envp));
+    ret = get_errno(safe_execveat(dirfd, p, argp, envp, flags));
     unlock_user(p, guest_path, 0);
 
  execve_free:
@@ -379,6 +378,16 @@ SYSCALL_IMPL(execve)
     return ret;
 }
 
+SYSCALL_IMPL(execve)
+{
+    return do_execveat(AT_FDCWD, arg1, arg2, arg3, 0);
+}
+
+SYSCALL_IMPL(execveat)
+{
+    return do_execveat(arg1, arg2, arg3, arg4, arg5);
+}
+
 SYSCALL_IMPL(exit)
 {
     CPUState *cpu = ENV_GET_CPU(cpu_env);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9b5b2eb7f1..3a027651e3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -682,7 +682,8 @@ safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
               struct rusage *, rusage)
 safe_syscall5(int, waitid, idtype_t, idtype, id_t, id, siginfo_t *, infop, \
               int, options, struct rusage *, rusage)
-safe_syscall3(int, execve, const char *, filename, char **, argv, char **, envp)
+safe_syscall5(int, execveat, int, dirfd, const char *, filename,
+              char **, argv, char **, envp, int, flags)
 safe_syscall6(int, pselect6, int, nfds, fd_set *, readfds, fd_set *, writefds, \
               fd_set *, exceptfds, struct timespec *, timeout, void *, sig)
 safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 8bc3fe6088..202bfa8f9e 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -139,9 +139,6 @@
 #ifdef TARGET_NR_execv
 { TARGET_NR_execv, "execv" , NULL, print_execv, NULL },
 #endif
-#ifdef TARGET_NR_execveat
-{ TARGET_NR_execveat, "execveat" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_exec_with_loader
 { TARGET_NR_exec_with_loader, "exec_with_loader" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
