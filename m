Received: from eggs.gnu.org ([2001:4830:134:3::10]:41239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfM-0003zf-UR
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfL-0004Mg-R5
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:16 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:33746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfL-0004MN-Ir
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:15 -0400
Received: by mail-pl0-x242.google.com with SMTP id n10-v6so10391995plp.0
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:52 -1000
Message-Id: <20180610030220.3777-81-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 080/108] linux-user: Split out fchown32,
 getgroups32, setgroups32
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
 linux-user/syscall.c | 114 +++++++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 47 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c8bd13092e..031033c0ea 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8123,6 +8123,13 @@ IMPL(fchown)
     return get_errno(fchown(arg1, low2highuid(arg2), low2highgid(arg3)));
 }
 
+#ifdef TARGET_NR_fchown32
+IMPL(fchown32)
+{
+    return get_errno(fchown(arg1, arg2, arg3));
+}
+#endif
+
 IMPL(fchownat)
 {
     char *p = lock_user_string(arg2);
@@ -8543,6 +8550,33 @@ IMPL(getgroups)
     return ret;
 }
 
+#ifdef TARGET_NR_getgroups32
+IMPL(getgroups32)
+{
+    int gidsetsize = arg1;
+    gid_t *grouplist;
+    abi_long ret;
+
+    grouplist = alloca(gidsetsize * sizeof(gid_t));
+    ret = get_errno(getgroups(gidsetsize, grouplist));
+
+    if (!is_error(ret) && gidsetsize != 0) {
+        uint32_t *target_gl;
+        int i;
+
+        target_gl = lock_user(VERIFY_WRITE, arg2, gidsetsize * 4, 0);
+        if (!target_gl) {
+            return -TARGET_EFAULT;
+        }
+        for (i = 0; i < ret; i++) {
+            target_gl[i] = tswap32(grouplist[i]);
+        }
+        unlock_user(target_gl, arg2, gidsetsize * 4);
+    }
+    return ret;
+}
+#endif
+
 IMPL(getitimer)
 {
     struct itimerval value;
@@ -10783,6 +10817,30 @@ IMPL(setgroups)
     return get_errno(setgroups(gidsetsize, grouplist));
 }
 
+#ifdef TARGET_NR_setgroups32
+IMPL(setgroups32)
+{
+    int gidsetsize = arg1;
+    gid_t *grouplist = NULL;
+
+    if (gidsetsize) {
+        uint32_t *target_gl;
+        int i;
+
+        grouplist = alloca(gidsetsize * sizeof(gid_t));
+        target_gl = lock_user(VERIFY_READ, arg2, gidsetsize * 4, 1);
+        if (!target_gl) {
+            return -TARGET_EFAULT;
+        }
+        for (i = 0; i < gidsetsize; i++) {
+            grouplist[i] = tswap32(target_gl[i]);
+        }
+        unlock_user(target_gl, arg2, 0);
+    }
+    return get_errno(setgroups(gidsetsize, grouplist));
+}
+#endif
+
 IMPL(sethostname)
 {
     char *p = lock_user_string(arg1);
@@ -11840,53 +11898,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_getgroups32
-    case TARGET_NR_getgroups32:
-        {
-            int gidsetsize = arg1;
-            uint32_t *target_grouplist;
-            gid_t *grouplist;
-            int i;
-
-            grouplist = alloca(gidsetsize * sizeof(gid_t));
-            ret = get_errno(getgroups(gidsetsize, grouplist));
-            if (gidsetsize == 0)
-                return ret;
-            if (!is_error(ret)) {
-                target_grouplist = lock_user(VERIFY_WRITE, arg2, gidsetsize * 4, 0);
-                if (!target_grouplist) {
-                    return -TARGET_EFAULT;
-                }
-                for(i = 0;i < ret; i++)
-                    target_grouplist[i] = tswap32(grouplist[i]);
-                unlock_user(target_grouplist, arg2, gidsetsize * 4);
-            }
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_setgroups32
-    case TARGET_NR_setgroups32:
-        {
-            int gidsetsize = arg1;
-            uint32_t *target_grouplist;
-            gid_t *grouplist;
-            int i;
-
-            grouplist = alloca(gidsetsize * sizeof(gid_t));
-            target_grouplist = lock_user(VERIFY_READ, arg2, gidsetsize * 4, 1);
-            if (!target_grouplist) {
-                return -TARGET_EFAULT;
-            }
-            for(i = 0;i < gidsetsize; i++)
-                grouplist[i] = tswap32(target_grouplist[i]);
-            unlock_user(target_grouplist, arg2, 0);
-            return get_errno(setgroups(gidsetsize, grouplist));
-        }
-#endif
-#ifdef TARGET_NR_fchown32
-    case TARGET_NR_fchown32:
-        return get_errno(fchown(arg1, arg2, arg3));
-#endif
 #ifdef TARGET_NR_setresuid32
     case TARGET_NR_setresuid32:
         return get_errno(sys_setresuid(arg1, arg2, arg3));
@@ -13144,6 +13155,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(fchmod);
         SYSCALL(fchmodat);
         SYSCALL(fchown);
+#ifdef TARGET_NR_fchown32
+        SYSCALL(fchown32);
+#endif
         SYSCALL(fchownat);
 #ifdef TARGET_NR_fcntl
         SYSCALL(fcntl);
@@ -13199,6 +13213,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(getgid32);
 #endif
         SYSCALL(getgroups);
+#ifdef TARGET_NR_getgroups32
+        SYSCALL(getgroups32);
+#endif
         SYSCALL(getitimer);
 #ifdef TARGET_NR_getpeername
         SYSCALL(getpeername);
@@ -13463,6 +13480,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(setfsuid);
         SYSCALL(setgid);
         SYSCALL(setgroups);
+#ifdef TARGET_NR_setgroups32
+        SYSCALL(setgroups32);
+#endif
         SYSCALL(sethostname);
         SYSCALL(setitimer);
         SYSCALL(setpgid);
-- 
2.17.1
