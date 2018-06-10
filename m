Received: from eggs.gnu.org ([2001:4830:134:3::10]:40223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqd9-0001tT-S1
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqd8-0003Gj-Fq
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:02:59 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:39499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqd8-0003GS-AM
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:02:58 -0400
Received: by mail-pg0-x22c.google.com with SMTP id w12-v6so8138454pgc.6
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:02:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:00:47 -1000
Message-Id: <20180610030220.3777-16-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 015/108] linux-user: Split out creat, fork,
 waitid, waitpid
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

All targets define waitid; remove the ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 104 +++++++++++++++++++++++++++----------------
 1 file changed, 65 insertions(+), 39 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f51cc7e937..a146b696fd 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7882,6 +7882,22 @@ IMPL(close)
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
@@ -8029,6 +8045,13 @@ IMPL(exit)
     g_assert_not_reached();
 }
 
+#ifdef TARGET_NR_fork
+IMPL(fork)
+{
+    return get_errno(do_fork(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0));
+}
+#endif
+
 #ifdef CONFIG_OPEN_BY_HANDLE
 IMPL(name_to_handle_at)
 {
@@ -8174,6 +8197,38 @@ IMPL(read)
     return ret;
 }
 
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
@@ -8215,45 +8270,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
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
@@ -12482,8 +12498,14 @@ static impl_fn *syscall_table(unsigned num)
          */
         SYSCALL(brk);
         SYSCALL(close);
+#ifdef TARGET_NR_creat
+        SYSCALL(creat);
+#endif
         SYSCALL(execve);
         SYSCALL(exit);
+#ifdef TARGET_NR_fork
+        SYSCALL(fork);
+#endif
 #ifdef CONFIG_OPEN_BY_HANDLE
         SYSCALL(name_to_handle_at);
 #endif
@@ -12495,6 +12517,10 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(open_by_handle_at);
 #endif
         SYSCALL(read);
+        SYSCALL(waitid);
+#ifdef TARGET_NR_waitpid
+        SYSCALL(waitpid);
+#endif
         SYSCALL(write);
     }
 
-- 
2.17.1
