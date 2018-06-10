Received: from eggs.gnu.org ([2001:4830:134:3::10]:41093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqf3-0003hf-Ey
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqf0-00048T-6v
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:57 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:34313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqf0-00047e-1k
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:54 -0400
Received: by mail-pg0-x22a.google.com with SMTP id q4-v6so7075239pgr.1
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:41 -1000
Message-Id: <20180610030220.3777-70-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 069/108] linux-user: Split out sendfile,
 sendfile64
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
 linux-user/syscall.c | 92 +++++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 44 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c906719152..39e416db0b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10284,6 +10284,48 @@ IMPL(send)
 }
 #endif
 
+#ifdef CONFIG_SENDFILE
+IMPL(sendfile)
+{
+    abi_long ret;
+    off_t off;
+
+    if (!arg3) {
+        return get_errno(sendfile(arg1, arg2, NULL, arg4));
+    }
+
+    if (get_user_sal(off, arg3)) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(sendfile(arg1, arg2, &off, arg4));
+    if (!is_error(ret) && arg3 && put_user_sal(off, arg3)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
+# ifdef TARGET_NR_sendfile64
+IMPL(sendfile64)
+{
+    abi_long ret;
+    off_t off;
+
+    if (!arg3) {
+        return get_errno(sendfile(arg1, arg2, NULL, arg4));
+    }
+
+    if (get_user_s64(off, arg3)) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(sendfile(arg1, arg2, &off, arg4));
+    if (!is_error(ret) && arg3 && put_user_s64(off, arg3)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+# endif
+#endif /* CONFIG_SENDFILE */
+
 #ifdef TARGET_NR_sendmsg
 IMPL(sendmsg)
 {
@@ -11265,50 +11307,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef CONFIG_SENDFILE
-    case TARGET_NR_sendfile:
-    {
-        off_t *offp = NULL;
-        off_t off;
-        if (arg3) {
-            ret = get_user_sal(off, arg3);
-            if (is_error(ret)) {
-                return ret;
-            }
-            offp = &off;
-        }
-        ret = get_errno(sendfile(arg1, arg2, offp, arg4));
-        if (!is_error(ret) && arg3) {
-            abi_long ret2 = put_user_sal(off, arg3);
-            if (is_error(ret2)) {
-                ret = ret2;
-            }
-        }
-        return ret;
-    }
-#ifdef TARGET_NR_sendfile64
-    case TARGET_NR_sendfile64:
-    {
-        off_t *offp = NULL;
-        off_t off;
-        if (arg3) {
-            ret = get_user_s64(off, arg3);
-            if (is_error(ret)) {
-                return ret;
-            }
-            offp = &off;
-        }
-        ret = get_errno(sendfile(arg1, arg2, offp, arg4));
-        if (!is_error(ret) && arg3) {
-            abi_long ret2 = put_user_s64(off, arg3);
-            if (is_error(ret2)) {
-                ret = ret2;
-            }
-        }
-        return ret;
-    }
-#endif
-#endif
 #ifdef TARGET_NR_vfork
     case TARGET_NR_vfork:
         return get_errno(do_fork(cpu_env,
@@ -13270,6 +13268,12 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_send
         SYSCALL(send);
 #endif
+#ifdef CONFIG_SENDFILE
+        SYSCALL(sendfile);
+# ifdef TARGET_NR_sendfile64
+        SYSCALL(sendfile64);
+# endif
+#endif
 #ifdef TARGET_NR_sendmmsg
         SYSCALL(sendmmsg);
 #endif
-- 
2.17.1
