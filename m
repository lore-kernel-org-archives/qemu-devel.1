Received: from eggs.gnu.org ([2001:4830:134:3::10]:49882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cjELn-0007Q6-V8
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 19:12:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cjELk-0001NL-PD
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 19:12:07 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:63511)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cjELk-0001Mc-E3
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 19:12:04 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  2 Mar 2017 01:11:45 +0100
Message-Id: <20170302001145.6879-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] linux-user: fix fadvise64_64() on ppc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>

On ppc, advice is arg2, not arg6:

long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
                      u32 len_high, u32 len_low)

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2da8426..671b13a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11261,6 +11261,15 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 
 #ifdef TARGET_NR_fadvise64_64
     case TARGET_NR_fadvise64_64:
+#if defined(TARGET_PPC)
+        /* 6 args: fd, advice, offset (high, low), len (high, low) */
+        ret = arg2;
+        arg2 = arg3;
+        arg3 = arg4;
+        arg4 = arg5;
+        arg5 = arg6;
+        arg6 = ret;
+#else
         /* 6 args: fd, offset (high, low), len (high, low), advice */
         if (regpairs_aligned(cpu_env)) {
             /* offset is in (3,4), len in (5,6) and advice in 7 */
@@ -11270,6 +11279,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             arg5 = arg6;
             arg6 = arg7;
         }
+#endif
         ret = -host_to_target_errno(posix_fadvise(arg1,
                                                   target_offset64(arg2, arg3),
                                                   target_offset64(arg4, arg5),
-- 
2.9.3
