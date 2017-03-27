Received: from eggs.gnu.org ([2001:4830:134:3::10]:41317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tejaswinipoluri3@gmail.com>) id 1csRvw-0007FC-DG
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 06:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tejaswinipoluri3@gmail.com>) id 1csRvt-0007mW-HI
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 06:31:32 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tejaswinipoluri3@gmail.com>)
	id 1csRvt-0007mH-BR
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 06:31:29 -0400
Received: by mail-pg0-x242.google.com with SMTP id o123so8995036pga.1
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 03:31:29 -0700 (PDT)
From: Tejaswini <tejaswinipoluri3@gmail.com>
Date: Mon, 27 Mar 2017 16:01:02 +0530
Message-Id: <1490610662-5483-1-git-send-email-tejaswinipoluri3@gmail.com>
Subject: [Qemu-devel] [[RFC]PATCH:hw/sd:sd_init()] hw/sd : modified the
 sd_init() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, Tejaswini Poluri <tejaswinipoluri3@gmail.com>

From: Tejaswini Poluri <tejaswinipoluri3@gmail.com>

Changed sd_init() to take SDstate by value and return state as success/failure
Edited the rest of the functions using sd_init() to accommodate the change

Signed-off-by: Tejaswini Poluri <tejaswinipoluri3@gmail.com>
---
 hw/sd/milkymist-memcard.c |  3 +--
 hw/sd/omap_mmc.c          |  6 ++----
 hw/sd/pl181.c             |  4 ++--
 hw/sd/sd.c                | 13 ++++++++-----
 hw/sd/ssi-sd.c            |  3 +--
 include/hw/sd/sd.h        |  2 +-
 6 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 1f2f0ed..68e50e5 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -259,8 +259,7 @@ static int milkymist_memcard_init(SysBusDevice *dev)
     /* FIXME use a qdev drive property instead of drive_get_next() */
     dinfo = drive_get_next(IF_SD);
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
-    s->card = sd_init(blk, false);
-    if (s->card == NULL) {
+    if (sd_init(s->card, blk, false) < 0) {
         return -1;
     }
 
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index e934cd3..add48a6 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -593,8 +593,7 @@ struct omap_mmc_s *omap_mmc_init(hwaddr base,
     memory_region_add_subregion(sysmem, base, &s->iomem);
 
     /* Instantiate the storage */
-    s->card = sd_init(blk, false);
-    if (s->card == NULL) {
+    if (sd_init(s->card, blk, false) < 0) {
         exit(1);
     }
 
@@ -620,8 +619,7 @@ struct omap_mmc_s *omap2_mmc_init(struct omap_target_agent_s *ta,
     omap_l4_attach(ta, 0, &s->iomem);
 
     /* Instantiate the storage */
-    s->card = sd_init(blk, false);
-    if (s->card == NULL) {
+    if (sd_init(s->card, blk, false) < 0) {
         exit(1);
     }
 
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 82c63a4..c2e2459 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -502,8 +502,8 @@ static void pl181_realize(DeviceState *dev, Error **errp)
 
     /* FIXME use a qdev drive property instead of drive_get_next() */
     dinfo = drive_get_next(IF_SD);
-    s->card = sd_init(dinfo ? blk_by_legacy_dinfo(dinfo) : NULL, false);
-    if (s->card == NULL) {
+    if (sd_init(s->card, dinfo ?
+		blk_by_legacy_dinfo(dinfo) : NULL, false) < 0) {
         error_setg(errp, "sd_init failed");
     }
 }
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ba47bff..b593939 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -562,7 +562,7 @@ static const VMStateDescription sd_vmstate = {
 };
 
 /* Legacy initialization function for use by non-qdevified callers */
-SDState *sd_init(BlockBackend *blk, bool is_spi)
+int sd_init(SDState *sd_state, BlockBackend *blk, bool is_spi)
 {
     Object *obj;
     DeviceState *dev;
@@ -573,16 +573,19 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
     qdev_prop_set_drive(dev, "drive", blk, &err);
     if (err) {
         error_report("sd_init failed: %s", error_get_pretty(err));
-        return NULL;
+        return -1;
     }
     qdev_prop_set_bit(dev, "spi", is_spi);
     object_property_set_bool(obj, true, "realized", &err);
     if (err) {
         error_report("sd_init failed: %s", error_get_pretty(err));
-        return NULL;
+        return -1;
     }
-
-    return SD_CARD(dev);
+    sd_state = SD_CARD(dev);
+    if (!sd_state) {
+		return -1;
+	}
+    return 0;
 }
 
 void sd_set_cb(SDState *sd, qemu_irq readonly, qemu_irq insert)
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 24001dc..c70b32d 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -244,8 +244,7 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
     s->mode = SSI_SD_CMD;
     /* FIXME use a qdev drive property instead of drive_get_next() */
     dinfo = drive_get_next(IF_SD);
-    s->sd = sd_init(dinfo ? blk_by_legacy_dinfo(dinfo) : NULL, true);
-    if (s->sd == NULL) {
+    if (sd_init(s->sd, dinfo ? blk_by_legacy_dinfo(dinfo) : NULL, true) < 0) {
         error_setg(errp, "Device initialization failed.");
         return;
     }
diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 96caefe..63741c0 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -115,7 +115,7 @@ typedef struct {
 } SDBusClass;
 
 /* Legacy functions to be used only by non-qdevified callers */
-SDState *sd_init(BlockBackend *bs, bool is_spi);
+int sd_init(SDState *sd, BlockBackend *bs, bool is_spi);
 int sd_do_command(SDState *sd, SDRequest *req,
                   uint8_t *response);
 void sd_write_data(SDState *sd, uint8_t value);
-- 
2.7.4
