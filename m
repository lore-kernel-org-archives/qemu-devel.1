Received: from eggs.gnu.org ([2001:4830:134:3::10]:47982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCR-0001F7-9e
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCO-0005Qp-4O
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34164
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCN-0005QP-Vr
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:08 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E7iZ017707
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:07 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmub2wvrt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:07 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:06 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:12 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-38-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 37/79] virtio-net: fix wild pointer when remove
 virtio-net queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yunjian Wang <wangyunjian@huawei.com>, Jason Wang <jasowang@redhat.com>

From: Yunjian Wang <wangyunjian@huawei.com>

The tx_bh or tx_timer will free in virtio_net_del_queue() function, when
removing virtio-net queues if the guest doesn't support multiqueue. But
it might be still referenced by virtio_net_set_status(), which needs to
be set NULL. And also the tx_waiting needs to be set zero to prevent
virtio_net_set_status() accessing tx_bh or tx_timer.

Cc: qemu-stable@nongnu.org
Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit f989c30cf834ba8625e98b808eac30e4e7ec5008)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/virtio-net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7d091c9..98bd683 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1522,9 +1522,12 @@ static void virtio_net_del_queue(VirtIONet *n, int index)
     if (q->tx_timer) {
         timer_del(q->tx_timer);
         timer_free(q->tx_timer);
+        q->tx_timer = NULL;
     } else {
         qemu_bh_delete(q->tx_bh);
+        q->tx_bh = NULL;
     }
+    q->tx_waiting = 0;
     virtio_del_queue(vdev, index * 2 + 1);
 }
 
-- 
2.7.4
