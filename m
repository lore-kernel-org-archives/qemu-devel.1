Received: from eggs.gnu.org ([2001:4830:134:3::10]:38284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiV-0004hX-SJ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiU-0001ae-Oi
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:27 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosiU-0001a9-Hp
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:26 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiT-00021I-JQ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:25 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:40 +0000
Message-Id: <20180222152307.7499-6-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/32] hw/sd/milkymist-memcard: use
 qemu_log_mask()
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
Acked-by: Michael Walle <michael@walle.cc>
Message-id: 20180216022933.10945-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/milkymist-memcard.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 341da88552..1292c0c099 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -22,11 +22,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
-#include "qemu/error-report.h"
+#include "include/qapi/error.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "hw/sd/sd.h"
@@ -138,8 +139,8 @@ static uint64_t memcard_read(void *opaque, hwaddr addr,
         } else {
             r = s->response[s->response_read_ptr++];
             if (s->response_read_ptr > s->response_len) {
-                error_report("milkymist_memcard: "
-                        "read more cmd bytes than available. Clipping.");
+                qemu_log_mask(LOG_GUEST_ERROR, "milkymist_memcard: "
+                              "read more cmd bytes than available. Clipping.");
                 s->response_read_ptr = 0;
             }
         }
@@ -163,8 +164,9 @@ static uint64_t memcard_read(void *opaque, hwaddr addr,
         break;
 
     default:
-        error_report("milkymist_memcard: read access to unknown register 0x"
-                TARGET_FMT_plx, addr << 2);
+        qemu_log_mask(LOG_UNIMP, "milkymist_memcard: "
+                      "read access to unknown register 0x%" HWADDR_PRIx "\n",
+                      addr << 2);
         break;
     }
 
@@ -220,8 +222,9 @@ static void memcard_write(void *opaque, hwaddr addr, uint64_t value,
         break;
 
     default:
-        error_report("milkymist_memcard: write access to unknown register 0x"
-                TARGET_FMT_plx, addr << 2);
+        qemu_log_mask(LOG_UNIMP, "milkymist_memcard: "
+                      "write access to unknown register 0x%" HWADDR_PRIx " "
+                      "(value 0x%" PRIx64 ")\n", addr << 2, value);
         break;
     }
 }
-- 
2.16.1
