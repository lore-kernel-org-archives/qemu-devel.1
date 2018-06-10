Received: from eggs.gnu.org ([2001:4830:134:3::10]:40339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdR-00028L-T7
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdQ-0003N1-SK
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:17 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqdQ-0003Mc-M9
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:16 -0400
Received: by mail-pl0-x244.google.com with SMTP id g20-v6so10400192plq.1
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:00:55 -1000
Message-Id: <20180610030220.3777-24-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 023/108] linux-user: Split out rename,
 renameat, renameat2
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

All targets define renameat2; remove the ifdefs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 101 +++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 48 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6729a960ea..e0a5d86956 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -628,7 +628,6 @@ static int sys_utimensat(int dirfd, const char *pathname,
 #endif
 #endif /* TARGET_NR_utimensat */
 
-#ifdef TARGET_NR_renameat2
 #if defined(__NR_renameat2)
 #define __NR_sys_renameat2 __NR_renameat2
 _syscall5(int, sys_renameat2, int, oldfd, const char *, old, int, newfd,
@@ -644,7 +643,6 @@ static int sys_renameat2(int oldfd, const char *old,
     return -1;
 }
 #endif
-#endif /* TARGET_NR_renameat2 */
 
 #ifdef CONFIG_INOTIFY
 #include <sys/inotify.h>
@@ -8420,6 +8418,52 @@ IMPL(read)
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
+#ifdef TARGET_NR_renameat
+IMPL(renameat)
+{
+    char *p1 = lock_user_string(arg2);
+    char *p2 = lock_user_string(arg4);
+    abi_long ret = -TARGET_EFAULT;
+
+    if (p1 && p2) {
+        ret = get_errno(renameat(arg1, p1, arg3, p2));
+    }
+    unlock_user(p2, arg4, 0);
+    unlock_user(p1, arg2, 0);
+    return ret;
+}
+#endif
+
+IMPL(renameat2)
+{
+    char *p1 = lock_user_string(arg2);
+    char *p2 = lock_user_string(arg4);
+    abi_long ret = -TARGET_EFAULT;
+
+    if (p1 && p2) {
+        ret = get_errno(sys_renameat2(arg1, p1, arg3, p2, arg5));
+    }
+    unlock_user(p2, arg4, 0);
+    unlock_user(p1, arg2, 0);
+    return ret;
+}
+
 #ifdef TARGET_NR_stime
 IMPL(stime)
 {
@@ -8621,52 +8665,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
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
-        {
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
-        {
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
@@ -12626,6 +12624,13 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(pause);
 #endif
         SYSCALL(read);
+#ifdef TARGET_NR_rename
+        SYSCALL(rename);
+#endif
+#ifdef TARGET_NR_renameat
+        SYSCALL(renameat);
+#endif
+        SYSCALL(renameat2);
 #ifdef TARGET_NR_stime
         SYSCALL(stime);
 #endif
-- 
2.17.1
