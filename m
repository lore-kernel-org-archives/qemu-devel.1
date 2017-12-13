Received: from eggs.gnu.org ([2001:4830:134:3::10]:39428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDty-0004Fy-9v
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDtx-0006h1-6C
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:14 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:39656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDtx-0006gX-0T
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:13 -0500
Received: by mail-qk0-x241.google.com with SMTP id u184so3674532qkd.6
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 12:45:12 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 17:44:31 -0300
Message-Id: <20171213204436.5379-7-f4bug@amsat.org>
In-Reply-To: <20171213204436.5379-1-f4bug@amsat.org>
References: <20171213204436.5379-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/11] sdbus: rename SDCardClass -> SDSlaveClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Clement Deschamps <clement.deschamps@antfield.fr>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

By default a SD bus connect SD cards, however it may accept other SD devices
like a SDIO device. The current class is not restricted to a SD "Card" device.
To better reflect this is a SD bus slave, simply rename it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd-internal.h | 10 +++++-----
 hw/sd/core.c        | 16 ++++++++--------
 hw/sd/sd.c          |  4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/sd/sd-internal.h b/hw/sd/sd-internal.h
index afd5dbf194..85a747ea64 100644
--- a/hw/sd/sd-internal.h
+++ b/hw/sd/sd-internal.h
@@ -66,10 +66,10 @@ typedef enum {
 
 typedef struct SDState SDState;
 
-#define SD_CARD_CLASS(klass) \
-    OBJECT_CLASS_CHECK(SDCardClass, (klass), TYPE_SD_CARD)
-#define SD_CARD_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(SDCardClass, (obj), TYPE_SD_CARD)
+#define SDBUS_SLAVE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(SDSlaveClass, (klass), TYPE_SD_CARD)
+#define SDBUS_SLAVE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(SDSlaveClass, (obj), TYPE_SD_CARD)
 
 typedef struct {
     /*< private >*/
@@ -83,7 +83,7 @@ typedef struct {
     void (*enable)(SDState *sd, bool enable);
     bool (*get_inserted)(SDState *sd);
     bool (*get_readonly)(SDState *sd);
-} SDCardClass;
+} SDSlaveClass;
 
 #define SD_BUS_CLASS(klass) OBJECT_CLASS_CHECK(SDBusClass, (klass), TYPE_SD_BUS)
 #define SD_BUS_GET_CLASS(obj) OBJECT_GET_CLASS(SDBusClass, (obj), TYPE_SD_BUS)
diff --git a/hw/sd/core.c b/hw/sd/core.c
index fc9ccfedb2..cd5b531cfa 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -49,7 +49,7 @@ int sdbus_do_command(SDBus *sdbus, SDRequest *req, uint8_t *response)
 
     trace_sdbus_command(sdbus_name(sdbus), req->cmd, req->arg, req->crc);
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        SDSlaveClass *sc = SDBUS_SLAVE_GET_CLASS(card);
 
         sz = sc->do_command(card, req, response);
         hexbuf = qemu_hexbuf_strdup(response, sz, NULL, "resp: ");
@@ -67,7 +67,7 @@ void sdbus_write_data(SDBus *sdbus, uint8_t value)
 
     trace_sdbus_write(sdbus_name(sdbus), value);
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        SDSlaveClass *sc = SDBUS_SLAVE_GET_CLASS(card);
 
         sc->write_data(card, value);
     }
@@ -79,7 +79,7 @@ uint8_t sdbus_read_data(SDBus *sdbus)
     uint8_t value = 0;
 
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        SDSlaveClass *sc = SDBUS_SLAVE_GET_CLASS(card);
 
         value = sc->read_data(card);
     }
@@ -93,7 +93,7 @@ bool sdbus_data_ready(SDBus *sdbus)
     SDState *card = get_card(sdbus);
 
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        SDSlaveClass *sc = SDBUS_SLAVE_GET_CLASS(card);
 
         return sc->data_ready(card);
     }
@@ -106,7 +106,7 @@ bool sdbus_get_inserted(SDBus *sdbus)
     SDState *card = get_card(sdbus);
 
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        SDSlaveClass *sc = SDBUS_SLAVE_GET_CLASS(card);
 
         return sc->get_inserted(card);
     }
@@ -119,7 +119,7 @@ bool sdbus_get_readonly(SDBus *sdbus)
     SDState *card = get_card(sdbus);
 
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        SDSlaveClass *sc = SDBUS_SLAVE_GET_CLASS(card);
 
         return sc->get_readonly(card);
     }
@@ -150,7 +150,7 @@ void sdbus_set_readonly(SDBus *sdbus, bool readonly)
 void sdbus_reparent_card(SDBus *from, SDBus *to)
 {
     SDState *card = get_card(from);
-    SDCardClass *sc;
+    SDSlaveClass *sc;
     bool readonly;
 
     /* We directly reparent the card object rather than implementing this
@@ -165,7 +165,7 @@ void sdbus_reparent_card(SDBus *from, SDBus *to)
         return;
     }
 
-    sc = SD_CARD_GET_CLASS(card);
+    sc = SDBUS_SLAVE_GET_CLASS(card);
     readonly = sc->get_readonly(card);
 
     sdbus_set_inserted(from, false);
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9b7dee2ec4..97046df5c3 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1917,7 +1917,7 @@ static Property sd_properties[] = {
 static void sd_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SDCardClass *sc = SD_CARD_CLASS(klass);
+    SDSlaveClass *sc = SDBUS_SLAVE_CLASS(klass);
 
     dc->realize = sd_realize;
     dc->props = sd_properties;
@@ -1938,7 +1938,7 @@ static const TypeInfo sd_info = {
     .name = TYPE_SD_CARD,
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(SDState),
-    .class_size = sizeof(SDCardClass),
+    .class_size = sizeof(SDSlaveClass),
     .class_init = sd_class_init,
     .instance_init = sd_instance_init,
     .instance_finalize = sd_instance_finalize,
-- 
2.15.1
