Received: from eggs.gnu.org ([2001:4830:134:3::10]:57471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWo-0005XT-LM
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWn-0000Sw-IK
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:14 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWn-0000S5-AJ
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:13 -0400
Received: by mail-pg0-x243.google.com with SMTP id 15-v6so10552560pge.2
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:30 -0700
Message-Id: <20180601073050.8054-14-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 13/33] linux-user: Split out name_to_handle_at
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

At the same time, merge do_name_to_handle_at into the new function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 129 +++++++++++++++++++++----------------------
 1 file changed, 64 insertions(+), 65 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fb1a8a4e7e..4afc22c20c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7369,63 +7369,6 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
         return -TARGET_ENOSYS;
     }
 }
-#if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
-static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
-                                     abi_long handle, abi_long mount_id,
-                                     abi_long flags)
-{
-    struct file_handle *target_fh;
-    struct file_handle *fh;
-    int mid = 0;
-    abi_long ret;
-    char *name;
-    unsigned int size, total_size;
-
-    if (get_user_s32(size, handle)) {
-        return -TARGET_EFAULT;
-    }
-
-    name = lock_user_string(pathname);
-    if (!name) {
-        return -TARGET_EFAULT;
-    }
-
-    total_size = sizeof(struct file_handle) + size;
-    target_fh = lock_user(VERIFY_WRITE, handle, total_size, 0);
-    if (!target_fh) {
-        unlock_user(name, pathname, 0);
-        return -TARGET_EFAULT;
-    }
-
-    fh = g_malloc0(total_size);
-    fh->handle_bytes = size;
-
-    TRY_INTERP_FD(ret, name,
-                  name_to_handle_at(interp_dirfd, name + 1, fh, &mid, flags),
-                  name_to_handle_at(dirfd, name, fh, &mid, flags));
-    ret = get_errno(ret);
-    unlock_user(name, pathname, 0);
-
-    /* man name_to_handle_at(2):
-     * Other than the use of the handle_bytes field, the caller should treat
-     * the file_handle structure as an opaque data type
-     */
-
-    memcpy(target_fh, fh, total_size);
-    target_fh->handle_bytes = tswap32(fh->handle_bytes);
-    target_fh->handle_type = tswap32(fh->handle_type);
-    g_free(fh);
-    unlock_user(target_fh, handle, total_size);
-
-    if (put_user_s32(mid, mount_id)) {
-        return -TARGET_EFAULT;
-    }
-
-    return ret;
-
-}
-#endif
-
 #if defined(TARGET_NR_open_by_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
 static abi_long do_open_by_handle_at(abi_long mount_fd, abi_long handle,
                                      abi_long flags)
@@ -8145,6 +8088,67 @@ IMPL(exit)
     g_assert_not_reached();
 }
 
+#if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
+IMPL(name_to_handle_at)
+{
+    abi_long dirfd = arg1;
+    abi_long pathname = arg2;
+    abi_long handle = arg3;
+    abi_long mount_id = arg4;
+    abi_long flags = arg5;
+    struct file_handle *target_fh;
+    struct file_handle *fh;
+    int mid = 0;
+    abi_long ret;
+    char *name;
+    unsigned int size, total_size;
+
+    if (is_hostfd(dirfd)) {
+        return -TARGET_EBADF;
+    }
+    if (get_user_s32(size, handle)) {
+        return -TARGET_EFAULT;
+    }
+
+    name = lock_user_string(pathname);
+    if (!name) {
+        return -TARGET_EFAULT;
+    }
+
+    total_size = sizeof(struct file_handle) + size;
+    target_fh = lock_user(VERIFY_WRITE, handle, total_size, 0);
+    if (!target_fh) {
+        unlock_user(name, pathname, 0);
+        return -TARGET_EFAULT;
+    }
+
+    fh = g_malloc0(total_size);
+    fh->handle_bytes = size;
+
+    TRY_INTERP_FD(ret, name,
+                  name_to_handle_at(interp_dirfd, name + 1, fh, &mid, flags),
+                  name_to_handle_at(dirfd, name, fh, &mid, flags));
+    ret = get_errno(ret);
+    unlock_user(name, pathname, 0);
+
+    /* man name_to_handle_at(2):
+     * Other than the use of the handle_bytes field, the caller should treat
+     * the file_handle structure as an opaque data type
+     */
+
+    memcpy(target_fh, fh, total_size);
+    target_fh->handle_bytes = tswap32(fh->handle_bytes);
+    target_fh->handle_type = tswap32(fh->handle_type);
+    g_free(fh);
+    unlock_user(target_fh, handle, total_size);
+
+    if (put_user_s32(mid, mount_id)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_open
 IMPL(open)
 {
@@ -8248,14 +8252,6 @@ IMPL(everything_else)
     char *fn;
 
     switch(num) {
-#if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
-    case TARGET_NR_name_to_handle_at:
-        if (is_hostfd(arg1)) {
-            return -TARGET_EBADF;
-        }
-        ret = do_name_to_handle_at(arg1, arg2, arg3, arg4, arg5);
-        return ret;
-#endif
 #if defined(TARGET_NR_open_by_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     case TARGET_NR_open_by_handle_at:
         if (is_hostfd(arg1)) {
@@ -12941,6 +12937,9 @@ static impl_fn * const syscall_table[] = {
     [TARGET_NR_close] = impl_close,
     [TARGET_NR_execve] = impl_execve,
     [TARGET_NR_exit] = impl_exit,
+#if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
+    [TARGET_NR_name_to_handle_at] = impl_name_to_handle_at,
+#endif
 #ifdef TARGET_NR_open
     [TARGET_NR_open] = impl_open,
 #endif
-- 
2.17.0
