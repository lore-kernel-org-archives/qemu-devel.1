Received: from eggs.gnu.org ([209.51.188.92]:40485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvfvx-00031R-BW
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvfvv-0005ez-Rs
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:13:57 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Feb 2019 11:12:54 +0100
Message-Id: <20190218101254.8007-4-david@redhat.com>
In-Reply-To: <20190218101254.8007-1-david@redhat.com>
References: <20190218101254.8007-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 3/3] qdev: Provide
 qdev_get_bus_hotplug_handler()
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

Let's use a wrapper instead of looking it up manually. This function can
than be reused when we explicitly want to have the bus hotplug handler
(e.g. when the bus hotplug handler was overwritten by the machine
hotplug handler).

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/qdev.c         | 10 +++++++++-
 include/hw/qdev-core.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 7ad45c0bd6..e2207d77a4 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -233,12 +233,20 @@ HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
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
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 9081fb0030..cb0ec63c2d 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -280,6 +280,7 @@ DeviceState *qdev_try_create(BusState *bus, const char *name);
 void qdev_init_nofail(DeviceState *dev);
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version);
+HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
 HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
 /**
  * qdev_get_hotplug_handler: Get handler responsible for device wiring
-- 
2.17.2
