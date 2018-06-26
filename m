Received: from eggs.gnu.org ([2001:4830:134:3::10]:51929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHG-00025L-7l
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHF-0007FY-H3
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:14 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fXrHF-0007CU-9s
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:13 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrH2-0008SX-Sr
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:57:00 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:56:27 +0100
Message-Id: <20180626165658.31394-2-peter.maydell@linaro.org>
In-Reply-To: <20180626165658.31394-1-peter.maydell@linaro.org>
References: <20180626165658.31394-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/32] aspeed/smc: fix dummy cycles count when
 in dual IO mode
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

When configured in dual I/O mode, address and data are sent in dual
mode, including the dummy byte cycles in between. Adapt the count to
the IO setting.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 20180612065716.10587-2-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 5059396bc62..fce126e6ee9 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -66,6 +66,8 @@
 
 /* CEx Control Register */
 #define R_CTRL0           (0x10 / 4)
+#define   CTRL_IO_DUAL_DATA        (1 << 29)
+#define   CTRL_IO_DUAL_ADDR_DATA   (1 << 28) /* Includes dummies */
 #define   CTRL_CMD_SHIFT           16
 #define   CTRL_CMD_MASK            0xff
 #define   CTRL_DUMMY_HIGH_SHIFT    14
@@ -492,8 +494,13 @@ static int aspeed_smc_flash_dummies(const AspeedSMCFlash *fl)
     uint32_t r_ctrl0 = s->regs[s->r_ctrl0 + fl->id];
     uint32_t dummy_high = (r_ctrl0 >> CTRL_DUMMY_HIGH_SHIFT) & 0x1;
     uint32_t dummy_low = (r_ctrl0 >> CTRL_DUMMY_LOW_SHIFT) & 0x3;
+    uint32_t dummies = ((dummy_high << 2) | dummy_low) * 8;
 
-    return ((dummy_high << 2) | dummy_low) * 8;
+    if (r_ctrl0 & CTRL_IO_DUAL_ADDR_DATA) {
+        dummies /= 2;
+    }
+
+    return dummies;
 }
 
 static void aspeed_smc_flash_send_addr(AspeedSMCFlash *fl, uint32_t addr)
-- 
2.17.1
