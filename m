Received: from eggs.gnu.org ([2001:4830:134:3::10]:43153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNOL-0002P6-S4
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNOL-0002tJ-10
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:59:21 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 14 Aug 2017 18:57:43 -0300
Message-Id: <20170814215748.5158-9-ehabkost@redhat.com>
In-Reply-To: <20170814215748.5158-1-ehabkost@redhat.com>
References: <20170814215748.5158-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v4 08/13] ide: enumerate_slots implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org

Example output when using "-machine q35":

  {
    "available": true,
    "count": 1,
    "device-types": [
      "ide-device"
    ],
    "hotpluggable": false,
    "opts": [
      { "option": "unit", "values": 0 },
      { "option": "bus", "values": "ide.2" }
    ],
    "opts-complete": true
  }
  {
    "available": false,
    "count": 1,
    "device": "/machine/unattached/device[19]",
    "device-types": [
      "ide-device"
    ],
    "hotpluggable": false,
    "opts": [
      { "option": "unit", "values": 1 },
      { "option": "bus", "values": "ide.2" } ],
    "opts-complete": true
  }
  {
    "available": true,
    "count": 10,
    "device-types": [
      "ide-device"
    ],
    "hotpluggable": false,
    "opts": [
      { "option": "unit", "values": [ [ 0, 1 ] ] },
      { "option": "bus", "values": [ "ide.4", "ide.3", "ide.5", "ide.0", "ide.1" ] }
    ],
    "opts-complete": true
  }

Cc: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/ide/qdev.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index f17da1f..cc96f6f 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -25,6 +25,7 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "hw/block/block.h"
+#include "hw/qdev-slotinfo.h"
 #include "sysemu/sysemu.h"
 #include "qapi/visitor.h"
 
@@ -38,6 +39,30 @@ static Property ide_props[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static DeviceSlotInfoList *ide_bus_enumerate_slots(BusState *bus)
+{
+    int unit;
+    DeviceSlotInfoList *r = NULL;
+    IDEBus *ib = IDE_BUS(bus);
+
+    for (unit = 0; unit < 2; unit++) {
+        DeviceSlotInfo *s = make_slot(bus);
+        IDEDevice *dev = (unit ? ib->master : ib->slave);
+        slot_add_opt_int(s, "unit", unit);
+        s->opts_complete = true;
+        s->has_count = true;
+        s->count = 1;
+        if (dev) {
+            s->available = false;
+            s->has_device = true;
+            s->device = object_get_canonical_path(OBJECT(dev));
+        }
+        slot_list_add_slot(&r, s);
+    }
+
+    return r;
+}
+
 static void ide_bus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k = BUS_CLASS(klass);
@@ -45,6 +70,7 @@ static void ide_bus_class_init(ObjectClass *klass, void *data)
     k->get_fw_dev_path = idebus_get_fw_dev_path;
     k->unrealize = idebus_unrealize;
     k->device_type = TYPE_IDE_DEVICE;
+    k->enumerate_slots = ide_bus_enumerate_slots;
 }
 
 static void idebus_unrealize(BusState *bus, Error **errp)
-- 
2.9.4
