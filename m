Received: from eggs.gnu.org ([209.51.188.92]:37755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h1bTj-0002YA-MC
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:41:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h1bTh-00069z-Hk
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:41:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1h1bTf-00067u-M2
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:41:17 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  6 Mar 2019 15:41:00 -0300
Message-Id: <20190306184101.9974-5-ehabkost@redhat.com>
In-Reply-To: <20190306184101.9974-1-ehabkost@redhat.com>
References: <20190306184101.9974-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] qdev: Let machine hotplug handler to
 override bus hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

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
Message-Id: <20190228122849.4296-3-david@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/qdev-core.h | 11 +++++++++++
 hw/core/qdev.c         |  6 ++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 35b8154e8b..ea4c1f60ed 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -282,6 +282,17 @@ void qdev_init_nofail(DeviceState *dev);
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
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index a9647d42ae..71c7facf60 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -238,12 +238,10 @@ HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
 
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
-- 
2.18.0.rc1.1.g3f1ff2140
