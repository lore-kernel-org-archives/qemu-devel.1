Received: from eggs.gnu.org ([2001:4830:134:3::10]:41512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfw-0004b2-HI
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfv-0004kU-Ax
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:52 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:33749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfv-0004k3-2B
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:51 -0400
Received: by mail-pl0-x243.google.com with SMTP id n10-v6so10392412plp.0
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:12 -1000
Message-Id: <20180610030220.3777-101-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 100/108] linux-user: Split out epoll syscalls
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

This includes epoll_create, epoll_create1, epoll_ctl,
epoll_pwait, epoll_wait.  All targets define epoll_create1,
epoll_ctl, epoll_pwait; remove those ifdefs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 244 +++++++++++++++++++++++--------------------
 1 file changed, 128 insertions(+), 116 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e630a43f97..9ce37c1119 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7897,6 +7897,123 @@ IMPL(dup3)
     return ret;
 }
 
+#ifdef CONFIG_EPOLL
+# ifdef TARGET_NR_epoll_create
+IMPL(epoll_create)
+{
+    return get_errno(epoll_create(arg1));
+}
+# endif
+
+IMPL(epoll_create1)
+{
+# ifdef CONFIG_EPOLL_CREATE1
+    return get_errno(epoll_create1(arg1));
+# else
+    /* If flags are 0, we can emulate with epoll_create.
+     * The size argument is ignored after linux 2.6.8,
+     * other than verifying that it is positive.
+     */
+    if (arg1 == 0) {
+        return get_errno(epoll_create(1));
+    }
+    return -TARGET_ENOSYS;
+# endif
+}
+
+IMPL(epoll_ctl)
+{
+    struct epoll_event ep;
+    struct epoll_event *epp = 0;
+
+    if (arg4) {
+        struct target_epoll_event *target_ep;
+        if (!lock_user_struct(VERIFY_READ, target_ep, arg4, 1)) {
+            return -TARGET_EFAULT;
+        }
+        ep.events = tswap32(target_ep->events);
+        /* The epoll_data_t union is just opaque data to the kernel,
+         * so we transfer all 64 bits across and need not worry what
+         * actual data type it is.
+         */
+        ep.data.u64 = tswap64(target_ep->data.u64);
+        unlock_user_struct(target_ep, arg4, 0);
+        epp = &ep;
+    }
+    return get_errno(epoll_ctl(arg1, arg2, arg3, epp));
+}
+
+IMPL(epoll_pwait_wait)
+{
+    struct target_epoll_event *target_ep;
+    struct epoll_event *ep;
+    int epfd = arg1;
+    int maxevents = arg3;
+    int timeout = arg4;
+    abi_long ret;
+
+    if (maxevents <= 0 || maxevents > TARGET_EP_MAX_EVENTS) {
+        return -TARGET_EINVAL;
+    }
+
+    target_ep = lock_user(VERIFY_WRITE, arg2,
+                          maxevents * sizeof(struct target_epoll_event), 1);
+    if (!target_ep) {
+        return -TARGET_EFAULT;
+    }
+
+    ep = g_try_new(struct epoll_event, maxevents);
+    if (!ep) {
+        unlock_user(target_ep, arg2, 0);
+        return -TARGET_ENOMEM;
+    }
+
+    switch (num) {
+    default: /* TARGET_NR_epoll_pwait */
+        if (arg5) {
+            target_sigset_t *target_set;
+            sigset_t set;
+
+            if (arg6 != sizeof(target_sigset_t)) {
+                ret = -TARGET_EINVAL;
+                break;
+            }
+            target_set = lock_user(VERIFY_READ, arg5,
+                                   sizeof(target_sigset_t), 1);
+            if (!target_set) {
+                ret = -TARGET_EFAULT;
+                break;
+            }
+            target_to_host_sigset(&set, target_set);
+            unlock_user(target_set, arg5, 0);
+
+            ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, timeout,
+                                             &set, SIGSET_T_SIZE));
+            break;
+        }
+        /* fallthru */
+# ifdef TARGET_NR_epoll_wait
+    case TARGET_NR_epoll_wait:
+# endif
+        ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents,
+                                         timeout, NULL, 0));
+        break;
+    }
+    if (!is_error(ret)) {
+        int i;
+        for (i = 0; i < ret; i++) {
+            target_ep[i].events = tswap32(ep[i].events);
+            target_ep[i].data.u64 = tswap64(ep[i].data.u64);
+        }
+        unlock_user(target_ep, arg2, ret * sizeof(struct target_epoll_event));
+    } else {
+        unlock_user(target_ep, arg2, 0);
+    }
+    g_free(ep);
+    return ret;
+}
+#endif /* CONFIG_EPOLL */
+
 #ifdef CONFIG_EVENTFD
 # ifdef TARGET_NR_eventfd
 IMPL(eventfd)
