Received: from eggs.gnu.org ([2001:4830:134:3::10]:46112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPUB3-0005Tg-Tl
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:12:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPUB1-0003ey-KD
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:12:29 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Wed, 21 Nov 2018 15:11:56 +0000
Message-ID: <20181121151211.15997-4-paul.durrant@citrix.com>
In-Reply-To: <20181121151211.15997-1-paul.durrant@citrix.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 03/18] xen: introduce 'xen-qdisk'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

This patch adds a new XenDevice: 'xen-qdisk' [1]. This will eventually
replace the 'xen_disk' legacy PV backend but it is illustrative to build
up the implementation incrementally, along with the XenBus/XenDevice
framework. Subsequent patches will therefore add to this device's
implementation as new features are added to the framework.

After this patch has been applied it is possible to instantiate a new
'xen-qdisk' device with a single 'vdev' parameter, which accepts values
adhering to the Xen VBD naming scheme [2]. For example, a command-line
instantiation of a xen-qdisk can be done with an argument similar to the
following:

-device xen-qdisk,vdev=hda

The implementation of the vdev parameter formulates the appropriate VBD
number for use in the PV protocol.

[1] The name 'qdisk' as always been the name given to the QEMU
    implementation of the Xen PV block protocol backend implementation
[2] http://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=docs/man/xen-vbd-interface.markdown.7

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
---
 MAINTAINERS                |   2 +-
 hw/block/Makefile.objs     |   1 +
 hw/block/trace-events      |   4 +
 hw/block/xen-qdisk.c       | 256 +++++++++++++++++++++++++++++++++++++++++++++
 include/hw/xen/xen-qdisk.h |  38 +++++++
 5 files changed, 300 insertions(+), 1 deletion(-)
 create mode 100644 hw/block/xen-qdisk.c
 create mode 100644 include/hw/xen/xen-qdisk.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1032406c56..10f048a503 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -389,7 +389,7 @@ F: hw/9pfs/xen-9p-backend.c
 F: hw/char/xen_console.c
 F: hw/display/xenfb.c
 F: hw/net/xen_nic.c
-F: hw/block/xen_*
+F: hw/block/xen*
 F: hw/xen/
 F: hw/xenpv/
 F: hw/i386/xen/
diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index 53ce5751ae..bcdd36d318 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -5,6 +5,7 @@ common-obj-$(CONFIG_NAND) += nand.o
 common-obj-$(CONFIG_PFLASH_CFI01) += pflash_cfi01.o
 common-obj-$(CONFIG_PFLASH_CFI02) += pflash_cfi02.o
 common-obj-$(CONFIG_XEN) += xen_disk.o
+common-obj-$(CONFIG_XEN) += xen-qdisk.o
 common-obj-$(CONFIG_ECC) += ecc.o
 common-obj-$(CONFIG_ONENAND) += onenand.o
 common-obj-$(CONFIG_NVME_PCI) += nvme.o
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 335c092450..fd3c126ac1 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -127,3 +127,7 @@ xen_disk_init(char *name) "%s"
 xen_disk_connect(char *name) "%s"
 xen_disk_disconnect(char *name) "%s"
 xen_disk_free(char *name) "%s"
