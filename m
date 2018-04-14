Received: from eggs.gnu.org ([2001:4830:134:3::10]:60241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agk@godking.net>) id 1f7BVp-0003EC-KI
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 23:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agk@godking.net>) id 1f7BVk-0001tm-La
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 23:06:01 -0400
Received: from s18231873.onlinehome-server.info ([217.160.179.168]:38984
	helo=godking.net) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agk@godking.net>) id 1f7BVk-0001ri-Bh
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 23:05:56 -0400
From: Alexander Kappner <agk@godking.net>
Date: Fri, 13 Apr 2018 20:05:25 -0700
Message-Id: <1523675125-14022-1-git-send-email-agk@godking.net>
Subject: [Qemu-devel] [PATCH] Implement query-usbhost QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, eblake@redhat.com, armbru@redhat.com
Cc: Alexander Kappner <agk@godking.net>, qemu-devel@nongnu.org

Implement a QMP command similar to the HMP's "info usbhost" command.
This allows a QMP client to query which USB devices may be available
for redirection. Because the availability of the command needs to
depend on the target's (not the build host's) USB configuration,
a qmp_nousb.c is provided for targets without USB support.

Signed-off-by: Alexander Kappner <agk@godking.net>
---
 hw/usb/Makefile.objs |  2 ++
 hw/usb/host-libusb.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/usb/qmp-nousb.c   | 28 +++++++++++++++++++++++
 qapi/misc.json       | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 156 insertions(+)
 create mode 100644 hw/usb/qmp-nousb.c

diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 41be700..10569ba 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -58,3 +58,5 @@ common-obj-$(CONFIG_XEN) += xen-usb.o
 xen-usb.o-cflags := $(LIBUSB_CFLAGS)
 xen-usb.o-libs := $(LIBUSB_LIBS)
 endif
+
+obj-$(call lnot,$(CONFIG_USB)) += qmp-nousb.o
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 1b0be07..efdf577 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -40,6 +40,7 @@
 #include <libusb.h>
 
 #include "qapi/error.h"
+#include "qapi/qapi-commands-misc.h"
 #include "qemu-common.h"
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
@@ -1743,6 +1744,69 @@ bool usb_host_dev_is_scsi_storage(USBDevice *ud)
     return is_scsi_storage;
 }
 
