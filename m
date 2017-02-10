Received: from eggs.gnu.org ([2001:4830:134:3::10]:49678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFcA-00023A-Tl
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc9-0003zh-PG
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:10 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ccFc9-0003xp-HT
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:09 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc8-0007eB-OW
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 18:08:08 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 18:08:00 +0000
Message-Id: <1486750082-12324-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
References: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/12] aspeed: remove useless comment on
 controller segment size
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

The flash devices used for the FMC controller (BMC firmware) are well
defined for each Aspeed machine and are all smaller than the default
mapping window size, at least for CE0 which is the chip the SoC boots
from.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1486648058-520-3-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index ac9cbd6..283c038 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -148,10 +148,6 @@ static void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
         DriveInfo *dinfo = drive_get_next(IF_MTD);
         qemu_irq cs_line;
 
-        /*
-         * FIXME: check that we are not using a flash module exceeding
-         * the controller segment size
-         */
         fl->flash = ssi_create_slave_no_init(s->spi, flashtype);
         if (dinfo) {
             qdev_prop_set_drive(fl->flash, "drive", blk_by_legacy_dinfo(dinfo),
@@ -210,7 +206,9 @@ static void aspeed_board_init(MachineState *machine,
 
         /*
          * create a ROM region using the default mapping window size of
-         * the flash module.
+         * the flash module. The window size is 64MB for the AST2400
+         * SoC and 128MB for the AST2500 SoC, which is twice as big as
+         * needed by the flash modules of the Aspeed machines.
          */
         memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
                                fl->size, &error_abort);
-- 
2.7.4
