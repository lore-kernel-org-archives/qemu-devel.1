Received: from eggs.gnu.org ([2001:4830:134:3::10]:41388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfi-0004NI-QZ
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfh-0004g0-F0
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:38 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:42799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfh-0004fp-5y
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:37 -0400
Received: by mail-pl0-x243.google.com with SMTP id w17-v6so10391244pll.9
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:04 -1000
Message-Id: <20180610030220.3777-93-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 092/108] linux-user: Split out futex,
 utimensat
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

At the same time, merge do_futex into the new function.
All targets define utimensat; remove the ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 161 ++++++++++++++++++++++---------------------
 1 file changed, 81 insertions(+), 80 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8406b9d8d3..800b79276f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -602,8 +602,7 @@ static int sys_getcwd1(char *buf, size_t size)
   return strlen(buf)+1;
 }
 
-#ifdef TARGET_NR_utimensat
-#if defined(__NR_utimensat)
+#ifdef __NR_utimensat
 #define __NR_sys_utimensat __NR_utimensat
 _syscall4(int,sys_utimensat,int,dirfd,const char *,pathname,
           const struct timespec *,tsp,int,flags)
@@ -615,7 +614,6 @@ static int sys_utimensat(int dirfd, const char *pathname,
     return -1;
 }
 #endif
-#endif /* TARGET_NR_utimensat */
 
 #if defined(__NR_renameat2)
 #define __NR_sys_renameat2 __NR_renameat2
@@ -7024,58 +7022,6 @@ static abi_long host_to_target_statfs64(abi_ulong target_addr,
 }
 #endif
 
-/* ??? Using host futex calls even when target atomic operations
-   are not really atomic probably breaks things.  However implementing
-   futexes locally would make futexes shared between multiple processes
-   tricky.  However they're probably useless because guest atomic
-   operations won't work either.  */
-static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
-                    target_ulong uaddr2, int val3)
-{
-    struct timespec ts, *pts;
-    int base_op;
-
-    /* ??? We assume FUTEX_* constants are the same on both host
-       and target.  */
-#ifdef FUTEX_CMD_MASK
-    base_op = op & FUTEX_CMD_MASK;
-#else
-    base_op = op;
-#endif
-    switch (base_op) {
-    case FUTEX_WAIT:
-    case FUTEX_WAIT_BITSET:
-        if (timeout) {
-            pts = &ts;
-            target_to_host_timespec(pts, timeout);
-        } else {
-            pts = NULL;
-        }
-        return get_errno(safe_futex(g2h(uaddr), op, tswap32(val),
-                         pts, NULL, val3));
-    case FUTEX_WAKE:
-        return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
-    case FUTEX_FD:
-        return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
-    case FUTEX_REQUEUE:
-    case FUTEX_CMP_REQUEUE:
-    case FUTEX_WAKE_OP:
-        /* For FUTEX_REQUEUE, FUTEX_CMP_REQUEUE, and FUTEX_WAKE_OP, the
-           TIMEOUT parameter is interpreted as a uint32_t by the kernel.
-           But the prototype takes a `struct timespec *'; insert casts
-           to satisfy the compiler.  We do not need to tswap TIMEOUT
-           since it's not compared to guest memory.  */
-        pts = (struct timespec *)(uintptr_t) timeout;
-        return get_errno(safe_futex(g2h(uaddr), op, val, pts,
-                                    g2h(uaddr2),
-                                    (base_op == FUTEX_CMP_REQUEUE
-                                     ? tswap32(val3)
-                                     : val3)));
-    default:
-        return -TARGET_ENOSYS;
-    }
-}
-
 #if defined(TARGET_NR_signalfd) || defined(TARGET_NR_signalfd4)
 
 /* signalfd siginfo conversion */
@@ -8574,6 +8520,58 @@ IMPL(ftruncate64)
 }
 #endif
 
