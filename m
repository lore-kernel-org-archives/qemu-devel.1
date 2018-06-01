Received: from eggs.gnu.org ([2001:4830:134:3::10]:57395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWi-0005T3-OT
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWh-0000MY-NL
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:08 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:43953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWh-0000M0-ID
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:07 -0400
Received: by mail-pl0-x244.google.com with SMTP id c41-v6so14803393plj.10
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:26 -0700
Message-Id: <20180601073050.8054-10-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 09/33] linux-user: Set up infrastructure for
 table-izing syscalls
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
 linux-user/syscall.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e2e2d58e84..fc3dc3f40d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7962,21 +7962,34 @@ static int host_to_target_cpu_mask(const unsigned long *host_mask,
     return 0;
 }
 
+typedef abi_long impl_fn(void *cpu_env, unsigned num, abi_long arg1,
+                         abi_long arg2, abi_long arg3, abi_long arg4,
+                         abi_long arg5, abi_long arg6, abi_long arg7,
+                         abi_long arg8);
+
 static abi_long do_unimplemented(unsigned num)
 {
     gemu_log("qemu: Unsupported syscall: %u\n", num);
     return -TARGET_ENOSYS;
 }
 
+#define IMPL(NAME) \
+static abi_long impl_##NAME(void *cpu_env, unsigned num, abi_long arg1,   \
+                            abi_long arg2, abi_long arg3, abi_long arg4,  \
+                            abi_long arg5, abi_long arg6, abi_long arg7,  \
+                            abi_long arg8)
+
+IMPL(enosys)
+{
+    return do_unimplemented(num);
+}
+
 /* This is an internal helper for do_syscall so that it is easier
  * to have a single return point, so that actions, such as logging
  * of syscall results, can be performed.
  * All errnos that do_syscall() returns must be -TARGET_<errcode>.
  */
-static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
-                            abi_long arg2, abi_long arg3, abi_long arg4,
-                            abi_long arg5, abi_long arg6, abi_long arg7,
-                            abi_long arg8)
+IMPL(everything_else)
 {
     CPUState *cpu = ENV_GET_CPU(cpu_env);
     abi_long ret;
@@ -12880,6 +12893,10 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     return ret;
 }
 
+static impl_fn * const syscall_table[] = {
+    impl_everything_else,
+};
+
 abi_long do_syscall(void *cpu_env, unsigned num, abi_long arg1,
                     abi_long arg2, abi_long arg3, abi_long arg4,
                     abi_long arg5, abi_long arg6, abi_long arg7,
@@ -12908,14 +12925,23 @@ abi_long do_syscall(void *cpu_env, unsigned num, abi_long arg1,
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4,
                              arg5, arg6, arg7, arg8);
 
+    /* ??? After impl_everything_else is fully split, initialize with NULL.  */
+    impl_fn *fn = impl_everything_else;
+    if (num < ARRAY_SIZE(syscall_table)) {
+        fn = syscall_table[num];
+    }
+    if (fn == NULL) {
+        fn = impl_enosys;
+    }
+
     if (unlikely(do_strace)) {
         print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
-        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
-                          arg5, arg6, arg7, arg8);
+        ret = fn(cpu_env, num, arg1, arg2, arg3, arg4,
+                 arg5, arg6, arg7, arg8);
         print_syscall_ret(num, ret);
     } else {
-        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
-                          arg5, arg6, arg7, arg8);
+        ret = fn(cpu_env, num, arg1, arg2, arg3, arg4,
+                 arg5, arg6, arg7, arg8);
     }
 
 #ifdef DEBUG
-- 
2.17.0
