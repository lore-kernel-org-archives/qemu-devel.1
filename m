Received: from eggs.gnu.org ([2001:4830:134:3::10]:40220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqd9-0001t2-Ea
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqd6-0003Fw-Nm
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:02:59 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:37244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqd6-0003FU-IX
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:02:56 -0400
Received: by mail-pf0-x243.google.com with SMTP id y5-v6so7582990pfn.4
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:02:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:00:46 -1000
Message-Id: <20180610030220.3777-15-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 014/108] linux-user: Split out
 open_to_handle_at
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
All targets define this syscall; remove one of the two ifdefs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 79 ++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 90341f4254..f51cc7e937 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7362,40 +7362,6 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
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
-
 #if defined(TARGET_NR_signalfd) || defined(TARGET_NR_signalfd4)
 
 /* signalfd siginfo conversion */
@@ -8152,6 +8118,42 @@ IMPL(openat)
     return ret;
 }
 
+#ifdef CONFIG_OPEN_BY_HANDLE
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
+    flags = target_to_host_bitmask(flags, fcntl_flags_tbl);
+    ret = get_errno(open_by_handle_at(mount_fd, fh, flags));
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
@@ -8213,12 +8215,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#if defined(TARGET_NR_open_by_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
-    case TARGET_NR_open_by_handle_at:
-        ret = do_open_by_handle_at(arg1, arg2, arg3);
-        fd_trans_unregister(ret);
-        return ret;
-#endif
 #ifdef TARGET_NR_fork
     case TARGET_NR_fork:
         return get_errno(do_fork(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0));
@@ -12495,6 +12491,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(open);
 #endif
         SYSCALL(openat);
+#ifdef CONFIG_OPEN_BY_HANDLE
+        SYSCALL(open_by_handle_at);
+#endif
         SYSCALL(read);
         SYSCALL(write);
     }
-- 
2.17.1
