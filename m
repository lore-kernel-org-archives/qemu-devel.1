Received: from eggs.gnu.org ([2001:4830:134:3::10]:57728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeXE-0005x0-Ai
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeXD-0000sR-01
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:40 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:43585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeXC-0000ro-P1
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:38 -0400
Received: by mail-pg0-x241.google.com with SMTP id p8-v6so10867837pgq.10
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:48 -0700
Message-Id: <20180601073050.8054-32-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 31/33] linux-user: Split out rt_sigprocmask,
 sgetmask, sigprocmask, ssetmask
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
 linux-user/syscall.c | 294 +++++++++++++++++++++++--------------------
 1 file changed, 158 insertions(+), 136 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 36e2bb838e..e37a3ab643 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8805,6 +8805,65 @@ IMPL(rt_sigaction)
     return ret;
 }
 
+IMPL(rt_sigprocmask)
+{
+    int how = 0;
+    sigset_t set, oldset, *set_ptr = NULL;
+    abi_long ret;
+    target_sigset_t *p;
+
+    if (arg4 != sizeof(target_sigset_t)) {
+        return -TARGET_EINVAL;
+    }
+
+    if (arg2) {
+        switch (arg1) {
+        case TARGET_SIG_BLOCK:
+            how = SIG_BLOCK;
+            break;
+        case TARGET_SIG_UNBLOCK:
+            how = SIG_UNBLOCK;
+            break;
+        case TARGET_SIG_SETMASK:
+            how = SIG_SETMASK;
+            break;
+        default:
+            return -TARGET_EINVAL;
+        }
+        p = lock_user(VERIFY_READ, arg2, sizeof(target_sigset_t), 1);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        target_to_host_sigset(&set, p);
+        unlock_user(p, arg2, 0);
+        set_ptr = &set;
+    }
+    ret = do_sigprocmask(how, set_ptr, &oldset);
+    if (!is_error(ret) && arg3) {
+        p = lock_user(VERIFY_WRITE, arg3, sizeof(target_sigset_t), 0);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        host_to_target_sigset(p, &oldset);
+        unlock_user(p, arg3, sizeof(target_sigset_t));
+    }
+    return ret;
+}
+
+#ifdef TARGET_NR_sgetmask
+IMPL(sgetmask)
+{
+    sigset_t cur_set;
+    abi_ulong target_set;
+    abi_long ret = do_sigprocmask(0, NULL, &cur_set);
+    if (!ret) {
+        host_to_target_old_sigset(&target_set, &cur_set);
+        ret = target_set;
+    }
+    return ret;
+}
+#endif
+
 IMPL(setpgid)
 {
     return get_errno(setpgid(arg1, arg2));
@@ -8901,6 +8960,95 @@ IMPL(sigaction)
 }
 #endif
 
