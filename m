Received: from eggs.gnu.org ([2001:4830:134:3::10]:57717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWrjm-0005E3-Ed
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:42:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWrjl-0002Ji-Lm
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:42:18 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 19:42:07 -0300
Message-Id: <20180103224208.30291-2-f4bug@amsat.org>
In-Reply-To: <20180103224208.30291-1-f4bug@amsat.org>
References: <20180103224208.30291-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/2] hw/timer/pxa2xx_timer: replace
 hw_error() -> qemu_log_mask()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/timer/pxa2xx_timer.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 68ba5a70b3..a489bf5159 100644
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
2.15.1
