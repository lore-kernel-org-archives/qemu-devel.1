Received: from eggs.gnu.org ([2001:4830:134:3::10]:39469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGOdb-0004hg-4T
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGOdW-0000UR-Rw
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cGOdW-0000U0-JW
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:14 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Dec 2016 12:18:55 +0100
Message-Id: <20161212111857.23399-10-pbonzini@redhat.com>
In-Reply-To: <20161212111857.23399-1-pbonzini@redhat.com>
References: <20161212111857.23399-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 09/11] virtio: add MemoryListener to cache ring
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
Cc: stefanha@redhat.com, famz@redhat.com, mst@redhat.com, borntraeger@de.ibm.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/virtio.c         | 91 ++++++++++++++++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio.h |  1 +
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 562e2b7..4f355b4 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -59,6 +59,13 @@ typedef struct VRingUsed
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
@@ -67,6 +74,7 @@ typedef struct VRing
     hwaddr desc;
     hwaddr avail;
     hwaddr used;
+    VRingMemoryRegionCaches *caches;
 } VRing;
 
 struct VirtQueue
@@ -103,6 +111,46 @@ struct VirtQueue
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
+static void virtio_init_region_cache(VirtIODevice *vdev, int i)
+{
+    VirtQueue *vq = &vdev->vq[i];
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
+    size = virtio_queue_get_desc_size(vdev, i);
+    address_space_cache_init(&new->desc, &address_space_memory,
+                             addr, size, false);
+
+    size = virtio_queue_get_used_size(vdev, i) + event_size;
+    address_space_cache_init(&new->used, &address_space_memory,
+                             vq->vring.used, size, true);
+
+    size = virtio_queue_get_avail_size(vdev, i) + event_size;
+    address_space_cache_init(&new->avail, &address_space_memory,
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
@@ -116,6 +164,7 @@ void virtio_queue_update_rings(VirtIODevice *vdev, int n)
     vring->used = vring_align(vring->avail +
                               offsetof(VRingAvail, ring[vring->num]),
                               vring->align);
+    virtio_init_region_cache(vdev, n);
 }
 
 static void vring_desc_read(VirtIODevice *vdev, VRingDesc *desc,
@@ -1223,6 +1272,7 @@ void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
     vdev->vq[n].vring.desc = desc;
     vdev->vq[n].vring.avail = avail;
     vdev->vq[n].vring.used = used;
+    virtio_init_region_cache(vdev, n);
 }
 
 void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
@@ -1927,9 +1977,6 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
 void virtio_cleanup(VirtIODevice *vdev)
 {
     qemu_del_vm_change_state_handler(vdev->vmstate);
-    g_free(vdev->config);
-    g_free(vdev->vq);
-    g_free(vdev->vector_queues);
 }
 
 static void virtio_vmstate_change(void *opaque, int running, RunState state)
@@ -2150,6 +2197,19 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
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
@@ -2172,6 +2232,9 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
+
+    vdev->listener.commit = virtio_memory_listener_commit;
+    memory_listener_register(&vdev->listener, &address_space_memory);
 }
 
 static void virtio_device_unrealize(DeviceState *dev, Error **errp)
@@ -2194,6 +2257,27 @@ static void virtio_device_unrealize(DeviceState *dev, Error **errp)
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
@@ -2320,6 +2404,7 @@ static const TypeInfo virtio_device_info = {
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(VirtIODevice),
     .class_init = virtio_device_class_init,
+    .instance_finalize = virtio_device_instance_finalize,
     .abstract = true,
     .class_size = sizeof(VirtioDeviceClass),
 };
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 9b21795..5bcc9a8 100644
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
1.8.3.1
