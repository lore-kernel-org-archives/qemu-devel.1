Received: from eggs.gnu.org ([2001:4830:134:3::10]:38341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiY-0004jf-E5
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiX-0001cX-8n
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:30 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosiX-0001bp-1a
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:29 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiW-000222-4D
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:28 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:43 +0000
Message-Id: <20180222152307.7499-9-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/32] hw/sd/ssi-sd: use the SDBus API,
 connect the SDCard to the bus
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

On reset the bus will reset the card,
we can now drop the device_reset() call.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180216022933.10945-5-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/ssi-sd.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index f88f509e0a..ae04b6641b 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -47,7 +47,7 @@ typedef struct {
     int32_t arglen;
     int32_t response_pos;
     int32_t stopping;
-    SDState *sd;
+    SDBus sdbus;
 } ssi_sd_state;
 
 #define TYPE_SSI_SD "ssi-sd"
@@ -100,7 +100,7 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32_t val)
             request.arg = (s->cmdarg[0] << 24) | (s->cmdarg[1] << 16)
                            | (s->cmdarg[2] << 8) | s->cmdarg[3];
             DPRINTF("CMD%d arg 0x%08x\n", s->cmd, request.arg);
-            s->arglen = sd_do_command(s->sd, &request, longresp);
+            s->arglen = sdbus_do_command(&s->sdbus, &request, longresp);
             if (s->arglen <= 0) {
                 s->arglen = 1;
                 s->response[0] = 4;
@@ -177,7 +177,7 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32_t val)
             DPRINTF("Response 0x%02x\n", s->response[s->response_pos]);
             return s->response[s->response_pos++];
         }
-        if (sd_data_ready(s->sd)) {
+        if (sdbus_data_ready(&s->sdbus)) {
             DPRINTF("Data read\n");
             s->mode = SSI_SD_DATA_START;
         } else {
@@ -190,8 +190,8 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32_t val)
         s->mode = SSI_SD_DATA_READ;
         return 0xfe;
     case SSI_SD_DATA_READ:
-        val = sd_read_data(s->sd);
-        if (!sd_data_ready(s->sd)) {
+        val = sdbus_read_data(&s->sdbus);
+        if (!sdbus_data_ready(&s->sdbus)) {
             DPRINTF("Data read end\n");
             s->mode = SSI_SD_CMD;
         }
@@ -242,13 +242,24 @@ static const VMStateDescription vmstate_ssi_sd = {
 static void ssi_sd_realize(SSISlave *d, Error **errp)
 {
     ssi_sd_state *s = FROM_SSI_SLAVE(ssi_sd_state, d);
+    DeviceState *carddev;
     DriveInfo *dinfo;
+    Error *err = NULL;
 
+    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS,
+                        DEVICE(d), "sd-bus");
+
+    /* Create and plug in the sd card */
     /* FIXME use a qdev drive property instead of drive_get_next() */
     dinfo = drive_get_next(IF_SD);
-    s->sd = sd_init(dinfo ? blk_by_legacy_dinfo(dinfo) : NULL, true);
-    if (s->sd == NULL) {
-        error_setg(errp, "Device initialization failed.");
+    carddev = qdev_create(&s->sdbus.qbus, TYPE_SD_CARD);
+    if (dinfo) {
+        qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinfo), &err);
+    }
+    object_property_set_bool(OBJECT(carddev), true, "spi", &err);
+    object_property_set_bool(OBJECT(carddev), true, "realized", &err);
+    if (err) {
+        error_setg(errp, "failed to init SD card: %s", error_get_pretty(err));
         return;
     }
 }
@@ -264,11 +275,6 @@ static void ssi_sd_reset(DeviceState *dev)
     s->arglen = 0;
     s->response_pos = 0;
     s->stopping = 0;
-
-    /* Since we're still using the legacy SD API the card is not plugged
-     * into any bus, and we must reset it manually.
-     */
-    device_reset(DEVICE(s->sd));
 }
 
 static void ssi_sd_class_init(ObjectClass *klass, void *data)
-- 
2.16.1
