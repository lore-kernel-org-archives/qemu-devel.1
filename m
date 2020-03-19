Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1992C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394BB20663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394BB20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jErW8-0005tG-9q
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jErS0-0005VC-6b
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jErRx-0004FQ-Cm
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:52 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35973)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jErRx-0004ER-2T
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:49 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M91Tq-1jAzpj40HO-0063xX; Thu, 19 Mar 2020 10:26:38 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v3 10/16] linux-user: Protect more syscalls
Date: Thu, 19 Mar 2020 10:26:21 +0100
Message-Id: <20200319092627.51487-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319092627.51487-1-laurent@vivier.eu>
References: <20200319092627.51487-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JWO/hTcjNc79nqn5uCye3/2GkvCs3ofTGo2CJTv6DfNKsyp7c3q
 atkWsQz2LW0udhV1efV9xxuB6JQlLsBIk5yOBKxU6Zqs5/hL1o0+OFyKRUDRwx7f0aTjtop
 uftAx6EQPbaCWXDiqnQsSUdjBWB5TChfJrdIxPnu+5qQN25TnUpl/xMXQN/fahMJCKcLeys
 Erf6Cn0hDDim95lfKJVlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:izPB/Mrth70=:js0t43xeWKvxWDNezEoAIG
 HXjQgmhY5JA+DWl3bpC3EfDq70+5fGhTi4Kv9bZwWS8QtylOfZh/SIaV+oh5Q2Ji4Q4qnRT3m
 T64MJDb3Ja4R5kQISj1So+qxrXZLcNDNpcWotggOpJWe4w1mmCSaOjzwCtF99HMnlkR2qAEbD
 VQa+F8f1ipBMyoV7hKm1vyFGMuOK0+DFWAPfxkoAfHtXYX5JxCZsEICnerDkr8Y8eOuW/3yjb
 9tpOMnNxbsHeHJwCo/lCtdsqG+x1O35DlPEvpaAUJ4J/s25lQEKww+ECq+O5zs4DZYWB+bhGD
 pTehX8hto6Iynh5G7EUPVd4WH+hcKKhk+G2sbzLDLsDETPYuHHzUIAj5Vo3Oh9oOJTzvkSva5
 C6qT8sZC74BybrgLlmespWpBNUnNfaQVp5gQkT9XiiZv65llPrlOycj+Rc6vYzueWreHFUHDc
 pRS0KliLmxUZXQKk8XHGyAN0g+OX5TpvJxQRhNzLTDH6uR8XPf1AX8SJe9jW5y1mrAlp8pc9z
 BnSGOV9KKYEaYm302fNaVRf647AxEEhgIs0sf5JKCCzP7h53RR3ckBASQ/udDY1rRtYoZkb5t
 c2LboNhEfewdYPNNrq2iF8FHXq1r+zx/UVnP8yaByF4cI4UwJS3FxZCFpOvdrCxD2xLKMAyPP
 dCcEqWiv1Kl9Zjk/J0ne42RJaXVfT7OsoGHUeW0MNPA7/o7F0l3XJROPOQmjsb9BDJIEbU5ZN
 qO+1VZ5AZGKKzYy032rE49UQognznSGlUXBG7wjAg40x/k2p++hdF9hYOojCd7VBIU9q2cPU1
 7+n0k3nS7zRUuGSDS2JHzqN8z9AW6TzBjg/qz9d8xrHGdFcddbt8BnL5AOp1i/V1KpFhCvX
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

New y2038 safe 32-bit architectures (like RISC-V) don't support old
syscalls with a 32-bit time_t. The kernel defines new *_time64 versions
of these syscalls. Add some more #ifdefs to syscall.c in linux-user to
allow us to compile without these old syscalls.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <9ffc3cc6226756895157f16622be5f6edfa2aee6.1584051142.git.alistair.francis@wdc.com>
[lv: guard copy_to_user_timezone() with TARGET_NR_gettimeofday]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c  |  2 ++
 linux-user/syscall.c | 70 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 69232f7e27b8..0d9095c674f4 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -781,6 +781,7 @@ print_syscall_ret_newselect(const struct syscallname *name, abi_long ret)
 #define TARGET_TIME_OOP      3   /* leap second in progress */
 #define TARGET_TIME_WAIT     4   /* leap second has occurred */
 #define TARGET_TIME_ERROR    5   /* clock not synchronized */
