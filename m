Received: from eggs.gnu.org ([2001:4830:134:3::10]:40423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdd-0002KC-Az
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdc-0003SC-Eg
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:29 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:42796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqdc-0003Rr-8g
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:28 -0400
Received: by mail-pl0-x243.google.com with SMTP id w17-v6so10389854pll.9
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:00 -1000
Message-Id: <20180610030220.3777-29-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 028/108] linux-user: Split out getpgrp,
 getppid, setsid
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
 linux-user/syscall.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8e13a16e91..d78288258a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8131,6 +8131,13 @@ IMPL(futimesat)
 }
 #endif
 
+#ifdef TARGET_NR_getpgrp
+IMPL(getpgrp)
+{
+    return get_errno(getpgrp());
+}
+#endif
+
 #ifdef TARGET_NR_getpid
 IMPL(getpid)
 {
@@ -8138,6 +8145,13 @@ IMPL(getpid)
 }
 #endif
 
+#ifdef TARGET_NR_getppid
+IMPL(getppid)
+{
+    return get_errno(getppid());
+}
+#endif
+
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
 IMPL(getxpid)
 {
@@ -8613,6 +8627,11 @@ IMPL(setpgid)
     return get_errno(setpgid(arg1, arg2));
 }
 
+IMPL(setsid)
+{
+    return get_errno(setsid());
+}
+
 #ifdef TARGET_NR_stime
 IMPL(stime)
 {
@@ -8854,16 +8873,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_getppid /* not on alpha */
-    case TARGET_NR_getppid:
-        return get_errno(getppid());
-#endif
-#ifdef TARGET_NR_getpgrp
-    case TARGET_NR_getpgrp:
-        return get_errno(getpgrp());
-#endif
-    case TARGET_NR_setsid:
-        return get_errno(setsid());
 #ifdef TARGET_NR_sigaction
     case TARGET_NR_sigaction:
         {
@@ -12673,9 +12682,15 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_futimesat
         SYSCALL(futimesat);
 #endif
+#ifdef TARGET_NR_getpgrp
+        SYSCALL(getpgrp);
+#endif
 #ifdef TARGET_NR_getpid
         SYSCALL(getpid);
 #endif
+#ifdef TARGET_NR_getppid
+        SYSCALL(getppid);
+#endif
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
         SYSCALL(getxpid);
 #endif
@@ -12727,6 +12742,7 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(rmdir);
 #endif
         SYSCALL(setpgid);
+        SYSCALL(setsid);
 #ifdef TARGET_NR_stime
         SYSCALL(stime);
 #endif
-- 
2.17.1
