Received: from eggs.gnu.org ([2001:4830:134:3::10]:34247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ff7Rb-0007TF-VQ
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ff7RX-0003AN-2r
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:37:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43182 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ff7RW-00039p-Sr
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:37:50 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 16 Jul 2018 18:37:42 +0100
Message-Id: <20180716173743.133393-4-dgilbert@redhat.com>
In-Reply-To: <20180716173743.133393-1-dgilbert@redhat.com>
References: <20180716173743.133393-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH for 3.1 3/4] virtio-scsi/migration: Allow
 load_request to fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com, famz@redhat.com, amit@kernel.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Rather than asserting, check values and return NULL
on failure.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/scsi/virtio-scsi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 6301af76ad..3441bfe6d7 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -204,7 +204,11 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
     uint32_t n;
 
     qemu_get_be32s(f, &n);
-    assert(n < vs->conf.num_queues);
+    if (n >= vs->conf.num_queues) {
+        error_report("%s: Bad queue number (%d vs %d)",
+                     __func__, n, vs->conf.num_queues);
+        return NULL;
+    }
     req = qemu_get_virtqueue_element(vdev, f,
                                      sizeof(VirtIOSCSIReq) + vs->cdb_size);
     if (!req) {
@@ -216,13 +220,18 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
     if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + vs->cdb_size,
                               sizeof(VirtIOSCSICmdResp) + vs->sense_size) < 0) {
         error_report("invalid SCSI request migration data");
-        exit(1);
+        return NULL;
     }
 
     scsi_req_ref(sreq);
     req->sreq = sreq;
     if (req->sreq->cmd.mode != SCSI_XFER_NONE) {
-        assert(req->sreq->cmd.mode == req->mode);
+        if (req->sreq->cmd.mode != req->mode) {
+            error_report("%s: Bad mode (%d vs %d)",
+                         __func__, req->sreq->cmd.mode, req->mode);
+            scsi_req_unref(sreq);
+            return NULL;
+        }
     }
     return req;
 }
-- 
2.17.1
