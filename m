Received: from eggs.gnu.org ([2001:4830:134:3::10]:51923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHG-000257-1V
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHF-0007Ex-0G
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:14 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fXrHE-00079F-PD
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:12 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrH4-0008Ta-9d
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:57:02 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:56:29 +0100
Message-Id: <20180626165658.31394-4-peter.maydell@linaro.org>
In-Reply-To: <20180626165658.31394-1-peter.maydell@linaro.org>
References: <20180626165658.31394-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/32] aspeed/smc: rename
 aspeed_smc_flash_send_addr() to aspeed_smc_flash_setup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

Also handle the fake transfers for dummy bytes in this setup
routine. It will be useful when we activate MMIO execution.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 20180612065716.10587-4-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index b1537089358..b29bfd3124a 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -503,10 +503,11 @@ static int aspeed_smc_flash_dummies(const AspeedSMCFlash *fl)
     return dummies;
 }
 
-static void aspeed_smc_flash_send_addr(AspeedSMCFlash *fl, uint32_t addr)
+static void aspeed_smc_flash_setup(AspeedSMCFlash *fl, uint32_t addr)
 {
     const AspeedSMCState *s = fl->controller;
     uint8_t cmd = aspeed_smc_flash_cmd(fl);
+    int i;
 
     /* Flash access can not exceed CS segment */
     addr = aspeed_smc_check_segment_addr(fl, addr);
@@ -519,6 +520,18 @@ static void aspeed_smc_flash_send_addr(AspeedSMCFlash *fl, uint32_t addr)
     ssi_transfer(s->spi, (addr >> 16) & 0xff);
     ssi_transfer(s->spi, (addr >> 8) & 0xff);
     ssi_transfer(s->spi, (addr & 0xff));
+
+    /*
+     * Use fake transfers to model dummy bytes. The value should
+     * be configured to some non-zero value in fast read mode and
+     * zero in read mode. But, as the HW allows inconsistent
+     * settings, let's check for fast read mode.
+     */
+    if (aspeed_smc_flash_mode(fl) == CTRL_FREADMODE) {
+        for (i = 0; i < aspeed_smc_flash_dummies(fl); i++) {
+                ssi_transfer(fl->controller->spi, 0xFF);
+        }
+    }
 }
 
 static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigned size)
@@ -537,19 +550,7 @@ static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigned size)
     case CTRL_READMODE:
     case CTRL_FREADMODE:
         aspeed_smc_flash_select(fl);
-        aspeed_smc_flash_send_addr(fl, addr);
-
-        /*
-         * Use fake transfers to model dummy bytes. The value should
-         * be configured to some non-zero value in fast read mode and
-         * zero in read mode. But, as the HW allows inconsistent
-         * settings, let's check for fast read mode.
-         */
-        if (aspeed_smc_flash_mode(fl) == CTRL_FREADMODE) {
-            for (i = 0; i < aspeed_smc_flash_dummies(fl); i++) {
-                ssi_transfer(fl->controller->spi, 0xFF);
-            }
-        }
+        aspeed_smc_flash_setup(fl, addr);
 
         for (i = 0; i < size; i++) {
             ret |= ssi_transfer(s->spi, 0x0) << (8 * i);
@@ -586,7 +587,7 @@ static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t data,
         break;
     case CTRL_WRITEMODE:
         aspeed_smc_flash_select(fl);
-        aspeed_smc_flash_send_addr(fl, addr);
+        aspeed_smc_flash_setup(fl, addr);
 
         for (i = 0; i < size; i++) {
             ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
-- 
2.17.1
