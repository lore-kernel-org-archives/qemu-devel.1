Received: from eggs.gnu.org ([2001:4830:134:3::10]:40607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdz-0002e7-JP
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdy-0003bQ-CD
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:51 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:38799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqdy-0003bD-4R
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:50 -0400
Received: by mail-pl0-x242.google.com with SMTP id b14-v6so10400850pls.5
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:10 -1000
Message-Id: <20180610030220.3777-39-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 038/108] linux-user: Split out mmap, mmap2,
 reboot, swapon
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

All targets define swapon; remove the ifdef.
Add a comment noting the incorrect implementation of mmap2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 142 ++++++++++++++++++++++++-------------------
 1 file changed, 81 insertions(+), 61 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f1123479df..a3374955da 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8392,6 +8392,49 @@ IMPL(mknodat)
     return ret;
 }
 
+#ifdef TARGET_NR_mmap
+IMPL(mmap)
+{
+# if (defined(TARGET_I386) && defined(TARGET_ABI32)) \
+  || (defined(TARGET_ARM) && defined(TARGET_ABI32)) \
+  || defined(TARGET_M68K) || defined(TARGET_CRIS) \
+  || defined(TARGET_MICROBLAZE) || defined(TARGET_S390X)
+    abi_ulong orig_arg1 = arg1;
+    abi_ulong *v = lock_user(VERIFY_READ, arg1, 6 * sizeof(abi_ulong), 1);
+
+    if (!v) {
+        return -TARGET_EFAULT;
+    }
+    arg1 = tswapal(v[0]);
+    arg2 = tswapal(v[1]);
+    arg3 = tswapal(v[2]);
+    arg4 = tswapal(v[3]);
+    arg5 = tswapal(v[4]);
+    arg6 = tswapal(v[5]);
+    unlock_user(v, orig_arg1, 0);
+# endif
+    return get_errno(target_mmap(arg1, arg2, arg3,
+                                 target_to_host_bitmask(arg4, mmap_flags_tbl),
+                                 arg5, arg6));
+}
+#endif
+
+#ifdef TARGET_NR_mmap2
+IMPL(mmap2)
+{
+#ifndef MMAP_SHIFT
+#define MMAP_SHIFT 12
+#endif
+    /* ??? The argument to target_mmap is abi_ulong.  Therefore this
+     * truncates the true offset for ABI32, which are the only users
+     * (and only point) of this syscall.
+     */
+    return get_errno(target_mmap(arg1, arg2, arg3,
+                                 target_to_host_bitmask(arg4, mmap_flags_tbl),
+                                 arg5, arg6 << MMAP_SHIFT));
+}
+#endif
+
 IMPL(mount)
 {
     char *p1 = NULL, *p2, *p3 = NULL;
@@ -8751,6 +8794,23 @@ IMPL(readlinkat)
     return do_readlinkat(arg1, arg2, arg3, arg4);
 }
 
+IMPL(reboot)
+{
+    abi_long ret;
+    if (arg3 == LINUX_REBOOT_CMD_RESTART2) {
+        /* arg4 must be ignored in all other cases */
+        char *p = lock_user_string(arg4);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(reboot(arg1, arg2, arg3, p));
+        unlock_user(p, arg4, 0);
+    } else {
+        ret = get_errno(reboot(arg1, arg2, arg3, NULL));
+    }
+    return ret;
+}
+
 #ifdef TARGET_NR_rename
 IMPL(rename)
 {
@@ -9370,6 +9430,19 @@ IMPL(stime)
 }
 #endif
 
+IMPL(swapon)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(swapon(p, arg2));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+
 #ifdef TARGET_NR_symlink
 IMPL(symlink)
 {
@@ -9630,67 +9703,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_swapon
-    case TARGET_NR_swapon:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(swapon(p, arg2));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-    case TARGET_NR_reboot:
-        if (arg3 == LINUX_REBOOT_CMD_RESTART2) {
-           /* arg4 must be ignored in all other cases */
-           p = lock_user_string(arg4);
-           if (!p) {
-               return -TARGET_EFAULT;
-           }
-           ret = get_errno(reboot(arg1, arg2, arg3, p));
-           unlock_user(p, arg4, 0);
-        } else {
-           ret = get_errno(reboot(arg1, arg2, arg3, NULL));
-        }
-        return ret;
-#ifdef TARGET_NR_mmap
-    case TARGET_NR_mmap:
-#if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
-    (defined(TARGET_ARM) && defined(TARGET_ABI32)) || \
-    defined(TARGET_M68K) || defined(TARGET_CRIS) || defined(TARGET_MICROBLAZE) \
-    || defined(TARGET_S390X)
-        {
-            abi_ulong *v;
-            abi_ulong v1, v2, v3, v4, v5, v6;
-            if (!(v = lock_user(VERIFY_READ, arg1, 6 * sizeof(abi_ulong), 1)))
-                return -TARGET_EFAULT;
-            v1 = tswapal(v[0]);
-            v2 = tswapal(v[1]);
-            v3 = tswapal(v[2]);
-            v4 = tswapal(v[3]);
-            v5 = tswapal(v[4]);
-            v6 = tswapal(v[5]);
-            unlock_user(v, arg1, 0);
-            ret = get_errno(target_mmap(v1, v2, v3,
-                                        target_to_host_bitmask(v4, mmap_flags_tbl),
-                                        v5, v6));
-        }
-#else
-        ret = get_errno(target_mmap(arg1, arg2, arg3,
-                                    target_to_host_bitmask(arg4, mmap_flags_tbl),
-                                    arg5,
-                                    arg6));
-#endif
-        return ret;
-#endif
-#ifdef TARGET_NR_mmap2
-    case TARGET_NR_mmap2:
-#ifndef MMAP_SHIFT
-#define MMAP_SHIFT 12
-#endif
-        ret = target_mmap(arg1, arg2, arg3,
-                          target_to_host_bitmask(arg4, mmap_flags_tbl),
-                          arg5, arg6 << MMAP_SHIFT);
-        return get_errno(ret);
-#endif
     case TARGET_NR_munmap:
         return get_errno(target_munmap(arg1, arg2));
     case TARGET_NR_mprotect:
@@ -12743,6 +12755,12 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(mknod);
 #endif
         SYSCALL(mknodat);
+#ifdef TARGET_NR_mmap
+        SYSCALL(mmap);
+#endif
+#ifdef TARGET_NR_mmap2
+        SYSCALL(mmap2);
+#endif
         SYSCALL(mount);
 #ifdef CONFIG_OPEN_BY_HANDLE
         SYSCALL(name_to_handle_at);
@@ -12773,6 +12791,7 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(readlink);
 #endif
         SYSCALL(readlinkat);
+        SYSCALL(reboot);
 #ifdef TARGET_NR_rename
         SYSCALL(rename);
 #endif
@@ -12827,6 +12846,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_stime
         SYSCALL(stime);
 #endif
+        SYSCALL(swapon);
 #ifdef TARGET_NR_symlink
         SYSCALL(symlink);
 #endif
-- 
2.17.1
