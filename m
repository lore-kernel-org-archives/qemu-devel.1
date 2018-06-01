Received: from eggs.gnu.org ([2001:4830:134:3::10]:57647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeX5-0005p1-HH
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeX4-0000jz-FG
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:31 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:37618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeX4-0000jN-9T
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:30 -0400
Received: by mail-pf0-x241.google.com with SMTP id e9-v6so12083209pfi.4
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:42 -0700
Message-Id: <20180601073050.8054-26-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 25/33] linux-user: Split out dup, mkdir, mkdirat,
 rmdir
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
 linux-user/syscall.c | 109 +++++++++++++++++++++++++++++--------------
 1 file changed, 73 insertions(+), 36 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 24514329b0..36092d753d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7977,6 +7977,20 @@ IMPL(creat)
 }
 #endif
 
+IMPL(dup)
+{
+    abi_long ret;
+
+    if (is_hostfd(arg1)) {
+        return -TARGET_EBADF;
+    }
+    ret = get_errno(dup(arg1));
+    if (ret >= 0) {
+        fd_trans_dup(arg1, ret);
+    }
+    return ret;
+}
+
 IMPL(execve)
 {
     abi_ulong *guest_ptrs;
@@ -8249,6 +8263,40 @@ IMPL(lseek)
     return get_errno(lseek(arg1, arg2, arg3));
 }
 
+#ifdef TARGET_NR_mkdir
+IMPL(mkdir)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(mkdir(p, arg2));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
+#ifdef TARGET_NR_mkdirat
+IMPL(mkdirat)
+{
+    char *p;
+    abi_long ret;
+
+    if (is_hostfd(arg1)) {
+        return -TARGET_EBADF;
+    }
+    p = lock_user_string(arg2);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(mkdirat(arg1, p, arg3));
+    unlock_user(p, arg2, 0);
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_mknod
 IMPL(mknod)
 {
@@ -8558,6 +8606,21 @@ IMPL(renameat2)
 }
 #endif
 
+#ifdef TARGET_NR_rmdir
+IMPL(rmdir)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(rmdir(p));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_stime
 IMPL(stime)
 {
@@ -8768,42 +8831,6 @@ IMPL(everything_else)
     char *fn;
 
     switch(num) {
-#ifdef TARGET_NR_mkdir
-    case TARGET_NR_mkdir:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(mkdir(p, arg2));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-#if defined(TARGET_NR_mkdirat)
-    case TARGET_NR_mkdirat:
-        if (is_hostfd(arg1)) {
-            return -TARGET_EBADF;
-        }
-        if (!(p = lock_user_string(arg2)))
-            return -TARGET_EFAULT;
-        ret = get_errno(mkdirat(arg1, p, arg3));
-        unlock_user(p, arg2, 0);
-        return ret;
-#endif
-#ifdef TARGET_NR_rmdir
-    case TARGET_NR_rmdir:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(rmdir(p));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-    case TARGET_NR_dup:
-        if (is_hostfd(arg1)) {
-            return -TARGET_EBADF;
-        }
-        ret = get_errno(dup(arg1));
-        if (ret >= 0) {
-            fd_trans_dup(arg1, ret);
-        }
-        return ret;
 #ifdef TARGET_NR_pipe
     case TARGET_NR_pipe:
         return do_pipe(cpu_env, arg1, 0, 0);
@@ -12922,6 +12949,7 @@ static impl_fn * const syscall_table[] = {
 #ifdef TARGET_NR_creat
     [TARGET_NR_creat] = impl_creat,
 #endif
+    [TARGET_NR_dup] = impl_dup,
     [TARGET_NR_execve] = impl_execve,
     [TARGET_NR_exit] = impl_exit,
 #ifdef TARGET_NR_faccessat
@@ -12947,6 +12975,12 @@ static impl_fn * const syscall_table[] = {
     [TARGET_NR_linkat] = impl_linkat,
 #endif
     [TARGET_NR_lseek] = impl_lseek,
+#ifdef TARGET_NR_mkdir
+    [TARGET_NR_mkdir] = impl_mkdir,
+#endif
+#ifdef TARGET_NR_mkdirat
+    [TARGET_NR_mkdirat] = impl_mkdirat,
+#endif
 #ifdef TARGET_NR_mknod
     [TARGET_NR_mknod] = impl_mknod,
 #endif
@@ -12980,6 +13014,9 @@ static impl_fn * const syscall_table[] = {
 #ifdef TARGET_NR_renameat2
     [TARGET_NR_renameat2] = impl_renameat2,
 #endif
+#ifdef TARGET_NR_rmdir
+    [TARGET_NR_rmdir] = impl_rmdir,
+#endif
 #ifdef TARGET_NR_stime
     [TARGET_NR_stime] = impl_stime,
 #endif
-- 
2.17.0
