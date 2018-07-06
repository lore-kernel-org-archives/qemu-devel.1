Received: from eggs.gnu.org ([2001:4830:134:3::10]:39502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fbTUl-0006lz-4y
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fbTUj-00073m-VX
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:22:07 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Jul 2018 13:21:55 -0300
Message-Id: <20180706162155.8432-2-f4bug@amsat.org>
In-Reply-To: <20180706162155.8432-1-f4bug@amsat.org>
References: <20180706162155.8432-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.0 1/1] hw/sd/omap_mmc: Split
 'pseudo-reset' from 'power-on-reset'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

DeviceClass::reset models a "cold power-on" reset which can
also be use to powercycle a device; but there is no "hot reset"
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

By spliting the 'pseudo-reset' code out of the 'power-on' reset
function, this patch fixes a latent bug in omap_mmc_write(MMC_CON)i
recently exposed by ecd219f7abb.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
---
 hw/sd/omap_mmc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 671264b650..d0c98ca021 100644
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
2.18.0
