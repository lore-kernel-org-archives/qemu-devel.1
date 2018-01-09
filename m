Received: from eggs.gnu.org ([2001:4830:134:3::10]:34451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eYuTh-0007AQ-6a
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eYuTb-00019O-LD
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:02:09 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  9 Jan 2018 14:01:52 +0000
Message-Id: <1515506513-31961-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515506513-31961-1-git-send-email-peter.maydell@linaro.org>
References: <1515506513-31961-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/4] hw/sd/ssi-sd: Reset SD card on controller
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, qemu-stable@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

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
---
 hw/sd/ssi-sd.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 24001dc..30d2a87 100644
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
@@ -251,6 +254,24 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
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
@@ -260,10 +281,11 @@ static void ssi_sd_class_init(ObjectClass *klass, void *data)
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
