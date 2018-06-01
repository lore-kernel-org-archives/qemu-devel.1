Received: from eggs.gnu.org ([2001:4830:134:3::10]:57618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeX3-0005mz-5m
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeX1-0000hS-QX
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:29 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:35085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeX1-0000gr-Iu
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:27 -0400
Received: by mail-pf0-x244.google.com with SMTP id x9-v6so12086382pfm.2
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:40 -0700
Message-Id: <20180601073050.8054-24-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 23/33] linux-user: Split out access, faccessat,
 futimesat, kill, nice, sync, syncfs
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
 linux-user/syscall.c | 179 +++++++++++++++++++++++++++----------------
 1 file changed, 113 insertions(+), 66 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b3838c5161..2a172e24eb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7894,6 +7894,24 @@ IMPL(enosys)
     return do_unimplemented(num);
 }
 
+#ifdef TARGET_NR_access
+IMPL(access)
+{
+    char *fn = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!fn) {
+        return -TARGET_EFAULT;
+    }
+    TRY_INTERP_FD(ret, fn,
+                  faccessat(interp_dirfd, fn + 1, arg2, 0),
+                  access(fn, arg2));
+    ret = get_errno(ret);
+    unlock_user(fn, arg1, 0);
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_alarm
 IMPL(alarm)
 {
@@ -8106,6 +8124,28 @@ IMPL(exit)
     g_assert_not_reached();
 }
 
