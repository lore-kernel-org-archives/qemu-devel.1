Received: from eggs.gnu.org ([2001:4830:134:3::10]:38408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosid-0004pQ-7i
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosia-0001fp-Qp
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:35 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosia-0001fC-JR
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:32 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiZ-00022z-Lk
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:31 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:47 +0000
Message-Id: <20180222152307.7499-13-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/32] sdcard: replace fprintf() by
 qemu_hexdump()
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
Message-id: 20180215220540.6556-5-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8f72cde534..ceab263970 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -44,13 +44,6 @@
 
 //#define DEBUG_SD 1
 
-#ifdef DEBUG_SD
-#define DPRINTF(fmt, ...) \
-do { fprintf(stderr, "SD: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
-
 #define ACMD41_ENQUIRY_MASK     0x00ffffff
 #define OCR_POWER_UP            0x80000000
 #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
@@ -1632,14 +1625,7 @@ send_response:
     }
 
 #ifdef DEBUG_SD
-    if (rsplen) {
-        int i;
-        DPRINTF("Response:");
-        for (i = 0; i < rsplen; i++) {
-            DPRINTF(" %02x", response[i]);
-        }
-        DPRINTF(" state %d\n", sd->state);
-    }
+    qemu_hexdump((const char *)response, stderr, "Response", rsplen);
 #endif
 
     return rsplen;
-- 
2.16.1
