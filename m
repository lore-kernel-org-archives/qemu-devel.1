Received: from eggs.gnu.org ([2001:4830:134:3::10]:59284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXXa-000536-Bx
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXXZ-0007MU-7s
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:06 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:42759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSXXZ-0007LX-19
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:05 -0400
Received: by mail-pg0-x243.google.com with SMTP id c10-v6so4967424pgu.9
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 17:52:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Jun 2018 14:51:32 -1000
Message-Id: <20180612005145.3375-7-richard.henderson@linaro.org>
In-Reply-To: <20180612005145.3375-1-richard.henderson@linaro.org>
References: <20180612005145.3375-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 06/19] linux-user: Split out do_syscall1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, peter.maydell@linaro.org

There was supposed to be a single point of return for do_syscall
so that tracing works properly.  However, there are a few bugs
in that area.  It is significantly simpler to simply split out
an inner function to enforce this.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 77 +++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 29 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c212149245..ec3bc1cbe5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7947,13 +7947,15 @@ static int host_to_target_cpu_mask(const unsigned long *host_mask,
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
@@ -7961,25 +7963,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     struct statfs stfs;
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
@@ -12765,11 +12748,47 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
