Received: from eggs.gnu.org ([2001:4830:134:3::10]:57601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeX2-0005mO-He
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWy-0000dX-UD
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:28 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:36010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWy-0000cy-Nn
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:24 -0400
Received: by mail-pl0-x244.google.com with SMTP id v24-v6so14818455plo.3
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:38 -0700
Message-Id: <20180601073050.8054-22-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 21/33] linux-user: Split out mount, umount
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
 linux-user/syscall.c | 123 +++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 63 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b568144369..53eac58ec0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8200,6 +8200,47 @@ IMPL(mknodat)
 }
 #endif
 
+IMPL(mount)
+{
+    char *p1 = NULL, *p2, *p3 = NULL;
+    abi_long ret = -TARGET_EFAULT;
+
+    if (arg1) {
+        p1 = lock_user_string(arg1);
+        if (!p1) {
+            goto exit1;
+        }
+    }
+    p2 = lock_user_string(arg2);
+    if (!p2) {
+        goto exit2;
+    }
+    if (arg3) {
+        p3 = lock_user_string(arg3);
+        if (!p3) {
+            goto exit3;
+        }
+    }
+
+    /* FIXME - arg5 should be locked, but it isn't clear how to do that
+     * since it's not guaranteed to be a NULL-terminated string.
+     */
+    ret = mount(p1, p2, p3, (unsigned long)arg4, arg5 ? g2h(arg5) : NULL);
+    ret = get_errno(ret);
+
+    if (arg3) {
+        unlock_user(p3, arg3, 0);
+    }
+ exit3:
+    unlock_user(p2, arg2, 0);
+ exit2:
+    if (arg1) {
+        unlock_user(p1, arg1, 0);
+    }
+ exit1:
+    return ret;
+}
+
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
 IMPL(name_to_handle_at)
 {
@@ -8373,6 +8414,21 @@ IMPL(time)
 }
 #endif
 
+#ifdef TARGET_NR_umount
+IMPL(umount)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(umount(p));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_unlink
 IMPL(unlink)
 {
@@ -8483,69 +8539,6 @@ IMPL(everything_else)
     char *fn;
 
     switch(num) {
-    case TARGET_NR_mount:
-        {
-            /* need to look at the data field */
-            void *p2, *p3;
-
-            if (arg1) {
-                p = lock_user_string(arg1);
-                if (!p) {
-                    return -TARGET_EFAULT;
-                }
-            } else {
-                p = NULL;
-            }
-
-            p2 = lock_user_string(arg2);
-            if (!p2) {
-                if (arg1) {
-                    unlock_user(p, arg1, 0);
-                }
-                return -TARGET_EFAULT;
-            }
-
-            if (arg3) {
-                p3 = lock_user_string(arg3);
-                if (!p3) {
-                    if (arg1) {
-                        unlock_user(p, arg1, 0);
-                    }
-                    unlock_user(p2, arg2, 0);
-                    return -TARGET_EFAULT;
-                }
-            } else {
-                p3 = NULL;
-            }
-
-            /* FIXME - arg5 should be locked, but it isn't clear how to
-             * do that since it's not guaranteed to be a NULL-terminated
-             * string.
-             */
-            if (!arg5) {
-                ret = mount(p, p2, p3, (unsigned long)arg4, NULL);
-            } else {
-                ret = mount(p, p2, p3, (unsigned long)arg4, g2h(arg5));
-            }
-            ret = get_errno(ret);
-
-            if (arg1) {
-                unlock_user(p, arg1, 0);
-            }
-            unlock_user(p2, arg2, 0);
-            if (arg3) {
-                unlock_user(p3, arg3, 0);
-            }
-        }
-        return ret;
-#ifdef TARGET_NR_umount
-    case TARGET_NR_umount:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(umount(p));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
 #ifdef TARGET_NR_stime /* not on alpha */
     case TARGET_NR_stime:
         {
@@ -12896,6 +12889,7 @@ static impl_fn * const syscall_table[] = {
 #ifdef TARGET_NR_mknodat
     [TARGET_NR_mknodat] = impl_mknodat,
 #endif
+    [TARGET_NR_mount] = impl_mount,
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     [TARGET_NR_name_to_handle_at] = impl_name_to_handle_at,
 #endif
@@ -12910,6 +12904,9 @@ static impl_fn * const syscall_table[] = {
 #ifdef TARGET_NR_time
     [TARGET_NR_time] = impl_time,
 #endif
+#ifdef TARGET_NR_umount
+    [TARGET_NR_umount] = impl_umount,
+#endif
 #ifdef TARGET_NR_unlink
     [TARGET_NR_unlink] = impl_unlink,
 #endif
-- 
2.17.0
