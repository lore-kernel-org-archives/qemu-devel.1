Received: from eggs.gnu.org ([2001:4830:134:3::10]:41300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfV-0004AM-Rw
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfU-0004Tt-JY
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:25 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfU-0004SS-AV
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:24 -0400
Received: by mail-pf0-x241.google.com with SMTP id a12-v6so8499859pfi.3
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:57 -1000
Message-Id: <20180610030220.3777-86-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 085/108] linux-user: Split out cacheflush,
 fcntl64, getpagesize, madvise
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

All targets define madvise; remove the ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 144 ++++++++++++++++++++++++-------------------
 1 file changed, 80 insertions(+), 64 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5f056cf660..bcddb28947 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7675,6 +7675,14 @@ IMPL(brk)
     return do_brk(arg1);
 }
 
+#ifdef TARGET_NR_cacheflush
+IMPL(cacheflush)
+{
+    /* Self-modifying code is handled automatically, so nothing needed.  */
+    return 0;
+}
+#endif
+
 IMPL(capget)
 {
     struct target_user_cap_header *target_header;
@@ -8269,6 +8277,52 @@ IMPL(fcntl)
 }
 #endif
 
+#if TARGET_ABI_BITS == 32
+IMPL(fcntl64)
+{
+    int cmd;
+    struct flock64 fl;
+    from_flock64_fn *copyfrom = copy_from_user_flock64;
+    to_flock64_fn *copyto = copy_to_user_flock64;
+    abi_long ret;
+
+#ifdef TARGET_ARM
+    if (!((CPUARMState *)cpu_env)->eabi) {
+        copyfrom = copy_from_user_oabi_flock64;
+        copyto = copy_to_user_oabi_flock64;
+    }
+#endif
+    cmd = target_to_host_fcntl_cmd(arg2);
+    if (cmd == -TARGET_EINVAL) {
+        return -TARGET_EINVAL;
+    }
+
+    switch (arg2) {
+    case TARGET_F_GETLK64:
+        ret = copyfrom(&fl, arg3);
+        if (ret) {
+            return ret;
+        }
+        ret = get_errno(fcntl(arg1, cmd, &fl));
+        if (ret == 0) {
+            ret = copyto(arg3, &fl);
+        }
+        return ret;
+
+    case TARGET_F_SETLK64:
+    case TARGET_F_SETLKW64:
+        ret = copyfrom(&fl, arg3);
+        if (ret) {
+            return ret;
+        }
+        return get_errno(safe_fcntl(arg1, cmd, &fl));
+
+    default:
+        return do_fcntl(arg1, arg2, arg3);
+    }
+}
+#endif
+
 IMPL(fdatasync)
 {
     return get_errno(fdatasync(arg1));
@@ -8709,6 +8763,13 @@ IMPL(getitimer)
     return ret;
 }
 
+#ifdef TARGET_NR_getpagesize
+IMPL(getpagesize)
+{
+    return TARGET_PAGE_SIZE;
+}
+#endif
+
 #ifdef TARGET_NR_getpeername
 IMPL(getpeername)
 {
@@ -9247,6 +9308,15 @@ IMPL(lstat64)
 }
 #endif
 
+IMPL(madvise)
+{
+    /* A straight passthrough may not be safe because qemu sometimes
+       turns private file-backed mappings into anonymous mappings.
+       This will break MADV_DONTNEED.
+       This is a hint, so ignoring and returning success is ok.  */
+    return 0;
+}
+
 IMPL(mincore)
 {
     void *a, *p;
@@ -12114,70 +12184,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_madvise
-    case TARGET_NR_madvise:
-        /* A straight passthrough may not be safe because qemu sometimes
-           turns private file-backed mappings into anonymous mappings.
-           This will break MADV_DONTNEED.
-           This is a hint, so ignoring and returning success is ok.  */
-        return 0;
-#endif
-#if TARGET_ABI_BITS == 32
-    case TARGET_NR_fcntl64:
-    {
-	int cmd;
-	struct flock64 fl;
-        from_flock64_fn *copyfrom = copy_from_user_flock64;
-        to_flock64_fn *copyto = copy_to_user_flock64;
-
-#ifdef TARGET_ARM
-        if (!((CPUARMState *)cpu_env)->eabi) {
-            copyfrom = copy_from_user_oabi_flock64;
-            copyto = copy_to_user_oabi_flock64;
-        }
-#endif
-
-	cmd = target_to_host_fcntl_cmd(arg2);
-        if (cmd == -TARGET_EINVAL) {
-            return cmd;
-        }
-
-        switch(arg2) {
-        case TARGET_F_GETLK64:
-            ret = copyfrom(&fl, arg3);
-            if (ret) {
-                break;
-            }
-            ret = get_errno(fcntl(arg1, cmd, &fl));
-            if (ret == 0) {
-                ret = copyto(arg3, &fl);
-            }
-	    break;
-
-        case TARGET_F_SETLK64:
-        case TARGET_F_SETLKW64:
-            ret = copyfrom(&fl, arg3);
-            if (ret) {
-                break;
-            }
-            ret = get_errno(safe_fcntl(arg1, cmd, &fl));
-	    break;
-        default:
-            ret = do_fcntl(arg1, arg2, arg3);
-            break;
-        }
-        return ret;
-    }
-#endif
-#ifdef TARGET_NR_cacheflush
-    case TARGET_NR_cacheflush:
-        /* self-modifying code is handled automatically, so nothing needed */
-        return 0;
-#endif
-#ifdef TARGET_NR_getpagesize
-    case TARGET_NR_getpagesize:
-        return TARGET_PAGE_SIZE;
-#endif
     case TARGET_NR_gettid:
         return get_errno(gettid());
 #ifdef TARGET_NR_readahead
@@ -13179,6 +13185,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(bind);
 #endif
         SYSCALL(brk);
+#ifdef TARGET_NR_cacheflush
+        SYSCALL(cacheflush);
+#endif
         SYSCALL(capget);
         SYSCALL(capset);
 #ifdef CONFIG_CLOCK_ADJTIME
@@ -13236,6 +13245,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(fchownat);
 #ifdef TARGET_NR_fcntl
         SYSCALL(fcntl);
+#endif
+#if TARGET_ABI_BITS == 32
+        SYSCALL(fcntl64);
 #endif
         SYSCALL(fdatasync);
         SYSCALL(flock);
@@ -13292,6 +13304,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(getgroups32);
 #endif
         SYSCALL(getitimer);
+#ifdef TARGET_NR_getpagesize
+        SYSCALL(getpagesize);
+#endif
 #ifdef TARGET_NR_getpeername
         SYSCALL(getpeername);
 #endif
@@ -13372,6 +13387,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_lstat64
         SYSCALL(lstat64);
 #endif
+        SYSCALL(madvise);
         SYSCALL(mincore);
 #ifdef TARGET_NR_mkdir
         SYSCALL(mkdir);
-- 
2.17.1
