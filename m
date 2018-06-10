Received: from eggs.gnu.org ([2001:4830:134:3::10]:40975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeo-0003TQ-L8
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqen-0003tU-Eg
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:42 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:40579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqen-0003t7-69
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:41 -0400
Received: by mail-pf0-x243.google.com with SMTP id z24-v6so8491109pfe.7
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:34 -1000
Message-Id: <20180610030220.3777-63-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 062/108] linux-user: Split out flock, preadv,
 pwritev, readv, writev
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

All targets define preadv and pwritev; remove the ifdefs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 135 ++++++++++++++++++++++++-------------------
 1 file changed, 77 insertions(+), 58 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 362d315ce8..07fa043965 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8043,6 +8043,12 @@ IMPL(fcntl)
 }
 #endif
 
+IMPL(flock)
+{
+    /* The flock constant seems to be the same for every Linux platform. */
+    return get_errno(safe_flock(arg1, arg2));
+}
+
 #ifdef TARGET_NR_fork
 IMPL(fork)
 {
@@ -9221,6 +9227,24 @@ IMPL(ppoll)
     return ret;
 }
 
+IMPL(preadv)
+{
+    struct iovec *vec;
+    abi_long ret;
+
+    vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
+    if (vec != NULL) {
+        unsigned long low, high;
+
+        target_to_host_low_high(arg4, arg5, &low, &high);
+        ret = get_errno(safe_preadv(arg1, vec, arg3, low, high));
+        unlock_iovec(vec, arg2, arg3, 1);
+    } else {
+        ret = -host_to_target_errno(errno);
+    }
+    return ret;
+}
+
 IMPL(pselect6)
 {
     abi_long rfd_addr, wfd_addr, efd_addr, n, ts_addr;
@@ -9322,6 +9346,24 @@ IMPL(pselect6)
     return ret;
 }
 
+IMPL(pwritev)
+{
+    struct iovec *vec;
+    abi_long ret;
+
+    vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
+    if (vec != NULL) {
+        unsigned long low, high;
+
+        target_to_host_low_high(arg4, arg5, &low, &high);
+        ret = get_errno(safe_pwritev(arg1, vec, arg3, low, high));
+        unlock_iovec(vec, arg2, arg3, 0);
+    } else {
+        ret = -host_to_target_errno(errno);
+    }
+    return ret;
+}
+
 IMPL(read)
 {
     abi_long ret;
@@ -9381,6 +9423,21 @@ IMPL(readlinkat)
     return do_readlinkat(arg1, arg2, arg3, arg4);
 }
 
+IMPL(readv)
+{
+    struct iovec *vec;
+    abi_long ret;
+
+    vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
+    if (vec != NULL) {
+        ret = get_errno(safe_readv(arg1, vec, arg3));
+        unlock_iovec(vec, arg2, arg3, 1);
+    } else {
+        ret = -host_to_target_errno(errno);
+    }
+    return ret;
+}
+
 IMPL(reboot)
 {
     abi_long ret;
@@ -10753,6 +10810,21 @@ IMPL(write)
     return ret;
 }
 
+IMPL(writev)
+{
+    struct iovec *vec;
+    abi_long ret;
+
+    vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
+    if (vec != NULL) {
+        ret = get_errno(safe_writev(arg1, vec, arg3));
+        unlock_iovec(vec, arg2, arg3, 0);
+    } else {
+        ret = -host_to_target_errno(errno);
+    }
+    return ret;
+}
+
 /* This is an internal helper for do_syscall so that it is easier
  * to have a single return point, so that actions, such as logging
  * of syscall results, can be performed.
@@ -10769,64 +10841,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_flock:
-        /* NOTE: the flock constant seems to be the same for every
-           Linux platform */
-        return get_errno(safe_flock(arg1, arg2));
-    case TARGET_NR_readv:
-        {
-            struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
-            if (vec != NULL) {
-                ret = get_errno(safe_readv(arg1, vec, arg3));
-                unlock_iovec(vec, arg2, arg3, 1);
-            } else {
-                ret = -host_to_target_errno(errno);
-            }
-        }
-        return ret;
-    case TARGET_NR_writev:
-        {
-            struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
-            if (vec != NULL) {
-                ret = get_errno(safe_writev(arg1, vec, arg3));
-                unlock_iovec(vec, arg2, arg3, 0);
-            } else {
-                ret = -host_to_target_errno(errno);
-            }
-        }
-        return ret;
-#if defined(TARGET_NR_preadv)
-    case TARGET_NR_preadv:
-        {
-            struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
-            if (vec != NULL) {
-                unsigned long low, high;
-
-                target_to_host_low_high(arg4, arg5, &low, &high);
-                ret = get_errno(safe_preadv(arg1, vec, arg3, low, high));
-                unlock_iovec(vec, arg2, arg3, 1);
-            } else {
-                ret = -host_to_target_errno(errno);
-           }
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_pwritev)
-    case TARGET_NR_pwritev:
-        {
-            struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
-            if (vec != NULL) {
-                unsigned long low, high;
-
-                target_to_host_low_high(arg4, arg5, &low, &high);
-                ret = get_errno(safe_pwritev(arg1, vec, arg3, low, high));
-                unlock_iovec(vec, arg2, arg3, 0);
-            } else {
-                ret = -host_to_target_errno(errno);
-           }
-        }
-        return ret;
-#endif
     case TARGET_NR_getsid:
         return get_errno(getsid(arg1));
 #if defined(TARGET_NR_fdatasync) /* Not on alpha (osf_datasync ?) */
@@ -12944,6 +12958,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_fcntl
         SYSCALL(fcntl);
 #endif
+        SYSCALL(flock);
 #ifdef TARGET_NR_fork
         SYSCALL(fork);
 #endif
@@ -13076,12 +13091,15 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(poll);
 #endif
         SYSCALL(ppoll);
+        SYSCALL(preadv);
         SYSCALL(pselect6);
+        SYSCALL(pwritev);
         SYSCALL(read);
 #ifdef TARGET_NR_readlink
         SYSCALL(readlink);
 #endif
         SYSCALL(readlinkat);
+        SYSCALL(readv);
         SYSCALL(reboot);
 #ifdef TARGET_NR_recv
         SYSCALL(recv);
@@ -13250,6 +13268,7 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(waitpid);
 #endif
         SYSCALL(write);
+        SYSCALL(writev);
     }
 
 #undef SYSCALL
-- 
2.17.1
