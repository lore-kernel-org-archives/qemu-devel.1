Received: from eggs.gnu.org ([2001:4830:134:3::10]:34253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ff7Rc-0007TI-0n
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ff7RX-0003AH-2D
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:37:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33474 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ff7RW-00039T-Su
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:37:50 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 16 Jul 2018 18:37:41 +0100
Message-Id: <20180716173743.133393-3-dgilbert@redhat.com>
In-Reply-To: <20180716173743.133393-1-dgilbert@redhat.com>
References: <20180716173743.133393-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH for 3.1 2/4] virtio: Check
 qemu_get_virtqueue_element returns
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

Check calls to qemu_get_virtqueue_element for NULL and pass
up the chain.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/block/virtio-blk.c       | 4 ++++
 hw/char/virtio-serial-bus.c | 4 ++++
 hw/scsi/virtio-scsi.c       | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 50b5c869e3..324c6b2b27 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -888,6 +888,10 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
         }
 
         req = qemu_get_virtqueue_element(vdev, f, sizeof(VirtIOBlockReq));
+        if (!req) {
+            error_report("%s: Bad vq element %u", __func__, vq_idx);
+            return -EINVAL;
+        }
         virtio_blk_init_request(s, virtio_get_queue(vdev, vq_idx), req);
         req->next = s->rq;
         s->rq = req;
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index d2dd8ab502..e99dc9bf59 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -781,6 +781,10 @@ static int fetch_active_ports_list(QEMUFile *f,
 
             port->elem =
                 qemu_get_virtqueue_element(vdev, f, sizeof(VirtQueueElement));
+            if (!port->elem) {
+                error_report("%s: Bad vq element", __func__);
+                return -EINVAL;
+            }
 
             /*
              *  Port was throttled on source machine.  Let's
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 3aa99717e2..6301af76ad 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -207,6 +207,10 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
     assert(n < vs->conf.num_queues);
     req = qemu_get_virtqueue_element(vdev, f,
                                      sizeof(VirtIOSCSIReq) + vs->cdb_size);
+    if (!req) {
+        error_report("%s: Bad vq element", __func__);
+        return NULL;
+    }
     virtio_scsi_init_req(s, vs->cmd_vqs[n], req);
 
     if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + vs->cdb_size,
-- 
2.17.1
