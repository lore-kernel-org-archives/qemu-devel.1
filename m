Received: from eggs.gnu.org ([2001:4830:134:3::10]:52515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPURM-0001iL-9o
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPURE-0007iU-MA
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:29:18 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Wed, 21 Nov 2018 15:12:07 +0000
Message-ID: <20181121151211.15997-15-paul.durrant@citrix.com>
In-Reply-To: <20181121151211.15997-1-paul.durrant@citrix.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 14/18] xen: add implementations of xen-qdisk
 connect and disconnect functions...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

...and wire in the dataplane.

This patch adds the remaining code to make the xen-qdisk XenDevice
functional. The parameters that a block frontend expects to find are
populated in the backend xenstore area, and the 'ring-ref' and
'event-channel' values specified in the frontend xenstore area are
mapped/bound and used to set up the dataplane.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
---
 hw/block/xen-qdisk.c       | 140 +++++++++++++++++++++++++++++++++++++++++++++
 hw/xen/xen-bus.c           |  12 ++--
 include/hw/xen/xen-bus.h   |   8 +++
 include/hw/xen/xen-qdisk.h |  12 ++++
 4 files changed, 166 insertions(+), 6 deletions(-)

diff --git a/hw/block/xen-qdisk.c b/hw/block/xen-qdisk.c
index 35f7b70480..8c88393832 100644
--- a/hw/block/xen-qdisk.c
+++ b/hw/block/xen-qdisk.c
@@ -9,6 +9,10 @@
 #include "qapi/visitor.h"
 #include "hw/hw.h"
 #include "hw/xen/xen-qdisk.h"
+#include "sysemu/blockdev.h"
+#include "sysemu/block-backend.h"
+#include "sysemu/iothread.h"
+#include "dataplane/xen-qdisk.h"
 #include "trace.h"
 
 static char *xen_qdisk_get_name(XenDevice *xendev, Error **errp)
