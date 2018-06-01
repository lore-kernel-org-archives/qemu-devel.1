Received: from eggs.gnu.org ([2001:4830:134:3::10]:57459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWn-0005WM-0n
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWm-0000RT-2w
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:13 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:45842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWl-0000Qs-Te
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:12 -0400
Received: by mail-pg0-x22b.google.com with SMTP id z1-v6so3946144pgv.12
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:29 -0700
Message-Id: <20180601073050.8054-13-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 12/33] linux-user: Split out open, openat
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
 linux-user/syscall.c | 65 ++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a9b59a8658..fb1a8a4e7e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8145,6 +8145,44 @@ IMPL(exit)
     g_assert_not_reached();
 }
 
+#ifdef TARGET_NR_open
+IMPL(open)
+{
+    char *fn = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!fn) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(do_openat(cpu_env, AT_FDCWD, fn,
+                              target_to_host_bitmask(arg2, fcntl_flags_tbl),
+                              arg3));
+    fd_trans_unregister(ret);
+    unlock_user(fn, arg1, 0);
+    return ret;
+}
+#endif
+
+IMPL(openat)
+{
+    char *fn;
+    abi_long ret;
+
+    if (is_hostfd(arg1)) {
+        return -TARGET_EBADF;
+    }
+    fn = lock_user_string(arg2);
+    if (!fn) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(do_openat(cpu_env, arg1, fn,
+                              target_to_host_bitmask(arg3, fcntl_flags_tbl),
+                              arg4));
+    fd_trans_unregister(ret);
+    unlock_user(fn, arg2, 0);
+    return ret;
+}
+
 IMPL(read)
 {
     abi_long ret;
@@ -8210,29 +8248,6 @@ IMPL(everything_else)
     char *fn;
 
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
-        if (is_hostfd(arg1)) {
-            return -TARGET_EBADF;
-        }
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
         if (is_hostfd(arg1)) {
@@ -12926,6 +12941,10 @@ static impl_fn * const syscall_table[] = {
     [TARGET_NR_close] = impl_close,
     [TARGET_NR_execve] = impl_execve,
     [TARGET_NR_exit] = impl_exit,
+#ifdef TARGET_NR_open
+    [TARGET_NR_open] = impl_open,
+#endif
+    [TARGET_NR_openat] = impl_openat,
     [TARGET_NR_read] = impl_read,
     [TARGET_NR_write] = impl_write,
 };
-- 
2.17.0
