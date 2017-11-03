Received: from eggs.gnu.org ([2001:4830:134:3::10]:39693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eAhnE-0004Rj-Rx
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 15:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eAhnB-0001Hf-NH
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 15:38:16 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:58661)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eAhnB-0001Ge-Cs
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 15:38:13 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  3 Nov 2017 20:38:02 +0100
Message-Id: <20171103193802.11876-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] linux-user: remove nmi.c and fw-path-provider.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Riku Voipio <riku.voipio@linaro.org>, Laurent Vivier <laurent@vivier.eu>

linux-user binaries don't need firmware and NMI,
so don't add them in this case, move QDEV
firmware functions to qdev-fw.c

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/core/Makefile.objs |  5 +--
 hw/core/qdev-fw.c     | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/core/qdev.c        | 77 -----------------------------------------
 3 files changed, 99 insertions(+), 79 deletions(-)
 create mode 100644 hw/core/qdev-fw.c

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index f8d7a4aaed..1240728c87 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -1,11 +1,12 @@
 # core qdev-related obj files, also used by *-user:
 common-obj-y += qdev.o qdev-properties.o
 common-obj-y += bus.o reset.o
-common-obj-y += fw-path-provider.o
+common-obj-$(CONFIG_SOFTMMU) += qdev-fw.o
+common-obj-$(CONFIG_SOFTMMU) += fw-path-provider.o
 # irq.o needed for qdev GPIO handling:
 common-obj-y += irq.o
 common-obj-y += hotplug.o
-common-obj-y += nmi.o
+common-obj-$(CONFIG_SOFTMMU) += nmi.o
 
 common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
 common-obj-$(CONFIG_XILINX_AXI) += stream.o
diff --git a/hw/core/qdev-fw.c b/hw/core/qdev-fw.c
new file mode 100644
index 0000000000..aa35e9d0ac
--- /dev/null
+++ b/hw/core/qdev-fw.c
@@ -0,0 +1,96 @@
+/*
+ *  qdev fw helpers
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License,
+ *  or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev.h"
+#include "hw/fw-path-provider.h"
+
+const char *qdev_fw_name(DeviceState *dev)
+{
+    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+
+    if (dc->fw_name) {
+        return dc->fw_name;
+    }
+
+    return object_get_typename(OBJECT(dev));
+}
+
+static char *bus_get_fw_dev_path(BusState *bus, DeviceState *dev)
+{
+    BusClass *bc = BUS_GET_CLASS(bus);
+
+    if (bc->get_fw_dev_path) {
+        return bc->get_fw_dev_path(dev);
+    }
+
+    return NULL;
+}
+
+static char *qdev_get_fw_dev_path_from_handler(BusState *bus, DeviceState *dev)
+{
+    Object *obj = OBJECT(dev);
+    char *d = NULL;
+
+    while (!d && obj->parent) {
+        obj = obj->parent;
+        d = fw_path_provider_try_get_dev_path(obj, bus, dev);
+    }
+    return d;
+}
+
+char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev)
+{
+    Object *obj = OBJECT(dev);
+
+    return fw_path_provider_try_get_dev_path(obj, bus, dev);
+}
+
+static int qdev_get_fw_dev_path_helper(DeviceState *dev, char *p, int size)
+{
+    int l = 0;
+
+    if (dev && dev->parent_bus) {
+        char *d;
+        l = qdev_get_fw_dev_path_helper(dev->parent_bus->parent, p, size);
+        d = qdev_get_fw_dev_path_from_handler(dev->parent_bus, dev);
+        if (!d) {
+            d = bus_get_fw_dev_path(dev->parent_bus, dev);
+        }
+        if (d) {
+            l += snprintf(p + l, size - l, "%s", d);
+            g_free(d);
+        } else {
+            return l;
+        }
+    }
+    l += snprintf(p + l , size - l, "/");
+
+    return l;
+}
+
+char *qdev_get_fw_dev_path(DeviceState *dev)
+{
+    char path[128];
+    int l;
+
+    l = qdev_get_fw_dev_path_helper(dev, path, 128);
+
+    path[l - 1] = '\0';
+
+    return g_strdup(path);
+}
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 11112951a5..49df62ba8c 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -27,7 +27,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/qdev.h"
-#include "hw/fw-path-provider.h"
 #include "sysemu/sysemu.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/visitor.h"
@@ -48,17 +47,6 @@ const VMStateDescription *qdev_get_vmsd(DeviceState *dev)
     return dc->vmsd;
 }
 
-const char *qdev_fw_name(DeviceState *dev)
-{
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
-
-    if (dc->fw_name) {
-        return dc->fw_name;
-    }
-
-    return object_get_typename(OBJECT(dev));
-}
-
 static void bus_remove_child(BusState *bus, DeviceState *child)
 {
     BusChild *kid;
@@ -619,71 +607,6 @@ DeviceState *qdev_find_recursive(BusState *bus, const char *id)
     return NULL;
 }
 
-static char *bus_get_fw_dev_path(BusState *bus, DeviceState *dev)
-{
-    BusClass *bc = BUS_GET_CLASS(bus);
-
-    if (bc->get_fw_dev_path) {
-        return bc->get_fw_dev_path(dev);
-    }
-
-    return NULL;
-}
-
-static char *qdev_get_fw_dev_path_from_handler(BusState *bus, DeviceState *dev)
-{
-    Object *obj = OBJECT(dev);
-    char *d = NULL;
-
-    while (!d && obj->parent) {
-        obj = obj->parent;
-        d = fw_path_provider_try_get_dev_path(obj, bus, dev);
-    }
-    return d;
-}
-
-char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev)
-{
-    Object *obj = OBJECT(dev);
-
-    return fw_path_provider_try_get_dev_path(obj, bus, dev);
-}
-
-static int qdev_get_fw_dev_path_helper(DeviceState *dev, char *p, int size)
-{
-    int l = 0;
-
-    if (dev && dev->parent_bus) {
-        char *d;
-        l = qdev_get_fw_dev_path_helper(dev->parent_bus->parent, p, size);
-        d = qdev_get_fw_dev_path_from_handler(dev->parent_bus, dev);
-        if (!d) {
-            d = bus_get_fw_dev_path(dev->parent_bus, dev);
-        }
-        if (d) {
-            l += snprintf(p + l, size - l, "%s", d);
-            g_free(d);
-        } else {
-            return l;
-        }
-    }
-    l += snprintf(p + l , size - l, "/");
-
-    return l;
-}
-
-char* qdev_get_fw_dev_path(DeviceState *dev)
-{
-    char path[128];
-    int l;
-
-    l = qdev_get_fw_dev_path_helper(dev, path, 128);
-
-    path[l-1] = '\0';
-
-    return g_strdup(path);
-}
-
 char *qdev_get_dev_path(DeviceState *dev)
 {
     BusClass *bc;
-- 
2.13.6
