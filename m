Received: from eggs.gnu.org ([2001:4830:134:3::10]:41157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfC-0003oH-3i
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqf9-0004JO-EX
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:06 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:41588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqf9-0004J0-7g
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:03 -0400
Received: by mail-pl0-x242.google.com with SMTP id az12-v6so10380849plb.8
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:46 -1000
Message-Id: <20180610030220.3777-75-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 074/108] linux-user: Split out fchown,
 fchownat, setresgid, setresuid
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

All targets define fchownat; remove the ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 66 +++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 915e1f1a91..75b869fb33 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8103,6 +8103,25 @@ IMPL(fchmodat)
     return ret;
 }
 
+IMPL(fchown)
+{
+    return get_errno(fchown(arg1, low2highuid(arg2), low2highgid(arg3)));
+}
+
+IMPL(fchownat)
+{
+    char *p = lock_user_string(arg2);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(fchownat(arg1, p, low2highuid(arg3),
+                             low2highgid(arg4), arg5));
+    unlock_user(p, arg2, 0);
+    return ret;
+}
+
 #ifdef TARGET_NR_fcntl
 IMPL(fcntl)
 {
@@ -10540,6 +10559,22 @@ IMPL(setregid)
     return get_errno(setregid(low2highgid(arg1), low2highgid(arg2)));
 }
 
+#ifdef TARGET_NR_setresgid
+IMPL(setresgid)
+{
+    return get_errno(sys_setresgid(low2highgid(arg1), low2highgid(arg2),
+                                   low2highgid(arg3)));
+}
+#endif
+
+#ifdef TARGET_NR_setresuid
+IMPL(setresuid)
+{
+    return get_errno(sys_setresuid(low2highuid(arg1), low2highuid(arg2),
+                                   low2highuid(arg3)));
+}
+#endif
+
 IMPL(setreuid)
 {
     return get_errno(setreuid(low2highuid(arg1), low2highuid(arg2)));
@@ -11512,23 +11547,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_fchown:
-        return get_errno(fchown(arg1, low2highuid(arg2), low2highgid(arg3)));
-#if defined(TARGET_NR_fchownat)
-    case TARGET_NR_fchownat:
-        if (!(p = lock_user_string(arg2))) 
-            return -TARGET_EFAULT;
-        ret = get_errno(fchownat(arg1, p, low2highuid(arg3),
-                                 low2highgid(arg4), arg5));
-        unlock_user(p, arg2, 0);
-        return ret;
-#endif
-#ifdef TARGET_NR_setresuid
-    case TARGET_NR_setresuid:
-        return get_errno(sys_setresuid(low2highuid(arg1),
-                                       low2highuid(arg2),
-                                       low2highuid(arg3)));
-#endif
 #ifdef TARGET_NR_getresuid
     case TARGET_NR_getresuid:
         {
@@ -11543,12 +11561,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
         }
         return ret;
 #endif
-#ifdef TARGET_NR_getresgid
-    case TARGET_NR_setresgid:
-        return get_errno(sys_setresgid(low2highgid(arg1),
-                                       low2highgid(arg2),
-                                       low2highgid(arg3)));
-#endif
 #ifdef TARGET_NR_getresgid
     case TARGET_NR_getresgid:
         {
@@ -13094,6 +13106,8 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(fchdir);
         SYSCALL(fchmod);
         SYSCALL(fchmodat);
+        SYSCALL(fchown);
+        SYSCALL(fchownat);
 #ifdef TARGET_NR_fcntl
         SYSCALL(fcntl);
 #endif
@@ -13378,6 +13392,12 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(setpgid);
         SYSCALL(setpriority);
         SYSCALL(setregid);
+#ifdef TARGET_NR_setresgid
+        SYSCALL(setresgid);
+#endif
+#ifdef TARGET_NR_setresuid
+        SYSCALL(setresuid);
+#endif
         SYSCALL(setreuid);
         SYSCALL(setrlimit);
 #ifdef TARGET_NR_setsockopt
-- 
2.17.1
