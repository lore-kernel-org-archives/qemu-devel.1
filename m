Received: from eggs.gnu.org ([2001:4830:134:3::10]:55901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWfZj-0003jb-N5
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWfZf-0008WK-94
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:47:39 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Tue, 11 Dec 2018 10:47:03 +0000
Message-ID: <1544525238-3527-4-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1544525238-3527-1-git-send-email-paul.durrant@citrix.com>
References: <1544525238-3527-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 03/18] xen: introduce 'xen-block',
 'xen-disk' and 'xen-cdrom'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

This patch adds new XenDevice-s: 'xen-disk' and 'xen-cdrom', both derived
from a common 'xen-block' parent type. These will eventually replace the
'xen_disk' (note the underscore rather than hyphen) legacy PV backend but
it is illustrative to build up the implementation incrementally, along with
the XenBus/XenDevice framework. Subsequent patches will therefore add to
these devices' implementation as new features are added to the framework.

After this patch has been applied it is possible to instantiate new
'xen-disk' or 'xen-cdrom' devices with a single 'vdev' parameter, which
accepts values adhering to the Xen VBD naming scheme [1]. For example, a
command-line instantiation of a xen-disk can be done with an argument
similar to the following:

-device xen-disk,vdev=hda

The implementation of the vdev parameter formulates the appropriate VBD
number for use in the PV protocol.

[1] https://xenbits.xen.org/docs/unstable/man/xen-vbd-interface.7.html

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>

v3:
 - Fix vdev parsing again, and vdev formatting this time
 - Remove an unnecessary local_err

v2:
 - Fix boilerplate
 - Fix vdev parsing
 - Change name from 'xen-qdisk' to 'xen-block', make abstract, and split
   off 'xen-disk' and 'xen-cdrom' as concrete sub-types
---
 MAINTAINERS                |   2 +-
 hw/block/Makefile.objs     |   1 +
 hw/block/trace-events      |   8 ++
 hw/block/xen-block.c       | 343 +++++++++++++++++++++++++++++++++++++++++++++
 include/hw/xen/xen-block.h |  69 +++++++++
 5 files changed, 422 insertions(+), 1 deletion(-)
 create mode 100644 hw/block/xen-block.c
 create mode 100644 include/hw/xen/xen-block.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 63effdc..dd728c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -403,7 +403,7 @@ F: hw/9pfs/xen-9p-backend.c
 F: hw/char/xen_console.c
 F: hw/display/xenfb.c
 F: hw/net/xen_nic.c
-F: hw/block/xen_*
+F: hw/block/xen*
 F: hw/xen/
 F: hw/xenpv/
 F: hw/i386/xen/
diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index 53ce575..f34813a 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -4,6 +4,7 @@ common-obj-$(CONFIG_SSI_M25P80) += m25p80.o
 common-obj-$(CONFIG_NAND) += nand.o
 common-obj-$(CONFIG_PFLASH_CFI01) += pflash_cfi01.o
 common-obj-$(CONFIG_PFLASH_CFI02) += pflash_cfi02.o
+common-obj-$(CONFIG_XEN) += xen-block.o
 common-obj-$(CONFIG_XEN) += xen_disk.o
 common-obj-$(CONFIG_ECC) += ecc.o
 common-obj-$(CONFIG_ONENAND) += onenand.o
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 335c092..4afbd62 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -127,3 +127,11 @@ xen_disk_init(char *name) "%s"
 xen_disk_connect(char *name) "%s"
 xen_disk_disconnect(char *name) "%s"
 xen_disk_free(char *name) "%s"
