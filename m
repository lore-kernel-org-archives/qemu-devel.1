Received: from eggs.gnu.org ([2001:4830:134:3::10]:49163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8715dceb6=Paul.Durrant@citrix.com>)
	id 1gUva3-0002N7-Su
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:28:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8715dceb6=Paul.Durrant@citrix.com>)
	id 1gUvZz-0007Tl-Qo
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:28:47 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Thu, 6 Dec 2018 15:08:40 +0000
Message-ID: <1544108924-10841-15-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1544108924-10841-1-git-send-email-paul.durrant@citrix.com>
References: <1544108924-10841-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 14/18] xen: add implementations of xen-block
 connect and disconnect functions...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

...and wire in the dataplane.

This patch adds the remaining code to make the xen-block XenDevice
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

v2:
 - Tidy up header inclusions
 - Stop leaking ring_ref on error
 - Auto-create drive for CDRom devices
---
 hw/block/xen-block.c       | 164 +++++++++++++++++++++++++++++++++++++++++++++
 hw/xen/xen-bus.c           |  12 ++--
 include/hw/xen/xen-block.h |   9 +++
 include/hw/xen/xen-bus.h   |  10 +++
 4 files changed, 189 insertions(+), 6 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index d2334ef..fc64aaf 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -10,7 +10,13 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "hw/hw.h"
+#include "hw/xen/xen_common.h"
+#include "hw/block/xen_blkif.h"
 #include "hw/xen/xen-block.h"
+#include "sysemu/blockdev.h"
+#include "sysemu/block-backend.h"
+#include "sysemu/iothread.h"
+#include "dataplane/xen-block.h"
 #include "trace.h"
 
 static char *xen_block_get_name(XenDevice *xendev, Error **errp)
@@ -28,6 +34,8 @@ static void xen_block_disconnect(XenDevice *xendev, Error **errp)
     XenBlockVdev *vdev = &blockdev->vdev;
 
     trace_xen_block_disconnect(type, vdev->disk, vdev->partition);
+
+    xen_block_dataplane_stop(blockdev->dataplane);
 }
 
 static void xen_block_connect(XenDevice *xendev, Error **errp)
@@ -35,8 +43,72 @@ static void xen_block_connect(XenDevice *xendev, Error **errp)
     XenBlockDevice *blockdev = XEN_BLOCK_DEVICE(xendev);
     const char *type = object_get_typename(OBJECT(blockdev));
     XenBlockVdev *vdev = &blockdev->vdev;
+    unsigned int order, nr_ring_ref, *ring_ref, event_channel, protocol;
+    char *str;
 
     trace_xen_block_connect(type, vdev->disk, vdev->partition);
+
+    if (xen_device_frontend_scanf(xendev, "ring-page-order", "%u",
+                                  &order) != 1) {
+        nr_ring_ref = 1;
+        ring_ref = g_new(unsigned int, nr_ring_ref);
+
+        if (xen_device_frontend_scanf(xendev, "ring-ref", "%u",
+                                      &ring_ref[0]) != 1) {
+            error_setg(errp, "failed to read ring-ref");
+            g_free(ring_ref);
+            return;
+        }
+    } else if (order <= blockdev->max_ring_page_order) {
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
+                g_free(ring_ref);
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
+        g_free(ring_ref);
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
+    xen_block_dataplane_start(blockdev->dataplane, ring_ref, nr_ring_ref,
+                              event_channel, protocol, errp);
+
+    g_free(ring_ref);
 }
 
 static void xen_block_unrealize(XenDevice *xendev, Error **errp)
@@ -60,6 +132,9 @@ static void xen_block_unrealize(XenDevice *xendev, Error **errp)
         error_propagate(errp, local_err);
     }
 
