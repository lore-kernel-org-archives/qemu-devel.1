Received: from eggs.gnu.org ([2001:4830:134:3::10]:41164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfC-0003ov-Lh
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfB-0004Jp-IF
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:06 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:42385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfB-0004Jf-CC
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:05 -0400
Received: by mail-pf0-x241.google.com with SMTP id w7-v6so8479182pfn.9
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:47 -1000
Message-Id: <20180610030220.3777-76-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 075/108] linux-user: Split out chown,
 getresgid, getresuid
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
 linux-user/syscall.c | 94 +++++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 37 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 75b869fb33..c55c414239 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7787,6 +7787,21 @@ IMPL(chmod)
 }
 #endif
 
+#ifdef TARGET_NR_chown
+IMPL(chown)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(chown(p, low2highuid(arg2), low2highgid(arg3)));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
 IMPL(chroot)
 {
     char *p = lock_user_string(arg1);
@@ -8588,6 +8603,38 @@ IMPL(getrandom)
     return ret;
 }
 
+#ifdef TARGET_NR_getresgid
+IMPL(getresgid)
+{
+    gid_t rgid, egid, sgid;
+    abi_long ret = get_errno(getresgid(&rgid, &egid, &sgid));
+
+    if (!is_error(ret) &&
+        (put_user_id(high2lowgid(rgid), arg1) ||
+         put_user_id(high2lowgid(egid), arg2) ||
+         put_user_id(high2lowgid(sgid), arg3))) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
+
+#ifdef TARGET_NR_getresuid
+IMPL(getresuid)
+{
+    uid_t ruid, euid, suid;
+    abi_long ret = get_errno(getresuid(&ruid, &euid, &suid));
+
+    if (!is_error(ret) &&
+        (put_user_id(high2lowuid(ruid), arg1) ||
+         put_user_id(high2lowuid(euid), arg2) ||
+         put_user_id(high2lowuid(suid), arg3))) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
+
 IMPL(getrlimit)
 {
     int resource = target_to_host_resource(arg1);
@@ -11547,42 +11594,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_getresuid
-    case TARGET_NR_getresuid:
-        {
-            uid_t ruid, euid, suid;
-            ret = get_errno(getresuid(&ruid, &euid, &suid));
-            if (!is_error(ret)) {
-                if (put_user_id(high2lowuid(ruid), arg1)
-                    || put_user_id(high2lowuid(euid), arg2)
-                    || put_user_id(high2lowuid(suid), arg3))
-                    return -TARGET_EFAULT;
-            }
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_getresgid
-    case TARGET_NR_getresgid:
-        {
-            gid_t rgid, egid, sgid;
-            ret = get_errno(getresgid(&rgid, &egid, &sgid));
-            if (!is_error(ret)) {
-                if (put_user_id(high2lowgid(rgid), arg1)
-                    || put_user_id(high2lowgid(egid), arg2)
-                    || put_user_id(high2lowgid(sgid), arg3))
-                    return -TARGET_EFAULT;
-            }
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_chown
-    case TARGET_NR_chown:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(chown(p, low2highuid(arg2), low2highgid(arg3)));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
     case TARGET_NR_setuid:
         return get_errno(sys_setuid(low2highuid(arg1)));
     case TARGET_NR_setgid:
@@ -13080,10 +13091,13 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(clone);
         SYSCALL(close);
         SYSCALL(chdir);
-        SYSCALL(chroot);
 #ifdef TARGET_NR_chmod
         SYSCALL(chmod);
 #endif
+#ifdef TARGET_NR_chown
+        SYSCALL(chown);
+#endif
+        SYSCALL(chroot);
 #ifdef TARGET_NR_connect
         SYSCALL(connect);
 #endif
@@ -13169,6 +13183,12 @@ static impl_fn *syscall_table(unsigned num)
 #endif
         SYSCALL(getpriority);
         SYSCALL(getrandom);
+#ifdef TARGET_NR_getresgid
+        SYSCALL(getresgid);
+#endif
+#ifdef TARGET_NR_getresuid
+        SYSCALL(getresuid);
+#endif
         SYSCALL(getrlimit);
         SYSCALL(getrusage);
         SYSCALL(getsid);
-- 
2.17.1
