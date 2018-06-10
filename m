Received: from eggs.gnu.org ([2001:4830:134:3::10]:40825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeW-0003B8-4V
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeU-0003lh-65
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:23 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqeT-0003lT-Ua
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:22 -0400
Received: by mail-pf0-x244.google.com with SMTP id a63-v6so8499317pfl.1
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:25 -1000
Message-Id: <20180610030220.3777-54-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 053/108] linux-user: Split out swapoff,
 sysinfo, vhangup, wait4
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

All targets define swapoff; remove the ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 140 +++++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 64 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 87374014b1..a0fbbbbb4a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9903,6 +9903,19 @@ IMPL(stime)
 }
 #endif
 
+IMPL(swapoff)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(swapoff(p));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+
 IMPL(swapon)
 {
     char *p = lock_user_string(arg1);
@@ -9959,6 +9972,36 @@ IMPL(syncfs)
 }
 #endif
 
+IMPL(sysinfo)
+{
+    struct sysinfo value;
+    abi_long ret = get_errno(sysinfo(&value));
+
+    if (!is_error(ret) && arg1) {
+        struct target_sysinfo *target_value;
+
+        if (!lock_user_struct(VERIFY_WRITE, target_value, arg1, 0)) {
+            return -TARGET_EFAULT;
+        }
+        __put_user(value.uptime, &target_value->uptime);
+        __put_user(value.loads[0], &target_value->loads[0]);
+        __put_user(value.loads[1], &target_value->loads[1]);
+        __put_user(value.loads[2], &target_value->loads[2]);
+        __put_user(value.totalram, &target_value->totalram);
+        __put_user(value.freeram, &target_value->freeram);
+        __put_user(value.sharedram, &target_value->sharedram);
+        __put_user(value.bufferram, &target_value->bufferram);
+        __put_user(value.totalswap, &target_value->totalswap);
+        __put_user(value.freeswap, &target_value->freeswap);
+        __put_user(value.procs, &target_value->procs);
+        __put_user(value.totalhigh, &target_value->totalhigh);
+        __put_user(value.freehigh, &target_value->freehigh);
+        __put_user(value.mem_unit, &target_value->mem_unit);
+        unlock_user_struct(target_value, arg1, 1);
+    }
+    return ret;
+}
+
 IMPL(syslog)
 {
     abi_long ret;
@@ -10156,6 +10199,35 @@ IMPL(utimes)
 }
 #endif
 
+IMPL(vhangup)
+{
+    return get_errno(vhangup());
+}
+
+IMPL(wait4)
+{
+    int status;
+    struct rusage rusage;
+    abi_long ret;
+
+    ret = get_errno(safe_wait4(arg1, &status, arg3, &rusage));
+    if (!is_error(ret)) {
+        if (ret && arg2) {
+            status = host_to_target_waitstatus(status);
+            if (put_user_s32(status, arg2)) {
+                return -TARGET_EFAULT;
+            }
+        }
+        if (arg4) {
+            abi_long err = host_to_target_rusage(arg4, &rusage);
+            if (err) {
+                return err;
+            }
+        }
+    }
+    return ret;
+}
+
 IMPL(waitid)
 {
     siginfo_t info;
@@ -10228,70 +10300,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_vhangup:
-        return get_errno(vhangup());
-    case TARGET_NR_wait4:
-        {
-            int status;
-            abi_long status_ptr = arg2;
-            struct rusage rusage, *rusage_ptr;
-            abi_ulong target_rusage = arg4;
-            abi_long rusage_err;
-            if (target_rusage)
-                rusage_ptr = &rusage;
-            else
-                rusage_ptr = NULL;
-            ret = get_errno(safe_wait4(arg1, &status, arg3, rusage_ptr));
-            if (!is_error(ret)) {
-                if (status_ptr && ret) {
-                    status = host_to_target_waitstatus(status);
-                    if (put_user_s32(status, status_ptr))
-                        return -TARGET_EFAULT;
-                }
-                if (target_rusage) {
-                    rusage_err = host_to_target_rusage(target_rusage, &rusage);
-                    if (rusage_err) {
-                        ret = rusage_err;
-                    }
-                }
-            }
-        }
-        return ret;
-#ifdef TARGET_NR_swapoff
-    case TARGET_NR_swapoff:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(swapoff(p));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-    case TARGET_NR_sysinfo:
-        {
-            struct target_sysinfo *target_value;
-            struct sysinfo value;
-            ret = get_errno(sysinfo(&value));
-            if (!is_error(ret) && arg1)
-            {
-                if (!lock_user_struct(VERIFY_WRITE, target_value, arg1, 0))
-                    return -TARGET_EFAULT;
-                __put_user(value.uptime, &target_value->uptime);
-                __put_user(value.loads[0], &target_value->loads[0]);
-                __put_user(value.loads[1], &target_value->loads[1]);
-                __put_user(value.loads[2], &target_value->loads[2]);
-                __put_user(value.totalram, &target_value->totalram);
-                __put_user(value.freeram, &target_value->freeram);
-                __put_user(value.sharedram, &target_value->sharedram);
-                __put_user(value.bufferram, &target_value->bufferram);
-                __put_user(value.totalswap, &target_value->totalswap);
-                __put_user(value.freeswap, &target_value->freeswap);
-                __put_user(value.procs, &target_value->procs);
-                __put_user(value.totalhigh, &target_value->totalhigh);
-                __put_user(value.freehigh, &target_value->freehigh);
-                __put_user(value.mem_unit, &target_value->mem_unit);
-                unlock_user_struct(target_value, arg1, 1);
-            }
-        }
-        return ret;
 #ifdef TARGET_NR_ipc
     case TARGET_NR_ipc:
         return do_ipc(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
@@ -13100,6 +13108,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_stime
         SYSCALL(stime);
 #endif
+        SYSCALL(swapoff);
         SYSCALL(swapon);
 #ifdef TARGET_NR_symlink
         SYSCALL(symlink);
@@ -13109,6 +13118,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef CONFIG_SYNCFS
         SYSCALL(syncfs);
 #endif
+        SYSCALL(sysinfo);
         SYSCALL(syslog);
 #ifdef TARGET_NR_time
         SYSCALL(time);
@@ -13130,6 +13140,8 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_utimes
         SYSCALL(utimes);
 #endif
+        SYSCALL(vhangup);
+        SYSCALL(wait4);
         SYSCALL(waitid);
 #ifdef TARGET_NR_waitpid
         SYSCALL(waitpid);
-- 
2.17.1
