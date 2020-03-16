Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F004C3F2CE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462F120719
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462F120719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDu9d-0006zp-5M
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsPg-0007v1-6Z
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsPe-0008VH-FX
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:24 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:38221)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsPe-0008Lw-5B
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:22 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N01hu-1jYARr3xCQ-00x41Z; Mon, 16 Mar 2020 17:16:18 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 12/38] linux-user: Support futex_time64
Date: Mon, 16 Mar 2020 17:15:24 +0100
Message-Id: <20200316161550.336150-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
References: <20200316161550.336150-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fSJIBRrZcdAMq2qAzWMn/Gj79ZLSEB4Vg8fzWLg10lhAM4cFEBY
 KGVIQ8/oJeCaLWi8kKq0wy5z6KiwSsqia2C5YhlVXYI9VDZ5ZPoTlWCyAmWJyxOfrZrPL7U
 L9OOQjXhTcreDwSKqEj2h3FTjyYv/O5phhRJiqZNFoJ3FMOv91/ZHjJ77Xb1eH170AsrMT4
 tj7AHyu10/+xisNeFGztQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aEq0pFrbZvk=:tTdGsQI9UhdBbUWSMz+jvE
 z0Q9rGLGRW42bMbbjk3e1ouvz5ueld1vyH3vcZ3VO3yOaGjl9qh8O2RS4QU8GZQQ4Gx3jhCzH
 UfdwZUCjzl6EziF7XKndfdKoeDpm2fQJdHxOl3e1VUh7giKIKdS4D3huD9fZXLYjo51r8qL0k
 zKYgUJVL5Tln4zBvYn1EG76ghhNgpLA81+NGoA3XWMthQa2LMyvOyqgx7No+/k/Einrt/4RX1
 R6L6MAR236EAe+mMB379z+0C57C5w3hQwm+23AvO2i1z68vw12HtxDboSge6jVr5YErr4ONhE
 YR4/L9TeS0ZAbzU58dqsetUtcHAWWYR1JneOYm4UpUAdrrAfGgNRck7+vzgNNiHTBZK5LkGfd
 EIKW+/oe6O8vbJ4jd76asvl8hbmSeMs1WWiRX7fZpGZ7tbrX8G9v/Oj4C6BSfuBo/QggyeC0d
 VwSHRKXtabPtrImAyuiUzqoMrITZ64C9mpsrvyAdKh8OLR0a+3ziP+eToJvXoGkKZ70gawKa9
 GN85owpgVjHWFVOqfLRqyBrUhqhCxEKijua+QZUDZHSQVBuOhPmrGPkBuexuPNavAeSZFQBF7
 A7JXacBH02nMGx5z71/k51ga8d0n761BV5O5vbRcWqdL8iNRgHeIXiQcDrFKUXmcNp7CYh9Zq
 XRLQfvHdpcTkSJFgJ4DHtY3nH35gvWw/6hac9fdeXZBU2fEp3G4aHGybTItAnaMJj60kgKba4
 UaXn8RoJLSxPbUpiBQ6LCpHLcsOK9bOZY/RS7YvsugEj9an3kqXOg+yYCaVz/lhPIDSJeO5Gg
 I8y7cbLZ8h1YgmQaEn0k/1aQl9p491Ub1kGPrQh8BtkUJs26riXhTwa6sEgu5aTAOv5AwVX
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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

Add support for host and target futex_time64. If futex_time64 exists on
the host we try that first before falling back to the standard futex
syscall.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <517832730838e1d0b5eda26781b280854d792f9e.1584143748.git.alistair.francis@wdc.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 144 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 131 insertions(+), 13 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index aaf62d48992a..32d75cfe3b8a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -245,7 +245,12 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #define __NR_sys_rt_sigqueueinfo __NR_rt_sigqueueinfo
 #define __NR_sys_rt_tgsigqueueinfo __NR_rt_tgsigqueueinfo
 #define __NR_sys_syslog __NR_syslog
-#define __NR_sys_futex __NR_futex
+#if defined(__NR_futex)
+# define __NR_sys_futex __NR_futex
+#endif
+#if defined(__NR_futex_time64)
+# define __NR_sys_futex_time64 __NR_futex_time64
+#endif
 #define __NR_sys_inotify_init __NR_inotify_init
 #define __NR_sys_inotify_add_watch __NR_inotify_add_watch
 #define __NR_sys_inotify_rm_watch __NR_inotify_rm_watch
