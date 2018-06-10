Received: from eggs.gnu.org ([2001:4830:134:3::10]:41495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfv-0004ZV-2L
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfs-0004jK-21
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:51 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:43603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfr-0004it-ST
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:47 -0400
Received: by mail-pl0-x241.google.com with SMTP id c41-v6so10386204plj.10
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:10 -1000
Message-Id: <20180610030220.3777-99-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 098/108] linux-user: Split out fallocate,
 sync_file_range/2
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

All targets define fallocate; remove the ifdefs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 101 +++++++++++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 38 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1158afde27..5edcb39b73 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8208,6 +8208,18 @@ IMPL(fadvise64)
 # endif
 #endif /* end fadvise64 handling */
 
+#ifdef CONFIG_FALLOCATE
+IMPL(fallocate)
+{
+# if TARGET_ABI_BITS == 32
+    return get_errno(fallocate(arg1, arg2, target_offset64(arg3, arg4),
+                               target_offset64(arg5, arg6)));
+# else
+    return get_errno(fallocate(arg1, arg2, arg3, arg4));
+# endif
+}
+#endif
+
 IMPL(fchdir)
 {
     return get_errno(fchdir(arg1));
@@ -12310,6 +12322,46 @@ IMPL(syncfs)
 }
 #endif
 
+#ifdef CONFIG_SYNC_FILE_RANGE
+# ifdef TARGET_NR_sync_file_range
+IMPL(sync_file_range)
+{
+    uint64_t off, len;
+    unsigned flags;
+
+#  if TARGET_ABI_BITS == 32
+    if (regpairs_aligned(cpu_env, TARGET_NR_sync_file_range)) {
+        off = target_offset64(arg3, arg4);
+        len = target_offset64(arg5, arg6);
+        flags = arg7;
+    } else {
+        off = target_offset64(arg2, arg3);
+        len = target_offset64(arg4, arg5);
+        flags = arg6;
+    }
+#  else
+    off = arg2;
+    len = arg3;
+    flags = arg4;
+#  endif
+    return get_errno(sync_file_range(arg1, off, len, flags));
+}
+# endif
+
+# ifdef TARGET_NR_sync_file_range2
+IMPL(sync_file_range2)
+{
+    /* This is like sync_file_range but the arguments are reordered */
+#  if TARGET_ABI_BITS == 32
+    return get_errno(sync_file_range(arg1, target_offset64(arg3, arg4),
+                                     target_offset64(arg5, arg6), arg2));
+#  else
+    return get_errno(sync_file_range(arg1, arg3, arg4, arg2));
+#  endif
+}
+# endif
+#endif /* CONFIG_SYNC_FILE_RANGE */
+
 #ifdef TARGET_NR__sysctl
 IMPL(_sysctl)
 {
@@ -12798,44 +12850,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     abi_long ret;
 
     switch(num) {
-#if defined(CONFIG_FALLOCATE) && defined(TARGET_NR_fallocate)
-    case TARGET_NR_fallocate:
-#if TARGET_ABI_BITS == 32
-        ret = get_errno(fallocate(arg1, arg2, target_offset64(arg3, arg4),
-                                  target_offset64(arg5, arg6)));
-#else
-        ret = get_errno(fallocate(arg1, arg2, arg3, arg4));
-#endif
-        return ret;
-#endif
-#if defined(CONFIG_SYNC_FILE_RANGE)
-#if defined(TARGET_NR_sync_file_range)
-    case TARGET_NR_sync_file_range:
-#if TARGET_ABI_BITS == 32
-#if defined(TARGET_MIPS)
-        ret = get_errno(sync_file_range(arg1, target_offset64(arg3, arg4),
-                                        target_offset64(arg5, arg6), arg7));
-#else
-        ret = get_errno(sync_file_range(arg1, target_offset64(arg2, arg3),
-                                        target_offset64(arg4, arg5), arg6));
-#endif /* !TARGET_MIPS */
-#else
-        ret = get_errno(sync_file_range(arg1, arg2, arg3, arg4));
-#endif
-        return ret;
-#endif
-#if defined(TARGET_NR_sync_file_range2)
-    case TARGET_NR_sync_file_range2:
-        /* This is like sync_file_range but the arguments are reordered */
-#if TARGET_ABI_BITS == 32
-        ret = get_errno(sync_file_range(arg1, target_offset64(arg3, arg4),
-                                        target_offset64(arg5, arg6), arg2));
-#else
-        ret = get_errno(sync_file_range(arg1, arg3, arg4, arg2));
-#endif
-        return ret;
-#endif
-#endif
 #if defined(TARGET_NR_signalfd4)
     case TARGET_NR_signalfd4:
         return do_signalfd4(arg1, arg2, arg4);
@@ -13341,6 +13355,9 @@ static impl_fn *syscall_table(unsigned num)
 # else
         SYSCALL_WITH(fadvise64_64, fadvise64);
 # endif
+#endif
+#ifdef CONFIG_FALLOCATE
+        SYSCALL(fallocate);
 #endif
         SYSCALL(fchdir);
         SYSCALL(fchmod);
@@ -13841,6 +13858,14 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef CONFIG_SYNCFS
         SYSCALL(syncfs);
 #endif
+#ifdef CONFIG_SYNC_FILE_RANGE
+# ifdef TARGET_NR_sync_file_range
+        SYSCALL(sync_file_range);
+# endif
+# ifdef TARGET_NR_sync_file_range2
+        SYSCALL(sync_file_range2);
+# endif
+#endif
 #ifdef TARGET_NR__sysctl
         SYSCALL(_sysctl);
 #endif
-- 
2.17.1
