Received: from eggs.gnu.org ([2001:4830:134:3::10]:34820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXUZq-00035p-IP
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXUZp-0000Ey-Ky
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:42:54 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Jun 2018 18:42:39 +0200
Message-Id: <20180625164239.13794-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] usb-storage: Add rerror/werror properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, berrange@redhat.com, pkrempa@redhat.com, armbru@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org

The error handling policy was traditionally set with -drive, but with
-blockdev it is no longer possible to set frontend options. scsi-disk
(and other block devices) have long supported qdev properties to
configure the error handling policy, so let's add these options to
usb-storage as well and just forward them to the internal scsi-disk
instance.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/scsi/scsi.h |  2 ++
 hw/scsi/scsi-bus.c     | 11 ++++++++++-
 hw/usb/dev-storage.c   |  2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index e35137ea78..1a7290d563 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -154,6 +154,8 @@ static inline SCSIBus *scsi_bus_from_device(SCSIDevice *d)
 SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
                                       int unit, bool removable, int bootindex,
                                       bool share_rw,
+                                      BlockdevOnError rerror,
+                                      BlockdevOnError werror,
                                       const char *serial, Error **errp);
 void scsi_bus_legacy_handle_cmdline(SCSIBus *bus);
 void scsi_legacy_handle_cmdline(void);
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 9646743a7d..5905f6bf29 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -226,6 +226,8 @@ static void scsi_qdev_unrealize(DeviceState *qdev, Error **errp)
 SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
                                       int unit, bool removable, int bootindex,
                                       bool share_rw,
+                                      BlockdevOnError rerror,
+                                      BlockdevOnError werror,
                                       const char *serial, Error **errp)
 {
     const char *driver;
@@ -262,6 +264,10 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
         object_unparent(OBJECT(dev));
         return NULL;
     }
+
+    qdev_prop_set_enum(dev, "rerror", rerror);
+    qdev_prop_set_enum(dev, "werror", werror);
+
     object_property_set_bool(OBJECT(dev), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
@@ -285,7 +291,10 @@ void scsi_bus_legacy_handle_cmdline(SCSIBus *bus)
         }
         qemu_opts_loc_restore(dinfo->opts);
         scsi_bus_legacy_add_drive(bus, blk_by_legacy_dinfo(dinfo),
-                                  unit, false, -1, false, NULL, &error_fatal);
+                                  unit, false, -1, false,
+                                  BLOCKDEV_ON_ERROR_AUTO,
+                                  BLOCKDEV_ON_ERROR_AUTO,
+                                  NULL, &error_fatal);
     }
     loc_pop(&loc);
 }
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index c99398b7f6..cd5551d94f 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -625,6 +625,7 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
                  &usb_msd_scsi_info_storage, NULL);
     scsi_dev = scsi_bus_legacy_add_drive(&s->bus, blk, 0, !!s->removable,
                                          s->conf.bootindex, s->conf.share_rw,
+                                         s->conf.rerror, s->conf.werror,
                                          dev->serial,
                                          errp);
     blk_unref(blk);
@@ -671,6 +672,7 @@ static const VMStateDescription vmstate_usb_msd = {
 
 static Property msd_properties[] = {
     DEFINE_BLOCK_PROPERTIES(MSDState, conf),
+    DEFINE_BLOCK_ERROR_PROPERTIES(MSDState, conf),
     DEFINE_PROP_BIT("removable", MSDState, removable, 0, false),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.13.6
