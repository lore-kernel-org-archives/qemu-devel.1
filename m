Received: from eggs.gnu.org ([2001:4830:134:3::10]:57696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeXC-0005vM-IO
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeX8-0000oF-Kh
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:38 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:41503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeX8-0000nb-CF
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:34 -0400
Received: by mail-pl0-x244.google.com with SMTP id az12-v6so14819689plb.8
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:45 -0700
Message-Id: <20180601073050.8054-29-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 28/33] linux-user: Split out chroot, dup2, dup3,
 fcntl, setpgid, umask
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
 linux-user/syscall.c | 123 +++++++++++++++++++++++++++----------------
 1 file changed, 79 insertions(+), 44 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 4be71367fc..4d9b9cad6e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7879,6 +7879,19 @@ IMPL(chmod)
 }
 #endif
 
+IMPL(chroot)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(chroot(p));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+
 IMPL(close)
 {
     if (is_hostfd(arg1)) {
@@ -7918,6 +7931,43 @@ IMPL(dup)
     return ret;
 }
 
+#ifdef TARGET_NR_dup2
+IMPL(dup2)
+{
+    abi_long ret;
+
+    if (is_hostfd(arg1) || is_hostfd(arg2)) {
+        return -TARGET_EBADF;
+    }
+    ret = get_errno(dup2(arg1, arg2));
+    if (ret >= 0) {
+        fd_trans_dup(arg1, arg2);
+    }
+    return ret;
+}
+#endif
+
+#if defined(TARGET_NR_dup3) && defined(CONFIG_DUP3)
+IMPL(dup3)
+{
+    int host_flags;
+    abi_long ret;
+
+    if (is_hostfd(arg1) || is_hostfd(arg2)) {
+        return -TARGET_EBADF;
+    }
+    if ((arg3 & ~TARGET_O_CLOEXEC) != 0) {
+        return -EINVAL;
+    }
+    host_flags = target_to_host_bitmask(arg3, fcntl_flags_tbl);
+    ret = get_errno(dup3(arg1, arg2, host_flags));
+    if (ret >= 0) {
+        fd_trans_dup(arg1, arg2);
+    }
+    return ret;
+}
+#endif
+
 IMPL(execve)
 {
     abi_ulong *guest_ptrs;
@@ -8087,6 +8137,13 @@ IMPL(faccessat)
 }
 #endif
 
+#ifdef TARGET_NR_fcntl
+IMPL(fcntl)
+{
+    return do_fcntl(arg1, arg2, arg3);
+}
+#endif
+
 #ifdef TARGET_NR_fork
 IMPL(fork)
 {
@@ -8659,6 +8716,11 @@ IMPL(rmdir)
 }
 #endif
 
+IMPL(setpgid)
+{
+    return get_errno(setpgid(arg1, arg2));
+}
+
 #ifdef TARGET_NR_stime
 IMPL(stime)
 {
@@ -8716,6 +8778,11 @@ IMPL(times)
     return ret;
 }
 
+IMPL(umask)
+{
+    return get_errno(umask(arg1));
+}
+
 #ifdef TARGET_NR_umount
 IMPL(umount)
 {
@@ -8905,50 +8972,6 @@ IMPL(everything_else)
     char *fn;
 
     switch(num) {
-#ifdef TARGET_NR_fcntl
-    case TARGET_NR_fcntl:
-        return do_fcntl(arg1, arg2, arg3);
-#endif
-    case TARGET_NR_setpgid:
-        return get_errno(setpgid(arg1, arg2));
-    case TARGET_NR_umask:
-        return get_errno(umask(arg1));
-    case TARGET_NR_chroot:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(chroot(p));
-        unlock_user(p, arg1, 0);
-        return ret;
-#ifdef TARGET_NR_dup2
-    case TARGET_NR_dup2:
-        if (is_hostfd(arg1) || is_hostfd(arg2)) {
-            return -TARGET_EBADF;
-        }
-        ret = get_errno(dup2(arg1, arg2));
-        if (ret >= 0) {
-            fd_trans_dup(arg1, arg2);
-        }
-        return ret;
-#endif
-#if defined(CONFIG_DUP3) && defined(TARGET_NR_dup3)
-    case TARGET_NR_dup3:
-    {
-        int host_flags;
-
-        if (is_hostfd(arg1) || is_hostfd(arg2)) {
-            return -TARGET_EBADF;
-        }
-        if ((arg3 & ~TARGET_O_CLOEXEC) != 0) {
-            return -EINVAL;
-        }
-        host_flags = target_to_host_bitmask(arg3, fcntl_flags_tbl);
-        ret = get_errno(dup3(arg1, arg2, host_flags));
-        if (ret >= 0) {
-            fd_trans_dup(arg1, arg2);
-        }
-        return ret;
-    }
-#endif
 #ifdef TARGET_NR_getppid /* not on alpha */
     case TARGET_NR_getppid:
         return get_errno(getppid());
@@ -12969,6 +12992,7 @@ static impl_fn * const syscall_table[] = {
     [TARGET_NR_brk] = impl_brk,
     [TARGET_NR_close] = impl_close,
     [TARGET_NR_chdir] = impl_chdir,
+    [TARGET_NR_chroot] = impl_chroot,
 #ifdef TARGET_NR_chmod
     [TARGET_NR_chmod] = impl_chmod,
 #endif
@@ -12976,11 +13000,20 @@ static impl_fn * const syscall_table[] = {
     [TARGET_NR_creat] = impl_creat,
 #endif
     [TARGET_NR_dup] = impl_dup,
+#ifdef TARGET_NR_dup2
+    [TARGET_NR_dup2] = impl_dup2,
+#endif
+#if defined(TARGET_NR_dup3) && defined(CONFIG_DUP3)
+    [TARGET_NR_dup3] = impl_dup3,
+#endif
     [TARGET_NR_execve] = impl_execve,
     [TARGET_NR_exit] = impl_exit,
 #ifdef TARGET_NR_faccessat
     [TARGET_NR_faccessat] = impl_faccessat,
 #endif
+#ifdef TARGET_NR_fcntl
+    [TARGET_NR_fcntl] = impl_fcntl,
+#endif
 #ifdef TARGET_NR_fork
     [TARGET_NR_fork] = impl_fork,
 #endif
@@ -13050,6 +13083,7 @@ static impl_fn * const syscall_table[] = {
 #ifdef TARGET_NR_rmdir
     [TARGET_NR_rmdir] = impl_rmdir,
 #endif
+    [TARGET_NR_setpgid] = impl_setpgid,
 #ifdef TARGET_NR_stime
     [TARGET_NR_stime] = impl_stime,
 #endif
@@ -13061,6 +13095,7 @@ static impl_fn * const syscall_table[] = {
     [TARGET_NR_time] = impl_time,
 #endif
     [TARGET_NR_times] = impl_times,
+    [TARGET_NR_umask] = impl_umask,
 #ifdef TARGET_NR_umount
     [TARGET_NR_umount] = impl_umount,
 #endif
-- 
2.17.0
