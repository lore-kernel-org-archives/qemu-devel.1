Received: from eggs.gnu.org ([2001:4830:134:3::10]:34614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fY5j8-00021C-7L
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fY5j6-0002Ps-PF
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:22:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59600 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fY5j6-0002Ok-Kd
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:22:56 -0400
From: Pankaj Gupta <pagupta@redhat.com>
Date: Wed, 27 Jun 2018 13:52:48 +0530
Message-Id: <20180627082248.14921-3-pagupta@redhat.com>
In-Reply-To: <20180627082248.14921-1-pagupta@redhat.com>
References: <20180627082248.14921-1-pagupta@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] virtio: Set status early in VirtIODevice
 parent object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, amit@kernel.org, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, slopezpa@redhat.com

 To process pending requests for driver status 'VIRTIO_CONFIG_S_DRIVER_OK',
 virtio-rng 'set_status' calls 'is_guest_ready' function. This checks if 
 virtqueue is ready and status is set to 'VIRTIO_CONFIG_S_DRIVER_OK'. 

 This call is made before new status is updated in VirtIODevice parent object 
 and calling function uses old status value.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 hw/virtio/virtio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d4e4d98b59..37dc59a686 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1154,10 +1154,11 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
             }
         }
     }
+    vdev->status = val;
+
     if (k->set_status) {
         k->set_status(vdev, val);
     }
-    vdev->status = val;
     return 0;
 }
 
-- 
2.14.3
