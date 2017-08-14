Received: from eggs.gnu.org ([2001:4830:134:3::10]:43011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNO0-00026q-6c
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNNw-0002f4-7F
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:59:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56367)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dhNNv-0002eK-U8
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:58:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D171625A7A1
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 21:58:54 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 14 Aug 2017 18:57:41 -0300
Message-Id: <20170814215748.5158-7-ehabkost@redhat.com>
In-Reply-To: <20170814215748.5158-1-ehabkost@redhat.com>
References: <20170814215748.5158-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v4 06/13] qdev core: generic enumerate_slots
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>

Implement a generic enumerate_slots method on TYPE_BUS
The generic implementation will just report a opts-complete=false
entry, listing the "bus" option.  This will let clients know that
the bus is available, but that detailed slot information is not
available by the running QEMU version.

We disable the implementation on TYPE_SYS_BUS as sysbus is an
exceptional case where only a handful of device types are
actually user-creatable.  This will be handled later by
sysbus-specific slot enumeration code.

TODO: write sysbus-specific slot enumeration code, based on
sysbus device whitelist.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/bus.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/core/sysbus.c |  7 +++++++
 2 files changed, 49 insertions(+)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index 4651f24..227c092 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "hw/qdev.h"
+#include "hw/qdev-slotinfo.h"
 #include "qapi/error.h"
 
 static void qbus_set_hotplug_handler_internal(BusState *bus, Object *handler,
@@ -208,12 +209,53 @@ static char *default_bus_get_fw_dev_path(DeviceState *dev)
     return g_strdup(object_get_typename(OBJECT(dev)));
 }
 
+static void class_check_user_creatable(ObjectClass *oc, void *opaque)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    bool *r = opaque;
+
+    if (dc->user_creatable) {
+        *r = true;
+    }
+}
+
+static bool bus_class_is_user_pluggable(BusClass *bc)
+{
+    bool r = false;
+
+    object_class_foreach(class_check_user_creatable,
+                         bc->device_type, false, &r);
+    return r;
+}
+
+static DeviceSlotInfoList *bus_generic_enumerate_slots(BusState *bus)
+{
+    DeviceSlotInfoList *r = NULL;
+    BusChild *kid = NULL;
+
+    if (!bus_class_is_user_pluggable(BUS_GET_CLASS(bus))) {
+        return NULL;
+    }
+
+    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+        DeviceSlotInfo *slot = make_slot(bus);
+        slot->available = false;
+        slot->has_device = true;
+        slot->device = object_get_canonical_path(OBJECT(kid->child));
+        slot_list_add_slot(&r, slot);
+    }
+
+    slot_list_add_slot(&r, make_slot(bus));
+    return r;
+}
+
 static void bus_class_init(ObjectClass *class, void *data)
 {
     BusClass *bc = BUS_CLASS(class);
 
     class->unparent = bus_unparent;
     bc->get_fw_dev_path = default_bus_get_fw_dev_path;
+    bc->enumerate_slots = bus_generic_enumerate_slots;
 }
 
 static void qbus_finalize(Object *obj)
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 9259931..06cb4d8 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -77,6 +77,13 @@ static void system_bus_class_init(ObjectClass *klass, void *data)
     k->print_dev = sysbus_dev_print;
     k->get_fw_dev_path = sysbus_get_fw_dev_path;
     k->device_type = TYPE_SYS_BUS_DEVICE;
+    /*
+     * We won't return sysbus devices on query-device-slots by now.
+     *
+     * TODO: return user-creatable whitelisted sybus devices
+     * if the machine supports dynamic sysbus devices.
+     */
+    k->enumerate_slots = NULL;
 }
 
 static const TypeInfo system_bus_info = {
-- 
2.9.4
