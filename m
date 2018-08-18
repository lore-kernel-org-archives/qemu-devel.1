Received: from eggs.gnu.org ([2001:4830:134:3::10]:55166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6TY-0005Eo-FU
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6TV-00076A-OZ
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:28 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fr6TV-00075c-JQ
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:25 -0400
Received: by mail-pf1-x444.google.com with SMTP id j8-v6so4888867pff.6
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 12:01:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 18 Aug 2018 12:01:04 -0700
Message-Id: <20180818190118.12911-3-richard.henderson@linaro.org>
In-Reply-To: <20180818190118.12911-1-richard.henderson@linaro.org>
References: <20180818190118.12911-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 02/16] linux-user: Split out do_syscall1
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

There was supposed to be a single point of return for do_syscall
so that tracing works properly.  However, there are a few bugs
in that area.  It is significantly simpler to simply split out
an inner function to enforce this.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 77 +++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 29 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6cd9b33a0d..dddd386ec4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7986,13 +7986,15 @@ static int host_to_target_cpu_mask(const unsigned long *host_mask,
     return 0;
 }
 
-/* do_syscall() should always have a single exit point at the end so
-   that actions, such as logging of syscall results, can be performed.
-   All errnos that do_syscall() returns must be -TARGET_<errcode>. */
-abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
-                    abi_long arg2, abi_long arg3, abi_long arg4,
-                    abi_long arg5, abi_long arg6, abi_long arg7,
-                    abi_long arg8)
+/* This is an internal helper for do_syscall so that it is easier
+ * to have a single return point, so that actions, such as logging
+ * of syscall results, can be performed.
+ * All errnos that do_syscall() returns must be -TARGET_<errcode>.
+ */
+static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
+                            abi_long arg2, abi_long arg3, abi_long arg4,
+                            abi_long arg5, abi_long arg6, abi_long arg7,
+                            abi_long arg8)
 {
     CPUState *cpu = ENV_GET_CPU(cpu_env);
     abi_long ret;
@@ -8007,25 +8009,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
     void *p;
 
-#if defined(DEBUG_ERESTARTSYS)
-    /* Debug-only code for exercising the syscall-restart code paths
-     * in the per-architecture cpu main loops: restart every syscall
-     * the guest makes once before letting it through.
-     */
-    {
-        static int flag;
-
-        flag = !flag;
-        if (flag) {
-            return -TARGET_ERESTARTSYS;
-        }
-    }
-#endif
-
-    trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
-    if(do_strace)
-        print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
-
     switch(num) {
     case TARGET_NR_exit:
         /* In old applications this may be used to implement _exit(2).
@@ -12836,11 +12819,47 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         break;
     }
 fail:
-    if(do_strace)
-        print_syscall_ret(num, ret);
-    trace_guest_user_syscall_ret(cpu, num, ret);
     return ret;
 efault:
     ret = -TARGET_EFAULT;
     goto fail;
 }
+
+abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
+                    abi_long arg2, abi_long arg3, abi_long arg4,
+                    abi_long arg5, abi_long arg6, abi_long arg7,
+                    abi_long arg8)
+{
+    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    abi_long ret;
+
+#ifdef DEBUG_ERESTARTSYS
+    /* Debug-only code for exercising the syscall-restart code paths
+     * in the per-architecture cpu main loops: restart every syscall
+     * the guest makes once before letting it through.
+     */
+    {
+        static bool flag;
+        flag = !flag;
+        if (flag) {
+            return -TARGET_ERESTARTSYS;
+        }
+    }
+#endif
+
+    trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4,
+                             arg5, arg6, arg7, arg8);
+
+    if (unlikely(do_strace)) {
+        print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
+        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
+                          arg5, arg6, arg7, arg8);
+        print_syscall_ret(num, ret);
+    } else {
+        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
+                          arg5, arg6, arg7, arg8);
+    }
+
+    trace_guest_user_syscall_ret(cpu, num, ret);
+    return ret;
+}
-- 
2.17.1
