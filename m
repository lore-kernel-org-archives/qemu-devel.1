Received: from eggs.gnu.org ([2001:4830:134:3::10]:40651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqe8-0002np-H6
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqe6-0003do-QF
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:00 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:38246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqe6-0003db-II
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:58 -0400
Received: by mail-pg0-x243.google.com with SMTP id c9-v6so8135601pgf.5
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:14 -1000
Message-Id: <20180610030220.3777-43-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 042/108] linux-user: Split out fstatfs,
 fstatfs64, statfs, statfs64
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
 linux-user/syscall.c | 193 ++++++++++++++++++++++++++++---------------
 1 file changed, 125 insertions(+), 68 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index df8422cd3a..86583988c4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7207,6 +7207,61 @@ static inline abi_long host_to_target_stat64(void *cpu_env,
     return 0;
 }
 
+static abi_long host_to_target_statfs(abi_ulong target_addr,
+                                      struct statfs *stfs)
+{
+    struct target_statfs *target_stfs;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_stfs, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(stfs->f_type, &target_stfs->f_type);
+    __put_user(stfs->f_bsize, &target_stfs->f_bsize);
+    __put_user(stfs->f_blocks, &target_stfs->f_blocks);
+    __put_user(stfs->f_bfree, &target_stfs->f_bfree);
+    __put_user(stfs->f_bavail, &target_stfs->f_bavail);
+    __put_user(stfs->f_files, &target_stfs->f_files);
+    __put_user(stfs->f_ffree, &target_stfs->f_ffree);
+    __put_user(stfs->f_fsid.__val[0], &target_stfs->f_fsid.val[0]);
+    __put_user(stfs->f_fsid.__val[1], &target_stfs->f_fsid.val[1]);
+    __put_user(stfs->f_namelen, &target_stfs->f_namelen);
+    __put_user(stfs->f_frsize, &target_stfs->f_frsize);
+#ifdef _STATFS_F_FLAGS
+    __put_user(stfs->f_flags, &target_stfs->f_flags);
+#else
+    __put_user(0, &target_stfs->f_flags);
+#endif
+    memset(target_stfs->f_spare, 0, sizeof(target_stfs->f_spare));
+    unlock_user_struct(target_stfs, target_addr, 1);
+    return 0;
+}
+
+#ifdef TARGET_NR_statfs64
+static abi_long host_to_target_statfs64(abi_ulong target_addr,
+                                        struct statfs *stfs)
+{
+    struct target_statfs64 *target_stfs;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_stfs, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(stfs->f_type, &target_stfs->f_type);
+    __put_user(stfs->f_bsize, &target_stfs->f_bsize);
+    __put_user(stfs->f_blocks, &target_stfs->f_blocks);
+    __put_user(stfs->f_bfree, &target_stfs->f_bfree);
+    __put_user(stfs->f_bavail, &target_stfs->f_bavail);
+    __put_user(stfs->f_files, &target_stfs->f_files);
+    __put_user(stfs->f_ffree, &target_stfs->f_ffree);
+    __put_user(stfs->f_fsid.__val[0], &target_stfs->f_fsid.val[0]);
+    __put_user(stfs->f_fsid.__val[1], &target_stfs->f_fsid.val[1]);
+    __put_user(stfs->f_namelen, &target_stfs->f_namelen);
+    __put_user(stfs->f_frsize, &target_stfs->f_frsize);
+    memset(target_stfs->f_spare, 0, sizeof(target_stfs->f_spare));
+    unlock_user_struct(target_stfs, target_addr, 1);
+    return 0;
+}
+#endif
+
 /* ??? Using host futex calls even when target atomic operations
    are not really atomic probably breaks things.  However implementing
    futexes locally would make futexes shared between multiple processes
@@ -8111,6 +8166,32 @@ IMPL(fork)
 }
 #endif
 
+IMPL(fstatfs)
+{
+    struct statfs stfs;
+    abi_long ret;
+
+    ret = get_errno(fstatfs(arg1, &stfs));
+    if (!is_error(ret) && host_to_target_statfs(arg2, &stfs)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
+#ifdef TARGET_NR_fstatfs64
+IMPL(fstatfs64)
+{
+    struct statfs stfs;
+    abi_long ret;
+
+    ret = get_errno(fstatfs(arg1, &stfs));
+    if (!is_error(ret) && host_to_target_statfs64(arg3, &stfs)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
+
 IMPL(ftruncate)
 {
     return get_errno(ftruncate(arg1, arg2));
@@ -9485,6 +9566,42 @@ IMPL(ssetmask)
 }
 #endif
 
+IMPL(statfs)
+{
+    char *p = lock_user_string(arg1);
+    struct statfs stfs;
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(statfs(path(p), &stfs));
+    unlock_user(p, arg1, 0);
+    if (!is_error(ret) && host_to_target_statfs(arg2, &stfs)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
+#ifdef TARGET_NR_statfs64
+IMPL(statfs64)
+{
+    char *p = lock_user_string(arg1);
+    struct statfs stfs;
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(statfs(path(p), &stfs));
+    unlock_user(p, arg1, 0);
+    if (!is_error(ret) && host_to_target_statfs64(arg3, &stfs)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_stime
 IMPL(stime)
 {
@@ -9778,7 +9895,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     CPUState *cpu __attribute__((unused)) = ENV_GET_CPU(cpu_env);
     abi_long ret;
     struct stat st;
-    struct statfs stfs;
     void *p;
 
     switch(num) {
@@ -9800,73 +9916,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
         return ret;
     case TARGET_NR_setpriority:
         return get_errno(setpriority(arg1, arg2, arg3));
-    case TARGET_NR_statfs:
-        if (!(p = lock_user_string(arg1))) {
-            return -TARGET_EFAULT;
-        }
-        ret = get_errno(statfs(path(p), &stfs));
-        unlock_user(p, arg1, 0);
-    convert_statfs:
-        if (!is_error(ret)) {
-            struct target_statfs *target_stfs;
-
-            if (!lock_user_struct(VERIFY_WRITE, target_stfs, arg2, 0))
-                return -TARGET_EFAULT;
-            __put_user(stfs.f_type, &target_stfs->f_type);
-            __put_user(stfs.f_bsize, &target_stfs->f_bsize);
-            __put_user(stfs.f_blocks, &target_stfs->f_blocks);
-            __put_user(stfs.f_bfree, &target_stfs->f_bfree);
-            __put_user(stfs.f_bavail, &target_stfs->f_bavail);
-            __put_user(stfs.f_files, &target_stfs->f_files);
-            __put_user(stfs.f_ffree, &target_stfs->f_ffree);
-            __put_user(stfs.f_fsid.__val[0], &target_stfs->f_fsid.val[0]);
-            __put_user(stfs.f_fsid.__val[1], &target_stfs->f_fsid.val[1]);
-            __put_user(stfs.f_namelen, &target_stfs->f_namelen);
-            __put_user(stfs.f_frsize, &target_stfs->f_frsize);
-#ifdef _STATFS_F_FLAGS
-            __put_user(stfs.f_flags, &target_stfs->f_flags);
-#else
-            __put_user(0, &target_stfs->f_flags);
-#endif
-            memset(target_stfs->f_spare, 0, sizeof(target_stfs->f_spare));
-            unlock_user_struct(target_stfs, arg2, 1);
-        }
-        return ret;
-    case TARGET_NR_fstatfs:
-        ret = get_errno(fstatfs(arg1, &stfs));
-        goto convert_statfs;
-#ifdef TARGET_NR_statfs64
-    case TARGET_NR_statfs64:
-        if (!(p = lock_user_string(arg1))) {
-            return -TARGET_EFAULT;
-        }
-        ret = get_errno(statfs(path(p), &stfs));
-        unlock_user(p, arg1, 0);
-    convert_statfs64:
-        if (!is_error(ret)) {
-            struct target_statfs64 *target_stfs;
-
-            if (!lock_user_struct(VERIFY_WRITE, target_stfs, arg3, 0))
-                return -TARGET_EFAULT;
-            __put_user(stfs.f_type, &target_stfs->f_type);
-            __put_user(stfs.f_bsize, &target_stfs->f_bsize);
-            __put_user(stfs.f_blocks, &target_stfs->f_blocks);
-            __put_user(stfs.f_bfree, &target_stfs->f_bfree);
-            __put_user(stfs.f_bavail, &target_stfs->f_bavail);
-            __put_user(stfs.f_files, &target_stfs->f_files);
-            __put_user(stfs.f_ffree, &target_stfs->f_ffree);
-            __put_user(stfs.f_fsid.__val[0], &target_stfs->f_fsid.val[0]);
-            __put_user(stfs.f_fsid.__val[1], &target_stfs->f_fsid.val[1]);
-            __put_user(stfs.f_namelen, &target_stfs->f_namelen);
-            __put_user(stfs.f_frsize, &target_stfs->f_frsize);
-            memset(target_stfs->f_spare, 0, sizeof(target_stfs->f_spare));
-            unlock_user_struct(target_stfs, arg3, 1);
-        }
-        return ret;
-    case TARGET_NR_fstatfs64:
-        ret = get_errno(fstatfs(arg1, &stfs));
-        goto convert_statfs64;
-#endif
 #ifdef TARGET_NR_socketcall
     case TARGET_NR_socketcall:
         return do_socketcall(arg1, arg2);
@@ -12744,6 +12793,10 @@ static impl_fn *syscall_table(unsigned num)
 #endif
 #ifdef TARGET_NR_fork
         SYSCALL(fork);
+#endif
+        SYSCALL(fstatfs);
+#ifdef TARGET_NR_fstatfs64
+        SYSCALL(fstatfs64);
 #endif
         SYSCALL(ftruncate);
 #ifdef TARGET_NR_futimesat
@@ -12874,6 +12927,10 @@ static impl_fn *syscall_table(unsigned num)
 #endif
 #ifdef TARGET_NR_ssetmask
         SYSCALL(ssetmask);
+#endif
+        SYSCALL(statfs);
+#ifdef TARGET_NR_statfs64
+        SYSCALL(statfs64);
 #endif
 #ifdef TARGET_NR_stime
         SYSCALL(stime);
-- 
2.17.1
