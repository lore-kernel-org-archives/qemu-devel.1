Received: from eggs.gnu.org ([2001:4830:134:3::10]:42762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNNI-0001WN-Pu
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNNE-0002GR-RC
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:58:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dhNNE-0002G0-Ih
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:58:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74B4577916
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 21:58:11 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 14 Aug 2017 18:57:36 -0300
Message-Id: <20170814215748.5158-2-ehabkost@redhat.com>
In-Reply-To: <20170814215748.5158-1-ehabkost@redhat.com>
References: <20170814215748.5158-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v4 01/13] qmp: Define query-device-slots command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>
Cc: libvir-list@redhat.com, Igor Mammedov <imammedo@redhat.com>

This adds a new command to QMP: query-device-slots. It will allow
management software to query possible slots where devices can be
plugged.

Slot sets are represented by a list of option names and sets of
possible values for each of those options.  We use a compact
format for set of valid values, to keep JSON response size
reasonable.  The format is documented at the SlotOption struct.

In the future, we may use QAPI alternates to define and document
the exact data format more strictly.

Actual implementations of BusClass::enumerate_slots will be added
by other patches.

Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: libvir-list@redhat.com,
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Laine Stump <laine@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v3 -> v4:
* Use a more compact format for the "slot sets"
* Renamed DeviceSlotInfo.props to DeviceSlotInfo.opts
* Replaced DeviceSlotInfo.incomplete with
  DeviceSlotInfo.opts-complete
* Now DeviceSlotInfo.available will be true even if hotplug is
  unavailable, to indicate the slot would be available using
  -device.

Changes v2 -> v3:
* Implemented a "slot set" structure, where multiple slots can be
  reported by using integer ranges or lists for possible
  values for each property. Added a ValueSet struct, that
  can represent a set of values using either a simple list of
  values, or integer ranges. (Its JSON representation is very
  verbose, though. See comments below).
* Removed the *Properties structs, and replaced them with
  a simple list of SlotOption structs.
* DeviceSlotInfo is not an union anymore, removed the 'type'
  field only because there are no slot-type-specific fields in
  the current implementation, but we may add it back if necessary
* The implementation is very quick and dirty, the main purpose of
  this RFC is to evaluate the schema and returned data.

Changes v1 -> v2:
* Don't show sysbus unless has_dynamic_sysbus is set for the
  machine type
* Removed max-devices and devices properties
* Introduced "non-slot" slot type, to explicitly indicate
  we are returning info on a bus that doesn't implement slot
  enumeration yet.
* Return bus name instead of full QOM path on "bus" field
* PCI: Replaced "addr" property (string parsed by property
  setter) with "device-number" uint32 property
* PCI: return only one slot for PCIe ports
---
 qapi-schema.json       | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/qdev-core.h |  2 ++
 qdev-monitor.c         | 38 +++++++++++++++++++++
 3 files changed, 129 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index 802ea53..6a9329e 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4325,6 +4325,95 @@
 ##
 { 'command': 'closefd', 'data': {'fdname': 'str'} }
 
