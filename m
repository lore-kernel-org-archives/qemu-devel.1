Received: from eggs.gnu.org ([2001:4830:134:3::10]:41568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqg4-0004jk-Ni
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqg3-0004pV-8L
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:06:00 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:44846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqg3-0004pD-0K
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:59 -0400
Received: by mail-pg0-x241.google.com with SMTP id p21-v6so8128974pgd.11
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:16 -1000
Message-Id: <20180610030220.3777-105-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 104/108] linux-user: Split out timer syscalls
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

This includes timer_create, timer_delete, timer_getoverrun,
timer_gettime, and timer_settime.  All targets define all of
these; remove the ifdefs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 234 ++++++++++++++++++++-----------------------
 1 file changed, 111 insertions(+), 123 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5d60872587..0f12a945ea 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -640,7 +640,6 @@ _syscall4(int, sys_prlimit64, pid_t, pid, int, resource,
           const struct host_rlimit64 *, new_limit,
           struct host_rlimit64 *, old_limit)
 
-#if defined(TARGET_NR_timer_create)
 /* Maxiumum of 32 active POSIX timers allowed at any one time. */
 static timer_t g_posix_timers[32] = { 0, } ;
 
@@ -656,7 +655,6 @@ static inline int next_free_host_timer(void)
     }
     return -1;
 }
