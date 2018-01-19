Received: from eggs.gnu.org ([2001:4830:134:3::10]:55503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ecU5R-0007m7-Kh
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ecU5O-00033P-K1
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:39:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ecU5O-00031z-EW
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:39:50 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 935AF780E9
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 10:39:49 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 19 Jan 2018 10:39:23 +0000
Message-Id: <20180119103924.332-7-dgilbert@redhat.com>
In-Reply-To: <20180119103924.332-1-dgilbert@redhat.com>
References: <20180119103924.332-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v7 6/7] vhost: Merge and delete unused callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com
Cc: maxime.coquelin@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Now that the olf vhost_set_memory code is gone, the _nop and _add
callbacks are identical and can be merged.  The _del callback is
no longer needed.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/virtio/vhost.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b2a8dd189f..5819ac6de7 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -554,8 +554,9 @@ static void vhost_region_add_section(struct vhost_dev *dev,
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
@@ -566,29 +567,6 @@ static void vhost_region_add(MemoryListener *listener,
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
@@ -1157,9 +1135,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
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
2.14.3
