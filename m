Received: from eggs.gnu.org ([2001:4830:134:3::10]:39819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeR1-0002lF-AX
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQz-0001aY-Ve
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:31 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fBeQz-0001Vb-Ov
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:29 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQy-000369-L0
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:47:28 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 11:47:13 +0100
Message-Id: <20180426104715.21702-18-peter.maydell@linaro.org>
In-Reply-To: <20180426104715.21702-1-peter.maydell@linaro.org>
References: <20180426104715.21702-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/19] hw/arm/aspeed_soc: don't use
 vmstate_register_ram_global for SRAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Currently we use vmstate_register_ram_global() for the SRAM;
this is not a good idea for devices, because it means that
you can only ever create one instance of the device, as
the second instance would get a RAM block name clash.
Instead, use memory_region_init_ram(), which automatically
registers the RAM block with a local-to-the-device name.

Note that this would be a cross-version migration compatibility break
for the "palmetto-bmc", "ast2500-evb" and "romulus-bmc" machines,
but migration is currently broken for them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20180420124835.7268-4-peter.maydell@linaro.org
---
 hw/arm/aspeed_soc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 30d25f8b06..407f10d0d4 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -186,13 +186,12 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* SRAM */
-    memory_region_init_ram_nomigrate(&s->sram, OBJECT(dev), "aspeed.sram",
+    memory_region_init_ram(&s->sram, OBJECT(dev), "aspeed.sram",
                            sc->info->sram_size, &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
-    vmstate_register_ram_global(&s->sram);
     memory_region_add_subregion(get_system_memory(), ASPEED_SOC_SRAM_BASE,
                                 &s->sram);
 
-- 
2.17.0