-#endif
 
 /* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
 #ifdef TARGET_ARM
@@ -12685,6 +12683,112 @@ IMPL(times)
     return host_to_target_clock_t(ret);
 }
 
+IMPL(timer_create)
+{
+    /* args: clockid_t clockid, struct sigevent *sevp, timer_t *timerid */
+    struct sigevent host_sevp, *phost_sevp = NULL;
+    int clkid = arg1;
+    int timer_index;
+    timer_t *phtimer;
+    abi_long ret;
+
+    timer_index = next_free_host_timer();
+    if (timer_index < 0) {
+        return -TARGET_EAGAIN;
+    }
+
+    phtimer = g_posix_timers + timer_index;
+    if (arg2) {
+        phost_sevp = &host_sevp;
+        ret = target_to_host_sigevent(phost_sevp, arg2);
+        if (ret != 0) {
+            return ret;
+        }
+    }
+
+    ret = get_errno(timer_create(clkid, phost_sevp, phtimer));
+    if (!ret && put_user(TIMER_MAGIC | timer_index, arg3, target_timer_t)) {
+        /* ??? Leak timer.  */
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
+IMPL(timer_delete)
+{
+    /* args: timer_t timerid */
+    target_timer_t timerid = get_timer_id(arg1);
+    timer_t htimer;
+    abi_long ret;
+
+    if (timerid < 0) {
+        return timerid;
+    }
+    htimer = g_posix_timers[timerid];
+    ret = get_errno(timer_delete(htimer));
+    g_posix_timers[timerid] = 0;
+    return ret;
+}
+
+IMPL(timer_getoverrun)
+{
+    /* args: timer_t timerid */
+    target_timer_t timerid = get_timer_id(arg1);
+    timer_t htimer;
+    abi_long ret;
+
+    if (timerid < 0) {
+        return timerid;
+    }
+    htimer = g_posix_timers[timerid];
+    ret = get_errno(timer_getoverrun(htimer));
+    fd_trans_unregister(ret);
+    return ret;
+}
+
+IMPL(timer_gettime)
+{
+    /* args: timer_t timerid, struct itimerspec *curr_value */
+    target_timer_t timerid = get_timer_id(arg1);
+    struct itimerspec hspec;
+    timer_t htimer;
+    abi_long ret;
+
+    if (timerid < 0) {
+        return timerid;
+    }
+    htimer = g_posix_timers[timerid];
+    ret = get_errno(timer_gettime(htimer, &hspec));
+    if (!ret && host_to_target_itimerspec(arg2, &hspec)) {
+        ret = -TARGET_EFAULT;
+    }
+    return ret;
+}
+
+IMPL(timer_settime)
+{
+    /* args: timer_t timerid, int flags, const struct itimerspec *new_value,
+     * struct itimerspec * old_value
+     */
+    struct itimerspec hspec_new, hspec_old;
+    target_timer_t timerid = get_timer_id(arg1);
+    timer_t htimer;
+    abi_long ret;
+
+    if (timerid < 0) {
+        return timerid;
+    }
+    if (target_to_host_itimerspec(&hspec_new, arg3)) {
+        return -TARGET_EFAULT;
+    }
+    htimer = g_posix_timers[timerid];
+    ret = get_errno(timer_settime(htimer, arg2, &hspec_new, &hspec_old));
+    if (!ret && arg4 && host_to_target_itimerspec(arg4, &hspec_old)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
 IMPL(tkill)
 {
     return get_errno(safe_tkill((int)arg1, target_to_host_signal(arg2)));
@@ -13048,127 +13152,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     abi_long ret;
 
     switch(num) {
-#ifdef TARGET_NR_timer_create
-    case TARGET_NR_timer_create:
-    {
-        /* args: clockid_t clockid, struct sigevent *sevp, timer_t *timerid */
-
-        struct sigevent host_sevp = { {0}, }, *phost_sevp = NULL;
-
-        int clkid = arg1;
-        int timer_index = next_free_host_timer();
-
-        if (timer_index < 0) {
-            ret = -TARGET_EAGAIN;
-        } else {
-            timer_t *phtimer = g_posix_timers  + timer_index;
-
-            if (arg2) {
-                phost_sevp = &host_sevp;
-                ret = target_to_host_sigevent(phost_sevp, arg2);
-                if (ret != 0) {
-                    return ret;
-                }
-            }
-
-            ret = get_errno(timer_create(clkid, phost_sevp, phtimer));
-            if (ret) {
-                phtimer = NULL;
-            } else {
-                if (put_user(TIMER_MAGIC | timer_index, arg3, target_timer_t)) {
-                    return -TARGET_EFAULT;
-                }
-            }
-        }
-        return ret;
-    }
-#endif
-
-#ifdef TARGET_NR_timer_settime
-    case TARGET_NR_timer_settime:
-    {
-        /* args: timer_t timerid, int flags, const struct itimerspec *new_value,
-         * struct itimerspec * old_value */
-        target_timer_t timerid = get_timer_id(arg1);
-
-        if (timerid < 0) {
-            ret = timerid;
-        } else if (arg3 == 0) {
-            ret = -TARGET_EINVAL;
-        } else {
-            timer_t htimer = g_posix_timers[timerid];
-            struct itimerspec hspec_new = {{0},}, hspec_old = {{0},};
-
-            if (target_to_host_itimerspec(&hspec_new, arg3)) {
-                return -TARGET_EFAULT;
-            }
-            ret = get_errno(
-                          timer_settime(htimer, arg2, &hspec_new, &hspec_old));
-            if (arg4 && host_to_target_itimerspec(arg4, &hspec_old)) {
-                return -TARGET_EFAULT;
-            }
-        }
-        return ret;
-    }
-#endif
-
-#ifdef TARGET_NR_timer_gettime
-    case TARGET_NR_timer_gettime:
-    {
-        /* args: timer_t timerid, struct itimerspec *curr_value */
-        target_timer_t timerid = get_timer_id(arg1);
-
-        if (timerid < 0) {
-            ret = timerid;
-        } else if (!arg2) {
-            ret = -TARGET_EFAULT;
-        } else {
-            timer_t htimer = g_posix_timers[timerid];
-            struct itimerspec hspec;
-            ret = get_errno(timer_gettime(htimer, &hspec));
-
-            if (host_to_target_itimerspec(arg2, &hspec)) {
-                ret = -TARGET_EFAULT;
-            }
-        }
-        return ret;
-    }
-#endif
-
-#ifdef TARGET_NR_timer_getoverrun
-    case TARGET_NR_timer_getoverrun:
-    {
-        /* args: timer_t timerid */
-        target_timer_t timerid = get_timer_id(arg1);
-
-        if (timerid < 0) {
-            ret = timerid;
-        } else {
-            timer_t htimer = g_posix_timers[timerid];
-            ret = get_errno(timer_getoverrun(htimer));
-        }
-        fd_trans_unregister(ret);
-        return ret;
-    }
-#endif
-
-#ifdef TARGET_NR_timer_delete
-    case TARGET_NR_timer_delete:
-    {
-        /* args: timer_t timerid */
-        target_timer_t timerid = get_timer_id(arg1);
-
-        if (timerid < 0) {
-            ret = timerid;
-        } else {
-            timer_t htimer = g_posix_timers[timerid];
-            ret = get_errno(timer_delete(htimer));
-            g_posix_timers[timerid] = 0;
-        }
-        return ret;
-    }
-#endif
-
 #if defined(TARGET_NR_timerfd_create) && defined(CONFIG_TIMERFD)
     case TARGET_NR_timerfd_create:
         return get_errno(timerfd_create(arg1,
@@ -13908,6 +13891,11 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(time);
 #endif
         SYSCALL(times);
+        SYSCALL(timer_create);
+        SYSCALL(timer_delete);
+        SYSCALL(timer_getoverrun);
+        SYSCALL(timer_gettime);
+        SYSCALL(timer_settime);
         SYSCALL(tkill);
         SYSCALL(truncate);
 #ifdef TARGET_NR_truncate64
-- 
2.17.1
