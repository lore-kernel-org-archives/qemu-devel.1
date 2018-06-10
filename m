Received: from eggs.gnu.org ([2001:4830:134:3::10]:40283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdK-00023D-4f
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdJ-0003KL-46
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:10 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqdI-0003K5-Tz
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:09 -0400
Received: by mail-pg0-x243.google.com with SMTP id 15-v6so8138338pge.2
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:00:52 -1000
Message-Id: <20180610030220.3777-21-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 020/108] linux-user: Split out mount, umount
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
 linux-user/syscall.c | 118 ++++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 63 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3d3983a504..844e771488 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8158,6 +8158,42 @@ IMPL(mknodat)
     return ret;
 }
 
+IMPL(mount)
+{
+    char *p1 = NULL, *p2, *p3 = NULL;
+    abi_long ret = -TARGET_EFAULT;
+
+    if (arg1) {
+        p1 = lock_user_string(arg1);
+        if (!p1) {
+            return ret;
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
+    unlock_user(p3, arg3, 0);
+ exit3:
+    unlock_user(p2, arg2, 0);
+ exit2:
+    unlock_user(p1, arg1, 0);
+    return ret;
+}
+
 #ifdef CONFIG_OPEN_BY_HANDLE
 IMPL(name_to_handle_at)
 {
@@ -8315,6 +8351,21 @@ IMPL(time)
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
@@ -8416,69 +8467,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
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
@@ -12569,6 +12557,7 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(mknod);
 #endif
         SYSCALL(mknodat);
+        SYSCALL(mount);
 #ifdef CONFIG_OPEN_BY_HANDLE
         SYSCALL(name_to_handle_at);
 #endif
@@ -12583,6 +12572,9 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_time
         SYSCALL(time);
 #endif
+#ifdef TARGET_NR_umount
+        SYSCALL(umount);
+#endif
 #ifdef TARGET_NR_unlink
         SYSCALL(unlink);
 #endif
-- 
2.17.1
