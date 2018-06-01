Received: from eggs.gnu.org ([2001:4830:134:3::10]:57571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWy-0005gQ-FH
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWx-0000c8-IC
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:24 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:33834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWx-0000bR-CD
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:23 -0400
Received: by mail-pl0-x243.google.com with SMTP id ay10-v6so14819429plb.1
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:37 -0700
Message-Id: <20180601073050.8054-21-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 20/33] linux-user: Split out getpid, getxpid,
 lseek
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
 linux-user/syscall.c | 45 +++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6a701ea8f6..b568144369 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8106,6 +8106,21 @@ IMPL(fork)
 }
 #endif
 
+#ifdef TARGET_NR_getpid
+IMPL(getpid)
+{
+    return get_errno(getpid());
+}
+#endif
+
+#if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
+IMPL(getxpid)
+{
+    ((CPUAlphaState *)cpu_env)->ir[IR_A4] = getppid();
+    return get_errno(getpid());
+}
+#endif
+
 #ifdef TARGET_NR_link
 IMPL(link)
 {
@@ -8143,6 +8158,14 @@ IMPL(linkat)
 }
 #endif
 
+IMPL(lseek)
+{
+    if (is_hostfd(arg1)) {
+        return -TARGET_EBADF;
+    }
+    return get_errno(lseek(arg1, arg2, arg3));
+}
+
 #ifdef TARGET_NR_mknod
 IMPL(mknod)
 {
@@ -8460,21 +8483,6 @@ IMPL(everything_else)
     char *fn;
 
     switch(num) {
-    case TARGET_NR_lseek:
-        if (is_hostfd(arg1)) {
-            return -TARGET_EBADF;
-        }
-        return get_errno(lseek(arg1, arg2, arg3));
-#if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
-    /* Alpha specific */
-    case TARGET_NR_getxpid:
-        ((CPUAlphaState *)cpu_env)->ir[IR_A4] = getppid();
-        return get_errno(getpid());
-#endif
-#ifdef TARGET_NR_getpid
-    case TARGET_NR_getpid:
-        return get_errno(getpid());
-#endif
     case TARGET_NR_mount:
         {
             /* need to look at the data field */
@@ -12869,12 +12877,19 @@ static impl_fn * const syscall_table[] = {
 #ifdef TARGET_NR_fork
     [TARGET_NR_fork] = impl_fork,
 #endif
+#ifdef TARGET_NR_getpid
+    [TARGET_NR_getpid] = impl_getpid,
+#endif
+#if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
+    [TARGET_NR_getxpid] = impl_getxpid,
+#endif
 #ifdef TARGET_NR_link
     [TARGET_NR_link] = impl_link,
 #endif
 #if defined(TARGET_NR_linkat)
     [TARGET_NR_linkat] = impl_linkat,
 #endif
+    [TARGET_NR_lseek] = impl_lseek,
 #ifdef TARGET_NR_mknod
     [TARGET_NR_mknod] = impl_mknod,
 #endif
-- 
2.17.0
