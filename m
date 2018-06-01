Received: from eggs.gnu.org ([2001:4830:134:3::10]:57528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWu-0005bg-07
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWt-0000Xv-37
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:19 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:36696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWs-0000X1-TL
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:19 -0400
Received: by mail-pf0-x22f.google.com with SMTP id w129-v6so12092166pfd.3
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:34 -0700
Message-Id: <20180601073050.8054-18-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 17/33] linux-user: Split out unlink, unlinkat
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
 linux-user/syscall.c | 59 ++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b5736436f8..bbe9d6d9fb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8276,6 +8276,40 @@ IMPL(read)
     return ret;
 }
 
+#ifdef TARGET_NR_unlink
+IMPL(unlink)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(unlink(p));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
+#ifdef TARGET_NR_unlinkat
+IMPL(unlinkat)
+{
+    char *p;
+    abi_long ret;
+
+    if (is_hostfd(arg1)) {
+        return -TARGET_EBADF;
+    }
+    p = lock_user_string(arg2);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(unlinkat(arg1, p, arg3));
+    unlock_user(p, arg2, 0);
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_waitid
 IMPL(waitid)
 {
@@ -8352,25 +8386,6 @@ IMPL(everything_else)
     char *fn;
 
     switch(num) {
-#ifdef TARGET_NR_unlink
-    case TARGET_NR_unlink:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(unlink(p));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-#if defined(TARGET_NR_unlinkat)
-    case TARGET_NR_unlinkat:
-        if (is_hostfd(arg1)) {
-            return -TARGET_EBADF;
-        }
-        if (!(p = lock_user_string(arg2)))
-            return -TARGET_EFAULT;
-        ret = get_errno(unlinkat(arg1, p, arg3));
-        unlock_user(p, arg2, 0);
-        return ret;
-#endif
     case TARGET_NR_chdir:
         if (!(p = lock_user_string(arg1)))
             return -TARGET_EFAULT;
@@ -12978,6 +12993,12 @@ static impl_fn * const syscall_table[] = {
     [TARGET_NR_open_by_handle_at] = impl_open_by_handle_at,
 #endif
     [TARGET_NR_read] = impl_read,
+#ifdef TARGET_NR_unlink
+    [TARGET_NR_unlink] = impl_unlink,
+#endif
+#if TARGET_NR_unlinkat
+    [TARGET_NR_unlinkat] = impl_unlinkat,
+#endif
 #ifdef TARGET_NR_waitid
     [TARGET_NR_waitid] = impl_waitid,
 #endif
-- 
2.17.0
