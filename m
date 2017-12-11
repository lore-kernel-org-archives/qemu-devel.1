Received: from eggs.gnu.org ([2001:4830:134:3::10]:33873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOU1y-00086R-28
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 14:46:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOU1x-0006fX-A3
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 14:46:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eOU1x-0006dv-49
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 14:46:25 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 11 Dec 2017 19:46:06 +0000
Message-Id: <20171211194610.3962-5-dgilbert@redhat.com>
In-Reply-To: <20171211194610.3962-1-dgilbert@redhat.com>
References: <20171211194610.3962-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/8] vhost: New memory update functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, imammedo@redhat.com
Cc: maxime.coquelin@redhat.com, mst@redhat.com, groug@kaod.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

vhost_update_mem will replace the existing update mechanism.
They make use of the Flatview we have now to make the update simpler.
This commit just adds the basic structure.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/vhost.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c7ce7baf9b..6d720036db 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -634,11 +634,51 @@ static void vhost_begin(MemoryListener *listener)
     dev->mem_changed_start_addr = -1;
 }
 
+struct vhost_update_mem_tmp {
+    struct vhost_dev   *dev;
+    uint32_t nregions;
+    struct vhost_memory_region *regions;
+};
+
+/* Called for each MRS from vhost_update_mem */
+static int vhost_update_mem_cb(MemoryRegionSection *mrs, void *opaque)
+{
+    if (!vhost_section(mrs)) {
+        return 0;
+    }
+
+    /* TODO */
+    return 0;
+}
+
+static int vhost_update_mem(struct vhost_dev *dev, bool *changed)
+{
+    int res;
+    struct vhost_update_mem_tmp vtmp;
+    vtmp.regions = 0;
+    vtmp.nregions = 0;
+    vtmp.dev = dev;
+
+    *changed = false;
+    res = address_space_iterate(&address_space_memory,
+                                vhost_update_mem_cb, &vtmp);
+    if (res) {
+        goto out;
+    }
+
+    /* TODO */
+    *changed = dev->mem_changed_start_addr < dev->mem_changed_end_addr;
+out:
+    g_free(vtmp.regions);
+    return res;
+}
+
 static void vhost_commit(MemoryListener *listener)
 {
     struct vhost_dev *dev = container_of(listener, struct vhost_dev,
                                          memory_listener);
     uint64_t log_size;
+    bool changed;
     int r;
 
     if (!dev->memory_changed) {
@@ -647,7 +687,12 @@ static void vhost_commit(MemoryListener *listener)
     if (!dev->started) {
         return;
     }
-    if (dev->mem_changed_start_addr > dev->mem_changed_end_addr) {
+    if (vhost_update_mem(dev, &changed)) {
+        return;
+    }
+
+    if (!changed) {
+        /* None of the mappings we care about changed */
         return;
     }
 
@@ -1523,6 +1568,7 @@ void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
 int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
 {
     int i, r;
+    bool changed;
 
     /* should only be called after backend is connected */
     assert(hdev->vhost_ops);
@@ -1535,6 +1581,9 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
         goto fail_features;
     }
 
+    if (vhost_update_mem(hdev, &changed)) {
+        goto fail_mem;
+    }
     if (vhost_dev_has_iommu(hdev)) {
         memory_listener_register(&hdev->iommu_listener, vdev->dma_as);
     }
-- 
2.14.3
