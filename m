Received: from eggs.gnu.org ([2001:4830:134:3::10]:41208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1gWYSA-0003WO-3z
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 22:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1gWYS9-0005fb-DX
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 22:11:22 -0500
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 11 Dec 2018 13:40:44 +1030
Message-Id: <20181211031044.27628-3-joel@jms.id.au>
In-Reply-To: <20181211031044.27628-1-joel@jms.id.au>
References: <20181211031044.27628-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] aspeed/scu: Implement power off register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

This register does not exist in hardware. It is here to allow the guest
code to cause Qemu to exit when required.

The register address chosen is unused in the emulated machines
datasheets.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/misc/aspeed_scu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index c8217740efc1..aa17d032ba93 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -16,6 +16,7 @@
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "sysemu/sysemu.h"
 #include "crypto/random.h"
 #include "trace.h"
 
@@ -84,6 +85,7 @@
 #define SRAM_DECODE_BASE1    TO_REG(0x194)
 #define SRAM_DECODE_BASE2    TO_REG(0x198)
 #define BMC_REV              TO_REG(0x19C)
+#define POWEROFF             TO_REG(0x1A0)
 #define BMC_DEV_ID           TO_REG(0x1A4)
 
 #define SCU_IO_REGION_SIZE 0x1000
@@ -264,6 +266,9 @@ static void aspeed_scu_write(void *opaque, hwaddr offset, uint64_t data,
         }
         /* Avoid assignment below, we've handled everything */
         return;
+    case POWEROFF:
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+        break;
     case FREQ_CNTR_EVAL:
     case VGA_SCRATCH1 ... VGA_SCRATCH8:
     case RNG_DATA:
-- 
2.19.1
