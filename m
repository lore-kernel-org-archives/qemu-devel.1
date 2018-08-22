Received: from eggs.gnu.org ([2001:4830:134:3::10]:36502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsHk3-00073T-V7
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsHjv-0001uv-4g
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:15:20 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56341)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fsHjs-0001sb-Tg
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:15:14 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 22 Aug 2018 03:14:17 +0200
Message-Id: <20180822011417.11608-8-laurent@vivier.eu>
In-Reply-To: <20180822011417.11608-1-laurent@vivier.eu>
References: <20180822011417.11608-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 7/7] linux-user: Propagate goto fail to return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180818190118.12911-8-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 60 ++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 38 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 57044cf546..02fba7606d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9016,8 +9016,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 how = SIG_SETMASK;
                 break;
             default:
-                ret = -TARGET_EINVAL;
-                goto fail;
+                return -TARGET_EINVAL;
             }
             mask = arg2;
             target_to_host_old_sigset(&set, &mask);
@@ -9044,8 +9043,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     how = SIG_SETMASK;
                     break;
                 default:
-                    ret = -TARGET_EINVAL;
-                    goto fail;
+                    return -TARGET_EINVAL;
                 }
                 if (!(p = lock_user(VERIFY_READ, arg2, sizeof(target_sigset_t), 1)))
                     return -TARGET_EFAULT;
@@ -9088,8 +9086,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     how = SIG_SETMASK;
                     break;
                 default:
-                    ret = -TARGET_EINVAL;
-                    goto fail;
+                    return -TARGET_EINVAL;
                 }
                 if (!(p = lock_user(VERIFY_READ, arg2, sizeof(target_sigset_t), 1)))
                     return -TARGET_EFAULT;
@@ -9379,15 +9376,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
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
@@ -9420,8 +9417,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     sig.set = &set;
                     if (arg_sigsize != sizeof(*target_sigset)) {
                         /* Like the kernel, we enforce correct size sigsets */
-                        ret = -TARGET_EINVAL;
-                        goto fail;
+                        return -TARGET_EINVAL;
                     }
                     target_sigset = lock_user(VERIFY_READ, arg_sigset,
                                               sizeof(*target_sigset), 1);
@@ -9860,17 +9856,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -10215,8 +10209,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             dirp = g_try_malloc(count);
             if (!dirp) {
-                ret = -TARGET_ENOMEM;
-                goto fail;
+                return -TARGET_ENOMEM;
             }
 
             ret = get_errno(sys_getdents(arg1, dirp, count));
@@ -10616,7 +10609,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                                        arg2 ? &node : NULL,
                                        NULL));
             if (is_error(ret)) {
-                goto fail;
+                return ret;
             }
             if (arg1 && put_user_u32(cpu, arg1)) {
                 return -TARGET_EFAULT;
@@ -11072,8 +11065,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 grouplist = alloca(gidsetsize * sizeof(gid_t));
                 target_grouplist = lock_user(VERIFY_READ, arg2, gidsetsize * sizeof(target_id), 1);
                 if (!target_grouplist) {
-                    ret = -TARGET_EFAULT;
-                    goto fail;
+                    return -TARGET_EFAULT;
                 }
                 for (i = 0; i < gidsetsize; i++) {
                     grouplist[i] = low2highgid(tswapid(target_grouplist[i]));
@@ -11331,8 +11323,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 how = SIG_SETMASK;
                 break;
             default:
-                ret = -TARGET_EINVAL;
-                goto fail;
+                return -TARGET_EINVAL;
             }
             mask = arg2;
             target_to_host_old_sigset(&set, &mask);
@@ -11380,8 +11371,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             if (!is_error(ret)) {
                 target_grouplist = lock_user(VERIFY_WRITE, arg2, gidsetsize * 4, 0);
                 if (!target_grouplist) {
-                    ret = -TARGET_EFAULT;
-                    goto fail;
+                    return -TARGET_EFAULT;
                 }
                 for(i = 0;i < ret; i++)
                     target_grouplist[i] = tswap32(grouplist[i]);
@@ -11401,8 +11391,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             grouplist = alloca(gidsetsize * sizeof(gid_t));
             target_grouplist = lock_user(VERIFY_READ, arg2, gidsetsize * 4, 1);
             if (!target_grouplist) {
-                ret = -TARGET_EFAULT;
-                goto fail;
+                return -TARGET_EFAULT;
             }
             for(i = 0;i < gidsetsize; i++)
                 grouplist[i] = tswap32(target_grouplist[i]);
@@ -11477,20 +11466,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11956,8 +11942,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = get_errno(sys_utimensat(arg1, NULL, tsp, arg4));
             else {
                 if (!(p = lock_user_string(arg2))) {
-                    ret = -TARGET_EFAULT;
-                    goto fail;
+                    return -TARGET_EFAULT;
                 }
                 ret = get_errno(sys_utimensat(arg1, path(p), tsp, arg4));
                 unlock_user(p, arg2, 0);
@@ -12599,7 +12584,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
         return -TARGET_ENOSYS;
     }
-fail:
     return ret;
 }
 
-- 
2.17.1
