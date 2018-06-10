Received: from eggs.gnu.org ([2001:4830:134:3::10]:40407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdb-0002IG-FF
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqda-0003RK-Al
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:27 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:34528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqda-0003RA-2i
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:26 -0400
Received: by mail-pl0-x243.google.com with SMTP id g20-v6so10400293plq.1
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:00:59 -1000
Message-Id: <20180610030220.3777-28-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 027/108] linux-user: Split out chroot, dup2,
 dup3, fcntl, setpgid, umask
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

All targets define dup3; remove the ifdef.

If !CONFIG_DUP3, fall back to dup2 when flags == 0.  This will help
emulation of new targets that do not define the dup2 syscall, using
dup3 as the syscall backing the dup2 posix function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 113 ++++++++++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 38 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ebe57d86aa..8e13a16e91 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7855,6 +7855,19 @@ IMPL(chmod)
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
     fd_trans_unregister(arg1);
@@ -7886,6 +7899,41 @@ IMPL(dup)
     return ret;
 }
 
+#ifdef TARGET_NR_dup2
+IMPL(dup2)
+{
+    abi_long ret = get_errno(dup2(arg1, arg2));
+    if (ret >= 0) {
+        fd_trans_dup(arg1, arg2);
+    }
+    return ret;
+}
+#endif
+
+IMPL(dup3)
+{
+    int host_flags = target_to_host_bitmask(arg3, fcntl_flags_tbl);
+    abi_long ret;
+
+    if ((arg3 & ~TARGET_O_CLOEXEC) != 0) {
+        return -EINVAL;
+    }
+#ifdef CONFIG_DUP3
+    ret = dup3(arg1, arg2, host_flags);
+#else
+    if (host_flags == 0) {
+        ret = dup2(arg1, arg2);
+    } else {
+        return -TARGET_ENOSYS;
+    }
+#endif
+    ret = get_errno(ret);
+    if (ret >= 0) {
+        fd_trans_dup(arg1, arg2);
+    }
+    return ret;
+}
+
 IMPL(execve)
 {
     abi_ulong *guest_ptrs;
@@ -8046,6 +8094,13 @@ IMPL(faccessat)
     return ret;
 }
 
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
@@ -8553,6 +8608,11 @@ IMPL(rmdir)
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
@@ -8611,6 +8671,11 @@ IMPL(times)
     return host_to_target_clock_t(ret);
 }
 
+IMPL(umask)
+{
+    return get_errno(umask(arg1));
+}
+
 #ifdef TARGET_NR_umount
 IMPL(umount)
 {
@@ -8789,44 +8854,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
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
@@ -12622,6 +12649,7 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(brk);
         SYSCALL(close);
         SYSCALL(chdir);
+        SYSCALL(chroot);
 #ifdef TARGET_NR_chmod
         SYSCALL(chmod);
 #endif
@@ -12629,9 +12657,16 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(creat);
 #endif
         SYSCALL(dup);
+#ifdef TARGET_NR_dup2
+        SYSCALL(dup2);
+#endif
+        SYSCALL(dup3);
         SYSCALL(execve);
         SYSCALL(exit);
         SYSCALL(faccessat);
+#ifdef TARGET_NR_fcntl
+        SYSCALL(fcntl);
+#endif
 #ifdef TARGET_NR_fork
         SYSCALL(fork);
 #endif
@@ -12691,6 +12726,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_rmdir
         SYSCALL(rmdir);
 #endif
+        SYSCALL(setpgid);
 #ifdef TARGET_NR_stime
         SYSCALL(stime);
 #endif
@@ -12702,6 +12738,7 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(time);
 #endif
         SYSCALL(times);
+        SYSCALL(umask);
 #ifdef TARGET_NR_umount
         SYSCALL(umount);
 #endif
-- 
2.17.1
