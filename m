Received: from eggs.gnu.org ([2001:4830:134:3::10]:40664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeB-0002st-PC
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqe9-0003eR-5Y
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:03 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:44506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqe8-0003e6-Uy
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:01 -0400
Received: by mail-pf0-x244.google.com with SMTP id h12-v6so8485496pfk.11
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:15 -1000
Message-Id: <20180610030220.3777-44-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 043/108] linux-user: Split out getpriority,
 setpriority
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
 linux-user/syscall.c | 46 +++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 86583988c4..6d8d2eb780 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8241,6 +8241,27 @@ IMPL(getppid)
 }
 #endif
 
+IMPL(getpriority)
+{
+    abi_long ret;
+
+    /* Note that negative values are valid for getpriority, so we must
+       differentiate based on errno settings.  */
+    errno = 0;
+    ret = getpriority(arg1, arg2);
+    if (ret == -1 && errno != 0) {
+        return -host_to_target_errno(errno);
+    }
+#ifdef TARGET_ALPHA
+    /* Return value is the unbiased priority.  Signal no error.  */
+    ((CPUAlphaState *)cpu_env)->ir[IR_V0] = 0;
+    return ret;
+#else
+    /* Return value is a biased priority to avoid negative numbers.  */
+    return 20 - ret;
+#endif
+}
+
 IMPL(getrlimit)
 {
     int resource = target_to_host_resource(arg1);
@@ -9303,6 +9324,11 @@ IMPL(setpgid)
     return get_errno(setpgid(arg1, arg2));
 }
 
+IMPL(setpriority)
+{
+    return get_errno(setpriority(arg1, arg2, arg3));
+}
+
 IMPL(setrlimit)
 {
     int resource = target_to_host_resource(arg1);
@@ -9898,24 +9924,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_getpriority:
-        /* Note that negative values are valid for getpriority, so we must
-           differentiate based on errno settings.  */
-        errno = 0;
-        ret = getpriority(arg1, arg2);
-        if (ret == -1 && errno != 0) {
-            return -host_to_target_errno(errno);
-        }
-#ifdef TARGET_ALPHA
-        /* Return value is the unbiased priority.  Signal no error.  */
-        ((CPUAlphaState *)cpu_env)->ir[IR_V0] = 0;
-#else
-        /* Return value is a biased priority to avoid negative numbers.  */
-        ret = 20 - ret;
-#endif
-        return ret;
-    case TARGET_NR_setpriority:
-        return get_errno(setpriority(arg1, arg2, arg3));
 #ifdef TARGET_NR_socketcall
     case TARGET_NR_socketcall:
         return do_socketcall(arg1, arg2);
@@ -12811,6 +12819,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_getppid
         SYSCALL(getppid);
 #endif
+        SYSCALL(getpriority);
         SYSCALL(getrlimit);
         SYSCALL(getrusage);
         SYSCALL(gettimeofday);
@@ -12907,6 +12916,7 @@ static impl_fn *syscall_table(unsigned num)
 #endif
         SYSCALL(sethostname);
         SYSCALL(setpgid);
+        SYSCALL(setpriority);
         SYSCALL(setrlimit);
         SYSCALL(settimeofday);
         SYSCALL(setsid);
-- 
2.17.1
