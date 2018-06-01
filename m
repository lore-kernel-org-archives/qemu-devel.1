Received: from eggs.gnu.org ([2001:4830:134:3::10]:57503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWs-0005a5-Mt
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWo-0000U0-Vz
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:18 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWo-0000TL-PE
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:14 -0400
Received: by mail-pg0-x242.google.com with SMTP id 15-v6so10552596pge.2
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:31 -0700
Message-Id: <20180601073050.8054-15-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 14/33] linux-user: Split out open_to_handle_at
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

At the same time, merge do_open_to_handle_at into the new function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 84 ++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 4afc22c20c..48bb1c0231 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7369,39 +7369,6 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
         return -TARGET_ENOSYS;
     }
 }
-#if defined(TARGET_NR_open_by_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
-static abi_long do_open_by_handle_at(abi_long mount_fd, abi_long handle,
-                                     abi_long flags)
-{
-    struct file_handle *target_fh;
-    struct file_handle *fh;
-    unsigned int size, total_size;
-    abi_long ret;
-
-    if (get_user_s32(size, handle)) {
-        return -TARGET_EFAULT;
-    }
-
-    total_size = sizeof(struct file_handle) + size;
-    target_fh = lock_user(VERIFY_READ, handle, total_size, 1);
-    if (!target_fh) {
-        return -TARGET_EFAULT;
-    }
-
-    fh = g_memdup(target_fh, total_size);
-    fh->handle_bytes = size;
-    fh->handle_type = tswap32(target_fh->handle_type);
-
-    ret = get_errno(open_by_handle_at(mount_fd, fh,
-                    target_to_host_bitmask(flags, fcntl_flags_tbl)));
-
-    g_free(fh);
-
-    unlock_user(target_fh, handle, total_size);
-
-    return ret;
-}
-#endif
 
 #if defined(TARGET_NR_signalfd) || defined(TARGET_NR_signalfd4)
 
@@ -8187,6 +8154,45 @@ IMPL(openat)
     return ret;
 }
 
+#if defined(TARGET_NR_open_by_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
+IMPL(open_by_handle_at)
+{
+    abi_long mount_fd = arg1;
+    abi_long handle = arg2;
+    abi_long flags = arg3;
+    struct file_handle *target_fh;
+    struct file_handle *fh;
+    unsigned int size, total_size;
+    abi_long ret;
+
+    if (is_hostfd(mount_fd)) {
+        return -TARGET_EBADF;
+    }
+    if (get_user_s32(size, handle)) {
+        return -TARGET_EFAULT;
+    }
+
+    total_size = sizeof(struct file_handle) + size;
+    target_fh = lock_user(VERIFY_READ, handle, total_size, 1);
+    if (!target_fh) {
+        return -TARGET_EFAULT;
+    }
+
+    fh = g_memdup(target_fh, total_size);
+    fh->handle_bytes = size;
+    fh->handle_type = tswap32(target_fh->handle_type);
+
+    ret = get_errno(open_by_handle_at(mount_fd, fh,
+                    target_to_host_bitmask(flags, fcntl_flags_tbl)));
+
+    g_free(fh);
+    unlock_user(target_fh, handle, total_size);
+
+    fd_trans_unregister(ret);
+    return ret;
+}
+#endif
+
 IMPL(read)
 {
     abi_long ret;
@@ -8252,15 +8258,6 @@ IMPL(everything_else)
     char *fn;
 
     switch(num) {
-#if defined(TARGET_NR_open_by_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
-    case TARGET_NR_open_by_handle_at:
-        if (is_hostfd(arg1)) {
-            return -TARGET_EBADF;
-        }
-        ret = do_open_by_handle_at(arg1, arg2, arg3);
-        fd_trans_unregister(ret);
-        return ret;
-#endif
 #ifdef TARGET_NR_fork
     case TARGET_NR_fork:
         return get_errno(do_fork(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0));
@@ -12944,6 +12941,9 @@ static impl_fn * const syscall_table[] = {
     [TARGET_NR_open] = impl_open,
 #endif
     [TARGET_NR_openat] = impl_openat,
+#if defined(TARGET_NR_open_by_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
+    [TARGET_NR_open_by_handle_at] = impl_open_by_handle_at,
+#endif
     [TARGET_NR_read] = impl_read,
     [TARGET_NR_write] = impl_write,
 };
-- 
2.17.0
