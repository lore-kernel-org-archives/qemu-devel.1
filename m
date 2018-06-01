Received: from eggs.gnu.org ([2001:4830:134:3::10]:57697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeXC-0005vN-JB
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeXA-0000pd-1r
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:38 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:36963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeX9-0000or-Rt
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:35 -0400
Received: by mail-pg0-x236.google.com with SMTP id a13-v6so10873101pgu.4
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:46 -0700
Message-Id: <20180601073050.8054-30-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 29/33] linux-user: Split out getpgrp, getppid,
 setsid
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
index 4d9b9cad6e..3dfb77ac11 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8182,6 +8182,13 @@ IMPL(futimesat)
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
@@ -8189,6 +8196,13 @@ IMPL(getpid)
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
@@ -8721,6 +8735,11 @@ IMPL(setpgid)
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
@@ -8972,16 +8991,6 @@ IMPL(everything_else)
     char *fn;
 
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
@@ -13020,9 +13029,15 @@ static impl_fn * const syscall_table[] = {
 #ifdef TARGET_NR_futimesat
     [TARGET_NR_futimesat] = impl_futimesat,
 #endif
+#ifdef TARGET_NR_getpgrp
+    [TARGET_NR_getpgrp] = impl_getpgrp,
+#endif
 #ifdef TARGET_NR_getpid
     [TARGET_NR_getpid] = impl_getpid,
 #endif
+#ifdef TARGET_NR_getppid
+    [TARGET_NR_getppid] = impl_getppid,
+#endif
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
     [TARGET_NR_getxpid] = impl_getxpid,
 #endif
@@ -13084,6 +13099,7 @@ static impl_fn * const syscall_table[] = {
     [TARGET_NR_rmdir] = impl_rmdir,
 #endif
     [TARGET_NR_setpgid] = impl_setpgid,
+    [TARGET_NR_setsid] = impl_setsid,
 #ifdef TARGET_NR_stime
     [TARGET_NR_stime] = impl_stime,
 #endif
-- 
2.17.0
