Received: from eggs.gnu.org ([2001:4830:134:3::10]:60746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fmwt3-0002m8-30
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fmwsy-0005ZN-85
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:58:37 -0400
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue,  7 Aug 2018 17:27:53 +0930
Message-Id: <20180807075757.7242-4-joel@jms.id.au>
In-Reply-To: <20180807075757.7242-1-joel@jms.id.au>
References: <20180807075757.7242-1-joel@jms.id.au>
Subject: [Qemu-devel] [PATCH 3/7] aspeed_sdmc: Set 'cache initial sequence'
 always true
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

The SDRAM training routine sets the 'Enable cache initial' bit, and then
waits for the 'cache initial sequence' to be done.

Have it always return done, as there is no other side effects that the
model needs to implement. This allows the upstream u-boot training to
proceed on the ast2500-evb board.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/misc/aspeed_sdmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 24fd4aee2d82..9ece545c4ffa 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -226,6 +226,7 @@ static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
         s->ram_bits = ast2500_rambits(s);
         s->fixed_conf = ASPEED_SDMC_HW_VERSION(1) |
             ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
+            ASPEED_SDMC_CACHE_INITIAL_DONE |
             ASPEED_SDMC_DRAM_SIZE(s->ram_bits);
         break;
     default:
-- 
2.17.1
