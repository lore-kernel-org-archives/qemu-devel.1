Received: from eggs.gnu.org ([209.51.188.92]:40393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvfvi-0002p2-67
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:13:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvfvZ-0005WA-FY
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:13:37 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Feb 2019 11:12:53 +0100
Message-Id: <20190218101254.8007-3-david@redhat.com>
In-Reply-To: <20190218101254.8007-1-david@redhat.com>
References: <20190218101254.8007-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/3] qdev: Let machine hotplug handler to
 override bus hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, David Hildenbrand <david@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

it will allow to return another hotplug handler than the default
one for a specific bus based device type. Which is needed to handle
non trivial plug/unplug sequences that need the access to resources
configured outside of bus where device is attached.

That will allow for returned hotplug handler to orchestrate wiring
in arbitrary order, by chaining other hotplug handlers when
it's needed.

PS:
It could be used for hybrid virtio-mem and virtio-pmem devices
where it will return machine as hotplug handler which will do
necessary wiring at machine level and then pass control down
the chain to bus specific hotplug handler.

Example of top level hotplug handler override and custom plug sequence:

  some_machine_get_hotplug_handler(machine){
      if (object_dynamic_cast(OBJECT(dev), TYPE_SOME_BUS_DEVICE)) {
          return HOTPLUG_HANDLER(machine);
      }
      return NULL;
  }

  some_machine_device_plug(hotplug_dev, dev) {
      if (object_dynamic_cast(OBJECT(dev), TYPE_SOME_BUS_DEVICE)) {
          /* do machine specific initialization */
          some_machine_init_special_device(dev)

          /* pass control to bus specific handler */
          hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev)
      }
  }

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/qdev.c         |  6 ++----
 include/hw/qdev-core.h | 11 +++++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 278cc094ec..7ad45c0bd6 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -235,12 +235,10 @@ HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
 
 HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
 {
-    HotplugHandler *hotplug_ctrl;
+    HotplugHandler *hotplug_ctrl = qdev_get_machine_hotplug_handler(dev);
 
-    if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
+    if (hotplug_ctrl == NULL && dev->parent_bus) {
         hotplug_ctrl = dev->parent_bus->hotplug_handler;
-    } else {
-        hotplug_ctrl = qdev_get_machine_hotplug_handler(dev);
     }
     return hotplug_ctrl;
 }
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 0a84c42756..9081fb0030 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -281,6 +281,17 @@ void qdev_init_nofail(DeviceState *dev);
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version);
 HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
+/**
+ * qdev_get_hotplug_handler: Get handler responsible for device wiring
+ *
+ * Find HOTPLUG_HANDLER for @dev that provides [pre|un]plug callbacks for it.
+ *
+ * Note: in case @dev has a parent bus, it will be returned as handler unless
+ * machine handler overrides it.
+ *
+ * Returns: pointer to object that implements TYPE_HOTPLUG_HANDLER interface
+ *          or NULL if there aren't any.
+ */
 HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev);
 void qdev_unplug(DeviceState *dev, Error **errp);
 void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
-- 
2.17.2
