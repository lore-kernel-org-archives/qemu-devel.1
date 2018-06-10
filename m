Received: from eggs.gnu.org ([2001:4830:134:3::10]:41431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfo-0004Su-Cn
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfm-0004hU-V3
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:44 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:38123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfm-0004hC-MX
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:42 -0400
Received: by mail-pf0-x242.google.com with SMTP id b74-v6so8494801pfl.5
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:07 -1000
Message-Id: <20180610030220.3777-96-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 095/108] linux-user: Split out mq syscalls
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

This includes mq_getsetattr, mq_open, mq_timedreceive, mq_timedsend,
and mq_unlink.  All targets define these syscalls; remove the ifdefs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 211 +++++++++++++++++++++++--------------------
 1 file changed, 112 insertions(+), 99 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a540c1455b..0c312cd156 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -77,6 +77,7 @@
 #ifdef CONFIG_INOTIFY
 #include <sys/inotify.h>
 #endif
+#include <mqueue.h>
 
 #define termios host_termios
 #define winsize host_winsize
@@ -1000,12 +1001,10 @@ static int safe_semtimedop(int semid, struct sembuf *tsops, unsigned nsops,
                     (long)timeout);
 }
 #endif
-#if defined(TARGET_NR_mq_open) && defined(__NR_mq_open)
 safe_syscall5(int, mq_timedsend, int, mqdes, const char *, msg_ptr,
               size_t, len, unsigned, prio, const struct timespec *, timeout)
 safe_syscall5(int, mq_timedreceive, int, mqdes, char *, msg_ptr,
               size_t, len, unsigned *, prio, const struct timespec *, timeout)
-#endif
 /* We do ioctl like this rather than via safe_syscall3 to preserve the
  * "third argument might be integer or pointer or not present" behaviour of
  * the libc function.
@@ -1382,9 +1381,6 @@ static inline abi_long copy_from_user_timezone(struct timezone *tz,
     return 0;
 }
 
-#if defined(TARGET_NR_mq_open) && defined(__NR_mq_open)
-#include <mqueue.h>
-
 static inline abi_long copy_from_user_mq_attr(struct mq_attr *attr,
                                               abi_ulong target_mq_attr_addr)
 {
@@ -1422,7 +1418,6 @@ static inline abi_long copy_to_user_mq_attr(abi_ulong target_mq_attr_addr,
 
     return 0;
 }
-#endif
 
 #if defined(TARGET_NR_select) || defined(TARGET_NR__newselect)
 /* do_select() must return target values and target errnos. */
@@ -9836,6 +9831,112 @@ IMPL(mprotect)
     return get_errno(target_mprotect(arg1, arg2, arg3));
 }
 
