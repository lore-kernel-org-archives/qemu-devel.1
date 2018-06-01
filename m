Received: from eggs.gnu.org ([2001:4830:134:3::10]:57316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWc-0005PS-L3
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWZ-0000EP-B0
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:02 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:35482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWZ-0000DK-07
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:30:59 -0400
Received: by mail-pl0-x244.google.com with SMTP id i5-v6so14819939plt.2
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:30:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:20 -0700
Message-Id: <20180601073050.8054-4-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 03/33] linux-user: Propagate goto ebadf to
 return
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
 linux-user/syscall.c | 187 +++++++++++++++++++++----------------------
 1 file changed, 92 insertions(+), 95 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 258aff0411..d0bf650c62 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8025,7 +8025,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             return 0;
         } else {
             if (is_hostfd(arg1)) {
-                goto ebadf;
+                return -TARGET_EBADF;
             }
             if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
                 goto efault;
@@ -8039,7 +8039,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     case TARGET_NR_write:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
             goto efault;
@@ -8070,7 +8070,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
     case TARGET_NR_openat:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         if (!(p = lock_user_string(arg2)))
             goto efault;
@@ -8083,7 +8083,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     case TARGET_NR_name_to_handle_at:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         ret = do_name_to_handle_at(arg1, arg2, arg3, arg4, arg5);
         return ret;
@@ -8091,7 +8091,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_open_by_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     case TARGET_NR_open_by_handle_at:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         ret = do_open_by_handle_at(arg1, arg2, arg3);
         fd_trans_unregister(ret);
@@ -8099,7 +8099,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
     case TARGET_NR_close:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         fd_trans_unregister(arg1);
         return get_errno(close(arg1));
@@ -8163,7 +8163,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_linkat)
     case TARGET_NR_linkat:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             void * p2 = NULL;
             if (!arg2 || !arg4)
@@ -8190,7 +8190,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_unlinkat)
     case TARGET_NR_unlinkat:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         if (!(p = lock_user_string(arg2)))
             goto efault;
@@ -8324,7 +8324,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_mknodat)
     case TARGET_NR_mknodat:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         if (!(p = lock_user_string(arg2)))
             goto efault;
@@ -8350,7 +8350,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
     case TARGET_NR_lseek:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return get_errno(lseek(arg1, arg2, arg3));
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
@@ -8497,7 +8497,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_futimesat)
     case TARGET_NR_futimesat:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             struct timeval *tvp, tv[2];
             if (arg3) {
@@ -8543,7 +8543,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_faccessat) && defined(__NR_faccessat)
     case TARGET_NR_faccessat:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         if (!(fn = lock_user_string(arg2))) {
             goto efault;
@@ -8590,7 +8590,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_renameat)
     case TARGET_NR_renameat:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             void *p2;
             p  = lock_user_string(arg2);
@@ -8607,7 +8607,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_renameat2)
     case TARGET_NR_renameat2:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             void *p2;
             p  = lock_user_string(arg2);
@@ -8633,7 +8633,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_mkdirat)
     case TARGET_NR_mkdirat:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         if (!(p = lock_user_string(arg2)))
             goto efault;
