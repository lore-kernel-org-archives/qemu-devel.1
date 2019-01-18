Received: from eggs.gnu.org ([209.51.188.92]:55981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkZ-0005HS-Ro
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkQ-0004hk-MZ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:21 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:47056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbkM-0004dE-Tp
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:16 -0500
Received: by mail-pl1-x644.google.com with SMTP id t13so6870391ply.13
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:52 +1100
Message-Id: <20190118213122.22865-19-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 19/49] linux-user: Split out wait4, waitid,
 waitpid
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

Note that waitid is universally provided and need not be conditional.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  5 ++
 linux-user/syscall-proc.inc.c | 88 +++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 67 --------------------------
 linux-user/strace.list        |  9 ----
 4 files changed, 93 insertions(+), 76 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 6f6f77927b..a84050a318 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -118,5 +118,10 @@ SYSCALL_DEF(shmget, ARG_DEC, ARG_DEC, ARG_HEX);
 /* Emulate vfork() with fork().  */
 SYSCALL_DEF_FULL(vfork, .impl = impl_fork);
 #endif
+SYSCALL_DEF(wait4, ARG_DEC, ARG_PTR, ARG_HEX, ARG_PTR);
+SYSCALL_DEF(waitid, ARG_HEX, ARG_DEC, ARG_PTR, ARG_HEX);
+#ifdef TARGET_NR_waitpid
+SYSCALL_DEF(waitpid, ARG_DEC, ARG_PTR, ARG_HEX);
+#endif
 SYSCALL_DEF(write, ARG_DEC, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(writev, ARG_DEC, ARG_PTR, ARG_DEC);
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index b89ac56552..37f5bbe197 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -318,3 +318,91 @@ SYSCALL_IMPL(fork)
     return do_clone(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0);
 }
 #endif
