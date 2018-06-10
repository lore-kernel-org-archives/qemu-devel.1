Received: from eggs.gnu.org ([2001:4830:134:3::10]:41442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfp-0004UN-MA
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfo-0004hw-Lm
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:45 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:40580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfo-0004hh-DE
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:44 -0400
Received: by mail-pf0-x241.google.com with SMTP id z24-v6so8491736pfe.7
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:08 -1000
Message-Id: <20180610030220.3777-97-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 096/108] linux-user: Split out splice, tee,
 vmsplice
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

All targets define all of these; remove the ifdefs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 117 +++++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 53 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0c312cd156..8548f113d1 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12075,6 +12075,39 @@ IMPL(socketpair)
 }
 #endif
 
+#ifdef CONFIG_SPLICE
+IMPL(splice)
+{
+    loff_t loff_in, loff_out;
+    loff_t *ploff_in = NULL, *ploff_out = NULL;
+    abi_long ret;
+
+    if (arg2) {
+        if (get_user_u64(loff_in, arg2)) {
+            return -TARGET_EFAULT;
+        }
+        ploff_in = &loff_in;
+    }
+    if (arg4) {
+        if (get_user_u64(loff_out, arg4)) {
+            return -TARGET_EFAULT;
+        }
+        ploff_out = &loff_out;
+    }
+    ret = get_errno(splice(arg1, ploff_in, arg3, ploff_out, arg5, arg6));
+    if (arg2) {
+        if (put_user_u64(loff_in, arg2)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    if (arg4) {
+        if (put_user_u64(loff_out, arg4)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+#endif
 #ifdef TARGET_NR_ssetmask
 IMPL(ssetmask)
 {
@@ -12324,6 +12357,13 @@ IMPL(syslog)
     }
 }
 
+#ifdef CONFIG_SPLICE
+IMPL(tee)
+{
+    return get_errno(tee(arg1, arg2, arg3, arg4));
+}
+#endif
+
 IMPL(tgkill)
 {
     return get_errno(safe_tgkill((int)arg1, (int)arg2,
@@ -12603,6 +12643,21 @@ IMPL(vm86)
 }
 #endif
 
+#ifdef CONFIG_SPLICE
+IMPL(vmsplice)
+{
+    struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
+    abi_long ret;
+
+    if (vec == NULL) {
+        return -host_to_target_errno(errno);
+    }
+    ret = get_errno(vmsplice(arg1, vec, arg3, arg4));
+    unlock_iovec(vec, arg2, arg3, 0);
+    return ret;
+}
+#endif
+
 IMPL(wait4)
 {
     int status;
@@ -12712,59 +12767,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     abi_long ret;
 
     switch(num) {
-#ifdef CONFIG_SPLICE
-#ifdef TARGET_NR_tee
-    case TARGET_NR_tee:
-        {
-            ret = get_errno(tee(arg1,arg2,arg3,arg4));
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_splice
-    case TARGET_NR_splice:
-        {
-            loff_t loff_in, loff_out;
-            loff_t *ploff_in = NULL, *ploff_out = NULL;
-            if (arg2) {
-                if (get_user_u64(loff_in, arg2)) {
-                    return -TARGET_EFAULT;
-                }
-                ploff_in = &loff_in;
-            }
-            if (arg4) {
-                if (get_user_u64(loff_out, arg4)) {
-                    return -TARGET_EFAULT;
-                }
-                ploff_out = &loff_out;
-            }
-            ret = get_errno(splice(arg1, ploff_in, arg3, ploff_out, arg5, arg6));
-            if (arg2) {
-                if (put_user_u64(loff_in, arg2)) {
-                    return -TARGET_EFAULT;
-                }
-            }
-            if (arg4) {
-                if (put_user_u64(loff_out, arg4)) {
-                    return -TARGET_EFAULT;
-                }
-            }
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_vmsplice
-	case TARGET_NR_vmsplice:
-        {
-            struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
-            if (vec != NULL) {
-                ret = get_errno(vmsplice(arg1, vec, arg3, arg4));
-                unlock_iovec(vec, arg2, arg3, 0);
-            } else {
-                ret = -host_to_target_errno(errno);
-            }
-        }
-        return ret;
-#endif
-#endif /* CONFIG_SPLICE */
 #ifdef CONFIG_EVENTFD
 #if defined(TARGET_NR_eventfd)
     case TARGET_NR_eventfd:
@@ -13800,6 +13802,9 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_socketpair
         SYSCALL(socketpair);
 #endif
+#ifdef CONFIG_SPLICE
+        SYSCALL(splice);
+#endif
 #ifdef TARGET_NR_ssetmask
         SYSCALL(ssetmask);
 #endif
@@ -13831,6 +13836,9 @@ static impl_fn *syscall_table(unsigned num)
 #endif
         SYSCALL(sysinfo);
         SYSCALL(syslog);
+#ifdef CONFIG_SPLICE
+        SYSCALL(tee);
+#endif
         SYSCALL(tgkill);
 #ifdef TARGET_NR_time
         SYSCALL(time);
@@ -13867,6 +13875,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(vhangup);
 #if defined(TARGET_I386) && !defined(TARGET_X86_64)
         SYSCALL(vm86);
+#endif
+#ifdef CONFIG_SPLICE
+        SYSCALL(vmsplice);
 #endif
         SYSCALL(wait4);
         SYSCALL(waitid);
-- 
2.17.1
