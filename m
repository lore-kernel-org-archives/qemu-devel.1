Received: from eggs.gnu.org ([2001:4830:134:3::10]:60768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fmwt5-0002nE-RT
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fmwt4-0005ba-Tg
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:58:39 -0400
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue,  7 Aug 2018 17:27:54 +0930
Message-Id: <20180807075757.7242-5-joel@jms.id.au>
In-Reply-To: <20180807075757.7242-1-joel@jms.id.au>
References: <20180807075757.7242-1-joel@jms.id.au>
Subject: [Qemu-devel] [PATCH 4/7] aspeed_sdmc: Init status alwlays idle
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

The ast2500 SDRAM training routine busy waits on the 'init cycle busy
state' bit in DDR PHY Control/Status register #1 (MCR60).

This ensures the bit always reads zero, and allows training to
complete with upstream u-boot on the ast2500-evb.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/misc/aspeed_sdmc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 9ece545c4ffa..522e01ef8c0d 100644
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
2.17.1
