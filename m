Received: from eggs.gnu.org ([2001:4830:134:3::10]:53844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceNCo-0000kr-Ba
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceNCl-0002OF-JE
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:38:46 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:55069)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ceNCl-0002NC-9P
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:38:43 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 16 Feb 2017 15:38:06 +0100
Message-Id: <20170216143816.2384-5-laurent@vivier.eu>
In-Reply-To: <20170216143816.2384-1-laurent@vivier.eu>
References: <20170216143816.2384-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL v2 04/14] linux-user: Fix inotify_init1 support
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

This commit adds necessary conversion of argument passed to inotify_init1.
inotify_init1 flags can be IN_NONBLOCK and IN_CLOEXEC which rely on O_NONBLOCK
and O_CLOEXEC and those can have different values on different platforms.

Signed-off-by: Lena Djokic <Lena.Djokic@rt-rk.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9be8e95..fccd631 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11561,7 +11561,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #ifdef CONFIG_INOTIFY1
 #if defined(TARGET_NR_inotify_init1) && defined(__NR_inotify_init1)
     case TARGET_NR_inotify_init1:
-        ret = get_errno(sys_inotify_init1(arg1));
+        ret = get_errno(sys_inotify_init1(target_to_host_bitmask(arg1,
+                                          fcntl_flags_tbl)));
         break;
 #endif
 #endif
-- 
2.9.3
