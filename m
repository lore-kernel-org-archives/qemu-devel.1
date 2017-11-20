Received: from eggs.gnu.org ([2001:4830:134:3::10]:58282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtW5-0004vh-6b
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtW4-00086M-6J
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:09 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:41055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1eGtW3-00083W-UF
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:08 -0500
Received: by mail-lf0-x244.google.com with SMTP id f134so11686961lfg.8
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 13:22:07 -0800 (PST)
From: riku.voipio@linaro.org
Date: Mon, 20 Nov 2017 23:21:42 +0200
Message-Id: <78bfef72fbf8705f002c5c57cf3f1d3b8e83399e.1511212753.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1511212753.git.riku.voipio@linaro.org>
References: <cover.1511212753.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/15] linux-user: Handle rt_sigaction correctly
 for SPARC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

SPARC is like Alpha in its handling of the rt_sigaction syscall:
it takes an extra parameter 'restorer' which needs to be copied
into the sa_restorer field of the sigaction struct. The order
of the arguments differs slightly between SPARC and Alpha but
the implementation is otherwise the same. (Compare the
rt_sigaction() functions in arch/sparc/kernel/sys_sparc_64.c
and arch/alpha/kernel/signal.c.)

Note that this change is somewhat moot until SPARC acquires
support for actually delivering RT signals.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f31b853bb7..11c9116c4a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8579,8 +8579,16 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_rt_sigaction:
         {
 #if defined(TARGET_ALPHA)
-            struct target_sigaction act, oact, *pact = 0;
+            /* For Alpha and SPARC this is a 5 argument syscall, with
+             * a 'restorer' parameter which must be copied into the
+             * sa_restorer field of the sigaction struct.
+             * For Alpha that 'restorer' is arg5; for SPARC it is arg4,
+             * and arg5 is the sigsetsize.
+             * Alpha also has a separate rt_sigaction struct that it uses
+             * here; SPARC uses the usual sigaction struct.
+             */
             struct target_rt_sigaction *rt_act;
+            struct target_sigaction act, oact, *pact = 0;
 
             if (arg4 != sizeof(target_sigset_t)) {
                 ret = -TARGET_EINVAL;
@@ -8606,18 +8614,29 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                 unlock_user_struct(rt_act, arg3, 1);
             }
 #else
+#ifdef TARGET_SPARC
+            target_ulong restorer = arg4;
+            target_ulong sigsetsize = arg5;
+#else
+            target_ulong sigsetsize = arg4;
+#endif
             struct target_sigaction *act;
             struct target_sigaction *oact;
 
-            if (arg4 != sizeof(target_sigset_t)) {
+            if (sigsetsize != sizeof(target_sigset_t)) {
                 ret = -TARGET_EINVAL;
                 break;
             }
             if (arg2) {
-                if (!lock_user_struct(VERIFY_READ, act, arg2, 1))
+                if (!lock_user_struct(VERIFY_READ, act, arg2, 1)) {
                     goto efault;
-            } else
+                }
+#ifdef TARGET_SPARC
+                act->sa_restorer = restorer;
+#endif
+            } else {
                 act = NULL;
+            }
             if (arg3) {
                 if (!lock_user_struct(VERIFY_WRITE, oact, arg3, 0)) {
                     ret = -TARGET_EFAULT;
-- 
2.14.2
