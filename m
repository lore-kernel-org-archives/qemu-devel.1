Received: from eggs.gnu.org ([2001:4830:134:3::10]:48997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCu-0001qs-Ua
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCr-0006Ha-Ox
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCr-0006GM-H8
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:37 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EBPK042816
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:36 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmr8nf0mq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:36 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:35 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:46 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-72-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 71/79] virtio-net: fix offload ctrl endian
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dfleytma@redhat.com>

From: Jason Wang <jasowang@redhat.com>

Spec said offloads should be le64, so use virtio_ldq_p() to guarantee
valid endian.

Fixes: 644c98587d4c ("virtio-net: dynamic network offloads configuration")
Cc: qemu-stable@nongnu.org
Cc: Dmitry Fleytman <dfleytma@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 189ae6bb5ce1f5a322f8691d00fe942ba43dd601)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/virtio-net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 98bd683..7695f75 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -723,6 +723,8 @@ static int virtio_net_handle_offloads(VirtIONet *n, uint8_t cmd,
     if (cmd == VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET) {
         uint64_t supported_offloads;
 
+        offloads = virtio_ldq_p(vdev, &offloads);
+
         if (!n->has_vnet_hdr) {
             return VIRTIO_NET_ERR;
         }
-- 
2.7.4
