Received: from eggs.gnu.org ([2001:4830:134:3::10]:39491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDu8-0004RT-Ld
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDu7-00075j-Md
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:24 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:41845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDu7-000757-Ht
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:23 -0500
Received: by mail-qk0-x243.google.com with SMTP id 84so3682252qks.8
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 12:45:23 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 17:44:33 -0300
Message-Id: <20171213204436.5379-9-f4bug@amsat.org>
In-Reply-To: <20171213204436.5379-1-f4bug@amsat.org>
References: <20171213204436.5379-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 08/11] sdbus: add a SD_BUS_MASTER interface
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

Now than we have clearly separated the SD slave devices, let continue adding
the SD master interface, this will simplify the design.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd-internal.h | 3 +++
 hw/sd/core.c        | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/hw/sd/sd-internal.h b/hw/sd/sd-internal.h
index 4576d2f8a8..7f446b4e81 100644
--- a/hw/sd/sd-internal.h
+++ b/hw/sd/sd-internal.h
@@ -88,6 +88,9 @@ typedef struct {
 
 #define SD_BUS_CLASS(klass) OBJECT_CLASS_CHECK(SDBusClass, (klass), TYPE_SD_BUS)
 #define SD_BUS_GET_CLASS(obj) OBJECT_GET_CLASS(SDBusClass, (obj), TYPE_SD_BUS)
+#define TYPE_SD_BUS_MASTER_INTERFACE    "sd-bus-master"
+#define SDBUS_MASTER_CLASS(klass) \
+    OBJECT_CLASS_CHECK(SDBusClass, (klass), TYPE_SD_BUS_MASTER_INTERFACE)
 
 typedef struct {
     /*< private >*/
diff --git a/hw/sd/core.c b/hw/sd/core.c
index dc1571befc..da3a7e0efa 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -181,6 +181,12 @@ static const TypeInfo sd_bus_info = {
     .class_size = sizeof(SDBusClass),
 };
 
+static const TypeInfo sd_master_info = {
+    .name = TYPE_SD_BUS_MASTER_INTERFACE,
+    .parent = TYPE_INTERFACE,
+    .class_size = sizeof(SDBusClass),
+};
+
 static const TypeInfo sd_slave_info = {
     .name = TYPE_SD_BUS_SLAVE_INTERFACE,
     .parent = TYPE_INTERFACE,
@@ -190,6 +196,7 @@ static const TypeInfo sd_slave_info = {
 static void sd_bus_register_types(void)
 {
     type_register_static(&sd_bus_info);
+    type_register_static(&sd_master_info);
     type_register_static(&sd_slave_info);
 }
 
-- 
2.15.1
