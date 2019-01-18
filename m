Received: from eggs.gnu.org ([209.51.188.92]:56307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbl4-0005eC-Qw
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbl3-0005KB-5t
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:58 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbl2-0005D1-Sg
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:57 -0500
Received: by mail-pf1-x443.google.com with SMTP id w73so7189495pfk.10
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:09 +1100
Message-Id: <20190118213122.22865-36-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 36/49] linux-user: Split out utime, utimes,
 futimesat
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  9 ++++
 linux-user/strace.c           | 41 ---------------
 linux-user/syscall-file.inc.c | 95 +++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 63 -----------------------
 linux-user/strace.list        |  9 ----
 5 files changed, 104 insertions(+), 113 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 9d0dd7457b..2767e335d8 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -36,6 +36,9 @@ SYSCALL_DEF(execve, ARG_STR, ARG_PTR, ARG_PTR);
 SYSCALL_DEF(execveat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_PTR, ARG_ATFLAG);
 SYSCALL_DEF(fchmod, ARG_DEC, ARG_MODEFLAG);
 SYSCALL_DEF(fchmodat, ARG_ATDIRFD, ARG_STR, ARG_MODEFLAG);
+#ifdef TARGET_NR_futimesat
+SYSCALL_DEF(futimesat, ARG_ATDIRFD, ARG_STR, ARG_PTR);
+#endif
 #ifdef TARGET_NR_fork
 SYSCALL_DEF(fork);
 #endif
@@ -172,6 +175,12 @@ SYSCALL_DEF(umount2, ARG_STR, ARG_UMOUNTFLAG);
 SYSCALL_DEF(unlink, ARG_STR);
 #endif
 SYSCALL_DEF(unlinkat, ARG_ATDIRFD, ARG_STR, ARG_UNLINKATFLAG);
