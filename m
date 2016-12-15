Received: from eggs.gnu.org ([2001:4830:134:3::10]:42964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC8-0003sr-VY
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC5-0001UD-Rh
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKC5-0001Sd-Hc
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:45 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hbL2016313
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:44 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm515g7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:44 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 19:46:43 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:40 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-47-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 46/67] virtio-net: mark VIRTIO_NET_F_GSO as
 legacy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

From: "Michael S. Tsirkin" <mst@redhat.com>

virtio 1.0 spec says this is a legacy feature bit,
hide it from guests in modern mode.

Note: for cross-version migration compatibility,
we keep the bit set in host_features.
The result will be that a guest migrating cross-version
will see host features change under it.
As guests only seem to read it once, this should
not be an issue. Meanwhile, will work to fix guests to
ignore this bit in virtio1 mode, too.

Cc: qemu-stable@nongnu.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
(cherry picked from commit 2a083ffd2e37ef08769749a5c7cfc6ca65c9f8ea)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/virtio-net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 01f1351..abc48d8 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1904,6 +1904,7 @@ static void virtio_net_class_init(ObjectClass *klass, void *data)
     vdc->guest_notifier_pending = virtio_net_guest_notifier_pending;
     vdc->load = virtio_net_load_device;
     vdc->save = virtio_net_save_device;
+    vdc->legacy_features |= (0x1 << VIRTIO_NET_F_GSO);
 }
 
 static const TypeInfo virtio_net_info = {
-- 
1.9.1
