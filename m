Received: from eggs.gnu.org ([2001:4830:134:3::10]:57508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWs-0005a9-Ob
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWr-0000Wb-SB
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:18 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWr-0000Vo-MH
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:17 -0400
Received: by mail-pf0-x242.google.com with SMTP id x9-v6so12086132pfm.2
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:33 -0700
Message-Id: <20180601073050.8054-17-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 16/33] linux-user: Split out link, linkat
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
 linux-user/syscall.c | 77 +++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e208f8647a..b5736436f8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8078,6 +8078,43 @@ IMPL(fork)
 }
 #endif
 
+#ifdef TARGET_NR_link
+IMPL(link)
+{
+    char *p1 = lock_user_string(arg1);
+    char *p2 = lock_user_string(arg2);
+    abi_long ret = -TARGET_EFAULT;
+
+    if (p1 && p2) {
+        ret = get_errno(link(p1, p2));
+    }
+    unlock_user(p1, arg1, 0);
+    unlock_user(p2, arg2, 0);
+    return ret;
+}
+#endif
+
+#if defined(TARGET_NR_linkat)
+IMPL(linkat)
+{
+    char *p1, *p2;
+    abi_long ret;
+
+    if (is_hostfd(arg1)) {
+        return -TARGET_EBADF;
+    }
+    p1 = lock_user_string(arg2);
+    p2 = lock_user_string(arg4);
+    ret = -TARGET_EFAULT;
+    if (p1 && p2) {
+        ret = get_errno(linkat(arg1, p1, arg3, p2, arg5));
+    }
+    unlock_user(p1, arg2, 0);
+    unlock_user(p2, arg4, 0);
+    return ret;
+}
+#endif
+
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
 IMPL(name_to_handle_at)
 {
@@ -8315,40 +8352,6 @@ IMPL(everything_else)
     char *fn;
 
     switch(num) {
-#ifdef TARGET_NR_link
-    case TARGET_NR_link:
-        {
-            void * p2;
-            p = lock_user_string(arg1);
-            p2 = lock_user_string(arg2);
-            if (!p || !p2)
-                ret = -TARGET_EFAULT;
-            else
-                ret = get_errno(link(p, p2));
-            unlock_user(p2, arg2, 0);
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_linkat)
-    case TARGET_NR_linkat:
-        if (is_hostfd(arg1)) {
-            return -TARGET_EBADF;
-        } else {
-            void * p2 = NULL;
-            if (!arg2 || !arg4)
-                return -TARGET_EFAULT;
-            p  = lock_user_string(arg2);
-            p2 = lock_user_string(arg4);
-            if (!p || !p2)
-                ret = -TARGET_EFAULT;
-            else
-                ret = get_errno(linkat(arg1, p, arg3, p2, arg5));
-            unlock_user(p, arg2, 0);
-            unlock_user(p2, arg4, 0);
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_unlink
     case TARGET_NR_unlink:
         if (!(p = lock_user_string(arg1)))
@@ -12958,6 +12961,12 @@ static impl_fn * const syscall_table[] = {
 #ifdef TARGET_NR_fork
     [TARGET_NR_fork] = impl_fork,
 #endif
+#ifdef TARGET_NR_link
+    [TARGET_NR_link] = impl_link,
+#endif
+#if defined(TARGET_NR_linkat)
+    [TARGET_NR_linkat] = impl_linkat,
+#endif
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     [TARGET_NR_name_to_handle_at] = impl_name_to_handle_at,
 #endif
-- 
2.17.0
