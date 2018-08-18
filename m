Received: from eggs.gnu.org ([2001:4830:134:3::10]:55278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6Tj-0005Il-W4
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6Ti-0007FC-Pk
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:39 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fr6Ti-0007Eu-IA
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:38 -0400
Received: by mail-pg1-x543.google.com with SMTP id r1-v6so4943428pgp.11
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 12:01:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 18 Aug 2018 12:01:13 -0700
Message-Id: <20180818190118.12911-12-richard.henderson@linaro.org>
In-Reply-To: <20180818190118.12911-1-richard.henderson@linaro.org>
References: <20180818190118.12911-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 11/16] linux-user: Split out preadv, pwritev,
 readv, writev
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
 linux-user/syscall-file.inc.c | 98 +++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 75 ++-------------------------
 linux-user/strace.list        | 12 -----
 3 files changed, 102 insertions(+), 83 deletions(-)

diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index aecc63682f..7eb5b968e2 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -323,6 +323,76 @@ SYSCALL_IMPL(openat)
 }
 SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 
+/*
+ * Both preadv and pwritev merge args 4/5 into a 64-bit offset.
+ * Moreover, the parts are *always* in little-endian order.
+ */
+#if TARGET_ABI_BITS == 32
+SYSCALL_ARGS(preadv_pwritev)
+{
+    /* We have already assigned out[0-3].  */
+    abi_ulong lo = in[4], hi = in[5];
+    out[4] = ((hi << (TARGET_ABI_BITS - 1)) << 1) | lo;
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
+static const SyscallDef def_preadv = {
+    .name = "preadv",
+    .args = args_preadv_pwritev,
+    .impl = impl_preadv,
+    .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 }
+};
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
+static const SyscallDef def_pwritev = {
+    .name = "pwritev",
+    .args = args_preadv_pwritev,
+    .impl = impl_pwritev,
+    .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 }
+};
+
 SYSCALL_IMPL(read)
 {
     abi_long ret;
@@ -414,6 +484,20 @@ SYSCALL_IMPL(readlinkat)
 SYSCALL_DEF(readlinkat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_DEC);
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
+SYSCALL_DEF(readv, ARG_DEC, ARG_PTR, ARG_DEC);
+
 SYSCALL_IMPL(write)
 {
     TargetFdDataFunc trans = fd_trans_target_to_host_data(arg1);
@@ -438,3 +522,17 @@ SYSCALL_IMPL(write)
     return ret;
 }
 SYSCALL_DEF(write, ARG_DEC, ARG_PTR, ARG_DEC);
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
+SYSCALL_DEF(writev, ARG_DEC, ARG_PTR, ARG_DEC);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f757ae87b0..16824386fd 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3456,23 +3456,6 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
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
@@ -10000,60 +9983,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12125,8 +12054,12 @@ static const SyscallDef *syscall_table(int num)
      */
     S(close);
     S(openat);
+    S(preadv);
+    S(pwritev);
     S(read);
+    S(readv);
     S(write);
+    S(writev);
 
     /*
      * Conditional syscalls.
diff --git a/linux-user/strace.list b/linux-user/strace.list
index f3a1b0fe31..f41b604c63 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1028,9 +1028,6 @@
 #ifdef TARGET_NR_pread64
 { TARGET_NR_pread64, "pread64" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_preadv
-{ TARGET_NR_preadv, "preadv" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_prlimit64
 { TARGET_NR_prlimit64, "prlimit64" , NULL, NULL, NULL },
 #endif
@@ -1058,9 +1055,6 @@
 #ifdef TARGET_NR_pwrite64
 { TARGET_NR_pwrite64, "pwrite64" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_pwritev
-{ TARGET_NR_pwritev, "pwritev" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_query_module
 { TARGET_NR_query_module, "query_module" , NULL, NULL, NULL },
 #endif
@@ -1073,9 +1067,6 @@
 #ifdef TARGET_NR_readdir
 { TARGET_NR_readdir, "readdir" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_readv
-{ TARGET_NR_readv, "readv" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_reboot
 { TARGET_NR_reboot, "reboot" , NULL, NULL, NULL },
 #endif
@@ -1608,9 +1599,6 @@
 #ifdef TARGET_NR_waitpid
 { TARGET_NR_waitpid, "waitpid" , "%s(%d,%p,%#x)", NULL, NULL },
 #endif
-#ifdef TARGET_NR_writev
-{ TARGET_NR_writev, "writev" , "%s(%d,%p,%#x)", NULL, NULL },
-#endif
 #ifdef TARGET_NR_utimensat
 { TARGET_NR_utimensat, "utimensat", NULL, print_utimensat, NULL },
 #endif
-- 
2.17.1
