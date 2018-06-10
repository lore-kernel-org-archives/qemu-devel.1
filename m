Received: from eggs.gnu.org ([2001:4830:134:3::10]:41583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqg6-0004lM-5R
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqg5-0004rJ-7i
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:06:02 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:41358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqg5-0004r8-2E
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:06:01 -0400
Received: by mail-pg0-x244.google.com with SMTP id l65-v6so8133692pgl.8
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:06:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:17 -1000
Message-Id: <20180610030220.3777-106-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 105/108] linux-user: Split out timerfd
 syscalls
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

This includes timerfd_create, timerfd_gettime, timerfd_settime.
All targets define all of these; remove the ifdefs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 83 +++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 43 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0f12a945ea..c0752ad6e0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12789,6 +12789,41 @@ IMPL(timer_settime)
     return ret;
 }
 
+#ifdef CONFIG_TIMERFD
+IMPL(timerfd_create)
+{
+    int host_flags = target_to_host_bitmask(arg2, fcntl_flags_tbl);
+    return get_errno(timerfd_create(arg1, host_flags));
+}
+
+IMPL(timerfd_gettime)
+{
+    struct itimerspec its_curr;
+    abi_long ret;
+
+    ret = get_errno(timerfd_gettime(arg1, &its_curr));
+    if (!ret && host_to_target_itimerspec(arg2, &its_curr)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
+IMPL(timerfd_settime)
+{
+    struct itimerspec its_new, its_old;
+    abi_long ret;
+
+    if (target_to_host_itimerspec(&its_new, arg3)) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(timerfd_settime(arg1, arg2, &its_new, &its_old));
+    if (!ret && arg4 && host_to_target_itimerspec(arg4, &its_old)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif /* CONFIG_TIMERFD */
+
 IMPL(tkill)
 {
     return get_errno(safe_tkill((int)arg1, target_to_host_signal(arg2)));
@@ -13152,49 +13187,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     abi_long ret;
 
     switch(num) {
-#if defined(TARGET_NR_timerfd_create) && defined(CONFIG_TIMERFD)
-    case TARGET_NR_timerfd_create:
-        return get_errno(timerfd_create(arg1,
-                          target_to_host_bitmask(arg2, fcntl_flags_tbl)));
-#endif
-
-#if defined(TARGET_NR_timerfd_gettime) && defined(CONFIG_TIMERFD)
-    case TARGET_NR_timerfd_gettime:
-        {
-            struct itimerspec its_curr;
-
-            ret = get_errno(timerfd_gettime(arg1, &its_curr));
-
-            if (arg2 && host_to_target_itimerspec(arg2, &its_curr)) {
-                return -TARGET_EFAULT;
-            }
-        }
-        return ret;
-#endif
-
-#if defined(TARGET_NR_timerfd_settime) && defined(CONFIG_TIMERFD)
-    case TARGET_NR_timerfd_settime:
-        {
-            struct itimerspec its_new, its_old, *p_new;
-
-            if (arg3) {
-                if (target_to_host_itimerspec(&its_new, arg3)) {
-                    return -TARGET_EFAULT;
-                }
-                p_new = &its_new;
-            } else {
-                p_new = NULL;
-            }
-
-            ret = get_errno(timerfd_settime(arg1, arg2, p_new, &its_old));
-
-            if (arg4 && host_to_target_itimerspec(arg4, &its_old)) {
-                return -TARGET_EFAULT;
-            }
-        }
-        return ret;
-#endif
-
 #if defined(TARGET_NR_ioprio_get) && defined(__NR_ioprio_get)
     case TARGET_NR_ioprio_get:
         return get_errno(ioprio_get(arg1, arg2));
@@ -13896,6 +13888,11 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(timer_getoverrun);
         SYSCALL(timer_gettime);
         SYSCALL(timer_settime);
+#ifdef CONFIG_TIMERFD
+        SYSCALL(timerfd_create);
+        SYSCALL(timerfd_gettime);
+        SYSCALL(timerfd_settime);
+#endif
         SYSCALL(tkill);
         SYSCALL(truncate);
 #ifdef TARGET_NR_truncate64
-- 
2.17.1
