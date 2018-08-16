Received: from eggs.gnu.org ([2001:4830:134:3::10]:59087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQd-0000ct-H9
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQc-00020p-P5
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:07 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQc-00020P-He
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:06 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQb-000092-KC
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:35:05 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:29 +0100
Message-Id: <20180816133438.17061-22-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/30] aspeed_sdmc: Init status always idle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Joel Stanley <joel@jms.id.au>

The ast2500 SDRAM training routine busy waits on the 'init cycle busy
state' bit in DDR PHY Control/Status register #1 (MCR60).

This ensures the bit always reads zero, and allows training to
complete with upstream u-boot on the ast2500-evb.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20180807075757.7242-5-joel@jms.id.au
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/aspeed_sdmc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 9ece545c4ff..522e01ef8c0 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -23,6 +23,10 @@
 /* Configuration Register */
 #define R_CONF            (0x04 / 4)
 
+/* Control/Status Register #1 (ast2500) */
+#define R_STATUS1         (0x60 / 4)
+#define   PHY_BUSY_STATE      BIT(0)
+
 /*
  * Configuration register Ox4 (for Aspeed AST2400 SOC)
  *
@@ -137,6 +141,17 @@ static void aspeed_sdmc_write(void *opaque, hwaddr addr, uint64_t data,
             g_assert_not_reached();
         }
     }
+    if (s->silicon_rev == AST2500_A0_SILICON_REV ||
+            s->silicon_rev == AST2500_A1_SILICON_REV) {
+        switch (addr) {
+        case R_STATUS1:
+            /* Will never return 'busy' */
+            data &= ~PHY_BUSY_STATE;
+            break;
+        default:
+            break;
+        }
+    }
 
     s->regs[addr] = data;
 }
-- 
2.18.0
