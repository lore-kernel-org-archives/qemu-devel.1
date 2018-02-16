Received: from eggs.gnu.org ([2001:4830:134:3::10]:60327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emVmc-0005LZ-SY
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:29:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emVmb-0002TD-Qz
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:29:54 -0500
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:37008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emVmb-0002T4-N2
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:29:53 -0500
Received: by mail-ua0-x241.google.com with SMTP id q8so1107454uae.4
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 18:29:53 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 23:29:26 -0300
Message-Id: <20180216022933.10945-2-f4bug@amsat.org>
In-Reply-To: <20180216022933.10945-1-f4bug@amsat.org>
References: <20180216022933.10945-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/7] hw/sd/milkymist-memcard: use
 qemu_log_mask()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrzej Zaborowski <balrogg@gmail.com>, Michael Walle <michael@walle.cc>, Stefan Weil <sw@weilnetz.de>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Acked-by: Michael Walle <michael@walle.cc>
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
