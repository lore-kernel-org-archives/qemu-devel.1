Received: from eggs.gnu.org ([2001:4830:134:3::10]:41346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfd-0004KN-LA
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfa-0004aS-6F
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:33 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:44111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfZ-0004ZG-UL
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:30 -0400
Received: by mail-pl0-x241.google.com with SMTP id z9-v6so10387849plk.11
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:00 -1000
Message-Id: <20180610030220.3777-89-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 088/108] linux-user: Split out getdomainname,
 get_thread_area, set_thread_area
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
 linux-user/syscall.c | 92 +++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 43 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c37af32bb6..285612dfe5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9029,6 +9029,21 @@ IMPL(getsockopt)
 }
 #endif
 
+#ifdef TARGET_NR_get_thread_area
+IMPL(get_thread_area)
+{
+# if defined(TARGET_I386) && defined(TARGET_ABI32)
+    return do_get_thread_area(cpu_env, arg1);
+# elif defined(TARGET_M68K)
+    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    TaskState *ts = cpu->opaque;
+    return ts->tp_value;
+# else
+    return -TARGET_ENOSYS;
+# endif
+}
+#endif
+
 IMPL(gettid)
 {
     return get_errno(gettid());
@@ -11480,6 +11495,31 @@ IMPL(setsockopt)
 }
 #endif
 
+#ifdef TARGET_NR_set_thread_area
+IMPL(set_thread_area)
+{
+# if defined(TARGET_MIPS)
+    ((CPUMIPSState *) cpu_env)->active_tc.CP0_UserLocal = arg1;
+    return 0;
+# elif defined(TARGET_CRIS)
+    if (arg1 & 0xff) {
+        return -TARGET_EINVAL;
+    }
+    ((CPUCRISState *) cpu_env)->pregs[PR_PID] = arg1;
+    return 0;
+# elif defined(TARGET_I386) && defined(TARGET_ABI32)
+    return do_set_thread_area(cpu_env, arg1);
+# elif defined(TARGET_M68K)
+    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    TaskState *ts = cpu->opaque;
+    ts->tp_value = arg1;
+    return 0;
+# else
+    return -TARGET_ENOSYS;
+# endif
+}
+#endif
+
 IMPL(settimeofday)
 {
     struct timeval tv;
@@ -12464,49 +12504,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_set_thread_area
-    case TARGET_NR_set_thread_area:
-#if defined(TARGET_MIPS)
-      ((CPUMIPSState *) cpu_env)->active_tc.CP0_UserLocal = arg1;
-      return 0;
-#elif defined(TARGET_CRIS)
-      if (arg1 & 0xff)
-          ret = -TARGET_EINVAL;
-      else {
-          ((CPUCRISState *) cpu_env)->pregs[PR_PID] = arg1;
-          ret = 0;
-      }
-      return ret;
-#elif defined(TARGET_I386) && defined(TARGET_ABI32)
-      return do_set_thread_area(cpu_env, arg1);
-#elif defined(TARGET_M68K)
-      {
-          TaskState *ts = cpu->opaque;
-          ts->tp_value = arg1;
-          return 0;
-      }
-#else
-      return -TARGET_ENOSYS;
-#endif
-#endif
-#ifdef TARGET_NR_get_thread_area
-    case TARGET_NR_get_thread_area:
-#if defined(TARGET_I386) && defined(TARGET_ABI32)
-        return do_get_thread_area(cpu_env, arg1);
-#elif defined(TARGET_M68K)
-        {
-            TaskState *ts = cpu->opaque;
-            return ts->tp_value;
-        }
-#else
-        return -TARGET_ENOSYS;
-#endif
-#endif
-#ifdef TARGET_NR_getdomainname
-    case TARGET_NR_getdomainname:
-        return -TARGET_ENOSYS;
-#endif
-
 #ifdef TARGET_NR_clock_settime
     case TARGET_NR_clock_settime:
     {
@@ -13391,6 +13388,9 @@ static impl_fn *syscall_table(unsigned num)
 #if defined(TARGET_NR_getdents64) && defined(__NR_getdents64)
         SYSCALL(getdents64);
 #endif
+#ifdef TARGET_NR_getdomainname
+        SYSCALL_WITH(getdomainname, enosys);
+#endif
 #ifdef TARGET_NR_getegid
         SYSCALL(getegid);
 #endif
@@ -13452,6 +13452,9 @@ static impl_fn *syscall_table(unsigned num)
 #endif
 #ifdef TARGET_NR_getsockopt
         SYSCALL(getsockopt);
+#endif
+#ifdef TARGET_NR_get_thread_area
+        SYSCALL(get_thread_area);
 #endif
         SYSCALL(gettid);
         SYSCALL(gettimeofday);
@@ -13748,6 +13751,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(setrlimit);
 #ifdef TARGET_NR_setsockopt
         SYSCALL(setsockopt);
+#endif
+#ifdef TARGET_NR_set_thread_area
+        SYSCALL(set_thread_area);
 #endif
         SYSCALL(settimeofday);
         SYSCALL(setsid);
-- 
2.17.1
