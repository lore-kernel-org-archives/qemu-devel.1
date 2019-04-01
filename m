Received: from eggs.gnu.org ([209.51.188.92]:42553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46o-0003NE-Ul
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46k-0004ks-ES
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46840
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB46g-0004cE-OU
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:40 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4NPo017104
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:28 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rks40kf4j-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:24 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:02 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:06 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-33-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 32/97] vhost: fix invalid downcast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yury Kotov <yury-kotov@yandex-team.ru>, "Michael S . Tsirkin" <mst@redhat.com>

From: Yury Kotov <yury-kotov@yandex-team.ru>

virtio_queue_get_desc_addr returns 64-bit hwaddr while int is usually 32-bit.
If returned hwaddr is not equal to 0 but least-significant 32 bits are
equal to 0 then this code will not actually stop running queue.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Acked-by: Jia He <hejianet@gmail.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit fa4ae4be15fb08b37bec35139688ef563311d0b9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/vhost.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index d4cb5894a8..569c4053ea 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1073,10 +1073,8 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
         .index = vhost_vq_index,
     };
     int r;
-    int a;
 
-    a = virtio_queue_get_desc_addr(vdev, idx);
-    if (a == 0) {
+    if (virtio_queue_get_desc_addr(vdev, idx) == 0) {
         /* Don't stop the virtqueue which might have not been started */
         return;
     }
-- 
2.17.1
