Received: from eggs.gnu.org ([2001:4830:134:3::10]:40361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdT-0002AK-N0
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdS-0003Oh-R2
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:19 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:45905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqdS-0003O8-LL
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:18 -0400
Received: by mail-pl0-x244.google.com with SMTP id c23-v6so10384114plz.12
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:00:56 -1000
Message-Id: <20180610030220.3777-25-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 024/108] linux-user: Split out dup, mkdir,
 mkdirat, rmdir
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

All targets define mkdirat; remove the ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 90 +++++++++++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 30 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e0a5d86956..f22d45d2cb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7946,6 +7946,15 @@ IMPL(creat)
 }
 #endif
 
+IMPL(dup)
+{
+    abi_long ret = get_errno(dup(arg1));
+    if (ret >= 0) {
+        fd_trans_dup(arg1, ret);
+    }
+    return ret;
+}
+
 IMPL(execve)
 {
     abi_ulong *guest_ptrs;
@@ -8191,6 +8200,34 @@ IMPL(lseek)
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
+IMPL(mkdirat)
+{
+    char *p = lock_user_string(arg2);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(mkdirat(arg1, p, arg3));
+    unlock_user(p, arg2, 0);
+    return ret;
+}
+
 #ifdef TARGET_NR_mknod
 IMPL(mknod)
 {
@@ -8464,6 +8501,21 @@ IMPL(renameat2)
     return ret;
 }
 
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
@@ -8665,36 +8717,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
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
-        ret = get_errno(dup(arg1));
-        if (ret >= 0) {
-            fd_trans_dup(arg1, ret);
-        }
-        return ret;
 #ifdef TARGET_NR_pipe
     case TARGET_NR_pipe:
         return do_pipe(cpu_env, arg1, 0, 0);
@@ -12581,6 +12603,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_creat
         SYSCALL(creat);
 #endif
+        SYSCALL(dup);
         SYSCALL(execve);
         SYSCALL(exit);
         SYSCALL(faccessat);
@@ -12602,6 +12625,10 @@ static impl_fn *syscall_table(unsigned num)
 #endif
         SYSCALL(linkat);
         SYSCALL(lseek);
+#ifdef TARGET_NR_mkdir
+        SYSCALL(mkdir);
+#endif
+        SYSCALL(mkdirat);
 #ifdef TARGET_NR_mknod
         SYSCALL(mknod);
 #endif
@@ -12631,6 +12658,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(renameat);
 #endif
         SYSCALL(renameat2);
+#ifdef TARGET_NR_rmdir
+        SYSCALL(rmdir);
+#endif
 #ifdef TARGET_NR_stime
         SYSCALL(stime);
 #endif
-- 
2.17.1
