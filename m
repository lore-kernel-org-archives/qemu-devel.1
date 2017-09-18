Received: from eggs.gnu.org ([2001:4830:134:3::10]:42949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dtwiW-0000iG-IM
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dtwiQ-0006QF-SA
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:08:08 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:20987
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dtwiQ-0006Nj-92
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:08:02 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Mon, 18 Sep 2017 22:05:17 +0800
Message-ID: <ebb77bf863c768a2fca0f1dc8a423ec9636a3c5c.1505737465.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1505737465.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1505737465.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 5/6] hw/block: Use errp directly rather than
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
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

Pass the error message to errp directly rather than the local
variable local_err and propagate it to errp via error_propagate().

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
---
 hw/block/fdc.c        | 17 ++++++-----------
 hw/block/nvme.c       |  8 +++-----
 hw/block/virtio-blk.c | 17 +++++------------
 hw/ide/qdev.c         | 12 ++++--------
 hw/scsi/scsi-disk.c   | 13 ++++---------
 hw/usb/dev-storage.c  |  9 +++------
 6 files changed, 25 insertions(+), 51 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 2853cdc..629609e 100644
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
+                                           blk_is_read_only(drive->blk),
+                                           false, errp)) {
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
index a18bf69..e117f7a 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -928,7 +928,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     int i;
     int64_t bs_size;
     uint8_t *pci_conf;
-    Error *local_err = NULL;
 
     if (!n->conf.blk) {
         error_setg(errp, "drive property not set");
@@ -947,10 +946,9 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         return;
     }
     blkconf_blocksizes(&n->conf);
-    blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
-                                  false, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!blkconf_apply_backend_options(&n->conf,
+                                       blk_is_read_only(n->conf.blk),
+                                       false, errp)) {
         return;
     }
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index a16ac75..4b4cdfe 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -913,7 +913,6 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOBlock *s = VIRTIO_BLK(dev);
     VirtIOBlkConf *conf = &s->conf;
-    Error *err = NULL;
     unsigned i;
 
     if (!conf->conf.blk) {
@@ -930,17 +929,13 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     }
 
     blkconf_serial(&conf->conf, &conf->serial);
-    blkconf_apply_backend_options(&conf->conf,
-                                  blk_is_read_only(conf->conf.blk), true,
-                                  &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!blkconf_apply_backend_options(&conf->conf,
+                                       blk_is_read_only(conf->conf.blk),
+                                       true, errp)) {
         return;
     }
     s->original_wce = blk_enable_write_cache(conf->conf.blk);
-    blkconf_geometry(&conf->conf, NULL, 65535, 255, 255, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!blkconf_geometry(&conf->conf, NULL, 65535, 255, 255, errp)) {
         return;
     }
     blkconf_blocksizes(&conf->conf);
@@ -955,9 +950,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
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
index d60ac25..9677191 100644
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
index 5f1e5e8..64a7fdd 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2306,7 +2306,6 @@ static void scsi_disk_unit_attention_reported(SCSIDevice *dev)
 static void scsi_realize(SCSIDevice *dev, Error **errp)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
-    Error *err = NULL;
 
     if (!s->qdev.conf.blk) {
         error_setg(errp, "drive property not set");
@@ -2322,17 +2321,13 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
     blkconf_serial(&s->qdev.conf, &s->serial);
     blkconf_blocksizes(&s->qdev.conf);
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
index 8a61ec9..801f552 100644
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
+    if (!blkconf_apply_backend_options(&s->conf, blk_is_read_only(blk),
+                                       true, errp)) {
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
2.9.4
