Received: from eggs.gnu.org ([2001:4830:134:3::10]:41407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfm-0004QN-26
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfj-0004gd-AB
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:42 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:42524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfj-0004gJ-5O
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:39 -0400
Received: by mail-pg0-x241.google.com with SMTP id c10-v6so2509671pgu.9
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:05 -1000
Message-Id: <20180610030220.3777-94-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 093/108] linux-user: Remove sys_futex
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

We can use safe_futex in the one place that used sys_futex;
no need to define them both.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 800b79276f..95b30adea2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -235,7 +235,6 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #define __NR_sys_rt_sigqueueinfo __NR_rt_sigqueueinfo
 #define __NR_sys_rt_tgsigqueueinfo __NR_rt_tgsigqueueinfo
 #define __NR_sys_syslog __NR_syslog
-#define __NR_sys_futex __NR_futex
 #define __NR_sys_inotify_init __NR_inotify_init
 #define __NR_sys_inotify_add_watch __NR_inotify_add_watch
 #define __NR_sys_inotify_rm_watch __NR_inotify_rm_watch
@@ -282,10 +281,6 @@ _syscall3(int,sys_syslog,int,type,char*,bufp,int,len)
 _syscall1(int,exit_group,int,error_code)
 #endif
 _syscall1(int,set_tid_address,int *,tidptr)
-#if defined(TARGET_NR_futex) && defined(__NR_futex)
-_syscall6(int,sys_futex,int *,uaddr,int,op,int,val,
-          const struct timespec *,timeout,int *,uaddr2,int,val3)
-#endif
 #define __NR_sys_sched_getaffinity __NR_sched_getaffinity
 _syscall3(int, sys_sched_getaffinity, pid_t, pid, unsigned int, len,
           unsigned long *, user_mask_ptr);
@@ -8079,8 +8074,8 @@ IMPL(exit)
         TaskState *ts = cpu->opaque;
         if (ts->child_tidptr) {
             put_user_u32(0, ts->child_tidptr);
-            sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
-                      NULL, NULL, 0);
+            safe_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
+                       NULL, NULL, 0);
         }
         thread_cpu = NULL;
         object_unref(OBJECT(cpu));
-- 
2.17.1