@@ -23,6 +27,11 @@ static void xen_qdisk_realize(XenDevice *xendev, Error **errp)
 {
     XenQdiskDevice *qdiskdev = XEN_QDISK_DEVICE(xendev);
     XenQdiskVdev *vdev = &qdiskdev->vdev;
+    BlockConf *conf = &qdiskdev->conf;
+    DriveInfo *dinfo;
+    bool is_cdrom;
+    unsigned int info;
+    int64_t size;
 
     if (!vdev->valid) {
         error_setg(errp, "vdev property not set");
@@ -30,13 +39,134 @@ static void xen_qdisk_realize(XenDevice *xendev, Error **errp)
     }
 
     trace_xen_qdisk_realize(vdev->disk, vdev->partition);
+
+    if (!conf->blk) {
+        error_setg(errp, "drive property not set");
+        return;
+    }
+
+    if (!blk_is_inserted(conf->blk)) {
+        error_setg(errp, "device needs media, but drive is empty");
+        return;
+    }
+
+    if (!blkconf_apply_backend_options(conf, blk_is_read_only(conf->blk),
+                                       false, errp)) {
+        return;
+    }
+
+    if (!blkconf_geometry(conf, NULL, 65535, 255, 255, errp)) {
+        return;
+    }
+
+    dinfo = blk_legacy_dinfo(conf->blk);
+    is_cdrom = (dinfo && dinfo->media_cd);
+
+    blkconf_blocksizes(conf);
+
+    if (conf->logical_block_size > conf->physical_block_size) {
+        error_setg(
+            errp, "logical_block_size > physical_block_size not supported");
+        return;
+    }
+
+    blk_set_guest_block_size(conf->blk, conf->logical_block_size);
+
+    if (conf->discard_granularity > 0) {
+        xen_device_backend_printf(xendev, "feature-discard", "%u", 1);
+    }
+
+    xen_device_backend_printf(xendev, "feature-flush-cache", "%u", 1);
+    xen_device_backend_printf(xendev, "max-ring-page-order", "%u",
+                              qdiskdev->max_ring_page_order);
+
+    info = blk_is_read_only(conf->blk) ? VDISK_READONLY : 0;
+    info |= is_cdrom ? VDISK_CDROM : 0;
+
+    xen_device_backend_printf(xendev, "info", "%u", info);
+
+    xen_device_frontend_printf(xendev, "virtual-device", "%u",
+                               vdev->number);
+    xen_device_frontend_printf(xendev, "device-type", "%s",
+                               is_cdrom ? "cdrom" : "disk");
+
+    size = blk_getlength(conf->blk);
+    xen_device_backend_printf(xendev, "sector-size", "%u",
+                              conf->logical_block_size);
+    xen_device_backend_printf(xendev, "sectors", "%lu",
+                              size / conf->logical_block_size);
+
+    qdiskdev->dataplane = xen_qdisk_dataplane_create(xendev, conf,
+                                                     qdiskdev->iothread);
 }
 
 static void xen_qdisk_connect(XenQdiskDevice *qdiskdev, Error **errp)
 {
     XenQdiskVdev *vdev = &qdiskdev->vdev;
+    XenDevice *xendev = XEN_DEVICE(qdiskdev);
+    unsigned int order, nr_ring_ref, *ring_ref, event_channel, protocol;
+    char *str;
 
     trace_xen_qdisk_connect(vdev->disk, vdev->partition);
+
+    if (xen_device_frontend_scanf(xendev, "ring-page-order", "%u",
+                                  &order) != 1) {
+        nr_ring_ref = 1;
+        ring_ref = g_new(unsigned int, nr_ring_ref);
+
+        if (xen_device_frontend_scanf(xendev, "ring-ref", "%u",
+                                      &ring_ref[0]) != 1) {
+            error_setg(errp, "failed to read ring-ref");
+            return;
+        }
+    } else if (order <= qdiskdev->max_ring_page_order) {
+        unsigned int i;
+
+        nr_ring_ref = 1 << order;
+        ring_ref = g_new(unsigned int, nr_ring_ref);
+
+        for (i = 0; i < nr_ring_ref; i++) {
+            const char *key = g_strdup_printf("ring-ref%u", i);
+
+            if (xen_device_frontend_scanf(xendev, key, "%u",
+                                          &ring_ref[i]) != 1) {
+                error_setg(errp, "failed to read %s", key);
+                g_free((gpointer)key);
+                return;
+            }
+
+            g_free((gpointer)key);
+        }
+    } else {
+        error_setg(errp, "invalid ring-page-order (%d)", order);
+        return;
+    }
+
+    if (xen_device_frontend_scanf(xendev, "event-channel", "%u",
+                                  &event_channel) != 1) {
+        error_setg(errp, "failed to read event-channel");
+        return;
+    }
+
+    if (xen_device_frontend_scanf(xendev, "protocol", "%ms",
+                                  &str) != 1) {
+        protocol = BLKIF_PROTOCOL_NATIVE;
+    } else {
+        if (strcmp(str, XEN_IO_PROTO_ABI_X86_32) == 0) {
+            protocol = BLKIF_PROTOCOL_X86_32;
+        } else if (strcmp(str, XEN_IO_PROTO_ABI_X86_64) == 0) {
+            protocol = BLKIF_PROTOCOL_X86_64;
+        } else {
+            protocol = BLKIF_PROTOCOL_NATIVE;
+        }
+
+        free(str);
+    }
+
+    xen_qdisk_dataplane_start(qdiskdev->dataplane, ring_ref, nr_ring_ref,
+                              event_channel, protocol);
+
+    g_free(ring_ref);
 }
 
 static void xen_qdisk_disconnect(XenQdiskDevice *qdiskdev, Error **errp)
@@ -44,6 +174,8 @@ static void xen_qdisk_disconnect(XenQdiskDevice *qdiskdev, Error **errp)
     XenQdiskVdev *vdev = &qdiskdev->vdev;
 
     trace_xen_qdisk_disconnect(vdev->disk, vdev->partition);
+
+    xen_qdisk_dataplane_stop(qdiskdev->dataplane);
 }
 
 static void xen_qdisk_frontend_changed(XenDevice *xendev,
@@ -93,6 +225,9 @@ static void xen_qdisk_unrealize(XenDevice *xendev, Error **errp)
     trace_xen_qdisk_unrealize(vdev->disk, vdev->partition);
 
     xen_qdisk_disconnect(qdiskdev, &error_fatal);
+
+    xen_qdisk_dataplane_destroy(qdiskdev->dataplane);
+    qdiskdev->dataplane = NULL;
 }
 
 static char *disk_to_vbd_name(unsigned int disk)
