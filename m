Received: from eggs.gnu.org ([2001:4830:134:3::10]:40690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeE-0002w8-UM
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeD-0003fr-VA
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:06 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:39881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqeD-0003fX-Oq
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:05 -0400
Received: by mail-pl0-x243.google.com with SMTP id f1-v6so10399814plt.6
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:17 -1000
Message-Id: <20180610030220.3777-46-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 045/108] linux-user: Split out accept,
 accept4, bind, connect
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

All targets define accept4; remove the ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 52 ++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d50c84614e..155da4f523 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7730,6 +7730,18 @@ static abi_long impl_##NAME(void *cpu_env, unsigned num, abi_long arg1,   \
                             abi_long arg5, abi_long arg6, abi_long arg7,  \
                             abi_long arg8)
 
+#ifdef TARGET_NR_accept
+IMPL(accept)
+{
+    return do_accept4(arg1, arg2, arg3, 0);
+}
+#endif
+
+IMPL(accept4)
+{
+    return do_accept4(arg1, arg2, arg3, arg4);
+}
+
 #ifdef TARGET_NR_access
 IMPL(access)
 {
@@ -7769,6 +7781,13 @@ IMPL(alarm)
 }
 #endif
 
+#ifdef TARGET_NR_bind
+IMPL(bind)
+{
+    return do_bind(arg1, arg2, arg3);
+}
+#endif
+
 IMPL(brk)
 {
     return do_brk(arg1);
@@ -7821,6 +7840,13 @@ IMPL(close)
     return get_errno(close(arg1));
 }
 
+#ifdef TARGET_NR_connect
+IMPL(connect)
+{
+    return do_connect(arg1, arg2, arg3);
+}
+#endif
+
 #ifdef TARGET_NR_creat
 IMPL(creat)
 {
@@ -9925,22 +9951,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_accept
-    case TARGET_NR_accept:
-        return do_accept4(arg1, arg2, arg3, 0);
-#endif
-#ifdef TARGET_NR_accept4
-    case TARGET_NR_accept4:
-        return do_accept4(arg1, arg2, arg3, arg4);
-#endif
-#ifdef TARGET_NR_bind
-    case TARGET_NR_bind:
-        return do_bind(arg1, arg2, arg3);
-#endif
-#ifdef TARGET_NR_connect
-    case TARGET_NR_connect:
-        return do_connect(arg1, arg2, arg3);
-#endif
 #ifdef TARGET_NR_getpeername
     case TARGET_NR_getpeername:
         return do_getpeername(arg1, arg2, arg3);
@@ -12769,9 +12779,16 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_access
         SYSCALL(access);
 #endif
+#ifdef TARGET_NR_accept
+        SYSCALL(accept);
+#endif
+        SYSCALL(accept4);
         SYSCALL(acct);
 #ifdef TARGET_NR_alarm
         SYSCALL(alarm);
+#endif
+#ifdef TARGET_NR_bind
+        SYSCALL(bind);
 #endif
         SYSCALL(brk);
         SYSCALL(close);
@@ -12780,6 +12797,9 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_chmod
         SYSCALL(chmod);
 #endif
+#ifdef TARGET_NR_connect
+        SYSCALL(connect);
+#endif
 #ifdef TARGET_NR_creat
         SYSCALL(creat);
 #endif
-- 
2.17.1
