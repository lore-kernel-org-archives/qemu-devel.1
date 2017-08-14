Received: from eggs.gnu.org ([2001:4830:134:3::10]:43077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNOA-0002EN-Oz
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNO6-0002lP-TS
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:59:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dhNO6-0002kx-KU
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:59:06 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 14 Aug 2017 18:57:42 -0300
Message-Id: <20170814215748.5158-8-ehabkost@redhat.com>
In-Reply-To: <20170814215748.5158-1-ehabkost@redhat.com>
References: <20170814215748.5158-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v4 07/13] qdev: Enumerate CPU slots on
 query-device-slots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>

Use machine_query_hotpluggable_cpus() to build the slot list for
CPU devices.

Example output: the following command line:

  $ qemu-system-x86_64 -machine q35,accel=kvm \
    -cpu Haswell -smp 2,maxcpus=4

will generate the following entries:

  {
    "available": false,
    "count": 1,
    "device": "/machine/unattached/device[0]",
    "device-types": [ "Haswell-x86_64-cpu" ],
    "hotpluggable": true,
    "opts": [
      { "option": "socket-id", "values": 0 },
      { "option": "thread-id", "values": 0 },
      { "option": "core-id", "values": 0 }
    ],
    "opts-complete": true
  }
  {
    "available": false,
    "count": 1,
    "device": "/machine/unattached/device[2]",
    "device-types": [ "Haswell-x86_64-cpu" ],
    "hotpluggable": true,
    "opts": [
      { "option": "socket-id", "values": 1 },
      { "option": "thread-id", "values": 0 },
      { "option": "core-id", "values": 0 }
    ],
    "opts-complete": true
  }
  {
    "available": true,
    "count": 2,
    "device-types": [ "Haswell-x86_64-cpu" ],
    "hotpluggable": true,
    "opts": [
      { "option": "socket-id", "values": [ [ 2, 3 ] ] },
      { "option": "thread-id", "values": 0 },
      { "option": "core-id", "values": 0 }
    ],
    "opts-complete": true
  }

Cc: Igor Mammedov <imammedo@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qdev-monitor.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index edc6e34..7ed41df 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -32,6 +32,8 @@
 #include "migration/misc.h"
 #include "qapi/qobject-output-visitor.h"
 #include "hw/boards.h"
+#include "hw/qdev-slotinfo.h"
+#include "qapi-visit.h"
 
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -668,11 +670,79 @@ static int enumerate_bus(Object *obj, void *opaque)
     return 0;
 }
 
+static void add_option(const char *key, QObject *obj, void *opaque)
+{
+    DeviceSlotInfo *slot = opaque;
+
+    qobject_incref(obj);
+    slot_add_opt(slot, key, obj);
+}
+
+/* Add all key/values in @d to as options to @slot */
+static void qdict_to_slot_props(QDict *d, DeviceSlotInfo *slot)
+{
+    qdict_iter(d, add_option, slot);
+}
+
+static QDict *cpu_instance_props_to_qdict(CpuInstanceProperties *src)
+{
+    QObject *qobj = NULL;
+    Visitor *v = qobject_output_visitor_new(&qobj);
+
+    visit_type_CpuInstanceProperties(v, "unused", &src, &error_abort);
+    visit_complete(v, &qobj);
+    visit_free(v);
+    return qobject_to_qdict(qobj);
+}
+
+static void enumerate_cpu_slots(SlotListState *s)
+{
+    DeviceSlotInfoList *r = NULL;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    HotpluggableCPUList *hcl;
+    HotpluggableCPUList *i;
+
+    if (!mc->has_hotpluggable_cpus) {
+        return;
+    }
+
+    hcl = machine_query_hotpluggable_cpus(ms);
+    for (i = hcl; i; i = i->next) {
+        DeviceSlotInfo *slot = g_new0(DeviceSlotInfo, 1);
+        HotpluggableCPU *hc = i->value;
+        QDict *props;
+
+        slot->device_types = g_new0(strList, 1);
+        slot->device_types->value = g_strdup(hc->type);
+        slot->available = !hc->has_qom_path;
+        if (hc->has_qom_path) {
+            slot->has_device = true;
+            slot->device = g_strdup(hc->qom_path);
+        }
+        slot->has_count = true;
+        slot->count = 1;
+        slot->opts_complete = true;
+        /*TODO: should 'hotpluggable' be always true? */
+        slot->hotpluggable = true;
+
+        props = cpu_instance_props_to_qdict(hc->props);
+        qdict_to_slot_props(props, slot);
+        QDECREF(props);
+
+        slot_list_add_slot(&r, slot);
+    }
+    qapi_free_HotpluggableCPUList(hcl);
+
+    append_slots(s, r);
+}
+
 DeviceSlotInfoList *qmp_query_device_slots(Error **errp)
 {
     SlotListState s = { .next = &s.result };
 
     object_child_foreach_recursive(qdev_get_machine(), enumerate_bus, &s);
+    enumerate_cpu_slots(&s);
 
     return slot_list_collapse(s.result);
 }
-- 
2.9.4
