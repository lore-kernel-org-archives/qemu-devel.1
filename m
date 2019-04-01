Received: from eggs.gnu.org ([209.51.188.92]:40998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44f-0001UP-VW
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44e-0003Vi-VB
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44e-0003KY-Gl
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:32 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31KrY5M049994
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:18 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkqrc07k8-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:17 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:16 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:13 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-40-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 39/97] clean up callback when del virtqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, liujunjie <liujunjie23@huawei.com>, Jason Wang <jasowang@redhat.com>

From: liujunjie <liujunjie23@huawei.com>

Before, we did not clear callback like handle_output when delete
the virtqueue which may result be segmentfault.
The scene is as follows:
1. Start a vm with multiqueue vhost-net,
2. then we write VIRTIO_PCI_GUEST_FEATURES in PCI configuration to
triger multiqueue disable in this vm which will delete the virtqueue.
In this step, the tx_bh is deleted but the callback virtio_net_handle_tx_bh
still exist.
3. Finally, we write VIRTIO_PCI_QUEUE_NOTIFY in PCI configuration to
notify the deleted virtqueue. In this way, virtio_net_handle_tx_bh
will be called and qemu will be crashed.

Although the way described above is uncommon, we had better reinforce it.

CC: qemu-stable@nongnu.org
Signed-off-by: liujunjie <liujunjie23@huawei.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 7da2d99fb9fbf30104125c061caaff330e362d74)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f6a588ab57..57a603a65b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1604,6 +1604,8 @@ void virtio_del_queue(VirtIODevice *vdev, int n)
 
     vdev->vq[n].vring.num = 0;
     vdev->vq[n].vring.num_default = 0;
+    vdev->vq[n].handle_output = NULL;
+    vdev->vq[n].handle_aio_output = NULL;
 }
 
 static void virtio_set_isr(VirtIODevice *vdev, int value)
-- 
2.17.1
