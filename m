Received: from eggs.gnu.org ([2001:4830:134:3::10]:38519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOWNm-00059y-Kz
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOWNj-0000nN-Ml
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:22 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOWNj-0000mY-BU
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:19 -0400
Received: by mail-pf0-x243.google.com with SMTP id x9-v6so11494872pfm.2
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 15:49:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 31 May 2018 15:49:08 -0700
Message-Id: <20180531224911.23725-4-richard.henderson@linaro.org>
In-Reply-To: <20180531224911.23725-1-richard.henderson@linaro.org>
References: <20180531224911.23725-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/6] linux-user: Check is_hostfd in do_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, evgreen@chromium.org

This is the vast majority of all fd inputs, but not all.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 303 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 280 insertions(+), 23 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d02c16bbc6..5339f0bc1c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8034,6 +8034,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         if (arg3 == 0)
             ret = 0;
         else {
+            if (is_hostfd(arg1)) {
+                goto ebadf;
+            }
             if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
                 goto efault;
             ret = get_errno(safe_read(arg1, p, arg3));
@@ -8045,6 +8048,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         }
         break;
     case TARGET_NR_write:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
             goto efault;
         if (fd_trans_target_to_host_data(arg1)) {
@@ -8072,6 +8078,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #endif
     case TARGET_NR_openat:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         if (!(p = lock_user_string(arg2)))
             goto efault;
         ret = get_errno(do_openat(cpu_env, arg1, p,
@@ -8082,16 +8091,25 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     case TARGET_NR_name_to_handle_at:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_name_to_handle_at(arg1, arg2, arg3, arg4, arg5);
         break;
 #endif
 #if defined(TARGET_NR_open_by_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     case TARGET_NR_open_by_handle_at:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_open_by_handle_at(arg1, arg2, arg3);
         fd_trans_unregister(ret);
         break;
 #endif
     case TARGET_NR_close:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         fd_trans_unregister(arg1);
         ret = get_errno(close(arg1));
         break;
@@ -8155,7 +8173,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #if defined(TARGET_NR_linkat)
     case TARGET_NR_linkat:
-        {
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        } else {
             void * p2 = NULL;
             if (!arg2 || !arg4)
                 goto efault;
@@ -8180,6 +8200,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #if defined(TARGET_NR_unlinkat)
     case TARGET_NR_unlinkat:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         if (!(p = lock_user_string(arg2)))
             goto efault;
         ret = get_errno(unlinkat(arg1, p, arg3));
@@ -8311,6 +8334,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #if defined(TARGET_NR_mknodat)
     case TARGET_NR_mknodat:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         if (!(p = lock_user_string(arg2)))
             goto efault;
         ret = get_errno(mknodat(arg1, p, arg3, arg4));
@@ -8334,6 +8360,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         goto unimplemented;
 #endif
     case TARGET_NR_lseek:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = get_errno(lseek(arg1, arg2, arg3));
         break;
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
@@ -8484,7 +8513,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #if defined(TARGET_NR_futimesat)
     case TARGET_NR_futimesat:
-        {
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        } else {
             struct timeval *tvp, tv[2];
             if (arg3) {
                 if (copy_from_user_timeval(&tv[0], arg3)
@@ -8520,6 +8551,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #if defined(TARGET_NR_faccessat) && defined(__NR_faccessat)
     case TARGET_NR_faccessat:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         if (!(p = lock_user_string(arg2)))
             goto efault;
         ret = get_errno(faccessat(arg1, p, arg3, 0));
@@ -8564,7 +8598,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #if defined(TARGET_NR_renameat)
     case TARGET_NR_renameat:
-        {
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        } else {
             void *p2;
             p  = lock_user_string(arg2);
             p2 = lock_user_string(arg4);
@@ -8579,7 +8615,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #if defined(TARGET_NR_renameat2)
     case TARGET_NR_renameat2:
-        {
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        } else {
             void *p2;
             p  = lock_user_string(arg2);
             p2 = lock_user_string(arg4);
@@ -8603,6 +8641,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #if defined(TARGET_NR_mkdirat)
     case TARGET_NR_mkdirat:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         if (!(p = lock_user_string(arg2)))
             goto efault;
         ret = get_errno(mkdirat(arg1, p, arg3));
@@ -8618,6 +8659,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #endif
     case TARGET_NR_dup:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = get_errno(dup(arg1));
         if (ret >= 0) {
             fd_trans_dup(arg1, ret);
@@ -8720,6 +8764,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_dup2
     case TARGET_NR_dup2:
+        if (is_hostfd(arg1) || is_hostfd(arg2)) {
+            goto ebadf;
+        }
         ret = get_errno(dup2(arg1, arg2));
         if (ret >= 0) {
             fd_trans_dup(arg1, arg2);
@@ -8731,6 +8778,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     {
         int host_flags;
 
+        if (is_hostfd(arg1) || is_hostfd(arg2)) {
+            goto ebadf;
+        }
         if ((arg3 & ~TARGET_O_CLOEXEC) != 0) {
             return -EINVAL;
         }
@@ -9424,7 +9474,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #if defined(TARGET_NR_symlinkat)
     case TARGET_NR_symlinkat:
-        {
+        if (is_hostfd(arg2)) {
+            goto ebadf;
+        } else {
             void *p2;
             p  = lock_user_string(arg1);
             p2 = lock_user_string(arg3);
@@ -9475,7 +9527,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #if defined(TARGET_NR_readlinkat)
     case TARGET_NR_readlinkat:
-        {
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        } else {
             void *p2;
             p  = lock_user_string(arg2);
             p2 = lock_user(VERIFY_WRITE, arg3, arg4, 0);
@@ -9619,13 +9673,22 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         unlock_user(p, arg1, 0);
         break;
     case TARGET_NR_ftruncate:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = get_errno(ftruncate(arg1, arg2));
         break;
     case TARGET_NR_fchmod:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = get_errno(fchmod(arg1, arg2));
         break;
 #if defined(TARGET_NR_fchmodat)
     case TARGET_NR_fchmodat:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         if (!(p = lock_user_string(arg2)))
             goto efault;
         ret = get_errno(fchmodat(arg1, p, arg3, 0));
@@ -9688,6 +9751,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         }
         break;
     case TARGET_NR_fstatfs:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = get_errno(fstatfs(arg1, &stfs));
         goto convert_statfs;
 #ifdef TARGET_NR_statfs64
@@ -9718,6 +9784,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         }
         break;
     case TARGET_NR_fstatfs64:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = get_errno(fstatfs(arg1, &stfs));
         goto convert_statfs64;
 #endif
@@ -9732,84 +9801,135 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_accept
     case TARGET_NR_accept:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_accept4(arg1, arg2, arg3, 0);
         break;
 #endif
 #ifdef TARGET_NR_accept4
     case TARGET_NR_accept4:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_accept4(arg1, arg2, arg3, arg4);
         break;
 #endif
 #ifdef TARGET_NR_bind
     case TARGET_NR_bind:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_bind(arg1, arg2, arg3);
         break;
 #endif
 #ifdef TARGET_NR_connect
     case TARGET_NR_connect:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_connect(arg1, arg2, arg3);
         break;
 #endif
 #ifdef TARGET_NR_getpeername
     case TARGET_NR_getpeername:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_getpeername(arg1, arg2, arg3);
         break;
 #endif
 #ifdef TARGET_NR_getsockname
     case TARGET_NR_getsockname:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_getsockname(arg1, arg2, arg3);
         break;
 #endif
 #ifdef TARGET_NR_getsockopt
     case TARGET_NR_getsockopt:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_getsockopt(arg1, arg2, arg3, arg4, arg5);
         break;
 #endif
 #ifdef TARGET_NR_listen
     case TARGET_NR_listen:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = get_errno(listen(arg1, arg2));
         break;
 #endif
 #ifdef TARGET_NR_recv
     case TARGET_NR_recv:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_recvfrom(arg1, arg2, arg3, arg4, 0, 0);
         break;
 #endif
 #ifdef TARGET_NR_recvfrom
     case TARGET_NR_recvfrom:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_recvfrom(arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 #endif
 #ifdef TARGET_NR_recvmsg
     case TARGET_NR_recvmsg:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_sendrecvmsg(arg1, arg2, arg3, 0);
         break;
 #endif
 #ifdef TARGET_NR_send
     case TARGET_NR_send:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_sendto(arg1, arg2, arg3, arg4, 0, 0);
         break;
 #endif
 #ifdef TARGET_NR_sendmsg
     case TARGET_NR_sendmsg:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_sendrecvmsg(arg1, arg2, arg3, 1);
         break;
 #endif
 #ifdef TARGET_NR_sendmmsg
     case TARGET_NR_sendmmsg:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_sendrecvmmsg(arg1, arg2, arg3, arg4, 1);
         break;
     case TARGET_NR_recvmmsg:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_sendrecvmmsg(arg1, arg2, arg3, arg4, 0);
         break;
 #endif
 #ifdef TARGET_NR_sendto
     case TARGET_NR_sendto:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_sendto(arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 #endif
 #ifdef TARGET_NR_shutdown
     case TARGET_NR_shutdown:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = get_errno(shutdown(arg1, arg2));
         break;
 #endif
@@ -9835,6 +9955,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_setsockopt
     case TARGET_NR_setsockopt:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_setsockopt(arg1, arg2, arg3, arg4, (socklen_t) arg5);
         break;
 #endif
@@ -9938,7 +10061,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         goto do_stat;
 #endif
     case TARGET_NR_fstat:
-        {
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        } else {
             ret = get_errno(fstat(arg1, &st));
 #if defined(TARGET_NR_stat) || defined(TARGET_NR_lstat)
         do_stat:
@@ -10110,6 +10235,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #endif
     case TARGET_NR_fsync:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = get_errno(fsync(arg1));
         break;
     case TARGET_NR_clone:
@@ -10225,6 +10353,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         ret = get_errno(getpgid(arg1));
         break;
     case TARGET_NR_fchdir:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = get_errno(fchdir(arg1));
         break;
 #ifdef TARGET_NR_bdflush /* not on x86_64 */
@@ -10244,7 +10375,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR__llseek /* Not on alpha */
     case TARGET_NR__llseek:
-        {
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        } else {
             int64_t res;
 #if !defined(__NR_llseek)
             res = lseek(arg1, ((uint64_t)arg2 << 32) | (abi_ulong)arg3, arg5);
@@ -10264,6 +10397,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_getdents
     case TARGET_NR_getdents:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
 #ifdef EMULATE_GETDENTS_WITH_GETDENTS
 #if TARGET_ABI_BITS == 32 && HOST_LONG_BITS == 64
         {
@@ -10396,7 +10532,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif /* TARGET_NR_getdents */
 #if defined(TARGET_NR_getdents64) && defined(__NR_getdents64)
     case TARGET_NR_getdents64:
-        {
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        } else {
             struct linux_dirent64 *dirp;
             abi_long count = arg3;
             if (!(dirp = lock_user(VERIFY_WRITE, arg2, count, 0)))
@@ -10454,10 +10592,19 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                     goto efault;
                 }
 
+                ret = 0;
                 pfd = alloca(sizeof(struct pollfd) * nfds);
                 for (i = 0; i < nfds; i++) {
                     pfd[i].fd = tswap32(target_pfd[i].fd);
                     pfd[i].events = tswap16(target_pfd[i].events);
+                    if (is_hostfd(pfd[i].fd)) {
+                        ret = -TARGET_EBADF;
+                    }
+                }
+                if (ret < 0) {
+                    unlock_user(target_pfd, arg1,
+                                sizeof(struct target_pollfd) * nfds);
+                    goto fail;
                 }
             }
 
@@ -10541,10 +10688,15 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_flock:
         /* NOTE: the flock constant seems to be the same for every
            Linux platform */
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = get_errno(safe_flock(arg1, arg2));
         break;
     case TARGET_NR_readv:
-        {
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        } else {
             struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
             if (vec != NULL) {
                 ret = get_errno(safe_readv(arg1, vec, arg3));
@@ -10555,7 +10707,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         }
         break;
     case TARGET_NR_writev:
-        {
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        } else {
             struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
             if (vec != NULL) {
                 ret = get_errno(safe_writev(arg1, vec, arg3));
@@ -10567,7 +10721,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #if defined(TARGET_NR_preadv)
     case TARGET_NR_preadv:
-        {
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        } else {
             struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
             if (vec != NULL) {
                 unsigned long low, high;
@@ -10583,7 +10739,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #if defined(TARGET_NR_pwritev)
     case TARGET_NR_pwritev:
-        {
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        } else {
             struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
             if (vec != NULL) {
                 unsigned long low, high;
@@ -10602,6 +10760,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #if defined(TARGET_NR_fdatasync) /* Not on alpha (osf_datasync ?) */
     case TARGET_NR_fdatasync:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = get_errno(fdatasync(arg1));
         break;
 #endif
@@ -10866,6 +11027,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_pread64
     case TARGET_NR_pread64:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         if (regpairs_aligned(cpu_env, num)) {
             arg4 = arg5;
             arg5 = arg6;
@@ -10876,6 +11040,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         unlock_user(p, arg2, ret);
         break;
     case TARGET_NR_pwrite64:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         if (regpairs_aligned(cpu_env, num)) {
             arg4 = arg5;
             arg5 = arg6;
@@ -10971,6 +11138,10 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     {
         off_t *offp = NULL;
         off_t off;
+
+        if (is_hostfd(arg1) || is_hostfd(arg2)) {
+            goto ebadf;
+        }
         if (arg3) {
             ret = get_user_sal(off, arg3);
             if (is_error(ret)) {
@@ -10992,6 +11163,10 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     {
         off_t *offp = NULL;
         off_t off;
+
+        if (is_hostfd(arg1) || is_hostfd(arg2)) {
+            goto ebadf;
+        }
         if (arg3) {
             ret = get_user_s64(off, arg3);
             if (is_error(ret)) {
@@ -11059,6 +11234,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_ftruncate64
     case TARGET_NR_ftruncate64:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
 	ret = target_ftruncate64(cpu_env, arg1, arg2, arg3, arg4);
 	break;
 #endif
@@ -11084,6 +11262,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_fstat64
     case TARGET_NR_fstat64:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = get_errno(fstat(arg1, &st));
         if (!is_error(ret))
             ret = host_to_target_stat64(cpu_env, arg2, &st);
@@ -11096,6 +11277,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_newfstatat
     case TARGET_NR_newfstatat:
 #endif
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         if (!(p = lock_user_string(arg2)))
             goto efault;
         ret = get_errno(fstatat(arg1, path(p), &st, arg4));
@@ -11184,6 +11368,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #if defined(TARGET_NR_fchownat)
     case TARGET_NR_fchownat:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         if (!(p = lock_user_string(arg2))) 
             goto efault;
         ret = get_errno(fchownat(arg1, p, low2highuid(arg3),
@@ -11525,6 +11712,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_fchown32
     case TARGET_NR_fchown32:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = get_errno(fchown(arg1, arg2, arg3));
         break;
 #endif
@@ -11626,6 +11816,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
          * Note that offset and len are both 64-bit so appear as
          * pairs of 32-bit registers.
          */
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = posix_fadvise(arg1, target_offset64(arg3, arg4),
                             target_offset64(arg5, arg6), arg2);
         ret = -host_to_target_errno(ret);
@@ -11636,6 +11829,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 
 #ifdef TARGET_NR_fadvise64_64
     case TARGET_NR_fadvise64_64:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
 #if defined(TARGET_PPC) || defined(TARGET_XTENSA)
         /* 6 args: fd, advice, offset (high, low), len (high, low) */
         ret = arg2;
@@ -11664,6 +11860,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 
 #ifdef TARGET_NR_fadvise64
     case TARGET_NR_fadvise64:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         /* 5 args: fd, offset (high, low), len, advice */
         if (regpairs_aligned(cpu_env, num)) {
             /* offset is in (3,4), len in 5 and advice in 6 */
@@ -11686,6 +11885,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_fadvise64
     case TARGET_NR_fadvise64:
 #endif
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
 #ifdef TARGET_S390X
         switch (arg4) {
         case 4: arg4 = POSIX_FADV_NOREUSE + 1; break; /* make sure it's an invalid value */
@@ -11711,6 +11913,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #if TARGET_ABI_BITS == 32
     case TARGET_NR_fcntl64:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
     {
 	int cmd;
 	struct flock64 fl;
@@ -11858,7 +12063,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         }
         break;
     case TARGET_NR_fsetxattr:
-        {
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        } else {
             void *n, *v = 0;
             if (arg3) {
                 v = lock_user(VERIFY_READ, arg3, arg4, 1);
@@ -11905,7 +12112,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         }
         break;
     case TARGET_NR_fgetxattr:
-        {
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        } else {
             void *n, *v = 0;
             if (arg3) {
                 v = lock_user(VERIFY_WRITE, arg3, arg4, 0);
@@ -11944,7 +12153,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         }
         break;
     case TARGET_NR_fremovexattr:
-        {
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        } else {
             void *n;
             n = lock_user_string(arg2);
             if (n) {
@@ -12095,7 +12306,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 
 #if defined(TARGET_NR_utimensat)
     case TARGET_NR_utimensat:
-        {
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        } else {
             struct timespec *tsp, ts[2];
             if (!arg3) {
                 tsp = NULL;
@@ -12141,6 +12354,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #if defined(TARGET_NR_inotify_add_watch) && defined(__NR_inotify_add_watch)
     case TARGET_NR_inotify_add_watch:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         p = lock_user_string(arg2);
         ret = get_errno(sys_inotify_add_watch(arg1, path(p), arg3));
         unlock_user(p, arg2, 0);
@@ -12148,6 +12364,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #if defined(TARGET_NR_inotify_rm_watch) && defined(__NR_inotify_rm_watch)
     case TARGET_NR_inotify_rm_watch:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = get_errno(sys_inotify_rm_watch(arg1, arg2));
         break;
 #endif
@@ -12248,14 +12467,18 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #ifdef CONFIG_SPLICE
 #ifdef TARGET_NR_tee
     case TARGET_NR_tee:
-        {
+        if (is_hostfd(arg1) || is_hostfd(arg2)) {
+            goto ebadf;
+        } else {
             ret = get_errno(tee(arg1,arg2,arg3,arg4));
         }
         break;
 #endif
 #ifdef TARGET_NR_splice
     case TARGET_NR_splice:
-        {
+        if (is_hostfd(arg1) || is_hostfd(arg3)) {
+            goto ebadf;
+        } else {
             loff_t loff_in, loff_out;
             loff_t *ploff_in = NULL, *ploff_out = NULL;
             if (arg2) {
@@ -12285,8 +12508,10 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #endif
 #ifdef TARGET_NR_vmsplice
-	case TARGET_NR_vmsplice:
-        {
+    case TARGET_NR_vmsplice:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        } else {
             struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
             if (vec != NULL) {
                 ret = get_errno(vmsplice(arg1, vec, arg3, arg4));
@@ -12327,6 +12552,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif /* CONFIG_EVENTFD  */
 #if defined(CONFIG_FALLOCATE) && defined(TARGET_NR_fallocate)
     case TARGET_NR_fallocate:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
 #if TARGET_ABI_BITS == 32
         ret = get_errno(fallocate(arg1, arg2, target_offset64(arg3, arg4),
                                   target_offset64(arg5, arg6)));
@@ -12338,6 +12566,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #if defined(CONFIG_SYNC_FILE_RANGE)
 #if defined(TARGET_NR_sync_file_range)
     case TARGET_NR_sync_file_range:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
 #if TARGET_ABI_BITS == 32
 #if defined(TARGET_MIPS)
         ret = get_errno(sync_file_range(arg1, target_offset64(arg3, arg4),
@@ -12354,6 +12585,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_sync_file_range2)
     case TARGET_NR_sync_file_range2:
         /* This is like sync_file_range but the arguments are reordered */
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
 #if TARGET_ABI_BITS == 32
         ret = get_errno(sync_file_range(arg1, target_offset64(arg3, arg4),
                                         target_offset64(arg5, arg6), arg2));
@@ -12365,11 +12599,17 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #if defined(TARGET_NR_signalfd4)
     case TARGET_NR_signalfd4:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_signalfd4(arg1, arg2, arg4);
         break;
 #endif
 #if defined(TARGET_NR_signalfd)
     case TARGET_NR_signalfd:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = do_signalfd4(arg1, arg2, 0);
         break;
 #endif
@@ -12389,6 +12629,10 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     {
         struct epoll_event ep;
         struct epoll_event *epp = 0;
+
+        if (is_hostfd(arg1) || is_hostfd(arg3)) {
+            goto ebadf;
+        }
         if (arg4) {
             struct target_epoll_event *target_ep;
             if (!lock_user_struct(VERIFY_READ, target_ep, arg4, 1)) {
@@ -12422,6 +12666,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         int maxevents = arg3;
         int timeout = arg4;
 
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         if (maxevents <= 0 || maxevents > TARGET_EP_MAX_EVENTS) {
             ret = -TARGET_EINVAL;
             break;
@@ -12698,7 +12945,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 
 #if defined(TARGET_NR_timerfd_gettime) && defined(CONFIG_TIMERFD)
     case TARGET_NR_timerfd_gettime:
-        {
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        } else {
             struct itimerspec its_curr;
 
             ret = get_errno(timerfd_gettime(arg1, &its_curr));
@@ -12712,7 +12961,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 
 #if defined(TARGET_NR_timerfd_settime) && defined(CONFIG_TIMERFD)
     case TARGET_NR_timerfd_settime:
-        {
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        } else {
             struct itimerspec its_new, its_old, *p_new;
 
             if (arg3) {
@@ -12747,6 +12998,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 
 #if defined(TARGET_NR_setns) && defined(CONFIG_SETNS)
     case TARGET_NR_setns:
+        if (is_hostfd(arg1)) {
+            goto ebadf;
+        }
         ret = get_errno(setns(arg1, arg2));
         break;
 #endif
@@ -12781,4 +13035,7 @@ fail:
 efault:
     ret = -TARGET_EFAULT;
     goto fail;
+ebadf:
+    ret = -TARGET_EBADF;
+    goto fail;
 }
-- 
2.17.0
