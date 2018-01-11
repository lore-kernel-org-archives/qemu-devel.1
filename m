Received: from eggs.gnu.org ([2001:4830:134:3::10]:52321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd47-0007Yc-1T
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd46-0000D4-7P
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:43 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd46-0000Bt-06
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:42 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd44-0005kW-VT
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:40 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:38:17 +0000
Message-Id: <1515677902-23436-22-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/26] hw/timer/pxa2xx_timer: replace hw_error()
 -> qemu_log_mask()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180103224208.30291-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/pxa2xx_timer.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 68ba5a7..a489bf5 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -13,6 +13,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/arm/pxa.h"
 #include "hw/sysbus.h"
+#include "qemu/log.h"
 
 #define OSMR0	0x00
 #define OSMR1	0x04
@@ -252,8 +253,14 @@ static uint64_t pxa2xx_timer_read(void *opaque, hwaddr offset,
     case OSNR:
         return s->snapshot;
     default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unknown register 0x%02" HWADDR_PRIx "\n",
+                      __func__, offset);
+        break;
     badreg:
-        hw_error("pxa2xx_timer_read: Bad offset " REG_FMT "\n", offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: incorrect register 0x%02" HWADDR_PRIx "\n",
+                      __func__, offset);
     }
 
     return 0;
@@ -377,8 +384,14 @@ static void pxa2xx_timer_write(void *opaque, hwaddr offset,
         }
         break;
     default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unknown register 0x%02" HWADDR_PRIx " "
+                      "(value 0x%08" PRIx64 ")\n",  __func__, offset, value);
+        break;
     badreg:
-        hw_error("pxa2xx_timer_write: Bad offset " REG_FMT "\n", offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: incorrect register 0x%02" HWADDR_PRIx " "
+                      "(value 0x%08" PRIx64 ")\n", __func__, offset, value);
     }
 }
 
-- 
2.7.4
