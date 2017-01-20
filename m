Received: from eggs.gnu.org ([2001:4830:134:3::10]:50544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcfX-0006pV-8p
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:08:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcfW-0001L2-3I
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:08:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUcfV-0001Kg-Q7
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:08:06 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 199A53D95F
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 17:08:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 18:07:55 +0100
Message-Id: <20170120170757.30308-6-pbonzini@redhat.com>
In-Reply-To: <20170120170757.30308-1-pbonzini@redhat.com>
References: <20170120170757.30308-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 5/7] virtio: add MemoryListener to cache ring
 translations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanha@redhat.com

The cached translations are RCU-protected to allow efficient use
when processing virtqueues.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/virtio.c         | 91 ++++++++++++++++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio.h |  1 +
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 52673d1..848c30f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -60,6 +60,13 @@ typedef struct VRingUsed
     VRingUsedElem ring[0];
 } VRingUsed;
 
+typedef struct VRingMemoryRegionCaches {
+    struct rcu_head rcu;
+    MemoryRegionCache desc;
+    MemoryRegionCache avail;
+    MemoryRegionCache used;
+} VRingMemoryRegionCaches;
+
 typedef struct VRing
 {
     unsigned int num;
@@ -68,6 +75,7 @@ typedef struct VRing
     hwaddr desc;
     hwaddr avail;
     hwaddr used;
+    VRingMemoryRegionCaches *caches;
 } VRing;
 
 struct VirtQueue
@@ -104,6 +112,46 @@ struct VirtQueue
     QLIST_ENTRY(VirtQueue) node;
 };
 
+static void virtio_free_region_cache(VRingMemoryRegionCaches *caches)
+{
+    address_space_cache_destroy(&caches->desc);
+    address_space_cache_destroy(&caches->avail);
+    address_space_cache_destroy(&caches->used);
+    g_free(caches);
+}
+
+static void virtio_init_region_cache(VirtIODevice *vdev, int n)
+{
+    VirtQueue *vq = &vdev->vq[n];
+    VRingMemoryRegionCaches *old = vq->vring.caches;
+    VRingMemoryRegionCaches *new = g_new0(VRingMemoryRegionCaches, 1);
+    hwaddr addr, size;
+    int event_size;
+
+    event_size = virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
+
+    addr = vq->vring.desc;
+    if (!addr) {
+        return;
+    }
+    size = virtio_queue_get_desc_size(vdev, n);
+    address_space_cache_init(&new->desc, vdev->dma_as,
+                             addr, size, false);
+
+    size = virtio_queue_get_used_size(vdev, n) + event_size;
+    address_space_cache_init(&new->used, vdev->dma_as,
+                             vq->vring.used, size, true);
+
+    size = virtio_queue_get_avail_size(vdev, n) + event_size;
+    address_space_cache_init(&new->avail, vdev->dma_as,
+                             vq->vring.avail, size, false);
+
+    atomic_rcu_set(&vq->vring.caches, new);
+    if (old) {
+        call_rcu(old, virtio_free_region_cache, rcu);
+    }
+}
+
 /* virt queue functions */
 void virtio_queue_update_rings(VirtIODevice *vdev, int n)
 {
@@ -117,6 +165,7 @@ void virtio_queue_update_rings(VirtIODevice *vdev, int n)
     vring->used = vring_align(vring->avail +
                               offsetof(VRingAvail, ring[vring->num]),
                               vring->align);
+    virtio_init_region_cache(vdev, n);
 }
 
 static void vring_desc_read(VirtIODevice *vdev, VRingDesc *desc,
@@ -1266,6 +1315,7 @@ void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
     vdev->vq[n].vring.desc = desc;
     vdev->vq[n].vring.avail = avail;
     vdev->vq[n].vring.used = used;
+    virtio_init_region_cache(vdev, n);
 }
 
 void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
@@ -1977,9 +2027,6 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
 void virtio_cleanup(VirtIODevice *vdev)
 {
     qemu_del_vm_change_state_handler(vdev->vmstate);
-    g_free(vdev->config);
-    g_free(vdev->vq);
-    g_free(vdev->vector_queues);
 }
 
 static void virtio_vmstate_change(void *opaque, int running, RunState state)
@@ -2240,6 +2287,19 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
     }
 }
 
+static void virtio_memory_listener_commit(MemoryListener *listener)
+{
+    VirtIODevice *vdev = container_of(listener, VirtIODevice, listener);
+    int i;
+
+    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+        if (vdev->vq[i].vring.num == 0) {
+            break;
+        }
+        virtio_init_region_cache(vdev, i);
+    }
+}
+
 static void virtio_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -2262,6 +2322,9 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
+
+    vdev->listener.commit = virtio_memory_listener_commit;
+    memory_listener_register(&vdev->listener, vdev->dma_as);
 }
 
 static void virtio_device_unrealize(DeviceState *dev, Error **errp)
@@ -2284,6 +2347,27 @@ static void virtio_device_unrealize(DeviceState *dev, Error **errp)
     vdev->bus_name = NULL;
 }
 
+static void virtio_device_instance_finalize(Object *obj)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(obj);
+    int i;
+
+    memory_listener_unregister(&vdev->listener);
+    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+        VRingMemoryRegionCaches *caches;
+        if (vdev->vq[i].vring.num == 0) {
+            break;
+        }
+        caches = atomic_read(&vdev->vq[i].vring.caches);
+        atomic_set(&vdev->vq[i].vring.caches, NULL);
+        virtio_free_region_cache(caches);
+    }
+
+    g_free(vdev->config);
+    g_free(vdev->vq);
+    g_free(vdev->vector_queues);
+}
+
 static Property virtio_properties[] = {
     DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
     DEFINE_PROP_END_OF_LIST(),
@@ -2410,6 +2494,7 @@ static const TypeInfo virtio_device_info = {
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(VirtIODevice),
     .class_init = virtio_device_class_init,
+    .instance_finalize = virtio_device_instance_finalize,
     .abstract = true,
     .class_size = sizeof(VirtioDeviceClass),
 };
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 525da24..f1b2673 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -85,6 +85,7 @@ struct VirtIODevice
     uint32_t generation;
     int nvectors;
     VirtQueue *vq;
+    MemoryListener listener;
     uint16_t device_id;
     bool vm_running;
     bool broken; /* device in invalid state, needs reset */
-- 
2.9.3
