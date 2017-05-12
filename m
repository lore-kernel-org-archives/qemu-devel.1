Received: from eggs.gnu.org ([2001:4830:134:3::10]:39607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1d97hB-00051l-1k
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1d97h7-00064O-U3
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:21:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:39439 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1d97h7-0005z3-NS
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:21:09 -0400
From: Hannes Reinecke <hare@suse.de>
Date: Fri, 12 May 2017 12:20:57 +0200
Message-Id: <20170512102057.5855-5-hare@suse.de>
In-Reply-To: <20170512102057.5855-1-hare@suse.de>
References: <20170512102057.5855-1-hare@suse.de>
Subject: [Qemu-devel] [PATCH 4/4] virtio: implement VIRTIO_SCSI_F_TIMEOUT
 feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.com>, qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>

Implement a handler for the VIRTIO_SCSI_F_TIMEOUT feature, which
allows to pass in the assigned command timeout in seconds or
minutes. This allows to specify a timeout up to 3 hours.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 hw/scsi/virtio-scsi.c                        | 16 ++++++++++++++++
 include/standard-headers/linux/virtio_scsi.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 46a3e3f280..f1c2f7cb5b 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -534,6 +534,7 @@ static void virtio_scsi_fail_cmd_req(VirtIOSCSIReq *req)
 static int virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCSIReq *req)
 {
     VirtIOSCSICommon *vs = &s->parent_obj;
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
     SCSIDevice *d;
     int rc;
 
@@ -560,6 +561,21 @@ static int virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCSIReq *req)
                              virtio_scsi_get_lun(req->req.cmd.lun),
                              req->req.cmd.cdb, req);
 
+    if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_TIMEOUT)) {
+        int timeout = (int)req->req.cmd.crn;
+
+        if (timeout < 60) {
+            /* Timeouts below 60 are in seconds */
+            req->sreq->timeout = timeout * 1000;
+        } else if (timeout == 255) {
+            /* 255 is infinite timeout */
+            req->sreq->timeout = UINT_MAX;
+        } else {
+            /* Otherwise the timeout is in minutes */
+            req->sreq->timeout = timeout * 1000 * 60;
+        }
+    }
+
     if (req->sreq->cmd.mode != SCSI_XFER_NONE
         && (req->sreq->cmd.mode != req->mode ||
             req->sreq->cmd.xfer > req->qsgl.size)) {
diff --git a/include/standard-headers/linux/virtio_scsi.h b/include/standard-headers/linux/virtio_scsi.h
index ab66166b6a..b00e2b95ab 100644
--- a/include/standard-headers/linux/virtio_scsi.h
+++ b/include/standard-headers/linux/virtio_scsi.h
@@ -120,6 +120,7 @@ struct virtio_scsi_config {
 #define VIRTIO_SCSI_F_HOTPLUG                  1
 #define VIRTIO_SCSI_F_CHANGE                   2
 #define VIRTIO_SCSI_F_T10_PI                   3
+#define VIRTIO_SCSI_F_TIMEOUT                  4
 
 /* Response codes */
 #define VIRTIO_SCSI_S_OK                       0
-- 
2.12.0