+
+##
+# @SlotOption:
+#
+# A option to be used when plugging a device to a slot.
+#
+# @option: Option name.
+#
+# @values: Set of valid option values.
+#
+# @values follow a compact format to represent a set of values:
+# - If @values is a string, bool, or number, it representes a
+#   single-element set containing that value.  In other words,
+#   @values is the only valid value for the option.
+# - If @values is a list, each element E on the list represents
+#   one or more possible values for the option:
+#   - If E is a string, bool, or number, it indicates that E
+#     is a valid value for the option.
+#   - If E is a one-element list [V], it means V is a valid value
+#     for the option.
+#   - If E is a two-element list [A, B] where A and B are
+#     numbers, it means any number X, A <= X <= B is a valid
+#     value for the option.
+#
+# TODO: @values could be represented by nested 'alternate' types,
+#      for more consistent documentation and automatic
+#      validation/parsing, but the following limitations on
+#      alternates prevent that today:
+#      - alternate branches can't be lists
+#      - alternate string members conflict with scalar values
+#      - alternate types should have 2 or more branches
+##
+{ 'struct': 'SlotOption',
+  'data': { 'option': 'str', 'values': 'any' } }
+
+##
+# @DeviceSlotInfo:
+#
+# Information on a set of slots where devices can be plugged.
+#
+# @device-types: List of device types accepted by the slots.
+#                Any device plugged to the slot should implement
+#                one of the accepted device types.
+#
+# @device: QOM path of device plugged to the slot, if any.
+#
+# @available: If false, the slot is not available for plugging any device.
+#             This value can change at runtime if condition changes.
+#
+# @hotpluggable: If true, the slot accepts hotplugged devices.  If false,
+#                device_add won't work on the slot even if @available=true.
+#
+# @count: Number of slots represented by this slot set.
+#
+# @opts-complete: If true, all options required to plug devices
+#                 to slots in this set are present in @opts.  If
+#                 false, slot information is incomplete in this
+#                 QEMU version and additional options may be
+#                 required to plug devices on those slots.
+#
+# @opts: Information on the arguments that should be provided to
+#        @device_add if plugging a device to this slot.
+#
+# Incomplete Slot Sets
+# --------------------
+#
+# Slot sets with @opts-complete=false represent a bus that
+# doesn't support slot enumeration yet. Slots of this type should
+# be replaced by more detailed slot sets in future QEMU versions.
+#
+# If @count is omitted, the entry may or may not represent more
+# than one slots.  Future QEMU versions should include additional
+# code to set @count on those entries.
+##
+{ 'struct': 'DeviceSlotInfo',
+  'data': { 'device-types': [ 'str' ], '*device': 'str',
+            'available': 'bool', 'hotpluggable': 'bool',
+            '*count': 'int', 'opts-complete': 'bool',
+            'opts': [ 'SlotOption' ] } }
+
+##
+# @query-device-slots:
+#
+# Return the list of possible slots for plugging devices using
+# @device_add.
+##
+{ 'command': 'query-device-slots',
+  'returns': [ 'DeviceSlotInfo' ] }
+
 ##
 # @MachineInfo:
 #
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index ae31728..0111350 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -191,6 +191,8 @@ struct BusClass {
     void (*reset)(BusState *bus);
     BusRealize realize;
     BusUnrealize unrealize;
+    /*TODO: write doc */
+    DeviceSlotInfoList *(*enumerate_slots)(BusState *bus);
 
     /* maximum devices allowed on the bus, 0: no limit. */
     int max_dev;
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 8fd6df9..785f4af 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -30,6 +30,8 @@
 #include "qemu/help_option.h"
 #include "sysemu/block-backend.h"
 #include "migration/misc.h"
+#include "qapi/qobject-output-visitor.h"
+#include "hw/boards.h"
 
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -638,6 +640,42 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
     return dev;
 }
 
+typedef struct SlotListState {
+    DeviceSlotInfoList *result;
+    DeviceSlotInfoList **next;
+} SlotListState;
+
+static void append_slots(SlotListState *s, DeviceSlotInfoList *l)
+{
+    *s->next = l;
+    for (; l; l = l->next) {
+        s->next = &l->next;
+    }
+}
+
+static int enumerate_bus(Object *obj, void *opaque)
+{
+    SlotListState *s = opaque;
+
+    if (object_dynamic_cast(obj, TYPE_BUS)) {
+        BusState *bus = BUS(obj);
+        BusClass *bc = BUS_GET_CLASS(bus);
+
+        if (bc->enumerate_slots) {
+            append_slots(s, bc->enumerate_slots(bus));
+        }
+    }
+    return 0;
+}
+
+DeviceSlotInfoList *qmp_query_device_slots(Error **errp)
+{
+    SlotListState s = { .next = &s.result };
+
+    object_child_foreach_recursive(qdev_get_machine(), enumerate_bus, &s);
+    return s.result;
+}
+
 
 #define qdev_printf(fmt, ...) monitor_printf(mon, "%*s" fmt, indent, "", ## __VA_ARGS__)
 static void qbus_print(Monitor *mon, BusState *bus, int indent);
-- 
2.9.4
