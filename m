Received: from eggs.gnu.org ([2001:4830:134:3::10]:49743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCc-0000tp-JK
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCZ-0000tb-8j
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCZ-0000sS-0g
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:51 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JHU4c086443
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:50 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epmmmnnt6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:49 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:48 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:35 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-43-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 42/55] vhost: restore avail index from vring
 used index on disconnection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Maxime Coquelin <maxime.coquelin@redhat.com>

vhost_virtqueue_stop() gets avail index value from the backend,
except if the backend is not responding.

It happens when the backend crashes, and in this case, internal
state of the virtio queue is inconsistent, making packets
to corrupt the vring state.

With a Linux guest, it results in following error message on
backend reconnection:

[   22.444905] virtio_net virtio0: output.0:id 0 is not a head!
[   22.446746] net enp0s3: Unexpected TXQ (0) queue failure: -5
[   22.476360] net enp0s3: Unexpected TXQ (0) queue failure: -5

Fixes: 283e2c2adcb8 ("net: virtio-net discards TX data after link down")
Cc: qemu-stable@nongnu.org
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 2ae39a113af311cb56a0c35b7f212dafcef15303)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/vhost.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b737ca915b..76f6e1fcaa 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1137,6 +1137,10 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
     r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
     if (r < 0) {
         VHOST_OPS_DEBUG("vhost VQ %d ring restore failed: %d", idx, r);
+        /* Connection to the backend is broken, so let's sync internal
+         * last avail idx to the device used idx.
+         */
+        virtio_queue_restore_last_avail_idx(vdev, idx);
     } else {
         virtio_queue_set_last_avail_idx(vdev, idx, state.num);
     }
-- 
2.11.0
