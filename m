Received: from eggs.gnu.org ([2001:4830:134:3::10]:40239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdB-0001v7-AI
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdA-0003HQ-Gv
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:01 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:43596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqdA-0003HB-Ax
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:00 -0400
Received: by mail-pl0-x241.google.com with SMTP id c41-v6so10384334plj.10
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:00:48 -1000
Message-Id: <20180610030220.3777-17-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 016/108] linux-user: Split out link, linkat
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

All targets define linkat; remove the ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 66 +++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a146b696fd..936c7a7484 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8052,6 +8052,36 @@ IMPL(fork)
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
+IMPL(linkat)
+{
+    char *p1 = lock_user_string(arg2);
+    char *p2 = lock_user_string(arg4);
+    abi_long ret = -TARGET_EFAULT;
+
+    if (p1 && p2) {
+        ret = get_errno(linkat(arg1, p1, arg3, p2, arg5));
+    }
+    unlock_user(p1, arg2, 0);
+    unlock_user(p2, arg4, 0);
+    return ret;
+}
+
 #ifdef CONFIG_OPEN_BY_HANDLE
 IMPL(name_to_handle_at)
 {
@@ -8270,38 +8300,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
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
-        {
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
@@ -12506,6 +12504,10 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_fork
         SYSCALL(fork);
 #endif
+#ifdef TARGET_NR_link
+        SYSCALL(link);
+#endif
+        SYSCALL(linkat);
 #ifdef CONFIG_OPEN_BY_HANDLE
         SYSCALL(name_to_handle_at);
 #endif
-- 
2.17.1
