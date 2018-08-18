Received: from eggs.gnu.org ([2001:4830:134:3::10]:55233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6Td-0005Gj-CK
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6Tc-0007B7-91
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:33 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fr6Tb-0007Aa-Vy
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:32 -0400
Received: by mail-pg1-x542.google.com with SMTP id r64-v6so3779941pgr.0
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 12:01:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 18 Aug 2018 12:01:09 -0700
Message-Id: <20180818190118.12911-8-richard.henderson@linaro.org>
In-Reply-To: <20180818190118.12911-1-richard.henderson@linaro.org>
References: <20180818190118.12911-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 07/16] linux-user: Propagate goto fail to
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 60 ++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 38 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ef3b9b623c..4ae608fb19 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8910,8 +8910,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 how = SIG_SETMASK;
                 break;
             default:
-                ret = -TARGET_EINVAL;
-                goto fail;
+                return -TARGET_EINVAL;
             }
             mask = arg2;
             target_to_host_old_sigset(&set, &mask);
@@ -8938,8 +8937,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     how = SIG_SETMASK;
                     break;
                 default:
-                    ret = -TARGET_EINVAL;
-                    goto fail;
+                    return -TARGET_EINVAL;
                 }
                 if (!(p = lock_user(VERIFY_READ, arg2, sizeof(target_sigset_t), 1)))
                     return -TARGET_EFAULT;
@@ -8982,8 +8980,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     how = SIG_SETMASK;
                     break;
                 default:
-                    ret = -TARGET_EINVAL;
-                    goto fail;
+                    return -TARGET_EINVAL;
                 }
                 if (!(p = lock_user(VERIFY_READ, arg2, sizeof(target_sigset_t), 1)))
                     return -TARGET_EFAULT;
@@ -9273,15 +9270,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
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
 
             /*
@@ -9314,8 +9311,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     sig.set = &set;
                     if (arg_sigsize != sizeof(*target_sigset)) {
                         /* Like the kernel, we enforce correct size sigsets */
-                        ret = -TARGET_EINVAL;
-                        goto fail;
+                        return -TARGET_EINVAL;
                     }
                     target_sigset = lock_user(VERIFY_READ, arg_sigset,
                                               sizeof(*target_sigset), 1);
@@ -9754,17 +9750,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             case TARGET_SYSLOG_ACTION_READ_CLEAR:    /* Read/clear msgs */
             case TARGET_SYSLOG_ACTION_READ_ALL:      /* Read last messages */
                 {
-                    ret = -TARGET_EINVAL;
                     if (len < 0) {
-                        goto fail;
+                        return -TARGET_EINVAL;
                     }
                     if (len == 0) {
                         return 0;
                     }
                     p = lock_user(VERIFY_WRITE, arg2, arg3, 0);
                     if (!p) {
-                        ret = -TARGET_EFAULT;
-                        goto fail;
+                        return -TARGET_EFAULT;
                     }
                     ret = get_errno(sys_syslog((int)arg1, p, (int)arg3));
                     unlock_user(p, arg2, arg3);
@@ -10109,8 +10103,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             dirp = g_try_malloc(count);
             if (!dirp) {
-                ret = -TARGET_ENOMEM;
-                goto fail;
+                return -TARGET_ENOMEM;
             }
 
             ret = get_errno(sys_getdents(arg1, dirp, count));
@@ -10510,7 +10503,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                                        arg2 ? &node : NULL,
                                        NULL));
             if (is_error(ret)) {
-                goto fail;
+                return ret;
             }
             if (arg1 && put_user_u32(cpu, arg1)) {
                 return -TARGET_EFAULT;
@@ -10966,8 +10959,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 grouplist = alloca(gidsetsize * sizeof(gid_t));
                 target_grouplist = lock_user(VERIFY_READ, arg2, gidsetsize * sizeof(target_id), 1);
                 if (!target_grouplist) {
-                    ret = -TARGET_EFAULT;
-                    goto fail;
+                    return -TARGET_EFAULT;
                 }
                 for (i = 0; i < gidsetsize; i++) {
                     grouplist[i] = low2highgid(tswapid(target_grouplist[i]));
@@ -11225,8 +11217,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 how = SIG_SETMASK;
                 break;
             default:
-                ret = -TARGET_EINVAL;
-                goto fail;
+                return -TARGET_EINVAL;
             }
             mask = arg2;
             target_to_host_old_sigset(&set, &mask);
@@ -11274,8 +11265,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             if (!is_error(ret)) {
                 target_grouplist = lock_user(VERIFY_WRITE, arg2, gidsetsize * 4, 0);
                 if (!target_grouplist) {
-                    ret = -TARGET_EFAULT;
-                    goto fail;
+                    return -TARGET_EFAULT;
                 }
                 for(i = 0;i < ret; i++)
                     target_grouplist[i] = tswap32(grouplist[i]);
@@ -11295,8 +11285,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             grouplist = alloca(gidsetsize * sizeof(gid_t));
             target_grouplist = lock_user(VERIFY_READ, arg2, gidsetsize * 4, 1);
             if (!target_grouplist) {
-                ret = -TARGET_EFAULT;
-                goto fail;
+                return -TARGET_EFAULT;
             }
             for(i = 0;i < gidsetsize; i++)
                 grouplist[i] = tswap32(target_grouplist[i]);
@@ -11371,20 +11360,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11850,8 +11836,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = get_errno(sys_utimensat(arg1, NULL, tsp, arg4));
             else {
                 if (!(p = lock_user_string(arg2))) {
-                    ret = -TARGET_EFAULT;
-                    goto fail;
+                    return -TARGET_EFAULT;
                 }
                 ret = get_errno(sys_utimensat(arg1, path(p), tsp, arg4));
                 unlock_user(p, arg2, 0);
@@ -12493,7 +12478,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
         return -TARGET_ENOSYS;
     }
-fail:
     return ret;
 }
 
-- 
2.17.1