+#ifdef TARGET_NR_adjtimex
 static void
 print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret)
 {
@@ -819,6 +820,7 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret)
 
     qemu_log("\n");
 }
+#endif
 
 UNUSED static struct flags access_flags[] = {
     FLAG_GENERIC(F_OK),
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index be676c3a4fb4..ea1c84dc5de5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -742,21 +742,30 @@ safe_syscall3(ssize_t, read, int, fd, void *, buff, size_t, count)
 safe_syscall3(ssize_t, write, int, fd, const void *, buff, size_t, count)
 safe_syscall4(int, openat, int, dirfd, const char *, pathname, \
               int, flags, mode_t, mode)
+#if defined(TARGET_NR_wait4) || defined(TARGET_NR_waitpid)
 safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
               struct rusage *, rusage)
+#endif
 safe_syscall5(int, waitid, idtype_t, idtype, id_t, id, siginfo_t *, infop, \
               int, options, struct rusage *, rusage)
 safe_syscall3(int, execve, const char *, filename, char **, argv, char **, envp)
+#if defined(TARGET_NR_select) || defined(TARGET_NR__newselect) || \
+    defined(TARGET_NR_pselect6)
 safe_syscall6(int, pselect6, int, nfds, fd_set *, readfds, fd_set *, writefds, \
               fd_set *, exceptfds, struct timespec *, timeout, void *, sig)
+#endif
+#if defined(TARGET_NR_ppoll) || defined(TARGET_NR_poll)
 safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
               struct timespec *, tsp, const sigset_t *, sigmask,
               size_t, sigsetsize)
+#endif
 safe_syscall6(int, epoll_pwait, int, epfd, struct epoll_event *, events,
               int, maxevents, int, timeout, const sigset_t *, sigmask,
               size_t, sigsetsize)
+#ifdef TARGET_NR_futex
 safe_syscall6(int,futex,int *,uaddr,int,op,int,val, \
               const struct timespec *,timeout,int *,uaddr2,int,val3)
+#endif
 safe_syscall2(int, rt_sigsuspend, sigset_t *, newset, size_t, sigsetsize)
 safe_syscall2(int, kill, pid_t, pid, int, sig)
 safe_syscall2(int, tkill, int, tid, int, sig)
@@ -776,12 +785,16 @@ safe_syscall6(ssize_t, recvfrom, int, fd, void *, buf, size_t, len,
 safe_syscall3(ssize_t, sendmsg, int, fd, const struct msghdr *, msg, int, flags)
 safe_syscall3(ssize_t, recvmsg, int, fd, struct msghdr *, msg, int, flags)
 safe_syscall2(int, flock, int, fd, int, operation)
+#ifdef TARGET_NR_rt_sigtimedwait
 safe_syscall4(int, rt_sigtimedwait, const sigset_t *, these, siginfo_t *, uinfo,
               const struct timespec *, uts, size_t, sigsetsize)
+#endif
 safe_syscall4(int, accept4, int, fd, struct sockaddr *, addr, socklen_t *, len,
               int, flags)
+#if defined(TARGET_NR_nanosleep)
 safe_syscall2(int, nanosleep, const struct timespec *, req,
               struct timespec *, rem)
+#endif
 #ifdef TARGET_NR_clock_nanosleep
 safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
               const struct timespec *, req, struct timespec *, rem)
@@ -802,9 +815,11 @@ safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
 safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
               unsigned, nsops, const struct timespec *, timeout)
 #endif
-#if defined(TARGET_NR_mq_open) && defined(__NR_mq_open)
+#ifdef TARGET_NR_mq_timedsend
 safe_syscall5(int, mq_timedsend, int, mqdes, const char *, msg_ptr,
               size_t, len, unsigned, prio, const struct timespec *, timeout)
+#endif
+#ifdef TARGET_NR_mq_timedreceive
 safe_syscall5(int, mq_timedreceive, int, mqdes, char *, msg_ptr,
               size_t, len, unsigned *, prio, const struct timespec *, timeout)
 #endif
@@ -946,6 +961,8 @@ abi_long do_brk(abi_ulong new_brk)
     return target_brk;
 }
 
+#if defined(TARGET_NR_select) || defined(TARGET_NR__newselect) || \
+    defined(TARGET_NR_pselect6)
 static inline abi_long copy_from_user_fdset(fd_set *fds,
                                             abi_ulong target_fds_addr,
                                             int n)
@@ -1021,6 +1038,7 @@ static inline abi_long copy_to_user_fdset(abi_ulong target_fds_addr,
 
     return 0;
 }
