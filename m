Received: from eggs.gnu.org ([2001:4830:134:3::10]:41345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfd-0004KM-Kl
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfb-0004c2-L7
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:33 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:40343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfb-0004b4-ET
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:31 -0400
Received: by mail-pl0-x241.google.com with SMTP id t12-v6so10377377plo.7
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:01 -1000
Message-Id: <20180610030220.3777-90-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 089/108] linux-user: Split out clock syscalls
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

This includes clock_getres, clock_gettime, clock_nanosleep, clock_settime.
All targets define all of these; remove the ifdefs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 115 ++++++++++++++++++++++---------------------
 1 file changed, 60 insertions(+), 55 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 285612dfe5..6f19f75c67 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7855,6 +7855,62 @@ IMPL(clock_adjtime)
 }
 #endif
 
+IMPL(clock_getres)
+{
+    struct timespec ts;
+    abi_long ret;
+
+    ret = get_errno(clock_getres(arg1, &ts));
+    if (!is_error(ret)) {
+        ret = host_to_target_timespec(arg2, &ts);
+    }
+    return ret;
+}
+
+IMPL(clock_gettime)
+{
+    struct timespec ts;
+    abi_long ret;
+
+    ret = get_errno(clock_gettime(arg1, &ts));
+    if (!is_error(ret)) {
+        ret = host_to_target_timespec(arg2, &ts);
+    }
+    return ret;
+}
+
+IMPL(clock_nanosleep)
+{
+    struct timespec ts;
+    abi_long ret;
+
+    target_to_host_timespec(&ts, arg3);
+    ret = get_errno(safe_clock_nanosleep(arg1, arg2, &ts, arg4 ? &ts : NULL));
+    if (arg4) {
+        host_to_target_timespec(arg4, &ts);
+    }
+#if defined(TARGET_PPC)
+    /* clock_nanosleep is odd in that it returns positive errno values.
+     * On PPC, CR0 bit 3 should be set in such a situation. */
+    if (ret && ret != -TARGET_ERESTARTSYS) {
+        ((CPUPPCState *)cpu_env)->crf[0] |= 1;
+    }
+#endif
+    return ret;
+}
+
+IMPL(clock_settime)
+{
+    struct timespec ts;
+    abi_long ret;
+
+    ret = target_to_host_timespec(&ts, arg2);
+    if (!is_error(ret)) {
+        ret = get_errno(clock_settime(arg1, &ts));
+    }
+    return ret;
+}
+
 IMPL(clone)
 {
     /* Linux manages to have three different orderings for its
@@ -12504,61 +12560,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_clock_settime
-    case TARGET_NR_clock_settime:
-    {
-        struct timespec ts;
-
-        ret = target_to_host_timespec(&ts, arg2);
-        if (!is_error(ret)) {
-            ret = get_errno(clock_settime(arg1, &ts));
-        }
-        return ret;
-    }
-#endif
-#ifdef TARGET_NR_clock_gettime
-    case TARGET_NR_clock_gettime:
-    {
-        struct timespec ts;
-        ret = get_errno(clock_gettime(arg1, &ts));
-        if (!is_error(ret)) {
-            ret = host_to_target_timespec(arg2, &ts);
-        }
-        return ret;
-    }
-#endif
-#ifdef TARGET_NR_clock_getres
-    case TARGET_NR_clock_getres:
-    {
-        struct timespec ts;
-        ret = get_errno(clock_getres(arg1, &ts));
-        if (!is_error(ret)) {
-            host_to_target_timespec(arg2, &ts);
-        }
-        return ret;
-    }
-#endif
-#ifdef TARGET_NR_clock_nanosleep
-    case TARGET_NR_clock_nanosleep:
-    {
-        struct timespec ts;
-        target_to_host_timespec(&ts, arg3);
-        ret = get_errno(safe_clock_nanosleep(arg1, arg2,
-                                             &ts, arg4 ? &ts : NULL));
-        if (arg4)
-            host_to_target_timespec(arg4, &ts);
-
-#if defined(TARGET_PPC)
-        /* clock_nanosleep is odd in that it returns positive errno values.
-         * On PPC, CR0 bit 3 should be set in such a situation. */
-        if (ret && ret != -TARGET_ERESTARTSYS) {
-            ((CPUPPCState *)cpu_env)->crf[0] |= 1;
-        }
-#endif
-        return ret;
-    }
-#endif
-
 #if defined(TARGET_NR_set_tid_address) && defined(__NR_set_tid_address)
     case TARGET_NR_set_tid_address:
         return get_errno(set_tid_address((int *)g2h(arg1)));
@@ -13292,6 +13293,10 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef CONFIG_CLOCK_ADJTIME
         SYSCALL(clock_adjtime);
 #endif
+        SYSCALL(clock_getres);
+        SYSCALL(clock_gettime);
+        SYSCALL(clock_nanosleep);
+        SYSCALL(clock_settime);
         SYSCALL(clone);
         SYSCALL(close);
         SYSCALL(chdir);
-- 
2.17.1
