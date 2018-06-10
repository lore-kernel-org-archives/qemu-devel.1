Received: from eggs.gnu.org ([2001:4830:134:3::10]:40266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdI-000228-7y
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdF-0003J1-4d
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:08 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:40842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqdE-0003Il-Uj
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:05 -0400
Received: by mail-pg0-x244.google.com with SMTP id l2-v6so8127232pgc.7
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:00:50 -1000
Message-Id: <20180610030220.3777-19-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 018/108] linux-user: Split out chdir, mknod,
 mknodat, time, chmod
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

All targets define mknodat; remove the ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 121 ++++++++++++++++++++++++++++---------------
 1 file changed, 79 insertions(+), 42 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e1b3c7e827..d32034ce38 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7876,6 +7876,34 @@ IMPL(brk)
     return do_brk(arg1);
 }
 
+IMPL(chdir)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(chdir(p));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_chmod
+IMPL(chmod)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(chmod(p, arg2));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
 IMPL(close)
 {
     fd_trans_unregister(arg1);
@@ -8082,6 +8110,34 @@ IMPL(linkat)
     return ret;
 }
 
+#ifdef TARGET_NR_mknod
+IMPL(mknod)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(mknod(p, arg2, arg3));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
+IMPL(mknodat)
+{
+    char *p = lock_user_string(arg2);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(mknodat(arg1, p, arg3, arg4));
+    unlock_user(p, arg2, 0);
+    return ret;
+}
+
 #ifdef CONFIG_OPEN_BY_HANDLE
 IMPL(name_to_handle_at)
 {
@@ -8227,6 +8283,18 @@ IMPL(read)
     return ret;
 }
 
+#ifdef TARGET_NR_time
+IMPL(time)
+{
+    time_t host_time;
+    abi_long ret = get_errno(time(&host_time));
+    if (!is_error(ret) && arg1 && put_user_sal(host_time, arg1)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_unlink
 IMPL(unlink)
 {
@@ -8328,48 +8396,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_chdir:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(chdir(p));
-        unlock_user(p, arg1, 0);
-        return ret;
-#ifdef TARGET_NR_time
-    case TARGET_NR_time:
-        {
-            time_t host_time;
-            ret = get_errno(time(&host_time));
-            if (!is_error(ret)
-                && arg1
-                && put_user_sal(host_time, arg1))
-                return -TARGET_EFAULT;
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_mknod
-    case TARGET_NR_mknod:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(mknod(p, arg2, arg3));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-#if defined(TARGET_NR_mknodat)
-    case TARGET_NR_mknodat:
-        if (!(p = lock_user_string(arg2)))
-            return -TARGET_EFAULT;
-        ret = get_errno(mknodat(arg1, p, arg3, arg4));
-        unlock_user(p, arg2, 0);
-        return ret;
-#endif
-#ifdef TARGET_NR_chmod
-    case TARGET_NR_chmod:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(chmod(p, arg2));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
     case TARGET_NR_lseek:
         return get_errno(lseek(arg1, arg2, arg3));
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
@@ -12508,6 +12534,10 @@ static impl_fn *syscall_table(unsigned num)
          */
         SYSCALL(brk);
         SYSCALL(close);
+        SYSCALL(chdir);
+#ifdef TARGET_NR_chmod
+        SYSCALL(chmod);
+#endif
 #ifdef TARGET_NR_creat
         SYSCALL(creat);
 #endif
@@ -12520,6 +12550,10 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(link);
 #endif
         SYSCALL(linkat);
+#ifdef TARGET_NR_mknod
+        SYSCALL(mknod);
+#endif
+        SYSCALL(mknodat);
 #ifdef CONFIG_OPEN_BY_HANDLE
         SYSCALL(name_to_handle_at);
 #endif
@@ -12531,6 +12565,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(open_by_handle_at);
 #endif
         SYSCALL(read);
+#ifdef TARGET_NR_time
+        SYSCALL(time);
+#endif
 #ifdef TARGET_NR_unlink
         SYSCALL(unlink);
 #endif
-- 
2.17.1
