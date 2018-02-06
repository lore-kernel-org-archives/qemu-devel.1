Received: from eggs.gnu.org ([2001:4830:134:3::10]:45198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9uW-0001eS-1j
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:32:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9uS-0003Vb-Mw
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:32:12 -0500
Received: from mail-db5eur01on0138.outbound.protection.outlook.com
	([104.47.2.138]:6562
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ej9uS-0003T5-DT
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:32:08 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Feb 2018 23:30:47 +0300
Message-Id: <20180206203048.11096-34-rkagan@virtuozzo.com>
In-Reply-To: <20180206203048.11096-1-rkagan@virtuozzo.com>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 33/34] vmbus: add support for rom files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>, Ben Warren <ben@skyportsystems.com>, si-wei liu <si-wei.liu@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, Vadim Rozenfeld <vrozenfe@redhat.com>

In order to leverage third-party drivers for VMBus devices in firmware
(in particular, there's a case with iPXE driver for hv-net in SeaBIOS
and OVMF), introduce an infrastructure to supply such drivers as option
ROMs.

To make it easy for the firmware to locate such ROMs, they are stored in
fw_cfg with names "vmbus/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.rom" for
default class ROMs (where xxx... is the class GUID) and
"vmbus/dev/yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy.rom" for per-device
(i.e. specified via .romfile property) ROMs (where yyy... is the device
instance GUID).

The format and the calling convention for the ROMs is out of scope for
this patch: QEMU doesn't try to interpret them.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 include/hw/vmbus/vmbus.h |  3 +++
 hw/vmbus/vmbus.c         | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/hw/vmbus/vmbus.h b/include/hw/vmbus/vmbus.h
index cdb5180796..847edc08d7 100644
--- a/include/hw/vmbus/vmbus.h
+++ b/include/hw/vmbus/vmbus.h
@@ -49,6 +49,8 @@ typedef struct VMBusDeviceClass {
     int (*open_channel) (VMBusDevice *vdev);
     void (*close_channel) (VMBusDevice *vdev);
     VMBusChannelNotifyCb chan_notify_cb;
+
+    const char *romfile;
 } VMBusDeviceClass;
 
 typedef struct VMBusDevice {
@@ -57,6 +59,7 @@ typedef struct VMBusDevice {
     uint16_t num_channels;
     VMBusChannel *channels;
     AddressSpace *dma_as;
+    char *romfile;
 } VMBusDevice;
 
 extern const VMStateDescription vmstate_vmbus_dev;
diff --git a/hw/vmbus/vmbus.c b/hw/vmbus/vmbus.c
index 42d12dfdf6..c2aec004e7 100644
--- a/hw/vmbus/vmbus.c
+++ b/hw/vmbus/vmbus.c
@@ -12,6 +12,7 @@
 #include "qapi/error.h"
 #include "hw/vmbus/vmbus.h"
 #include "hw/sysbus.h"
+#include "hw/loader.h"
 #include "trace.h"
 
 #define TYPE_VMBUS "vmbus"
@@ -2061,6 +2062,36 @@ unmap:
     cpu_physical_memory_unmap(int_map, len, 1, is_dirty);
 }
 
+static void vmbus_install_rom(VMBusDevice *vdev)
+{
+    VMBusDeviceClass *vdc = VMBUS_DEVICE_GET_CLASS(vdev);
+    VMBus *vmbus = VMBUS(qdev_get_parent_bus(DEVICE(vdev)));
+    BusChild *child;
+    char uuid[UUID_FMT_LEN + 1];
+    char romname[10 + UUID_FMT_LEN + 4 + 1];
+
+    if (vdev->romfile) {
+        /* device-specific rom */
+        qemu_uuid_unparse(&vdc->instanceid, uuid);
+        snprintf(romname, sizeof(romname), "vmbus/dev/%s.rom", uuid);
+        rom_add_file(vdev->romfile, romname, 0, -1, true, NULL, NULL);
+    } else if (vdc->romfile) {
+        /* class-wide rom */
+        QTAILQ_FOREACH(child, &BUS(vmbus)->children, sibling) {
+            VMBusDevice *chlddev = VMBUS_DEVICE(child->child);
+
+            /* another device of the same class has already installed it */
+            if (chlddev != vdev && !chlddev->romfile &&
+                VMBUS_DEVICE_GET_CLASS(chlddev) == vdc) {
+                return;
+            }
+        }
+        qemu_uuid_unparse(&vdc->classid, uuid);
+        snprintf(romname, sizeof(romname), "vmbus/%s.rom", uuid);
+        rom_add_file(vdc->romfile, romname, 0, -1, true, NULL, NULL);
+    }
+}
+
 static void vmbus_dev_realize(DeviceState *dev, Error **errp)
 {
     VMBusDevice *vdev = VMBUS_DEVICE(dev);
@@ -2098,6 +2129,8 @@ static void vmbus_dev_realize(DeviceState *dev, Error **errp)
         goto error_out;
     }
 
+    vmbus_install_rom(vdev);
+
     if (vdc->vmdev_realize) {
         vdc->vmdev_realize(vdev, &err);
         if (err) {
@@ -2145,6 +2178,11 @@ static void vmbus_dev_unrealize(DeviceState *dev, Error **errp)
     free_channels(vmbus, vdev);
 }
 
+static Property vmbus_dev_props[] = {
+    DEFINE_PROP_STRING("romfile", VMBusDevice, romfile),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void vmbus_dev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *kdev = DEVICE_CLASS(klass);
@@ -2152,6 +2190,7 @@ static void vmbus_dev_class_init(ObjectClass *klass, void *data)
     kdev->realize = vmbus_dev_realize;
     kdev->unrealize = vmbus_dev_unrealize;
     kdev->reset = vmbus_dev_reset;
+    kdev->props = vmbus_dev_props;
 }
 
 static int vmbus_dev_post_load(void *opaque, int version_id)
-- 
2.14.3
