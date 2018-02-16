Received: from eggs.gnu.org ([2001:4830:134:3::10]:60350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emVml-0005RW-Jf
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:30:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emVmk-0002Vq-Hy
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:30:03 -0500
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:35954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emVmk-0002Vg-DQ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:30:02 -0500
Received: by mail-ua0-x241.google.com with SMTP id i15so1108168uak.3
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 18:30:02 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 23:29:28 -0300
Message-Id: <20180216022933.10945-4-f4bug@amsat.org>
In-Reply-To: <20180216022933.10945-1-f4bug@amsat.org>
References: <20180216022933.10945-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 3/7] hw/sd/milkymist-memcard: expose a SDBus
 and connect the SDCard to it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrzej Zaborowski <balrogg@gmail.com>, Michael Walle <michael@walle.cc>, Stefan Weil <sw@weilnetz.de>

using the sdbus_*() API.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Acked-by: Michael Walle <michael@walle.cc>
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
