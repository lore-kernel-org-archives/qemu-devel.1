Received: from eggs.gnu.org ([209.51.188.92]:37766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h1bTl-0002YG-SL
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h1bTk-0006CL-OI
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:41:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1h1bTj-0006Ap-Rj
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:41:20 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  6 Mar 2019 15:41:01 -0300
Message-Id: <20190306184101.9974-6-ehabkost@redhat.com>
In-Reply-To: <20190306184101.9974-1-ehabkost@redhat.com>
References: <20190306184101.9974-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] qdev: Provide qdev_get_bus_hotplug_handler()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's use a wrapper instead of looking it up manually. This function can
than be reused when we explicitly want to have the bus hotplug handler
(e.g. when the bus hotplug handler was overwritten by the machine
hotplug handler).

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190228122849.4296-4-david@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/qdev-core.h |  1 +
 hw/core/qdev.c         | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index ea4c1f60ed..17f09aac72 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -281,6 +281,7 @@ DeviceState *qdev_try_create(BusState *bus, const char *name);
 void qdev_init_nofail(DeviceState *dev);
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version);
+HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
 HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
 /**
  * qdev_get_hotplug_handler: Get handler responsible for device wiring
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 71c7facf60..512ce7ca7a 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -236,12 +236,20 @@ HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
     return NULL;
 }
 
+HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev)
+{
+    if (dev->parent_bus) {
+        return dev->parent_bus->hotplug_handler;
+    }
+    return NULL;
+}
+
 HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
 {
     HotplugHandler *hotplug_ctrl = qdev_get_machine_hotplug_handler(dev);
 
     if (hotplug_ctrl == NULL && dev->parent_bus) {
-        hotplug_ctrl = dev->parent_bus->hotplug_handler;
+        hotplug_ctrl = qdev_get_bus_hotplug_handler(dev);
     }
     return hotplug_ctrl;
 }
-- 
2.18.0.rc1.1.g3f1ff2140
