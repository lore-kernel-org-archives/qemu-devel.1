Received: from eggs.gnu.org ([2001:4830:134:3::10]:46233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzfp-0001El-0H
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:11:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzfl-0004zU-SF
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:11:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ebzfl-0004z3-Jn
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:11:21 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Jan 2018 00:09:54 -0200
Message-Id: <20180118021000.27203-14-ehabkost@redhat.com>
In-Reply-To: <20180118021000.27203-1-ehabkost@redhat.com>
References: <20180118021000.27203-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 13/19] qdev: Check for the availability of a
 hotplug controller before adding a device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The qdev_unplug() function contains a g_assert(hotplug_ctrl) statement,
so QEMU crashes when the user tries to device_add + device_del a device
that does not have a corresponding hotplug controller. This could be
provoked for a couple of devices in the past (see commit 4c93950659487c7ad
or 84ebd3e8c7d4fe955 for example), and can currently for example also be
triggered like this:

$ s390x-softmmu/qemu-system-s390x -M none -nographic
QEMU 2.10.50 monitor - type 'help' for more information
(qemu) device_add qemu-s390x-cpu,id=x
(qemu) device_del x
**
ERROR:qemu/qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctrl)
Aborted (core dumped)

So devices clearly need a hotplug controller when they should be usable
with device_add.
The code in qdev_device_add() already checks whether the bus has a proper
hotplug controller, but for devices that do not have a corresponding bus,
there is no appropriate check available yet. In that case we should check
whether the machine itself provides a suitable hotplug controller and
refuse to plug the device if none is available.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1509617407-21191-3-git-send-email-thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/qdev-core.h |  1 +
 hw/core/qdev.c         | 28 ++++++++++++++++++++--------
 qdev-monitor.c         |  5 +++++
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 0a71bf83f0..51473eee7b 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -286,6 +286,7 @@ DeviceState *qdev_try_create(BusState *bus, const char *name);
 void qdev_init_nofail(DeviceState *dev);
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version);
+HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
 HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev);
 void qdev_unplug(DeviceState *dev, Error **errp);
 void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 11112951a5..f739753e3a 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -253,19 +253,31 @@ void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
     dev->alias_required_for_version = required_for_version;
 }
 
+HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
+{
+    MachineState *machine;
+    MachineClass *mc;
+    Object *m_obj = qdev_get_machine();
+
+    if (object_dynamic_cast(m_obj, TYPE_MACHINE)) {
+        machine = MACHINE(m_obj);
+        mc = MACHINE_GET_CLASS(machine);
+        if (mc->get_hotplug_handler) {
+            return mc->get_hotplug_handler(machine, dev);
+        }
+    }
+
+    return NULL;
+}
+
 HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
 {
-    HotplugHandler *hotplug_ctrl = NULL;
+    HotplugHandler *hotplug_ctrl;
 
     if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
         hotplug_ctrl = dev->parent_bus->hotplug_handler;
-    } else if (object_dynamic_cast(qdev_get_machine(), TYPE_MACHINE)) {
-        MachineState *machine = MACHINE(qdev_get_machine());
-        MachineClass *mc = MACHINE_GET_CLASS(machine);
-
-        if (mc->get_hotplug_handler) {
-            hotplug_ctrl = mc->get_hotplug_handler(machine, dev);
-        }
+    } else {
+        hotplug_ctrl = qdev_get_machine_hotplug_handler(dev);
     }
     return hotplug_ctrl;
 }
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 2abb80d7e4..c436616446 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -613,6 +613,11 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
 
     if (bus) {
         qdev_set_parent_bus(dev, bus);
+    } else if (qdev_hotplug && !qdev_get_machine_hotplug_handler(dev)) {
+        /* No bus, no machine hotplug handler --> device is not hotpluggable */
+        error_setg(&err, "Device '%s' can not be hotplugged on this machine",
+                   driver);
+        goto err_del_dev;
     }
 
     qdev_set_id(dev, qemu_opts_id(opts));
-- 
2.14.3
