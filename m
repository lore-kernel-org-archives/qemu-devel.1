Received: from eggs.gnu.org ([2001:4830:134:3::10]:60817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fmwtI-0002xl-58
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fmwtH-0005fG-Fz
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:58:52 -0400
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue,  7 Aug 2018 17:27:55 +0930
Message-Id: <20180807075757.7242-6-joel@jms.id.au>
In-Reply-To: <20180807075757.7242-1-joel@jms.id.au>
References: <20180807075757.7242-1-joel@jms.id.au>
Subject: [Qemu-devel] [PATCH 5/7] aspeed_sdmc: Handle ECC training
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

This is required to ensure u-boot SDRAM training completes.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/misc/aspeed_sdmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 522e01ef8c0d..89de3138aff0 100644
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
2.17.1
