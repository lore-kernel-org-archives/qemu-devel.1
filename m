Received: from eggs.gnu.org ([2001:4830:134:3::10]:57504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWs-0005a6-N0
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWq-0000VF-CA
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:18 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:44909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWq-0000Um-6D
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:16 -0400
Received: by mail-pg0-x241.google.com with SMTP id p21-v6so10876647pgd.11
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:32 -0700
Message-Id: <20180601073050.8054-16-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 15/33] linux-user: Split out creat, fork, waitid,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 108 +++++++++++++++++++++++++++----------------
 1 file changed, 69 insertions(+), 39 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 48bb1c0231..e208f8647a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7908,6 +7908,22 @@ IMPL(close)
     return get_errno(close(arg1));
 }
 
+#ifdef TARGET_NR_creat
+IMPL(creat)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(creat(p, arg2));
+    fd_trans_unregister(ret);
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
 IMPL(execve)
 {
     abi_ulong *guest_ptrs;
@@ -8055,6 +8071,13 @@ IMPL(exit)
     g_assert_not_reached();
 }
 
+#ifdef TARGET_NR_fork
+IMPL(fork)
+{
+    return get_errno(do_fork(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0));
+}
+#endif
+
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
 IMPL(name_to_handle_at)
 {
@@ -8216,6 +8239,40 @@ IMPL(read)
     return ret;
 }
 
+#ifdef TARGET_NR_waitid
+IMPL(waitid)
+{
+    siginfo_t info;
+    abi_long ret;
+
+    info.si_pid = 0;
+    ret = get_errno(safe_waitid(arg1, arg2, &info, arg4, NULL));
+    if (!is_error(ret) && arg3 && info.si_pid != 0) {
+        target_siginfo_t *p
+            = lock_user(VERIFY_WRITE, arg3, sizeof(target_siginfo_t), 0);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        host_to_target_siginfo(p, &info);
+        unlock_user(p, arg3, sizeof(target_siginfo_t));
+    }
+    return ret;
+}
+#endif
+
+#ifdef TARGET_NR_waitpid
+IMPL(waitpid)
+{
+    int status;
+    abi_long ret = get_errno(safe_wait4(arg1, &status, arg3, 0));
+    if (!is_error(ret) && arg2 && ret &&
+        put_user_s32(host_to_target_waitstatus(status), arg2)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
+
 IMPL(write)
 {
     abi_long ret;
@@ -8258,45 +8315,6 @@ IMPL(everything_else)
     char *fn;
 
     switch(num) {
-#ifdef TARGET_NR_fork
-    case TARGET_NR_fork:
-        return get_errno(do_fork(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0));
-#endif
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
-#ifdef TARGET_NR_creat /* not on alpha */
-    case TARGET_NR_creat:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(creat(p, arg2));
-        fd_trans_unregister(ret);
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
 #ifdef TARGET_NR_link
     case TARGET_NR_link:
         {
@@ -12932,8 +12950,14 @@ IMPL(everything_else)
 static impl_fn * const syscall_table[] = {
     [TARGET_NR_brk] = impl_brk,
     [TARGET_NR_close] = impl_close,
+#ifdef TARGET_NR_creat
+    [TARGET_NR_creat] = impl_creat,
+#endif
     [TARGET_NR_execve] = impl_execve,
     [TARGET_NR_exit] = impl_exit,
+#ifdef TARGET_NR_fork
+    [TARGET_NR_fork] = impl_fork,
+#endif
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     [TARGET_NR_name_to_handle_at] = impl_name_to_handle_at,
 #endif
@@ -12945,6 +12969,12 @@ static impl_fn * const syscall_table[] = {
     [TARGET_NR_open_by_handle_at] = impl_open_by_handle_at,
 #endif
     [TARGET_NR_read] = impl_read,
+#ifdef TARGET_NR_waitid
+    [TARGET_NR_waitid] = impl_waitid,
+#endif
+#ifdef TARGET_NR_waitpid
+    [TARGET_NR_waitpid] = impl_waitpid,
+#endif
     [TARGET_NR_write] = impl_write,
 };
 
-- 
2.17.0