+
+# hw/block/xen-qdisk.c
+xen_qdisk_realize(uint32_t disk, uint32_t partition) "d%up%u"
+xen_qdisk_unrealize(uint32_t disk, uint32_t partition) "d%up%u"
diff --git a/hw/block/xen-qdisk.c b/hw/block/xen-qdisk.c
new file mode 100644
index 0000000000..72122073f7
--- /dev/null
+++ b/hw/block/xen-qdisk.c
@@ -0,0 +1,256 @@
+/*
+ * Copyright (c) Citrix Systems Inc.
+ * All rights reserved.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "hw/hw.h"
+#include "hw/xen/xen-qdisk.h"
+#include "trace.h"
+
+static void xen_qdisk_realize(XenDevice *xendev, Error **errp)
+{
+    XenQdiskDevice *qdiskdev = XEN_QDISK_DEVICE(xendev);
+    XenQdiskVdev *vdev = &qdiskdev->vdev;
+
+    if (!vdev->valid) {
+        error_setg(errp, "vdev property not set");
+        return;
+    }
+
+    trace_xen_qdisk_realize(vdev->disk, vdev->partition);
+}
+
+static void xen_qdisk_unrealize(XenDevice *xendev, Error **errp)
+{
+    XenQdiskDevice *qdiskdev = XEN_QDISK_DEVICE(xendev);
+    XenQdiskVdev *vdev = &qdiskdev->vdev;
+
+    trace_xen_qdisk_unrealize(vdev->disk, vdev->partition);
+}
+
+static char *disk_to_vbd_name(unsigned int disk)
+{
+    unsigned int len = DIV_ROUND_UP(disk, 26);
+    char *name = g_malloc0(len + 1);
+
+    do {
+        name[len--] = 'a' + (disk % 26);
+        disk /= 26;
+    } while (disk != 0);
+    assert(len == 0);
+
+    return name;
+}
+
+static void xen_qdisk_get_vdev(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    XenQdiskVdev *vdev = qdev_get_prop_ptr(dev, prop);
+    char *str;
+
+    switch (vdev->type) {
+    case XEN_QDISK_VDEV_TYPE_DP:
+        str = g_strdup_printf("d%lup%lu", vdev->disk, vdev->partition);
+        break;
+
+    case XEN_QDISK_VDEV_TYPE_XVD:
+    case XEN_QDISK_VDEV_TYPE_HD:
+    case XEN_QDISK_VDEV_TYPE_SD: {
+        char *name = disk_to_vbd_name(vdev->disk);
+
+        str = g_strdup_printf("%s%s%lu",
+                              (vdev->type == XEN_QDISK_VDEV_TYPE_XVD) ?
+                              "xvd" :
+                              (vdev->type == XEN_QDISK_VDEV_TYPE_HD) ?
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
+        disk += *name++ - 'a';
+    }
+    *endp = name;
+
+    return disk;
+}
+
+static void xen_qdisk_set_vdev(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    XenQdiskVdev *vdev = qdev_get_prop_ptr(dev, prop);
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
+        vdev->type = XEN_QDISK_VDEV_TYPE_DP;
+    } else if (strcmp(str, "xv") == 0) {
+        vdev->type = XEN_QDISK_VDEV_TYPE_XVD;
+    } else if (strcmp(str, "h") == 0) {
+        vdev->type = XEN_QDISK_VDEV_TYPE_HD;
+    } else if (strcmp(str, "s") == 0) {
+        vdev->type = XEN_QDISK_VDEV_TYPE_SD;
+    } else {
+        goto invalid;
+    }
+
+    if (vdev->type == XEN_QDISK_VDEV_TYPE_DP) {
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
+    case XEN_QDISK_VDEV_TYPE_DP:
+    case XEN_QDISK_VDEV_TYPE_XVD:
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
+    case XEN_QDISK_VDEV_TYPE_HD:
+        if ((vdev->disk == 0 || vdev->disk == 1) &&
+            vdev->partition < (1 << 4)) {
+            vdev->number = (3 << 8) | (vdev->disk << 6) | vdev->partition;
+        } else if ((vdev->disk == 2 || vdev->disk == 3) &&
+                   vdev->partition < (1 << 4)) {
+            vdev->number = (22 << 8) | ((vdev->disk - 2) << 6) |
+                vdev->partition;
+        } else {
+            goto invalid;
+        }
+        break;
+
+    case XEN_QDISK_VDEV_TYPE_SD:
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
+    vdev->valid = true;
+    return;
+
+invalid:
+    error_setg(errp, "invalid virtual disk specifier");
+    g_free(str);
+}
+
+const PropertyInfo xen_qdisk_prop_vdev = {
+    .name  = "str",
+    .description = "Virtual Disk specifier: d*p*/xvd*/hd*/sd*",
+    .get = xen_qdisk_get_vdev,
+    .set = xen_qdisk_set_vdev,
+};
+
+static Property xen_qdisk_props[] = {
+    DEFINE_PROP("vdev", XenQdiskDevice, vdev,
+                xen_qdisk_prop_vdev, XenQdiskVdev),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void xen_qdisk_class_init(ObjectClass *class, void *data)
+{
+    DeviceClass *dev_class = DEVICE_CLASS(class);
+    XenDeviceClass *xendev_class = XEN_DEVICE_CLASS(class);
+
+    xendev_class->realize = xen_qdisk_realize;
+    xendev_class->unrealize = xen_qdisk_unrealize;
+
+    dev_class->desc = "Xen Qdisk Device";
+    dev_class->props = xen_qdisk_props;
+}
+
+static const TypeInfo xen_qdisk_type_info = {
+    .name = TYPE_XEN_QDISK_DEVICE,
+    .parent = TYPE_XEN_DEVICE,
+    .instance_size = sizeof(XenQdiskDevice),
+    .class_init = xen_qdisk_class_init,
+};
+
+static void xen_qdisk_register_types(void)
+{
+    type_register_static(&xen_qdisk_type_info);
+}
+
+type_init(xen_qdisk_register_types)
diff --git a/include/hw/xen/xen-qdisk.h b/include/hw/xen/xen-qdisk.h
new file mode 100644
index 0000000000..ade0866037
--- /dev/null
+++ b/include/hw/xen/xen-qdisk.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright (c) Citrix Systems Inc.
+ * All rights reserved.
+ */
+
+#ifndef HW_XEN_QDISK_H
+#define HW_XEN_QDISK_H
+
+#include "hw/xen/xen-bus.h"
+
+typedef enum XenQdiskVdevType {
+    XEN_QDISK_VDEV_TYPE_DP,
+    XEN_QDISK_VDEV_TYPE_XVD,
+    XEN_QDISK_VDEV_TYPE_HD,
+    XEN_QDISK_VDEV_TYPE_SD,
+    XEN_QDISK_VDEV_TYPE__MAX
+} XenQdiskVdevType;
+
+typedef struct XenQdiskVdev {
+    XenQdiskVdevType type;
+    unsigned long disk;
+    unsigned long partition;
+    unsigned long number;
+    bool valid;
+} XenQdiskVdev;
+
+#define TYPE_XEN_QDISK_DEVICE  "xen-qdisk"
+#define XEN_QDISK_DEVICE(obj) \
+     OBJECT_CHECK(XenQdiskDevice, (obj), TYPE_XEN_QDISK_DEVICE)
+
+typedef struct XenQdiskDevice XenQdiskDevice;
+
+struct XenQdiskDevice {
+    XenDevice xendev;
+    XenQdiskVdev vdev;
+};
+
+#endif /* HW_XEN_QDISK_H */
-- 
2.11.0
