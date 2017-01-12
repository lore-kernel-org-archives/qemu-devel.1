Received: from eggs.gnu.org ([2001:4830:134:3::10]:57337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRfLO-0002aE-1c
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:23:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRfLK-00069E-3S
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:23:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cRfLJ-00068K-U5
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:23:02 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 12 Jan 2017 11:46:11 +0000
Message-Id: <20170112114612.14520-3-stefanha@redhat.com>
In-Reply-To: <20170112114612.14520-1-stefanha@redhat.com>
References: <20170112114612.14520-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] virtio: disable notifications again after
 poll succeeded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Doug Goldstein <cardoe@cardoe.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

While AioContext is in polling mode virtqueue notifications are not
necessary.  Some device virtqueue handlers enable notifications.  Make
sure they stay disabled to avoid unnecessary vmexits.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f04ab7a..34065c7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2126,6 +2126,9 @@ static bool virtio_queue_host_notifier_aio_poll(void *opaque)
     }
 
     virtio_queue_notify_aio_vq(vq);
+
+    /* In case the handler function re-enabled notifications */
+    virtio_queue_set_notification(vq, 0);
     return true;
 }
 
-- 
2.9.3
