Received: from eggs.gnu.org ([2001:4830:134:3::10]:48233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWcn-0007i8-KA
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWcm-000543-Jy
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:45 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fcWcm-00053K-Bs
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:44 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWcl-0000kZ-9C
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:54:43 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jul 2018 14:54:33 +0100
Message-Id: <20180709135435.836-10-peter.maydell@linaro.org>
In-Reply-To: <20180709135435.836-1-peter.maydell@linaro.org>
References: <20180709135435.836-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/11] hw/sd/omap_mmc: Split 'pseudo-reset' from
 'power-on-reset'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

DeviceClass::reset models a "cold power-on" reset which can
also be used to powercycle a device; but there is no "hot reset"
(a.k.a. soft-reset) method available.

The OMAP MMC Power-Up Control bit is not designed to powercycle
a card, but to disable it without powering it off (pseudo-reset):

  Multimedia Card (MMC/SD/SDIO) Interface [SPRU765A]

  MMC_CON[11] Power-Up Control (POW)
  This bit must be set to 1 before any valid transaction to either
  MMC/SD or SPI memory cards.
  When 1, the card is considered powered-up and the controller core
  is enabled.
  When 0, the card is considered powered-down (system dependent),
  and the controller core logic is in pseudo-reset state. This is,
  the MMC_STAT flags and the FIFO pointers are reset, any access to
  MMC_DATA[DATA] has no effect, a write into the MMC.CMD register
  is ignored, and a setting of MMC_SPI[STR] to 1 is ignored.

By splitting the 'pseudo-reset' code out of the 'power-on' reset
function, this patch fixes a latent bug in omap_mmc_write(MMC_CON)i
recently exposed by ecd219f7abb.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180706162155.8432-2-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/omap_mmc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 671264b6500..d0c98ca0214 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -1,6 +1,8 @@
 /*
  * OMAP on-chip MMC/SD host emulation.
  *
+ * Datasheet: TI Multimedia Card (MMC/SD/SDIO) Interface (SPRU765A)
+ *
  * Copyright (C) 2006-2007 Andrzej Zaborowski  <balrog@zabor.org>
  *
  * This program is free software; you can redistribute it and/or
@@ -278,6 +280,12 @@ static void omap_mmc_update(void *opaque)
     omap_mmc_interrupts_update(s);
 }
 
+static void omap_mmc_pseudo_reset(struct omap_mmc_s *host)
+{
+    host->status = 0;
+    host->fifo_len = 0;
+}
+
 void omap_mmc_reset(struct omap_mmc_s *host)
 {
     host->last_cmd = 0;
@@ -286,11 +294,9 @@ void omap_mmc_reset(struct omap_mmc_s *host)
     host->dw = 0;
     host->mode = 0;
     host->enable = 0;
-    host->status = 0;
     host->mask = 0;
     host->cto = 0;
     host->dto = 0;
-    host->fifo_len = 0;
     host->blen = 0;
     host->blen_counter = 0;
     host->nblk = 0;
@@ -305,6 +311,8 @@ void omap_mmc_reset(struct omap_mmc_s *host)
     qemu_set_irq(host->coverswitch, host->cdet_state);
     host->clkdiv = 0;
 
+    omap_mmc_pseudo_reset(host);
+
     /* Since we're still using the legacy SD API the card is not plugged
      * into any bus, and we must reset it manually. When omap_mmc is
      * QOMified this must move into the QOM reset function.
@@ -459,7 +467,7 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
         if (s->dw != 0 && s->lines < 4)
             printf("4-bit SD bus enabled\n");
         if (!s->enable)
-            omap_mmc_reset(s);
+            omap_mmc_pseudo_reset(s);
         break;
 
     case 0x10:	/* MMC_STAT */
-- 
2.17.1