+IMPL(mq_getsetattr)
+{
+    struct mq_attr in, out;
+    abi_long ret = 0;
+
+    if (arg2 != 0) {
+        ret = copy_from_user_mq_attr(&in, arg2);
+        if (ret) {
+            return ret;
+        }
+        ret = get_errno(mq_setattr(arg1, &in, &out));
+    } else if (arg3 != 0) {
+        ret = get_errno(mq_getattr(arg1, &out));
+    }
+    if (ret == 0 && arg3 != 0) {
+        ret = copy_to_user_mq_attr(arg3, &out);
+    }
+    return ret;
+}
+
+IMPL(mq_open)
+{
+    struct mq_attr posix_mq_attr;
+    struct mq_attr *pposix_mq_attr;
+    int host_flags;
+    abi_long ret;
+    char *p;
+
+    host_flags = target_to_host_bitmask(arg2, fcntl_flags_tbl);
+    pposix_mq_attr = NULL;
+    if (arg4) {
+        if (copy_from_user_mq_attr(&posix_mq_attr, arg4) != 0) {
+            return -TARGET_EFAULT;
+        }
+        pposix_mq_attr = &posix_mq_attr;
+    }
+    p = lock_user_string(arg1 - 1);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(mq_open(p, host_flags, arg3, pposix_mq_attr));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+
+IMPL(mq_timedreceive)
+{
+    struct timespec ts;
+    unsigned int prio;
+    abi_long ret;
+    void *p;
+
+    p = lock_user(VERIFY_READ, arg2, arg3, 1);
+    if (arg5 != 0) {
+        ret = target_to_host_timespec(&ts, arg5);
+        if (ret == 0) {
+            ret = get_errno(safe_mq_timedreceive(arg1, p, arg3, &prio, &ts));
+            if (ret == 0) {
+                ret = host_to_target_timespec(arg5, &ts);
+            }
+        }
+    } else {
+        ret = get_errno(safe_mq_timedreceive(arg1, p, arg3, &prio, NULL));
+    }
+    unlock_user(p, arg2, arg3);
+    if (ret == 0 && arg4 != 0) {
+        ret = put_user_u32(prio, arg4);
+    }
+    return ret;
+}
+
+IMPL(mq_timedsend)
+{
+    struct timespec ts;
+    abi_long ret;
+    void *p;
+
+    p = lock_user(VERIFY_READ, arg2, arg3, 1);
+    if (arg5 != 0) {
+        ret = target_to_host_timespec(&ts, arg5);
+        if (ret == 0) {
+            ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, &ts));
+            if (ret == 0) {
+                ret = host_to_target_timespec(arg5, &ts);
+            }
+        }
+    } else {
+        ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, NULL));
+    }
+    unlock_user(p, arg2, arg3);
+    return ret;
+}
+
+IMPL(mq_unlink)
+{
+    char *p = lock_user_string(arg1 - 1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(mq_unlink(p));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+
 IMPL(mremap)
 {
     return get_errno(target_mremap(arg1, arg2, arg3, arg4, arg5));
@@ -12609,101 +12710,8 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
 {
     CPUState *cpu __attribute__((unused)) = ENV_GET_CPU(cpu_env);
     abi_long ret;
-    void *p;
 
     switch(num) {
-#if defined(TARGET_NR_mq_open) && defined(__NR_mq_open)
-    case TARGET_NR_mq_open:
-        {
-            struct mq_attr posix_mq_attr;
-            struct mq_attr *pposix_mq_attr;
-            int host_flags;
-
-            host_flags = target_to_host_bitmask(arg2, fcntl_flags_tbl);
-            pposix_mq_attr = NULL;
-            if (arg4) {
-                if (copy_from_user_mq_attr(&posix_mq_attr, arg4) != 0) {
-                    return -TARGET_EFAULT;
-                }
-                pposix_mq_attr = &posix_mq_attr;
-            }
-            p = lock_user_string(arg1 - 1);
-            if (!p) {
-                return -TARGET_EFAULT;
-            }
-            ret = get_errno(mq_open(p, host_flags, arg3, pposix_mq_attr));
-            unlock_user (p, arg1, 0);
-        }
-        return ret;
-
-    case TARGET_NR_mq_unlink:
-        p = lock_user_string(arg1 - 1);
-        if (!p) {
-            return -TARGET_EFAULT;
-        }
-        ret = get_errno(mq_unlink(p));
-        unlock_user (p, arg1, 0);
-        return ret;
-
-    case TARGET_NR_mq_timedsend:
-        {
-            struct timespec ts;
-
-            p = lock_user (VERIFY_READ, arg2, arg3, 1);
-            if (arg5 != 0) {
-                target_to_host_timespec(&ts, arg5);
-                ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, &ts));
-                host_to_target_timespec(arg5, &ts);
-            } else {
-                ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, NULL));
-            }
-            unlock_user (p, arg2, arg3);
-        }
-        return ret;
-
-    case TARGET_NR_mq_timedreceive:
-        {
-            struct timespec ts;
-            unsigned int prio;
-
-            p = lock_user (VERIFY_READ, arg2, arg3, 1);
-            if (arg5 != 0) {
-                target_to_host_timespec(&ts, arg5);
-                ret = get_errno(safe_mq_timedreceive(arg1, p, arg3,
-                                                     &prio, &ts));
-                host_to_target_timespec(arg5, &ts);
-            } else {
-                ret = get_errno(safe_mq_timedreceive(arg1, p, arg3,
-                                                     &prio, NULL));
-            }
-            unlock_user (p, arg2, arg3);
-            if (arg4 != 0)
-                put_user_u32(prio, arg4);
-        }
-        return ret;
-
-    /* Not implemented for now... */
-/*     case TARGET_NR_mq_notify: */
-/*         break; */
-
-    case TARGET_NR_mq_getsetattr:
-        {
-            struct mq_attr posix_mq_attr_in, posix_mq_attr_out;
-            ret = 0;
-            if (arg2 != 0) {
-                copy_from_user_mq_attr(&posix_mq_attr_in, arg2);
-                ret = get_errno(mq_setattr(arg1, &posix_mq_attr_in,
-                                           &posix_mq_attr_out));
-            } else if (arg3 != 0) {
-                ret = get_errno(mq_getattr(arg1, &posix_mq_attr_out));
-            }
-            if (ret == 0 && arg3 != 0) {
-                copy_to_user_mq_attr(arg3, &posix_mq_attr_out);
-            }
-        }
-        return ret;
-#endif
-
 #ifdef CONFIG_SPLICE
 #ifdef TARGET_NR_tee
     case TARGET_NR_tee:
@@ -13537,6 +13545,11 @@ static impl_fn *syscall_table(unsigned num)
 #endif
         SYSCALL(mount);
         SYSCALL(mprotect);
+        SYSCALL(mq_getsetattr);
+        SYSCALL(mq_open);
+        SYSCALL(mq_timedreceive);
+        SYSCALL(mq_timedsend);
+        SYSCALL(mq_unlink);
         SYSCALL(mremap);
 #ifdef TARGET_NR_msgctl
         SYSCALL(msgctl);
-- 
2.17.1
