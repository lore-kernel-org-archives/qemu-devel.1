Received: from eggs.gnu.org ([2001:4830:134:3::10]:41200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfG-0003sq-Dt
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfF-0004L7-El
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:10 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:46239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfF-0004Kv-9A
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:09 -0400
Received: by mail-pl0-x243.google.com with SMTP id 30-v6so10377639pld.13
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:49 -1000
Message-Id: <20180610030220.3777-78-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 077/108] linux-user: Split out getuid32,
 getxgid, getxuid, lchown32
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
 linux-user/syscall.c | 83 ++++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 33 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 76a66b56fe..17560ebd41 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8704,6 +8704,21 @@ IMPL(getuid)
 }
 #endif
 
+#ifdef TARGET_NR_getuid32
+IMPL(getuid32)
+{
+    return get_errno(getuid());
+}
+#endif
+
+#if defined(TARGET_NR_getxgid) && defined(TARGET_ALPHA)
+IMPL(getxgid)
+{
+    ((CPUAlphaState *)cpu_env)->ir[IR_A4] = getegid();
+    return get_errno(getgid());
+}
+#endif
+
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
 IMPL(getxpid)
 {
@@ -8712,6 +8727,14 @@ IMPL(getxpid)
 }
 #endif
 
+#if defined(TARGET_NR_getxuid) && defined(TARGET_ALPHA)
+IMPL(getxuid)
+{
+    ((CPUAlphaState *)cpu_env)->ir[IR_A4] = geteuid();
+    return get_errno(getuid());
+}
+#endif
+
 /* ??? Implement proper locking for ioctls.  */
 IMPL(ioctl)
 {
@@ -8904,6 +8927,21 @@ IMPL(lchown)
 }
 #endif
 
+#ifdef TARGET_NR_lchown32
+IMPL(lchown32)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(lchown(p, arg2, arg3));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_link
 IMPL(link)
 {
@@ -11614,39 +11652,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_lchown32
-    case TARGET_NR_lchown32:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(lchown(p, arg2, arg3));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-#ifdef TARGET_NR_getuid32
-    case TARGET_NR_getuid32:
-        return get_errno(getuid());
-#endif
-
-#if defined(TARGET_NR_getxuid) && defined(TARGET_ALPHA)
-   /* Alpha specific */
-    case TARGET_NR_getxuid:
-         {
-            uid_t euid;
-            euid=geteuid();
-            ((CPUAlphaState *)cpu_env)->ir[IR_A4]=euid;
-         }
-        return get_errno(getuid());
-#endif
-#if defined(TARGET_NR_getxgid) && defined(TARGET_ALPHA)
-   /* Alpha specific */
-    case TARGET_NR_getxgid:
-         {
-            uid_t egid;
-            egid=getegid();
-            ((CPUAlphaState *)cpu_env)->ir[IR_A4]=egid;
-         }
-        return get_errno(getgid());
-#endif
 #if defined(TARGET_NR_osf_getsysinfo) && defined(TARGET_ALPHA)
     /* Alpha specific */
     case TARGET_NR_osf_getsysinfo:
@@ -13213,8 +13218,17 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_getuid
         SYSCALL(getuid);
 #endif
+#ifdef TARGET_NR_getuid32
+        SYSCALL(getuid32);
+#endif
+#if defined(TARGET_NR_getxgid) && defined(TARGET_ALPHA)
+        SYSCALL(getxgid);
+#endif
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
         SYSCALL(getxpid);
+#endif
+#if defined(TARGET_NR_getxuid) && defined(TARGET_ALPHA)
+        SYSCALL(getxuid);
 #endif
         SYSCALL(ioctl);
 #ifdef TARGET_NR_ipc
@@ -13224,6 +13238,9 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_lchown
         SYSCALL(lchown);
 #endif
+#ifdef TARGET_NR_lchown32
+        SYSCALL(lchown32);
+#endif
 #ifdef TARGET_NR_link
         SYSCALL(link);
 #endif
-- 
2.17.1
