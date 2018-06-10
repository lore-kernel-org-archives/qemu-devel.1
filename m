Received: from eggs.gnu.org ([2001:4830:134:3::10]:41188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfE-0003qY-9a
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfD-0004Kc-De
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:08 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:43801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfD-0004KK-7u
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:07 -0400
Received: by mail-pf0-x241.google.com with SMTP id j20-v6so8482171pff.10
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:48 -1000
Message-Id: <20180610030220.3777-77-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 076/108] linux-user: Split out setfsgid,
 setfsuid, setgid, setuid
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
 linux-user/syscall.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c55c414239..76a66b56fe 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10533,6 +10533,21 @@ IMPL(setdomainname)
     return ret;
 }
 
+IMPL(setfsgid)
+{
+    return get_errno(setfsgid(arg1));
+}
+
+IMPL(setfsuid)
+{
+    return get_errno(setfsuid(arg1));
+}
+
+IMPL(setgid)
+{
+    return get_errno(sys_setgid(low2highgid(arg1)));
+}
+
 IMPL(setgroups)
 {
     int gidsetsize = arg1;
@@ -10668,6 +10683,11 @@ IMPL(setsid)
     return get_errno(setsid());
 }
 
+IMPL(setuid)
+{
+    return get_errno(sys_setuid(low2highuid(arg1)));
+}
+
 #ifdef TARGET_NR_sigaction
 IMPL(sigaction)
 {
@@ -11594,15 +11614,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_setuid:
-        return get_errno(sys_setuid(low2highuid(arg1)));
-    case TARGET_NR_setgid:
-        return get_errno(sys_setgid(low2highgid(arg1)));
-    case TARGET_NR_setfsuid:
-        return get_errno(setfsuid(arg1));
-    case TARGET_NR_setfsgid:
-        return get_errno(setfsgid(arg1));
-
 #ifdef TARGET_NR_lchown32
     case TARGET_NR_lchown32:
         if (!(p = lock_user_string(arg1)))
@@ -13406,6 +13417,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(sendto);
 #endif
         SYSCALL(setdomainname);
+        SYSCALL(setfsgid);
+        SYSCALL(setfsuid);
+        SYSCALL(setgid);
         SYSCALL(setgroups);
         SYSCALL(sethostname);
         SYSCALL(setitimer);
@@ -13425,6 +13439,7 @@ static impl_fn *syscall_table(unsigned num)
 #endif
         SYSCALL(settimeofday);
         SYSCALL(setsid);
+        SYSCALL(setuid);
 #ifdef TARGET_NR_sigaction
         SYSCALL(sigaction);
 #endif
-- 
2.17.1
