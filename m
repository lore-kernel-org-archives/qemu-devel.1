Received: from eggs.gnu.org ([2001:4830:134:3::10]:40584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdx-0002bu-9H
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdw-0003ao-E9
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:49 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:38365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqdw-0003ac-8T
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:48 -0400
Received: by mail-pf0-x236.google.com with SMTP id b74-v6so8493620pfl.5
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:09 -1000
Message-Id: <20180610030220.3777-38-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 037/108] linux-user: Split out readlink,
 readlinkat
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

All targets define readlinkat; remove the ifdef.
Unify the two with do_readlinkat so that we do not
replicate the /proc/self/exe handling.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 96 ++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 53 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 39d8a70d7d..f1123479df 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8712,6 +8712,45 @@ IMPL(read)
     return ret;
 }
 
+static abi_long do_readlinkat(abi_long dirfd, abi_long target_path,
+                              abi_long target_buf, abi_long bufsize)
+{
+    char *host_path, *host_buf;
+    abi_long ret;
+
+    host_path = lock_user_string(target_path);
+    host_buf = lock_user(VERIFY_WRITE, target_buf, bufsize, 0);
+    if (!host_path || !host_buf) {
+        ret = -TARGET_EFAULT;
+    } else if (is_proc_myself(host_path, "exe")) {
+        char real[PATH_MAX], *temp;
+        temp = realpath(exec_path, real);
+        if (temp == NULL) {
+            ret = get_errno(-1);
+        } else {
+            ret = MIN(strlen(real), bufsize);
+            memcpy(host_buf, real, ret);
+        }
+    } else {
+        ret = get_errno(readlinkat(dirfd, path(host_path), host_buf, bufsize));
+    }
+    unlock_user(host_buf, target_buf, ret);
+    unlock_user(host_path, target_path, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_readlink
+IMPL(readlink)
+{
+    return do_readlinkat(AT_FDCWD, arg1, arg2, arg3);
+}
+#endif
+
+IMPL(readlinkat)
+{
+    return do_readlinkat(arg1, arg2, arg3, arg4);
+}
+
 #ifdef TARGET_NR_rename
 IMPL(rename)
 {
@@ -9591,59 +9630,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_readlink
-    case TARGET_NR_readlink:
-        {
-            void *p2;
-            p = lock_user_string(arg1);
-            p2 = lock_user(VERIFY_WRITE, arg2, arg3, 0);
-            if (!p || !p2) {
-                ret = -TARGET_EFAULT;
-            } else if (!arg3) {
-                /* Short circuit this for the magic exe check. */
-                ret = -TARGET_EINVAL;
-            } else if (is_proc_myself((const char *)p, "exe")) {
-                char real[PATH_MAX], *temp;
-                temp = realpath(exec_path, real);
-                /* Return value is # of bytes that we wrote to the buffer. */
-                if (temp == NULL) {
-                    ret = get_errno(-1);
-                } else {
-                    /* Don't worry about sign mismatch as earlier mapping
-                     * logic would have thrown a bad address error. */
-                    ret = MIN(strlen(real), arg3);
-                    /* We cannot NUL terminate the string. */
-                    memcpy(p2, real, ret);
-                }
-            } else {
-                ret = get_errno(readlink(path(p), p2, arg3));
-            }
-            unlock_user(p2, arg2, ret);
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_readlinkat)
-    case TARGET_NR_readlinkat:
-        {
-            void *p2;
-            p  = lock_user_string(arg2);
-            p2 = lock_user(VERIFY_WRITE, arg3, arg4, 0);
-            if (!p || !p2) {
-                ret = -TARGET_EFAULT;
-            } else if (is_proc_myself((const char *)p, "exe")) {
-                char real[PATH_MAX], *temp;
-                temp = realpath(exec_path, real);
-                ret = temp == NULL ? get_errno(-1) : strlen(real) ;
-                snprintf((char *)p2, arg4, "%s", real);
-            } else {
-                ret = get_errno(readlinkat(arg1, path(p), p2, arg4));
-            }
-            unlock_user(p2, arg3, ret);
-            unlock_user(p, arg2, 0);
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_swapon
     case TARGET_NR_swapon:
         if (!(p = lock_user_string(arg1)))
@@ -12783,6 +12769,10 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(pipe2);
         SYSCALL(pselect6);
         SYSCALL(read);
+#ifdef TARGET_NR_readlink
+        SYSCALL(readlink);
+#endif
+        SYSCALL(readlinkat);
 #ifdef TARGET_NR_rename
         SYSCALL(rename);
 #endif
-- 
2.17.1
