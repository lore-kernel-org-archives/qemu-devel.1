Received: from eggs.gnu.org ([2001:4830:134:3::10]:59108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQh-0000lF-8x
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQd-00021N-OQ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:10 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQd-00020P-Gt
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:07 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQc-00009G-HQ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:35:06 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:30 +0100
Message-Id: <20180816133438.17061-23-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/30] aspeed_sdmc: Handle ECC training
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

This is required to ensure u-boot SDRAM training completes.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20180807075757.7242-6-joel@jms.id.au
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/aspeed_sdmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 522e01ef8c0..89de3138aff 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -27,6 +27,10 @@
 #define R_STATUS1         (0x60 / 4)
 #define   PHY_BUSY_STATE      BIT(0)
 
+#define R_ECC_TEST_CTRL   (0x70 / 4)
+#define   ECC_TEST_FINISHED   BIT(12)
+#define   ECC_TEST_FAIL       BIT(13)
+
 /*
  * Configuration register Ox4 (for Aspeed AST2400 SOC)
  *
@@ -148,6 +152,11 @@ static void aspeed_sdmc_write(void *opaque, hwaddr addr, uint64_t data,
             /* Will never return 'busy' */
             data &= ~PHY_BUSY_STATE;
             break;
+        case R_ECC_TEST_CTRL:
+            /* Always done, always happy */
+            data |= ECC_TEST_FINISHED;
+            data &= ~ECC_TEST_FAIL;
+            break;
         default:
             break;
         }
-- 
2.18.0
