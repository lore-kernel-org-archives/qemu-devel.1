Received: from eggs.gnu.org ([2001:4830:134:3::10]:42220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fGlGK-0007nP-IB
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fGlGG-0006MO-Jr
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:05:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58616 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fGlGG-0006MK-F7
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:05:32 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 10 May 2018 15:04:38 +0200
Message-Id: <1525957478-250605-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <19eb43f8-3bdc-fbfe-47c1-bcc1de7a64ba@redhat.com>
References: <19eb43f8-3bdc-fbfe-47c1-bcc1de7a64ba@redhat.com>
Subject: [Qemu-devel] [PATCH] qdev: let machine hotplug handler to override
 bus hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, david@redhat.com, david@gibson.dropbear.id.au, pagupta@redhat.com

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

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/qdev-core.h | 11 +++++++++++
 hw/core/qdev.c         |  6 ++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 9453588..e6a8eca 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -286,6 +286,17 @@ void qdev_init_nofail(DeviceState *dev);
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
index f6f9247..885286f 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -261,12 +261,10 @@ HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
 
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
2.7.4
