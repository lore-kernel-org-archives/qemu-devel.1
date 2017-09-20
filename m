Received: from eggs.gnu.org ([2001:4830:134:3::10]:58927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1duYIZ-0000b7-DS
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1duYIV-0008PR-Ag
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:15:51 -0400
Received: from proxmox.maurer-it.com ([212.186.127.180]:20823)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <w.bumiller@proxmox.com>)
	id 1duYIV-00088F-2l
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:15:47 -0400
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
Date: Wed, 20 Sep 2017 08:09:33 +0200
Message-Id: <20170920060933.11593-1-w.bumiller@proxmox.com>
Subject: [Qemu-devel] [PATCH] virtio: fix descriptor counting in
 virtqueue_pop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

While changing the s/g list allocation, commit 3b3b0628
also changed the descriptor counting to count iovec entries
as split by cpu_physical_memory_map(). Previously only the
actual descriptor entries were counted and the split into
the iovec happened afterwards in virtqueue_map().
Count the entries again instead to avoid erroneous
"Looped descriptor" errors.

Reported-by: Hans Middelhoek <h.middelhoek@ospito.nl>
Link: https://forum.proxmox.com/threads/vm-crash-with-memory-hotplug.35904/
Fixes: 3b3b0628217e ("virtio: slim down allocation of VirtQueueElements")
Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
---
 hw/virtio/virtio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 890b4d7eb7..33bb770177 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -834,7 +834,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     int64_t len;
     VirtIODevice *vdev = vq->vdev;
     VirtQueueElement *elem = NULL;
-    unsigned out_num, in_num;
+    unsigned out_num, in_num, elem_entries;
     hwaddr addr[VIRTQUEUE_MAX_SIZE];
     struct iovec iov[VIRTQUEUE_MAX_SIZE];
     VRingDesc desc;
@@ -852,7 +852,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     smp_rmb();
 
     /* When we start there are none of either input nor output. */
-    out_num = in_num = 0;
+    out_num = in_num = elem_entries = 0;
 
     max = vq->vring.num;
 
@@ -922,7 +922,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
         }
 
         /* If we've got too many, that implies a descriptor loop. */
-        if ((in_num + out_num) > max) {
+        if (++elem_entries > max) {
             virtio_error(vdev, "Looped descriptor");
             goto err_undo_map;
         }
-- 
2.11.0
