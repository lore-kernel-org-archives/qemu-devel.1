Received: from eggs.gnu.org ([2001:4830:134:3::10]:59426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6a-0003Ng-6d
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6U-0007ai-HL
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:44 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6U-0007aR-D3
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:38 -0500
Received: by mail-qt0-x243.google.com with SMTP id k19so18149100qtj.6
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 05:16:38 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 16 Jan 2018 10:15:51 -0300
Message-Id: <20180116131555.14242-8-f4bug@amsat.org>
In-Reply-To: <20180116131555.14242-1-f4bug@amsat.org>
References: <20180116131555.14242-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/11] qdev: simplify the
 SysBusDeviceClass::init path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

The SysBusDevice is the last DeviceClass::init user.

Instead of using
  SysBusDeviceClass::realize
   -> DeviceClass::realize
       -> DeviceClass::init
           -> sysbus_device_init
              -> SysBusDeviceClass::init

Simplify the path by directly calling SysBusDeviceClass::init
in SysBusDeviceClass::realize:

  SysBusDeviceClass::realize
   -> SysBusDeviceClass::init

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/qdev.c   |  9 ---------
 hw/core/sysbus.c | 21 +++++++++------------
 2 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 11112951a5..a4f76c8f5d 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -221,15 +221,6 @@ void device_listener_unregister(DeviceListener *listener)
 
 static void device_realize(DeviceState *dev, Error **errp)
 {
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
-
-    if (dc->init) {
-        int rc = dc->init(dev);
-        if (rc < 0) {
-            error_setg(errp, "Device initialization failed.");
-            return;
-        }
-    }
 }
 
 static void device_unrealize(DeviceState *dev, Error **errp)
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 04d6061f76..9edf43bc27 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "monitor/monitor.h"
 #include "exec/address-spaces.h"
@@ -200,22 +201,19 @@ void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size)
     }
 }
 
-/* TODO remove, once users are converted to realize */
-static int sysbus_device_init(DeviceState *dev)
+static void sysbus_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sd = SYS_BUS_DEVICE(dev);
     SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(sd);
 
-    if (!sbc->init) {
-        return 0;
+    /* TODO remove, once users are converted to realize */
+    if (sbc->init) {
+        int rc = sbc->init(sd);
+        if (rc < 0) {
+            error_setg(errp, "Device initialization failed.");
+            return;
+        }
     }
-    return sbc->init(sd);
-}
-
-static void sysbus_realize(DeviceState *dev, Error **errp)
-{
-    SysBusDevice *sd = SYS_BUS_DEVICE(dev);
-    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(sd);
 
     if (sbc->realize) {
         sbc->realize(sd, errp);
@@ -345,7 +343,6 @@ MemoryRegion *sysbus_address_space(SysBusDevice *dev)
 static void sysbus_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
-    k->init = sysbus_device_init;
     k->realize = sysbus_realize;
     k->unrealize = sysbus_unrealize;
     k->bus_type = TYPE_SYSTEM_BUS;
-- 
2.15.1
