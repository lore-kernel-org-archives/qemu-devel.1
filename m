Received: from eggs.gnu.org ([2001:4830:134:3::10]:48744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9VZg-0002Gr-62
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9VZf-00006n-9K
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:55:36 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 13:48:35 +0100
Message-Id: <20180420124835.7268-4-peter.maydell@linaro.org>
In-Reply-To: <20180420124835.7268-1-peter.maydell@linaro.org>
References: <20180420124835.7268-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/3] hw/arm/aspeed_soc: don't use
 vmstate_register_ram_global for SRAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Rob Herring <robh@kernel.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Currently we use vmstate_register_ram_global() for the SRAM;
this is not a good idea for devices, because it means that
you can only ever create one instance of the device, as
the second instance would get a RAM block name clash.
Instead, use memory_region_init_ram(), which automatically
registers the RAM block with a local-to-the-device name.

Note that this is a cross-version migration compatibility break
for the "palmetto-bmc", "ast2500-evb" and "romulus-bmc" machines.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
