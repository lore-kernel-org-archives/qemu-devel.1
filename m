Received: from eggs.gnu.org ([2001:4830:134:3::10]:46827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dAlFa-0002Ho-0f
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dAlFZ-0005J7-7T
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:47:30 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:45082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dAlFZ-0005IW-23
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:47:29 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Wed, 17 May 2017 00:47:18 +0200
Message-Id: <20170516224721.13832-3-aurelien@aurel32.net>
In-Reply-To: <20170516224721.13832-1-aurelien@aurel32.net>
References: <20170516224721.13832-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 2/5] target/sh4: fix reset when using a kernel
 and an initrd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

When a masked exception happens, the SH4 CPU generates a non-masked
reset exception, which then jumps to the reset vector at address
0xA0000000. While this is emulated correctly in QEMU, this does not
work when using a kernel and initrd as this address then contain an
illegal instruction (and there is no guarantee the kernel and initrd
haven't been overwritten).

Therefore call qemu_system_reset_request to reload the kernel and initrd
and load the program counter to the kernel entry point.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 4c024f9529..5296e7cf4e 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/log.h"
+#include "sysemu/sysemu.h"
 
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/sh4/sh_intc.h"
@@ -92,7 +93,14 @@ void superh_cpu_do_interrupt(CPUState *cs)
 
     if (env->sr & (1u << SR_BL)) {
         if (do_exp && cs->exception_index != 0x1e0) {
-            cs->exception_index = 0x000; /* masked exception -> reset */
+            /* In theory a masked exception generates a reset exception,
+               which in turn jumps to the reset vector. However this only
+               works when using a bootloader. When using a kernel and an
+               initrd, they need to be reloaded and the program counter
+               should be loaded with the kernel entry point.
+               qemu_system_reset_request takes care of that.  */
+            qemu_system_reset_request();
+            return;
         }
         if (do_irq && !env->in_sleep) {
             return; /* masked */
-- 
2.11.0
