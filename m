Received: from eggs.gnu.org ([2001:4830:134:3::10]:41285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfU-00048D-9f
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfS-0004Rp-Px
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:24 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:38930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfS-0004QX-B0
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:22 -0400
Received: by mail-pg0-x243.google.com with SMTP id w12-v6so8139803pgc.6
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:56 -1000
Message-Id: <20180610030220.3777-85-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 084/108] linux-user: Split out fadvise64,
 fadvise64_64
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

Generalize the s390x guest advice frobbing to support s390x as a host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 189 ++++++++++++++++++++++++++-----------------
 1 file changed, 113 insertions(+), 76 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index afe6df5efa..5f056cf660 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8110,6 +8110,109 @@ IMPL(faccessat)
     return ret;
 }
 
+/* The advise values for DONTNEED and NOREUSE differ for s390x.
+ * Which means that we need to translate for the host as well.
+ */
+static int target_to_host_fadvise64_advice(int advice)
+{
+    switch (advice) {
+    case 0 ... 3:
+        return advice;
+#ifdef TARGET_S390X
+    case 6:
+        return POSIX_FADV_DONTNEED;
+    case 7:
+        return POSIX_FADV_NOREUSE;
+#else
+    case 4:
+        return POSIX_FADV_DONTNEED;
+    case 5:
+        return POSIX_FADV_NOREUSE;
+#endif
+    default:
+        return -TARGET_EINVAL;
+    }
+}
+
+#if TARGET_ABI_BITS == 32
+# ifdef TARGET_NR_fadvise64
+IMPL(fadvise64)
+{
+    abi_long ret;
+    off_t off, len;
+    int advice;
+
+    /* 5 args: fd, offset (high, low), len, advice */
+    if (regpairs_aligned(cpu_env, num)) {
+        /* offset is in (3,4), len in 5 and advice in 6 */
+        off = target_offset64(arg3, arg4);
+        len = arg5;
+        advice = arg6;
+    } else {
+        off = target_offset64(arg2, arg3);
+        len = arg4;
+        advice = arg5;
+    }
+    advice = target_to_host_fadvise64_advice(advice);
+    if (advice < 0) {
+        return advice;
+    }
+    ret = posix_fadvise(arg1, off, len, advice);
+    return -host_to_target_errno(ret);
+}
+# endif
+/* ??? TARGET_NR_arm_fadvise64_64 should be TARGET_NR_fadvise64_64.
+ * The argument ordering is the same as ppc32 and xtensa anyway.
+ */
+# ifdef TARGET_NR_arm_fadvise64_64
+#  define TARGET_NR_fadvise64_64  TARGET_NR_arm_fadvise64_64
+# endif
+# ifdef TARGET_NR_fadvise64_64
+IMPL(fadvise64_64)
+{
+    abi_long ret;
+    off_t off, len;
+    int advice;
+
+#  if defined(TARGET_ARM) || defined(TARGET_PPC) || defined(TARGET_XTENSA)
+    /* 6 args: fd, advice, offset (high, low), len (high, low) */
+    advice = arg2;
+    off = target_offset64(arg3, arg4);
+    len = target_offset64(arg5, arg6);
+#  else
+    /* 6 args: fd, offset (high, low), len (high, low), advice */
+    if (regpairs_aligned(cpu_env, num)) {
+        /* offset is in (3,4), len in (5,6) and advice in 7 */
+        off = target_offset64(arg3, arg4);
+        len = target_offset64(arg5, arg6);
+        advice = arg7;
+    } else {
+        off = target_offset64(arg2, arg3);
+        len = target_offset64(arg4, arg5);
+        advice = arg6;
+    }
+#  endif
+    advice = target_to_host_fadvise64_advice(advice);
+    if (advice < 0) {
+        return advice;
+    }
+    ret = posix_fadvise(arg1, off, len, advice);
+    return -host_to_target_errno(ret);
+}
+# endif
+#else /* TARGET_ABI_BITS == 64 */
+# if defined(TARGET_NR_fadvise64_64) || defined(TARGET_NR_fadvise64)
+IMPL(fadvise64)
+{
+    int advice = target_to_host_fadvise64_advice(arg4);
+    if (advice < 0) {
+        return advice;
+    }
+    return -host_to_target_errno(posix_fadvise(arg1, arg2, arg3, advice));
+}
+# endif
+#endif /* end fadvise64 handling */
+
 IMPL(fchdir)
 {
     return get_errno(fchdir(arg1));
@@ -12011,82 +12114,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_arm_fadvise64_64
-    case TARGET_NR_arm_fadvise64_64:
-        /* arm_fadvise64_64 looks like fadvise64_64 but
-         * with different argument order: fd, advice, offset, len
-         * rather than the usual fd, offset, len, advice.
-         * Note that offset and len are both 64-bit so appear as
-         * pairs of 32-bit registers.
-         */
-        ret = posix_fadvise(arg1, target_offset64(arg3, arg4),
-                            target_offset64(arg5, arg6), arg2);
-        return -host_to_target_errno(ret);
-#endif
-
-#if TARGET_ABI_BITS == 32
-
-#ifdef TARGET_NR_fadvise64_64
-    case TARGET_NR_fadvise64_64:
-#if defined(TARGET_PPC) || defined(TARGET_XTENSA)
-        /* 6 args: fd, advice, offset (high, low), len (high, low) */
-        ret = arg2;
-        arg2 = arg3;
-        arg3 = arg4;
-        arg4 = arg5;
-        arg5 = arg6;
-        arg6 = ret;
-#else
-        /* 6 args: fd, offset (high, low), len (high, low), advice */
-        if (regpairs_aligned(cpu_env, num)) {
-            /* offset is in (3,4), len in (5,6) and advice in 7 */
-            arg2 = arg3;
-            arg3 = arg4;
-            arg4 = arg5;
-            arg5 = arg6;
-            arg6 = arg7;
-        }
-#endif
-        ret = posix_fadvise(arg1, target_offset64(arg2, arg3),
-                            target_offset64(arg4, arg5), arg6);
-        return -host_to_target_errno(ret);
-#endif
-
-#ifdef TARGET_NR_fadvise64
-    case TARGET_NR_fadvise64:
-        /* 5 args: fd, offset (high, low), len, advice */
-        if (regpairs_aligned(cpu_env, num)) {
-            /* offset is in (3,4), len in 5 and advice in 6 */
-            arg2 = arg3;
-            arg3 = arg4;
-            arg4 = arg5;
-            arg5 = arg6;
-        }
-        ret = posix_fadvise(arg1, target_offset64(arg2, arg3), arg4, arg5);
-        return -host_to_target_errno(ret);
-#endif
-
-#else /* not a 32-bit ABI */
-#if defined(TARGET_NR_fadvise64_64) || defined(TARGET_NR_fadvise64)
-#ifdef TARGET_NR_fadvise64_64
-    case TARGET_NR_fadvise64_64:
-#endif
-#ifdef TARGET_NR_fadvise64
-    case TARGET_NR_fadvise64:
-#endif
-#ifdef TARGET_S390X
-        switch (arg4) {
-        case 4: arg4 = POSIX_FADV_NOREUSE + 1; break; /* make sure it's an invalid value */
-        case 5: arg4 = POSIX_FADV_NOREUSE + 2; break; /* ditto */
-        case 6: arg4 = POSIX_FADV_DONTNEED; break;
-        case 7: arg4 = POSIX_FADV_NOREUSE; break;
-        default: break;
-        }
-#endif
-        return -host_to_target_errno(posix_fadvise(arg1, arg2, arg3, arg4));
-#endif
-#endif /* end of 64-bit ABI fadvise handling */
-
 #ifdef TARGET_NR_madvise
     case TARGET_NR_madvise:
         /* A straight passthrough may not be safe because qemu sometimes
@@ -13189,6 +13216,16 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL_WITH(exit_group, enosys);
 #endif
         SYSCALL(faccessat);
+#ifdef TARGET_NR_fadvise64
+        SYSCALL(fadvise64);
+#endif
+#ifdef TARGET_NR_fadvise64_64
+# if TARGET_ABI_BITS == 32
+        SYSCALL(fadvise64_64);
+# else
+        SYSCALL_WITH(fadvise64_64, fadvise64);
+# endif
+#endif
         SYSCALL(fchdir);
         SYSCALL(fchmod);
         SYSCALL(fchmodat);
-- 
2.17.1
