Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B00FC10F25
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 18:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E242067C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 18:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PUqiyVVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E242067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAHo8-0002Z1-67
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 13:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=32724e9af=alistair.francis@wdc.com>)
 id 1jAHlY-0008Ej-Rj
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 13:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=32724e9af=alistair.francis@wdc.com>)
 id 1jAHlW-0003W4-Bm
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 13:32:08 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:47137)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=32724e9af=alistair.francis@wdc.com>)
 id 1jAHlV-0003Db-II; Fri, 06 Mar 2020 13:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583519532; x=1615055532;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eTAQO7hK8pO+bJDBUbfEgC8vuuepk8Y/fLd6r3xIXR4=;
 b=PUqiyVVdAZz2h8ev+y7nEZOBojKdBnl45JD+E0JAid/UqXjmb4DeC4TX
 MIcH2mjSLX0BrJO8SnKlqyAk3y+9PzcrdCECF7gag1+xb/4wtSH0SlGnQ
 bVDzGMKIc93Z6vnrXZYyJ+gTb7WClVGsOR0u/tHQk22ADbyXS1ESiVGYa
 NkoCPa2MCmsUkeC0wmXmL0CoQSn49Dw5joCR0YOpeswVTQcYwmBaVrOhG
 iFdSoMhaJQDu4jn8t/Y+Iv4IQhY+zRE5mYvWql026hu6uppAN105PYrgl
 VcCWPx6OoGRykEl0ehlRNBgdSzEOlmks9wIv5hlQ8sS685qQq5xxnrt+h Q==;
IronPort-SDR: sEG3zj8wLmd+JoRWqNuaAtMFIGyUQqD0dr6xZRpaNAiQKNMxyDJXH4ViuFH9HimVbN0w66Q4Ba
 KaszW0HF/4RV0ZLpuxPxD+9/+WHL7lxhqvZM9PYa04yW7OcW4yuF41GP8p0DahS9G/UkuKm87B
 MYNx3Rj76nm3qdKCZIcx13CkTh9AHt4mG++0jMqu4PbZiJYoAq4cZUeW41+Y4YaOb/94SX3w13
 bc9ZpwE/HCugwBY6WcZ71MahijTDWJsHnvPaeRtlU1bn4btAmY+akmlAPiHkGHPrbcXDcywxOp
 bPs=
X-IronPort-AV: E=Sophos;i="5.70,523,1574092800"; d="scan'208";a="233755501"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2020 02:31:48 +0800
IronPort-SDR: rsrXR9CYJs+1cbRKdJbMeNNYCgs53hflmsquiDUzTC3/wHBSPUrC01tPJoKyt2zaePsu4iJ5bQ
 a4L2LDYJsQQLY6hRx34n7FtzaT65Gyt5b8k9ZusD1Vj6oBMtzcjxgqZrUJvWMQ+wTdiuGhNFZA
 IBFBHuYByvSZTTt9b1DPr3+XjIis62bluZl1rdpZ7q1dwuhZbqD0ma/l07BxUDknAejEB+/5c2
 kIVdUCDX5ytVBP2XQWdgWXgZBxnODwax+crPbuZW/B1lgdwYwp6dZdsvDIwvd1CYIUWgRGLoaF
 2flZ9GZl9145RM3NWxM5N7nP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2020 10:23:56 -0800
IronPort-SDR: Q8OXUZkr945rW6E5TZ6gWlh0C44VAiuiGvlom83O660nLMAFAj3T/qA/lHoIkFGUHjDwYaCk1c
 vQ2Ft3Yyl6CFvuSscY2OHMcOfA0zOOGmqEpYBjWwtnGorkNIiosD3rRLGOjzo5hNJbdEWrp0fl
 DPw0j0DVoQbMqsK8QnEIbbpK8BmgA+x1dK/Rv3Ez6ajwZzBThP//bVoY4MRRVCPGTSK5HAX8bA
 YooRBw+6QbIFCgr6wB1BI5Gh7FP4fl+QqAUwj7ul9D0cSeoBHuLfkIwW4v1ciz1rbkYTwMpe0z
 zms=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Mar 2020 10:31:45 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, aleksandar.m.mail@gmail.com,
 laurent@vivier.eu
Subject: [PATCH v6 3/4] linux-user: Support futex_time64
Date: Fri,  6 Mar 2020 10:24:28 -0800
Message-Id: <b7595a50debfc704e63fde17425eb399a5e5a707.1583518447.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583518447.git.alistair.francis@wdc.com>
References: <cover.1583518447.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for host and target futex_time64. If futex_time64 exists on
the host we try that first before falling back to the standard futux
syscall.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/syscall.c | 98 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 80 insertions(+), 18 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0f219b26c1..8a50e2d3dc 100644
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
@@ -295,10 +300,15 @@ _syscall1(int,exit_group,int,error_code)
 #if defined(TARGET_NR_set_tid_address) && defined(__NR_set_tid_address)
 _syscall1(int,set_tid_address,int *,tidptr)
 #endif
-#if defined(TARGET_NR_futex) && defined(__NR_futex)
+#if (defined(TARGET_NR_futex) || defined(TARGET_NR_futex_time64)) && \
+    defined(__NR_futex)
 _syscall6(int,sys_futex,int *,uaddr,int,op,int,val,
           const struct timespec *,timeout,int *,uaddr2,int,val3)
 #endif