@@ -295,10 +300,16 @@ _syscall1(int,exit_group,int,error_code)
 #if defined(TARGET_NR_set_tid_address) && defined(__NR_set_tid_address)
 _syscall1(int,set_tid_address,int *,tidptr)
 #endif
-#if defined(TARGET_NR_futex) && defined(__NR_futex)
+#if (defined(TARGET_NR_futex) && defined(__NR_futex)) || \
+    (defined(TARGET_NR_futex_time64) && \
+        (HOST_LONG_BITS == 64 && defined(__NR_futex)))
 _syscall6(int,sys_futex,int *,uaddr,int,op,int,val,
           const struct timespec *,timeout,int *,uaddr2,int,val3)
 #endif
+#if (defined(TARGET_NR_futex_time64) && defined(__NR_futex_teim64))
+_syscall6(int,sys_futex_time64,int *,uaddr,int,op,int,val,
+          const struct timespec *,timeout,int *,uaddr2,int,val3)
+#endif
 #define __NR_sys_sched_getaffinity __NR_sched_getaffinity
 _syscall3(int, sys_sched_getaffinity, pid_t, pid, unsigned int, len,
           unsigned long *, user_mask_ptr);
@@ -762,10 +773,14 @@ safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
 safe_syscall6(int, epoll_pwait, int, epfd, struct epoll_event *, events,
               int, maxevents, int, timeout, const sigset_t *, sigmask,
               size_t, sigsetsize)
-#ifdef TARGET_NR_futex
+#if defined(__NR_futex)
 safe_syscall6(int,futex,int *,uaddr,int,op,int,val, \
               const struct timespec *,timeout,int *,uaddr2,int,val3)
 #endif
+#if defined(__NR_futex_time64)
+safe_syscall6(int,futex_time64,int *,uaddr,int,op,int,val, \
+              const struct timespec *,timeout,int *,uaddr2,int,val3)
+#endif
 safe_syscall2(int, rt_sigsuspend, sigset_t *, newset, size_t, sigsetsize)
 safe_syscall2(int, kill, pid_t, pid, int, sig)
 safe_syscall2(int, tkill, int, tid, int, sig)
@@ -1229,7 +1244,7 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
 }
 #endif
 
