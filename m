Received: from eggs.gnu.org ([2001:4830:134:3::10]:36698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mb-0007SC-K4
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Ma-0003cS-Lg
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:37 -0400
Received: from mail-lf0-x22a.google.com ([2a00:1450:4010:c07::22a]:35916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1dG3Ma-0003bx-Eu
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:36 -0400
Received: by mail-lf0-x22a.google.com with SMTP id h4so8614275lfj.3
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:08:36 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 31 May 2017 16:08:15 +0300
Message-Id: <43046b5a074029a9354bb2b772ca1f91320440f5.1496234766.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1496234766.git.riku.voipio@linaro.org>
References: <cover.1496234766.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 03/15] linux-user: fix fadvise64_64() on ppc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com, Laurent Vivier <laurent@vivier.eu>

From: Laurent Vivier <laurent@vivier.eu>

On ppc, advice is arg2, not arg6:

long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
                      u32 len_high, u32 len_low)

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2da8426aaa..671b13a23b 100644
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
2.11.0
