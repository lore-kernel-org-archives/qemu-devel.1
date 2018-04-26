Received: from eggs.gnu.org ([2001:4830:134:3::10]:39773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeR0-0002lA-IK
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQz-0001ZY-6s
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:30 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fBeQy-0001Yu-Vo
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:29 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQx-00035o-V1
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:47:27 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 11:47:12 +0100
Message-Id: <20180426104715.21702-17-peter.maydell@linaro.org>
In-Reply-To: <20180426104715.21702-1-peter.maydell@linaro.org>
References: <20180426104715.21702-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/19] hw/arm/aspeed: don't make 'boot_rom'
 region 'nomigrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Currently we use memory_region_init_ram_nomigrate() to create
the "aspeed.boot_rom" memory region, and we don't manually
register it with vmstate_register_ram(). This currently
means that its contents are migrated but as a ram block
whose name is the empty string; in future it may mean they
are not migrated at all. Use memory_region_init_ram() instead.

Note that would be a cross-version migration compatibility break
for the "palmetto-bmc", "ast2500-evb" and "romulus-bmc" machines,
but migration is currently broken for them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20180420124835.7268-3-peter.maydell@linaro.org
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