@@ -12856,122 +12973,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     abi_long ret;
 
     switch(num) {
-#if defined(CONFIG_EPOLL)
-#if defined(TARGET_NR_epoll_create)
-    case TARGET_NR_epoll_create:
-        return get_errno(epoll_create(arg1));
-#endif
-#if defined(TARGET_NR_epoll_create1) && defined(CONFIG_EPOLL_CREATE1)
-    case TARGET_NR_epoll_create1:
-        return get_errno(epoll_create1(arg1));
-#endif
-#if defined(TARGET_NR_epoll_ctl)
-    case TARGET_NR_epoll_ctl:
-    {
-        struct epoll_event ep;
-        struct epoll_event *epp = 0;
-        if (arg4) {
-            struct target_epoll_event *target_ep;
-            if (!lock_user_struct(VERIFY_READ, target_ep, arg4, 1)) {
-                return -TARGET_EFAULT;
-            }
-            ep.events = tswap32(target_ep->events);
-            /* The epoll_data_t union is just opaque data to the kernel,
-             * so we transfer all 64 bits across and need not worry what
-             * actual data type it is.
-             */
-            ep.data.u64 = tswap64(target_ep->data.u64);
-            unlock_user_struct(target_ep, arg4, 0);
-            epp = &ep;
-        }
-        return get_errno(epoll_ctl(arg1, arg2, arg3, epp));
-    }
-#endif
-
-#if defined(TARGET_NR_epoll_wait) || defined(TARGET_NR_epoll_pwait)
-#if defined(TARGET_NR_epoll_wait)
-    case TARGET_NR_epoll_wait:
-#endif
-#if defined(TARGET_NR_epoll_pwait)
-    case TARGET_NR_epoll_pwait:
-#endif
-    {
-        struct target_epoll_event *target_ep;
-        struct epoll_event *ep;
-        int epfd = arg1;
-        int maxevents = arg3;
-        int timeout = arg4;
-
-        if (maxevents <= 0 || maxevents > TARGET_EP_MAX_EVENTS) {
-            return -TARGET_EINVAL;
-        }
-
-        target_ep = lock_user(VERIFY_WRITE, arg2,
-                              maxevents * sizeof(struct target_epoll_event), 1);
-        if (!target_ep) {
-            return -TARGET_EFAULT;
-        }
-
-        ep = g_try_new(struct epoll_event, maxevents);
-        if (!ep) {
-            unlock_user(target_ep, arg2, 0);
-            return -TARGET_ENOMEM;
-        }
-
-        switch (num) {
-#if defined(TARGET_NR_epoll_pwait)
-        case TARGET_NR_epoll_pwait:
-        {
-            target_sigset_t *target_set;
-            sigset_t _set, *set = &_set;
-
-            if (arg5) {
-                if (arg6 != sizeof(target_sigset_t)) {
-                    ret = -TARGET_EINVAL;
-                    break;
-                }
-
-                target_set = lock_user(VERIFY_READ, arg5,
-                                       sizeof(target_sigset_t), 1);
-                if (!target_set) {
-                    ret = -TARGET_EFAULT;
-                    break;
-                }
-                target_to_host_sigset(set, target_set);
-                unlock_user(target_set, arg5, 0);
-            } else {
-                set = NULL;
-            }
-
-            ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, timeout,
-                                             set, SIGSET_T_SIZE));
-        }
-#endif
-#if defined(TARGET_NR_epoll_wait)
-        case TARGET_NR_epoll_wait:
-            ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, timeout,
-                                             NULL, 0));
-            break;
-#endif
-        default:
-            ret = -TARGET_ENOSYS;
-        }
-        if (!is_error(ret)) {
-            int i;
-            for (i = 0; i < ret; i++) {
-                target_ep[i].events = tswap32(ep[i].events);
-                target_ep[i].data.u64 = tswap64(ep[i].data.u64);
-            }
-            unlock_user(target_ep, arg2,
-                        ret * sizeof(struct target_epoll_event));
-        } else {
-            unlock_user(target_ep, arg2, 0);
-        }
-        g_free(ep);
-        return ret;
-    }
-#endif
-#endif
 #ifdef TARGET_NR_prlimit64
     case TARGET_NR_prlimit64:
     {
@@ -13330,6 +13331,17 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(dup2);
 #endif
         SYSCALL(dup3);
+#ifdef CONFIG_EPOLL
+# ifdef TARGET_NR_epoll_create
+        SYSCALL(epoll_create);
+# endif
+        SYSCALL(epoll_create1);
+        SYSCALL(epoll_ctl);
+        SYSCALL_WITH(epoll_pwait, epoll_pwait_wait);
+# ifdef TARGET_NR_epoll_wait
+        SYSCALL_WITH(epoll_wait, epoll_pwait_wait);
+# endif
+#endif
 #ifdef CONFIG_EVENTFD
 # ifdef TARGET_NR_eventfd
         SYSCALL(eventfd);
-- 
2.17.1
