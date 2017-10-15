Received: from eggs.gnu.org ([2001:4830:134:3::10]:49318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZX0-00032l-Rv
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZWz-0007BG-Kz
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:24:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3ZWz-0007Ao-ED
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:24:01 -0400
Date: Sun, 15 Oct 2017 06:23:58 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1508036858-13479-23-git-send-email-mst@redhat.com>
References: <1508036858-13479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508036858-13479-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 22/26] virtio: fix descriptor counting in
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Wolfgang Bumiller <w.bumiller@proxmox.com>, Hans Middelhoek <h.middelhoek@ospito.nl>

From: Wolfgang Bumiller <w.bumiller@proxmox.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 311929e..5884ce3 100644
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
MST
