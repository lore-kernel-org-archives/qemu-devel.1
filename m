Received: from eggs.gnu.org ([2001:4830:134:3::10]:41139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqf8-0003nU-S8
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqf7-0004H0-Jv
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:02 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:41587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqf7-0004FX-CC
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:01 -0400
Received: by mail-pl0-x241.google.com with SMTP id az12-v6so10380824plb.8
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:45 -1000
Message-Id: <20180610030220.3777-74-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 073/108] linux-user: Split out getgroups,
 setgroups, setregid, setreuid
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
 linux-user/syscall.c | 107 +++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 44 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f8e34d28b1..915e1f1a91 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8462,6 +8462,32 @@ IMPL(getgid)
 }
 #endif
 
+IMPL(getgroups)
+{
+    int gidsetsize = arg1;
+    gid_t *grouplist;
+    abi_long ret;
+
+    grouplist = alloca(gidsetsize * sizeof(gid_t));
+    ret = get_errno(getgroups(gidsetsize, grouplist));
+
+    if (!is_error(ret) && gidsetsize != 0) {
+        target_id *target_gl;
+        int i;
+
+        target_gl = lock_user(VERIFY_WRITE, arg2,
+                              gidsetsize * sizeof(target_id), 0);
+        if (!target_gl) {
+            return -TARGET_EFAULT;
+        }
+        for (i = 0; i < ret; i++) {
+            target_gl[i] = tswapid(high2lowgid(grouplist[i]));
+        }
+        unlock_user(target_gl, arg2, gidsetsize * sizeof(target_id));
+    }
+    return ret;
+}
+
 IMPL(getitimer)
 {
     struct itimerval value;
@@ -10441,6 +10467,29 @@ IMPL(setdomainname)
     return ret;
 }
 
+IMPL(setgroups)
+{
+    int gidsetsize = arg1;
+    gid_t *grouplist = NULL;
+
+    if (gidsetsize) {
+        target_id *target_gl;
+        int i;
+
+        grouplist = alloca(gidsetsize * sizeof(gid_t));
+        target_gl = lock_user(VERIFY_READ, arg2,
+                              gidsetsize * sizeof(target_id), 1);
+        if (!target_gl) {
+            return -TARGET_EFAULT;
+        }
+        for (i = 0; i < gidsetsize; i++) {
+            grouplist[i] = low2highgid(tswapid(target_gl[i]));
+        }
+        unlock_user(target_gl, arg2, 0);
+    }
+    return get_errno(setgroups(gidsetsize, grouplist));
+}
+
 IMPL(sethostname)
 {
     char *p = lock_user_string(arg1);
@@ -10486,6 +10535,16 @@ IMPL(setpriority)
     return get_errno(setpriority(arg1, arg2, arg3));
 }
 
+IMPL(setregid)
+{
+    return get_errno(setregid(low2highgid(arg1), low2highgid(arg2)));
+}
+
+IMPL(setreuid)
+{
+    return get_errno(setreuid(low2highuid(arg1), low2highuid(arg2)));
+}
+
 IMPL(setrlimit)
 {
     int resource = target_to_host_resource(arg1);
@@ -11453,50 +11512,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_setreuid:
-        return get_errno(setreuid(low2highuid(arg1), low2highuid(arg2)));
-    case TARGET_NR_setregid:
-        return get_errno(setregid(low2highgid(arg1), low2highgid(arg2)));
-    case TARGET_NR_getgroups:
-        {
-            int gidsetsize = arg1;
-            target_id *target_grouplist;
-            gid_t *grouplist;
-            int i;
-
-            grouplist = alloca(gidsetsize * sizeof(gid_t));
-            ret = get_errno(getgroups(gidsetsize, grouplist));
-            if (gidsetsize == 0)
-                return ret;
-            if (!is_error(ret)) {
-                target_grouplist = lock_user(VERIFY_WRITE, arg2, gidsetsize * sizeof(target_id), 0);
-                if (!target_grouplist)
-                    return -TARGET_EFAULT;
-                for(i = 0;i < ret; i++)
-                    target_grouplist[i] = tswapid(high2lowgid(grouplist[i]));
-                unlock_user(target_grouplist, arg2, gidsetsize * sizeof(target_id));
-            }
-        }
-        return ret;
-    case TARGET_NR_setgroups:
-        {
-            int gidsetsize = arg1;
-            target_id *target_grouplist;
-            gid_t *grouplist = NULL;
-            int i;
-            if (gidsetsize) {
-                grouplist = alloca(gidsetsize * sizeof(gid_t));
-                target_grouplist = lock_user(VERIFY_READ, arg2, gidsetsize * sizeof(target_id), 1);
-                if (!target_grouplist) {
-                    return -TARGET_EFAULT;
-                }
-                for (i = 0; i < gidsetsize; i++) {
-                    grouplist[i] = low2highgid(tswapid(target_grouplist[i]));
-                }
-                unlock_user(target_grouplist, arg2, 0);
-            }
-            return get_errno(setgroups(gidsetsize, grouplist));
-        }
     case TARGET_NR_fchown:
         return get_errno(fchown(arg1, low2highuid(arg2), low2highgid(arg3)));
 #if defined(TARGET_NR_fchownat)
@@ -13123,6 +13138,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_getgid
         SYSCALL(getgid);
 #endif
+        SYSCALL(getgroups);
         SYSCALL(getitimer);
 #ifdef TARGET_NR_getpeername
         SYSCALL(getpeername);
@@ -13356,10 +13372,13 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(sendto);
 #endif
         SYSCALL(setdomainname);
+        SYSCALL(setgroups);
         SYSCALL(sethostname);
         SYSCALL(setitimer);
         SYSCALL(setpgid);
         SYSCALL(setpriority);
+        SYSCALL(setregid);
+        SYSCALL(setreuid);
         SYSCALL(setrlimit);
 #ifdef TARGET_NR_setsockopt
         SYSCALL(setsockopt);
-- 
2.17.1