+UsbDeviceInfoList *qmp_query_usbhost(Error **errp)
+{
+    UsbDeviceInfoList *usb_list = NULL;
+    UsbDeviceInfoList *info;
+    libusb_device **devs = NULL;
+    struct libusb_device_descriptor ddesc;
+    char port[16];
+    int i, n;
+
+    if (usb_host_init() != 0) {
+        return NULL;
+    }
+    n = libusb_get_device_list(ctx, &devs);
+
+    for (i = 0; i < n; i++) {
+        if (libusb_get_device_descriptor(devs[i], &ddesc) != 0) {
+            continue;
+        }
+        if (ddesc.bDeviceClass == LIBUSB_CLASS_HUB) {
+            continue;
+        }
+        usb_host_get_port(devs[i], port, sizeof(port));
+        info = g_new0(UsbDeviceInfoList, 1);
+        info->value = g_new0(UsbDeviceInfo, 1);
+        info->value->id_vendor = ddesc.idVendor;
+        info->value->bus_num = libusb_get_bus_number(devs[i]);
+        info->value->dev_addr = libusb_get_device_address(devs[i]);
+        info->value->id_product = ddesc.idProduct;
+        info->value->b_device_class = ddesc.bDeviceClass;
+        info->value->speed = libusb_get_device_speed(devs[i]);
+        info->next = usb_list;
+        usb_list = info;
+
+        if (ddesc.iProduct) {
+            libusb_device_handle *handle;
+            if (libusb_open(devs[i], &handle) == 0) {
+                unsigned char name[64] = "";
+                libusb_get_string_descriptor_ascii(handle,
+                                                   ddesc.iProduct,
+                                                   name, sizeof(name));
+                libusb_close(handle);
+                info->value->str_product = g_strdup((gchar *)name);
+            }
+        } else
+            info->value->str_product = NULL;
+
+        if (ddesc.iManufacturer) {
+            libusb_device_handle *handle;
+            if (libusb_open(devs[i], &handle) == 0) {
+                unsigned char name[64] = "";
+                libusb_get_string_descriptor_ascii(handle,
+                                                   ddesc.iManufacturer,
+                                                   name, sizeof(name));
+                libusb_close(handle);
+                info->value->str_manufacturer = g_strdup((gchar *)name);
+            }
+        } else
+        info->value->str_manufacturer = NULL;
+    }
+    libusb_free_device_list(devs, 1);
+    return usb_list;
+}
+
 void hmp_info_usbhost(Monitor *mon, const QDict *qdict)
 {
     libusb_device **devs = NULL;
diff --git a/hw/usb/qmp-nousb.c b/hw/usb/qmp-nousb.c
new file mode 100644
index 0000000..2ce8962
--- /dev/null
+++ b/hw/usb/qmp-nousb.c
@@ -0,0 +1,28 @@
+/*
+ * QMP Target options - Commands handled based on a target config
+ *                      versus a host config
+ *
+ * Copyright (c) 2018 Alexander Kappner <agk@godking.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-misc.h"
+#include "qapi/qmp/qerror.h"
+
+UsbDeviceInfoList *qmp_query_usbhost(Error **errp)
+{
+    error_setg(errp, QERR_FEATURE_DISABLED, "usb");
+    return NULL;
+};
diff --git a/qapi/misc.json b/qapi/misc.json
index 5636f4a..19a1453 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -270,6 +270,46 @@
 { 'command': 'query-kvm', 'returns': 'KvmInfo' }
 
 ##
+# @query-usbhost:
+#
+# Returns information about USB devices available on the host
+#
+# Returns: a [UsbDeviceInfo]. Returns an error if compiled without
+# CONFIG_USB.
+#
+# Since: TODO (maintainer insert version number if mainlined)
+#
+# Example:
+#
+# -> {"execute": "query-usbhost" }
+# {
+#     "return": [
+#         {
+#             "b_device_class": 239,
+#             "id_product": 793,
+#             "id_vendor": 3468,
+#             "speed": 3,
+#             "str_manufacturer": "Schiit Audio",
+#             "str_product": "Schiit Modi Uber"
+#             "bus_num": 5,
+#             "dev_addr": 21
+#         },
+#         {
+#             "b_device_class": 0,
+#             "id_product": 6944,
+#             "id_vendor": 6940,
+#             "speed": 2,
+#             "str_manufacturer": "Corsair",
+#             "str_product": "Corsair STRAFE RGB Gaming Keyboard"
+#             "bus_num": 5,
+#             "dev_addr": 35
+#         }
+#     ]
+# }
+##
+{ 'command': 'query-usbhost', 'returns': ['UsbDeviceInfo'] }
+
+##
 # @UuidInfo:
 #
 # Guest UUID information (Universally Unique Identifier).
@@ -876,6 +916,28 @@
            'regions': ['PciMemoryRegion']} }
 
 ##
+# @UsbDeviceInfo:
+#
+# @speed: the speed
+#
+# @id_vendor: idVendor field from device descriptor
+#
+# @id_product: idProduct field from device descriptor
+#
+# @str_product: string descriptor referenced by iProduct index, if any
+#
+# @str_manufacturer: string descriptor referenced by iManufacturer index, if any
+#
+# @dev_addr: address on bus that device is connected to
+#
+# @bus_num: bus number device is connected to
+##
+{ 'struct': 'UsbDeviceInfo',
+  'data':
+  {'speed': 'int', 'id_vendor': 'int', 'id_product' : 'int', 'str_product': 'str',
+   'b_device_class': 'int', 'str_manufacturer' : 'str', 'dev_addr' : 'int', 'bus_num' : 'int'} }
+
+##
 # @PciInfo:
 #
 # Information about a PCI bus
-- 
2.1.4
