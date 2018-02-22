Received: from eggs.gnu.org ([2001:4830:134:3::10]:38315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiX-0004ip-B0
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiW-0001bk-9L
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:29 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosiW-0001b9-1x
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:28 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiV-00021n-4o
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:27 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:42 +0000
Message-Id: <20180222152307.7499-8-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/32] hw/sd/milkymist-memcard: expose a SDBus
 and connect the SDCard to it
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

using the sdbus_*() API.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Acked-by: Michael Walle <michael@walle.cc>
Message-id: 20180216022933.10945-4-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/milkymist-memcard.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index a8e65892c7..5570c1e9a0 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -69,7 +69,7 @@ struct MilkymistMemcardState {
     SysBusDevice parent_obj;
 
     MemoryRegion regs_region;
-    SDState *card;
+    SDBus sdbus;
 
     int command_write_ptr;
     int response_read_ptr;
@@ -105,7 +105,7 @@ static void memcard_sd_command(MilkymistMemcardState *s)
     req.crc = s->command[5];
 
     s->response[0] = req.cmd;
-    s->response_len = sd_do_command(s->card, &req, s->response+1);
+    s->response_len = sdbus_do_command(&s->sdbus, &req, s->response + 1);
     s->response_read_ptr = 0;
 
     if (s->response_len == 16) {
@@ -150,10 +150,10 @@ static uint64_t memcard_read(void *opaque, hwaddr addr,
             r = 0xffffffff;
         } else {
             r = 0;
-            r |= sd_read_data(s->card) << 24;
-            r |= sd_read_data(s->card) << 16;
-            r |= sd_read_data(s->card) << 8;
-            r |= sd_read_data(s->card);
+            r |= sdbus_read_data(&s->sdbus) << 24;
+            r |= sdbus_read_data(&s->sdbus) << 16;
+            r |= sdbus_read_data(&s->sdbus) << 8;
+            r |= sdbus_read_data(&s->sdbus);
         }
         break;
     case R_CLK2XDIV:
@@ -207,10 +207,10 @@ static void memcard_write(void *opaque, hwaddr addr, uint64_t value,
         if (!s->enabled) {
             break;
         }
-        sd_write_data(s->card, (value >> 24) & 0xff);
-        sd_write_data(s->card, (value >> 16) & 0xff);
-        sd_write_data(s->card, (value >> 8) & 0xff);
-        sd_write_data(s->card, value & 0xff);
+        sdbus_write_data(&s->sdbus, (value >> 24) & 0xff);
+        sdbus_write_data(&s->sdbus, (value >> 16) & 0xff);
+        sdbus_write_data(&s->sdbus, (value >> 8) & 0xff);
+        sdbus_write_data(&s->sdbus, value & 0xff);
         break;
     case R_ENABLE:
         s->regs[addr] = value;
@@ -251,10 +251,6 @@ static void milkymist_memcard_reset(DeviceState *d)
     for (i = 0; i < R_MAX; i++) {
         s->regs[i] = 0;
     }
-    /* Since we're still using the legacy SD API the card is not plugged
-     * into any bus, and we must reset it manually.
-     */
-    device_reset(DEVICE(s->card));
 }
 
 static void milkymist_memcard_init(Object *obj)
@@ -270,15 +266,23 @@ static void milkymist_memcard_init(Object *obj)
 static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
 {
     MilkymistMemcardState *s = MILKYMIST_MEMCARD(dev);
+    DeviceState *carddev;
     BlockBackend *blk;
     DriveInfo *dinfo;
+    Error *err = NULL;
 
+    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS,
+                        dev, "sd-bus");
+
+    /* Create and plug in the sd card */
     /* FIXME use a qdev drive property instead of drive_get_next() */
     dinfo = drive_get_next(IF_SD);
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
-    s->card = sd_init(blk, false);
-    if (s->card == NULL) {
-        error_setg(errp, "failed to init SD card");
+    carddev = qdev_create(&s->sdbus.qbus, TYPE_SD_CARD);
+    qdev_prop_set_drive(carddev, "drive", blk, &err);
+    object_property_set_bool(OBJECT(carddev), true, "realized", &err);
+    if (err) {
+        error_setg(errp, "failed to init SD card: %s", error_get_pretty(err));
         return;
     }
     s->enabled = blk && blk_is_inserted(blk);
-- 
2.16.1
