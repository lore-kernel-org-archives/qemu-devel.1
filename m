Received: from eggs.gnu.org ([2001:4830:134:3::10]:40250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdD-0001zS-Hw
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdC-0003IF-Pc
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:03 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:32936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqdC-0003Hy-KA
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:02 -0400
Received: by mail-pf0-x244.google.com with SMTP id b17-v6so8494408pfi.0
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:00:49 -1000
Message-Id: <20180610030220.3777-18-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 017/108] linux-user: Split out unlink,
 unlinkat
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

All targets define unlinkat; remove the ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 48 +++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 936c7a7484..e1b3c7e827 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8227,6 +8227,34 @@ IMPL(read)
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
+IMPL(unlinkat)
+{
+    char *p = lock_user_string(arg2);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(unlinkat(arg1, p, arg3));
+    unlock_user(p, arg2, 0);
+    return ret;
+}
+
 IMPL(waitid)
 {
     siginfo_t info;
@@ -8300,22 +8328,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
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
-        if (!(p = lock_user_string(arg2)))
-            return -TARGET_EFAULT;
-        ret = get_errno(unlinkat(arg1, p, arg3));
-        unlock_user(p, arg2, 0);
-        return ret;
-#endif
     case TARGET_NR_chdir:
         if (!(p = lock_user_string(arg1)))
             return -TARGET_EFAULT;
@@ -12519,6 +12531,10 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(open_by_handle_at);
 #endif
         SYSCALL(read);
+#ifdef TARGET_NR_unlink
+        SYSCALL(unlink);
+#endif
+        SYSCALL(unlinkat);
         SYSCALL(waitid);
 #ifdef TARGET_NR_waitpid
         SYSCALL(waitpid);
-- 
2.17.1
