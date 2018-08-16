Received: from eggs.gnu.org ([2001:4830:134:3::10]:56799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJmQ-0007xb-41
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJmD-0001ym-32
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:01:36 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46085 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqJm5-00015j-Nx
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:01:25 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 16 Aug 2018 16:58:08 +0200
Message-Id: <1534431497-1385-76-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v9 75/84] linux-user: Add support for nanoMIPS
 signal trampoline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Add signal trampoline support for nanoMIPS.

Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/mips/signal.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/linux-user/mips/signal.c b/linux-user/mips/signal.c
index ab66429..c6f5504 100644
--- a/linux-user/mips/signal.c
+++ b/linux-user/mips/signal.c
@@ -101,6 +101,17 @@ static inline int install_sigtramp(unsigned int *tramp,   unsigned int syscall)
 {
     int err = 0;
 
+#if defined(TARGET_ABI_MIPSP32)
+    uint16_t *tramp16 = (uint16_t *)tramp;
+    /*
+     *         li      $2, __NR__foo_sigreturn
+     *         syscall 0
+     */
+     __put_user(0x6040 , tramp16 + 0);
+     __put_user(syscall, tramp16 + 1);
+     __put_user(0      , tramp16 + 2);
+     __put_user(0x1008 , tramp16 + 3);
+#else
     /*
      * Set up the return code ...
      *
@@ -110,7 +121,7 @@ static inline int install_sigtramp(unsigned int *tramp,   unsigned int syscall)
 
     __put_user(0x24020000 + syscall, tramp + 0);
     __put_user(0x0000000c          , tramp + 1);
-
+#endif
     return err;
 }
 
-- 
2.7.4
