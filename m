Received: from eggs.gnu.org ([2001:4830:134:3::10]:40198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqd6-0001pp-5n
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqd5-0003FA-59
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:02:56 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:45641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqd4-0003Eo-T4
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:02:55 -0400
Received: by mail-pf0-x244.google.com with SMTP id a22-v6so8479202pfo.12
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:02:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:00:45 -1000
Message-Id: <20180610030220.3777-14-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 013/108] linux-user: Split out
 name_to_handle_at
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
All targets define this syscall; remove one of the two ifdefs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 116 +++++++++++++++++++++----------------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a4d0f2720f..90341f4254 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7361,59 +7361,6 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
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
-    ret = get_errno(name_to_handle_at(dirfd, path(name), fh, &mid, flags));
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
 
 #if defined(TARGET_NR_open_by_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
 static abi_long do_open_by_handle_at(abi_long mount_fd, abi_long handle,
@@ -8116,6 +8063,61 @@ IMPL(exit)
     g_assert_not_reached();
 }
 
+#ifdef CONFIG_OPEN_BY_HANDLE
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
+    ret = get_errno(name_to_handle_at(dirfd, path(name), fh, &mid, flags));
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
@@ -8211,11 +8213,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
-    case TARGET_NR_name_to_handle_at:
-        ret = do_name_to_handle_at(arg1, arg2, arg3, arg4, arg5);
-        return ret;
-#endif
 #if defined(TARGET_NR_open_by_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     case TARGET_NR_open_by_handle_at:
         ret = do_open_by_handle_at(arg1, arg2, arg3);
@@ -12491,6 +12488,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(close);
         SYSCALL(execve);
         SYSCALL(exit);
+#ifdef CONFIG_OPEN_BY_HANDLE
+        SYSCALL(name_to_handle_at);
+#endif
 #ifdef TARGET_NR_open
         SYSCALL(open);
 #endif
-- 
2.17.1
