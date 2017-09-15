Received: from eggs.gnu.org ([2001:4830:134:3::10]:40425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jrtc27@jrtc27.com>) id 1dskap-0005FK-59
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 02:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jrtc27@jrtc27.com>) id 1dskal-00067S-AT
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 02:59:15 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:56889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jrtc27@jrtc27.com>) id 1dskal-000676-3i
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 02:59:11 -0400
Received: by mail-wr0-x22e.google.com with SMTP id r74so997157wrb.13
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 23:59:09 -0700 (PDT)
From: James Clarke <jrtc27@jrtc27.com>
Date: Fri, 15 Sep 2017 07:58:21 +0100
Message-Id: <20170915065821.16600-1-jrtc27@jrtc27.com>
Subject: [Qemu-devel] [PATCH] linux-user/syscall.c: Handle SH4's exceptional
 alignment for p{read, write}64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: James Clarke <jrtc27@jrtc27.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>

Fixes: https://bugs.launchpad.net/qemu/+bug/1716767
Signed-off-by: James Clarke <jrtc27@jrtc27.com>
---
 linux-user/syscall.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9b6364a266..24d6a81c21 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10495,20 +10495,32 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_pread64
     case TARGET_NR_pread64:
+#if defined(TARGET_SH4)
+        /* SH4 doesn't align register pairs, except for p{read,write}64 */
+        arg4 = arg5;
+        arg5 = arg6;
+#else
         if (regpairs_aligned(cpu_env)) {
             arg4 = arg5;
             arg5 = arg6;
         }
+#endif
         if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
             goto efault;
         ret = get_errno(pread64(arg1, p, arg3, target_offset64(arg4, arg5)));
         unlock_user(p, arg2, ret);
         break;
     case TARGET_NR_pwrite64:
+#if defined(TARGET_SH4)
+        /* SH4 doesn't align register pairs, except for p{read,write}64 */
+        arg4 = arg5;
+        arg5 = arg6;
+#else
         if (regpairs_aligned(cpu_env)) {
             arg4 = arg5;
             arg5 = arg6;
         }
+#endif
         if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
             goto efault;
         ret = get_errno(pwrite64(arg1, p, arg3, target_offset64(arg4, arg5)));
--
2.13.2
