Received: from eggs.gnu.org ([2001:4830:134:3::10]:41263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfQ-00043c-Ry
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfP-0004NX-Fu
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:20 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:41364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfP-0004NL-98
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:19 -0400
Received: by mail-pf0-x244.google.com with SMTP id a11-v6so8486595pff.8
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:54 -1000
Message-Id: <20180610030220.3777-83-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 082/108] linux-user: Split out chown32,
 setfsgid32, setfsuid32, setgid32, setuid32
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
 linux-user/syscall.c | 82 +++++++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 24 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index af96cc95d3..fc7f301519 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7802,6 +7802,21 @@ IMPL(chown)
 }
 #endif
 
+#ifdef TARGET_NR_chown32
+IMPL(chown32)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(chown(p, arg2, arg3));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
 IMPL(chroot)
 {
     char *p = lock_user_string(arg1);
@@ -10815,16 +10830,37 @@ IMPL(setfsgid)
     return get_errno(setfsgid(arg1));
 }
 
+#ifdef TARGET_NR_setfsgid32
+IMPL(setfsgid32)
+{
+    return get_errno(setfsgid(arg1));
+}
+#endif
+
 IMPL(setfsuid)
 {
     return get_errno(setfsuid(arg1));
 }
 
+#ifdef TARGET_NR_setfsuid32
+IMPL(setfsuid32)
+{
+    return get_errno(setfsuid(arg1));
+}
+#endif
+
 IMPL(setgid)
 {
     return get_errno(sys_setgid(low2highgid(arg1)));
 }
 
+#ifdef TARGET_NR_setgid32
+IMPL(setgid32)
+{
+    return get_errno(sys_setgid(arg1));
+}
+#endif
+
 IMPL(setgroups)
 {
     int gidsetsize = arg1;
@@ -11017,6 +11053,13 @@ IMPL(setuid)
     return get_errno(sys_setuid(low2highuid(arg1)));
 }
 
+#ifdef TARGET_NR_setuid32
+IMPL(setuid32)
+{
+    return get_errno(sys_setuid(arg1));
+}
+#endif
+
 #ifdef TARGET_NR_sigaction
 IMPL(sigaction)
 {
@@ -11943,30 +11986,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_chown32
-    case TARGET_NR_chown32:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(chown(p, arg2, arg3));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-#ifdef TARGET_NR_setuid32
-    case TARGET_NR_setuid32:
-        return get_errno(sys_setuid(arg1));
-#endif
-#ifdef TARGET_NR_setgid32
-    case TARGET_NR_setgid32:
-        return get_errno(sys_setgid(arg1));
-#endif
-#ifdef TARGET_NR_setfsuid32
-    case TARGET_NR_setfsuid32:
-        return get_errno(setfsuid(arg1));
-#endif
-#ifdef TARGET_NR_setfsgid32
-    case TARGET_NR_setfsgid32:
-        return get_errno(setfsgid(arg1));
-#endif
 #ifdef TARGET_NR_mincore
     case TARGET_NR_mincore:
         {
@@ -13139,6 +13158,9 @@ static impl_fn *syscall_table(unsigned num)
 #endif
 #ifdef TARGET_NR_chown
         SYSCALL(chown);
+#endif
+#ifdef TARGET_NR_chown32
+        SYSCALL(chown32);
 #endif
         SYSCALL(chroot);
 #ifdef TARGET_NR_connect
@@ -13492,8 +13514,17 @@ static impl_fn *syscall_table(unsigned num)
 #endif
         SYSCALL(setdomainname);
         SYSCALL(setfsgid);
+#ifdef TARGET_NR_setfsgid32
+        SYSCALL(setfsgid32);
+#endif
         SYSCALL(setfsuid);
+#ifdef TARGET_NR_setfsuid32
+        SYSCALL(setfsuid32);
+#endif
         SYSCALL(setgid);
+#ifdef TARGET_NR_setgid32
+        SYSCALL(setgid32);
+#endif
         SYSCALL(setgroups);
 #ifdef TARGET_NR_setgroups32
         SYSCALL(setgroups32);
@@ -13529,6 +13560,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(settimeofday);
         SYSCALL(setsid);
         SYSCALL(setuid);
+#ifdef TARGET_NR_setuid32
+        SYSCALL(setuid32);
+#endif
 #ifdef TARGET_NR_sigaction
         SYSCALL(sigaction);
 #endif
-- 
2.17.1
