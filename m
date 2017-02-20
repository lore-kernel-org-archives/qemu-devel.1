Received: from eggs.gnu.org ([2001:4830:134:3::10]:39438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkjE-0003vz-Ia
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkjA-0005gl-J4
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39231
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cfkjA-0005g7-Cq
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:52 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1K9sGOX016434
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:51 -0500
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28qshc2q1x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:51 -0500
Received: from localhost
	by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 20 Feb 2017 09:57:49 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Mon, 20 Feb 2017 10:57:30 +0100
In-Reply-To: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
References: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
Message-Id: <20170220095734.7890-9-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 08/12] virtio-ccw: check
 flic->adapter_routes_max_batch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Currently VIRTIO_CCW_QUEUE_MAX is defined as ADAPTER_ROUTES_MAX_GSI.
That is when checking queue max we implicitly check the constraint
concerning the number of adapter routes. This won't be satisfactory any
more (due to backward migration considerations) if ADAPTER_ROUTES_MAX_GSI
changes (ADAPTER_ROUTES_MAX_GSI is going to change because we want to
support up to VIRTIO_QUEUE_MAX queues per virtio-ccw device).

Let us introduce a check on a recently introduce flic property which
gives us the compatibility machine aware limit on adapter routes.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/virtio-ccw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 771411ea3c..a2ea95947f 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1319,6 +1319,7 @@ static void virtio_ccw_device_plugged(DeviceState *d, Error **errp)
     CcwDevice *ccw_dev = CCW_DEVICE(d);
     SubchDev *sch = ccw_dev->sch;
     int n = virtio_get_num_queues(vdev);
+    S390FLICState *flic = s390_get_flic();
 
     if (!virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
         dev->max_rev = 0;
@@ -1330,6 +1331,12 @@ static void virtio_ccw_device_plugged(DeviceState *d, Error **errp)
                    VIRTIO_CCW_QUEUE_MAX);
         return;
     }
+    if (virtio_get_num_queues(vdev) > flic->adapter_routes_max_batch) {
+        error_setg(errp, "The number of virtqueues %d "
+                   "exceeds flic adapter route limit %d", n,
+                   flic->adapter_routes_max_batch);
+        return;
+    }
 
     sch->id.cu_model = virtio_bus_get_vdev_id(&dev->bus);
 
-- 
2.11.0
