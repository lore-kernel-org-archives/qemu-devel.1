Received: from eggs.gnu.org ([2001:4830:134:3::10]:60983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe0-0007WN-OK
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAdz-0002j7-QB
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:36 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cbAdz-0002gg-K5
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:35 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAdw-0005WF-BF
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:37:32 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Feb 2017 18:37:25 +0000
Message-Id: <1486492645-27803-14-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
References: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/13] stellaris: Use the 'unimplemented' device
 for parts we don't implement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Use the 'unimplemented' dummy device to cover regions of the
SoC device memory map which we don't have proper device
implementations for yet.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 1484247815-15279-4-git-send-email-peter.maydell@linaro.org
---
 hw/arm/stellaris.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 5c4b707..9edcd49 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -21,6 +21,7 @@
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
 #include "hw/char/pl011.h"
+#include "hw/misc/unimp.h"
 
 #define GPIO_A 0
 #define GPIO_B 1
@@ -1404,6 +1405,19 @@ static void stellaris_init(const char *kernel_filename, const char *cpu_model,
             }
         }
     }
+
+    /* Add dummy regions for the devices we don't implement yet,
+     * so guest accesses don't cause unlogged crashes.
+     */
+    create_unimplemented_device("wdtimer", 0x40000000, 0x1000);
+    create_unimplemented_device("i2c-0", 0x40002000, 0x1000);
+    create_unimplemented_device("i2c-2", 0x40021000, 0x1000);
+    create_unimplemented_device("PWM", 0x40028000, 0x1000);
+    create_unimplemented_device("QEI-0", 0x4002c000, 0x1000);
+    create_unimplemented_device("QEI-1", 0x4002d000, 0x1000);
+    create_unimplemented_device("analogue-comparator", 0x4003c000, 0x1000);
+    create_unimplemented_device("hibernation", 0x400fc000, 0x1000);
+    create_unimplemented_device("flash-control", 0x400fd000, 0x1000);
 }
 
 /* FIXME: Figure out how to generate these from stellaris_boards.  */
-- 
2.7.4
