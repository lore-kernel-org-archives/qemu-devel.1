Received: from eggs.gnu.org ([2001:4830:134:3::10]:40763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeP-00037D-DS
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeO-0003jF-68
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:17 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:35910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqeN-0003j3-Tm
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:16 -0400
Received: by mail-pl0-x244.google.com with SMTP id a7-v6so7899611plp.3
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:22 -1000
Message-Id: <20180610030220.3777-51-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 050/108] linux-user: Split out getitimer,
 setitimer, syslog
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

All targets define syslog; remove the ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 155 ++++++++++++++++++++++---------------------
 1 file changed, 79 insertions(+), 76 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 46c7c485fd..c8fc7fc908 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8154,6 +8154,20 @@ IMPL(futimesat)
 }
 #endif
 
+IMPL(getitimer)
+{
+    struct itimerval value;
+    abi_long ret = get_errno(getitimer(arg1, &value));
+
+    if (!is_error(ret) && arg2 &&
+        (copy_to_user_timeval(arg2, &value.it_interval) ||
+         copy_to_user_timeval(arg2 + sizeof(struct target_timeval),
+                              &value.it_value))) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
 #ifdef TARGET_NR_getpeername
 IMPL(getpeername)
 {
@@ -9357,6 +9371,28 @@ IMPL(sethostname)
     return ret;
 }
 
+IMPL(setitimer)
+{
+    struct itimerval ivalue, ovalue;
+    abi_long ret;
+
+    if (arg2 &&
+        (copy_from_user_timeval(&ivalue.it_interval, arg2) ||
+         copy_from_user_timeval(&ivalue.it_value,
+                                arg2 + sizeof(struct target_timeval)))) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(setitimer(arg1, arg2 ? &ivalue : NULL,
+                              arg3 ? &ovalue : NULL));
+    if (!is_error(ret) && arg3 &&
+        (copy_to_user_timeval(arg3, &ovalue.it_interval) ||
+         copy_to_user_timeval(arg3 + sizeof(struct target_timeval),
+                              &ovalue.it_value))) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
 IMPL(setpgid)
 {
     return get_errno(setpgid(arg1, arg2));
@@ -9848,6 +9884,46 @@ IMPL(syncfs)
 }
 #endif
 
+IMPL(syslog)
+{
+    abi_long ret;
+    char *p;
+    int len;
+
+    switch (arg1) {
+    case TARGET_SYSLOG_ACTION_CLOSE:         /* Close log */
+    case TARGET_SYSLOG_ACTION_OPEN:          /* Open log */
+    case TARGET_SYSLOG_ACTION_CLEAR:         /* Clear ring buffer */
+    case TARGET_SYSLOG_ACTION_CONSOLE_OFF:   /* Disable logging */
+    case TARGET_SYSLOG_ACTION_CONSOLE_ON:    /* Enable logging */
+    case TARGET_SYSLOG_ACTION_CONSOLE_LEVEL: /* Set messages level */
+    case TARGET_SYSLOG_ACTION_SIZE_UNREAD:   /* Number of chars */
+    case TARGET_SYSLOG_ACTION_SIZE_BUFFER:   /* Size of the buffer */
+        return get_errno(sys_syslog((int)arg1, NULL, (int)arg3));
+
+    case TARGET_SYSLOG_ACTION_READ:          /* Read from log */
+    case TARGET_SYSLOG_ACTION_READ_CLEAR:    /* Read/clear msgs */
+    case TARGET_SYSLOG_ACTION_READ_ALL:      /* Read last messages */
+        len = arg2;
+        if (len < 0) {
+            return -TARGET_EINVAL;
+        }
+        if (len == 0) {
+            return 0;
+        }
+        p = lock_user(VERIFY_WRITE, arg2, arg3, 0);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(sys_syslog((int)arg1, p, (int)arg3));
+        unlock_user(p, arg2, arg3);
+        return ret;
+
+    default:
+        return -TARGET_EINVAL;
+    }
+}
+
 #ifdef TARGET_NR_time
 IMPL(time)
 {
@@ -10077,82 +10153,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#if defined(TARGET_NR_syslog)
-    case TARGET_NR_syslog:
-        {
-            int len = arg2;
-
-            switch (arg1) {
-            case TARGET_SYSLOG_ACTION_CLOSE:         /* Close log */
-            case TARGET_SYSLOG_ACTION_OPEN:          /* Open log */
-            case TARGET_SYSLOG_ACTION_CLEAR:         /* Clear ring buffer */
-            case TARGET_SYSLOG_ACTION_CONSOLE_OFF:   /* Disable logging */
-            case TARGET_SYSLOG_ACTION_CONSOLE_ON:    /* Enable logging */
-            case TARGET_SYSLOG_ACTION_CONSOLE_LEVEL: /* Set messages level */
-            case TARGET_SYSLOG_ACTION_SIZE_UNREAD:   /* Number of chars */
-            case TARGET_SYSLOG_ACTION_SIZE_BUFFER:   /* Size of the buffer */
-                return get_errno(sys_syslog((int)arg1, NULL, (int)arg3));
-            case TARGET_SYSLOG_ACTION_READ:          /* Read from log */
-            case TARGET_SYSLOG_ACTION_READ_CLEAR:    /* Read/clear msgs */
-            case TARGET_SYSLOG_ACTION_READ_ALL:      /* Read last messages */
-                {
-                    if (len < 0) {
-                        return -TARGET_EINVAL;
-                    }
-                    if (len == 0) {
-                        return 0;
-                    }
-                    p = lock_user(VERIFY_WRITE, arg2, arg3, 0);
-                    if (!p) {
-                        return -TARGET_EFAULT;
-                    }
-                    ret = get_errno(sys_syslog((int)arg1, p, (int)arg3));
-                    unlock_user(p, arg2, arg3);
-                }
-                return ret;
-            default:
-                return -TARGET_EINVAL;
-            }
-        }
-        break;
-#endif
-    case TARGET_NR_setitimer:
-        {
-            struct itimerval value, ovalue, *pvalue;
-
-            if (arg2) {
-                pvalue = &value;
-                if (copy_from_user_timeval(&pvalue->it_interval, arg2)
-                    || copy_from_user_timeval(&pvalue->it_value,
-                                              arg2 + sizeof(struct target_timeval)))
-                    return -TARGET_EFAULT;
-            } else {
-                pvalue = NULL;
-            }
-            ret = get_errno(setitimer(arg1, pvalue, &ovalue));
-            if (!is_error(ret) && arg3) {
-                if (copy_to_user_timeval(arg3,
-                                         &ovalue.it_interval)
-                    || copy_to_user_timeval(arg3 + sizeof(struct target_timeval),
-                                            &ovalue.it_value))
-                    return -TARGET_EFAULT;
-            }
-        }
-        return ret;
-    case TARGET_NR_getitimer:
-        {
-            struct itimerval value;
-
-            ret = get_errno(getitimer(arg1, &value));
-            if (!is_error(ret) && arg2) {
-                if (copy_to_user_timeval(arg2,
-                                         &value.it_interval)
-                    || copy_to_user_timeval(arg2 + sizeof(struct target_timeval),
-                                            &value.it_value))
-                    return -TARGET_EFAULT;
-            }
-        }
-        return ret;
 #ifdef TARGET_NR_stat
     case TARGET_NR_stat:
         if (!(p = lock_user_string(arg1))) {
@@ -12881,6 +12881,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_futimesat
         SYSCALL(futimesat);
 #endif
+        SYSCALL(getitimer);
 #ifdef TARGET_NR_getpeername
         SYSCALL(getpeername);
 #endif
@@ -13026,6 +13027,7 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(sendto);
 #endif
         SYSCALL(sethostname);
+        SYSCALL(setitimer);
         SYSCALL(setpgid);
         SYSCALL(setpriority);
         SYSCALL(setrlimit);
@@ -13077,6 +13079,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef CONFIG_SYNCFS
         SYSCALL(syncfs);
 #endif
+        SYSCALL(syslog);
 #ifdef TARGET_NR_time
         SYSCALL(time);
 #endif
-- 
2.17.1
