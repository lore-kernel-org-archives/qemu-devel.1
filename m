Received: from eggs.gnu.org ([2001:4830:134:3::10]:40703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeH-0002z6-NZ
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeG-0003gQ-Hj
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:09 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:33743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqeG-0003gF-Bk
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:08 -0400
Received: by mail-pl0-x241.google.com with SMTP id n10-v6so10391225plp.0
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:18 -1000
Message-Id: <20180610030220.3777-47-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 046/108] linux-user: Split out 7 syscalls
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

Handle getpeername, getsockname, getsockopt,
listen, recv, recvfrom, recvmsg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 98 +++++++++++++++++++++++++++++++-------------
 1 file changed, 70 insertions(+), 28 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 155da4f523..98a982f83f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8153,6 +8153,13 @@ IMPL(futimesat)
 }
 #endif
 
+#ifdef TARGET_NR_getpeername
+IMPL(getpeername)
+{
+    return do_getpeername(arg1, arg2, arg3);
+}
+#endif
+
 #ifdef TARGET_NR_getpgrp
 IMPL(getpgrp)
 {
@@ -8226,6 +8233,20 @@ IMPL(getrusage)
     return ret;
 }
 
+#ifdef TARGET_NR_getsockname
+IMPL(getsockname)
+{
+    return do_getsockname(arg1, arg2, arg3);
+}
+#endif
+
+#ifdef TARGET_NR_getsockopt
+IMPL(getsockopt)
+{
+    return do_getsockopt(arg1, arg2, arg3, arg4, arg5);
+}
+#endif
+
 IMPL(gettimeofday)
 {
     struct timeval tv;
@@ -8374,6 +8395,13 @@ IMPL(linkat)
     return ret;
 }
 
+#ifdef TARGET_NR_listen
+IMPL(listen)
+{
+    return get_errno(listen(arg1, arg2));
+}
+#endif
+
 IMPL(lseek)
 {
     return get_errno(lseek(arg1, arg2, arg3));
@@ -8912,6 +8940,27 @@ IMPL(reboot)
     return ret;
 }
 
+#ifdef TARGET_NR_recv
+IMPL(recv)
+{
+    return do_recvfrom(arg1, arg2, arg3, arg4, 0, 0);
+}
+#endif
+
+#ifdef TARGET_NR_recvfrom
+IMPL(recvfrom)
+{
+    return do_recvfrom(arg1, arg2, arg3, arg4, arg5, arg6);
+}
+#endif
+
+#ifdef TARGET_NR_recvmsg
+IMPL(recvmsg)
+{
+    return do_sendrecvmsg(arg1, arg2, arg3, 0);
+}
+#endif
+
 #ifdef TARGET_NR_rename
 IMPL(rename)
 {
@@ -9951,34 +10000,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_getpeername
-    case TARGET_NR_getpeername:
-        return do_getpeername(arg1, arg2, arg3);
-#endif
-#ifdef TARGET_NR_getsockname
-    case TARGET_NR_getsockname:
-        return do_getsockname(arg1, arg2, arg3);
-#endif
-#ifdef TARGET_NR_getsockopt
-    case TARGET_NR_getsockopt:
-        return do_getsockopt(arg1, arg2, arg3, arg4, arg5);
-#endif
-#ifdef TARGET_NR_listen
-    case TARGET_NR_listen:
-        return get_errno(listen(arg1, arg2));
-#endif
-#ifdef TARGET_NR_recv
-    case TARGET_NR_recv:
-        return do_recvfrom(arg1, arg2, arg3, arg4, 0, 0);
-#endif
-#ifdef TARGET_NR_recvfrom
-    case TARGET_NR_recvfrom:
-        return do_recvfrom(arg1, arg2, arg3, arg4, arg5, arg6);
-#endif
-#ifdef TARGET_NR_recvmsg
-    case TARGET_NR_recvmsg:
-        return do_sendrecvmsg(arg1, arg2, arg3, 0);
-#endif
 #ifdef TARGET_NR_send
     case TARGET_NR_send:
         return do_sendto(arg1, arg2, arg3, arg4, 0, 0);
@@ -12827,6 +12848,9 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_futimesat
         SYSCALL(futimesat);
 #endif
+#ifdef TARGET_NR_getpeername
+        SYSCALL(getpeername);
+#endif
 #ifdef TARGET_NR_getpgrp
         SYSCALL(getpgrp);
 #endif
@@ -12839,6 +12863,12 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(getpriority);
         SYSCALL(getrlimit);
         SYSCALL(getrusage);
+#ifdef TARGET_NR_getsockname
+        SYSCALL(getsockname);
+#endif
+#ifdef TARGET_NR_getsockopt
+        SYSCALL(getsockopt);
+#endif
         SYSCALL(gettimeofday);
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
         SYSCALL(getxpid);
@@ -12849,6 +12879,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(link);
 #endif
         SYSCALL(linkat);
+#ifdef TARGET_NR_listen
+        SYSCALL(listen);
+#endif
         SYSCALL(lseek);
 #ifdef TARGET_NR_mkdir
         SYSCALL(mkdir);
@@ -12903,6 +12936,15 @@ static impl_fn *syscall_table(unsigned num)
 #endif
         SYSCALL(readlinkat);
         SYSCALL(reboot);
+#ifdef TARGET_NR_recv
+        SYSCALL(recv);
+#endif
+#ifdef TARGET_NR_recvfrom
+        SYSCALL(recvfrom);
+#endif
+#ifdef TARGET_NR_recvmsg
+        SYSCALL(recvmsg);
+#endif
 #ifdef TARGET_NR_rename
         SYSCALL(rename);
 #endif
-- 
2.17.1
