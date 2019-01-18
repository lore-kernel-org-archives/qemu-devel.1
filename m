Received: from eggs.gnu.org ([209.51.188.92]:55871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbk6-0004tG-9e
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbk5-0004K3-60
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:58 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbk4-0004II-VC
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:57 -0500
Received: by mail-pl1-x642.google.com with SMTP id a14so6865602plm.12
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:31:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:45 +1100
Message-Id: <20190118213122.22865-12-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 12/49] linux-user: Split out preadv, pwritev
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
 linux-user/syscall-defs.h     |  6 ++++
 linux-user/syscall-file.inc.c | 64 +++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 49 ---------------------------
 linux-user/strace.list        |  6 ----
 4 files changed, 70 insertions(+), 55 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 027793d5d0..ae89be0e87 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -27,6 +27,12 @@ SYSCALL_DEF_FULL(pread64, .impl = impl_pread64,
 SYSCALL_DEF_FULL(pwrite64, .impl = impl_pwrite64,
                  .args = args_pread64_pwrite64,
                  .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
+SYSCALL_DEF_FULL(preadv, .impl = impl_preadv,
+                 .args = args_preadv_pwritev,
+                 .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
+SYSCALL_DEF_FULL(pwritev, .impl = impl_pwritev,
+                 .args = args_preadv_pwritev,
+                 .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
 SYSCALL_DEF(read, ARG_DEC, ARG_PTR, ARG_DEC);
 #ifdef TARGET_NR_readlink
 SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index e79cfabf56..63401684c3 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -379,6 +379,70 @@ SYSCALL_IMPL(pwrite64)
     return ret;
 }
 
+/*
+ * Both preadv and pwritev merge args 4/5 into a 64-bit offset.
+ * Moreover, the parts are *always* in little-endian order.
+ */
+#if TARGET_ABI_BITS == 32
+SYSCALL_ARGS(preadv_pwritev)
+{
+    /* We have already assigned out[0-2].  */
+    abi_ulong lo = in[3], hi = in[4];
+    out[3] = (((uint64_t)hi << (TARGET_ABI_BITS - 1)) << 1) | lo;
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
+    int fd = arg1;
+    abi_ulong target_vec = arg2;
+    int count = arg3;
+    uint64_t off = arg4;
+    struct iovec *vec = lock_iovec(VERIFY_WRITE, target_vec, count, 0);
+    unsigned long lo, hi;
+    abi_long ret;
+
+    if (vec == NULL) {
+        return -TARGET_EFAULT;
+    }
+
+    host_offset64_low_high(&lo, &hi, off);
+    ret = get_errno(safe_preadv(fd, vec, count, lo, hi));
+    unlock_iovec(vec, target_vec, count, 1);
+    return ret;
+}
+
+SYSCALL_IMPL(pwritev)
+{
+    int fd = arg1;
+    abi_ulong target_vec = arg2;
+    int count = arg3;
+    uint64_t off = arg4;
+    struct iovec *vec = lock_iovec(VERIFY_READ, target_vec, count, 1);
+    unsigned long lo, hi;
+    abi_long ret;
+
+    if (vec == NULL) {
+        return -TARGET_EFAULT;
+    }
+
+    host_offset64_low_high(&lo, &hi, off);
+    ret = get_errno(safe_pwritev(fd, vec, count, lo, hi));
+    unlock_iovec(vec, target_vec, count, 0);
+    return ret;
+}
+
 SYSCALL_IMPL(read)
 {
     int fd = arg1;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 80806c0150..9606f15a09 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2403,23 +2403,6 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
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
@@ -8949,38 +8932,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         /* NOTE: the flock constant seems to be the same for every
            Linux platform */
         return get_errno(safe_flock(arg1, arg2));
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
diff --git a/linux-user/strace.list b/linux-user/strace.list
index c7e573669d..586eb55482 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1025,9 +1025,6 @@
 #ifdef TARGET_NR_prctl
 { TARGET_NR_prctl, "prctl" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_preadv
-{ TARGET_NR_preadv, "preadv" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_prlimit64
 { TARGET_NR_prlimit64, "prlimit64" , NULL, NULL, NULL },
 #endif
@@ -1052,9 +1049,6 @@
 #ifdef TARGET_NR_putpmsg
 { TARGET_NR_putpmsg, "putpmsg" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_pwritev
-{ TARGET_NR_pwritev, "pwritev" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_query_module
 { TARGET_NR_query_module, "query_module" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
