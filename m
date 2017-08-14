Received: from eggs.gnu.org ([2001:4830:134:3::10]:43220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNOf-0002eD-SP
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNOc-00030H-0l
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:59:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dhNOb-0002zy-Of
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:59:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8DE025A7A4
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 21:59:36 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 14 Aug 2017 18:57:47 -0300
Message-Id: <20170814215748.5158-13-ehabkost@redhat.com>
In-Reply-To: <20170814215748.5158-1-ehabkost@redhat.com>
References: <20170814215748.5158-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v4 12/13] usb: enumerate_slots implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>

Example output for QEMU command-line:

  $ qemu-system-x86_64 -machine q35,usb=on -S \
    -device usb-hub,port=2 -device usb-tablet,port=2.4

Output:

  {"available":true,"count":12,
   "device-types":["usb-device"],"hotpluggable":true,
   "opts":[
     {"option":"port","values":["1","3","4","5","6","2.1","2.2","2.3","2.5","2.6","2.7","2.8"]},
     {"option":"bus","values":"usb-bus.0"}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/peripheral-anon/device[1]",
   "device-types":["usb-device"],"hotpluggable":true,
   "opts":[{"option":"port","values":"2"},{"option":"bus","values":"usb-bus.0"}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/peripheral-anon/device[2]",
   "device-types":["usb-device"],"hotpluggable":true,
   "opts":[{"option":"port","values":"2.4"},{"option":"bus","values":"usb-bus.0"}],
   "opts-complete":true}

TODO: Introduce USBPortList typedef in a separate patch

TODO: decide if "bus" should be included in the output, or we
should make "port" the only parameter required to identify where
the device will be plugged.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/usb.h |  6 ++++--
 hw/usb/bus.c     | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/hw/usb.h b/include/hw/usb.h
index eb28655..f8119c9 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -509,14 +509,16 @@ void musb_set_size(MUSBState *s, int epnum, int size, int is_tx);
 #define TYPE_USB_BUS "usb-bus"
 #define USB_BUS(obj) OBJECT_CHECK(USBBus, (obj), TYPE_USB_BUS)
 
+typedef QTAILQ_HEAD(, USBPort) USBPortList;
+
 struct USBBus {
     BusState qbus;
     USBBusOps *ops;
     int busnr;
     int nfree;
     int nused;
-    QTAILQ_HEAD(, USBPort) free;
-    QTAILQ_HEAD(, USBPort) used;
+    USBPortList free;
+    USBPortList used;
     QTAILQ_ENTRY(USBBus) next;
 };
 
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 42f85a7..fd00269 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -2,6 +2,7 @@
 #include "hw/hw.h"
 #include "hw/usb.h"
 #include "hw/qdev.h"
+#include "hw/qdev-slotinfo.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
@@ -25,6 +26,40 @@ static Property usb_props[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
+static void usb_bus_enumerate_slot_list(DeviceSlotInfoList **r, USBBus *bus, USBPortList *l)
+{
+    USBPort *port;
+
+    QTAILQ_FOREACH(port, l, next) {
+        DeviceSlotInfo *slot = make_slot(BUS(bus));
+        /*
+         * TODO: should the "bus" option be included, or is
+         * "port" enough to identify the USB bus + port?
+         */
+        slot_add_opt_str(slot, "port", port->path);
+        slot->opts_complete = slot;
+        if (port->dev) {
+            slot->has_device = true;
+            slot->device = object_get_canonical_path(OBJECT(port->dev));
+            slot->available = false;
+        }
+        slot->has_count = 1;
+        slot->count = 1;
+
+        slot_list_add_slot(r, slot);
+    }
+}
+
+static DeviceSlotInfoList *usb_bus_enumerate_slots(BusState *bus)
+{
+    USBBus *ub = USB_BUS(bus);
+    DeviceSlotInfoList *r = NULL;
+
+    usb_bus_enumerate_slot_list(&r, ub, &ub->free);
+    usb_bus_enumerate_slot_list(&r, ub, &ub->used);
+    return r;
+}
+
 static void usb_bus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k = BUS_CLASS(klass);
@@ -34,6 +69,7 @@ static void usb_bus_class_init(ObjectClass *klass, void *data)
     k->get_dev_path = usb_get_dev_path;
     k->get_fw_dev_path = usb_get_fw_dev_path;
     k->device_type = TYPE_USB_DEVICE;
+    k->enumerate_slots = usb_bus_enumerate_slots;
     hc->unplug = qdev_simple_device_unplug_cb;
 }
 
-- 
2.9.4
