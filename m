Received: from eggs.gnu.org ([2001:4830:134:3::10]:57599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeX2-0005mN-HM
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeX0-0000fp-9G
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:28 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeX0-0000eX-1q
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:26 -0400
Received: by mail-pg0-x244.google.com with SMTP id e11-v6so1684922pgq.0
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:39 -0700
Message-Id: <20180601073050.8054-23-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 22/33] linux-user: Split out alarm, pause, stime,
 utime, utimes
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
 linux-user/syscall.c | 156 ++++++++++++++++++++++++++-----------------
 1 file changed, 94 insertions(+), 62 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 53eac58ec0..b3838c5161 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7894,6 +7894,13 @@ IMPL(enosys)
     return do_unimplemented(num);
 }
 
+#ifdef TARGET_NR_alarm
+IMPL(alarm)
+{
+    return alarm(arg1);
+}
+#endif
+
 IMPL(brk)
 {
     return do_brk(arg1);
@@ -8379,6 +8386,18 @@ IMPL(open_by_handle_at)
 }
 #endif
 
+#ifdef TARGET_NR_pause
+IMPL(pause)
+{
+    CPUState *cpu = ENV_GET_CPU(cpu_env);
+
+    if (!block_signals()) {
+        sigsuspend(&((TaskState *)cpu->opaque)->signal_mask);
+    }
+    return -TARGET_EINTR;
+}
+#endif
+
 IMPL(read)
 {
     abi_long ret;
@@ -8402,6 +8421,17 @@ IMPL(read)
     return ret;
 }
 
+#ifdef TARGET_NR_stime
+IMPL(stime)
+{
+    time_t host_time;
+    if (get_user_sal(host_time, arg1)) {
+        return -TARGET_EFAULT;
+    }
+    return get_errno(stime(&host_time));
+}
+#endif
+
 #ifdef TARGET_NR_time
 IMPL(time)
 {
@@ -8463,6 +8493,55 @@ IMPL(unlinkat)
 }
 #endif
 
+#ifdef TARGET_NR_utime
+IMPL(utime)
+{
+    struct utimbuf tbuf;
+    char *p;
+    abi_long ret;
+
+    if (arg2) {
+        struct target_utimbuf *target_tbuf;
+        if (!lock_user_struct(VERIFY_READ, target_tbuf, arg2, 1)) {
+            return -TARGET_EFAULT;
+        }
+        tbuf.actime = tswapal(target_tbuf->actime);
+        tbuf.modtime = tswapal(target_tbuf->modtime);
+        unlock_user_struct(target_tbuf, arg2, 0);
+    }
+    p = lock_user_string(arg1);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(utime(p, arg2 ? &tbuf : NULL));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
+#ifdef TARGET_NR_utimes
+IMPL(utimes)
+{
+    struct timeval tv[2];
+    char *p;
+    abi_long ret;
+
+    if (arg2 &&
+        (copy_from_user_timeval(&tv[0], arg2) ||
+         copy_from_user_timeval(&tv[1],
+                                arg2 + sizeof(struct target_timeval)))) {
+        return -TARGET_EFAULT;
+    }
+    p = lock_user_string(arg1);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(utimes(p, arg2 ? tv : NULL));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_waitid
 IMPL(waitid)
 {
@@ -8539,68 +8618,6 @@ IMPL(everything_else)
     char *fn;
 
     switch(num) {
-#ifdef TARGET_NR_stime /* not on alpha */
-    case TARGET_NR_stime:
-        {
-            time_t host_time;
-            if (get_user_sal(host_time, arg1))
-                return -TARGET_EFAULT;
-            return get_errno(stime(&host_time));
-        }
-#endif
-#ifdef TARGET_NR_alarm /* not on alpha */
-    case TARGET_NR_alarm:
-        return alarm(arg1);
-#endif
-#ifdef TARGET_NR_pause /* not on alpha */
-    case TARGET_NR_pause:
-        if (!block_signals()) {
-            sigsuspend(&((TaskState *)cpu->opaque)->signal_mask);
-        }
-        return -TARGET_EINTR;
-#endif
-#ifdef TARGET_NR_utime
-    case TARGET_NR_utime:
-        {
-            struct utimbuf tbuf, *host_tbuf;
-            struct target_utimbuf *target_tbuf;
-            if (arg2) {
-                if (!lock_user_struct(VERIFY_READ, target_tbuf, arg2, 1))
-                    return -TARGET_EFAULT;
-                tbuf.actime = tswapal(target_tbuf->actime);
-                tbuf.modtime = tswapal(target_tbuf->modtime);
-                unlock_user_struct(target_tbuf, arg2, 0);
-                host_tbuf = &tbuf;
-            } else {
-                host_tbuf = NULL;
-            }
-            if (!(p = lock_user_string(arg1)))
-                return -TARGET_EFAULT;
-            ret = get_errno(utime(p, host_tbuf));
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_utimes
-    case TARGET_NR_utimes:
-        {
-            struct timeval *tvp, tv[2];
-            if (arg2) {
-                if (copy_from_user_timeval(&tv[0], arg2)
-                    || copy_from_user_timeval(&tv[1],
-                                              arg2 + sizeof(struct target_timeval)))
-                    return -TARGET_EFAULT;
-                tvp = tv;
-            } else {
-                tvp = NULL;
-            }
-            if (!(p = lock_user_string(arg1)))
-                return -TARGET_EFAULT;
-            ret = get_errno(utimes(p, tvp));
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
-#endif
 #if defined(TARGET_NR_futimesat)
     case TARGET_NR_futimesat:
         if (is_hostfd(arg1)) {
@@ -12856,6 +12873,9 @@ IMPL(everything_else)
 }
 
 static impl_fn * const syscall_table[] = {
+#ifdef TARGET_NR_alarm
+    [TARGET_NR_alarm] = impl_alarm,
+#endif
     [TARGET_NR_brk] = impl_brk,
     [TARGET_NR_close] = impl_close,
     [TARGET_NR_chdir] = impl_chdir,
@@ -12899,8 +12919,14 @@ static impl_fn * const syscall_table[] = {
     [TARGET_NR_openat] = impl_openat,
 #if defined(TARGET_NR_open_by_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     [TARGET_NR_open_by_handle_at] = impl_open_by_handle_at,
+#endif
+#ifdef TARGET_NR_pause
+    [TARGET_NR_pause] = impl_pause,
 #endif
     [TARGET_NR_read] = impl_read,
+#ifdef TARGET_NR_stime
+    [TARGET_NR_stime] = impl_stime,
+#endif
 #ifdef TARGET_NR_time
     [TARGET_NR_time] = impl_time,
 #endif
@@ -12913,6 +12939,12 @@ static impl_fn * const syscall_table[] = {
 #if TARGET_NR_unlinkat
     [TARGET_NR_unlinkat] = impl_unlinkat,
 #endif
+#ifdef TARGET_NR_utime
+    [TARGET_NR_utime] = impl_utime,
+#endif
+#ifdef TARGET_NR_utimes
+    [TARGET_NR_utimes] = impl_utimes,
+#endif
 #ifdef TARGET_NR_waitid
     [TARGET_NR_waitid] = impl_waitid,
 #endif
-- 
2.17.0
