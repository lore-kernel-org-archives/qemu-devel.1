Received: from eggs.gnu.org ([2001:4830:134:3::10]:44243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWlq3-0004As-Br
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 11:24:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWlq2-00053H-Ca
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 11:24:23 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 13:23:59 -0300
Message-Id: <20180103162400.10396-6-f4bug@amsat.org>
In-Reply-To: <20180103162400.10396-1-f4bug@amsat.org>
References: <20180103162400.10396-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/6] hw/sd/ssi-sd: expose a SDBus and connect
 the SDCard to it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

using the sdbus_*() API.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/ssi-sd.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 24001dc3e6..c8b27add84 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -47,7 +47,7 @@ typedef struct {
     int32_t arglen;
     int32_t response_pos;
     int32_t stopping;
-    SDState *sd;
+    SDBus sdbus;
 } ssi_sd_state;
 
 /* State word bits.  */
@@ -97,7 +97,7 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32_t val)
             request.arg = (s->cmdarg[0] << 24) | (s->cmdarg[1] << 16)
                            | (s->cmdarg[2] << 8) | s->cmdarg[3];
             DPRINTF("CMD%d arg 0x%08x\n", s->cmd, request.arg);
-            s->arglen = sd_do_command(s->sd, &request, longresp);
+            s->arglen = sdbus_do_command(&s->sdbus, &request, longresp);
             if (s->arglen <= 0) {
                 s->arglen = 1;
                 s->response[0] = 4;
@@ -174,7 +174,7 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32_t val)
             DPRINTF("Response 0x%02x\n", s->response[s->response_pos]);
             return s->response[s->response_pos++];
         }
-        if (sd_data_ready(s->sd)) {
+        if (sdbus_data_ready(&s->sdbus)) {
             DPRINTF("Data read\n");
             s->mode = SSI_SD_DATA_START;
         } else {
@@ -187,8 +187,8 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32_t val)
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
@@ -239,14 +239,25 @@ static const VMStateDescription vmstate_ssi_sd = {
 static void ssi_sd_realize(SSISlave *d, Error **errp)
 {
     ssi_sd_state *s = FROM_SSI_SLAVE(ssi_sd_state, d);
+    DeviceState *carddev;
     DriveInfo *dinfo;
+    Error *err = NULL;
 
     s->mode = SSI_SD_CMD;
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
-- 
2.15.1