+IMPL(futex)
+{
+    target_ulong uaddr = arg1;
+    int op = arg2;
+    int val = arg3;
+    target_ulong timeout = arg4;
+    target_ulong uaddr2 = arg5;
+    int val3 = arg6;
+    struct timespec ts, *pts;
+    int base_op;
+
+    /* ??? We assume FUTEX_* constants are the same on both host
+       and target.  */
+#ifdef FUTEX_CMD_MASK
+    base_op = op & FUTEX_CMD_MASK;
+#else
+    base_op = op;
+#endif
+    switch (base_op) {
+    case FUTEX_WAIT:
+    case FUTEX_WAIT_BITSET:
+        if (timeout) {
+            pts = &ts;
+            target_to_host_timespec(pts, timeout);
+        } else {
+            pts = NULL;
+        }
+        return get_errno(safe_futex(g2h(uaddr), op, tswap32(val),
+                         pts, NULL, val3));
+    case FUTEX_WAKE:
+        return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
+    case FUTEX_FD:
+        return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
+    case FUTEX_REQUEUE:
+    case FUTEX_CMP_REQUEUE:
+    case FUTEX_WAKE_OP:
+        /* For FUTEX_REQUEUE, FUTEX_CMP_REQUEUE, and FUTEX_WAKE_OP, the
+           TIMEOUT parameter is interpreted as a uint32_t by the kernel.
+           But the prototype takes a `struct timespec *'; insert casts
+           to satisfy the compiler.  We do not need to tswap TIMEOUT
+           since it's not compared to guest memory.  */
+        pts = (struct timespec *)(uintptr_t) timeout;
+        return get_errno(safe_futex(g2h(uaddr), op, val, pts,
+                                    g2h(uaddr2),
+                                    (base_op == FUTEX_CMP_REQUEUE
+                                     ? tswap32(val3)
+                                     : val3)));
+    default:
+        return -TARGET_ENOSYS;
+    }
+}
+
 #ifdef TARGET_NR_futimesat
 IMPL(futimesat)
 {
@@ -12425,6 +12423,32 @@ IMPL(utime)
 }
 #endif
 
+IMPL(utimensat)
+{
+    struct timespec *tsp = NULL, ts[2];
+    abi_long ret;
+    char *p;
+
+    if (arg3) {
+        if (target_to_host_timespec(&ts[0], arg3) ||
+            target_to_host_timespec(&ts[1], arg3
+                                    + sizeof(struct target_timespec))) {
+            return -TARGET_EFAULT;
+        }
+        tsp = ts;
+    }
+    if (!arg2) {
+        return get_errno(sys_utimensat(arg1, NULL, tsp, arg4));
+    }
+    p = lock_user_string(arg2);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(sys_utimensat(arg1, path(p), tsp, arg4));
+    unlock_user(p, arg2, 0);
+    return ret;
+}
+
 #ifdef TARGET_NR_utimes
 IMPL(utimes)
 {
@@ -12579,31 +12603,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#if defined(TARGET_NR_utimensat)
-    case TARGET_NR_utimensat:
-        {
-            struct timespec *tsp, ts[2];
-            if (!arg3) {
-                tsp = NULL;
-            } else {
-                target_to_host_timespec(ts, arg3);
-                target_to_host_timespec(ts+1, arg3+sizeof(struct target_timespec));
-                tsp = ts;
-            }
-            if (!arg2)
-                ret = get_errno(sys_utimensat(arg1, NULL, tsp, arg4));
-            else {
-                if (!(p = lock_user_string(arg2))) {
-                    return -TARGET_EFAULT;
-                }
-                ret = get_errno(sys_utimensat(arg1, path(p), tsp, arg4));
-                unlock_user(p, arg2, 0);
-            }
-        }
-        return ret;
-#endif
-    case TARGET_NR_futex:
-        return do_futex(arg1, arg2, arg3, arg4, arg5, arg6);
 #if defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)
     case TARGET_NR_inotify_init:
         ret = get_errno(sys_inotify_init());
@@ -13388,6 +13387,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_ftruncate64
         SYSCALL(ftruncate64);
 #endif
+        SYSCALL(futex);
 #ifdef TARGET_NR_futimesat
         SYSCALL(futimesat);
 #endif
@@ -13858,6 +13858,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_utime
         SYSCALL(utime);
 #endif
+        SYSCALL(utimensat);
 #ifdef TARGET_NR_utimes
         SYSCALL(utimes);
 #endif
-- 
2.17.1
