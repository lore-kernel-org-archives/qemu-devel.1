Received: from eggs.gnu.org ([209.51.188.92]:56573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbln-0006CE-ON
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbll-0006KO-PM
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:43 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkblj-0005mP-Nx
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:39 -0500
Received: by mail-pg1-x544.google.com with SMTP id z11so6661606pgu.0
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:33:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:19 +1100
Message-Id: <20190118213122.22865-46-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 46/49] linux-user: Split out acct
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
 linux-user/syscall-defs.h     |  1 +
 linux-user/syscall-file.inc.c | 18 ++++++++++++++++++
 linux-user/syscall.c          | 11 -----------
 linux-user/strace.list        |  3 ---
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 25d5aaccd1..f8f280f376 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -19,6 +19,7 @@
 #ifdef TARGET_NR_access
 SYSCALL_DEF(access, ARG_STR, ARG_ACCESSFLAG);
 #endif
+SYSCALL_DEF(acct, ARG_STR);
 #ifdef TARGET_NR_alarm
 SYSCALL_DEF(alarm, ARG_DEC);
 #endif
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 90aacfacaf..dd0bf877d5 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -36,6 +36,24 @@ SYSCALL_IMPL(access)
 }
 #endif
 
+SYSCALL_IMPL(acct)
+{
+    abi_ulong target_path = arg1;
+    abi_long ret;
+
+    if (target_path == 0) {
+        ret = get_errno(acct(NULL));
+    } else {
+        char *p = lock_user_string(target_path);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(acct(path(p)));
+        unlock_user(p, target_path, 0);
+    }
+    return ret;
+}
+
 SYSCALL_IMPL(chdir)
 {
     abi_ulong target_path = arg1;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d0bf339281..33d536262f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5293,17 +5293,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_acct:
-        if (arg1 == 0) {
-            ret = get_errno(acct(NULL));
-        } else {
-            if (!(p = lock_user_string(arg1))) {
-                return -TARGET_EFAULT;
-            }
-            ret = get_errno(acct(path(p)));
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
     case TARGET_NR_ioctl:
         return do_ioctl(arg1, arg2, arg3);
 #ifdef TARGET_NR_fcntl
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 4ea11f162e..9f2f8977b4 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -9,9 +9,6 @@
 #ifdef TARGET_NR_accept4
 { TARGET_NR_accept4, "accept4" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_acct
-{ TARGET_NR_acct, "acct" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_add_key
 { TARGET_NR_add_key, "add_key" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
