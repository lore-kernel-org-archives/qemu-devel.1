Received: from eggs.gnu.org ([2001:4830:134:3::10]:57660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeX7-0005pr-3W
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeX6-0000lk-0N
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:33 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:39793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeX5-0000kx-P3
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:31 -0400
Received: by mail-pf0-x229.google.com with SMTP id r11-v6so4527377pfl.6
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:43 -0700
Message-Id: <20180601073050.8054-27-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 26/33] linux-user: Split out acct, pipe, pipe2,
 times, umount2
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
 linux-user/syscall.c | 127 +++++++++++++++++++++++++++----------------
 1 file changed, 80 insertions(+), 47 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 36092d753d..bde1f9872f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7912,6 +7912,24 @@ IMPL(access)
 }
 #endif
 
+IMPL(acct)
+{
+    if (arg1 == 0) {
+        return get_errno(acct(NULL));
+    } else {
+        char *fn = lock_user_string(arg1);
+        abi_long ret;
+
+        if (!fn) {
+            return -TARGET_EFAULT;
+        }
+        TRY_INTERP_PATH(ret, fn, acct(fn));
+        ret = get_errno(ret);
+        unlock_user(fn, arg1, 0);
+        return ret;
+    }
+}
+
 #ifdef TARGET_NR_alarm
 IMPL(alarm)
 {
@@ -8529,6 +8547,21 @@ IMPL(pause)
 }
 #endif
 
+#ifdef TARGET_NR_pipe
+IMPL(pipe)
+{
+    return do_pipe(cpu_env, arg1, 0, 0);
+}
+#endif
+
+#ifdef TARGET_NR_pipe2
+IMPL(pipe2)
+{
+    return do_pipe(cpu_env, arg1,
+                   target_to_host_bitmask(arg2, fcntl_flags_tbl), 1);
+}
+#endif
+
 IMPL(read)
 {
     abi_long ret;
@@ -8657,6 +8690,27 @@ IMPL(time)
 }
 #endif
 
+IMPL(times)
+{
+    struct tms tms;
+    abi_long ret = get_errno(times(&tms));
+    if (arg1) {
+        struct target_tms *tmsp
+            = lock_user(VERIFY_WRITE, arg1, sizeof(struct target_tms), 0);
+        if (!tmsp) {
+            return -TARGET_EFAULT;
+        }
+        tmsp->tms_utime = tswapal(host_to_target_clock_t(tms.tms_utime));
+        tmsp->tms_stime = tswapal(host_to_target_clock_t(tms.tms_stime));
+        tmsp->tms_cutime = tswapal(host_to_target_clock_t(tms.tms_cutime));
+        tmsp->tms_cstime = tswapal(host_to_target_clock_t(tms.tms_cstime));
+    }
+    if (!is_error(ret)) {
+        ret = host_to_target_clock_t(ret);
+    }
+    return ret;
+}
+
 #ifdef TARGET_NR_umount
 IMPL(umount)
 {
@@ -8672,6 +8726,21 @@ IMPL(umount)
 }
 #endif
 
+#ifdef TARGET_NR_umount2
+IMPL(umount2)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(umount2(p, arg2));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_unlink
 IMPL(unlink)
 {
@@ -8831,53 +8900,6 @@ IMPL(everything_else)
     char *fn;
 
     switch(num) {
-#ifdef TARGET_NR_pipe
-    case TARGET_NR_pipe:
-        return do_pipe(cpu_env, arg1, 0, 0);
-#endif
-#ifdef TARGET_NR_pipe2
-    case TARGET_NR_pipe2:
-        return do_pipe(cpu_env, arg1,
-                       target_to_host_bitmask(arg2, fcntl_flags_tbl), 1);
-#endif
-    case TARGET_NR_times:
-        {
-            struct target_tms *tmsp;
-            struct tms tms;
-            ret = get_errno(times(&tms));
-            if (arg1) {
-                tmsp = lock_user(VERIFY_WRITE, arg1, sizeof(struct target_tms), 0);
-                if (!tmsp)
-                    return -TARGET_EFAULT;
-                tmsp->tms_utime = tswapal(host_to_target_clock_t(tms.tms_utime));
-                tmsp->tms_stime = tswapal(host_to_target_clock_t(tms.tms_stime));
-                tmsp->tms_cutime = tswapal(host_to_target_clock_t(tms.tms_cutime));
-                tmsp->tms_cstime = tswapal(host_to_target_clock_t(tms.tms_cstime));
-            }
-            if (!is_error(ret))
-                ret = host_to_target_clock_t(ret);
-        }
-        return ret;
-    case TARGET_NR_acct:
-        if (arg1 == 0) {
-            ret = get_errno(acct(NULL));
-        } else {
-            if (!(fn = lock_user_string(arg1))) {
-                return -TARGET_EFAULT;
-            }
-            TRY_INTERP_PATH(ret, fn, acct(fn));
-            ret = get_errno(ret);
-            unlock_user(fn, arg1, 0);
-        }
-        return ret;
-#ifdef TARGET_NR_umount2
-    case TARGET_NR_umount2:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(umount2(p, arg2));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
     case TARGET_NR_ioctl:
         return do_ioctl(arg1, arg2, arg3);
 #ifdef TARGET_NR_fcntl
@@ -12937,6 +12959,7 @@ static impl_fn * const syscall_table[] = {
 #ifdef TARGET_NR_access
     [TARGET_NR_access] = impl_access,
 #endif
+    [TARGET_NR_acct] = impl_acct,
 #ifdef TARGET_NR_alarm
     [TARGET_NR_alarm] = impl_alarm,
 #endif
@@ -13003,6 +13026,12 @@ static impl_fn * const syscall_table[] = {
 #endif
 #ifdef TARGET_NR_pause
     [TARGET_NR_pause] = impl_pause,
+#endif
+#ifdef TARGET_NR_pipe
+    [TARGET_NR_pipe] = impl_pipe,
+#endif
+#ifdef TARGET_NR_pipe2
+    [TARGET_NR_pipe2] = impl_pipe2,
 #endif
     [TARGET_NR_read] = impl_read,
 #ifdef TARGET_NR_rename
@@ -13027,9 +13056,13 @@ static impl_fn * const syscall_table[] = {
 #ifdef TARGET_NR_time
     [TARGET_NR_time] = impl_time,
 #endif
+    [TARGET_NR_times] = impl_times,
 #ifdef TARGET_NR_umount
     [TARGET_NR_umount] = impl_umount,
 #endif
+#ifdef TARGET_NR_umount2
+    [TARGET_NR_umount2] = impl_umount2,
+#endif
 #ifdef TARGET_NR_unlink
     [TARGET_NR_unlink] = impl_unlink,
 #endif
-- 
2.17.0
