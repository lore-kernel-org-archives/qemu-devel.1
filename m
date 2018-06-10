Received: from eggs.gnu.org ([2001:4830:134:3::10]:40267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdI-000229-87
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdH-0003Jc-8c
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:08 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:41358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqdH-0003JP-3N
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:07 -0400
Received: by mail-pf0-x241.google.com with SMTP id a11-v6so8485301pff.8
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:00:51 -1000
Message-Id: <20180610030220.3777-20-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 019/108] linux-user: Split out getpid,
 getxpid, lseek
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
 linux-user/syscall.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d32034ce38..3d3983a504 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8080,6 +8080,21 @@ IMPL(fork)
 }
 #endif
 
+#ifdef TARGET_NR_getpid
+IMPL(getpid)
+{
+    return get_errno(getpid());
+}
+#endif
+
+#if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
+IMPL(getxpid)
+{
+    ((CPUAlphaState *)cpu_env)->ir[IR_A4] = getppid();
+    return get_errno(getpid());
+}
+#endif
+
 #ifdef TARGET_NR_link
 IMPL(link)
 {
@@ -8110,6 +8125,11 @@ IMPL(linkat)
     return ret;
 }
 
+IMPL(lseek)
+{
+    return get_errno(lseek(arg1, arg2, arg3));
+}
+
 #ifdef TARGET_NR_mknod
 IMPL(mknod)
 {
@@ -8396,18 +8416,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_lseek:
-        return get_errno(lseek(arg1, arg2, arg3));
-#if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
-    /* Alpha specific */
-    case TARGET_NR_getxpid:
-        ((CPUAlphaState *)cpu_env)->ir[IR_A4] = getppid();
-        return get_errno(getpid());
-#endif
-#ifdef TARGET_NR_getpid
-    case TARGET_NR_getpid:
-        return get_errno(getpid());
-#endif
     case TARGET_NR_mount:
         {
             /* need to look at the data field */
@@ -12546,10 +12554,17 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_fork
         SYSCALL(fork);
 #endif
+#ifdef TARGET_NR_getpid
+        SYSCALL(getpid);
+#endif
+#if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
+        SYSCALL(getxpid);
+#endif
 #ifdef TARGET_NR_link
         SYSCALL(link);
 #endif
         SYSCALL(linkat);
+        SYSCALL(lseek);
 #ifdef TARGET_NR_mknod
         SYSCALL(mknod);
 #endif
-- 
2.17.1
