Received: from eggs.gnu.org ([209.51.188.92]:55735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbjv-0004i0-70
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbjt-0003xT-HD
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:47 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbjt-0003ss-9V
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:45 -0500
Received: by mail-pg1-x544.google.com with SMTP id z11so6660047pgu.0
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:31:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:39 +1100
Message-Id: <20190118213122.22865-6-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 06/49] linux-user: Split out readlink,
 readlinkat
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

Split out a shared implementation for both of these;
unify the best parts of /proc/self/exe checking.

Remove the temporary forward declaration for is_proc_self.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  6 ++++
 linux-user/strace.c           | 29 ------------------
 linux-user/syscall-file.inc.c | 45 ++++++++++++++++++++++++++++
 linux-user/syscall.c          | 55 -----------------------------------
 linux-user/strace.list        |  6 ----
 5 files changed, 51 insertions(+), 90 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 1f3a9c47ab..d1a6c6fa3c 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -20,3 +20,9 @@
 SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 #endif
 SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
+#ifdef TARGET_NR_readlink
+SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
+#endif
+#ifdef TARGET_NR_readlinkat
+SYSCALL_DEF(readlinkat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_DEC);
+#endif
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 1e4f6c9b53..4faeb8c031 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -2244,35 +2244,6 @@ print_fstatat64(const struct syscallname *name,
 #define print_newfstatat    print_fstatat64
 #endif
 
-#ifdef TARGET_NR_readlink
-static void
-print_readlink(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_pointer(arg1, 0);
-    print_raw_param("%u", arg2, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
-#ifdef TARGET_NR_readlinkat
-static void
-print_readlinkat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_at_dirfd(arg0, 0);
-    print_string(arg1, 0);
-    print_pointer(arg2, 0);
-    print_raw_param("%u", arg3, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_rename
 static void
 print_rename(const struct syscallname *name,
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index f202a4c8f4..841795f8aa 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -308,3 +308,48 @@ SYSCALL_IMPL(openat)
 {
     return do_openat(cpu_env, arg1, arg2, arg3, arg4);
 }
+
+static abi_long do_readlinkat(int dirfd, abi_ulong target_path,
+                              abi_ulong target_buf, abi_ulong bufsiz)
+{
+    char *p = lock_user_string(target_path);
+    void *buf = lock_user(VERIFY_WRITE, target_buf, bufsiz, 0);
+    abi_long ret;
+
+    if (!p || !buf) {
+        ret = -TARGET_EFAULT;
+    } else if (!bufsiz) {
+        /* Short circuit this for the magic exe check. */
+        ret = -TARGET_EINVAL;
+    } else if (is_proc_myself((const char *)p, "exe")) {
+        char real[PATH_MAX];
+        char *temp = realpath(exec_path, real);
+
+        if (temp == NULL) {
+            ret = -host_to_target_errno(errno);
+        } else {
+            ret = MIN(strlen(real), bufsiz);
+            /* We cannot NUL terminate the string. */
+            memcpy(buf, real, ret);
+        }
+    } else {
+        ret = get_errno(readlinkat(dirfd, path(p), buf, bufsiz));
+    }
+    unlock_user(buf, target_buf, ret);
+    unlock_user(p, target_path, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_readlink
+SYSCALL_IMPL(readlink)
+{
+    return do_readlinkat(AT_FDCWD, arg1, arg2, arg3);
+}
+#endif
+
+#ifdef TARGET_NR_readlinkat
+SYSCALL_IMPL(readlinkat)
+{
+    return do_readlinkat(arg1, arg2, arg3, arg4);
+}
+#endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 32d1a285eb..035f17c0d9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6577,8 +6577,6 @@ int host_to_target_waitstatus(int status)
     return status;
 }
 
-static int is_proc_myself(const char *filename, const char *entry);
-
 #define TIMER_MAGIC 0x0caf0000
 #define TIMER_MAGIC_MASK 0xffff0000
 
@@ -8052,59 +8050,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
-#ifdef TARGET_NR_readlink
-    case TARGET_NR_readlink:
-        {
-            void *p2;
-            p = lock_user_string(arg1);
-            p2 = lock_user(VERIFY_WRITE, arg2, arg3, 0);
-            if (!p || !p2) {
-                ret = -TARGET_EFAULT;
-            } else if (!arg3) {
-                /* Short circuit this for the magic exe check. */
-                ret = -TARGET_EINVAL;
-            } else if (is_proc_myself((const char *)p, "exe")) {
-                char real[PATH_MAX], *temp;
-                temp = realpath(exec_path, real);
-                /* Return value is # of bytes that we wrote to the buffer. */
-                if (temp == NULL) {
-                    ret = get_errno(-1);
-                } else {
-                    /* Don't worry about sign mismatch as earlier mapping
-                     * logic would have thrown a bad address error. */
-                    ret = MIN(strlen(real), arg3);
-                    /* We cannot NUL terminate the string. */
-                    memcpy(p2, real, ret);
-                }
-            } else {
-                ret = get_errno(readlink(path(p), p2, arg3));
-            }
-            unlock_user(p2, arg2, ret);
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_readlinkat)
-    case TARGET_NR_readlinkat:
-        {
-            void *p2;
-            p  = lock_user_string(arg2);
-            p2 = lock_user(VERIFY_WRITE, arg3, arg4, 0);
-            if (!p || !p2) {
-                ret = -TARGET_EFAULT;
-            } else if (is_proc_myself((const char *)p, "exe")) {
-                char real[PATH_MAX], *temp;
-                temp = realpath(exec_path, real);
-                ret = temp == NULL ? get_errno(-1) : strlen(real) ;
-                snprintf((char *)p2, arg4, "%s", real);
-            } else {
-                ret = get_errno(readlinkat(arg1, path(p), p2, arg4));
-            }
-            unlock_user(p2, arg3, ret);
-            unlock_user(p, arg2, 0);
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_swapon
     case TARGET_NR_swapon:
         if (!(p = lock_user_string(arg1)))
diff --git a/linux-user/strace.list b/linux-user/strace.list
index b2d3e99df7..2f466e5699 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1079,12 +1079,6 @@
 #ifdef TARGET_NR_readdir
 { TARGET_NR_readdir, "readdir" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_readlink
-{ TARGET_NR_readlink, "readlink" , NULL, print_readlink, NULL },
-#endif
-#ifdef TARGET_NR_readlinkat
-{ TARGET_NR_readlinkat, "readlinkat" , NULL, print_readlinkat, NULL },
-#endif
 #ifdef TARGET_NR_readv
 { TARGET_NR_readv, "readv" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
