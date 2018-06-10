Received: from eggs.gnu.org ([2001:4830:134:3::10]:41606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqg9-0004qP-HV
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqg8-0004u7-MF
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:06:05 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:45907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqg8-0004tK-Fy
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:06:04 -0400
Received: by mail-pl0-x241.google.com with SMTP id c23-v6so10385837plz.12
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:06:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:19 -1000
Message-Id: <20180610030220.3777-108-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 107/108] linux-user: Split out setns, unshare
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

All targets define both of these; remove the ifdefs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d15f994039..7a94a0b0e9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11820,6 +11820,13 @@ IMPL(setitimer)
     return ret;
 }
 
+#ifdef CONFIG_SETNS
+IMPL(setns)
+{
+    return get_errno(setns(arg1, arg2));
+}
+#endif
+
 IMPL(setpgid)
 {
     return get_errno(setpgid(arg1, arg2));
@@ -12984,6 +12991,13 @@ IMPL(unlinkat)
     return ret;
 }
 
+#ifdef CONFIG_SETNS
+IMPL(unshare)
+{
+    return get_errno(unshare(arg1));
+}
+#endif
+
 #ifdef TARGET_NR_utime
 IMPL(utime)
 {
@@ -13200,23 +13214,11 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
                             abi_long arg5, abi_long arg6, abi_long arg7,
                             abi_long arg8)
 {
-    CPUState *cpu __attribute__((unused)) = ENV_GET_CPU(cpu_env);
-    abi_long ret;
-
     switch(num) {
-#if defined(TARGET_NR_setns) && defined(CONFIG_SETNS)
-    case TARGET_NR_setns:
-        return get_errno(setns(arg1, arg2));
-#endif
-#if defined(TARGET_NR_unshare) && defined(CONFIG_SETNS)
-    case TARGET_NR_unshare:
-        return get_errno(unshare(arg1));
-#endif
     default:
         gemu_log("qemu: Unsupported syscall: %d\n", num);
         return -TARGET_ENOSYS;
     }
-    return ret;
 }
 
 /* The default action for a syscall not listed in syscall_table is to
@@ -13770,6 +13772,9 @@ static impl_fn *syscall_table(unsigned num)
 #endif
         SYSCALL(sethostname);
         SYSCALL(setitimer);
+#ifdef CONFIG_SETNS
+        SYSCALL(setns);
+#endif
         SYSCALL(setpgid);
         SYSCALL(setpriority);
         SYSCALL(setregid);
@@ -13916,6 +13921,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(unlink);
 #endif
         SYSCALL(unlinkat);
+#ifdef CONFIG_SETNS
+        SYSCALL(unshare);
+#endif
 #ifdef TARGET_NR_utime
         SYSCALL(utime);
 #endif
-- 
2.17.1
