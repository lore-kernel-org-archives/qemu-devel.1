Received: from eggs.gnu.org ([2001:4830:134:3::10]:40554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdt-0002ap-MB
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqds-0003ZH-Cg
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:45 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqds-0003Yv-4K
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:44 -0400
Received: by mail-pg0-x242.google.com with SMTP id e11-v6so8142855pgq.0
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:07 -1000
Message-Id: <20180610030220.3777-36-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 035/108] linux-user: Split out select,
 pselect6, newselect
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

All targets define pselect6; remove the ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 251 ++++++++++++++++++++++---------------------
 1 file changed, 130 insertions(+), 121 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 4c5292efed..326323e377 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8483,6 +8483,13 @@ IMPL(name_to_handle_at)
 }
 #endif
 
+#ifdef TARGET_NR__newselect
+IMPL(_newselect)
+{
+    return do_select(arg1, arg2, arg3, arg4, arg5);
+}
+#endif
+
 #ifdef TARGET_NR_nice
 IMPL(nice)
 {
@@ -8584,6 +8591,107 @@ IMPL(pipe2)
                    target_to_host_bitmask(arg2, fcntl_flags_tbl), 1);
 }
 
+IMPL(pselect6)
+{
+    abi_long rfd_addr, wfd_addr, efd_addr, n, ts_addr;
+    fd_set rfds, wfds, efds;
+    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
+    struct timespec ts, *ts_ptr = NULL;
+    target_sigset_t *target_sigset;
+    abi_long ret;
+
+    /*
+     * The 6th arg is actually two args smashed together,
+     * so we cannot use the C library.
+     */
+    sigset_t set;
+    struct {
+        sigset_t *set;
+        size_t size;
+    } sig, *sig_ptr = NULL;
+
+    n = arg1;
+    rfd_addr = arg2;
+    wfd_addr = arg3;
+    efd_addr = arg4;
+    ts_addr = arg5;
+
+    ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
+    if (ret) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
+    if (ret) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
+    if (ret) {
+        return ret;
+    }
+
+    /*
+     * This takes a timespec, and not a timeval, so we cannot
+     * use the do_select() helper ...
+     */
+    if (ts_addr) {
+        if (target_to_host_timespec(&ts, ts_addr)) {
+            return -TARGET_EFAULT;
+        }
+        ts_ptr = &ts;
+    }
+
+    /* Extract the two packed args for the sigset */
+    if (arg6) {
+        abi_ulong arg_sigset, arg_sigsize, *arg7;
+
+        sig_ptr = &sig;
+        sig.set = NULL;
+        sig.size = SIGSET_T_SIZE;
+
+        arg7 = lock_user(VERIFY_READ, arg6, sizeof(*arg7) * 2, 1);
+        if (!arg7) {
+            return -TARGET_EFAULT;
+        }
+        arg_sigset = tswapal(arg7[0]);
+        arg_sigsize = tswapal(arg7[1]);
+        unlock_user(arg7, arg6, 0);
+
+        if (arg_sigset) {
+            sig.set = &set;
+            if (arg_sigsize != sizeof(*target_sigset)) {
+                /* Like the kernel, we enforce correct size sigsets */
+                return -TARGET_EINVAL;
+            }
+            target_sigset = lock_user(VERIFY_READ, arg_sigset,
+                                      sizeof(*target_sigset), 1);
+            if (!target_sigset) {
+                return -TARGET_EFAULT;
+            }
+            target_to_host_sigset(&set, target_sigset);
+            unlock_user(target_sigset, arg_sigset, 0);
+        }
+    }
+
+    ret = get_errno(safe_pselect6(n, rfds_ptr, wfds_ptr, efds_ptr,
+                                  ts_ptr, sig_ptr));
+
+    if (!is_error(ret)) {
+        if (rfd_addr && copy_to_user_fdset(rfd_addr, &rfds, n)) {
+            return -TARGET_EFAULT;
+        }
+        if (wfd_addr && copy_to_user_fdset(wfd_addr, &wfds, n)) {
+            return -TARGET_EFAULT;
+        }
+        if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n)) {
+            return -TARGET_EFAULT;
+        }
+        if (ts_addr && host_to_target_timespec(ts_addr, &ts)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
 IMPL(read)
 {
     abi_long ret;
@@ -8920,6 +9028,17 @@ IMPL(sgetmask)
 }
 #endif
 
+#if defined(TARGET_NR_select) && !defined(TARGET_WANT_NI_OLD_SELECT)
+IMPL(select)
+{
+# ifdef TARGET_WANT_OLD_SYS_SELECT
+    return do_old_select(arg1);
+# else
+    return do_select(arg1, arg2, arg3, arg4, arg5);
+# endif
+}
+#endif
+
 IMPL(sethostname)
 {
     char *p = lock_user_string(arg1);
@@ -9442,123 +9561,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#if defined(TARGET_NR_select)
-    case TARGET_NR_select:
-#if defined(TARGET_WANT_NI_OLD_SELECT)
-        /* some architectures used to have old_select here
-         * but now ENOSYS it.
-         */
-        ret = -TARGET_ENOSYS;
-#elif defined(TARGET_WANT_OLD_SYS_SELECT)
-        ret = do_old_select(arg1);
-#else
-        ret = do_select(arg1, arg2, arg3, arg4, arg5);
-#endif
-        return ret;
-#endif
-#ifdef TARGET_NR_pselect6
-    case TARGET_NR_pselect6:
-        {
-            abi_long rfd_addr, wfd_addr, efd_addr, n, ts_addr;
-            fd_set rfds, wfds, efds;
-            fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
-            struct timespec ts, *ts_ptr;
-
-            /*
-             * The 6th arg is actually two args smashed together,
-             * so we cannot use the C library.
-             */
-            sigset_t set;
-            struct {
-                sigset_t *set;
-                size_t size;
-            } sig, *sig_ptr;
-
-            abi_ulong arg_sigset, arg_sigsize, *arg7;
-            target_sigset_t *target_sigset;
-
-            n = arg1;
-            rfd_addr = arg2;
-            wfd_addr = arg3;
-            efd_addr = arg4;
-            ts_addr = arg5;
-
-            ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
-            if (ret) {
-                return ret;
-            }
-            ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
-            if (ret) {
-                return ret;
-            }
-            ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
-            if (ret) {
-                return ret;
-            }
-
-            /*
-             * This takes a timespec, and not a timeval, so we cannot
-             * use the do_select() helper ...
-             */
-            if (ts_addr) {
-                if (target_to_host_timespec(&ts, ts_addr)) {
-                    return -TARGET_EFAULT;
-                }
-                ts_ptr = &ts;
-            } else {
-                ts_ptr = NULL;
-            }
-
-            /* Extract the two packed args for the sigset */
-            if (arg6) {
-                sig_ptr = &sig;
-                sig.size = SIGSET_T_SIZE;
-
-                arg7 = lock_user(VERIFY_READ, arg6, sizeof(*arg7) * 2, 1);
-                if (!arg7) {
-                    return -TARGET_EFAULT;
-                }
-                arg_sigset = tswapal(arg7[0]);
-                arg_sigsize = tswapal(arg7[1]);
-                unlock_user(arg7, arg6, 0);
-
-                if (arg_sigset) {
-                    sig.set = &set;
-                    if (arg_sigsize != sizeof(*target_sigset)) {
-                        /* Like the kernel, we enforce correct size sigsets */
-                        return -TARGET_EINVAL;
-                    }
-                    target_sigset = lock_user(VERIFY_READ, arg_sigset,
-                                              sizeof(*target_sigset), 1);
-                    if (!target_sigset) {
-                        return -TARGET_EFAULT;
-                    }
-                    target_to_host_sigset(&set, target_sigset);
-                    unlock_user(target_sigset, arg_sigset, 0);
-                } else {
-                    sig.set = NULL;
-                }
-            } else {
-                sig_ptr = NULL;
-            }
-
-            ret = get_errno(safe_pselect6(n, rfds_ptr, wfds_ptr, efds_ptr,
-                                          ts_ptr, sig_ptr));
-
-            if (!is_error(ret)) {
-                if (rfd_addr && copy_to_user_fdset(rfd_addr, &rfds, n))
-                    return -TARGET_EFAULT;
-                if (wfd_addr && copy_to_user_fdset(wfd_addr, &wfds, n))
-                    return -TARGET_EFAULT;
-                if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n))
-                    return -TARGET_EFAULT;
-
-                if (ts_addr && host_to_target_timespec(ts_addr, &ts))
-                    return -TARGET_EFAULT;
-            }
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_symlink
     case TARGET_NR_symlink:
         {
@@ -10459,10 +10461,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
         }
         return ret;
 #endif /* TARGET_NR_getdents64 */
-#if defined(TARGET_NR__newselect)
-    case TARGET_NR__newselect:
-        return do_select(arg1, arg2, arg3, arg4, arg5);
-#endif
 #if defined(TARGET_NR_poll) || defined(TARGET_NR_ppoll)
 # ifdef TARGET_NR_poll
     case TARGET_NR_poll:
@@ -12763,6 +12761,9 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef CONFIG_OPEN_BY_HANDLE
         SYSCALL(name_to_handle_at);
 #endif
+#ifdef TARGET_NR__newselect
+        SYSCALL(_newselect);
+#endif
 #ifdef TARGET_NR_nice
         SYSCALL(nice);
 #endif
@@ -12780,6 +12781,7 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(pipe);
 #endif
         SYSCALL(pipe2);
+        SYSCALL(pselect6);
         SYSCALL(read);
 #ifdef TARGET_NR_rename
         SYSCALL(rename);
@@ -12801,6 +12803,13 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(rt_tgsigqueueinfo);
 #ifdef TARGET_NR_sgetmask
         SYSCALL(sgetmask);
+#endif
+#ifdef TARGET_NR_select
+# ifdef TARGET_WANT_NI_OLD_SELECT
+        SYSCALL_WITH(select, enosys);
+# else
+        SYSCALL(select);
+# endif
 #endif
         SYSCALL(sethostname);
         SYSCALL(setpgid);
-- 
2.17.1
