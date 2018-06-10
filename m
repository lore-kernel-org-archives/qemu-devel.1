Received: from eggs.gnu.org ([2001:4830:134:3::10]:41539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfz-0004eh-RP
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfy-0004mh-Qr
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:55 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:41590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfy-0004ln-KX
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:54 -0400
Received: by mail-pl0-x242.google.com with SMTP id az12-v6so10381429plb.8
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:14 -1000
Message-Id: <20180610030220.3777-103-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 102/108] linux-user: Split out
 atomic_barrier, gethostname
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
 linux-user/syscall.c | 49 ++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 91d90c7417..f898e70e98 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7552,6 +7552,14 @@ IMPL(arch_prctl)
 }
 #endif
 
+#ifdef TARGET_NR_atomic_barrier
+IMPL(atomic_barrier)
+{
+    /* Like the kernel implementation and the qemu arm barrier, no-op this.  */
+    return 0;
+}
+#endif
+
 #ifdef TARGET_NR_bind
 IMPL(bind)
 {
@@ -8987,6 +8995,21 @@ IMPL(getgroups32)
 }
 #endif
 
+#ifdef TARGET_NR_gethostname
+IMPL(gethostname)
+{
+    char *name = lock_user(VERIFY_WRITE, arg1, arg2, 0);
+    abi_long ret;
+
+    if (!name) {
+        ret = -TARGET_EFAULT;
+    }
+    ret = get_errno(gethostname(name, arg2));
+    unlock_user(name, arg1, arg2);
+    return ret;
+}
+#endif
+
 IMPL(getitimer)
 {
     struct itimerval value;
@@ -13002,19 +13025,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     abi_long ret;
 
     switch(num) {
-#ifdef TARGET_NR_gethostname
-    case TARGET_NR_gethostname:
-    {
-        char *name = lock_user(VERIFY_WRITE, arg1, arg2, 0);
-        if (name) {
-            ret = get_errno(gethostname(name, arg2));
-            unlock_user(name, arg1, arg2);
-        } else {
-            ret = -TARGET_EFAULT;
-        }
-        return ret;
-    }
-#endif
 #ifdef TARGET_NR_atomic_cmpxchg_32
     case TARGET_NR_atomic_cmpxchg_32:
     {
@@ -13036,13 +13046,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
         return mem_value;
     }
 #endif
-#ifdef TARGET_NR_atomic_barrier
-    case TARGET_NR_atomic_barrier:
-        /* Like the kernel implementation and the
-           qemu arm barrier, no-op this? */
-        return 0;
-#endif
-
 #ifdef TARGET_NR_timer_create
     case TARGET_NR_timer_create:
     {
@@ -13293,6 +13296,9 @@ static impl_fn *syscall_table(unsigned num)
 #endif
 #ifdef TARGET_NR_bind
         SYSCALL(bind);
+#endif
+#ifdef TARGET_NR_atomic_barrier
+        SYSCALL(atomic_barrier);
 #endif
         SYSCALL(brk);
 #ifdef TARGET_NR_cacheflush
@@ -13448,6 +13454,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(getgroups);
 #ifdef TARGET_NR_getgroups32
         SYSCALL(getgroups32);
+#endif
+#ifdef TARGET_NR_gethostname
+        SYSCALL(gethostname);
 #endif
         SYSCALL(getitimer);
 #ifdef TARGET_NR_getpagesize
-- 
2.17.1
