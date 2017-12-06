Received: from eggs.gnu.org ([2001:4830:134:3::10]:49959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCi-0000yY-FN
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCf-00011W-Dg
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCf-00010M-4S
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:57 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JHuHG056846
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:56 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epmpw5emb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:55 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:54 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:40 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-48-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 47/55] virtio-net: don't touch virtqueue if vm
 is stopped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Jason Wang <jasowang@redhat.com>

Guest state should not be touched if VM is stopped, unfortunately we
didn't check running state and tried to drain tx queue unconditionally
in virtio_net_set_status(). A crash was then noticed as a migration
destination when user type quit after virtqueue state is loaded but
before region cache is initialized. In this case,
virtio_net_drop_tx_queue_data() tries to access the uninitialized
region cache.

Fix this by only dropping tx queue data when vm is running.

Fixes: 283e2c2adcb80 ("net: virtio-net discards TX data after link down")
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 70e53e6e4da3db4b2c31981191753a7e974936d0)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/virtio-net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 148071a396..fbc5e1bd73 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -288,7 +288,8 @@ static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
                 qemu_bh_cancel(q->tx_bh);
             }
             if ((n->status & VIRTIO_NET_S_LINK_UP) == 0 &&
-                (queue_status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+                (queue_status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+                vdev->vm_running) {
                 /* if tx is waiting we are likely have some packets in tx queue
                  * and disabled notification */
                 q->tx_waiting = 0;
-- 
2.11.0
