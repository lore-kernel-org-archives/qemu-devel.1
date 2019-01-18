Received: from eggs.gnu.org ([209.51.188.92]:56049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbke-0005MB-IG
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkd-0004t6-MG
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:32 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbkd-0004r5-AK
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:31 -0500
Received: by mail-pg1-x543.google.com with SMTP id n2so6650154pgm.3
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:59 +1100
Message-Id: <20190118213122.22865-26-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 26/49] linux-user: Split out chdir
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

Note that chdir is universally provided.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  1 +
 linux-user/strace.c           | 12 ------------
 linux-user/syscall-file.inc.c | 14 ++++++++++++++
 linux-user/syscall.c          |  6 ------
 linux-user/strace.list        |  3 ---
 5 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 392bd1579c..3fad9d51f0 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -19,6 +19,7 @@
 SYSCALL_DEF_FULL(brk, .impl = impl_brk,
                  .print_ret = print_syscall_ptr_ret,
                  .arg_type = { ARG_PTR });
+SYSCALL_DEF(chdir, ARG_STR);
 SYSCALL_DEF_ARGS(clone, ARG_CLONEFLAG, ARG_PTR, ARG_PTR, ARG_PTR, ARG_PTR);
 SYSCALL_DEF(close, ARG_DEC);
 #ifdef TARGET_NR_creat
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 43865e9df9..5133998c4f 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1113,18 +1113,6 @@ print_access(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_chdir
-static void
-print_chdir(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_chmod
 static void
 print_chmod(const struct syscallname *name,
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 2dd57176b3..7a4751d460 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -16,6 +16,20 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+SYSCALL_IMPL(chdir)
+{
+    abi_ulong target_path = arg1;
+    char *p = lock_user_string(target_path);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(chdir(p));
+    unlock_user(p, target_path, 0);
+    return ret;
+}
+
 SYSCALL_IMPL(close)
 {
     int fd = arg1;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3a027651e3..1cdc9727a9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5331,12 +5331,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_chdir:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(chdir(p));
-        unlock_user(p, arg1, 0);
-        return ret;
 #ifdef TARGET_NR_time
     case TARGET_NR_time:
         {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 202bfa8f9e..357984dd6f 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -61,9 +61,6 @@
 #ifdef TARGET_NR_capset
 { TARGET_NR_capset, "capset" , "%s(%p,%p)", NULL, NULL },
 #endif
-#ifdef TARGET_NR_chdir
-{ TARGET_NR_chdir, "chdir" , NULL, print_chdir, NULL },
-#endif
 #ifdef TARGET_NR_chmod
 { TARGET_NR_chmod, "chmod" , NULL, print_chmod, NULL },
 #endif
-- 
2.17.2
