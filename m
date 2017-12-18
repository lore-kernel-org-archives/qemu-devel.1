Received: from eggs.gnu.org ([2001:4830:134:3::10]:45360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwWf-0006RB-Ut
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwWQ-0006ht-Dl
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQwWQ-0006hB-3U
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:02 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 18 Dec 2017 14:35:11 +0000
Message-Id: <20171218143530.12082-5-stefanha@redhat.com>
In-Reply-To: <20171218143530.12082-1-stefanha@redhat.com>
References: <20171218143530.12082-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 04/23] hw/block: Use errp directly rather than
 local_err
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

Cc: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: e77848d3735ba590f23ffbf8094379c646c33d79.1511317952.git.maozy.fnst@cn.fujitsu.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/fdc.c        | 17 ++++++-----------
 hw/block/nvme.c       |  7 ++-----
 hw/block/virtio-blk.c | 18 ++++++------------
 hw/ide/qdev.c         | 12 ++++--------
 hw/scsi/scsi-disk.c   | 13 ++++---------
 hw/usb/dev-storage.c  |  9 +++------
 6 files changed, 25 insertions(+), 51 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 67f78ac702..7b7dd41296 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -473,16 +473,13 @@ static void fd_revalidate(FDrive *drv)
 static void fd_change_cb(void *opaque, bool load, Error **errp)
 {
     FDrive *drive = opaque;
-    Error *local_err = NULL;
 
     if (!load) {
         blk_set_perm(drive->blk, 0, BLK_PERM_ALL, &error_abort);
     } else {
-        blkconf_apply_backend_options(drive->conf,
-                                      blk_is_read_only(drive->blk), false,
-                                      &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (!blkconf_apply_backend_options(drive->conf,
+                                           blk_is_read_only(drive->blk), false,
+                                           errp)) {
             return;
         }
     }
@@ -522,7 +519,6 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
     FloppyDrive *dev = FLOPPY_DRIVE(qdev);
     FloppyBus *bus = FLOPPY_BUS(qdev->parent_bus);
     FDrive *drive;
-    Error *local_err = NULL;
     int ret;
 
     if (dev->unit == -1) {
@@ -568,10 +564,9 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
     dev->conf.rerror = BLOCKDEV_ON_ERROR_AUTO;
     dev->conf.werror = BLOCKDEV_ON_ERROR_AUTO;
 
-    blkconf_apply_backend_options(&dev->conf, blk_is_read_only(dev->conf.blk),
-                                  false, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!blkconf_apply_backend_options(&dev->conf,
+                                       blk_is_read_only(dev->conf.blk),
+                                       false, errp)) {
         return;
     }
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index e530ba7a30..e529e88e4e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -928,7 +928,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     int i;
     int64_t bs_size;
     uint8_t *pci_conf;
-    Error *local_err = NULL;
 
     if (!n->conf.blk) {
         error_setg(errp, "drive property not set");
@@ -947,10 +946,8 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         return;
     }
     blkconf_blocksizes(&n->conf);
-    blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
-                                  false, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
+                                       false, errp)) {
         return;
     }
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 05d1440786..ae3356f6a8 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -913,7 +913,6 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOBlock *s = VIRTIO_BLK(dev);
     VirtIOBlkConf *conf = &s->conf;
-    Error *err = NULL;
     unsigned i;
 
     if (!conf->conf.blk) {
@@ -930,19 +929,16 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     }
 
     blkconf_serial(&conf->conf, &conf->serial);
-    blkconf_apply_backend_options(&conf->conf,
-                                  blk_is_read_only(conf->conf.blk), true,
-                                  &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!blkconf_apply_backend_options(&conf->conf,
+                                       blk_is_read_only(conf->conf.blk), true,
+                                       errp)) {
         return;
     }
     s->original_wce = blk_enable_write_cache(conf->conf.blk);
-    blkconf_geometry(&conf->conf, NULL, 65535, 255, 255, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!blkconf_geometry(&conf->conf, NULL, 65535, 255, 255, errp)) {
         return;
     }
+
     blkconf_blocksizes(&conf->conf);
 
     virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
@@ -955,9 +951,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < conf->num_queues; i++) {
         virtio_add_queue(vdev, 128, virtio_blk_handle_output);
     }
