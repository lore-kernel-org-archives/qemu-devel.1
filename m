Received: from eggs.gnu.org ([2001:4830:134:3::10]:40546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdt-0002aC-16
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdp-0003YR-TY
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:45 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:43002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqdp-0003YF-Lf
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:41 -0400
Received: by mail-pf0-x231.google.com with SMTP id w7-v6so8478356pfn.9
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:06 -1000
Message-Id: <20180610030220.3777-35-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 034/108] linux-user: Split out getrlimit,
 getrusage, gettimeofday, settimeofday
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
 linux-user/syscall.c | 117 ++++++++++++++++++++++---------------------
 1 file changed, 61 insertions(+), 56 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ac3592d776..4c5292efed 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8152,6 +8152,49 @@ IMPL(getppid)
 }
 #endif
 
+IMPL(getrlimit)
+{
+    int resource = target_to_host_resource(arg1);
+    struct target_rlimit *target_rlim;
+    struct rlimit rlim;
+    abi_long ret;
+
+    ret = get_errno(getrlimit(resource, &rlim));
+    if (!is_error(ret)) {
+        if (!lock_user_struct(VERIFY_WRITE, target_rlim, arg2, 0)) {
+            return -TARGET_EFAULT;
+        }
+        target_rlim->rlim_cur = host_to_target_rlim(rlim.rlim_cur);
+        target_rlim->rlim_max = host_to_target_rlim(rlim.rlim_max);
+        unlock_user_struct(target_rlim, arg2, 1);
+    }
+    return ret;
+}
+
+IMPL(getrusage)
+{
+    struct rusage rusage;
+    abi_long ret;
+
+    ret = get_errno(getrusage(arg1, &rusage));
+    if (!is_error(ret) && host_to_target_rusage(arg2, &rusage)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
+IMPL(gettimeofday)
+{
+    struct timeval tv;
+    abi_long ret;
+
+    ret = get_errno(gettimeofday(&tv, NULL));
+    if (!is_error(ret) && copy_to_user_timeval(arg1, &tv)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
 IMPL(getxpid)
 {
@@ -8910,6 +8953,20 @@ IMPL(setrlimit)
     return get_errno(setrlimit(resource, &rlim));
 }
 
+IMPL(settimeofday)
+{
+    struct timeval tv;
+    struct timezone tz;
+
+    if (arg1 && copy_from_user_timeval(&tv, arg1)) {
+        return -TARGET_EFAULT;
+    }
+    if (arg2 && copy_from_user_timezone(&tz, arg2)) {
+        return -TARGET_EFAULT;
+    }
+    return get_errno(settimeofday(arg1 ? &tv : NULL, arg2 ? &tz : NULL));
+}
+
 IMPL(setsid)
 {
     return get_errno(setsid());
@@ -9385,62 +9442,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_getrlimit:
-        {
-            int resource = target_to_host_resource(arg1);
-            struct target_rlimit *target_rlim;
-            struct rlimit rlim;
-
-            ret = get_errno(getrlimit(resource, &rlim));
-            if (!is_error(ret)) {
-                if (!lock_user_struct(VERIFY_WRITE, target_rlim, arg2, 0))
-                    return -TARGET_EFAULT;
-                target_rlim->rlim_cur = host_to_target_rlim(rlim.rlim_cur);
-                target_rlim->rlim_max = host_to_target_rlim(rlim.rlim_max);
-                unlock_user_struct(target_rlim, arg2, 1);
-            }
-        }
-        return ret;
-    case TARGET_NR_getrusage:
-        {
-            struct rusage rusage;
-            ret = get_errno(getrusage(arg1, &rusage));
-            if (!is_error(ret)) {
-                ret = host_to_target_rusage(arg2, &rusage);
-            }
-        }
-        return ret;
-    case TARGET_NR_gettimeofday:
-        {
-            struct timeval tv;
-            ret = get_errno(gettimeofday(&tv, NULL));
-            if (!is_error(ret)) {
-                if (copy_to_user_timeval(arg1, &tv))
-                    return -TARGET_EFAULT;
-            }
-        }
-        return ret;
-    case TARGET_NR_settimeofday:
-        {
-            struct timeval tv, *ptv = NULL;
-            struct timezone tz, *ptz = NULL;
-
-            if (arg1) {
-                if (copy_from_user_timeval(&tv, arg1)) {
-                    return -TARGET_EFAULT;
-                }
-                ptv = &tv;
-            }
-
-            if (arg2) {
-                if (copy_from_user_timezone(&tz, arg2)) {
-                    return -TARGET_EFAULT;
-                }
-                ptz = &tz;
-            }
-
-            return get_errno(settimeofday(ptv, ptz));
-        }
 #if defined(TARGET_NR_select)
     case TARGET_NR_select:
 #if defined(TARGET_WANT_NI_OLD_SELECT)
@@ -12737,6 +12738,9 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_getppid
         SYSCALL(getppid);
 #endif
+        SYSCALL(getrlimit);
+        SYSCALL(getrusage);
+        SYSCALL(gettimeofday);
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
         SYSCALL(getxpid);
 #endif
@@ -12801,6 +12805,7 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(sethostname);
         SYSCALL(setpgid);
         SYSCALL(setrlimit);
+        SYSCALL(settimeofday);
         SYSCALL(setsid);
 #ifdef TARGET_NR_sigaction
         SYSCALL(sigaction);
-- 
2.17.1