-#if defined(TARGET_NR_clock_settime64)
+#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64)
 static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
                                                  abi_ulong target_addr)
 {
@@ -6907,6 +6922,55 @@ static inline abi_long host_to_target_statx(struct target_statx *host_stx,
 }
 #endif
 
+static int do_sys_futex(int *uaddr, int op, int val,
+                         const struct timespec *timeout, int *uaddr2,
+                         int val3)
+{
+#if HOST_LONG_BITS == 64
+#if defined(__NR_futex)
+    /* always a 64-bit time_t, it doesn't define _time64 version  */
+    return sys_futex(uaddr, op, val, timeout, uaddr2, val3);
+
+#endif
+#else /* HOST_LONG_BITS == 64 */
+#if defined(__NR_futex_time64)
+    if (sizeof(timeout->tv_sec) == 8) {
+        /* _time64 function on 32bit arch */
+        return sys_futex_time64(uaddr, op, val, timeout, uaddr2, val3);
+    }
+#endif
+#if defined(__NR_futex)
+    /* old function on 32bit arch */
+    return sys_futex(uaddr, op, val, timeout, uaddr2, val3);
+#endif
+#endif /* HOST_LONG_BITS == 64 */
+    g_assert_not_reached();
+}
+
+static int do_safe_futex(int *uaddr, int op, int val,
+                         const struct timespec *timeout, int *uaddr2,
+                         int val3)
+{
+#if HOST_LONG_BITS == 64
+#if defined(__NR_futex)
+    /* always a 64-bit time_t, it doesn't define _time64 version  */
+    return get_errno(safe_futex(uaddr, op, val, timeout, uaddr2, val3));
+#endif
+#else /* HOST_LONG_BITS == 64 */
+#if defined(__NR_futex_time64)
+    if (sizeof(timeout->tv_sec) == 8) {
+        /* _time64 function on 32bit arch */
+        return get_errno(safe_futex_time64(uaddr, op, val, timeout, uaddr2,
+                                           val3));
+    }
+#endif
+#if defined(__NR_futex)
+    /* old function on 32bit arch */
+    return get_errno(safe_futex(uaddr, op, val, timeout, uaddr2, val3));
+#endif
+#endif /* HOST_LONG_BITS == 64 */
+    return -TARGET_ENOSYS;
+}
 
 /* ??? Using host futex calls even when target atomic operations
    are not really atomic probably breaks things.  However implementing
@@ -6936,12 +7000,61 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
         } else {
             pts = NULL;
         }
-        return get_errno(safe_futex(g2h(uaddr), op, tswap32(val),
+        return get_errno(do_safe_futex(g2h(uaddr), op, tswap32(val),
+                         pts, NULL, val3));
+    case FUTEX_WAKE:
+        return get_errno(do_safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
+    case FUTEX_FD:
+        return get_errno(do_safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
+    case FUTEX_REQUEUE:
+    case FUTEX_CMP_REQUEUE:
+    case FUTEX_WAKE_OP:
+        /* For FUTEX_REQUEUE, FUTEX_CMP_REQUEUE, and FUTEX_WAKE_OP, the
+           TIMEOUT parameter is interpreted as a uint32_t by the kernel.
+           But the prototype takes a `struct timespec *'; insert casts
+           to satisfy the compiler.  We do not need to tswap TIMEOUT
+           since it's not compared to guest memory.  */
+        pts = (struct timespec *)(uintptr_t) timeout;
+        return get_errno(do_safe_futex(g2h(uaddr), op, val, pts,
+                                       g2h(uaddr2),
+                                       (base_op == FUTEX_CMP_REQUEUE
+                                        ? tswap32(val3)
+                                        : val3)));
+    default:
+        return -TARGET_ENOSYS;
+    }
+}
+#endif
+
+#if defined(TARGET_NR_futex_time64)
+static int do_futex_time64(target_ulong uaddr, int op, int val, target_ulong timeout,
+                           target_ulong uaddr2, int val3)
+{
+    struct timespec ts, *pts;
+    int base_op;
+
+    /* ??? We assume FUTEX_* constants are the same on both host
+       and target.  */
+#ifdef FUTEX_CMD_MASK
+    base_op = op & FUTEX_CMD_MASK;
+#else
+    base_op = op;
+#endif
+    switch (base_op) {
+    case FUTEX_WAIT:
+    case FUTEX_WAIT_BITSET:
+        if (timeout) {
+            pts = &ts;
+            target_to_host_timespec64(pts, timeout);
+        } else {
+            pts = NULL;
+        }
+        return get_errno(do_safe_futex(g2h(uaddr), op, tswap32(val),
                          pts, NULL, val3));
     case FUTEX_WAKE:
-        return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
+        return get_errno(do_safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
     case FUTEX_FD:
-        return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
+        return get_errno(do_safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
     case FUTEX_REQUEUE:
     case FUTEX_CMP_REQUEUE:
     case FUTEX_WAKE_OP:
@@ -6951,16 +7064,17 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
            to satisfy the compiler.  We do not need to tswap TIMEOUT
            since it's not compared to guest memory.  */
         pts = (struct timespec *)(uintptr_t) timeout;
-        return get_errno(safe_futex(g2h(uaddr), op, val, pts,
-                                    g2h(uaddr2),
-                                    (base_op == FUTEX_CMP_REQUEUE
-                                     ? tswap32(val3)
-                                     : val3)));
+        return get_errno(do_safe_futex(g2h(uaddr), op, val, pts,
+                                       g2h(uaddr2),
+                                       (base_op == FUTEX_CMP_REQUEUE
+                                        ? tswap32(val3)
+                                        : val3)));
     default:
         return -TARGET_ENOSYS;
     }
 }
 #endif
+
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
 static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
                                      abi_long handle, abi_long mount_id,
@@ -7532,7 +7646,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ts = cpu->opaque;
             if (ts->child_tidptr) {
                 put_user_u32(0, ts->child_tidptr);
-                sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
+                do_sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
                           NULL, NULL, 0);
             }
             thread_cpu = NULL;
@@ -11630,6 +11744,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_futex:
         return do_futex(arg1, arg2, arg3, arg4, arg5, arg6);
 #endif
+#ifdef TARGET_NR_futex_time64
+    case TARGET_NR_futex_time64:
+        return do_futex_time64(arg1, arg2, arg3, arg4, arg5, arg6);
+#endif
 #if defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)
     case TARGET_NR_inotify_init:
         ret = get_errno(sys_inotify_init());
-- 
2.24.1


