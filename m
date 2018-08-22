Received: from eggs.gnu.org ([2001:4830:134:3::10]:36339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsHjV-0005k9-C9
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsHjP-0001eU-Br
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:14:49 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:42769)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fsHjN-0001ai-St
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:14:42 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 22 Aug 2018 03:14:12 +0200
Message-Id: <20180822011417.11608-3-laurent@vivier.eu>
In-Reply-To: <20180822011417.11608-1-laurent@vivier.eu>
References: <20180822011417.11608-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/7] linux-user: Split out do_syscall1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

There was supposed to be a single point of return for do_syscall
so that tracing works properly.  However, there are a few bugs
in that area.  It is significantly simpler to simply split out
an inner function to enforce this.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180818190118.12911-3-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 77 +++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 29 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2e45f854f7..f651024357 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8092,13 +8092,15 @@ static int host_to_target_cpu_mask(const unsigned long *host_mask,
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
@@ -8113,25 +8115,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
@@ -12942,11 +12925,47 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
