Received: from eggs.gnu.org ([2001:4830:134:3::10]:40568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdv-0002bB-II
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdu-0003a2-Ke
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:47 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:38926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqdu-0003Zo-EP
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:46 -0400
Received: by mail-pg0-x242.google.com with SMTP id w12-v6so8138873pgc.6
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:08 -1000
Message-Id: <20180610030220.3777-37-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 036/108] linux-user: Split out symlink,
 symlinkat
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

All targets define symlinkat; remove the ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 64 +++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 326323e377..39d8a70d7d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9331,6 +9331,36 @@ IMPL(stime)
 }
 #endif
 
+#ifdef TARGET_NR_symlink
+IMPL(symlink)
+{
+    char *p1 = lock_user_string(arg1);
+    char *p2 = lock_user_string(arg2);
+    abi_long ret = -TARGET_EFAULT;
+
+    if (p1 && p2) {
+        ret = get_errno(symlink(p1, p2));
+    }
+    unlock_user(p2, arg2, 0);
+    unlock_user(p1, arg1, 0);
+    return ret;
+}
+#endif
+
+IMPL(symlinkat)
+{
+    char *p1 = lock_user_string(arg1);
+    char *p2 = lock_user_string(arg3);
+    abi_long ret = -TARGET_EFAULT;
+
+    if (p1 && p2) {
+        ret = get_errno(symlinkat(p1, arg2, p2));
+    }
+    unlock_user(p2, arg3, 0);
+    unlock_user(p1, arg1, 0);
+    return ret;
+}
+
 IMPL(sync)
 {
     sync();
@@ -9561,36 +9591,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_symlink
-    case TARGET_NR_symlink:
-        {
-            void *p2;
-            p = lock_user_string(arg1);
-            p2 = lock_user_string(arg2);
-            if (!p || !p2)
-                ret = -TARGET_EFAULT;
-            else
-                ret = get_errno(symlink(p, p2));
-            unlock_user(p2, arg2, 0);
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_symlinkat)
-    case TARGET_NR_symlinkat:
-        {
-            void *p2;
-            p  = lock_user_string(arg1);
-            p2 = lock_user_string(arg3);
-            if (!p || !p2)
-                ret = -TARGET_EFAULT;
-            else
-                ret = get_errno(symlinkat(p, arg2, p2));
-            unlock_user(p2, arg3, 0);
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_readlink
     case TARGET_NR_readlink:
         {
@@ -12837,6 +12837,10 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_stime
         SYSCALL(stime);
 #endif
+#ifdef TARGET_NR_symlink
+        SYSCALL(symlink);
+#endif
+        SYSCALL(symlinkat);
         SYSCALL(sync);
 #ifdef CONFIG_SYNCFS
         SYSCALL(syncfs);
-- 
2.17.1