+#ifdef TARGET_NR_faccessat
+IMPL(faccessat)
+{
+    char *fn;
+    abi_long ret;
+
+    if (is_hostfd(arg1)) {
+        return -TARGET_EBADF;
+    }
+    fn = lock_user_string(arg2);
+    if (!fn) {
+        return -TARGET_EFAULT;
+    }
+    TRY_INTERP_FD(ret, fn,
+                  faccessat(interp_dirfd, fn + 1, arg3, 0),
+                  faccessat(arg1, fn, arg3, 0));
+    ret = get_errno(ret);
+    unlock_user(fn, arg2, 0);
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_fork
 IMPL(fork)
 {
@@ -8113,6 +8153,37 @@ IMPL(fork)
 }
 #endif
 
+#ifdef TARGET_NR_futimesat
+IMPL(futimesat)
+{
+    struct timeval tv[2], *tvp = NULL;
+    char *fn;
+    abi_long ret;
+
+    if (is_hostfd(arg1)) {
+        return -TARGET_EBADF;
+    }
+    if (arg3) {
+        if (copy_from_user_timeval(&tv[0], arg3) ||
+            copy_from_user_timeval(&tv[1],
+                                   arg3 + sizeof(struct target_timeval))) {
+            return -TARGET_EFAULT;
+        }
+        tvp = tv;
+    }
+    fn = lock_user_string(arg2);
+    if (!fn) {
+        return -TARGET_EFAULT;
+    }
+    TRY_INTERP_FD(ret, fn,
+                  futimesat(interp_dirfd, fn + 1, tvp),
+                  futimesat(arg1, fn, tvp));
+    ret = get_errno(ret);
+    unlock_user(fn, arg2, 0);
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_getpid
 IMPL(getpid)
 {
@@ -8128,6 +8199,11 @@ IMPL(getxpid)
 }
 #endif
 
+IMPL(kill)
+{
+    return get_errno(safe_kill(arg1, target_to_host_signal(arg2)));
+}
+
 #ifdef TARGET_NR_link
 IMPL(link)
 {
@@ -8309,6 +8385,13 @@ IMPL(name_to_handle_at)
 }
 #endif
 
+#ifdef TARGET_NR_nice
+IMPL(nice)
+{
+    return get_errno(nice(arg1));
+}
+#endif
+
 #ifdef TARGET_NR_open
 IMPL(open)
 {
@@ -8432,6 +8515,19 @@ IMPL(stime)
 }
 #endif
 
+IMPL(sync)
+{
+    sync();
+    return 0;
+}
+
+#if defined(TARGET_NR_syncfs) && defined(CONFIG_SYNCFS)
+IMPL(syncfs)
+{
+    return get_errno(syncfs(arg1));
+}
+#endif
+
 #ifdef TARGET_NR_time
 IMPL(time)
 {
@@ -8618,72 +8714,6 @@ IMPL(everything_else)
     char *fn;
 
     switch(num) {
-#if defined(TARGET_NR_futimesat)
-    case TARGET_NR_futimesat:
-        if (is_hostfd(arg1)) {
-            return -TARGET_EBADF;
-        } else {
-            struct timeval *tvp, tv[2];
-            if (arg3) {
-                if (copy_from_user_timeval(&tv[0], arg3)
-                    || copy_from_user_timeval(&tv[1],
-                                              arg3 + sizeof(struct target_timeval)))
-                    return -TARGET_EFAULT;
-                tvp = tv;
-            } else {
-                tvp = NULL;
-            }
-            if (!(fn = lock_user_string(arg2))) {
-                return -TARGET_EFAULT;
-            }
-            TRY_INTERP_FD(ret, fn,
-                          futimesat(interp_dirfd, fn + 1, tvp),
-                          futimesat(arg1, fn, tvp));
-            ret = get_errno(ret);
-            unlock_user(fn, arg2, 0);
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_access
-    case TARGET_NR_access:
-        if (!(fn = lock_user_string(arg1))) {
-            return -TARGET_EFAULT;
-        }
-        TRY_INTERP_FD(ret, fn,
-                      faccessat(interp_dirfd, fn + 1, arg2, 0),
-                      access(fn, arg2));
-        ret = get_errno(ret);
-        unlock_user(fn, arg1, 0);
-        return ret;
-#endif
-#if defined(TARGET_NR_faccessat) && defined(__NR_faccessat)
-    case TARGET_NR_faccessat:
-        if (is_hostfd(arg1)) {
-            return -TARGET_EBADF;
-        }
-        if (!(fn = lock_user_string(arg2))) {
-            return -TARGET_EFAULT;
-        }
-        TRY_INTERP_FD(ret, fn,
-                      faccessat(interp_dirfd, fn + 1, arg3, 0),
-                      faccessat(arg1, fn, arg3, 0));
-        ret = get_errno(ret);
-        unlock_user(fn, arg2, 0);
-        return ret;
-#endif
-#ifdef TARGET_NR_nice /* not on alpha */
-    case TARGET_NR_nice:
-        return get_errno(nice(arg1));
-#endif
-    case TARGET_NR_sync:
-        sync();
-        return 0;
-#if defined(TARGET_NR_syncfs) && defined(CONFIG_SYNCFS)
-    case TARGET_NR_syncfs:
-        return get_errno(syncfs(arg1));
-#endif
-    case TARGET_NR_kill:
-        return get_errno(safe_kill(arg1, target_to_host_signal(arg2)));
 #ifdef TARGET_NR_rename
     case TARGET_NR_rename:
         {
@@ -12873,6 +12903,9 @@ IMPL(everything_else)
 }
 
 static impl_fn * const syscall_table[] = {
+#ifdef TARGET_NR_access
+    [TARGET_NR_access] = impl_access,
+#endif
 #ifdef TARGET_NR_alarm
     [TARGET_NR_alarm] = impl_alarm,
 #endif
@@ -12887,15 +12920,22 @@ static impl_fn * const syscall_table[] = {
 #endif
     [TARGET_NR_execve] = impl_execve,
     [TARGET_NR_exit] = impl_exit,
+#ifdef TARGET_NR_faccessat
+    [TARGET_NR_faccessat] = impl_faccessat,
+#endif
 #ifdef TARGET_NR_fork
     [TARGET_NR_fork] = impl_fork,
 #endif
+#ifdef TARGET_NR_futimesat
+    [TARGET_NR_futimesat] = impl_futimesat,
+#endif
 #ifdef TARGET_NR_getpid
     [TARGET_NR_getpid] = impl_getpid,
 #endif
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
     [TARGET_NR_getxpid] = impl_getxpid,
 #endif
+    [TARGET_NR_kill] = impl_kill,
 #ifdef TARGET_NR_link
     [TARGET_NR_link] = impl_link,
 #endif
@@ -12913,6 +12953,9 @@ static impl_fn * const syscall_table[] = {
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     [TARGET_NR_name_to_handle_at] = impl_name_to_handle_at,
 #endif
+#ifdef TARGET_NR_nice
+    [TARGET_NR_nice] = impl_nice,
+#endif
 #ifdef TARGET_NR_open
     [TARGET_NR_open] = impl_open,
 #endif
@@ -12926,6 +12969,10 @@ static impl_fn * const syscall_table[] = {
     [TARGET_NR_read] = impl_read,
 #ifdef TARGET_NR_stime
     [TARGET_NR_stime] = impl_stime,
+#endif
+    [TARGET_NR_sync] = impl_sync,
+#if defined(TARGET_NR_syncfs) && defined(CONFIG_SYNCFS)
+    [TARGET_NR_syncfs] = impl_syncfs,
 #endif
 #ifdef TARGET_NR_time
     [TARGET_NR_time] = impl_time,
-- 
2.17.0