@@ -289,6 +424,11 @@ const PropertyInfo xen_qdisk_prop_vdev = {
 static Property xen_qdisk_props[] = {
     DEFINE_PROP("vdev", XenQdiskDevice, vdev,
                 xen_qdisk_prop_vdev, XenQdiskVdev),
+    DEFINE_BLOCK_PROPERTIES(XenQdiskDevice, conf),
+    DEFINE_PROP_UINT32("max-ring-page-order", XenQdiskDevice,
+                       max_ring_page_order, 4),
+    DEFINE_PROP_LINK("iothread", XenQdiskDevice, iothread, TYPE_IOTHREAD,
+                     IOThread *),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 64c8af54b0..c4b253103f 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -217,8 +217,8 @@ static const TypeInfo xen_bus_type_info = {
     .class_init = xen_bus_class_init,
 };
 
-static void xen_device_backend_printf(XenDevice *xendev, const char *key,
-                                      const char *fmt, ...)
+void xen_device_backend_printf(XenDevice *xendev, const char *key,
+                               const char *fmt, ...)
 {
     XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
     va_list ap;
@@ -305,8 +305,8 @@ static void xen_device_backend_destroy(XenDevice *xendev)
     g_free(xendev->backend_path);
 }
 
-static void xen_device_frontend_printf(XenDevice *xendev, const char *key,
-                                       const char *fmt, ...)
+void xen_device_frontend_printf(XenDevice *xendev, const char *key,
+                                const char *fmt, ...)
 {
     XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
     va_list ap;
@@ -318,8 +318,8 @@ static void xen_device_frontend_printf(XenDevice *xendev, const char *key,
     va_end(ap);
 }
 
-static int xen_device_frontend_scanf(XenDevice *xendev, const char *key,
-                                      const char *fmt, ...)
+int xen_device_frontend_scanf(XenDevice *xendev, const char *key,
+                              const char *fmt, ...)
 {
     XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
     va_list ap;
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 386f6bfc93..d931e01268 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -82,6 +82,14 @@ void xen_device_backend_set_state(XenDevice *xendev,
                                   enum xenbus_state state);
 enum xenbus_state xen_device_backend_get_state(XenDevice *xendev);
 
+void xen_device_backend_printf(XenDevice *xendev, const char *key,
+                               const char *fmt, ...);
+
+void xen_device_frontend_printf(XenDevice *xendev, const char *key,
+                                const char *fmt, ...);
+int xen_device_frontend_scanf(XenDevice *xendev, const char *key,
+                              const char *fmt, ...);
+
 void xen_device_set_max_grant_refs(XenDevice *xendev, unsigned int nr_refs,
                                    Error **errp);
 void *xen_device_map_grant_refs(XenDevice *xendev, uint32_t *refs,
diff --git a/include/hw/xen/xen-qdisk.h b/include/hw/xen/xen-qdisk.h
index ade0866037..d7dd2bf0ee 100644
--- a/include/hw/xen/xen-qdisk.h
+++ b/include/hw/xen/xen-qdisk.h
@@ -6,7 +6,15 @@
 #ifndef HW_XEN_QDISK_H
 #define HW_XEN_QDISK_H
 
+#include "hw/xen/xen.h"
 #include "hw/xen/xen-bus.h"
+#include "hw/block/block.h"
+#include "hw/block/xen_blkif.h"
+#include "hw/block/dataplane/xen-qdisk.h"
+#include "sysemu/blockdev.h"
+#include "sysemu/iothread.h"
+#include "sysemu/block-backend.h"
+#include "sysemu/iothread.h"
 
 typedef enum XenQdiskVdevType {
     XEN_QDISK_VDEV_TYPE_DP,
@@ -33,6 +41,10 @@ typedef struct XenQdiskDevice XenQdiskDevice;
 struct XenQdiskDevice {
     XenDevice xendev;
     XenQdiskVdev vdev;
+    BlockConf conf;
+    unsigned int max_ring_page_order;
+    IOThread *iothread;
+    XenQdiskDataPlane *dataplane;
 };
 
 #endif /* HW_XEN_QDISK_H */
-- 
2.11.0
