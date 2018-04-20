Received: from eggs.gnu.org ([2001:4830:134:3::10]:48766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9VZg-0002HV-Sl
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9VZf-00009C-Ob
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:55:36 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 13:48:34 +0100
Message-Id: <20180420124835.7268-3-peter.maydell@linaro.org>
In-Reply-To: <20180420124835.7268-1-peter.maydell@linaro.org>
References: <20180420124835.7268-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/3] hw/arm/aspeed: don't make 'boot_rom'
 region 'nomigrate'
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

Currently we use memory_region_init_ram_nomigrate() to create
the "aspeed.boot_rom" memory region, and we don't manually
register it with vmstate_register_ram(). This currently
means that its contents are migrated but as a ram block
whose name is the empty string; in future it may mean they
are not migrated at all. Use memory_region_init_ram() instead.

Note that this is a cross-version migration compatibility break
for the "palmetto-bmc", "ast2500-evb" and "romulus-bmc" machines.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 7088c907bd..aecb3c1e75 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -225,7 +225,7 @@ static void aspeed_board_init(MachineState *machine,
          * SoC and 128MB for the AST2500 SoC, which is twice as big as
          * needed by the flash modules of the Aspeed machines.
          */
-        memory_region_init_rom_nomigrate(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
+        memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
                                fl->size, &error_abort);
         memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
                                     boot_rom);
-- 
2.17.0
