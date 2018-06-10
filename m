Received: from eggs.gnu.org ([2001:4830:134:3::10]:40388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdW-0002D1-BY
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdV-0003Pq-42
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:22 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:35651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqdU-0003PS-SR
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:21 -0400
Received: by mail-pl0-x243.google.com with SMTP id k1-v6so1987035plt.2
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:00:57 -1000
Message-Id: <20180610030220.3777-26-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 025/108] linux-user: Split out acct, pipe,
 pipe2, times, umount2
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

All targets define pipe2 and umount2; remove the ifdefs.
Merge do_pipe2 into its only user.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 148 +++++++++++++++++++++++++------------------
 1 file changed, 88 insertions(+), 60 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f22d45d2cb..81e142f091 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1561,24 +1561,25 @@ static abi_long do_old_select(abi_ulong arg1)
 #endif
 #endif
 
-static abi_long do_pipe2(int host_pipe[], int flags)
-{
-#ifdef CONFIG_PIPE2
-    return pipe2(host_pipe, flags);
-#else
-    return -ENOSYS;
-#endif
-}
-
 static abi_long do_pipe(void *cpu_env, abi_ulong pipedes,
                         int flags, int is_pipe2)
 {
     int host_pipe[2];
     abi_long ret;
-    ret = flags ? do_pipe2(host_pipe, flags) : pipe(host_pipe);
 
-    if (is_error(ret))
-        return get_errno(ret);
+    if (flags) {
+#ifdef CONFIG_PIPE2
+        ret = pipe2(host_pipe, flags);
+#else
+        return -ENOSYS;
+#endif
+    } else {
+        ret = pipe(host_pipe);
+    }
+    ret = get_errno(ret);
+    if (is_error(ret)) {
+        return ret;
+    }
 
     /* Several targets have special calling conventions for the original
        pipe syscall, but didn't replicate this into the pipe2 syscall.  */
@@ -1599,9 +1600,10 @@ static abi_long do_pipe(void *cpu_env, abi_ulong pipedes,
     }
 
     if (put_user_s32(host_pipe[0], pipedes)
-        || put_user_s32(host_pipe[1], pipedes + sizeof(host_pipe[0])))
+        || put_user_s32(host_pipe[1], pipedes + sizeof(host_pipe[0]))) {
         return -TARGET_EFAULT;
-    return get_errno(ret);
+    }
+    return ret;
 }
 
 static inline abi_long target_to_host_ip_mreq(struct ip_mreqn *mreqn,
@@ -7884,6 +7886,23 @@ IMPL(access)
 }
 #endif
 
+IMPL(acct)
+{
+    if (arg1 == 0) {
+        return get_errno(acct(NULL));
+    } else {
+        char *p = lock_user_string(arg1);
+        abi_long ret;
+
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(acct(path(p)));
+        unlock_user(p, arg1, 0);
+        return ret;
+    }
+}
+
 #ifdef TARGET_NR_alarm
 IMPL(alarm)
 {
@@ -8435,6 +8454,19 @@ IMPL(pause)
 }
 #endif
 
+#ifdef TARGET_NR_pipe
+IMPL(pipe)
+{
+    return do_pipe(cpu_env, arg1, 0, 0);
+}
+#endif
+
+IMPL(pipe2)
+{
+    return do_pipe(cpu_env, arg1,
+                   target_to_host_bitmask(arg2, fcntl_flags_tbl), 1);
+}
+
 IMPL(read)
 {
     abi_long ret;
@@ -8552,6 +8584,28 @@ IMPL(time)
 }
 #endif
 
+IMPL(times)
+{
+    struct tms tms;
+    abi_long ret = get_errno(times(&tms));
+
+    if (is_error(ret)) {
+        return ret;
+    }
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
+    return host_to_target_clock_t(ret);
+}
+
 #ifdef TARGET_NR_umount
 IMPL(umount)
 {
@@ -8567,6 +8621,19 @@ IMPL(umount)
 }
 #endif
 
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
+
 #ifdef TARGET_NR_unlink
 IMPL(unlink)
 {
@@ -8717,52 +8784,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
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
-            if (!(p = lock_user_string(arg1))) {
-                return -TARGET_EFAULT;
-            }
-            ret = get_errno(acct(path(p)));
-            unlock_user(p, arg1, 0);
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
@@ -12591,6 +12612,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_access
         SYSCALL(access);
 #endif
+        SYSCALL(acct);
 #ifdef TARGET_NR_alarm
         SYSCALL(alarm);
 #endif
@@ -12650,6 +12672,10 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_pause
         SYSCALL(pause);
 #endif
+#ifdef TARGET_NR_pipe
+        SYSCALL(pipe);
+#endif
+        SYSCALL(pipe2);
         SYSCALL(read);
 #ifdef TARGET_NR_rename
         SYSCALL(rename);
@@ -12671,9 +12697,11 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_time
         SYSCALL(time);
 #endif
+        SYSCALL(times);
 #ifdef TARGET_NR_umount
         SYSCALL(umount);
 #endif
+        SYSCALL(umount2);
 #ifdef TARGET_NR_unlink
         SYSCALL(unlink);
 #endif
-- 
2.17.1
