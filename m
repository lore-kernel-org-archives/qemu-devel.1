Received: from eggs.gnu.org ([2001:4830:134:3::10]:41456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfr-0004Vf-F7
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfq-0004iR-Cy
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:47 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:45645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfq-0004i9-6A
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:46 -0400
Received: by mail-pf0-x243.google.com with SMTP id a22-v6so8480880pfo.12
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:09 -1000
Message-Id: <20180610030220.3777-98-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 097/108] linux-user: Split out eventfd,
 eventfd2
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

All targets define eventfd2; remove the ifdefs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 64 +++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8548f113d1..1158afde27 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7903,6 +7903,37 @@ IMPL(dup3)
     return ret;
 }
 
+#ifdef CONFIG_EVENTFD
+# ifdef TARGET_NR_eventfd
+IMPL(eventfd)
+{
+    abi_long ret = get_errno(eventfd(arg1, 0));
+    if (ret >= 0) {
+        fd_trans_register(ret, &target_eventfd_trans);
+    }
+    return ret;
+}
+# endif
+
+IMPL(eventfd2)
+{
+    int host_flags = arg2 & (~(TARGET_O_NONBLOCK | TARGET_O_CLOEXEC));
+    abi_long ret;
+
+    if (arg2 & TARGET_O_NONBLOCK) {
+        host_flags |= O_NONBLOCK;
+    }
+    if (arg2 & TARGET_O_CLOEXEC) {
+        host_flags |= O_CLOEXEC;
+    }
+    ret = get_errno(eventfd(arg1, host_flags));
+    if (ret >= 0) {
+        fd_trans_register(ret, &target_eventfd_trans);
+    }
+    return ret;
+}
+#endif /* CONFIG_EVENTFD */
+
 IMPL(execve)
 {
     abi_ulong *guest_ptrs;
@@ -12767,33 +12798,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     abi_long ret;
 
     switch(num) {
-#ifdef CONFIG_EVENTFD
-#if defined(TARGET_NR_eventfd)
-    case TARGET_NR_eventfd:
-        ret = get_errno(eventfd(arg1, 0));
-        if (ret >= 0) {
-            fd_trans_register(ret, &target_eventfd_trans);
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_eventfd2)
-    case TARGET_NR_eventfd2:
-    {
-        int host_flags = arg2 & (~(TARGET_O_NONBLOCK | TARGET_O_CLOEXEC));
-        if (arg2 & TARGET_O_NONBLOCK) {
-            host_flags |= O_NONBLOCK;
-        }
-        if (arg2 & TARGET_O_CLOEXEC) {
-            host_flags |= O_CLOEXEC;
-        }
-        ret = get_errno(eventfd(arg1, host_flags));
-        if (ret >= 0) {
-            fd_trans_register(ret, &target_eventfd_trans);
-        }
-        return ret;
-    }
-#endif
-#endif /* CONFIG_EVENTFD  */
 #if defined(CONFIG_FALLOCATE) && defined(TARGET_NR_fallocate)
     case TARGET_NR_fallocate:
 #if TARGET_ABI_BITS == 32
@@ -13314,6 +13318,12 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(dup2);
 #endif
         SYSCALL(dup3);
+#ifdef CONFIG_EVENTFD
+# ifdef TARGET_NR_eventfd
+        SYSCALL(eventfd);
+# endif
+        SYSCALL(eventfd2);
+#endif
         SYSCALL(execve);
         SYSCALL(exit);
 #ifdef __NR_exit_group
-- 
2.17.1
