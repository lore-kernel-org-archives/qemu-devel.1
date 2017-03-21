Received: from eggs.gnu.org ([2001:4830:134:3::10]:40571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAK9-0002wL-BQ
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAK8-0001Cg-Jt
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:19:05 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 21 Mar 2017 11:16:29 +0800
Message-Id: <20170321031635.22123-11-famz@redhat.com>
In-Reply-To: <20170321031635.22123-1-famz@redhat.com>
References: <20170321031635.22123-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 10/16] virtio-scsi: Request
 BLK_PERM_AIO_CONTEXT_CHANGE for dataplane
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

blk_set_aio_context is audited by perm API, so follow the protocol and
request for permission first.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/scsi/virtio-scsi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 1dbc4bc..6a48356 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -811,6 +811,10 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
             return;
         }
         virtio_scsi_acquire(s);
+        if (!blk_request_perm(sd->conf.blk, BLK_PERM_AIO_CONTEXT_CHANGE, errp)) {
+            virtio_scsi_release(s);
+            return;
+        }
         blk_set_aio_context(sd->conf.blk, s->ctx);
         virtio_scsi_release(s);
 
-- 
2.9.3