+
+# hw/block/xen-block.c
+xen_block_realize(const char *type, uint32_t disk, uint32_t partition) "%s d%up%u"
+xen_block_unrealize(const char *type, uint32_t disk, uint32_t partition) "%s d%up%u"
+xen_disk_realize(void) ""
+xen_disk_unrealize(void) ""
+xen_cdrom_realize(void) ""
+xen_cdrom_unrealize(void) ""
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
new file mode 100644
index 0000000..c29acb0
--- /dev/null
+++ b/hw/block/xen-block.c
@@ -0,0 +1,343 @@
+/*
+ * Copyright (c) 2018  Citrix Systems Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "hw/hw.h"
+#include "hw/xen/xen-block.h"
+#include "trace.h"
+
+static void xen_block_unrealize(XenDevice *xendev, Error **errp)
+{
+    XenBlockDevice *blockdev = XEN_BLOCK_DEVICE(xendev);
+    XenBlockDeviceClass *blockdev_class =
+        XEN_BLOCK_DEVICE_GET_CLASS(xendev);
+    const char *type = object_get_typename(OBJECT(blockdev));
+    XenBlockVdev *vdev = &blockdev->vdev;
+
+    if (vdev->type == XEN_BLOCK_VDEV_TYPE_INVALID) {
+        return;
+    }
+
+    trace_xen_block_unrealize(type, vdev->disk, vdev->partition);
+
+    if (blockdev_class->unrealize) {
+        blockdev_class->unrealize(blockdev, errp);
+    }
+}
+
+static void xen_block_realize(XenDevice *xendev, Error **errp)
+{
+    XenBlockDevice *blockdev = XEN_BLOCK_DEVICE(xendev);
+    XenBlockDeviceClass *blockdev_class =
+        XEN_BLOCK_DEVICE_GET_CLASS(xendev);
+    const char *type = object_get_typename(OBJECT(blockdev));
+    XenBlockVdev *vdev = &blockdev->vdev;
+    Error *local_err = NULL;
+
+    if (vdev->type == XEN_BLOCK_VDEV_TYPE_INVALID) {
+        error_setg(errp, "vdev property not set");
+        return;
+    }
+
+    trace_xen_block_realize(type, vdev->disk, vdev->partition);
+
+    if (blockdev_class->realize) {
+        blockdev_class->realize(blockdev, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+        }
+    }
+}
+
+static char *disk_to_vbd_name(unsigned int disk)
+{
+    char *name, *prefix = (disk >= 26) ?
+        disk_to_vbd_name((disk / 26) - 1) : g_strdup("");
+
+    name = g_strdup_printf("%s%c", prefix, 'a' + disk % 26);
+    g_free(prefix);
+
+    return name;
+}
+
+static void xen_block_get_vdev(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    XenBlockVdev *vdev = qdev_get_prop_ptr(dev, prop);
+    char *str;
+
+    switch (vdev->type) {
+    case XEN_BLOCK_VDEV_TYPE_DP:
+        str = g_strdup_printf("d%lup%lu", vdev->disk, vdev->partition);
+        break;
+
+    case XEN_BLOCK_VDEV_TYPE_XVD:
+    case XEN_BLOCK_VDEV_TYPE_HD:
+    case XEN_BLOCK_VDEV_TYPE_SD: {
+        char *name = disk_to_vbd_name(vdev->disk);
+
+        str = g_strdup_printf("%s%s%lu",
+                              (vdev->type == XEN_BLOCK_VDEV_TYPE_XVD) ?
+                              "xvd" :
+                              (vdev->type == XEN_BLOCK_VDEV_TYPE_HD) ?
+                              "hd" :
+                              "sd",
+                              name, vdev->partition);
+        g_free(name);
+        break;
+    }
+    default:
+        error_setg(errp, "invalid vdev type");
+        return;
+    }
+
+    visit_type_str(v, name, &str, errp);
+    g_free(str);
+}
+
+static unsigned int vbd_name_to_disk(const char *name, const char **endp)
+{
+    unsigned int disk = 0;
+
+    while (*name != '\0') {
+        if (!g_ascii_isalpha(*name) || !g_ascii_islower(*name)) {
+            break;
+        }
+
+        disk *= 26;
+        disk += *name++ - 'a' + 1;
+    }
+    *endp = name;
+
+    return disk - 1;
+}
+
+static void xen_block_set_vdev(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    XenBlockVdev *vdev = qdev_get_prop_ptr(dev, prop);
+    Error *local_err = NULL;
+    char *str, *p;
+    const char *end;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_str(v, name, &str, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    p = strchr(str, 'd');
+    if (!p) {
+        goto invalid;
+    }
+
+    *p++ = '\0';
+    if (*str == '\0') {
+        vdev->type = XEN_BLOCK_VDEV_TYPE_DP;
+    } else if (strcmp(str, "xv") == 0) {
+        vdev->type = XEN_BLOCK_VDEV_TYPE_XVD;
+    } else if (strcmp(str, "h") == 0) {
+        vdev->type = XEN_BLOCK_VDEV_TYPE_HD;
+    } else if (strcmp(str, "s") == 0) {
+        vdev->type = XEN_BLOCK_VDEV_TYPE_SD;
+    } else {
+        goto invalid;
+    }
+
+    if (vdev->type == XEN_BLOCK_VDEV_TYPE_DP) {
+        if (qemu_strtoul(p, &end, 10, &vdev->disk)) {
+            goto invalid;
+        }
+
+        if (*end == 'p') {
+            p = (char *) ++end;
+            if (*end == '\0') {
+                goto invalid;
+            }
+        }
+    } else {
+        vdev->disk = vbd_name_to_disk(p, &end);
+    }
+
+    if (*end != '\0') {
+        p = (char *)end;
+
+        if (qemu_strtoul(p, &end, 10, &vdev->partition)) {
+            goto invalid;
+        }
+
+        if (*end != '\0') {
+            goto invalid;
+        }
+    } else {
+        vdev->partition = 0;
+    }
+
+    switch (vdev->type) {
+    case XEN_BLOCK_VDEV_TYPE_DP:
+    case XEN_BLOCK_VDEV_TYPE_XVD:
+        if (vdev->disk < (1 << 4) && vdev->partition < (1 << 4)) {
+            vdev->number = (202 << 8) | (vdev->disk << 4) |
+                vdev->partition;
+        } else if (vdev->disk < (1 << 20) && vdev->partition < (1 << 8)) {
+            vdev->number = (1 << 28) | (vdev->disk << 8) |
+                vdev->partition;
+        } else {
+            goto invalid;
+        }
+        break;
+
+    case XEN_BLOCK_VDEV_TYPE_HD:
+        if ((vdev->disk == 0 || vdev->disk == 1) &&
+            vdev->partition < (1 << 6)) {
+            vdev->number = (3 << 8) | (vdev->disk << 6) | vdev->partition;
+        } else if ((vdev->disk == 2 || vdev->disk == 3) &&
+                   vdev->partition < (1 << 6)) {
+            vdev->number = (22 << 8) | ((vdev->disk - 2) << 6) |
+                vdev->partition;
+        } else {
+            goto invalid;
+        }
+        break;
+
+    case XEN_BLOCK_VDEV_TYPE_SD:
+        if (vdev->disk < (1 << 4) && vdev->partition < (1 << 4)) {
+            vdev->number = (8 << 8) | (vdev->disk << 4) | vdev->partition;
+        } else {
+            goto invalid;
+        }
+        break;
+
+    default:
+        goto invalid;
+    }
+
+    g_free(str);
+    return;
+
+invalid:
+    error_setg(errp, "invalid virtual disk specifier");
+
+    vdev->type = XEN_BLOCK_VDEV_TYPE_INVALID;
+    g_free(str);
+}
+
+/*
+ * This property deals with 'vdev' names adhering to the Xen VBD naming
+ * scheme described in:
+ *
+ * https://xenbits.xen.org/docs/unstable/man/xen-vbd-interface.7.html
+ */
+const PropertyInfo xen_block_prop_vdev = {
+    .name  = "str",
+    .description = "Virtual Disk specifier: d*p*/xvd*/hd*/sd*",
+    .get = xen_block_get_vdev,
+    .set = xen_block_set_vdev,
+};
+
+static Property xen_block_props[] = {
+    DEFINE_PROP("vdev", XenBlockDevice, vdev,
+                xen_block_prop_vdev, XenBlockVdev),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void xen_block_class_init(ObjectClass *class, void *data)
+{
+    DeviceClass *dev_class = DEVICE_CLASS(class);
+    XenDeviceClass *xendev_class = XEN_DEVICE_CLASS(class);
+
+    xendev_class->realize = xen_block_realize;
+    xendev_class->unrealize = xen_block_unrealize;
+
+    dev_class->props = xen_block_props;
+}
+
+static const TypeInfo xen_block_type_info = {
+    .name = TYPE_XEN_BLOCK_DEVICE,
+    .parent = TYPE_XEN_DEVICE,
+    .instance_size = sizeof(XenBlockDevice),
+    .abstract = true,
+    .class_size = sizeof(XenBlockDeviceClass),
+    .class_init = xen_block_class_init,
+};
+
+static void xen_disk_unrealize(XenBlockDevice *blockdev, Error **errp)
+{
+    trace_xen_disk_unrealize();
+}
+
+static void xen_disk_realize(XenBlockDevice *blockdev, Error **errp)
+{
+    trace_xen_disk_realize();
+}
+
+static void xen_disk_class_init(ObjectClass *class, void *data)
+{
+    DeviceClass *dev_class = DEVICE_CLASS(class);
+    XenBlockDeviceClass *blockdev_class = XEN_BLOCK_DEVICE_CLASS(class);
+
+    blockdev_class->realize = xen_disk_realize;
+    blockdev_class->unrealize = xen_disk_unrealize;
+
+    dev_class->desc = "Xen Disk Device";
+}
+
+static const TypeInfo xen_disk_type_info = {
+    .name = TYPE_XEN_DISK_DEVICE,
+    .parent = TYPE_XEN_BLOCK_DEVICE,
+    .instance_size = sizeof(XenDiskDevice),
+    .class_init = xen_disk_class_init,
+};
+
+static void xen_cdrom_unrealize(XenBlockDevice *blockdev, Error **errp)
+{
+    trace_xen_cdrom_unrealize();
+}
+
+static void xen_cdrom_realize(XenBlockDevice *blockdev, Error **errp)
+{
+    trace_xen_cdrom_realize();
+}
+
+static void xen_cdrom_class_init(ObjectClass *class, void *data)
+{
+    DeviceClass *dev_class = DEVICE_CLASS(class);
+    XenBlockDeviceClass *blockdev_class = XEN_BLOCK_DEVICE_CLASS(class);
+
+    blockdev_class->realize = xen_cdrom_realize;
+    blockdev_class->unrealize = xen_cdrom_unrealize;
+
+    dev_class->desc = "Xen CD-ROM Device";
+}
+
+static const TypeInfo xen_cdrom_type_info = {
+    .name = TYPE_XEN_CDROM_DEVICE,
+    .parent = TYPE_XEN_BLOCK_DEVICE,
+    .instance_size = sizeof(XenCDRomDevice),
+    .class_init = xen_cdrom_class_init,
+};
+
+static void xen_block_register_types(void)
+{
+    type_register_static(&xen_block_type_info);
+    type_register_static(&xen_disk_type_info);
+    type_register_static(&xen_cdrom_type_info);
+}
+
+type_init(xen_block_register_types)
diff --git a/include/hw/xen/xen-block.h b/include/hw/xen/xen-block.h
new file mode 100644
index 0000000..067932a
--- /dev/null
+++ b/include/hw/xen/xen-block.h
@@ -0,0 +1,69 @@
+/*
+ * Copyright (c) 2018  Citrix Systems Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_XEN_BLOCK_H
+#define HW_XEN_BLOCK_H
+
+#include "hw/xen/xen-bus.h"
+
+typedef enum XenBlockVdevType {
+    XEN_BLOCK_VDEV_TYPE_INVALID,
+    XEN_BLOCK_VDEV_TYPE_DP,
+    XEN_BLOCK_VDEV_TYPE_XVD,
+    XEN_BLOCK_VDEV_TYPE_HD,
+    XEN_BLOCK_VDEV_TYPE_SD,
+    XEN_BLOCK_VDEV_TYPE__MAX
+} XenBlockVdevType;
+
+typedef struct XenBlockVdev {
+    XenBlockVdevType type;
+    unsigned long disk;
+    unsigned long partition;
+    unsigned long number;
+} XenBlockVdev;
+
+typedef struct XenBlockDevice {
+    XenDevice xendev;
+    XenBlockVdev vdev;
+} XenBlockDevice;
+
+typedef void (*XenBlockDeviceRealize)(XenBlockDevice *blockdev, Error **errp);
+typedef void (*XenBlockDeviceUnrealize)(XenBlockDevice *blockdev, Error **errp);
+
+typedef struct XenBlockDeviceClass {
+    /*< private >*/
+    XenDeviceClass parent_class;
+    /*< public >*/
+    XenBlockDeviceRealize realize;
+    XenBlockDeviceUnrealize unrealize;
+} XenBlockDeviceClass;
+
+#define TYPE_XEN_BLOCK_DEVICE  "xen-block"
+#define XEN_BLOCK_DEVICE(obj) \
+     OBJECT_CHECK(XenBlockDevice, (obj), TYPE_XEN_BLOCK_DEVICE)
+#define XEN_BLOCK_DEVICE_CLASS(class) \
+     OBJECT_CLASS_CHECK(XenBlockDeviceClass, (class), TYPE_XEN_BLOCK_DEVICE)
+#define XEN_BLOCK_DEVICE_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(XenBlockDeviceClass, (obj), TYPE_XEN_BLOCK_DEVICE)
+
+typedef struct XenDiskDevice {
+    XenBlockDevice blockdev;
+} XenDiskDevice;
+
+#define TYPE_XEN_DISK_DEVICE  "xen-disk"
+#define XEN_DISK_DEVICE(obj) \
+     OBJECT_CHECK(XenDiskDevice, (obj), TYPE_XEN_DISK_DEVICE)
+
+typedef struct XenCDRomDevice {
+    XenBlockDevice blockdev;
+} XenCDRomDevice;
+
+#define TYPE_XEN_CDROM_DEVICE  "xen-cdrom"
+#define XEN_CDROM_DEVICE(obj) \
+     OBJECT_CHECK(XenCDRomDevice, (obj), TYPE_XEN_CDROM_DEVICE)
+
+#endif /* HW_XEN_BLOCK_H */
-- 
2.1.4
