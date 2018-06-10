Received: from eggs.gnu.org ([2001:4830:134:3::10]:41372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfg-0004LU-Jh
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqff-0004fX-JV
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:36 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:33747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqff-0004fJ-D1
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:35 -0400
Received: by mail-pl0-x241.google.com with SMTP id n10-v6so10392216plp.0
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:03 -1000
Message-Id: <20180610030220.3777-92-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 091/108] linux-user: Split out
 set_tid_address, tgkill, tkill
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

All targets define set_tid_address; remove the ifdef.
Use the bogus syscall method to supply the host syscall.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1c1e05dc26..8406b9d8d3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -250,6 +250,9 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #ifndef __NR_gettid
 #define __NR_gettid  -1
 #endif
+#ifndef __NR_set_tid_address
+#define __NR_set_tid_address  -1
+#endif
 
 _syscall0(int, gettid)
 
@@ -278,9 +281,7 @@ _syscall3(int,sys_syslog,int,type,char*,bufp,int,len)
 #ifdef __NR_exit_group
 _syscall1(int,exit_group,int,error_code)
 #endif
-#if defined(TARGET_NR_set_tid_address) && defined(__NR_set_tid_address)
 _syscall1(int,set_tid_address,int *,tidptr)
-#endif
 #if defined(TARGET_NR_futex) && defined(__NR_futex)
 _syscall6(int,sys_futex,int *,uaddr,int,op,int,val,
           const struct timespec *,timeout,int *,uaddr2,int,val3)
@@ -11578,6 +11579,11 @@ IMPL(set_thread_area)
 }
 #endif
 
+IMPL(set_tid_address)
+{
+    return get_errno(set_tid_address((int *)g2h(arg1)));
+}
+
 IMPL(settimeofday)
 {
     struct timeval tv;
@@ -12210,6 +12216,12 @@ IMPL(syslog)
     }
 }
 
+IMPL(tgkill)
+{
+    return get_errno(safe_tgkill((int)arg1, (int)arg2,
+                                 target_to_host_signal(arg3)));
+}
+
 #ifdef TARGET_NR_time
 IMPL(time)
 {
@@ -12244,6 +12256,11 @@ IMPL(times)
     return host_to_target_clock_t(ret);
 }
 
+IMPL(tkill)
+{
+    return get_errno(safe_tkill((int)arg1, target_to_host_signal(arg2)));
+}
+
 IMPL(truncate)
 {
     char *p = lock_user_string(arg1);
@@ -12562,19 +12579,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#if defined(TARGET_NR_set_tid_address) && defined(__NR_set_tid_address)
-    case TARGET_NR_set_tid_address:
-        return get_errno(set_tid_address((int *)g2h(arg1)));
-#endif
-
-    case TARGET_NR_tkill:
-        return get_errno(safe_tkill((int)arg1, target_to_host_signal(arg2)));
-
-    case TARGET_NR_tgkill:
-        return get_errno(safe_tgkill((int)arg1, (int)arg2,
-                         target_to_host_signal(arg3)));
-
-
 #if defined(TARGET_NR_utimensat)
     case TARGET_NR_utimensat:
         {
@@ -13762,6 +13766,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_set_thread_area
         SYSCALL(set_thread_area);
 #endif
+        SYSCALL(set_tid_address);
         SYSCALL(settimeofday);
         SYSCALL(setsid);
         SYSCALL(setuid);
@@ -13827,10 +13832,12 @@ static impl_fn *syscall_table(unsigned num)
 #endif
         SYSCALL(sysinfo);
         SYSCALL(syslog);
+        SYSCALL(tgkill);
 #ifdef TARGET_NR_time
         SYSCALL(time);
 #endif
         SYSCALL(times);
+        SYSCALL(tkill);
         SYSCALL(truncate);
 #ifdef TARGET_NR_truncate64
         SYSCALL(truncate64);
-- 
2.17.1
