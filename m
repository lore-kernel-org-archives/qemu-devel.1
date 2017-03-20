Received: from eggs.gnu.org ([2001:4830:134:3::10]:42101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6RC-0002Dz-IB
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6R0-0005NC-Je
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6R0-0005M5-Ai
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:54 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8XeZ109634
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:53 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ak40pccb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:53 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:52 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:43 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-80-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 79/81] virtio-pci: reset modern vq meta data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Jason Wang <jasowang@redhat.com>

We don't reset proxy->vqs[].{num|desc[]|avail[]|used[]}. This means if
a driver enable the vq without setting vq address after reset. The old
addresses were leaked. Fixing this by resetting modern vq meta data
during device reset.

Cc: qemu-stable@nongnu.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 60a8d8023473dd24957b3a66824f66cd35b80d64)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 21c2b9d..33eb1fb 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1836,6 +1836,10 @@ static void virtio_pci_reset(DeviceState *qdev)
 
     for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
         proxy->vqs[i].enabled = 0;
+        proxy->vqs[i].num = 0;
+        proxy->vqs[i].desc[0] = proxy->vqs[i].desc[1] = 0;
+        proxy->vqs[i].avail[0] = proxy->vqs[i].avail[1] = 0;
+        proxy->vqs[i].used[0] = proxy->vqs[i].used[1] = 0;
     }
 }
 
-- 
2.7.4
