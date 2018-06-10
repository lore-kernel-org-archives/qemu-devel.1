Received: from eggs.gnu.org ([2001:4830:134:3::10]:40722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeK-00032H-UQ
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeI-0003hD-Bz
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:12 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:44843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqeI-0003go-5l
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:10 -0400
Received: by mail-pg0-x244.google.com with SMTP id p21-v6so8127954pgd.11
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:19 -1000
Message-Id: <20180610030220.3777-48-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 047/108] linux-user: Split out recvmmsg, send,
 sendmmsg, sendmsg, sendto
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
 linux-user/syscall.c | 68 ++++++++++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 18 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 98a982f83f..977f61610c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8954,6 +8954,13 @@ IMPL(recvfrom)
 }
 #endif
 
+#ifdef TARGET_NR_recvmmsg
+IMPL(recvmmsg)
+{
+    return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 0);
+}
+#endif
+
 #ifdef TARGET_NR_recvmsg
 IMPL(recvmsg)
 {
@@ -9288,6 +9295,34 @@ IMPL(select)
 }
 #endif
 
+#ifdef TARGET_NR_send
+IMPL(send)
+{
+    return do_sendto(arg1, arg2, arg3, arg4, 0, 0);
+}
+#endif
+
+#ifdef TARGET_NR_sendmsg
+IMPL(sendmsg)
+{
+    return do_sendrecvmsg(arg1, arg2, arg3, 1);
+}
+#endif
+
+#ifdef TARGET_NR_sendmmsg
+IMPL(sendmmsg)
+{
+    return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 1);
+}
+#endif
+
+#ifdef TARGET_NR_sendto
+IMPL(sendto)
+{
+    return do_sendto(arg1, arg2, arg3, arg4, arg5, arg6);
+}
+#endif
+
 IMPL(sethostname)
 {
     char *p = lock_user_string(arg1);
@@ -10000,24 +10035,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_send
-    case TARGET_NR_send:
-        return do_sendto(arg1, arg2, arg3, arg4, 0, 0);
-#endif
-#ifdef TARGET_NR_sendmsg
-    case TARGET_NR_sendmsg:
-        return do_sendrecvmsg(arg1, arg2, arg3, 1);
-#endif
-#ifdef TARGET_NR_sendmmsg
-    case TARGET_NR_sendmmsg:
-        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 1);
-    case TARGET_NR_recvmmsg:
-        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 0);
-#endif
-#ifdef TARGET_NR_sendto
-    case TARGET_NR_sendto:
-        return do_sendto(arg1, arg2, arg3, arg4, arg5, arg6);
-#endif
 #ifdef TARGET_NR_shutdown
     case TARGET_NR_shutdown:
         return get_errno(shutdown(arg1, arg2));
@@ -12942,6 +12959,9 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_recvfrom
         SYSCALL(recvfrom);
 #endif
+#ifdef TARGET_NR_recvmmsg
+        SYSCALL(recvmmsg);
+#endif
 #ifdef TARGET_NR_recvmsg
         SYSCALL(recvmsg);
 #endif
@@ -12972,6 +12992,18 @@ static impl_fn *syscall_table(unsigned num)
 # else
         SYSCALL(select);
 # endif
+#endif
+#ifdef TARGET_NR_send
+        SYSCALL(send);
+#endif
+#ifdef TARGET_NR_sendmmsg
+        SYSCALL(sendmmsg);
+#endif
+#ifdef TARGET_NR_sendmsg
+        SYSCALL(sendmsg);
+#endif
+#ifdef TARGET_NR_sendto
+        SYSCALL(sendto);
 #endif
         SYSCALL(sethostname);
         SYSCALL(setpgid);
-- 
2.17.1