+#ifdef TARGET_NR_utime
+SYSCALL_DEF(utime, ARG_STR, ARG_PTR);
+#endif
+#ifdef TARGET_NR_utimes
+SYSCALL_DEF(utimes, ARG_STR, ARG_PTR);
+#endif
 #ifdef TARGET_NR_vfork
 /* Emulate vfork() with fork().  */
 SYSCALL_DEF_FULL(vfork, .impl = impl_fork);
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 78781b8817..b54949df27 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1284,21 +1284,6 @@ print_fcntl(const struct syscallname *name,
 #endif
 
 
-#ifdef TARGET_NR_futimesat
-static void
-print_futimesat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_at_dirfd(arg0, 0);
-    print_string(arg1, 0);
-    print_timeval(arg2, 0);
-    print_timeval(arg2 + sizeof (struct target_timeval), 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #if defined(TARGET_NR_socket)
 static void
 print_socket(const struct syscallname *name,
@@ -2003,32 +1988,6 @@ print_symlinkat(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_utime
-static void
-print_utime(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_pointer(arg1, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
-#ifdef TARGET_NR_utimes
-static void
-print_utimes(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_pointer(arg1, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_utimensat
 static void
 print_utimensat(const struct syscallname *name,
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 7ec1c26347..6a7ef80bfc 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -84,6 +84,38 @@ SYSCALL_IMPL(fchmodat)
     return do_fchmodat(arg1, arg2, arg3);
 }
 
+#ifdef TARGET_NR_futimesat
+SYSCALL_IMPL(futimesat)
+{
+    int dirfd = arg1;
+    abi_ulong target_path = arg2;
+    abi_ulong target_tv = arg3;
+    struct timeval *tvp, tv[2];
+    char *p;
+    abi_long ret;
+
+    if (target_tv) {
+        if (copy_from_user_timeval(&tv[0], target_tv)
+            || copy_from_user_timeval(&tv[1],
+                                      target_tv +
+                                      sizeof(struct target_timeval))) {
+            return -TARGET_EFAULT;
+        }
+        tvp = tv;
+    } else {
+        tvp = NULL;
+    }
+
+    p = lock_user_string(target_path);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(futimesat(dirfd, path(p), tvp));
+    unlock_user(p, target_path, 0);
+    return ret;
+}
+#endif
+
 static abi_long do_linkat(int olddirfd, abi_ulong target_oldpath,
                           int newdirfd, abi_ulong target_newpath,
                           int flags)
@@ -867,6 +899,69 @@ SYSCALL_IMPL(unlinkat)
     return do_unlinkat(arg1, arg2, arg3);
 }
 
+#ifdef TARGET_NR_utime
+SYSCALL_IMPL(utime)
+{
+    abi_ulong target_path = arg1;
+    abi_ulong target_times = arg2;
+    struct utimbuf tbuf, *host_tbuf;
+    struct target_utimbuf *target_tbuf;
+    char *p;
+    abi_long ret;
+
+    if (target_times) {
+        if (!lock_user_struct(VERIFY_READ, target_tbuf, target_times, 1)) {
+            return -TARGET_EFAULT;
+        }
+        tbuf.actime = tswapal(target_tbuf->actime);
+        tbuf.modtime = tswapal(target_tbuf->modtime);
+        unlock_user_struct(target_tbuf, arg2, 0);
+        host_tbuf = &tbuf;
+    } else {
+        host_tbuf = NULL;
+    }
+
+    p = lock_user_string(target_path);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(utime(p, host_tbuf));
+    unlock_user(p, target_path, 0);
+    return ret;
+}
+#endif
+
+#ifdef TARGET_NR_utimes
+SYSCALL_IMPL(utimes)
+{
+    abi_ulong target_path = arg1;
+    abi_ulong target_tv = arg2;
+    struct timeval *tvp, tv[2];
+    char *p;
+    abi_long ret;
+
+    if (target_tv) {
+        if (copy_from_user_timeval(&tv[0], target_tv)
+            || copy_from_user_timeval(&tv[1],
+                                      target_tv +
+                                      sizeof(struct target_timeval))) {
+            return -TARGET_EFAULT;
+        }
+        tvp = tv;
+    } else {
+        tvp = NULL;
+    }
+
+    p = lock_user_string(target_path);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(utimes(p, tvp));
+    unlock_user(p, target_path, 0);
+    return ret;
+}
+#endif
+
 SYSCALL_IMPL(write)
 {
     int fd = arg1;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f3ea9600c8..ca462fde61 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5327,69 +5327,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_utime
-    case TARGET_NR_utime:
-        {
-            struct utimbuf tbuf, *host_tbuf;
-            struct target_utimbuf *target_tbuf;
-            if (arg2) {
-                if (!lock_user_struct(VERIFY_READ, target_tbuf, arg2, 1))
-                    return -TARGET_EFAULT;
-                tbuf.actime = tswapal(target_tbuf->actime);
-                tbuf.modtime = tswapal(target_tbuf->modtime);
-                unlock_user_struct(target_tbuf, arg2, 0);
-                host_tbuf = &tbuf;
-            } else {
-                host_tbuf = NULL;
-            }
-            if (!(p = lock_user_string(arg1)))
-                return -TARGET_EFAULT;
-            ret = get_errno(utime(p, host_tbuf));
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_utimes
-    case TARGET_NR_utimes:
-        {
-            struct timeval *tvp, tv[2];
-            if (arg2) {
-                if (copy_from_user_timeval(&tv[0], arg2)
-                    || copy_from_user_timeval(&tv[1],
-                                              arg2 + sizeof(struct target_timeval)))
-                    return -TARGET_EFAULT;
-                tvp = tv;
-            } else {
-                tvp = NULL;
-            }
-            if (!(p = lock_user_string(arg1)))
-                return -TARGET_EFAULT;
-            ret = get_errno(utimes(p, tvp));
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_futimesat)
-    case TARGET_NR_futimesat:
-        {
-            struct timeval *tvp, tv[2];
-            if (arg3) {
-                if (copy_from_user_timeval(&tv[0], arg3)
-                    || copy_from_user_timeval(&tv[1],
-                                              arg3 + sizeof(struct target_timeval)))
-                    return -TARGET_EFAULT;
-                tvp = tv;
-            } else {
-                tvp = NULL;
-            }
-            if (!(p = lock_user_string(arg2))) {
-                return -TARGET_EFAULT;
-            }
-            ret = get_errno(futimesat(arg1, path(p), tvp));
-            unlock_user(p, arg2, 0);
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_access
     case TARGET_NR_access:
         if (!(p = lock_user_string(arg1))) {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index b119b7a20c..c0c1b896f7 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -226,9 +226,6 @@
 #ifdef TARGET_NR_futex
 { TARGET_NR_futex, "futex" , NULL, print_futex, NULL },
 #endif
-#ifdef TARGET_NR_futimesat
-{ TARGET_NR_futimesat, "futimesat" , NULL, print_futimesat, NULL },
-#endif
 #ifdef TARGET_NR_getcpu
 { TARGET_NR_getcpu, "getcpu" , "%s(%p,%d)", NULL, NULL },
 #endif
@@ -1392,12 +1389,6 @@
 #ifdef TARGET_NR_ustat
 { TARGET_NR_ustat, "ustat" , "%s(%#x,%p)", NULL, NULL },
 #endif
-#ifdef TARGET_NR_utime
-{ TARGET_NR_utime, "utime" , NULL, print_utime, NULL },
-#endif
-#ifdef TARGET_NR_utimes
-{ TARGET_NR_utimes, "utimes" , NULL, print_utimes, NULL },
-#endif
 #ifdef TARGET_NR_utrap_install
 { TARGET_NR_utrap_install, "utrap_install" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