+#ifdef TARGET_NR_sigprocmask
+IMPL(sigprocmask)
+{
+    abi_long ret;
+# ifdef TARGET_ALPHA
+    sigset_t set, oldset;
+    abi_ulong mask;
+    int how;
+
+    switch (arg1) {
+    case TARGET_SIG_BLOCK:
+        how = SIG_BLOCK;
+        break;
+    case TARGET_SIG_UNBLOCK:
+        how = SIG_UNBLOCK;
+        break;
+    case TARGET_SIG_SETMASK:
+        how = SIG_SETMASK;
+        break;
+    default:
+        return -TARGET_EINVAL;
+    }
+    mask = arg2;
+    target_to_host_old_sigset(&set, &mask);
+
+    ret = do_sigprocmask(how, &set, &oldset);
+    if (!is_error(ret)) {
+        host_to_target_old_sigset(&mask, &oldset);
+        ret = mask;
+        ((CPUAlphaState *)cpu_env)->ir[IR_V0] = 0; /* force no error */
+    }
+# else
+    sigset_t set, oldset, *set_ptr = NULL;
+    int how = 0;
+    abi_ulong *p;
+
+    if (arg2) {
+        switch (arg1) {
+        case TARGET_SIG_BLOCK:
+            how = SIG_BLOCK;
+            break;
+        case TARGET_SIG_UNBLOCK:
+            how = SIG_UNBLOCK;
+            break;
+        case TARGET_SIG_SETMASK:
+            how = SIG_SETMASK;
+            break;
+        default:
+            return -TARGET_EINVAL;
+        }
+        p = lock_user(VERIFY_READ, arg2, sizeof(target_sigset_t), 1);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        target_to_host_old_sigset(&set, p);
+        unlock_user(p, arg2, 0);
+        set_ptr = &set;
+    }
+    ret = do_sigprocmask(how, set_ptr, &oldset);
+    if (!is_error(ret) && arg3) {
+        p = lock_user(VERIFY_WRITE, arg3, sizeof(target_sigset_t), 0);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        host_to_target_old_sigset(p, &oldset);
+        unlock_user(p, arg3, sizeof(target_sigset_t));
+    }
+# endif
+    return ret;
+}
+#endif
+
+#ifdef TARGET_NR_ssetmask
+IMPL(ssetmask)
+{
+    sigset_t set, oset;
+    abi_ulong target_set = arg1;
+    abi_long ret;
+
+    target_to_host_old_sigset(&set, &target_set);
+    ret = do_sigprocmask(SIG_SETMASK, &set, &oset);
+    if (!ret) {
+        host_to_target_old_sigset(&target_set, &oset);
+        ret = target_set;
+    }
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_stime
 IMPL(stime)
 {
@@ -9152,142 +9300,6 @@ IMPL(everything_else)
     char *fn;
 
     switch(num) {
-#ifdef TARGET_NR_sgetmask /* not on alpha */
-    case TARGET_NR_sgetmask:
-        {
-            sigset_t cur_set;
-            abi_ulong target_set;
-            ret = do_sigprocmask(0, NULL, &cur_set);
-            if (!ret) {
-                host_to_target_old_sigset(&target_set, &cur_set);
-                ret = target_set;
-            }
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_ssetmask /* not on alpha */
-    case TARGET_NR_ssetmask:
-        {
-            sigset_t set, oset;
-            abi_ulong target_set = arg1;
-            target_to_host_old_sigset(&set, &target_set);
-            ret = do_sigprocmask(SIG_SETMASK, &set, &oset);
-            if (!ret) {
-                host_to_target_old_sigset(&target_set, &oset);
-                ret = target_set;
-            }
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_sigprocmask
-    case TARGET_NR_sigprocmask:
-        {
-#if defined(TARGET_ALPHA)
-            sigset_t set, oldset;
-            abi_ulong mask;
-            int how;
-
-            switch (arg1) {
-            case TARGET_SIG_BLOCK:
-                how = SIG_BLOCK;
-                break;
-            case TARGET_SIG_UNBLOCK:
-                how = SIG_UNBLOCK;
-                break;
-            case TARGET_SIG_SETMASK:
-                how = SIG_SETMASK;
-                break;
-            default:
-                return -TARGET_EINVAL;
-            }
-            mask = arg2;
-            target_to_host_old_sigset(&set, &mask);
-
-            ret = do_sigprocmask(how, &set, &oldset);
-            if (!is_error(ret)) {
-                host_to_target_old_sigset(&mask, &oldset);
-                ret = mask;
-                ((CPUAlphaState *)cpu_env)->ir[IR_V0] = 0; /* force no error */
-            }
-#else
-            sigset_t set, oldset, *set_ptr;
-            int how;
-
-            if (arg2) {
-                switch (arg1) {
-                case TARGET_SIG_BLOCK:
-                    how = SIG_BLOCK;
-                    break;
-                case TARGET_SIG_UNBLOCK:
-                    how = SIG_UNBLOCK;
-                    break;
-                case TARGET_SIG_SETMASK:
-                    how = SIG_SETMASK;
-                    break;
-                default:
-                    return -TARGET_EINVAL;
-                }
-                if (!(p = lock_user(VERIFY_READ, arg2, sizeof(target_sigset_t), 1)))
-                    return -TARGET_EFAULT;
-                target_to_host_old_sigset(&set, p);
-                unlock_user(p, arg2, 0);
-                set_ptr = &set;
-            } else {
-                how = 0;
-                set_ptr = NULL;
-            }
-            ret = do_sigprocmask(how, set_ptr, &oldset);
-            if (!is_error(ret) && arg3) {
-                if (!(p = lock_user(VERIFY_WRITE, arg3, sizeof(target_sigset_t), 0)))
-                    return -TARGET_EFAULT;
-                host_to_target_old_sigset(p, &oldset);
-                unlock_user(p, arg3, sizeof(target_sigset_t));
-            }
-#endif
-        }
-        return ret;
-#endif
-    case TARGET_NR_rt_sigprocmask:
-        {
-            int how = arg1;
-            sigset_t set, oldset, *set_ptr;
-
-            if (arg4 != sizeof(target_sigset_t)) {
-                return -TARGET_EINVAL;
-            }
-
-            if (arg2) {
-                switch(how) {
-                case TARGET_SIG_BLOCK:
-                    how = SIG_BLOCK;
-                    break;
-                case TARGET_SIG_UNBLOCK:
-                    how = SIG_UNBLOCK;
-                    break;
-                case TARGET_SIG_SETMASK:
-                    how = SIG_SETMASK;
-                    break;
-                default:
-                    return -TARGET_EINVAL;
-                }
-                if (!(p = lock_user(VERIFY_READ, arg2, sizeof(target_sigset_t), 1)))
-                    return -TARGET_EFAULT;
-                target_to_host_sigset(&set, p);
-                unlock_user(p, arg2, 0);
-                set_ptr = &set;
-            } else {
-                how = 0;
-                set_ptr = NULL;
-            }
-            ret = do_sigprocmask(how, set_ptr, &oldset);
-            if (!is_error(ret) && arg3) {
-                if (!(p = lock_user(VERIFY_WRITE, arg3, sizeof(target_sigset_t), 0)))
-                    return -TARGET_EFAULT;
-                host_to_target_sigset(p, &oldset);
-                unlock_user(p, arg3, sizeof(target_sigset_t));
-            }
-        }
-        return ret;
 #ifdef TARGET_NR_sigpending
     case TARGET_NR_sigpending:
         {
@@ -13100,11 +13112,21 @@ static impl_fn * const syscall_table[] = {
     [TARGET_NR_rmdir] = impl_rmdir,
 #endif
     [TARGET_NR_rt_sigaction] = impl_rt_sigaction,
+    [TARGET_NR_rt_sigprocmask] = impl_rt_sigprocmask,
+#ifdef TARGET_NR_sgetmask
+    [TARGET_NR_sgetmask] = impl_sgetmask,
+#endif
     [TARGET_NR_setpgid] = impl_setpgid,
     [TARGET_NR_setsid] = impl_setsid,
 #ifdef TARGET_NR_sigaction
     [TARGET_NR_sigaction] = impl_sigaction,
 #endif
+#ifdef TARGET_NR_sigprocmask
+    [TARGET_NR_sigprocmask] = impl_sigprocmask,
+#endif
+#ifdef TARGET_NR_ssetmask
+    [TARGET_NR_ssetmask] = impl_ssetmask,
+#endif
 #ifdef TARGET_NR_stime
     [TARGET_NR_stime] = impl_stime,
 #endif
-- 
2.17.0