+#endif
 
 #if defined(__alpha__)
 #define HOST_HZ 1024
@@ -1067,6 +1085,7 @@ static inline abi_long host_to_target_rusage(abi_ulong target_addr,
     return 0;
 }
 
+#ifdef TARGET_NR_setrlimit
 static inline rlim_t target_to_host_rlim(abi_ulong target_rlim)
 {
     abi_ulong target_rlim_swap;
@@ -1082,7 +1101,9 @@ static inline rlim_t target_to_host_rlim(abi_ulong target_rlim)
     
     return result;
 }
+#endif
 
+#if defined(TARGET_NR_getrlimit) || defined(TARGET_NR_ugetrlimit)
 static inline abi_ulong host_to_target_rlim(rlim_t rlim)
 {
     abi_ulong target_rlim_swap;
@@ -1096,6 +1117,7 @@ static inline abi_ulong host_to_target_rlim(rlim_t rlim)
     
     return result;
 }
+#endif
 
 static inline int target_to_host_resource(int code)
 {
@@ -1186,6 +1208,12 @@ static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr,
     return 0;
 }
 
+#if defined(TARGET_NR_futex) || \
+    defined(TARGET_NR_rt_sigtimedwait) || \
+    defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6) || \
+    defined(TARGET_NR_nanosleep) || defined(TARGET_NR_clock_settime) || \
+    defined(TARGET_NR_utimensat) || defined(TARGET_NR_mq_timedsend) || \
+    defined(TARGET_NR_mq_timedreceive)
 static inline abi_long target_to_host_timespec(struct timespec *host_ts,
                                                abi_ulong target_addr)
 {
@@ -1199,6 +1227,7 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
     unlock_user_struct(target_ts, target_addr, 0);
     return 0;
 }
+#endif
 
 static inline abi_long host_to_target_timespec(abi_ulong target_addr,
                                                struct timespec *host_ts)
@@ -1228,6 +1257,7 @@ static inline abi_long host_to_target_timespec64(abi_ulong target_addr,
     return 0;
 }
 
+#if defined(TARGET_NR_gettimeofday)
 static inline abi_long copy_to_user_timezone(abi_ulong target_tz_addr,
                                              struct timezone *tz)
 {
@@ -1244,7 +1274,9 @@ static inline abi_long copy_to_user_timezone(abi_ulong target_tz_addr,
 
     return 0;
 }
+#endif
 
+#if defined(TARGET_NR_settimeofday)
 static inline abi_long copy_from_user_timezone(struct timezone *tz,
                                                abi_ulong target_tz_addr)
 {
@@ -1261,6 +1293,7 @@ static inline abi_long copy_from_user_timezone(struct timezone *tz,
 
     return 0;
 }
+#endif
 
 #if defined(TARGET_NR_mq_open) && defined(__NR_mq_open)
 #include <mqueue.h>
@@ -6582,6 +6615,8 @@ static inline abi_long target_ftruncate64(void *cpu_env, abi_long arg1,
 }
 #endif
 
+#if defined(TARGET_NR_timer_settime) || \
+    (defined(TARGET_NR_timerfd_settime) && defined(CONFIG_TIMERFD))
 static inline abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,
                                                  abi_ulong target_addr)
 {
@@ -6601,7 +6636,11 @@ static inline abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,
     unlock_user_struct(target_itspec, target_addr, 1);
     return 0;
 }
+#endif
 
+#if ((defined(TARGET_NR_timerfd_gettime) || \
+      defined(TARGET_NR_timerfd_settime)) && defined(CONFIG_TIMERFD)) || \
+    defined(TARGET_NR_timer_gettime) || defined(TARGET_NR_timer_settime)
 static inline abi_long host_to_target_itimerspec(abi_ulong target_addr,
                                                struct itimerspec *host_its)
 {
@@ -6620,7 +6659,10 @@ static inline abi_long host_to_target_itimerspec(abi_ulong target_addr,
     unlock_user_struct(target_itspec, target_addr, 0);
     return 0;
 }
+#endif
 
+#if defined(TARGET_NR_adjtimex) || \
+    (defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME))
 static inline abi_long target_to_host_timex(struct timex *host_tx,
                                             abi_long target_addr)
 {
@@ -6690,7 +6732,7 @@ static inline abi_long host_to_target_timex(abi_long target_addr,
     unlock_user_struct(target_tx, target_addr, 1);
     return 0;
 }
-
+#endif
 
 static inline abi_long target_to_host_sigevent(struct sigevent *host_sevp,
                                                abi_ulong target_addr)
@@ -6857,6 +6899,7 @@ static inline abi_long host_to_target_statx(struct target_statx *host_stx,
    futexes locally would make futexes shared between multiple processes
    tricky.  However they're probably useless because guest atomic
    operations won't work either.  */
+#if defined(TARGET_NR_futex)
 static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
                     target_ulong uaddr2, int val3)
 {
@@ -6903,6 +6946,7 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
         return -TARGET_ENOSYS;
     }
 }
