Received: from eggs.gnu.org ([2001:4830:134:3::10]:40733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeL-00033B-QD
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeK-0003hu-IJ
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:13 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:40843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqeK-0003hm-80
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:12 -0400
Received: by mail-pg0-x241.google.com with SMTP id l2-v6so8127859pgc.7
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:20 -1000
Message-Id: <20180610030220.3777-49-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 048/108] linux-user: Split out getrandom,
 shutdown, setsockopt, socket, socketpair
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

All targets define getrandom; remove the ifdef.
Define a stub if the host __NR_getrandom is not defined.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 90 ++++++++++++++++++++++++++++++--------------
 1 file changed, 62 insertions(+), 28 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 977f61610c..4dc2312ae6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -249,6 +249,14 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #define TARGET_NR__llseek TARGET_NR_llseek
 #endif
 
+/* These definitions produce an ENOSYS from the host kernel.
+ * Performing a bogus syscall is lazier than boilerplating
+ * the replacement functions here in C.
+ */
+#ifndef __NR_getrandom
+#define __NR_getrandom  -1
+#endif
+
 #ifdef __NR_gettid
 _syscall0(int, gettid)
 #else
@@ -315,9 +323,7 @@ _syscall2(int, ioprio_get, int, which, int, who)
 #if defined(TARGET_NR_ioprio_set) && defined(__NR_ioprio_set)
 _syscall3(int, ioprio_set, int, which, int, who, int, ioprio)
 #endif
-#if defined(TARGET_NR_getrandom) && defined(__NR_getrandom)
 _syscall3(int, getrandom, void *, buf, size_t, buflen, unsigned int, flags)
-#endif
 
 #if defined(TARGET_NR_kcmp) && defined(__NR_kcmp)
 _syscall5(int, kcmp, pid_t, pid1, pid_t, pid2, int, type,
@@ -8202,6 +8208,19 @@ IMPL(getpriority)
 #endif
 }
 
+IMPL(getrandom)
+{
+    char *p = lock_user(VERIFY_WRITE, arg1, arg2, 0);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(getrandom(p, arg2, arg3));
+    unlock_user(p, arg1, ret);
+    return ret;
+}
+
 IMPL(getrlimit)
 {
     int resource = target_to_host_resource(arg1);
@@ -9284,6 +9303,13 @@ IMPL(sgetmask)
 }
 #endif
 
+#ifdef TARGET_NR_shutdown
+IMPL(shutdown)
+{
+    return get_errno(shutdown(arg1, arg2));
+}
+#endif
+
 #if defined(TARGET_NR_select) && !defined(TARGET_WANT_NI_OLD_SELECT)
 IMPL(select)
 {
@@ -9361,6 +9387,13 @@ IMPL(setrlimit)
     return get_errno(setrlimit(resource, &rlim));
 }
 
+#ifdef TARGET_NR_setsockopt
+IMPL(setsockopt)
+{
+    return do_setsockopt(arg1, arg2, arg3, arg4, (socklen_t) arg5);
+}
+#endif
+
 IMPL(settimeofday)
 {
     struct timeval tv;
@@ -9592,6 +9625,13 @@ IMPL(sigsuspend)
 }
 #endif
 
+#ifdef TARGET_NR_socket
+IMPL(socket)
+{
+    return do_socket(arg1, arg2, arg3);
+}
+#endif
+
 #ifdef TARGET_NR_socketcall
 IMPL(socketcall)
 {
@@ -9686,6 +9726,13 @@ IMPL(socketcall)
 }
 #endif
 
+#ifdef TARGET_NR_socketpair
+IMPL(socketpair)
+{
+    return do_socketpair(arg1, arg2, arg3, arg4);
+}
+#endif
+
 #ifdef TARGET_NR_ssetmask
 IMPL(ssetmask)
 {
@@ -10035,32 +10082,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_shutdown
-    case TARGET_NR_shutdown:
-        return get_errno(shutdown(arg1, arg2));
-#endif
-#if defined(TARGET_NR_getrandom) && defined(__NR_getrandom)
-    case TARGET_NR_getrandom:
-        p = lock_user(VERIFY_WRITE, arg1, arg2, 0);
-        if (!p) {
-            return -TARGET_EFAULT;
-        }
-        ret = get_errno(getrandom(p, arg2, arg3));
-        unlock_user(p, arg1, ret);
-        return ret;
-#endif
-#ifdef TARGET_NR_socket
-    case TARGET_NR_socket:
-        return do_socket(arg1, arg2, arg3);
-#endif
-#ifdef TARGET_NR_socketpair
-    case TARGET_NR_socketpair:
-        return do_socketpair(arg1, arg2, arg3, arg4);
-#endif
-#ifdef TARGET_NR_setsockopt
-    case TARGET_NR_setsockopt:
-        return do_setsockopt(arg1, arg2, arg3, arg4, (socklen_t) arg5);
-#endif
 #if defined(TARGET_NR_syslog)
     case TARGET_NR_syslog:
         {
@@ -12878,6 +12899,7 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(getppid);
 #endif
         SYSCALL(getpriority);
+        SYSCALL(getrandom);
         SYSCALL(getrlimit);
         SYSCALL(getrusage);
 #ifdef TARGET_NR_getsockname
@@ -12986,6 +13008,9 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_sgetmask
         SYSCALL(sgetmask);
 #endif
+#ifdef TARGET_NR_shutdown
+        SYSCALL(shutdown);
+#endif
 #ifdef TARGET_NR_select
 # ifdef TARGET_WANT_NI_OLD_SELECT
         SYSCALL_WITH(select, enosys);
@@ -13009,6 +13034,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(setpgid);
         SYSCALL(setpriority);
         SYSCALL(setrlimit);
+#ifdef TARGET_NR_setsockopt
+        SYSCALL(setsockopt);
+#endif
         SYSCALL(settimeofday);
         SYSCALL(setsid);
 #ifdef TARGET_NR_sigaction
@@ -13026,9 +13054,15 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_sigsuspend
         SYSCALL(sigsuspend);
 #endif
+#ifdef TARGET_NR_socket
+        SYSCALL(socket);
+#endif
 #ifdef TARGET_NR_socketcall
         SYSCALL(socketcall);
 #endif
+#ifdef TARGET_NR_socketpair
+        SYSCALL(socketpair);
+#endif
 #ifdef TARGET_NR_ssetmask
         SYSCALL(ssetmask);
 #endif
-- 
2.17.1
