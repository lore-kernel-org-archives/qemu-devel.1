Received: from eggs.gnu.org ([2001:4830:134:3::10]:42773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyUJt-0005FV-66
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyUJp-0001Vx-7E
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:21:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37798 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eyUJp-0001V7-3Y
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:21:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B21AA4040070
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 03:21:34 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 21 Mar 2018 11:21:24 +0800
Message-Id: <20180321032124.24028-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH] vhost: add trace for IOTLB miss
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

Add some trace points for IOTLB translation for vhost. After vhost-user
is setup, the only IO path that QEMU will participate should be the
IOMMU translation, so it'll be good we can track this with explicit
timestamps when needed to see how long time we take to do the
translation, and whether there's anything stuck inside.  It might be
useful for triaging vhost-user problems.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/virtio/trace-events | 1 +
 hw/virtio/vhost.c      | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 742ff0f90b..933eaab133 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -5,6 +5,7 @@ vhost_commit(bool started, bool changed) "Started: %d Changed: %d"
 vhost_region_add_section(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
 vhost_region_add_section_abut(const char *name, uint64_t new_size) "%s: 0x%"PRIx64
 vhost_section(const char *name, int r) "%s:%d"
+vhost_iotlb_miss(void *dev, int step) "%p step %d"
 
 # hw/virtio/virtio.c
 virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index d8d0ef92e1..aa68f79510 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -839,12 +839,15 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
 
     rcu_read_lock();
 
+    trace_vhost_iotlb_miss(dev, 1);
+
     iotlb = address_space_get_iotlb_entry(dev->vdev->dma_as,
                                           iova, write);
     if (iotlb.target_as != NULL) {
         ret = vhost_memory_region_lookup(dev, iotlb.translated_addr,
                                          &uaddr, &len);
         if (ret) {
+            trace_vhost_iotlb_miss(dev, 3);
             error_report("Fail to lookup the translated address "
                          "%"PRIx64, iotlb.translated_addr);
             goto out;
@@ -856,10 +859,14 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
         ret = vhost_backend_update_device_iotlb(dev, iova, uaddr,
                                                 len, iotlb.perm);
         if (ret) {
+            trace_vhost_iotlb_miss(dev, 4);
             error_report("Fail to update device iotlb");
             goto out;
         }
     }
+
+    trace_vhost_iotlb_miss(dev, 2);
+
 out:
     rcu_read_unlock();
 
-- 
2.14.3
