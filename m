Received: from eggs.gnu.org ([2001:4830:134:3::10]:40640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqe5-0002k0-2w
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqe4-0003dG-5h
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:57 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:47033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqe3-0003d3-Ve
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:56 -0400
Received: by mail-pg0-x243.google.com with SMTP id d2-v6so8129667pga.13
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:13 -1000
Message-Id: <20180610030220.3777-42-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 041/108] linux-user: Split out fchmod,
 fchmodat, ftruncate, truncate
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

All targets define fchmodat; remove the ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 58 ++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f79aebe869..df8422cd3a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8079,6 +8079,24 @@ IMPL(faccessat)
     return ret;
 }
 
+IMPL(fchmod)
+{
+    return get_errno(fchmod(arg1, arg2));
+}
+
+IMPL(fchmodat)
+{
+    char *p = lock_user_string(arg2);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(fchmodat(arg1, p, arg3, 0));
+    unlock_user(p, arg2, 0);
+    return ret;
+}
+
 #ifdef TARGET_NR_fcntl
 IMPL(fcntl)
 {
@@ -8093,6 +8111,11 @@ IMPL(fork)
 }
 #endif
 
+IMPL(ftruncate)
+{
+    return get_errno(ftruncate(arg1, arg2));
+}
+
 #ifdef TARGET_NR_futimesat
 IMPL(futimesat)
 {
@@ -9563,6 +9586,19 @@ IMPL(times)
     return host_to_target_clock_t(ret);
 }
 
+IMPL(truncate)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(truncate(p, arg2));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+
 IMPL(umask)
 {
     return get_errno(umask(arg1));
@@ -9746,24 +9782,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_truncate:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(truncate(p, arg2));
-        unlock_user(p, arg1, 0);
-        return ret;
-    case TARGET_NR_ftruncate:
-        return get_errno(ftruncate(arg1, arg2));
-    case TARGET_NR_fchmod:
-        return get_errno(fchmod(arg1, arg2));
-#if defined(TARGET_NR_fchmodat)
-    case TARGET_NR_fchmodat:
-        if (!(p = lock_user_string(arg2)))
-            return -TARGET_EFAULT;
-        ret = get_errno(fchmodat(arg1, p, arg3, 0));
-        unlock_user(p, arg2, 0);
-        return ret;
-#endif
     case TARGET_NR_getpriority:
         /* Note that negative values are valid for getpriority, so we must
            differentiate based on errno settings.  */
@@ -12719,12 +12737,15 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(execve);
         SYSCALL(exit);
         SYSCALL(faccessat);
+        SYSCALL(fchmod);
+        SYSCALL(fchmodat);
 #ifdef TARGET_NR_fcntl
         SYSCALL(fcntl);
 #endif
 #ifdef TARGET_NR_fork
         SYSCALL(fork);
 #endif
+        SYSCALL(ftruncate);
 #ifdef TARGET_NR_futimesat
         SYSCALL(futimesat);
 #endif
@@ -12870,6 +12891,7 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(time);
 #endif
         SYSCALL(times);
+        SYSCALL(truncate);
         SYSCALL(umask);
 #ifdef TARGET_NR_umount
         SYSCALL(umount);
-- 
2.17.1
