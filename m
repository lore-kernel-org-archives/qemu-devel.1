Received: from eggs.gnu.org ([2001:4830:134:3::10]:57634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeX4-0005nz-3A
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeX3-0000iZ-1j
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:30 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:43953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeX2-0000hw-Sg
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:29 -0400
Received: by mail-pl0-x241.google.com with SMTP id c41-v6so14803978plj.10
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:41 -0700
Message-Id: <20180601073050.8054-25-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 24/33] linux-user: Split out rename, renameat,
 renameat2
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
 linux-user/syscall.c | 113 ++++++++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 50 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2a172e24eb..24514329b0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8504,6 +8504,60 @@ IMPL(read)
     return ret;
 }
 
+#ifdef TARGET_NR_rename
+IMPL(rename)
+{
+    char *p1 = lock_user_string(arg1);
+    char *p2 = lock_user_string(arg2);
+    abi_long ret = -TARGET_EFAULT;
+
+    if (p1 && p2) {
+        ret = get_errno(rename(p1, p2));
+    }
+    unlock_user(p2, arg2, 0);
+    unlock_user(p1, arg1, 0);
+    return ret;
+}
+#endif
+
+#if defined(TARGET_NR_renameat)
+IMPL(renameat)
+{
+    if (is_hostfd(arg1)) {
+        return -TARGET_EBADF;
+    }
+
+    char *p1 = lock_user_string(arg2);
+    char *p2 = lock_user_string(arg4);
+    abi_long ret = -TARGET_EFAULT;
+    if (p1 && p2) {
+        ret = get_errno(renameat(arg1, p1, arg3, p2));
+    }
+    unlock_user(p2, arg4, 0);
+    unlock_user(p1, arg2, 0);
+    return ret;
+}
+#endif
+
+#ifdef TARGET_NR_renameat2
+IMPL(renameat2)
+{
+    if (is_hostfd(arg1)) {
+        return -TARGET_EBADF;
+    }
+
+    char *p1 = lock_user_string(arg2);
+    char *p2 = lock_user_string(arg4);
+    abi_long ret = -TARGET_EFAULT;
+    if (p1 && p2) {
+        ret = get_errno(sys_renameat2(arg1, p1, arg3, p2, arg5));
+    }
+    unlock_user(p2, arg4, 0);
+    unlock_user(p1, arg2, 0);
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_stime
 IMPL(stime)
 {
@@ -8714,56 +8768,6 @@ IMPL(everything_else)
     char *fn;
 
     switch(num) {
-#ifdef TARGET_NR_rename
-    case TARGET_NR_rename:
-        {
-            void *p2;
-            p = lock_user_string(arg1);
-            p2 = lock_user_string(arg2);
-            if (!p || !p2)
-                ret = -TARGET_EFAULT;
-            else
-                ret = get_errno(rename(p, p2));
-            unlock_user(p2, arg2, 0);
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_renameat)
-    case TARGET_NR_renameat:
-        if (is_hostfd(arg1)) {
-            return -TARGET_EBADF;
-        } else {
-            void *p2;
-            p  = lock_user_string(arg2);
-            p2 = lock_user_string(arg4);
-            if (!p || !p2)
-                ret = -TARGET_EFAULT;
-            else
-                ret = get_errno(renameat(arg1, p, arg3, p2));
-            unlock_user(p2, arg4, 0);
-            unlock_user(p, arg2, 0);
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_renameat2)
-    case TARGET_NR_renameat2:
-        if (is_hostfd(arg1)) {
-            return -TARGET_EBADF;
-        } else {
-            void *p2;
-            p  = lock_user_string(arg2);
-            p2 = lock_user_string(arg4);
-            if (!p || !p2) {
-                ret = -TARGET_EFAULT;
-            } else {
-                ret = get_errno(sys_renameat2(arg1, p, arg3, p2, arg5));
-            }
-            unlock_user(p2, arg4, 0);
-            unlock_user(p, arg2, 0);
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_mkdir
     case TARGET_NR_mkdir:
         if (!(p = lock_user_string(arg1)))
@@ -12967,6 +12971,15 @@ static impl_fn * const syscall_table[] = {
     [TARGET_NR_pause] = impl_pause,
 #endif
     [TARGET_NR_read] = impl_read,
+#ifdef TARGET_NR_rename
+    [TARGET_NR_rename] = impl_rename,
+#endif
+#ifdef TARGET_NR_renameat
+    [TARGET_NR_renameat] = impl_renameat,
+#endif
+#ifdef TARGET_NR_renameat2
+    [TARGET_NR_renameat2] = impl_renameat2,
+#endif
 #ifdef TARGET_NR_stime
     [TARGET_NR_stime] = impl_stime,
 #endif
-- 
2.17.0
