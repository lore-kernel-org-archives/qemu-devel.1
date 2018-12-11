Received: from eggs.gnu.org ([2001:4830:134:3::10]:53285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWkRb-0005wa-NX
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:59:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWkRT-0005FF-2G
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:59:31 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Tue, 11 Dec 2018 15:57:40 +0000
Message-ID: <1544543862-9997-17-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1544543862-9997-1-git-send-email-paul.durrant@citrix.com>
References: <1544543862-9997-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 16/18] xen: automatically create
 XenBlockDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

This patch adds a creator function for XenBlockDevice-s so that they can
be created automatically when the Xen toolstack instantiates a new
PV backend. When the XenBlockDevice is created this way it is also
necessary to create a drive which matches the configuration that the Xen
toolstack has written into xenstore. This drive is marked 'auto_del' so
that it will be removed when the XenBlockDevice is destroyed. Also, for
compatibility with the legacy 'xen_disk' implementation, an iothread
is automatically created for the new XenBlockDevice. This will also be
removed when the XenBlockDevice is destroyed.

Correspondingly the legacy backend scan for 'qdisk' is removed.

After this patch is applied the legacy 'xen_disk' code is redundant. It
will be removed by a subsequent patch.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Anthony Perard <anthony.perard@citrix.com>
---
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>

v2:
 - Get rid of error_abort
 - Don't use qdev_init_nofail
 - Explain why file locking needs to be off
---
 hw/block/trace-events       |   1 +
 hw/block/xen-block.c        | 261 +++++++++++++++++++++++++++++++++++++++++++-
 hw/xen/xen-legacy-backend.c |   1 -
 include/hw/xen/xen-block.h  |   1 +
 4 files changed, 262 insertions(+), 2 deletions(-)

diff --git a/hw/block/trace-events b/hw/block/trace-events
index 89e2583..a89c8a6 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -137,3 +137,4 @@ xen_disk_realize(void) ""
 xen_disk_unrealize(void) ""
 xen_cdrom_realize(void) ""
 xen_cdrom_unrealize(void) ""
+xen_block_device_create(const char *name) "name: %s"
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index f3d21c6..0d1616d 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -7,12 +7,15 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/option.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "qapi/qmp/qdict.h"
 #include "hw/hw.h"
 #include "hw/xen/xen_common.h"
 #include "hw/block/xen_blkif.h"
 #include "hw/xen/xen-block.h"
+#include "hw/xen/xen-backend.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/iothread.h"
@@ -131,6 +134,11 @@ static void xen_block_unrealize(XenDevice *xendev, Error **errp)
     xen_block_dataplane_destroy(blockdev->dataplane);
     blockdev->dataplane = NULL;
 
+    if (blockdev->auto_iothread) {
+        iothread_destroy(blockdev->auto_iothread);
+        blockdev->auto_iothread = NULL;
+    }
+
     if (blockdev_class->unrealize) {
         blockdev_class->unrealize(blockdev, errp);
     }
@@ -145,6 +153,8 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
     XenBlockVdev *vdev = &blockdev->vdev;
     Error *local_err = NULL;
     BlockConf *conf = &blockdev->conf;
+    IOThread *iothread = blockdev->auto_iothread ?
+        blockdev->auto_iothread : blockdev->iothread;
 
     if (vdev->type == XEN_BLOCK_VDEV_TYPE_INVALID) {
         error_setg(errp, "vdev property not set");
@@ -212,7 +222,7 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
                               conf->logical_block_size);
 
     blockdev->dataplane = xen_block_dataplane_create(xendev, conf,
-                                                     blockdev->iothread);
+                                                     iothread);
 }
 
 static void xen_block_frontend_changed(XenDevice *xendev,
@@ -474,6 +484,7 @@ static void xen_block_class_init(ObjectClass *class, void *data)
     DeviceClass *dev_class = DEVICE_CLASS(class);
     XenDeviceClass *xendev_class = XEN_DEVICE_CLASS(class);
 
+    xendev_class->backend = "qdisk";
     xendev_class->device = "vbd";
     xendev_class->get_name = xen_block_get_name;
     xendev_class->realize = xen_block_realize;
@@ -586,3 +597,251 @@ static void xen_block_register_types(void)
 }
 
 type_init(xen_block_register_types)
