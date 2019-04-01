Received: from eggs.gnu.org ([209.51.188.92]:40776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44W-0001JK-Bd
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44U-0003N7-W7
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44U-0003Bo-Fl
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1qAF062115
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:01:59 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksw4s013-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:01:58 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:01:55 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:02 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-29-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 28/97] virtio: update MemoryRegionCaches when
 guest negotiates features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Because the cache is sized to include the rings and the event indices,
negotiating the VIRTIO_RING_F_EVENT_IDX feature will result in the size
of the cache changing.  And because MemoryRegionCache accesses are
range-checked, if we skip this we end up with an assertion failure.
This happens with OpenBSD 6.3.

Reported-by: Fam Zheng <famz@redhat.com>
Fixes: 97cd965c070152bc626c7507df9fb356bbe1cd81
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit db812c4073c77c8a64db8d6663b3416a587c7b4a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d4e4d98b59..f6a588ab57 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2006,14 +2006,25 @@ static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val)
 
 int virtio_set_features(VirtIODevice *vdev, uint64_t val)
 {
-   /*
+    int ret;
+    /*
      * The driver must not attempt to set features after feature negotiation
      * has finished.
      */
     if (vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) {
         return -EINVAL;
     }
-    return virtio_set_features_nocheck(vdev, val);
+    ret = virtio_set_features_nocheck(vdev, val);
+    if (!ret && virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
+        /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
+        int i;
+        for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+            if (vdev->vq[i].vring.num != 0) {
+                virtio_init_region_cache(vdev, i);
+            }
+        }
+    }
+    return ret;
 }
 
 int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
-- 
2.17.1
