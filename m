Received: from eggs.gnu.org ([2001:4830:134:3::10]:48655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceMxd-00035X-59
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:23:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceMxZ-0002TG-C2
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:23:05 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:59359)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ceMxZ-0002Sc-0s
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:23:01 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 16 Feb 2017 15:22:18 +0100
Message-Id: <20170216142227.27448-6-laurent@vivier.eu>
In-Reply-To: <20170216142227.27448-1-laurent@vivier.eu>
References: <20170216142227.27448-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 05/14] linux-user: Fix readahead
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

Calculation of 64-bit offset was not correct for all cases.

Signed-off-by: Lena Djokic <Lena.Djokic@rt-rk.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fccd631..3e88dd1 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11228,7 +11228,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             arg3 = arg4;
             arg4 = arg5;
         }
-        ret = get_errno(readahead(arg1, ((off64_t)arg3 << 32) | arg2, arg4));
+        ret = get_errno(readahead(arg1, target_offset64(arg2, arg3) , arg4));
 #else
         ret = get_errno(readahead(arg1, arg2, arg3));
 #endif
-- 
2.9.3
