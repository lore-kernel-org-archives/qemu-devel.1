Received: from eggs.gnu.org ([2001:4830:134:3::10]:40626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqe3-0002i7-9Y
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqe2-0003cc-7B
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:55 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:47032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqe2-0003cM-1g
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:54 -0400
Received: by mail-pg0-x242.google.com with SMTP id d2-v6so8129647pga.13
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:12 -1000
Message-Id: <20180610030220.3777-41-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 040/108] linux-user: Split out mlock,
 mlockall, munlock, munlockall
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

All targets define all of these; remove the ifdefs.
Merge target_to_host_mlockall_arg into its only caller.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 62 ++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7504ad74b5..f79aebe869 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7144,21 +7144,6 @@ static inline abi_long target_to_host_sigevent(struct sigevent *host_sevp,
     return 0;
 }
 
-#if defined(TARGET_NR_mlockall)
-static inline int target_to_host_mlockall_arg(int arg)
-{
-    int result = 0;
-
-    if (arg & TARGET_MLOCKALL_MCL_CURRENT) {
-        result |= MCL_CURRENT;
-    }
-    if (arg & TARGET_MLOCKALL_MCL_FUTURE) {
-        result |= MCL_FUTURE;
-    }
-    return result;
-}
-#endif
-
 static inline abi_long host_to_target_stat64(void *cpu_env,
                                              abi_ulong target_addr,
                                              struct stat *host_st)
@@ -8392,6 +8377,23 @@ IMPL(mknodat)
     return ret;
 }
 
+IMPL(mlock)
+{
+    return get_errno(mlock(g2h(arg1), arg2));
+}
+
+IMPL(mlockall)
+{
+    int host_flags = 0;
+    if (arg1 & TARGET_MLOCKALL_MCL_CURRENT) {
+        host_flags |= MCL_CURRENT;
+    }
+    if (arg1 & TARGET_MLOCKALL_MCL_FUTURE) {
+        host_flags |= MCL_FUTURE;
+    }
+    return get_errno(mlockall(host_flags));
+}
+
 #ifdef TARGET_NR_mmap
 IMPL(mmap)
 {
@@ -8497,6 +8499,16 @@ IMPL(msync)
     return get_errno(msync(g2h(arg1), arg2, arg3));
 }
 
+IMPL(munlock)
+{
+    return get_errno(munlock(g2h(arg1), arg2));
+}
+
+IMPL(munlockall)
+{
+    return get_errno(munlockall());
+}
+
 IMPL(munmap)
 {
     return get_errno(target_munmap(arg1, arg2));
@@ -9734,22 +9746,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_mlock
-    case TARGET_NR_mlock:
-        return get_errno(mlock(g2h(arg1), arg2));
-#endif
-#ifdef TARGET_NR_munlock
-    case TARGET_NR_munlock:
-        return get_errno(munlock(g2h(arg1), arg2));
-#endif
-#ifdef TARGET_NR_mlockall
-    case TARGET_NR_mlockall:
-        return get_errno(mlockall(target_to_host_mlockall_arg(arg1)));
-#endif
-#ifdef TARGET_NR_munlockall
-    case TARGET_NR_munlockall:
-        return get_errno(munlockall());
-#endif
     case TARGET_NR_truncate:
         if (!(p = lock_user_string(arg1)))
             return -TARGET_EFAULT;
@@ -12762,6 +12758,8 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(mknod);
 #endif
         SYSCALL(mknodat);
+        SYSCALL(mlock);
+        SYSCALL(mlockall);
 #ifdef TARGET_NR_mmap
         SYSCALL(mmap);
 #endif
@@ -12772,6 +12770,8 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(mprotect);
         SYSCALL(mremap);
         SYSCALL(msync);
+        SYSCALL(munlock);
+        SYSCALL(munlockall);
         SYSCALL(munmap);
 #ifdef CONFIG_OPEN_BY_HANDLE
         SYSCALL(name_to_handle_at);
-- 
2.17.1
