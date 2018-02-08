Received: from eggs.gnu.org ([2001:4830:134:3::10]:54101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZB-00064M-Pz
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZA-0008Ha-PM
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42100 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ejrZA-0008H7-Jj
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:04 -0500
Date: Thu, 8 Feb 2018 21:09:03 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1518116908-10852-10-git-send-email-mst@redhat.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518116908-10852-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 09/26] vhost: Merge and delete unused callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Now that the olf vhost_set_memory code is gone, the _nop and _add
callbacks are identical and can be merged.  The _del callback is
no longer needed.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c7814d1..326f168 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -560,8 +560,9 @@ static void vhost_region_add_section(struct vhost_dev *dev,
     }
 }
 
-static void vhost_region_add(MemoryListener *listener,
-                             MemoryRegionSection *section)
+/* Used for both add and nop callbacks */
+static void vhost_region_addnop(MemoryListener *listener,
+                                MemoryRegionSection *section)
 {
     struct vhost_dev *dev = container_of(listener, struct vhost_dev,
                                          memory_listener);
@@ -572,29 +573,6 @@ static void vhost_region_add(MemoryListener *listener,
     vhost_region_add_section(dev, section);
 }
 
-/* Called on regions that have not changed */
-static void vhost_region_nop(MemoryListener *listener,
-                             MemoryRegionSection *section)
-{
-    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
-                                         memory_listener);
-
-    if (!vhost_section(section)) {
-        return;
-    }
-
-    vhost_region_add_section(dev, section);
-}
-
-static void vhost_region_del(MemoryListener *listener,
-                             MemoryRegionSection *section)
-{
-    if (!vhost_section(section)) {
-        return;
-    }
-
-}
-
 static void vhost_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 {
     struct vhost_iommu *iommu = container_of(n, struct vhost_iommu, n);
@@ -1163,9 +1141,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->memory_listener = (MemoryListener) {
         .begin = vhost_begin,
         .commit = vhost_commit,
-        .region_add = vhost_region_add,
-        .region_del = vhost_region_del,
-        .region_nop = vhost_region_nop,
+        .region_add = vhost_region_addnop,
+        .region_nop = vhost_region_addnop,
         .log_start = vhost_log_start,
         .log_stop = vhost_log_stop,
         .log_sync = vhost_log_sync,
-- 
MST
