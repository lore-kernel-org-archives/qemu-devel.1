Received: from eggs.gnu.org ([2001:4830:134:3::10]:37373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNu-0008Bh-Sa
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNr-0002mt-3A
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:38 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ebRNq-0002gG-Su
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:35 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNn-0002sT-Ou
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:34:31 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 13:34:03 +0000
Message-Id: <1516109659-1557-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
References: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/24] hw/sd/omap_mmc: Reset SD card on
 controller reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since omap_mmc is still using the legacy SD card API, the SD
card created by sd_init() is not plugged into any bus. This
means that the controller has to reset it manually.

Failing to do this mostly didn't affect the guest since the
guest typically does a programmed SD card reset as part of
its SD controller driver initialization, but would mean that
migration fails because it's only in sd_reset() that we
set up the wpgrps_size field.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1515506513-31961-5-git-send-email-peter.maydell@linaro.org
---
 hw/sd/omap_mmc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index e934cd3..5b47cad 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -305,6 +305,12 @@ void omap_mmc_reset(struct omap_mmc_s *host)
     host->cdet_enable = 0;
     qemu_set_irq(host->coverswitch, host->cdet_state);
     host->clkdiv = 0;
+
+    /* Since we're still using the legacy SD API the card is not plugged
+     * into any bus, and we must reset it manually. When omap_mmc is
+     * QOMified this must move into the QOM reset function.
+     */
+    device_reset(DEVICE(host->card));
 }
 
 static uint64_t omap_mmc_read(void *opaque, hwaddr offset,
@@ -587,8 +593,6 @@ struct omap_mmc_s *omap_mmc_init(hwaddr base,
     s->lines = 1;	/* TODO: needs to be settable per-board */
     s->rev = 1;
 
-    omap_mmc_reset(s);
-
     memory_region_init_io(&s->iomem, NULL, &omap_mmc_ops, s, "omap.mmc", 0x800);
     memory_region_add_subregion(sysmem, base, &s->iomem);
 
@@ -598,6 +602,8 @@ struct omap_mmc_s *omap_mmc_init(hwaddr base,
         exit(1);
     }
 
+    omap_mmc_reset(s);
+
     return s;
 }
 
@@ -613,8 +619,6 @@ struct omap_mmc_s *omap2_mmc_init(struct omap_target_agent_s *ta,
     s->lines = 4;
     s->rev = 2;
 
-    omap_mmc_reset(s);
-
     memory_region_init_io(&s->iomem, NULL, &omap_mmc_ops, s, "omap.mmc",
                           omap_l4_region_size(ta, 0));
     omap_l4_attach(ta, 0, &s->iomem);
@@ -628,6 +632,8 @@ struct omap_mmc_s *omap2_mmc_init(struct omap_target_agent_s *ta,
     s->cdet = qemu_allocate_irq(omap_mmc_cover_cb, s, 0);
     sd_set_cb(s->card, NULL, s->cdet);
 
+    omap_mmc_reset(s);
+
     return s;
 }
 
-- 
2.7.4
