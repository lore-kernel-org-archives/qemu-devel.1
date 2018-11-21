Received: from eggs.gnu.org ([2001:4830:134:3::10]:52549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPURN-0001jY-JR
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPURL-0007qG-Fl
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:29:21 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Wed, 21 Nov 2018 15:12:09 +0000
Message-ID: <20181121151211.15997-17-paul.durrant@citrix.com>
In-Reply-To: <20181121151211.15997-1-paul.durrant@citrix.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 16/18] xen: automatically create
 XenQdiskDevice-s
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

This patch adds a creator function for XenQdiskDevice-s so that they can
be created automatically when the Xen toolstack instantiates a new
PV backend. When the XenQdiskDevice is created this way it is also
necessary to create a drive which matches the configuration that the Xen
toolstack has written into xenstore. This drive is marked 'auto_del' so
that it will be removed when the XenQdiskDevice is destroyed. Also, for
compatibilitye with the legacy 'xen_disk' implementation, an iothread
is automatically created for the new XenQdiskDevice. This will also be
removed when he XenQdiskDevice is destroyed.

Correspondingly the legacy backend scan for 'qdisk' is removed.

After this patch is applied the legacy 'xen_disk' code is redundant. It
will be removed by a subsequent patch.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
---
 hw/block/trace-events       |   1 +
 hw/block/xen-qdisk.c        | 237 +++++++++++++++++++++++++++++++++++++++++++-
 hw/xen/xen-legacy-backend.c |   1 -
 include/hw/xen/xen-qdisk.h  |   1 +
 4 files changed, 238 insertions(+), 2 deletions(-)

diff --git a/hw/block/trace-events b/hw/block/trace-events
index 8b95567560..ee2ac756cf 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -133,3 +133,4 @@ xen_qdisk_realize(uint32_t disk, uint32_t partition) "d%up%u"
 xen_qdisk_connect(uint32_t disk, uint32_t partition) "d%up%u"
 xen_qdisk_disconnect(uint32_t disk, uint32_t partition) "d%up%u"
 xen_qdisk_unrealize(uint32_t disk, uint32_t partition) "d%up%u"
+xen_qdisk_device_create(const char *name) "name: %s"
diff --git a/hw/block/xen-qdisk.c b/hw/block/xen-qdisk.c
index 8c88393832..00cdd8181b 100644
--- a/hw/block/xen-qdisk.c
+++ b/hw/block/xen-qdisk.c
@@ -5,9 +5,12 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/option.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "qapi/qmp/qdict.h"
 #include "hw/hw.h"
+#include "hw/xen/xen-backend.h"
 #include "hw/xen/xen-qdisk.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/block-backend.h"
@@ -28,6 +31,8 @@ static void xen_qdisk_realize(XenDevice *xendev, Error **errp)
     XenQdiskDevice *qdiskdev = XEN_QDISK_DEVICE(xendev);
     XenQdiskVdev *vdev = &qdiskdev->vdev;
     BlockConf *conf = &qdiskdev->conf;
+    IOThread *iothread = qdiskdev->auto_iothread ?
+        qdiskdev->auto_iothread : qdiskdev->iothread;
     DriveInfo *dinfo;
     bool is_cdrom;
     unsigned int info;
@@ -97,7 +102,7 @@ static void xen_qdisk_realize(XenDevice *xendev, Error **errp)
                               size / conf->logical_block_size);
 
     qdiskdev->dataplane = xen_qdisk_dataplane_create(xendev, conf,
-                                                     qdiskdev->iothread);
+                                                     iothread);
 }
 
 static void xen_qdisk_connect(XenQdiskDevice *qdiskdev, Error **errp)
@@ -228,6 +233,11 @@ static void xen_qdisk_unrealize(XenDevice *xendev, Error **errp)
 
     xen_qdisk_dataplane_destroy(qdiskdev->dataplane);
     qdiskdev->dataplane = NULL;
+
+    if (qdiskdev->auto_iothread) {
+        iothread_destroy(qdiskdev->auto_iothread);
+        qdiskdev->auto_iothread = NULL;
+    }
 }
 
 static char *disk_to_vbd_name(unsigned int disk)
@@ -461,3 +471,228 @@ static void xen_qdisk_register_types(void)
 }
 
 type_init(xen_qdisk_register_types)
