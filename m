Received: from eggs.gnu.org ([209.51.188.92]:55785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbjx-0004jZ-94
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbjv-00041s-KK
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:49 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbjv-00040B-Bw
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:47 -0500
Received: by mail-pf1-x441.google.com with SMTP id 64so7190254pfr.9
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:31:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:41 +1100
Message-Id: <20190118213122.22865-8-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 08/49] linux-user: Split out read, write
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
 linux-user/syscall-defs.h     |  2 ++
 linux-user/syscall-file.inc.c | 58 +++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 34 --------------------
 linux-user/strace.list        |  6 ----
 4 files changed, 60 insertions(+), 40 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 797426ae6f..b031de1375 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -21,9 +21,11 @@ SYSCALL_DEF(close, ARG_DEC);
 SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 #endif
 SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
+SYSCALL_DEF(read, ARG_DEC, ARG_PTR, ARG_DEC);
 #ifdef TARGET_NR_readlink
 SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
 #endif
 #ifdef TARGET_NR_readlinkat
 SYSCALL_DEF(readlinkat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_DEC);
 #endif
+SYSCALL_DEF(write, ARG_DEC, ARG_PTR, ARG_DEC);
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index feb83c4e87..9c8025b252 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -317,6 +317,32 @@ SYSCALL_IMPL(openat)
     return do_openat(cpu_env, arg1, arg2, arg3, arg4);
 }
 
+SYSCALL_IMPL(read)
+{
+    int fd = arg1;
+    abi_ulong target_p = arg2;
+    abi_ulong size = arg3;
+    void *p;
+    abi_long ret;
+
+    if (size == 0) {
+        return 0;
+    }
+    p = lock_user(VERIFY_WRITE, target_p, size, 0);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(safe_read(fd, p, size));
+    if (!is_error(ret)) {
+        TargetFdDataFunc trans = fd_trans_host_to_target_data(fd);
+        if (trans) {
+            ret = trans(p, ret);
+        }
+    }
+    unlock_user(p, target_p, ret);
+    return ret;
+}
+
 static abi_long do_readlinkat(int dirfd, abi_ulong target_path,
                               abi_ulong target_buf, abi_ulong bufsiz)
 {
@@ -361,3 +387,35 @@ SYSCALL_IMPL(readlinkat)
     return do_readlinkat(arg1, arg2, arg3, arg4);
 }
 #endif
+
+SYSCALL_IMPL(write)
+{
+    int fd = arg1;
+    abi_ulong target_p = arg2;
+    abi_ulong size = arg3;
+    TargetFdDataFunc trans;
+    abi_long ret;
+    void *p;
+
+    if (target_p == 0 && size == 0) {
+        return get_errno(safe_write(fd, 0, 0));
+    }
+    p = lock_user(VERIFY_READ, target_p, size, 1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    trans = fd_trans_target_to_host_data(fd);
+    if (trans) {
+        void *copy = g_malloc(size);
+        memcpy(copy, p, size);
+        ret = trans(copy, size);
+        if (ret >= 0) {
+            ret = get_errno(safe_write(fd, copy, ret));
+        }
+        g_free(copy);
+    } else {
+        ret = get_errno(safe_write(fd, p, size));
+    }
+    unlock_user(p, target_p, 0);
+    return ret;
+}
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f230fe161e..d4d5c25803 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6726,40 +6726,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         preexit_cleanup(cpu_env, arg1);
         _exit(arg1);
         return 0; /* avoid warning */
-    case TARGET_NR_read:
-        if (arg3 == 0) {
-            return 0;
-        } else {
-            if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
-                return -TARGET_EFAULT;
-            ret = get_errno(safe_read(arg1, p, arg3));
-            if (ret >= 0 &&
-                fd_trans_host_to_target_data(arg1)) {
-                ret = fd_trans_host_to_target_data(arg1)(p, ret);
-            }
-            unlock_user(p, arg2, ret);
-        }
-        return ret;
-    case TARGET_NR_write:
-        if (arg2 == 0 && arg3 == 0) {
-            return get_errno(safe_write(arg1, 0, 0));
-        }
-        if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
-            return -TARGET_EFAULT;
-        if (fd_trans_target_to_host_data(arg1)) {
-            void *copy = g_malloc(arg3);
-            memcpy(copy, p, arg3);
-            ret = fd_trans_target_to_host_data(arg1)(copy, arg3);
-            if (ret >= 0) {
-                ret = get_errno(safe_write(arg1, copy, ret));
-            }
-            g_free(copy);
-        } else {
-            ret = get_errno(safe_write(arg1, p, arg3));
-        }
-        unlock_user(p, arg2, 0);
-        return ret;
-
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     case TARGET_NR_name_to_handle_at:
         ret = do_name_to_handle_at(arg1, arg2, arg3, arg4, arg5);
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 71a18123bf..f3a1b0fe31 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1067,9 +1067,6 @@
 #ifdef TARGET_NR_quotactl
 { TARGET_NR_quotactl, "quotactl" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_read
-{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NULL, NULL },
-#endif
 #ifdef TARGET_NR_readahead
 { TARGET_NR_readahead, "readahead" , NULL, NULL, NULL },
 #endif
@@ -1611,9 +1608,6 @@
 #ifdef TARGET_NR_waitpid
 { TARGET_NR_waitpid, "waitpid" , "%s(%d,%p,%#x)", NULL, NULL },
 #endif
-#ifdef TARGET_NR_write
-{ TARGET_NR_write, "write" , "%s(%d,%#x,%d)", NULL, NULL },
-#endif
 #ifdef TARGET_NR_writev
 { TARGET_NR_writev, "writev" , "%s(%d,%p,%#x)", NULL, NULL },
 #endif
-- 
2.17.2