+
+static void xen_block_drive_create(const char *id, const char *device_type,
+                                   QDict *opts, Error **errp)
+{
+    const char *params = qdict_get_try_str(opts, "params");
+    const char *mode = qdict_get_try_str(opts, "mode");
+    const char *direct_io_safe = qdict_get_try_str(opts, "direct-io-safe");
+    const char *discard_enable = qdict_get_try_str(opts, "discard-enable");
+    char *format = NULL;
+    char *file = NULL;
+    char *drive_optstr = NULL;
+    QemuOpts *drive_opts;
+    Error *local_err = NULL;
+
+    if (params) {
+        char **v = g_strsplit(params, ":", 2);
+
+        if (v[1] == NULL) {
+            file = g_strdup(v[0]);
+        } else {
+            if (strcmp(v[0], "aio") == 0) {
+                format = g_strdup("raw");
+            } else if (strcmp(v[0], "vhd") == 0) {
+                format = g_strdup("vpc");
+            } else {
+                format = g_strdup(v[0]);
+            }
+            file = g_strdup(v[1]);
+        }
+
+        g_strfreev(v);
+    }
+
+    if (!file) {
+        error_setg(errp, "no file parameter");
+        return;
+    }
+
+    drive_optstr = g_strdup_printf("id=%s", id);
+    drive_opts = drive_def(drive_optstr);
+    if (!drive_opts) {
+        error_setg(errp, "failed to create drive options");
+        goto done;
+    }
+
+    qemu_opt_set(drive_opts, "file", file, &local_err);
+    if (local_err) {
+        error_propagate_prepend(errp, local_err, "failed to set 'file': ");
+        goto done;
+    }
+
+    qemu_opt_set(drive_opts, "media", device_type, &local_err);
+    if (local_err) {
+        error_propagate_prepend(errp, local_err,
+                                "failed to set 'media': ");
+        goto done;
+    }
+
+    if (format) {
+        qemu_opt_set(drive_opts, "format", format, &local_err);
+        if (local_err) {
+            error_propagate_prepend(errp, local_err,
+                                    "failed to set 'format': ");
+            goto done;
+        }
+    }
+
+    if (mode && *mode != 'w') {
+        qemu_opt_set_bool(drive_opts, BDRV_OPT_READ_ONLY, true, &local_err);
+        if (local_err) {
+            error_propagate_prepend(errp, local_err, "failed to set '%s': ",
+                                    BDRV_OPT_READ_ONLY);
+            goto done;
+        }
+    }
+
+    /*
+     * It is necessary to turn file locking off as an emulated device
+     * my have already opened the same image file.
+     */
+    qemu_opt_set(drive_opts, "file.locking", "off", &local_err);
+    if (local_err) {
+        error_propagate_prepend(errp, local_err,
+                                "failed to set 'file.locking': ");
+        goto done;
+    }
+
+    qemu_opt_set_bool(drive_opts, BDRV_OPT_CACHE_WB, true, &local_err);
+    if (local_err) {
+        error_propagate_prepend(errp, local_err, "failed to set '%s': ",
+                                BDRV_OPT_CACHE_WB);
+        goto done;
+    }
+
+    if (direct_io_safe) {
+        qemu_opt_set_bool(drive_opts, BDRV_OPT_CACHE_DIRECT, true,
+                          &local_err);
+        if (local_err) {
+            error_propagate_prepend(errp, local_err, "failed to set '%s': ",
+                                    BDRV_OPT_CACHE_DIRECT);
+            goto done;
+        }
+
+        qemu_opt_set(drive_opts, "aio", "native", &local_err);
+        if (local_err) {
+            error_propagate_prepend(errp, local_err,
+                                    "failed to set 'aio': ");
+            goto done;
+        }
+    }
+
+    if (discard_enable) {
+        unsigned long value;
+
+        if (!qemu_strtoul(discard_enable, NULL, 2, &value)) {
+            qemu_opt_set_bool(drive_opts, BDRV_OPT_DISCARD, !!value,
+                              &local_err);
+            if (local_err) {
+                error_propagate_prepend(errp, local_err,
+                                        "failed to set '%s': ",
+                                        BDRV_OPT_DISCARD);
+                goto done;
+            }
+        }
+    }
+
+    drive_new(drive_opts, IF_NONE, &local_err);
+    if (local_err) {
+        error_propagate_prepend(errp, local_err,
+                                "failed to create drive: ");
+        goto done;
+    }
+
+done:
+    g_free(drive_optstr);
+    g_free(format);
+    g_free(file);
+}
+
+static void xen_block_device_create(BusState *bus, const char *name,
+                                    QDict *opts, Error **errp)
+{
+    unsigned long number;
+    const char *vdev, *device_type;
+    BlockBackend *blk = NULL;
+    IOThread *iothread = NULL;
+    DeviceState *dev = NULL;
+    Error *local_err = NULL;
+    const char *type;
+    XenBlockDevice *blockdev;
+
+    trace_xen_block_device_create(name);
+
+    if (qemu_strtoul(name, NULL, 10, &number)) {
+        error_setg(errp, "failed to parse name '%s'", name);
+        return;
+    }
+
+    vdev = qdict_get_try_str(opts, "dev");
+    if (!vdev) {
+        error_setg(errp, "no dev parameter");
+        return;
+    }
+
+    device_type = qdict_get_try_str(opts, "device-type");
+    if (!device_type) {
+        error_setg(errp, "no device-type parameter");
+        return;
+    }
+
+    if (!strcmp(device_type, "disk")) {
+        type = TYPE_XEN_DISK_DEVICE;
+    } else if (!strcmp(device_type, "cdrom")) {
+        type = TYPE_XEN_CDROM_DEVICE;
+    } else {
+        error_setg(errp, "invalid device-type parameter '%s'", device_type);
+        return;
+    }
+
+    xen_block_drive_create(vdev, device_type, opts, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    blk = blk_by_name(vdev);
+    g_assert(blk);
+
+    iothread = iothread_create(vdev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto unref;
+    }
+
+    dev = qdev_create(bus, type);
+    blockdev = XEN_BLOCK_DEVICE(dev);
+
+    qdev_prop_set_string(dev, "vdev", vdev);
+    if (blockdev->vdev.number != number) {
+        error_setg(errp, "invalid dev parameter '%s'", vdev);
+        goto unref;
+    }
+
+    qdev_prop_set_drive(dev, "drive", blk, &local_err);
+    if (local_err) {
+        error_propagate_prepend(errp, local_err, "failed to set 'drive': ");
+        goto unref;
+    }
+
+    blockdev->auto_iothread = iothread;
+
+    object_property_set_bool(OBJECT(dev), true, "realized", &local_err);
+    if (local_err) {
+        error_propagate_prepend(errp, local_err,
+                                "initialization of device %s failed: ",
+                                type);
+        goto unref;
+    }
+
+    blockdev_mark_auto_del(blk);
+    return;
+
+unref:
+    if (dev) {
+        object_unparent(OBJECT(dev));
+    }
+
+    if (iothread) {
+        iothread_destroy(iothread);
+    }
+
+    if (blk) {
+        monitor_remove_blk(blk);
+        blk_unref(blk);
+    }
+}
+
+static const XenBackendInfo xen_block_backend_info = {
+    .type = "qdisk",
+    .create = xen_block_device_create,
+};
+
+static void xen_block_register_backend(void)
+{
+    xen_backend_register(&xen_block_backend_info);
+}
+
+xen_backend_init(xen_block_register_backend);
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 0c26023..fb227de 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -753,7 +753,6 @@ void xen_be_register_common(void)
 
     xen_be_register("console", &xen_console_ops);
     xen_be_register("vkbd", &xen_kbdmouse_ops);
-    xen_be_register("qdisk", &xen_blkdev_ops);
 #ifdef CONFIG_VIRTFS
     xen_be_register("9pfs", &xen_9pfs_ops);
 #endif
diff --git a/include/hw/xen/xen-block.h b/include/hw/xen/xen-block.h
index 37ed8a6..5bced60 100644
--- a/include/hw/xen/xen-block.h
+++ b/include/hw/xen/xen-block.h
@@ -37,6 +37,7 @@ typedef struct XenBlockDevice {
     unsigned int info;
     unsigned int max_ring_page_order;
     IOThread *iothread;
+    IOThread *auto_iothread;
     XenBlockDataPlane *dataplane;
 } XenBlockDevice;
 
-- 
2.1.4
