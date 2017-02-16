Received: from eggs.gnu.org ([2001:4830:134:3::10]:48716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceMxh-0003Ct-Ly
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceMxe-0002Ux-F4
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:23:09 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:65114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ceMxe-0002UV-4i
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:23:06 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 16 Feb 2017 15:22:19 +0100
Message-Id: <20170216142227.27448-7-laurent@vivier.eu>
In-Reply-To: <20170216142227.27448-1-laurent@vivier.eu>
References: <20170216142227.27448-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 06/14] linux-user: Fix mq_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Lena Djokic <Lena.Djokic@rt-rk.com>, Riku Voipio <riku.voipio@linaro.org>

From: Lena Djokic <Lena.Djokic@rt-rk.com>

If fourth argument is NULL it should be passed without
using lock_user function which would, in that case, return
EFAULT, and system call supports passing NULL as fourth argument.

Signed-off-by: Lena Djokic <Lena.Djokic@rt-rk.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3e88dd1..c1d6f76 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11583,17 +11583,22 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_mq_open:
         {
             struct mq_attr posix_mq_attr;
+            struct mq_attr *pposix_mq_attr;
             int host_flags;
 
             host_flags = target_to_host_bitmask(arg2, fcntl_flags_tbl);
-            if (copy_from_user_mq_attr(&posix_mq_attr, arg4) != 0) {
-                goto efault;
+            pposix_mq_attr = NULL;
+            if (arg4) {
+                if (copy_from_user_mq_attr(&posix_mq_attr, arg4) != 0) {
+                    goto efault;
+                }
+                pposix_mq_attr = &posix_mq_attr;
             }
             p = lock_user_string(arg1 - 1);
             if (!p) {
                 goto efault;
             }
-            ret = get_errno(mq_open(p, host_flags, arg3, &posix_mq_attr));
+            ret = get_errno(mq_open(p, host_flags, arg3, pposix_mq_attr));
             unlock_user (p, arg1, 0);
         }
         break;
-- 
2.9.3
