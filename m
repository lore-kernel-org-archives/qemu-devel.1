Received: from eggs.gnu.org ([2001:4830:134:3::10]:51221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZTRa-0007vd-3t
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 23:26:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZTMM-0006Nk-1J
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 23:21:28 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZTMJ-0006L5-ST
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 23:21:24 -0500
Received: by mail-pf1-x443.google.com with SMTP id r136so2142561pfc.6
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 20:21:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 18 Dec 2018 20:21:09 -0800
Message-Id: <20181219042113.7364-5-richard.henderson@linaro.org>
In-Reply-To: <20181219042113.7364-1-richard.henderson@linaro.org>
References: <20181219042113.7364-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 4/8] linux-user: Split out preadv, pwritev,
 readv, writev, pread64, pwrite64
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
 linux-user/syscall-defs.h     |  14 ++++
 linux-user/syscall-file.inc.c | 124 ++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          |  93 -------------------------
 linux-user/strace.list        |  18 -----
 4 files changed, 138 insertions(+), 111 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index b031de1375..ae89be0e87 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -21,6 +21,18 @@ SYSCALL_DEF(close, ARG_DEC);
 SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 #endif
 SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
+SYSCALL_DEF_FULL(pread64, .impl = impl_pread64,
+                 .args = args_pread64_pwrite64,
+                 .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
+SYSCALL_DEF_FULL(pwrite64, .impl = impl_pwrite64,
+                 .args = args_pread64_pwrite64,
+                 .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
+SYSCALL_DEF_FULL(preadv, .impl = impl_preadv,
+                 .args = args_preadv_pwritev,
+                 .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
+SYSCALL_DEF_FULL(pwritev, .impl = impl_pwritev,
+                 .args = args_preadv_pwritev,
+                 .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
 SYSCALL_DEF(read, ARG_DEC, ARG_PTR, ARG_DEC);
 #ifdef TARGET_NR_readlink
 SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
@@ -28,4 +40,6 @@ SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
 #ifdef TARGET_NR_readlinkat
 SYSCALL_DEF(readlinkat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_DEC);
 #endif
+SYSCALL_DEF(readv, ARG_DEC, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(write, ARG_DEC, ARG_PTR, ARG_DEC);
+SYSCALL_DEF(writev, ARG_DEC, ARG_PTR, ARG_DEC);
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 11e75044c1..410a763eee 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -315,6 +315,104 @@ SYSCALL_IMPL(openat)
     return do_openat(cpu_env, arg1, arg2, arg3, arg4);
 }
 
+/*
+ * Both pread64 and pwrite64 merge args into a 64-bit offset,
+ * but the input registers and ordering are target specific.
+ */
+#if TARGET_ABI_BITS == 32
+SYSCALL_ARGS(pread64_pwrite64)
+{
+    /* We have already assigned out[0-2].  */
+    int off = regpairs_aligned(cpu_env, TARGET_NR_pread64);
+    out[3] = target_offset64(in[3 + off], in[4 + off]);
+    return def;
+}
+#else
+#define args_pread64_pwrite64 NULL
+#endif
+
+SYSCALL_IMPL(pread64)
+{
+    void *p = lock_user(VERIFY_WRITE, arg2, arg3, 0);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(pread64(arg1, p, arg3, arg4));
+    unlock_user(p, arg2, ret);
+    return ret;
+}
+
+SYSCALL_IMPL(pwrite64)
+{
+    void *p = lock_user(VERIFY_READ, arg2, arg3, 0);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(pwrite64(arg1, p, arg3, arg4));
+    unlock_user(p, arg2, 0);
+    return ret;
+}
+
+/*
+ * Both preadv and pwritev merge args 4/5 into a 64-bit offset.
+ * Moreover, the parts are *always* in little-endian order.
+ */
+#if TARGET_ABI_BITS == 32
+SYSCALL_ARGS(preadv_pwritev)
+{
+    /* We have already assigned out[0-2].  */
+    abi_ulong lo = in[3], hi = in[4];
+    out[3] = ((hi << (TARGET_ABI_BITS - 1)) << 1) | lo;
+    return def;
+}
+#else
+#define args_preadv_pwritev NULL
+#endif
+
+/* Perform the inverse operation for the host.  */
+static inline void host_offset64_low_high(unsigned long *l, unsigned long *h,
+                                          uint64_t off)
+{
+    *l = off;
+    *h = (off >> (HOST_LONG_BITS - 1)) >> 1;
+}
+
+SYSCALL_IMPL(preadv)
+{
+    struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
+    unsigned long lo, hi;
+    abi_long ret;
+
+    if (vec == NULL) {
+        return -host_to_target_errno(errno);
+    }
+
+    host_offset64_low_high(&lo, &hi, arg4);
+    ret = get_errno(safe_preadv(arg1, vec, arg3, lo, hi));
+    unlock_iovec(vec, arg2, arg3, 1);
+    return ret;
+}
+
+SYSCALL_IMPL(pwritev)
+{
+    struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
+    unsigned long lo, hi;
+    abi_long ret;
+
+    if (vec == NULL) {
+        ret = -host_to_target_errno(errno);
+    }
+
+    host_offset64_low_high(&lo, &hi, arg4);
+    ret = get_errno(safe_pwritev(arg1, vec, arg3, lo, hi));
+    unlock_iovec(vec, arg2, arg3, 0);
+    return ret;
+}
+
 SYSCALL_IMPL(read)
 {
     abi_long ret;
@@ -403,6 +501,19 @@ SYSCALL_IMPL(readlinkat)
 }
 #endif
 
+SYSCALL_IMPL(readv)
+{
+    struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
+    abi_long ret;
+
+    if (vec == NULL) {
+        return -host_to_target_errno(errno);
+    }
+    ret = get_errno(safe_readv(arg1, vec, arg3));
+    unlock_iovec(vec, arg2, arg3, 1);
+    return ret;
+}
+
 SYSCALL_IMPL(write)
 {
     TargetFdDataFunc trans;
@@ -431,3 +542,16 @@ SYSCALL_IMPL(write)
     unlock_user(p, arg2, 0);
     return ret;
 }
+
+SYSCALL_IMPL(writev)
+{
+    struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
+    abi_long ret;
+
+    if (vec == NULL) {
+        return -host_to_target_errno(errno);
+    }
+    ret = get_errno(safe_writev(arg1, vec, arg3));
+    unlock_iovec(vec, arg2, arg3, 0);
+    return ret;
+}
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d4c11c3e93..9a9b6c543c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2364,23 +2364,6 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
     return ret;
 }
 
-/* Convert target low/high pair representing file offset into the host
- * low/high pair. This function doesn't handle offsets bigger than 64 bits
- * as the kernel doesn't handle them either.
- */
-static void target_to_host_low_high(abi_ulong tlow,
-                                    abi_ulong thigh,
-                                    unsigned long *hlow,
-                                    unsigned long *hhigh)
-{
-    uint64_t off = tlow |
-        ((unsigned long long)thigh << TARGET_LONG_BITS / 2) <<
-        TARGET_LONG_BITS / 2;
-
-    *hlow = off;
-    *hhigh = (off >> HOST_LONG_BITS / 2) >> HOST_LONG_BITS / 2;
-}
-
 static struct iovec *lock_iovec(int type, abi_ulong target_addr,
                                 abi_ulong count, int copy)
 {
@@ -8910,60 +8893,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         /* NOTE: the flock constant seems to be the same for every
            Linux platform */
         return get_errno(safe_flock(arg1, arg2));
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
@@ -9295,28 +9224,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #else
 #error unreachable
 #endif
-#endif
-#ifdef TARGET_NR_pread64
-    case TARGET_NR_pread64:
-        if (regpairs_aligned(cpu_env, num)) {
-            arg4 = arg5;
-            arg5 = arg6;
-        }
-        if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
-            return -TARGET_EFAULT;
-        ret = get_errno(pread64(arg1, p, arg3, target_offset64(arg4, arg5)));
-        unlock_user(p, arg2, ret);
-        return ret;
-    case TARGET_NR_pwrite64:
-        if (regpairs_aligned(cpu_env, num)) {
-            arg4 = arg5;
-            arg5 = arg6;
-        }
-        if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(pwrite64(arg1, p, arg3, target_offset64(arg4, arg5)));
-        unlock_user(p, arg2, 0);
-        return ret;
 #endif
     case TARGET_NR_getcwd:
         if (!(p = lock_user(VERIFY_WRITE, arg1, arg2, 0)))
diff --git a/linux-user/strace.list b/linux-user/strace.list
index ff8bb19f5f..8f96b7a105 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1034,12 +1034,6 @@
 #ifdef TARGET_NR_prctl
 { TARGET_NR_prctl, "prctl" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_pread64
-{ TARGET_NR_pread64, "pread64" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_preadv
-{ TARGET_NR_preadv, "preadv" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_prlimit64
 { TARGET_NR_prlimit64, "prlimit64" , NULL, NULL, NULL },
 #endif
@@ -1064,12 +1058,6 @@
 #ifdef TARGET_NR_putpmsg
 { TARGET_NR_putpmsg, "putpmsg" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_pwrite64
-{ TARGET_NR_pwrite64, "pwrite64" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_pwritev
-{ TARGET_NR_pwritev, "pwritev" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_query_module
 { TARGET_NR_query_module, "query_module" , NULL, NULL, NULL },
 #endif
@@ -1091,9 +1079,6 @@
 #ifdef TARGET_NR_readlinkat
 { TARGET_NR_readlinkat, "readlinkat" , NULL, print_readlinkat, NULL },
 #endif
-#ifdef TARGET_NR_readv
-{ TARGET_NR_readv, "readv" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_reboot
 { TARGET_NR_reboot, "reboot" , NULL, NULL, NULL },
 #endif
@@ -1629,9 +1614,6 @@
 #ifdef TARGET_NR_write
 { TARGET_NR_write, "write" , "%s(%d,%#x,%d)", NULL, NULL },
 #endif
-#ifdef TARGET_NR_writev
-{ TARGET_NR_writev, "writev" , "%s(%d,%p,%#x)", NULL, NULL },
-#endif
 #ifdef TARGET_NR_utimensat
 { TARGET_NR_utimensat, "utimensat", NULL, print_utimensat, NULL },
 #endif
-- 
2.17.2
