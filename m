Received: from eggs.gnu.org ([2001:4830:134:3::10]:40896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeg-0003Kb-32
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqef-0003pF-2Y
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:34 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:42384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqee-0003ow-Tw
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:33 -0400
Received: by mail-pf0-x241.google.com with SMTP id w7-v6so8478858pfn.9
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:30 -1000
Message-Id: <20180610030220.3777-59-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 058/108] linux-user: Split out adjtimex,
 clock_adjtime, vm86
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

All targets define clock_adjtime; remove the ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 85 +++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 4967b84f21..7ff05dd33c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7669,6 +7669,23 @@ IMPL(acct)
     }
 }
 
+IMPL(adjtimex)
+{
+    struct timex host_buf;
+    abi_long ret;
+
+    if (target_to_host_timex(&host_buf, arg1) != 0) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(adjtimex(&host_buf));
+    if (!is_error(ret)) {
+        if (host_to_target_timex(arg1, &host_buf) != 0) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
 #ifdef TARGET_NR_alarm
 IMPL(alarm)
 {
@@ -7729,6 +7746,23 @@ IMPL(chroot)
     return ret;
 }
 
+#ifdef CONFIG_CLOCK_ADJTIME
+IMPL(clock_adjtime)
+{
+    struct timex htx;
+    abi_long ret;
+
+    if (target_to_host_timex(&htx, arg2)) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(clock_adjtime(arg1, &htx));
+    if (!is_error(ret) && host_to_target_timex(arg2, &htx)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
+
 IMPL(clone)
 {
     /* Linux manages to have three different orderings for its
@@ -10324,6 +10358,14 @@ IMPL(vhangup)
     return get_errno(vhangup());
 }
 
+#if defined(TARGET_I386) && !defined(TARGET_X86_64)
+/* ??? Other TARGET_NR_vm86 should be deleted.  */
+IMPL(vm86)
+{
+    return do_vm86(cpu_env, arg1, arg2);
+}
+#endif
+
 IMPL(wait4)
 {
     int status;
@@ -10420,42 +10462,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#if defined(TARGET_I386) && !defined(TARGET_X86_64)
-    case TARGET_NR_vm86:
-        return do_vm86(cpu_env, arg1, arg2);
-#endif
-    case TARGET_NR_adjtimex:
-        {
-            struct timex host_buf;
-
-            if (target_to_host_timex(&host_buf, arg1) != 0) {
-                return -TARGET_EFAULT;
-            }
-            ret = get_errno(adjtimex(&host_buf));
-            if (!is_error(ret)) {
-                if (host_to_target_timex(arg1, &host_buf) != 0) {
-                    return -TARGET_EFAULT;
-                }
-            }
-        }
-        return ret;
-#if defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME)
-    case TARGET_NR_clock_adjtime:
-        {
-            struct timex htx, *phtx = &htx;
-
-            if (target_to_host_timex(phtx, arg2) != 0) {
-                return -TARGET_EFAULT;
-            }
-            ret = get_errno(clock_adjtime(arg1, phtx));
-            if (!is_error(ret) && phtx) {
-                if (host_to_target_timex(arg2, phtx) != 0) {
-                    return -TARGET_EFAULT;
-                }
-            }
-        }
-        return ret;
-#endif
     case TARGET_NR_getpgid:
         return get_errno(getpgid(arg1));
     case TARGET_NR_fchdir:
@@ -12881,6 +12887,7 @@ static impl_fn *syscall_table(unsigned num)
 #endif
         SYSCALL(accept4);
         SYSCALL(acct);
+        SYSCALL(adjtimex);
 #ifdef TARGET_NR_alarm
         SYSCALL(alarm);
 #endif
@@ -12888,6 +12895,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(bind);
 #endif
         SYSCALL(brk);
+#ifdef CONFIG_CLOCK_ADJTIME
+        SYSCALL(clock_adjtime);
+#endif
         SYSCALL(clone);
         SYSCALL(close);
         SYSCALL(chdir);
@@ -13201,6 +13211,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(utimes);
 #endif
         SYSCALL(vhangup);
+#if defined(TARGET_I386) && !defined(TARGET_X86_64)
+        SYSCALL(vm86);
+#endif
         SYSCALL(wait4);
         SYSCALL(waitid);
 #ifdef TARGET_NR_waitpid
-- 
2.17.1
