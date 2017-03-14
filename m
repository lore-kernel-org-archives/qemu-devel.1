Received: from eggs.gnu.org ([2001:4830:134:3::10]:59059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cncik-0007U3-3l
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 23:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cncij-0002Wj-Cq
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 23:01:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cncij-0002W8-6r
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 23:01:57 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Mar 2017 11:01:42 +0800
Message-Id: <1489460502-6686-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1489460502-6686-1-git-send-email-jasowang@redhat.com>
References: <1489460502-6686-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH V3 3/3] virtio: validate address space cache
 during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

We don't check the return value of address_space_cache_init(), this
may lead buggy driver use incorrect region caches. Instead of
triggering an assert, catch and warn this early in
virtio_init_region_cache().

Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/virtio.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f607a09..7714688 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -131,6 +131,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     VRingMemoryRegionCaches *new;
     hwaddr addr, size;
     int event_size;
+    int64_t len;
 
     event_size = virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
 
@@ -140,21 +141,41 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     }
     new = g_new0(VRingMemoryRegionCaches, 1);
     size = virtio_queue_get_desc_size(vdev, n);
-    address_space_cache_init(&new->desc, vdev->dma_as,
-                             addr, size, false);
+    len = address_space_cache_init(&new->desc, vdev->dma_as,
+                                   addr, size, false);
+    if (len < size) {
+        virtio_error(vdev, "Cannot map desc");
+        goto err_desc;
+    }
 
     size = virtio_queue_get_used_size(vdev, n) + event_size;
-    address_space_cache_init(&new->used, vdev->dma_as,
-                             vq->vring.used, size, true);
+    len = address_space_cache_init(&new->used, vdev->dma_as,
+                                   vq->vring.used, size, true);
+    if (len < size) {
+        virtio_error(vdev, "Cannot map used");
+        goto err_used;
+    }
 
     size = virtio_queue_get_avail_size(vdev, n) + event_size;
-    address_space_cache_init(&new->avail, vdev->dma_as,
-                             vq->vring.avail, size, false);
+    len = address_space_cache_init(&new->avail, vdev->dma_as,
+                                   vq->vring.avail, size, false);
+    if (len < size) {
+        virtio_error(vdev, "Cannot map avail");
+        goto err_avail;
+    }
 
     atomic_rcu_set(&vq->vring.caches, new);
     if (old) {
         call_rcu(old, virtio_free_region_cache, rcu);
     }
+    return;
+
+err_avail:
+    address_space_cache_destroy(&new->used);
+err_used:
+    address_space_cache_destroy(&new->desc);
+err_desc:
+    g_free(new);
 }
 
 /* virt queue functions */
-- 
2.7.4
