Received: from eggs.gnu.org ([2001:4830:134:3::10]:58625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8a-0003fz-Np
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8Z-0000En-J4
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33540 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8Z-0000EI-EF
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 10964406E974
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:13:19 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-47.ams2.redhat.com
	[10.36.117.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8FB972026DEF
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:13:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:26 +0200
Message-Id: <20180531171253.21012-27-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 26/53] virtio: free MemoryRegionCache when
 initialization fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

---
 hw/virtio/virtio.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 1debb0147b..d4e4d98b59 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -123,11 +123,22 @@ static void virtio_free_region_cache(VRingMemoryRegionCaches *caches)
     g_free(caches);
 }
 
+static void virtio_virtqueue_reset_region_cache(struct VirtQueue *vq)
+{
+    VRingMemoryRegionCaches *caches;
+
+    caches = atomic_read(&vq->vring.caches);
+    atomic_rcu_set(&vq->vring.caches, NULL);
+    if (caches) {
+        call_rcu(caches, virtio_free_region_cache, rcu);
+    }
+}
+
 static void virtio_init_region_cache(VirtIODevice *vdev, int n)
 {
     VirtQueue *vq = &vdev->vq[n];
     VRingMemoryRegionCaches *old = vq->vring.caches;
-    VRingMemoryRegionCaches *new;
+    VRingMemoryRegionCaches *new = NULL;
     hwaddr addr, size;
     int event_size;
     int64_t len;
@@ -136,7 +147,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
 
     addr = vq->vring.desc;
     if (!addr) {
-        return;
+        goto out_no_cache;
     }
     new = g_new0(VRingMemoryRegionCaches, 1);
     size = virtio_queue_get_desc_size(vdev, n);
@@ -170,11 +181,14 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     return;
 
 err_avail:
-    address_space_cache_destroy(&new->used);
+    address_space_cache_destroy(&new->avail);
 err_used:
-    address_space_cache_destroy(&new->desc);
+    address_space_cache_destroy(&new->used);
 err_desc:
+    address_space_cache_destroy(&new->desc);
+out_no_cache:
     g_free(new);
+    virtio_virtqueue_reset_region_cache(vq);
 }
 
 /* virt queue functions */
@@ -1168,17 +1182,6 @@ static enum virtio_device_endian virtio_current_cpu_endian(void)
     }
 }
 
-static void virtio_virtqueue_reset_region_cache(struct VirtQueue *vq)
-{
-    VRingMemoryRegionCaches *caches;
-
-    caches = atomic_read(&vq->vring.caches);
-    atomic_rcu_set(&vq->vring.caches, NULL);
-    if (caches) {
-        call_rcu(caches, virtio_free_region_cache, rcu);
-    }
-}
-
 void virtio_reset(void *opaque)
 {
     VirtIODevice *vdev = opaque;
-- 
2.17.0
