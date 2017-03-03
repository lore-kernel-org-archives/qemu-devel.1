Received: from eggs.gnu.org ([2001:4830:134:3::10]:46234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cjiw7-0002Cn-21
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 03:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cjiw4-00027J-0e
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 03:51:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cjiw3-00026y-QP
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 03:51:35 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7D9B13AA1
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 08:51:35 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
Date: Fri,  3 Mar 2017 16:51:28 +0800
Message-Id: <1488531088-12483-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio: unbreak 1.0 device load with region
 cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Current code depends on virtio_queue_update_rings() to setup address
space cache. But this does not work for 1.0 device since we can't infer
avail and used. Fixing this by calling virtio_init_region_cache()
after subsections load which can guarantee avail and used are correct.

Fixes: 97cd965c0701 ("virtio: use VRingMemoryRegionCaches for avail
                      and used rings")
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/virtio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 23483c7..faa45cb 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2059,6 +2059,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
 
     rcu_read_lock();
     for (i = 0; i < num; i++) {
+        virtio_init_region_cache(vdev, i);
         if (vdev->vq[i].vring.desc) {
             uint16_t nheads;
             nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
-- 
2.7.4