+
+static void xen_qdisk_drive_create(const char *id, QDict *opts,
+                                   Error **errp)
+{
+    const char *params, *device_type, *mode, *direct_io_safe,
+        *discard_enable;
+    char *format = NULL;
+    char *file = NULL;
+    char *drive_optstr = NULL;
+    QemuOpts *drive_opts;
+    Error *local_err = NULL;
+
+    params = qdict_get_try_str(opts, "params");
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
+        error_propagate(errp, local_err);
+        error_prepend(errp, "failed to set 'file': ");
+        goto done;
+    }
+
+    if (format) {
+        qemu_opt_set(drive_opts, "format", format, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            error_prepend(errp, "failed to set 'format': ");
+            goto done;
+        }
+    }
+
+    device_type = qdict_get_try_str(opts, "device-type");
+    if (device_type) {
+        qemu_opt_set(drive_opts, "media", device_type, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            error_prepend(errp, "failed to set 'media': ");
+            goto done;
+        }
+    }
+
+    mode = qdict_get_try_str(opts, "mode");
+    if (mode && *mode != 'w') {
+        qemu_opt_set_bool(drive_opts, BDRV_OPT_READ_ONLY, true, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            error_prepend(errp, "failed to set '%s': ", BDRV_OPT_READ_ONLY);
+            goto done;
+        }
+    }
+
+    qemu_opt_set(drive_opts, "file.locking", "off", &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "failed to set 'file.locking': ");
+        goto done;
+    }
+
+    qemu_opt_set_bool(drive_opts, BDRV_OPT_CACHE_WB, true, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "failed to set '%s': ", BDRV_OPT_CACHE_WB);
+        goto done;
+    }
+
+    direct_io_safe = qdict_get_try_str(opts, "direct-io-safe");
+    if (direct_io_safe) {
+        qemu_opt_set_bool(drive_opts, BDRV_OPT_CACHE_DIRECT, true,
+                          &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            error_prepend(errp, "failed to set '%s': ",
+                          BDRV_OPT_CACHE_DIRECT);
+            goto done;
+        }
+
+        qemu_opt_set(drive_opts, "aio", "native", &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            error_prepend(errp, "failed to set 'aio': ");
+            goto done;
+        }
+    }
+
+    discard_enable = qdict_get_try_str(opts, "discard-enable");
+    if (discard_enable) {
+        unsigned long value;
+
+        if (!qemu_strtoul(discard_enable, NULL, 2, &value)) {
+            qemu_opt_set_bool(drive_opts, BDRV_OPT_DISCARD, !!value,
+                              &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                error_prepend(errp, "failed to set '%s': ",
+                              BDRV_OPT_DISCARD);
+                goto done;
+            }
+        }
+    }
+
+    drive_new(drive_opts, IF_NONE, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "failed to create drive: ");
+        goto done;
+    }
+
+done:
+    g_free(drive_optstr);
+    g_free(format);
+    g_free(file);
+}
+
+static void xen_qdisk_device_create(BusState *bus, const char *name,
+                                    QDict *opts, Error **errp)
+{
+    unsigned long number;
+    const char *vdev;
+    BlockBackend *blk = NULL;
+    IOThread *iothread = NULL;
+    DeviceState *dev = NULL;
+    Error *local_err = NULL;
+
+    trace_xen_qdisk_device_create(name);
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
+    xen_qdisk_drive_create(vdev, opts, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    blk = blk_by_name(vdev);
+    g_assert(blk);
+
+    iothread = iothread_create(vdev, &error_abort);
+
+    dev = qdev_create(bus, TYPE_XEN_QDISK_DEVICE);
+
+    qdev_prop_set_string(dev, "vdev", vdev);
+
+    if (XEN_QDISK_DEVICE(dev)->vdev.number != number) {
+        error_setg(errp, "invalid dev parameter '%s'", vdev);
+        goto unref;
+    }
+
+    qdev_prop_set_drive(dev, "drive", blk, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "failed to set 'drive': ");
+        goto unref;
+    }
+
+    XEN_QDISK_DEVICE(dev)->auto_iothread = iothread;
+
+    qdev_init_nofail(dev);
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
+static const XenBackendInfo xen_qdisk_backend_info = {
+    .type = "qdisk",
+    .create = xen_qdisk_device_create,
+};
+
+static void xen_qdisk_register_backend(void)
+{
+    xen_backend_register(&xen_qdisk_backend_info);
+}
+
+xen_backend_init(xen_qdisk_register_backend);
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 2d748665a6..cc0add0a5b 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -753,7 +753,6 @@ void xen_be_register_common(void)
 
     xen_be_register("console", &xen_console_ops);
     xen_be_register("vkbd", &xen_kbdmouse_ops);
-    xen_be_register("qdisk", &xen_blkdev_ops);
 #ifdef CONFIG_VIRTFS
     xen_be_register("9pfs", &xen_9pfs_ops);
 #endif
diff --git a/include/hw/xen/xen-qdisk.h b/include/hw/xen/xen-qdisk.h
index d7dd2bf0ee..c7bc011731 100644
--- a/include/hw/xen/xen-qdisk.h
+++ b/include/hw/xen/xen-qdisk.h
@@ -44,6 +44,7 @@ struct XenQdiskDevice {
     BlockConf conf;
     unsigned int max_ring_page_order;
     IOThread *iothread;
+    IOThread *auto_iothread;
     XenQdiskDataPlane *dataplane;
 };
 
-- 
2.11.0
