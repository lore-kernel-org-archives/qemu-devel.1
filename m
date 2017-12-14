Received: from eggs.gnu.org ([2001:4830:134:3::10]:51994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ePQXt-0001D2-0A
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 05:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ePQXp-0004LT-2e
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 05:15:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:59092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1ePQXo-0004HF-Ok
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 05:15:13 -0500
From: Hannes Reinecke <hare@suse.de>
Date: Thu, 14 Dec 2017 11:14:34 +0100
Message-Id: <20171214101435.26265-4-hare@suse.de>
In-Reply-To: <20171214101435.26265-1-hare@suse.de>
References: <20171214101435.26265-1-hare@suse.de>
Subject: [Qemu-devel] [PATCH 3/4] virtio-scsi: Implement 'native LUN' feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>

The 'native LUN' feature allows virtio-scsi to use the LUN
numbers from the underlying storage directly, without having
to modify the LUN number when sending over the wire.
It works by shifting the existing LUN number down by 8 bytes,
and add the virtio-specific 8-byte LUN steering header.
With that virtio doesn't have to mangle the LUN number, allowing
us to pass the 'real' LUN number to the guest.
Of course, we do cut off the last 8 bytes of the 'real' LUN number,
but I'm not aware of any array utilizing that, so the impact should
be negligible.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 hw/scsi/virtio-scsi.c                        | 29 ++++++++++++++++++++--------
 include/hw/scsi/scsi.h                       |  4 ++--
 include/standard-headers/linux/virtio_scsi.h |  1 +
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index fa2031f636..ec91c8c403 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -26,20 +26,30 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 
-static inline uint64_t virtio_scsi_get_lun(uint8_t *lun)
+static inline uint64_t virtio_scsi_get_lun(VirtIODevice *vdev, uint8_t *lun)
 {
-    return (((uint64_t)(lun[2] << 8) | lun[3]) & 0x3FFF) << 48;
+    uint64_t lun64;
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_NATIVE_LUN)) {
+        lun64 = scsi_lun_from_str(lun) << 16;
+    } else {
+        lun64 = (((uint64_t)(lun[2] << 8) | lun[3]) & 0x3FFF) << 48;
+    }
+    return lun64;
 }
 
 static inline SCSIDevice *virtio_scsi_device_find(VirtIOSCSI *s, uint8_t *lun)
 {
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
     if (lun[0] != 1) {
         return NULL;
     }
-    if (lun[2] != 0 && !(lun[2] >= 0x40 && lun[2] < 0x80)) {
+    if (!virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_NATIVE_LUN) &&
+        lun[2] != 0 && !(lun[2] >= 0x40 && lun[2] < 0x80)) {
         return NULL;
     }
-    return scsi_device_find(&s->bus, 0, lun[1], virtio_scsi_get_lun(lun));
+    return scsi_device_find(&s->bus, 0, lun[1], virtio_scsi_get_lun(vdev, lun));
 }
 
 void virtio_scsi_init_req(VirtIOSCSI *s, VirtQueue *vq, VirtIOSCSIReq *req)
@@ -270,7 +280,7 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSCSIReq *req)
         if (!d) {
             goto fail;
         }
-        if (d->lun != virtio_scsi_get_lun(req->req.tmf.lun)) {
+        if (d->lun != virtio_scsi_get_lun(VIRTIO_DEVICE(s), req->req.tmf.lun)) {
             goto incorrect_lun;
         }
         QTAILQ_FOREACH_SAFE(r, &d->requests, next, next) {
@@ -307,7 +317,7 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSCSIReq *req)
         if (!d) {
             goto fail;
         }
-        if (d->lun != virtio_scsi_get_lun(req->req.tmf.lun)) {
+        if (d->lun != virtio_scsi_get_lun(VIRTIO_DEVICE(s), req->req.tmf.lun)) {
             goto incorrect_lun;
         }
         s->resetting++;
@@ -321,7 +331,7 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSCSIReq *req)
         if (!d) {
             goto fail;
         }
-        if (d->lun != virtio_scsi_get_lun(req->req.tmf.lun)) {
+        if (d->lun != virtio_scsi_get_lun(VIRTIO_DEVICE(s), req->req.tmf.lun)) {
             goto incorrect_lun;
         }
 
@@ -609,7 +619,8 @@ static int virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCSIReq *req)
     }
     virtio_scsi_ctx_check(s, d);
     req->sreq = scsi_req_new(d, req->req.cmd.tag,
-                             virtio_scsi_get_lun(req->req.cmd.lun),
+                             virtio_scsi_get_lun(VIRTIO_DEVICE(s),
+                                                 req->req.cmd.lun),
                              req->req.cmd.cdb, req);
 
     if (req->sreq->cmd.mode != SCSI_XFER_NONE
@@ -980,6 +991,8 @@ static Property virtio_scsi_properties[] = {
                                                 VIRTIO_SCSI_F_CHANGE, true),
     DEFINE_PROP_BIT("rescan", VirtIOSCSI, host_features,
                                           VIRTIO_SCSI_F_RESCAN, true),
+    DEFINE_PROP_BIT("native_lun", VirtIOSCSI, host_features,
+                                              VIRTIO_SCSI_F_NATIVE_LUN, true),
     DEFINE_PROP_LINK("iothread", VirtIOSCSI, parent_obj.conf.iothread,
                      TYPE_IOTHREAD, IOThread *),
     DEFINE_PROP_STRING("wwpn", VirtIOSCSI, parent_obj.conf.wwpn),
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index cb2b2bddcd..a18e430c08 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -175,8 +175,8 @@ static inline uint64_t scsi_lun_from_str(uint8_t *lun)
     uint64_t lun64 = 0;
 
     for (i = 0; i < 8; i += 2) {
-        lun64 |= (uint64_t)lun[i] << ((i + 1) * 8) |
-            (uint64_t)lun[i + 1] << (i * 8);
+        lun64 = lun64 << 16;
+        lun64 |= ((uint64_t)lun[i] << 8) | (uint64_t)lun[i + 1];
     }
     return lun64;
 }
diff --git a/include/standard-headers/linux/virtio_scsi.h b/include/standard-headers/linux/virtio_scsi.h
index 5b3a930569..911fc2db82 100644
--- a/include/standard-headers/linux/virtio_scsi.h
+++ b/include/standard-headers/linux/virtio_scsi.h
@@ -134,6 +134,7 @@ struct virtio_scsi_config {
 #define VIRTIO_SCSI_F_CHANGE                   2
 #define VIRTIO_SCSI_F_T10_PI                   3
 #define VIRTIO_SCSI_F_RESCAN                   4
+#define VIRTIO_SCSI_F_NATIVE_LUN               5
 
 /* Response codes */
 #define VIRTIO_SCSI_S_OK                       0
-- 
2.12.3
