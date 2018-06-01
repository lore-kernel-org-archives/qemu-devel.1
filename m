Received: from eggs.gnu.org ([2001:4830:134:3::10]:57390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWi-0005Si-Fw
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWf-0000Jq-1S
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:08 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:39728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWe-0000JJ-Q8
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:04 -0400
Received: by mail-pg0-x244.google.com with SMTP id w12-v6so9663034pgc.6
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:24 -0700
Message-Id: <20180601073050.8054-8-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 07/33] linux-user: Propagate goto fail to return
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
 linux-user/syscall.c | 62 ++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 39 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 4269ec2c23..a413aad658 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9001,8 +9001,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 how = SIG_SETMASK;
                 break;
             default:
-                ret = -TARGET_EINVAL;
-                goto fail;
+                return -TARGET_EINVAL;
             }
             mask = arg2;
             target_to_host_old_sigset(&set, &mask);
@@ -9029,8 +9028,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     how = SIG_SETMASK;
                     break;
                 default:
-                    ret = -TARGET_EINVAL;
-                    goto fail;
+                    return -TARGET_EINVAL;
                 }
                 if (!(p = lock_user(VERIFY_READ, arg2, sizeof(target_sigset_t), 1)))
                     return -TARGET_EFAULT;
@@ -9073,8 +9071,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     how = SIG_SETMASK;
                     break;
                 default:
-                    ret = -TARGET_EINVAL;
-                    goto fail;
+                    return -TARGET_EINVAL;
                 }
                 if (!(p = lock_user(VERIFY_READ, arg2, sizeof(target_sigset_t), 1)))
                     return -TARGET_EFAULT;
@@ -9363,15 +9360,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
             if (ret) {
-                goto fail;
+                return ret;
             }
             ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
             if (ret) {
-                goto fail;
+                return ret;
             }
             ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
             if (ret) {
-                goto fail;
+                return ret;
             }
             if (contains_hostfd(&rfds) ||
                 contains_hostfd(&wfds) ||
@@ -9409,8 +9406,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     sig.set = &set;
                     if (arg_sigsize != sizeof(*target_sigset)) {
                         /* Like the kernel, we enforce correct size sigsets */
-                        ret = -TARGET_EINVAL;
-                        goto fail;
+                        return -TARGET_EINVAL;
                     }
                     target_sigset = lock_user(VERIFY_READ, arg_sigset,
                                               sizeof(*target_sigset), 1);
@@ -9951,18 +9947,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             case TARGET_SYSLOG_ACTION_READ_CLEAR:    /* Read/clear msgs */
             case TARGET_SYSLOG_ACTION_READ_ALL:      /* Read last messages */
                 {
-                    ret = -TARGET_EINVAL;
                     if (len < 0) {
-                        goto fail;
+                        return -TARGET_EINVAL;
                     }
-                    ret = 0;
                     if (len == 0) {
-                        return ret;
+                        return 0;
                     }
                     p = lock_user(VERIFY_WRITE, arg2, arg3, 0);
                     if (!p) {
-                        ret = -TARGET_EFAULT;
-                        goto fail;
+                        return -TARGET_EFAULT;
                     }
                     ret = get_errno(sys_syslog((int)arg1, p, (int)arg3));
                     unlock_user(p, arg2, arg3);
@@ -10363,8 +10356,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             dirp = g_try_malloc(count);
             if (!dirp) {
-                ret = -TARGET_ENOMEM;
-                goto fail;
+                return -TARGET_ENOMEM;
             }
 
             ret = get_errno(sys_getdents(arg1, dirp, count));
@@ -10556,7 +10548,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 if (ret < 0) {
                     unlock_user(target_pfd, arg1,
                                 sizeof(struct target_pollfd) * nfds);
-                    goto fail;
+                    return ret;
                 }
             }
 
@@ -10788,7 +10780,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                                        arg2 ? &node : NULL,
                                        NULL));
             if (is_error(ret)) {
-                goto fail;
+                return ret;
             }
             if (arg1 && put_user_u32(cpu, arg1)) {
                 return -TARGET_EFAULT;
@@ -11290,8 +11282,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 grouplist = alloca(gidsetsize * sizeof(gid_t));
                 target_grouplist = lock_user(VERIFY_READ, arg2, gidsetsize * sizeof(target_id), 1);
                 if (!target_grouplist) {
-                    ret = -TARGET_EFAULT;
-                    goto fail;
+                    return -TARGET_EFAULT;
                 }
                 for (i = 0; i < gidsetsize; i++) {
                     grouplist[i] = low2highgid(tswapid(target_grouplist[i]));
@@ -11552,8 +11543,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 how = SIG_SETMASK;
                 break;
             default:
-                ret = -TARGET_EINVAL;
-                goto fail;
+                return -TARGET_EINVAL;
             }
             mask = arg2;
             target_to_host_old_sigset(&set, &mask);
@@ -11601,8 +11591,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             if (!is_error(ret)) {
                 target_grouplist = lock_user(VERIFY_WRITE, arg2, gidsetsize * 4, 0);
                 if (!target_grouplist) {
-                    ret = -TARGET_EFAULT;
-                    goto fail;
+                    return -TARGET_EFAULT;
                 }
                 for(i = 0;i < ret; i++)
                     target_grouplist[i] = tswap32(grouplist[i]);
@@ -11622,8 +11611,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             grouplist = alloca(gidsetsize * sizeof(gid_t));
             target_grouplist = lock_user(VERIFY_READ, arg2, gidsetsize * 4, 1);
             if (!target_grouplist) {
-                ret = -TARGET_EFAULT;
-                goto fail;
+                return -TARGET_EFAULT;
             }
             for(i = 0;i < gidsetsize; i++)
                 grouplist[i] = tswap32(target_grouplist[i]);
@@ -11704,20 +11692,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_mincore
     case TARGET_NR_mincore:
         {
-            void *a;
-            ret = -TARGET_ENOMEM;
-            a = lock_user(VERIFY_READ, arg1, arg2, 0);
+            void *a = lock_user(VERIFY_READ, arg1, arg2, 0);
             if (!a) {
-                goto fail;
+                return -TARGET_ENOMEM;
             }
-            ret = -TARGET_EFAULT;
             p = lock_user_string(arg3);
             if (!p) {
-                goto mincore_fail;
+                ret = -TARGET_EFAULT;
+            } else {
+                ret = get_errno(mincore(a, arg2, p));
+                unlock_user(p, arg3, ret);
             }
-            ret = get_errno(mincore(a, arg2, p));
-            unlock_user(p, arg3, ret);
-            mincore_fail:
             unlock_user(a, arg1, 0);
         }
         return ret;
@@ -12892,7 +12877,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     default:
         return do_unimplemented(num);
     }
-fail:
     return ret;
 }
 
-- 
2.17.0
