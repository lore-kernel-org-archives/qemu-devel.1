Received: from eggs.gnu.org ([2001:4830:134:3::10]:34236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDMQU-0000kh-KD
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDMQT-00076L-Uh
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:53:30 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 24 May 2017 10:52:30 +0800
Message-Id: <20170524025235.32190-12-famz@redhat.com>
In-Reply-To: <20170524025235.32190-1-famz@redhat.com>
References: <20170524025235.32190-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 11/16] virtio-scsi: Request
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

blk_set_aio_context is audited by perm API, so follow the protocol and
request for permission first.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/scsi/virtio-scsi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 46a3e3f..074e235 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -794,6 +794,10 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
2.9.4
