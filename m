Received: from eggs.gnu.org ([2001:4830:134:3::10]:59517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejShz-00044W-KZ
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:36:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejShy-0005CE-Nd
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:36:31 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  7 Feb 2018 17:36:21 +0100
Message-Id: <20180207163622.29935-2-pbonzini@redhat.com>
In-Reply-To: <20180207163622.29935-1-pbonzini@redhat.com>
References: <20180207163622.29935-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] scsi: add unrealize method for SCSI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

The next patch will introduce a different unrealize implementation
for scsi-block.  Compared to the code before commit fb7b5c0df6
("scsi: devirtualize unrealize of SCSI devices", 2014-10-31), the
common code for all SCSI devices is kept in scsi-bus.c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c     | 4 ++++
 include/hw/scsi/scsi.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 05e501efd3..a0790438f0 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -212,12 +212,16 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
 static void scsi_qdev_unrealize(DeviceState *qdev, Error **errp)
 {
     SCSIDevice *dev = SCSI_DEVICE(qdev);
+    SCSIDeviceClass *sc = SCSI_DEVICE_GET_CLASS(dev);
 
     if (dev->vmsentry) {
         qemu_del_vm_change_state_handler(dev->vmsentry);
     }
 
     scsi_device_purge_requests(dev, SENSE_CODE(NO_SENSE));
+    if (sc->unrealize) {
+        sc->unrealize(dev, errp);
+    }
     blockdev_mark_auto_del(dev->conf.blk);
 }
 
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 802a647cdc..569a4b9d14 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -59,6 +59,7 @@ struct SCSIRequest {
 typedef struct SCSIDeviceClass {
     DeviceClass parent_class;
     void (*realize)(SCSIDevice *dev, Error **errp);
+    void (*unrealize)(SCSIDevice *dev, Error **errp);
     int (*parse_cdb)(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
                      void *hba_private);
     SCSIRequest *(*alloc_req)(SCSIDevice *s, uint32_t tag, uint32_t lun,
-- 
2.14.3
