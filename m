Received: from eggs.gnu.org ([2001:4830:134:3::10]:41115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqf5-0003ic-84
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqf3-0004Bp-S8
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:59 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:38122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqf3-0004As-Kc
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:57 -0400
Received: by mail-pf0-x243.google.com with SMTP id b74-v6so8494347pfl.5
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:43 -1000
Message-Id: <20180610030220.3777-72-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 071/108] linux-user: Split out fstat64,
 fstatat64, newfstatat, lstat64, stat64
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

Comment on the odd overlap of fstatat64 and newfstatat,
especially with respect to nios2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 135 ++++++++++++++++++++++++++++---------------
 1 file changed, 89 insertions(+), 46 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c2dc7131bb..8d6b949b8a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8140,6 +8140,42 @@ IMPL(fstat)
     return ret;
 }
 
+#ifdef TARGET_NR_fstat64
+IMPL(fstat64)
+{
+    struct stat st;
+    abi_long ret;
+
+    ret = get_errno(fstat(arg1, &st));
+    if (!is_error(ret) && host_to_target_stat64(cpu_env, arg2, &st)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
+
+/* Some targets name this syscall newfstatat, with the same arguments.  */
+/* ??? Our nios2/syscall_nr.h defines both names; the kernel does not.
+ * Preserve previous behavior and map both syscalls to this function.
+ */
+IMPL(fstatat64)
+{
+    char *p;
+    abi_long ret;
+    struct stat st;
+
+    p = lock_user_string(arg2);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(fstatat(arg1, path(p), &st, arg4));
+    unlock_user(p, arg2, 0);
+    if (!is_error(ret) && host_to_target_stat64(cpu_env, arg3, &st)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
 IMPL(fstatfs)
 {
     struct statfs stfs;
@@ -8815,6 +8851,25 @@ IMPL(lstat)
 }
 #endif
 
+#ifdef TARGET_NR_lstat64
+IMPL(lstat64)
+{
+    char *p = lock_user_string(arg1);
+    struct stat st;
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(lstat(path(p), &st));
+    unlock_user(p, arg1, 0);
+    if (!is_error(ret) && host_to_target_stat64(cpu_env, arg2, &st)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_mkdir
 IMPL(mkdir)
 {
@@ -10790,6 +10845,25 @@ IMPL(stat)
 }
 #endif
 
+#ifdef TARGET_NR_stat64
+IMPL(stat64)
+{
+    char *p = lock_user_string(arg1);
+    struct stat st;
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(stat(path(p), &st));
+    unlock_user(p, arg1, 0);
+    if (!is_error(ret) && host_to_target_stat64(cpu_env, arg2, &st)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
+
 IMPL(statfs)
 {
     char *p = lock_user_string(arg1);
@@ -11333,55 +11407,9 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
 {
     CPUState *cpu __attribute__((unused)) = ENV_GET_CPU(cpu_env);
     abi_long ret;
-    struct stat st;
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_stat64
-    case TARGET_NR_stat64:
-        if (!(p = lock_user_string(arg1))) {
-            return -TARGET_EFAULT;
-        }
-        ret = get_errno(stat(path(p), &st));
-        unlock_user(p, arg1, 0);
-        if (!is_error(ret))
-            ret = host_to_target_stat64(cpu_env, arg2, &st);
-        return ret;
-#endif
-#ifdef TARGET_NR_lstat64
-    case TARGET_NR_lstat64:
-        if (!(p = lock_user_string(arg1))) {
-            return -TARGET_EFAULT;
-        }
-        ret = get_errno(lstat(path(p), &st));
-        unlock_user(p, arg1, 0);
-        if (!is_error(ret))
-            ret = host_to_target_stat64(cpu_env, arg2, &st);
-        return ret;
-#endif
-#ifdef TARGET_NR_fstat64
-    case TARGET_NR_fstat64:
-        ret = get_errno(fstat(arg1, &st));
-        if (!is_error(ret))
-            ret = host_to_target_stat64(cpu_env, arg2, &st);
-        return ret;
-#endif
-#if (defined(TARGET_NR_fstatat64) || defined(TARGET_NR_newfstatat))
-#ifdef TARGET_NR_fstatat64
-    case TARGET_NR_fstatat64:
-#endif
-#ifdef TARGET_NR_newfstatat
-    case TARGET_NR_newfstatat:
-#endif
-        if (!(p = lock_user_string(arg2))) {
-            return -TARGET_EFAULT;
-        }
-        ret = get_errno(fstatat(arg1, path(p), &st, arg4));
-        unlock_user(p, arg2, 0);
-        if (!is_error(ret))
-            ret = host_to_target_stat64(cpu_env, arg3, &st);
-        return ret;
-#endif
 #ifdef TARGET_NR_lchown
     case TARGET_NR_lchown:
         if (!(p = lock_user_string(arg1)))
@@ -13041,6 +13069,12 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(fork);
 #endif
         SYSCALL(fstat);
+#ifdef TARGET_NR_fstat64
+        SYSCALL(fstat64);
+#endif
+#ifdef TARGET_NR_fstatat64
+        SYSCALL(fstatat64);
+#endif
         SYSCALL(fstatfs);
 #ifdef TARGET_NR_fstatfs64
         SYSCALL(fstatfs64);
@@ -13109,6 +13143,9 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_lstat
         SYSCALL(lstat);
 #endif
+#ifdef TARGET_NR_lstat64
+        SYSCALL(lstat64);
+#endif
 #ifdef TARGET_NR_mkdir
         SYSCALL(mkdir);
 #endif
@@ -13151,6 +13188,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(name_to_handle_at);
 #endif
         SYSCALL(nanosleep);
+#ifdef TARGET_NR_newfstatat
+        SYSCALL_WITH(newfstatat, fstatat64);
+#endif
 #ifdef TARGET_NR__newselect
         SYSCALL(_newselect);
 #endif
@@ -13322,6 +13362,9 @@ static impl_fn *syscall_table(unsigned num)
 #endif
 #ifdef TARGET_NR_stat
         SYSCALL(stat);
+#endif
+#ifdef TARGET_NR_stat64
+        SYSCALL(stat64);
 #endif
         SYSCALL(statfs);
 #ifdef TARGET_NR_statfs64
-- 
2.17.1
