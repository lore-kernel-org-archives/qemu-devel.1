Received: from eggs.gnu.org ([2001:4830:134:3::10]:40186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqd4-0001oB-LL
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqd3-0003EO-Ey
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:02:54 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:34313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqd3-0003E8-90
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:02:53 -0400
Received: by mail-pg0-x22c.google.com with SMTP id q4-v6so7074086pgr.1
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:02:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:00:44 -1000
Message-Id: <20180610030220.3777-13-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 012/108] linux-user: Split out open, openat
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
 linux-user/syscall.c | 58 +++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index aa6c4e1577..a4d0f2720f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8116,6 +8116,40 @@ IMPL(exit)
     g_assert_not_reached();
 }
 
+#ifdef TARGET_NR_open
+IMPL(open)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(do_openat(cpu_env, AT_FDCWD, p,
+                              target_to_host_bitmask(arg2, fcntl_flags_tbl),
+                              arg3));
+    unlock_user(p, arg1, 0);
+    fd_trans_unregister(ret);
+    return ret;
+}
+#endif
+
+IMPL(openat)
+{
+    char *p = lock_user_string(arg2);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(do_openat(cpu_env, arg1, p,
+                              target_to_host_bitmask(arg3, fcntl_flags_tbl),
+                              arg4));
+    unlock_user(p, arg2, 0);
+    fd_trans_unregister(ret);
+    return ret;
+}
+
 IMPL(read)
 {
     abi_long ret;
@@ -8177,26 +8211,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_open
-    case TARGET_NR_open:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(do_openat(cpu_env, AT_FDCWD, p,
-                                  target_to_host_bitmask(arg2, fcntl_flags_tbl),
-                                  arg3));
-        fd_trans_unregister(ret);
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-    case TARGET_NR_openat:
-        if (!(p = lock_user_string(arg2)))
-            return -TARGET_EFAULT;
-        ret = get_errno(do_openat(cpu_env, arg1, p,
-                                  target_to_host_bitmask(arg3, fcntl_flags_tbl),
-                                  arg4));
-        fd_trans_unregister(ret);
-        unlock_user(p, arg2, 0);
-        return ret;
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     case TARGET_NR_name_to_handle_at:
         ret = do_name_to_handle_at(arg1, arg2, arg3, arg4, arg5);
@@ -12477,6 +12491,10 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(close);
         SYSCALL(execve);
         SYSCALL(exit);
+#ifdef TARGET_NR_open
+        SYSCALL(open);
+#endif
+        SYSCALL(openat);
         SYSCALL(read);
         SYSCALL(write);
     }
-- 
2.17.1