+#if defined(TARGET_NR_futex_time64) && defined(__NR_futex_time64)
+_syscall6(int,sys_futex_time64,int *,uaddr,int,op,int,val,
+          const struct timespec *,timeout,int *,uaddr2,int,val3)
+#endif
 #define __NR_sys_sched_getaffinity __NR_sched_getaffinity
 _syscall3(int, sys_sched_getaffinity, pid_t, pid, unsigned int, len,
           unsigned long *, user_mask_ptr);
@@ -762,10 +772,14 @@ safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
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
@@ -1210,7 +1224,7 @@ static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr,
     return 0;
 }
 
-#if defined(TARGET_NR_futex) || \
+#if defined(TARGET_NR_futex) || defined(TARGET_NR_futex_time64) || \
     defined(TARGET_NR_rt_sigtimedwait) || \
     defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6) || \
     defined(TARGET_NR_nanosleep) || defined(TARGET_NR_clock_settime) || \
@@ -6898,12 +6912,12 @@ static inline abi_long host_to_target_statx(struct target_statx *host_stx,
    futexes locally would make futexes shared between multiple processes
    tricky.  However they're probably useless because guest atomic
    operations won't work either.  */
-#if defined(TARGET_NR_futex)
+#if defined(TARGET_NR_futex) || defined(TARGET_NR_futex_time64)
 static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
                     target_ulong uaddr2, int val3)
 {
     struct timespec ts, *pts;
-    int base_op;
+    int base_op, err = -ENOSYS;
 
     /* ??? We assume FUTEX_* constants are the same on both host
        and target.  */
@@ -6915,18 +6929,49 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
     switch (base_op) {
     case FUTEX_WAIT:
     case FUTEX_WAIT_BITSET:
+#ifdef __NR_futex_time64
+        struct __kernel_timespec ts64, *pts64;
+
         if (timeout) {
-            pts = &ts;
-            target_to_host_timespec(pts, timeout);
+            pts64 = &ts64;
+            target_to_host_timespec64(pts64, timeout);
         } else {
-            pts = NULL;
+            pts64 = NULL;
+        }
+
+        err = get_errno(safe_futex_time64(g2h(uaddr), op, tswap32(val),
+                         pts64, NULL, val3));
+#endif
+#ifdef __NR_futex
+        if (err == -ENOSYS) {
+            if (timeout) {
+                pts = &ts;
+                target_to_host_timespec(pts, timeout);
+            } else {
+                pts = NULL;
+            }
+            return get_errno(safe_futex(g2h(uaddr), op, tswap32(val),
+                             pts, NULL, val3));
         }
-        return get_errno(safe_futex(g2h(uaddr), op, tswap32(val),
-                         pts, NULL, val3));
+#endif
     case FUTEX_WAKE:
-        return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
+#ifdef __NR_futex_time64
+        err = get_errno(safe_futex_time64(g2h(uaddr), op, val, NULL, NULL, 0));
+#endif
+#ifdef __NR_futex
+        if (err == -ENOSYS) {
+            return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
+        }
+#endif
     case FUTEX_FD:
-        return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
+#ifdef __NR_futex_time64
+        err = get_errno(safe_futex_time64(g2h(uaddr), op, val, NULL, NULL, 0));
+#endif
+#ifdef __NR_futex
+        if (err == -ENOSYS) {
+            return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
+        }
+#endif
     case FUTEX_REQUEUE:
     case FUTEX_CMP_REQUEUE:
     case FUTEX_WAKE_OP:
@@ -6935,12 +6980,25 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
            But the prototype takes a `struct timespec *'; insert casts
            to satisfy the compiler.  We do not need to tswap TIMEOUT
            since it's not compared to guest memory.  */
+#ifdef __NR_futex_time64
+        struct __kernel_timespec *pts64;
+        pts64 = (struct __kernel_timespec *)(uintptr_t) timeout;
+        ret = get_errno(safe_futex_time64(g2h(uaddr), op, val, pts64,
+                                   g2h(uaddr2),
+                                   (base_op == FUTEX_CMP_REQUEUE
+                                    ? tswap32(val3)
+                                    : val3)));
+#endif
+#ifdef __NR_futex
         pts = (struct timespec *)(uintptr_t) timeout;
-        return get_errno(safe_futex(g2h(uaddr), op, val, pts,
-                                    g2h(uaddr2),
-                                    (base_op == FUTEX_CMP_REQUEUE
-                                     ? tswap32(val3)
-                                     : val3)));
+        if (err == -ENOSYS) {
+            return get_errno(safe_futex(g2h(uaddr), op, val, pts,
+                                      g2h(uaddr2),
+                                      (base_op == FUTEX_CMP_REQUEUE
+                                       ? tswap32(val3)
+                                       : val3)));
+        }
+#endif
     default:
         return -TARGET_ENOSYS;
     }
@@ -11599,6 +11657,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_futex:
         return do_futex(arg1, arg2, arg3, arg4, arg5, arg6);
 #endif
+#ifdef TARGET_NR_futex_time64
+    case TARGET_NR_futex_time64:
+        return do_futex(arg1, arg2, arg3, arg4, arg5, arg6);
+#endif
 #if defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)
     case TARGET_NR_inotify_init:
         ret = get_errno(sys_inotify_init());
-- 
2.25.1