+#endif
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
 static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
                                      abi_long handle, abi_long mount_id,
@@ -8521,6 +8565,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#ifdef TARGET_NR_rt_sigtimedwait
     case TARGET_NR_rt_sigtimedwait:
         {
             sigset_t set;
@@ -8557,6 +8602,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
     case TARGET_NR_rt_sigqueueinfo:
         {
             siginfo_t uinfo;
@@ -8656,6 +8702,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#if defined(TARGET_NR_gettimeofday)
     case TARGET_NR_gettimeofday:
         {
             struct timeval tv;
@@ -8672,6 +8719,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
+#if defined(TARGET_NR_settimeofday)
     case TARGET_NR_settimeofday:
         {
             struct timeval tv, *ptv = NULL;
@@ -8693,6 +8742,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             return get_errno(settimeofday(ptv, ptz));
         }
+#endif
 #if defined(TARGET_NR_select)
     case TARGET_NR_select:
 #if defined(TARGET_WANT_NI_OLD_SELECT)
@@ -9164,6 +9214,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_sendmmsg
     case TARGET_NR_sendmmsg:
         return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 1);
+#endif
+#ifdef TARGET_NR_recvmmsg
     case TARGET_NR_recvmmsg:
         return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 0);
 #endif
@@ -9338,6 +9390,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return do_syscall(cpu_env, arg1 & 0xffff, arg2, arg3, arg4, arg5,
                           arg6, arg7, arg8, 0);
 #endif
+#if defined(TARGET_NR_wait4)
     case TARGET_NR_wait4:
         {
             int status;
@@ -9365,6 +9418,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
 #ifdef TARGET_NR_swapoff
     case TARGET_NR_swapoff:
         if (!(p = lock_user_string(arg1)))
@@ -9509,6 +9563,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return do_vm86(cpu_env, arg1, arg2);
 #endif
 #endif
+#if defined(TARGET_NR_adjtimex)
     case TARGET_NR_adjtimex:
         {
             struct timex host_buf;
@@ -9524,6 +9579,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
 #if defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME)
     case TARGET_NR_clock_adjtime:
         {
@@ -10040,6 +10096,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return get_errno(sched_get_priority_max(arg1));
     case TARGET_NR_sched_get_priority_min:
         return get_errno(sched_get_priority_min(arg1));
+#ifdef TARGET_NR_sched_rr_get_interval
     case TARGET_NR_sched_rr_get_interval:
         {
             struct timespec ts;
@@ -10049,6 +10106,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
+#if defined(TARGET_NR_nanosleep)
     case TARGET_NR_nanosleep:
         {
             struct timespec req, rem;
@@ -10059,6 +10118,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
     case TARGET_NR_prctl:
         switch (arg1) {
         case PR_GET_PDEATHSIG:
@@ -11529,8 +11589,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
+#ifdef TARGET_NR_futex
     case TARGET_NR_futex:
         return do_futex(arg1, arg2, arg3, arg4, arg5, arg6);
+#endif
 #if defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)
     case TARGET_NR_inotify_init:
         ret = get_errno(sys_inotify_init());
@@ -11595,6 +11657,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         unlock_user (p, arg1, 0);
         return ret;
 
+#ifdef TARGET_NR_mq_timedsend
     case TARGET_NR_mq_timedsend:
         {
             struct timespec ts;
@@ -11610,7 +11673,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user (p, arg2, arg3);
         }
         return ret;
+#endif
 
+#ifdef TARGET_NR_mq_timedreceive
     case TARGET_NR_mq_timedreceive:
         {
             struct timespec ts;
@@ -11631,6 +11696,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 put_user_u32(prio, arg4);
         }
         return ret;
+#endif
 
     /* Not implemented for now... */
 /*     case TARGET_NR_mq_notify: */
-- 
2.25.1


