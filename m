Received: from eggs.gnu.org ([2001:4830:134:3::10]:41222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfL-0003xl-2V
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfJ-0004M1-TW
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:15 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:45906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfJ-0004Lu-NQ
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:13 -0400
Received: by mail-pl0-x241.google.com with SMTP id c23-v6so10385320plz.12
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:51 -1000
Message-Id: <20180610030220.3777-80-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 079/108] linux-user: Split out getegid32,
 geteuid32, getgid32, setregid32, setreuid32
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
 linux-user/syscall.c | 70 +++++++++++++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 20 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ae591a6523..c8bd13092e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8482,6 +8482,13 @@ IMPL(getegid)
 }
 #endif
 
+#ifdef TARGET_NR_getegid32
+IMPL(getegid32)
+{
+    return get_errno(getegid());
+}
+#endif
+
 #ifdef TARGET_NR_geteuid
 IMPL(geteuid)
 {
@@ -8489,6 +8496,13 @@ IMPL(geteuid)
 }
 #endif
 
+#ifdef TARGET_NR_geteuid32
+IMPL(geteuid32)
+{
+    return get_errno(geteuid());
+}
+#endif
+
 #ifdef TARGET_NR_getgid
 IMPL(getgid)
 {
@@ -8496,6 +8510,13 @@ IMPL(getgid)
 }
 #endif
 
+#ifdef TARGET_NR_getgid32
+IMPL(getgid32)
+{
+    return get_errno(getgid());
+}
+#endif
+
 IMPL(getgroups)
 {
     int gidsetsize = arg1;
@@ -10812,6 +10833,13 @@ IMPL(setregid)
     return get_errno(setregid(low2highgid(arg1), low2highgid(arg2)));
 }
 
+#ifdef TARGET_NR_setregid32
+IMPL(setregid32)
+{
+    return get_errno(setregid(arg1, arg2));
+}
+#endif
+
 #ifdef TARGET_NR_setresgid
 IMPL(setresgid)
 {
@@ -10833,6 +10861,13 @@ IMPL(setreuid)
     return get_errno(setreuid(low2highuid(arg1), low2highuid(arg2)));
 }
 
+#ifdef TARGET_NR_setreuid32
+IMPL(setreuid32)
+{
+    return get_errno(setreuid(arg1, arg2));
+}
+#endif
+
 IMPL(setrlimit)
 {
     int resource = target_to_host_resource(arg1);
@@ -11805,26 +11840,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_getgid32
-    case TARGET_NR_getgid32:
-        return get_errno(getgid());
-#endif
-#ifdef TARGET_NR_geteuid32
-    case TARGET_NR_geteuid32:
-        return get_errno(geteuid());
-#endif
-#ifdef TARGET_NR_getegid32
-    case TARGET_NR_getegid32:
-        return get_errno(getegid());
-#endif
-#ifdef TARGET_NR_setreuid32
-    case TARGET_NR_setreuid32:
-        return get_errno(setreuid(arg1, arg2));
-#endif
-#ifdef TARGET_NR_setregid32
-    case TARGET_NR_setregid32:
-        return get_errno(setregid(arg1, arg2));
-#endif
 #ifdef TARGET_NR_getgroups32
     case TARGET_NR_getgroups32:
         {
@@ -13168,11 +13183,20 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_getegid
         SYSCALL(getegid);
 #endif
+#ifdef TARGET_NR_getegid32
+        SYSCALL(getegid32);
+#endif
 #ifdef TARGET_NR_geteuid
         SYSCALL(geteuid);
 #endif
+#ifdef TARGET_NR_geteuid32
+        SYSCALL(geteuid32);
+#endif
 #ifdef TARGET_NR_getgid
         SYSCALL(getgid);
+#endif
+#ifdef TARGET_NR_getgid32
+        SYSCALL(getgid32);
 #endif
         SYSCALL(getgroups);
         SYSCALL(getitimer);
@@ -13447,10 +13471,16 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_setresgid
         SYSCALL(setresgid);
 #endif
+#ifdef TARGET_NR_setregid32
+        SYSCALL(setregid32);
+#endif
 #ifdef TARGET_NR_setresuid
         SYSCALL(setresuid);
 #endif
         SYSCALL(setreuid);
+#ifdef TARGET_NR_setreuid32
+        SYSCALL(setreuid32);
+#endif
         SYSCALL(setrlimit);
 #ifdef TARGET_NR_setsockopt
         SYSCALL(setsockopt);
-- 
2.17.1