+    xen_block_dataplane_destroy(blockdev->dataplane);
+    blockdev->dataplane = NULL;
+
     if (blockdev_class->unrealize) {
         blockdev_class->unrealize(blockdev, &local_err);
         if (local_err) {
@@ -76,6 +151,7 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
     const char *type = object_get_typename(OBJECT(blockdev));
     XenBlockVdev *vdev = &blockdev->vdev;
     Error *local_err = NULL;
+    BlockConf *conf = &blockdev->conf;
 
     if (vdev->type == XEN_BLOCK_VDEV_TYPE_INVALID) {
         error_setg(errp, "vdev property not set");
@@ -90,6 +166,59 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
             error_propagate(errp, local_err);
         }
     }
+
+    /*
+     * The blkif protocol does not deal with removable media, so it must
+     * always be present, even for CDRom devices.
+     */
+    assert(conf->blk);
+    if (!blk_is_inserted(conf->blk)) {
+        error_setg(errp, "device needs media, but drive is empty");
+        return;
+    }
+
+    if (!blkconf_apply_backend_options(conf, blockdev->info & VDISK_READONLY,
+                                       false, errp)) {
+        return;
+    }
+
+    if (!(blockdev->info & VDISK_CDROM) &&
+        !blkconf_geometry(conf, NULL, 65535, 255, 255, errp)) {
+        return;
+    }
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
+                              blockdev->max_ring_page_order);
+    xen_device_backend_printf(xendev, "info", "%u", blockdev->info);
+
+    xen_device_frontend_printf(xendev, "virtual-device", "%lu",
+                               vdev->number);
+    xen_device_frontend_printf(xendev, "device-type", "%s",
+                               blockdev->device_type);
+
+    xen_device_backend_printf(xendev, "sector-size", "%u",
+                              conf->logical_block_size);
+    xen_device_backend_printf(xendev, "sectors", "%lu",
+                              blk_getlength(conf->blk) /
+                              conf->logical_block_size);
+
+    blockdev->dataplane = xen_block_dataplane_create(xendev, conf,
+                                                     blockdev->iothread);
 }
 
 static void xen_block_frontend_changed(XenDevice *xendev,
@@ -338,6 +467,11 @@ const PropertyInfo xen_block_prop_vdev = {
 static Property xen_block_props[] = {
     DEFINE_PROP("vdev", XenBlockDevice, vdev,
                 xen_block_prop_vdev, XenBlockVdev),
+    DEFINE_BLOCK_PROPERTIES(XenBlockDevice, conf),
+    DEFINE_PROP_UINT32("max-ring-page-order", XenBlockDevice,
+                       max_ring_page_order, 4),
+    DEFINE_PROP_LINK("iothread", XenBlockDevice, iothread, TYPE_IOTHREAD,
+                     IOThread *),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -370,7 +504,18 @@ static void xen_disk_unrealize(XenBlockDevice *blockdev, Error **errp)
 
 static void xen_disk_realize(XenBlockDevice *blockdev, Error **errp)
 {
+    BlockConf *conf = &blockdev->conf;
+
     trace_xen_disk_realize();
+
+    blockdev->device_type = "disk";
+
+    if (!conf->blk) {
+        error_setg(errp, "drive property not set");
+        return;
+    }
+
+    blockdev->info = blk_is_read_only(conf->blk) ? VDISK_READONLY : 0;
 }
 
 static void xen_disk_class_init(ObjectClass *class, void *data)
@@ -398,7 +543,26 @@ static void xen_cdrom_unrealize(XenBlockDevice *blockdev, Error **errp)
 
 static void xen_cdrom_realize(XenBlockDevice *blockdev, Error **errp)
 {
+    BlockConf *conf = &blockdev->conf;
+
     trace_xen_cdrom_realize();
+
+    blockdev->device_type = "cdrom";
+
+    if (!conf->blk) {
+        int rc;
+
+        /* Set up an empty drive */
+        conf->blk = blk_new(0, BLK_PERM_ALL);
+
+        rc = blk_attach_dev(conf->blk, DEVICE(blockdev));
+        if (!rc) {
+            error_setg_errno(errp, -rc, "failed to create drive");
+            return;
+        }
+    }
+
+    blockdev->info = VDISK_READONLY | VDISK_CDROM;
 }
 
 static void xen_cdrom_class_init(ObjectClass *class, void *data)
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 0e6f194..1b3837c 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -236,8 +236,8 @@ static const TypeInfo xen_bus_type_info = {
     },
 };
 
-static void xen_device_backend_printf(XenDevice *xendev, const char *key,
-                                      const char *fmt, ...)
+void xen_device_backend_printf(XenDevice *xendev, const char *key,
+                               const char *fmt, ...)
 {
     XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
     Error *local_err = NULL;
@@ -336,8 +336,8 @@ static void xen_device_backend_destroy(XenDevice *xendev)
     }
 }
 
-static void xen_device_frontend_printf(XenDevice *xendev, const char *key,
-                                       const char *fmt, ...)
+void xen_device_frontend_printf(XenDevice *xendev, const char *key,
+                                const char *fmt, ...)
 {
     XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
     Error *local_err = NULL;
@@ -355,8 +355,8 @@ static void xen_device_frontend_printf(XenDevice *xendev, const char *key,
     }
 }
 
-static int xen_device_frontend_scanf(XenDevice *xendev, const char *key,
-                                     const char *fmt, ...)
+int xen_device_frontend_scanf(XenDevice *xendev, const char *key,
+                              const char *fmt, ...)
 {
     XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
     va_list ap;
diff --git a/include/hw/xen/xen-block.h b/include/hw/xen/xen-block.h
index 067932a..37ed8a6 100644
--- a/include/hw/xen/xen-block.h
+++ b/include/hw/xen/xen-block.h
@@ -9,6 +9,9 @@
 #define HW_XEN_BLOCK_H
 
 #include "hw/xen/xen-bus.h"
+#include "hw/block/block.h"
+#include "hw/block/dataplane/xen-block.h"
+#include "sysemu/iothread.h"
 
 typedef enum XenBlockVdevType {
     XEN_BLOCK_VDEV_TYPE_INVALID,
@@ -29,6 +32,12 @@ typedef struct XenBlockVdev {
 typedef struct XenBlockDevice {
     XenDevice xendev;
     XenBlockVdev vdev;
+    BlockConf conf;
+    const char *device_type;
+    unsigned int info;
+    unsigned int max_ring_page_order;
+    IOThread *iothread;
+    XenBlockDataPlane *dataplane;
 } XenBlockDevice;
 
 typedef void (*XenBlockDeviceRealize)(XenBlockDevice *blockdev, Error **errp);
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index f83a95c..d7f0f0a 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -84,6 +84,16 @@ void xen_device_backend_set_state(XenDevice *xendev,
                                   enum xenbus_state state);
 enum xenbus_state xen_device_backend_get_state(XenDevice *xendev);
 
+void xen_device_backend_printf(XenDevice *xendev, const char *key,
+                               const char *fmt, ...)
+    GCC_FMT_ATTR(3, 4);
+void xen_device_frontend_printf(XenDevice *xendev, const char *key,
+                                const char *fmt, ...)
+    GCC_FMT_ATTR(3, 4);
+
+int xen_device_frontend_scanf(XenDevice *xendev, const char *key,
+                              const char *fmt, ...);
+
 void xen_device_set_max_grant_refs(XenDevice *xendev, unsigned int nr_refs,
                                    Error **errp);
 void *xen_device_map_grant_refs(XenDevice *xendev, uint32_t *refs,
-- 
2.1.4
