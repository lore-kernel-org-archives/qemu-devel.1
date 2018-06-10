Received: from eggs.gnu.org ([2001:4830:134:3::10]:41126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqf7-0003jk-3h
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqf5-0004EJ-Ua
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:01 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:44111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqf5-0004DM-Mq
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:59 -0400
Received: by mail-pl0-x242.google.com with SMTP id z9-v6so10387518plk.11
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:44 -1000
Message-Id: <20180610030220.3777-73-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 072/108] linux-user: Split out getegid,
 geteuid, getgid, getuid, lchown
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
 linux-user/syscall.c | 82 +++++++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 24 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8d6b949b8a..f8e34d28b1 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8441,6 +8441,27 @@ IMPL(getdents64)
 }
 #endif /* TARGET_NR_getdents64 */
 
+#ifdef TARGET_NR_getegid
+IMPL(getegid)
+{
+    return get_errno(high2lowgid(getegid()));
+}
+#endif
+
+#ifdef TARGET_NR_geteuid
+IMPL(geteuid)
+{
+    return get_errno(high2lowuid(geteuid()));
+}
+#endif
+
+#ifdef TARGET_NR_getgid
+IMPL(getgid)
+{
+    return get_errno(high2lowgid(getgid()));
+}
+#endif
+
 IMPL(getitimer)
 {
     struct itimerval value;
@@ -8584,6 +8605,13 @@ IMPL(gettimeofday)
     return ret;
 }
 
+#ifdef TARGET_NR_getuid
+IMPL(getuid)
+{
+    return get_errno(high2lowuid(getuid()));
+}
+#endif
+
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
 IMPL(getxpid)
 {
@@ -8769,6 +8797,21 @@ IMPL(kill)
     return get_errno(safe_kill(arg1, target_to_host_signal(arg2)));
 }
 
+#ifdef TARGET_NR_lchown
+IMPL(lchown)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(lchown(p, low2highuid(arg2), low2highgid(arg3)));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_link
 IMPL(link)
 {
@@ -11410,30 +11453,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_lchown
-    case TARGET_NR_lchown:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(lchown(p, low2highuid(arg2), low2highgid(arg3)));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-#ifdef TARGET_NR_getuid
-    case TARGET_NR_getuid:
-        return get_errno(high2lowuid(getuid()));
-#endif
-#ifdef TARGET_NR_getgid
-    case TARGET_NR_getgid:
-        return get_errno(high2lowgid(getgid()));
-#endif
-#ifdef TARGET_NR_geteuid
-    case TARGET_NR_geteuid:
-        return get_errno(high2lowuid(geteuid()));
-#endif
-#ifdef TARGET_NR_getegid
-    case TARGET_NR_getegid:
-        return get_errno(high2lowgid(getegid()));
-#endif
     case TARGET_NR_setreuid:
         return get_errno(setreuid(low2highuid(arg1), low2highuid(arg2)));
     case TARGET_NR_setregid:
@@ -13094,6 +13113,15 @@ static impl_fn *syscall_table(unsigned num)
 #endif
 #if defined(TARGET_NR_getdents64) && defined(__NR_getdents64)
         SYSCALL(getdents64);
+#endif
+#ifdef TARGET_NR_getegid
+        SYSCALL(getegid);
+#endif
+#ifdef TARGET_NR_geteuid
+        SYSCALL(geteuid);
+#endif
+#ifdef TARGET_NR_getgid
+        SYSCALL(getgid);
 #endif
         SYSCALL(getitimer);
 #ifdef TARGET_NR_getpeername
@@ -13121,6 +13149,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(getsockopt);
 #endif
         SYSCALL(gettimeofday);
+#ifdef TARGET_NR_getuid
+        SYSCALL(getuid);
+#endif
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
         SYSCALL(getxpid);
 #endif
@@ -13129,6 +13160,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(ipc);
 #endif
         SYSCALL(kill);
+#ifdef TARGET_NR_lchown
+        SYSCALL(lchown);
+#endif
 #ifdef TARGET_NR_link
         SYSCALL(link);
 #endif
-- 
2.17.1