+
+/*
+ * Map host to target signal numbers for the wait family of syscalls.
+ * Assume all other status bits are the same.
+ */
+int host_to_target_waitstatus(int status)
+{
+    if (WIFSIGNALED(status)) {
+        return host_to_target_signal(WTERMSIG(status)) | (status & ~0x7f);
+    }
+    if (WIFSTOPPED(status)) {
+        return (host_to_target_signal(WSTOPSIG(status)) << 8)
+               | (status & 0xff);
+    }
+    return status;
+}
+
+SYSCALL_IMPL(wait4)
+{
+    int status;
+    pid_t pid = arg1;
+    abi_ulong status_ptr = arg2;
+    int options = arg3;
+    abi_ulong target_rusage = arg4;
+    struct rusage rusage;
+    struct rusage *rusage_ptr = target_rusage ? &rusage : NULL;
+    abi_long ret;
+
+    ret = get_errno(safe_wait4(pid, &status, options, rusage_ptr));
+    if (!is_error(ret)) {
+        if (status_ptr && ret) {
+            status = host_to_target_waitstatus(status);
+            if (put_user_s32(status, status_ptr)) {
+                return -TARGET_EFAULT;
+            }
+        }
+        if (target_rusage) {
+            abi_long err = host_to_target_rusage(target_rusage, &rusage);
+            if (err) {
+                ret = err;
+            }
+        }
+    }
+    return ret;
+}
+
+SYSCALL_IMPL(waitid)
+{
+    idtype_t idtype = arg1;
+    id_t id = arg2;
+    abi_ulong target_info = arg3;
+    int options = arg4;
+    siginfo_t info, *info_ptr = target_info ? &info : NULL;
+    abi_long ret;
+
+    info.si_pid = 0;
+    ret = get_errno(safe_waitid(idtype, id, info_ptr, options, NULL));
+    if (!is_error(ret) && target_info && info.si_pid != 0) {
+        target_siginfo_t *p = lock_user(VERIFY_WRITE, target_info,
+                                        sizeof(target_siginfo_t), 0);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        host_to_target_siginfo(p, &info);
+        unlock_user(p, target_info, sizeof(target_siginfo_t));
+    }
+    return ret;
+}
+
+#ifdef TARGET_NR_waitpid
+SYSCALL_IMPL(waitpid)
+{
+    pid_t pid = arg1;
+    abi_ulong target_status = arg2;
+    int options = arg3;
+    int status;
+    abi_long ret;
+
+    ret = get_errno(safe_wait4(pid, &status, options, NULL));
+    if (!is_error(ret)
+        && target_status
+        && ret
+        && put_user_s32(host_to_target_waitstatus(status), target_status)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1d18d28fbe..8da92dd188 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5218,20 +5218,6 @@ static abi_long do_signalfd4(int fd, abi_long mask, int flags)
 }
 #endif
 
-/* Map host to target signal numbers for the wait family of syscalls.
-   Assume all other status bits are the same.  */
-int host_to_target_waitstatus(int status)
-{
-    if (WIFSIGNALED(status)) {
-        return host_to_target_signal(WTERMSIG(status)) | (status & ~0x7f);
-    }
-    if (WIFSTOPPED(status)) {
-        return (host_to_target_signal(WSTOPSIG(status)) << 8)
-               | (status & 0xff);
-    }
-    return status;
-}
-
 #define TIMER_MAGIC 0x0caf0000
 #define TIMER_MAGIC_MASK 0xffff0000
 
@@ -5344,32 +5330,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_waitpid
-    case TARGET_NR_waitpid:
-        {
-            int status;
-            ret = get_errno(safe_wait4(arg1, &status, arg3, 0));
-            if (!is_error(ret) && arg2 && ret
-                && put_user_s32(host_to_target_waitstatus(status), arg2))
-                return -TARGET_EFAULT;
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_waitid
-    case TARGET_NR_waitid:
-        {
-            siginfo_t info;
-            info.si_pid = 0;
-            ret = get_errno(safe_waitid(arg1, arg2, &info, arg4, NULL));
-            if (!is_error(ret) && arg3 && info.si_pid != 0) {
-                if (!(p = lock_user(VERIFY_WRITE, arg3, sizeof(target_siginfo_t), 0)))
-                    return -TARGET_EFAULT;
-                host_to_target_siginfo(p, &info);
-                unlock_user(p, arg3, sizeof(target_siginfo_t));
-            }
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_creat /* not on alpha */
     case TARGET_NR_creat:
         if (!(p = lock_user_string(arg1)))
@@ -6969,33 +6929,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return do_syscall(cpu_env, arg1 & 0xffff, arg2, arg3, arg4, arg5,
                           arg6, arg7, arg8, 0);
 #endif
-    case TARGET_NR_wait4:
-        {
-            int status;
-            abi_long status_ptr = arg2;
-            struct rusage rusage, *rusage_ptr;
-            abi_ulong target_rusage = arg4;
-            abi_long rusage_err;
-            if (target_rusage)
-                rusage_ptr = &rusage;
-            else
-                rusage_ptr = NULL;
-            ret = get_errno(safe_wait4(arg1, &status, arg3, rusage_ptr));
-            if (!is_error(ret)) {
-                if (status_ptr && ret) {
-                    status = host_to_target_waitstatus(status);
-                    if (put_user_s32(status, status_ptr))
-                        return -TARGET_EFAULT;
-                }
-                if (target_rusage) {
-                    rusage_err = host_to_target_rusage(target_rusage, &rusage);
-                    if (rusage_err) {
-                        ret = rusage_err;
-                    }
-                }
-            }
-        }
-        return ret;
 #ifdef TARGET_NR_swapoff
     case TARGET_NR_swapoff:
         if (!(p = lock_user_string(arg1)))
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 0d978ea580..afa1521e2d 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1494,15 +1494,6 @@
 #ifdef TARGET_NR_vserver
 { TARGET_NR_vserver, "vserver" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_wait4
-{ TARGET_NR_wait4, "wait4" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_waitid
-{ TARGET_NR_waitid, "waitid" , "%s(%#x,%d,%p,%#x)", NULL, NULL },
-#endif
-#ifdef TARGET_NR_waitpid
-{ TARGET_NR_waitpid, "waitpid" , "%s(%d,%p,%#x)", NULL, NULL },
-#endif
 #ifdef TARGET_NR_utimensat
 { TARGET_NR_utimensat, "utimensat", NULL, print_utimensat, NULL },
 #endif
-- 
2.17.2
