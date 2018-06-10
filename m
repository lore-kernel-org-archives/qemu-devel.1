Received: from eggs.gnu.org ([2001:4830:134:3::10]:41250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfO-00041E-Fx
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfN-0004N7-Ej
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:18 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:35912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfN-0004Ms-8V
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:17 -0400
Received: by mail-pl0-x244.google.com with SMTP id a7-v6so7900314plp.3
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:53 -1000
Message-Id: <20180610030220.3777-82-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 081/108] linux-user: Split out getresgid32,
 getresuid32, setresgid32, setresuid32
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
 linux-user/syscall.c | 93 +++++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 36 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 031033c0ea..af96cc95d3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8674,6 +8674,22 @@ IMPL(getresgid)
 }
 #endif
 
+#ifdef TARGET_NR_getresgid32
+IMPL(getresgid32)
+{
+    gid_t rgid, egid, sgid;
+    abi_long ret = get_errno(getresgid(&rgid, &egid, &sgid));
+
+    if (!is_error(ret) &&
+        (put_user_u32(rgid, arg1) ||
+         put_user_u32(egid, arg2) ||
+         put_user_u32(sgid, arg3))) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_getresuid
 IMPL(getresuid)
 {
@@ -8690,6 +8706,21 @@ IMPL(getresuid)
 }
 #endif
 
+#ifdef TARGET_NR_getresuid32
+IMPL(getresuid32)
+{
+    uid_t ruid, euid, suid;
+    abi_long ret = get_errno(getresuid(&ruid, &euid, &suid));
+
+    if (!is_error(ret) &&
+        (put_user_u32(ruid, arg1) ||
+         put_user_u32(euid, arg2) ||
+         put_user_u32(suid, arg3))) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
 IMPL(getrlimit)
 {
     int resource = target_to_host_resource(arg1);
@@ -10906,6 +10937,13 @@ IMPL(setresgid)
 }
 #endif
 
+#ifdef TARGET_NR_setresgid32
+IMPL(setresgid32)
+{
+    return get_errno(sys_setresgid(arg1, arg2, arg3));
+}
+#endif
+
 #ifdef TARGET_NR_setresuid
 IMPL(setresuid)
 {
@@ -10914,6 +10952,13 @@ IMPL(setresuid)
 }
 #endif
 
+#ifdef TARGET_NR_setresuid32
+IMPL(setresuid32)
+{
+    return get_errno(sys_setresuid(arg1, arg2, arg3));
+}
+#endif
+
 IMPL(setreuid)
 {
     return get_errno(setreuid(low2highuid(arg1), low2highuid(arg2)));
@@ -11898,42 +11943,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_setresuid32
-    case TARGET_NR_setresuid32:
-        return get_errno(sys_setresuid(arg1, arg2, arg3));
-#endif
-#ifdef TARGET_NR_getresuid32
-    case TARGET_NR_getresuid32:
-        {
-            uid_t ruid, euid, suid;
-            ret = get_errno(getresuid(&ruid, &euid, &suid));
-            if (!is_error(ret)) {
-                if (put_user_u32(ruid, arg1)
-                    || put_user_u32(euid, arg2)
-                    || put_user_u32(suid, arg3))
-                    return -TARGET_EFAULT;
-            }
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_setresgid32
-    case TARGET_NR_setresgid32:
-        return get_errno(sys_setresgid(arg1, arg2, arg3));
-#endif
-#ifdef TARGET_NR_getresgid32
-    case TARGET_NR_getresgid32:
-        {
-            gid_t rgid, egid, sgid;
-            ret = get_errno(getresgid(&rgid, &egid, &sgid));
-            if (!is_error(ret)) {
-                if (put_user_u32(rgid, arg1)
-                    || put_user_u32(egid, arg2)
-                    || put_user_u32(sgid, arg3))
-                    return -TARGET_EFAULT;
-            }
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_chown32
     case TARGET_NR_chown32:
         if (!(p = lock_user_string(arg1)))
@@ -13235,8 +13244,14 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_getresgid
         SYSCALL(getresgid);
 #endif
+#ifdef TARGET_NR_getresgid32
+        SYSCALL(getresgid32);
+#endif
 #ifdef TARGET_NR_getresuid
         SYSCALL(getresuid);
+#endif
+#ifdef TARGET_NR_getresuid32
+        SYSCALL(getresuid32);
 #endif
         SYSCALL(getrlimit);
         SYSCALL(getrusage);
@@ -13491,11 +13506,17 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_setresgid
         SYSCALL(setresgid);
 #endif
+#ifdef TARGET_NR_setresgid32
+        SYSCALL(setresgid32);
+#endif
 #ifdef TARGET_NR_setregid32
         SYSCALL(setregid32);
 #endif
 #ifdef TARGET_NR_setresuid
         SYSCALL(setresuid);
+#endif
+#ifdef TARGET_NR_setresuid32
+        SYSCALL(setresuid32);
 #endif
         SYSCALL(setreuid);
 #ifdef TARGET_NR_setreuid32
-- 
2.17.1
