Received: from eggs.gnu.org ([2001:4830:134:3::10]:59372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXXu-0005KO-3N
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXXs-0007fY-3Q
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:26 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSXXr-0007ep-SA
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:24 -0400
Received: by mail-pg0-x242.google.com with SMTP id m5-v6so10589323pgd.3
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 17:52:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Jun 2018 14:51:40 -1000
Message-Id: <20180612005145.3375-15-richard.henderson@linaro.org>
In-Reply-To: <20180612005145.3375-1-richard.henderson@linaro.org>
References: <20180612005145.3375-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 14/19] linux-user: Split out preadv, pwritev,
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
Cc: laurent@vivier.eu, peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.h           |   5 ++
 linux-user/syscall.c           |  85 ++-------------------------
 linux-user/syscall_file.c      | 103 +++++++++++++++++++++++++++++++++
 linux-user/gen_syscall_list.py |   4 ++
 linux-user/strace.list         |  12 ----
 5 files changed, 116 insertions(+), 93 deletions(-)

diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index e35b0a60f5..3fc49d5b65 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -169,6 +169,11 @@ static inline void fd_trans_unregister(int fd)
     }
 }
 
+struct iovec *lock_iovec(int type, abi_ulong target_addr,
+                         abi_ulong count, int copy);
+void unlock_iovec(struct iovec *vec, abi_ulong target_addr,
+                  abi_ulong count, int copy);
+
 /* Temporary declarations from syscall_foo.c back to main syscall.c.
  * These indicate incomplete conversion.
  */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c47e73de5f..381ee9c3a2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -856,12 +856,6 @@ safe_syscall2(int, rt_sigsuspend, sigset_t *, newset, size_t, sigsetsize)
 safe_syscall2(int, kill, pid_t, pid, int, sig)
 safe_syscall2(int, tkill, int, tid, int, sig)
 safe_syscall3(int, tgkill, int, tgid, int, pid, int, sig)
-safe_syscall3(ssize_t, readv, int, fd, const struct iovec *, iov, int, iovcnt)
-safe_syscall3(ssize_t, writev, int, fd, const struct iovec *, iov, int, iovcnt)
-safe_syscall5(ssize_t, preadv, int, fd, const struct iovec *, iov, int, iovcnt,
-              unsigned long, pos_l, unsigned long, pos_h)
-safe_syscall5(ssize_t, pwritev, int, fd, const struct iovec *, iov, int, iovcnt,
-              unsigned long, pos_l, unsigned long, pos_h)
 safe_syscall3(int, connect, int, fd, const struct sockaddr *, addr,
               socklen_t, addrlen)
 safe_syscall6(ssize_t, sendto, int, fd, const void *, buf, size_t, len,
@@ -3317,25 +3311,8 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
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
-static struct iovec *lock_iovec(int type, abi_ulong target_addr,
-                                abi_ulong count, int copy)
+struct iovec *lock_iovec(int type, abi_ulong target_addr,
+                         abi_ulong count, int copy)
 {
     struct target_iovec *target_vec;
     struct iovec *vec;
@@ -3422,8 +3399,8 @@ static struct iovec *lock_iovec(int type, abi_ulong target_addr,
     return NULL;
 }
 
-static void unlock_iovec(struct iovec *vec, abi_ulong target_addr,
-                         abi_ulong count, int copy)
+void unlock_iovec(struct iovec *vec, abi_ulong target_addr,
+                  abi_ulong count, int copy)
 {
     struct target_iovec *target_vec;
     int i;
@@ -9859,60 +9836,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
diff --git a/linux-user/syscall_file.c b/linux-user/syscall_file.c
index d11128787f..4cc7051847 100644
--- a/linux-user/syscall_file.c
+++ b/linux-user/syscall_file.c
@@ -26,8 +26,14 @@
 
 safe_syscall4(int, openat, int, dirfd, const char *, pathname, \
               int, flags, mode_t, mode)
+safe_syscall5(ssize_t, preadv, int, fd, const struct iovec *, iov,
+              int, iovcnt, unsigned long, pos_l, unsigned long, pos_h)
+safe_syscall5(ssize_t, pwritev, int, fd, const struct iovec *, iov,
+              int, iovcnt, unsigned long, pos_l, unsigned long, pos_h)
 safe_syscall3(ssize_t, read, int, fd, void *, buff, size_t, count)
+safe_syscall3(ssize_t, readv, int, fd, const struct iovec *, iov, int, iovcnt)
 safe_syscall3(ssize_t, write, int, fd, const void *, buff, size_t, count)
+safe_syscall3(ssize_t, writev, int, fd, const struct iovec *, iov, int, iovcnt)
 
 bitmask_transtbl const fcntl_flags_tbl[] = {
   { TARGET_O_ACCMODE,   TARGET_O_WRONLY,    O_ACCMODE,   O_WRONLY,    },
@@ -372,6 +378,75 @@ SYSCALL_IMPL(openat)
 }
 SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 
+/* Both preadv and pwritev merge args 4/5 into a 64-bit offset.
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
+const SyscallDef def_preadv = {
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
+const SyscallDef def_pwritev = {
+    .name = "pwritev",
+    .args = args_preadv_pwritev,
+    .impl = impl_pwritev,
+    .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 }
+};
+
 SYSCALL_IMPL(read)
 {
     abi_long ret;
@@ -397,6 +472,20 @@ SYSCALL_IMPL(read)
 }
 SYSCALL_DEF(read, ARG_DEC, ARG_PTR, ARG_DEC);
 
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
@@ -421,3 +510,17 @@ SYSCALL_IMPL(write)
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
diff --git a/linux-user/gen_syscall_list.py b/linux-user/gen_syscall_list.py
index 3d223e3468..ce6dca742c 100644
--- a/linux-user/gen_syscall_list.py
+++ b/linux-user/gen_syscall_list.py
@@ -27,8 +27,12 @@ import sys
 unconditional_syscalls = [
     "close",
     "openat",
+    "preadv",
+    "pwritev",
     "read",
+    "readv",
     "write",
+    "writev",
 ]
 
 # These syscalls are only supported by some target or abis.
diff --git a/linux-user/strace.list b/linux-user/strace.list
index baafa28370..d5ee55ac82 100644
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
@@ -1079,9 +1073,6 @@
 #ifdef TARGET_NR_readlinkat
 { TARGET_NR_readlinkat, "readlinkat" , NULL, print_readlinkat, NULL },
 #endif
-#ifdef TARGET_NR_readv
-{ TARGET_NR_readv, "readv" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_reboot
 { TARGET_NR_reboot, "reboot" , NULL, NULL, NULL },
 #endif
@@ -1614,9 +1605,6 @@
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
