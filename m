Received: from eggs.gnu.org ([2001:4830:134:3::10]:37400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNv-0008Ch-Vv
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNs-0002nn-0i
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:40 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ebRNr-0002gG-Pj
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:35 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNn-0002s2-1y
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:34:31 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 13:34:02 +0000
Message-Id: <1516109659-1557-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
References: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/24] hw/sd/ssi-sd: Reset SD card on controller
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since ssi-sd is still using the legacy SD card API, the SD
card created by sd_init() is not plugged into any bus. This
means that the controller has to reset it manually.

Failing to do this mostly didn't affect the guest since the
guest typically does a programmed SD card reset as part of
its SD controller driver initialization, but meant that
migration failed because it's only in sd_reset() that we
set up the wpgrps_size field.

In the case of sd-ssi, we have to implement an entire
reset function since there wasn't one previously, and
that requires a QOM cast macro that got omitted when this
device was QOMified.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1515506513-31961-4-git-send-email-peter.maydell@linaro.org
---
 hw/sd/ssi-sd.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 24001dc..f88f509 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -50,6 +50,9 @@ typedef struct {
     SDState *sd;
 } ssi_sd_state;
 
+#define TYPE_SSI_SD "ssi-sd"
+#define SSI_SD(obj) OBJECT_CHECK(ssi_sd_state, (obj), TYPE_SSI_SD)
+
 /* State word bits.  */
 #define SSI_SDR_LOCKED          0x0001
 #define SSI_SDR_WP_ERASE        0x0002
@@ -241,7 +244,6 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
     ssi_sd_state *s = FROM_SSI_SLAVE(ssi_sd_state, d);
     DriveInfo *dinfo;
 
-    s->mode = SSI_SD_CMD;
     /* FIXME use a qdev drive property instead of drive_get_next() */
     dinfo = drive_get_next(IF_SD);
     s->sd = sd_init(dinfo ? blk_by_legacy_dinfo(dinfo) : NULL, true);
@@ -251,6 +253,24 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
     }
 }
 
+static void ssi_sd_reset(DeviceState *dev)
+{
+    ssi_sd_state *s = SSI_SD(dev);
+
+    s->mode = SSI_SD_CMD;
+    s->cmd = 0;
+    memset(s->cmdarg, 0, sizeof(s->cmdarg));
+    memset(s->response, 0, sizeof(s->response));
+    s->arglen = 0;
+    s->response_pos = 0;
+    s->stopping = 0;
+
+    /* Since we're still using the legacy SD API the card is not plugged
+     * into any bus, and we must reset it manually.
+     */
+    device_reset(DEVICE(s->sd));
+}
+
 static void ssi_sd_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -260,10 +280,11 @@ static void ssi_sd_class_init(ObjectClass *klass, void *data)
     k->transfer = ssi_sd_transfer;
     k->cs_polarity = SSI_CS_LOW;
     dc->vmsd = &vmstate_ssi_sd;
+    dc->reset = ssi_sd_reset;
 }
 
 static const TypeInfo ssi_sd_info = {
-    .name          = "ssi-sd",
+    .name          = TYPE_SSI_SD,
     .parent        = TYPE_SSI_SLAVE,
     .instance_size = sizeof(ssi_sd_state),
     .class_init    = ssi_sd_class_init,
-- 
2.7.4
