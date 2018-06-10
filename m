Received: from eggs.gnu.org ([2001:4830:134:3::10]:40962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqen-0003Rc-0D
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqel-0003sw-Os
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:41 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqel-0003sS-Gw
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:39 -0400
Received: by mail-pf0-x242.google.com with SMTP id a63-v6so8499503pfl.1
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:33 -1000
Message-Id: <20180610030220.3777-62-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 061/108] linux-user: Split out poll, ppoll
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

All targets define ppoll; remove the ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 232 +++++++++++++++++++++++--------------------
 1 file changed, 124 insertions(+), 108 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 600702ea3e..362d315ce8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9101,6 +9101,126 @@ IMPL(pipe2)
                    target_to_host_bitmask(arg2, fcntl_flags_tbl), 1);
 }
 
+static struct pollfd *get_pollfd(abi_ulong nfds, abi_ulong target_addr,
+                                 struct target_pollfd **ptfd, abi_long *err)
+{
+    struct target_pollfd *target_pfd;
+    struct pollfd *pfd;
+    abi_ulong i;
+
+    if (nfds > (INT_MAX / sizeof(struct target_pollfd))) {
+        *err = -TARGET_EINVAL;
+        return NULL;
+    }
+    pfd = g_try_new(struct pollfd, nfds);
+    if (pfd == NULL) {
+        *err = -TARGET_ENOMEM;
+        return NULL;
+    }
+
+    *ptfd = target_pfd = lock_user(VERIFY_WRITE, target_addr,
+                                   sizeof(struct target_pollfd) * nfds, 1);
+    if (!target_pfd) {
+        *err = -TARGET_EFAULT;
+        g_free(pfd);
+        return NULL;
+    }
+
+    for (i = 0; i < nfds; i++) {
+        pfd[i].fd = tswap32(target_pfd[i].fd);
+        pfd[i].events = tswap16(target_pfd[i].events);
+    }
+
+    *err = 0;
+    return pfd;
+}
+
+static abi_long put_pollfd(abi_ulong nfds, abi_ulong target_addr,
+                           struct pollfd *pfd,
+                           struct target_pollfd *target_pfd, abi_long ret)
+{
+    if (!is_error(ret)) {
+        abi_ulong i;
+        for (i = 0; i < nfds; i++) {
+            target_pfd[i].revents = tswap16(pfd[i].revents);
+        }
+    }
+    unlock_user(target_pfd, target_addr, sizeof(struct target_pollfd) * nfds);
+    g_free(pfd);
+    return ret;
+}
+
+#ifdef TARGET_NR_poll
+IMPL(poll)
+{
+    struct timespec ts, *pts;
+    struct target_pollfd *target_pfd;
+    struct pollfd *pfd;
+    abi_long ret;
+
+    if (arg3 >= 0) {
+        /* Convert ms to secs, ns */
+        ts.tv_sec = arg3 / 1000;
+        ts.tv_nsec = (arg3 % 1000) * 1000000LL;
+        pts = &ts;
+    } else {
+        /* -ve poll() timeout means "infinite" */
+        pts = NULL;
+    }
+
+    pfd = get_pollfd(arg2, arg1, &target_pfd, &ret);
+    if (pfd == NULL) {
+        return ret;
+    }
+    ret = safe_ppoll(pfd, arg2, pts, NULL, 0);
+    return put_pollfd(arg2, arg1, pfd, target_pfd, get_errno(ret));
+}
+#endif
+
+IMPL(ppoll)
+{
+    struct timespec ts;
+    sigset_t set;
+    struct target_pollfd *target_pfd;
+    struct pollfd *pfd;
+    abi_long ret;
+
+    if (arg3) {
+        if (target_to_host_timespec(&ts, arg3)) {
+            return -TARGET_EFAULT;
+        }
+    }
+
+    if (arg4) {
+        target_sigset_t *target_set;
+        if (arg5 != sizeof(target_sigset_t)) {
+            return -TARGET_EINVAL;
+        }
+        target_set = lock_user(VERIFY_READ, arg4, sizeof(target_sigset_t), 1);
+        if (!target_set) {
+            return -TARGET_EFAULT;
+        }
+        target_to_host_sigset(&set, target_set);
+        unlock_user(target_set, arg4, 0);
+    }
+
+    pfd = get_pollfd(arg2, arg1, &target_pfd, &ret);
+    if (pfd == NULL) {
+        return ret;
+    }
+    ret = safe_ppoll(pfd, arg2, arg3 ? &ts : NULL,
+                     arg4 ? &set : NULL, SIGSET_T_SIZE);
+    ret = put_pollfd(arg2, arg1, pfd, target_pfd, get_errno(ret));
+
+    if (!is_error(ret) && arg3) {
+        abi_long err = host_to_target_timespec(arg3, &ts);
+        if (err) {
+            return err;
+        }
+    }
+    return ret;
+}
+
 IMPL(pselect6)
 {
     abi_long rfd_addr, wfd_addr, efd_addr, n, ts_addr;
@@ -10649,114 +10769,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#if defined(TARGET_NR_poll) || defined(TARGET_NR_ppoll)
-# ifdef TARGET_NR_poll
-    case TARGET_NR_poll:
-# endif
-# ifdef TARGET_NR_ppoll
-    case TARGET_NR_ppoll:
-# endif
-        {
-            struct target_pollfd *target_pfd;
-            unsigned int nfds = arg2;
-            struct pollfd *pfd;
-            unsigned int i;
-
-            pfd = NULL;
-            target_pfd = NULL;
-            if (nfds) {
-                if (nfds > (INT_MAX / sizeof(struct target_pollfd))) {
-                    return -TARGET_EINVAL;
-                }
-
-                target_pfd = lock_user(VERIFY_WRITE, arg1,
-                                       sizeof(struct target_pollfd) * nfds, 1);
-                if (!target_pfd) {
-                    return -TARGET_EFAULT;
-                }
-
-                pfd = alloca(sizeof(struct pollfd) * nfds);
-                for (i = 0; i < nfds; i++) {
-                    pfd[i].fd = tswap32(target_pfd[i].fd);
-                    pfd[i].events = tswap16(target_pfd[i].events);
-                }
-            }
-
-            switch (num) {
-# ifdef TARGET_NR_ppoll
-            case TARGET_NR_ppoll:
-            {
-                struct timespec _timeout_ts, *timeout_ts = &_timeout_ts;
-                target_sigset_t *target_set;
-                sigset_t _set, *set = &_set;
-
-                if (arg3) {
-                    if (target_to_host_timespec(timeout_ts, arg3)) {
-                        unlock_user(target_pfd, arg1, 0);
-                        return -TARGET_EFAULT;
-                    }
-                } else {
-                    timeout_ts = NULL;
-                }
-
-                if (arg4) {
-                    if (arg5 != sizeof(target_sigset_t)) {
-                        unlock_user(target_pfd, arg1, 0);
-                        return -TARGET_EINVAL;
-                    }
-
-                    target_set = lock_user(VERIFY_READ, arg4, sizeof(target_sigset_t), 1);
-                    if (!target_set) {
-                        unlock_user(target_pfd, arg1, 0);
-                        return -TARGET_EFAULT;
-                    }
-                    target_to_host_sigset(set, target_set);
-                } else {
-                    set = NULL;
-                }
-
-                ret = get_errno(safe_ppoll(pfd, nfds, timeout_ts,
-                                           set, SIGSET_T_SIZE));
-
-                if (!is_error(ret) && arg3) {
-                    host_to_target_timespec(arg3, timeout_ts);
-                }
-                if (arg4) {
-                    unlock_user(target_set, arg4, 0);
-                }
-                return ret;
-            }
-# endif
-# ifdef TARGET_NR_poll
-            case TARGET_NR_poll:
-            {
-                struct timespec ts, *pts;
-
-                if (arg3 >= 0) {
-                    /* Convert ms to secs, ns */
-                    ts.tv_sec = arg3 / 1000;
-                    ts.tv_nsec = (arg3 % 1000) * 1000000LL;
-                    pts = &ts;
-                } else {
-                    /* -ve poll() timeout means "infinite" */
-                    pts = NULL;
-                }
-                return get_errno(safe_ppoll(pfd, nfds, pts, NULL, 0));
-            }
-# endif
-            default:
-                g_assert_not_reached();
-            }
-
-            if (!is_error(ret)) {
-                for(i = 0; i < nfds; i++) {
-                    target_pfd[i].revents = tswap16(pfd[i].revents);
-                }
-            }
-            unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
-        }
-        return ret;
-#endif
     case TARGET_NR_flock:
         /* NOTE: the flock constant seems to be the same for every
            Linux platform */
@@ -13060,6 +13072,10 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(pipe);
 #endif
         SYSCALL(pipe2);
+#ifdef TARGET_NR_poll
+        SYSCALL(poll);
+#endif
+        SYSCALL(ppoll);
         SYSCALL(pselect6);
         SYSCALL(read);
 #ifdef TARGET_NR_readlink
-- 
2.17.1