@@ -8651,7 +8651,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
     case TARGET_NR_dup:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         ret = get_errno(dup(arg1));
         if (ret >= 0) {
@@ -8752,7 +8752,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_dup2
     case TARGET_NR_dup2:
         if (is_hostfd(arg1) || is_hostfd(arg2)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         ret = get_errno(dup2(arg1, arg2));
         if (ret >= 0) {
@@ -8766,7 +8766,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         int host_flags;
 
         if (is_hostfd(arg1) || is_hostfd(arg2)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         if ((arg3 & ~TARGET_O_CLOEXEC) != 0) {
             return -EINVAL;
@@ -9370,7 +9370,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             if (contains_hostfd(&rfds) ||
                 contains_hostfd(&wfds) ||
                 contains_hostfd(&efds)) {
-                goto ebadf;
+                return -TARGET_EBADF;
             }
 
             /*
@@ -9455,7 +9455,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_symlinkat)
     case TARGET_NR_symlinkat:
         if (is_hostfd(arg2)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             void *p2;
             p  = lock_user_string(arg1);
@@ -9511,7 +9511,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_readlinkat)
     case TARGET_NR_readlinkat:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             void *p2;
             fn = lock_user_string(arg2);
@@ -9582,7 +9582,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             v6 = tswapal(v[5]);
             unlock_user(v, arg1, 0);
             if (is_hostfd(v5)) {
-                goto ebadf;
+                return -TARGET_EBADF;
             }
             ret = get_errno(target_mmap(v1, v2, v3,
                                         target_to_host_bitmask(v4, mmap_flags_tbl),
@@ -9590,7 +9590,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
 #else
         if (is_hostfd(arg5)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         ret = get_errno(target_mmap(arg1, arg2, arg3,
                                     target_to_host_bitmask(arg4, mmap_flags_tbl),
@@ -9605,7 +9605,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #define MMAP_SHIFT 12
 #endif
         if (is_hostfd(arg5)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         ret = target_mmap(arg1, arg2, arg3,
                           target_to_host_bitmask(arg4, mmap_flags_tbl),
@@ -9660,18 +9660,18 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     case TARGET_NR_ftruncate:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return get_errno(ftruncate(arg1, arg2));
     case TARGET_NR_fchmod:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return get_errno(fchmod(arg1, arg2));
 #if defined(TARGET_NR_fchmodat)
     case TARGET_NR_fchmodat:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         if (!(p = lock_user_string(arg2)))
             goto efault;
@@ -9736,7 +9736,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     case TARGET_NR_fstatfs:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         ret = get_errno(fstatfs(arg1, &stfs));
         goto convert_statfs;
@@ -9771,7 +9771,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     case TARGET_NR_fstatfs64:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         ret = get_errno(fstatfs(arg1, &stfs));
         goto convert_statfs64;
@@ -9787,117 +9787,117 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_accept
     case TARGET_NR_accept:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return do_accept4(arg1, arg2, arg3, 0);
 #endif
 #ifdef TARGET_NR_accept4
     case TARGET_NR_accept4:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return do_accept4(arg1, arg2, arg3, arg4);
 #endif
 #ifdef TARGET_NR_bind
     case TARGET_NR_bind:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return do_bind(arg1, arg2, arg3);
 #endif
 #ifdef TARGET_NR_connect
     case TARGET_NR_connect:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return do_connect(arg1, arg2, arg3);
 #endif
 #ifdef TARGET_NR_getpeername
     case TARGET_NR_getpeername:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return do_getpeername(arg1, arg2, arg3);
 #endif
 #ifdef TARGET_NR_getsockname
     case TARGET_NR_getsockname:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return do_getsockname(arg1, arg2, arg3);
 #endif
 #ifdef TARGET_NR_getsockopt
     case TARGET_NR_getsockopt:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return do_getsockopt(arg1, arg2, arg3, arg4, arg5);
 #endif
 #ifdef TARGET_NR_listen
     case TARGET_NR_listen:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return get_errno(listen(arg1, arg2));
 #endif
 #ifdef TARGET_NR_recv
     case TARGET_NR_recv:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return do_recvfrom(arg1, arg2, arg3, arg4, 0, 0);
 #endif
 #ifdef TARGET_NR_recvfrom
     case TARGET_NR_recvfrom:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return do_recvfrom(arg1, arg2, arg3, arg4, arg5, arg6);
 #endif
 #ifdef TARGET_NR_recvmsg
     case TARGET_NR_recvmsg:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return do_sendrecvmsg(arg1, arg2, arg3, 0);
 #endif
 #ifdef TARGET_NR_send
     case TARGET_NR_send:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return do_sendto(arg1, arg2, arg3, arg4, 0, 0);
 #endif
 #ifdef TARGET_NR_sendmsg
     case TARGET_NR_sendmsg:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return do_sendrecvmsg(arg1, arg2, arg3, 1);
 #endif
 #ifdef TARGET_NR_sendmmsg
     case TARGET_NR_sendmmsg:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 1);
     case TARGET_NR_recvmmsg:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 0);
 #endif
 #ifdef TARGET_NR_sendto
     case TARGET_NR_sendto:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return do_sendto(arg1, arg2, arg3, arg4, arg5, arg6);
 #endif
 #ifdef TARGET_NR_shutdown
     case TARGET_NR_shutdown:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return get_errno(shutdown(arg1, arg2));
 #endif
@@ -9922,7 +9922,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_setsockopt
     case TARGET_NR_setsockopt:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return do_setsockopt(arg1, arg2, arg3, arg4, (socklen_t) arg5);
 #endif
@@ -10031,7 +10031,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
     case TARGET_NR_fstat:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             ret = get_errno(fstat(arg1, &st));
 #if defined(TARGET_NR_stat) || defined(TARGET_NR_lstat)
@@ -10191,7 +10191,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
     case TARGET_NR_fsync:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return get_errno(fsync(arg1));
     case TARGET_NR_clone:
@@ -10304,7 +10304,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return get_errno(getpgid(arg1));
     case TARGET_NR_fchdir:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return get_errno(fchdir(arg1));
 #ifdef TARGET_NR_bdflush /* not on x86_64 */
@@ -10324,7 +10324,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR__llseek /* Not on alpha */
     case TARGET_NR__llseek:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             int64_t res;
 #if !defined(__NR_llseek)
@@ -10346,7 +10346,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_getdents
     case TARGET_NR_getdents:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
 #ifdef EMULATE_GETDENTS_WITH_GETDENTS
 #if TARGET_ABI_BITS == 32 && HOST_LONG_BITS == 64
@@ -10481,7 +10481,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_getdents64) && defined(__NR_getdents64)
     case TARGET_NR_getdents64:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             struct linux_dirent64 *dirp;
             abi_long count = arg3;
@@ -10633,12 +10633,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         /* NOTE: the flock constant seems to be the same for every
            Linux platform */
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return get_errno(safe_flock(arg1, arg2));
     case TARGET_NR_readv:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
             if (vec != NULL) {
@@ -10651,7 +10651,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     case TARGET_NR_writev:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
             if (vec != NULL) {
@@ -10665,7 +10665,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_preadv)
     case TARGET_NR_preadv:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
             if (vec != NULL) {
@@ -10683,7 +10683,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_pwritev)
     case TARGET_NR_pwritev:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
             if (vec != NULL) {
@@ -10703,7 +10703,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_fdatasync) /* Not on alpha (osf_datasync ?) */
     case TARGET_NR_fdatasync:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return get_errno(fdatasync(arg1));
 #endif
@@ -10955,7 +10955,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_pread64
     case TARGET_NR_pread64:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         if (regpairs_aligned(cpu_env, num)) {
             arg4 = arg5;
@@ -10968,7 +10968,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     case TARGET_NR_pwrite64:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         if (regpairs_aligned(cpu_env, num)) {
             arg4 = arg5;
@@ -11067,7 +11067,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         off_t off;
 
         if (is_hostfd(arg1) || is_hostfd(arg2)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         if (arg3) {
             ret = get_user_sal(off, arg3);
@@ -11092,7 +11092,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         off_t off;
 
         if (is_hostfd(arg1) || is_hostfd(arg2)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         if (arg3) {
             ret = get_user_s64(off, arg3);
@@ -11161,7 +11161,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_ftruncate64
     case TARGET_NR_ftruncate64:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
 	return target_ftruncate64(cpu_env, arg1, arg2, arg3, arg4);
 #endif
@@ -11196,7 +11196,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_fstat64
     case TARGET_NR_fstat64:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         ret = get_errno(fstat(arg1, &st));
         if (!is_error(ret))
@@ -11211,7 +11211,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_newfstatat:
 #endif
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         if (!(fn = lock_user_string(arg2))) {
             goto efault;
@@ -11299,7 +11299,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_fchownat)
     case TARGET_NR_fchownat:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         if (!(p = lock_user_string(arg2))) 
             goto efault;
@@ -11628,7 +11628,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_fchown32
     case TARGET_NR_fchown32:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return get_errno(fchown(arg1, arg2, arg3));
 #endif
@@ -11725,7 +11725,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
          * pairs of 32-bit registers.
          */
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         ret = posix_fadvise(arg1, target_offset64(arg3, arg4),
                             target_offset64(arg5, arg6), arg2);
@@ -11737,7 +11737,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_fadvise64_64
     case TARGET_NR_fadvise64_64:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
 #if defined(TARGET_PPC) || defined(TARGET_XTENSA)
         /* 6 args: fd, advice, offset (high, low), len (high, low) */
@@ -11766,7 +11766,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_fadvise64
     case TARGET_NR_fadvise64:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         /* 5 args: fd, offset (high, low), len, advice */
         if (regpairs_aligned(cpu_env, num)) {
@@ -11789,7 +11789,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_fadvise64:
 #endif
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
 #ifdef TARGET_S390X
         switch (arg4) {
@@ -11815,7 +11815,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if TARGET_ABI_BITS == 32
     case TARGET_NR_fcntl64:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
     {
 	int cmd;
@@ -11958,7 +11958,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     case TARGET_NR_fsetxattr:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             void *n, *v = 0;
             if (arg3) {
@@ -12005,7 +12005,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     case TARGET_NR_fgetxattr:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             void *n, *v = 0;
             if (arg3) {
@@ -12045,7 +12045,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     case TARGET_NR_fremovexattr:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             void *n;
             n = lock_user_string(arg2);
@@ -12190,7 +12190,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_utimensat)
     case TARGET_NR_utimensat:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             struct timespec *tsp, ts[2];
             if (!arg3) {
@@ -12239,7 +12239,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_inotify_add_watch) && defined(__NR_inotify_add_watch)
     case TARGET_NR_inotify_add_watch:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         if (!(fn = lock_user_string(arg2))) {
             goto efault;
@@ -12252,7 +12252,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_inotify_rm_watch) && defined(__NR_inotify_rm_watch)
     case TARGET_NR_inotify_rm_watch:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return get_errno(sys_inotify_rm_watch(arg1, arg2));
 #endif
@@ -12353,7 +12353,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_tee
     case TARGET_NR_tee:
         if (is_hostfd(arg1) || is_hostfd(arg2)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             ret = get_errno(tee(arg1,arg2,arg3,arg4));
         }
@@ -12362,7 +12362,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_splice
     case TARGET_NR_splice:
         if (is_hostfd(arg1) || is_hostfd(arg3)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             loff_t loff_in, loff_out;
             loff_t *ploff_in = NULL, *ploff_out = NULL;
@@ -12395,7 +12395,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_vmsplice
     case TARGET_NR_vmsplice:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
             if (vec != NULL) {
@@ -12438,7 +12438,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(CONFIG_FALLOCATE) && defined(TARGET_NR_fallocate)
     case TARGET_NR_fallocate:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
 #if TARGET_ABI_BITS == 32
         ret = get_errno(fallocate(arg1, arg2, target_offset64(arg3, arg4),
@@ -12452,7 +12452,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_sync_file_range)
     case TARGET_NR_sync_file_range:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
 #if TARGET_ABI_BITS == 32
 #if defined(TARGET_MIPS)
@@ -12471,7 +12471,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_sync_file_range2:
         /* This is like sync_file_range but the arguments are reordered */
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
 #if TARGET_ABI_BITS == 32
         ret = get_errno(sync_file_range(arg1, target_offset64(arg3, arg4),
@@ -12485,14 +12485,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_signalfd4)
     case TARGET_NR_signalfd4:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return do_signalfd4(arg1, arg2, arg4);
 #endif
 #if defined(TARGET_NR_signalfd)
     case TARGET_NR_signalfd:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return do_signalfd4(arg1, arg2, 0);
 #endif
@@ -12512,7 +12512,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         struct epoll_event *epp = 0;
 
         if (is_hostfd(arg1) || is_hostfd(arg3)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         if (arg4) {
             struct target_epoll_event *target_ep;
@@ -12547,7 +12547,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         int timeout = arg4;
 
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         if (maxevents <= 0 || maxevents > TARGET_EP_MAX_EVENTS) {
             return -TARGET_EINVAL;
@@ -12819,7 +12819,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_timerfd_gettime) && defined(CONFIG_TIMERFD)
     case TARGET_NR_timerfd_gettime:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             struct itimerspec its_curr;
 
@@ -12835,7 +12835,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_timerfd_settime) && defined(CONFIG_TIMERFD)
     case TARGET_NR_timerfd_settime:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         } else {
             struct itimerspec its_new, its_old, *p_new;
 
@@ -12870,7 +12870,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_setns) && defined(CONFIG_SETNS)
     case TARGET_NR_setns:
         if (is_hostfd(arg1)) {
-            goto ebadf;
+            return -TARGET_EBADF;
         }
         return get_errno(setns(arg1, arg2));
 #endif
@@ -12896,9 +12896,6 @@ fail:
 efault:
     ret = -TARGET_EFAULT;
     goto fail;
-ebadf:
-    ret = -TARGET_EBADF;
-    goto fail;
 }
 
 abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
-- 
2.17.0