-    virtio_blk_data_plane_create(vdev, conf, &s->dataplane, &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!virtio_blk_data_plane_create(vdev, conf, &s->dataplane, errp)) {
         virtio_cleanup(vdev);
         return;
     }
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index a5181b4448..f395d24592 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -160,7 +160,6 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
 {
     IDEBus *bus = DO_UPCAST(IDEBus, qbus, dev->qdev.parent_bus);
     IDEState *s = bus->ifs + dev->unit;
-    Error *err = NULL;
     int ret;
 
     if (!dev->conf.blk) {
@@ -191,16 +190,13 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
 
     blkconf_serial(&dev->conf, &dev->serial);
     if (kind != IDE_CD) {
-        blkconf_geometry(&dev->conf, &dev->chs_trans, 65535, 16, 255, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!blkconf_geometry(&dev->conf, &dev->chs_trans, 65535, 16, 255,
+                              errp)) {
             return;
         }
     }
-    blkconf_apply_backend_options(&dev->conf, kind == IDE_CD, kind != IDE_CD,
-                                  &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!blkconf_apply_backend_options(&dev->conf, kind == IDE_CD,
+                                       kind != IDE_CD, errp)) {
         return;
     }
 
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 12431177a7..870d9ae85a 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2332,7 +2332,6 @@ static void scsi_disk_unit_attention_reported(SCSIDevice *dev)
 static void scsi_realize(SCSIDevice *dev, Error **errp)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
-    Error *err = NULL;
 
     if (!s->qdev.conf.blk) {
         error_setg(errp, "drive property not set");
@@ -2356,17 +2355,13 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
     }
 
     if (dev->type == TYPE_DISK) {
-        blkconf_geometry(&dev->conf, NULL, 65535, 255, 255, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!blkconf_geometry(&dev->conf, NULL, 65535, 255, 255, errp)) {
             return;
         }
     }
-    blkconf_apply_backend_options(&dev->conf,
-                                  blk_is_read_only(s->qdev.conf.blk),
-                                  dev->type == TYPE_DISK, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!blkconf_apply_backend_options(&dev->conf,
+                                       blk_is_read_only(s->qdev.conf.blk),
+                                       dev->type == TYPE_DISK, errp)) {
         return;
     }
 
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 8a61ec94c8..a9bcc67e67 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -601,7 +601,6 @@ static void usb_msd_realize_storage(USBDevice *dev, Error **errp)
     MSDState *s = USB_STORAGE_DEV(dev);
     BlockBackend *blk = s->conf.blk;
     SCSIDevice *scsi_dev;
-    Error *err = NULL;
 
     if (!blk) {
         error_setg(errp, "drive property not set");
@@ -610,9 +609,8 @@ static void usb_msd_realize_storage(USBDevice *dev, Error **errp)
 
     blkconf_serial(&s->conf, &dev->serial);
     blkconf_blocksizes(&s->conf);
-    blkconf_apply_backend_options(&s->conf, blk_is_read_only(blk), true, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!blkconf_apply_backend_options(&s->conf, blk_is_read_only(blk), true,
+                                       errp)) {
         return;
     }
 
@@ -636,10 +634,9 @@ static void usb_msd_realize_storage(USBDevice *dev, Error **errp)
                  &usb_msd_scsi_info_storage, NULL);
     scsi_dev = scsi_bus_legacy_add_drive(&s->bus, blk, 0, !!s->removable,
                                          s->conf.bootindex, dev->serial,
-                                         &err);
+                                         errp);
     blk_unref(blk);
     if (!scsi_dev) {
-        error_propagate(errp, err);
         return;
     }
     usb_msd_handle_reset(dev);
-- 
2.14.3
