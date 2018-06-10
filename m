Received: from eggs.gnu.org ([2001:4830:134:3::10]:40300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdM-00025a-IB
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdL-0003LC-CC
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:12 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:40841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqdL-0003Ku-40
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:11 -0400
Received: by mail-pg0-x242.google.com with SMTP id l2-v6so8127289pgc.7
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:00:53 -1000
Message-Id: <20180610030220.3777-22-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 021/108] linux-user: Split out alarm, pause,
 stime, utime, utimes
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
 linux-user/syscall.c | 155 ++++++++++++++++++++++++++-----------------
 1 file changed, 93 insertions(+), 62 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 844e771488..d5f7519e62 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7871,6 +7871,13 @@ static abi_long impl_##NAME(void *cpu_env, unsigned num, abi_long arg1,   \
                             abi_long arg5, abi_long arg6, abi_long arg7,  \
                             abi_long arg8)
 
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
@@ -8319,6 +8326,17 @@ IMPL(open_by_handle_at)
 }
 #endif
 
+#ifdef TARGET_NR_pause
+IMPL(pause)
+{
+    if (!block_signals()) {
+        CPUState *cpu = ENV_GET_CPU(cpu_env);
+        sigsuspend(&((TaskState *)cpu->opaque)->signal_mask);
+    }
+    return -TARGET_EINTR;
+}
+#endif
+
 IMPL(read)
 {
     abi_long ret;
@@ -8339,6 +8357,17 @@ IMPL(read)
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
@@ -8394,6 +8423,55 @@ IMPL(unlinkat)
     return ret;
 }
 
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
 IMPL(waitid)
 {
     siginfo_t info;
@@ -8467,68 +8545,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
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
         {
@@ -12528,6 +12544,9 @@ static impl_fn *syscall_table(unsigned num)
         /*
          * Other syscalls listed in collation order, with '_' ignored.
          */
+#ifdef TARGET_NR_alarm
+        SYSCALL(alarm);
+#endif
         SYSCALL(brk);
         SYSCALL(close);
         SYSCALL(chdir);
@@ -12567,8 +12586,14 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(openat);
 #ifdef CONFIG_OPEN_BY_HANDLE
         SYSCALL(open_by_handle_at);
+#endif
+#ifdef TARGET_NR_pause
+        SYSCALL(pause);
 #endif
         SYSCALL(read);
+#ifdef TARGET_NR_stime
+        SYSCALL(stime);
+#endif
 #ifdef TARGET_NR_time
         SYSCALL(time);
 #endif
@@ -12579,6 +12604,12 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(unlink);
 #endif
         SYSCALL(unlinkat);
+#ifdef TARGET_NR_utime
+        SYSCALL(utime);
+#endif
+#ifdef TARGET_NR_utimes
+        SYSCALL(utimes);
+#endif
         SYSCALL(waitid);
 #ifdef TARGET_NR_waitpid
         SYSCALL(waitpid);
-- 
2.17.1
