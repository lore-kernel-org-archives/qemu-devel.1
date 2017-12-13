Received: from eggs.gnu.org ([2001:4830:134:3::10]:39461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDu4-0004O8-Sd
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDu1-0006w0-PE
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:20 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:41843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDu1-0006ug-LG
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:17 -0500
Received: by mail-qk0-x241.google.com with SMTP id 84so3681921qks.8
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 12:45:17 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 17:44:32 -0300
Message-Id: <20171213204436.5379-8-f4bug@amsat.org>
In-Reply-To: <20171213204436.5379-1-f4bug@amsat.org>
References: <20171213204436.5379-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/11] sdbus: add a SD_BUS_SLAVE interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Clement Deschamps <clement.deschamps@antfield.fr>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

Devices implementing this interface can be (hot-)plugged to a SD bus.

The sdcard device is currently the unique implementation.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd-internal.h | 5 +++--
 hw/sd/core.c        | 7 +++++++
 hw/sd/sd.c          | 4 ++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd-internal.h b/hw/sd/sd-internal.h
index 85a747ea64..4576d2f8a8 100644
--- a/hw/sd/sd-internal.h
+++ b/hw/sd/sd-internal.h
@@ -66,10 +66,11 @@ typedef enum {
 
 typedef struct SDState SDState;
 
+#define TYPE_SD_BUS_SLAVE_INTERFACE     "sd-bus-slave"
 #define SDBUS_SLAVE_CLASS(klass) \
-    OBJECT_CLASS_CHECK(SDSlaveClass, (klass), TYPE_SD_CARD)
+    OBJECT_CLASS_CHECK(SDSlaveClass, (klass), TYPE_SD_BUS_SLAVE_INTERFACE)
 #define SDBUS_SLAVE_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(SDSlaveClass, (obj), TYPE_SD_CARD)
+    OBJECT_GET_CLASS(SDSlaveClass, (obj), TYPE_SD_BUS_SLAVE_INTERFACE)
 
 typedef struct {
     /*< private >*/
diff --git a/hw/sd/core.c b/hw/sd/core.c
index cd5b531cfa..dc1571befc 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -181,9 +181,16 @@ static const TypeInfo sd_bus_info = {
     .class_size = sizeof(SDBusClass),
 };
 
+static const TypeInfo sd_slave_info = {
+    .name = TYPE_SD_BUS_SLAVE_INTERFACE,
+    .parent = TYPE_INTERFACE,
+    .class_size = sizeof(SDBusClass),
+};
+
 static void sd_bus_register_types(void)
 {
     type_register_static(&sd_bus_info);
+    type_register_static(&sd_slave_info);
 }
 
 type_init(sd_bus_register_types)
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 97046df5c3..8e12b07ee4 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1942,6 +1942,10 @@ static const TypeInfo sd_info = {
     .class_init = sd_class_init,
     .instance_init = sd_instance_init,
     .instance_finalize = sd_instance_finalize,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_SD_BUS_SLAVE_INTERFACE },
+        { },
+    },
 };
 
 static void sd_register_types(void)
-- 
2.15.1
