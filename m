Received: from eggs.gnu.org ([2001:4830:134:3::10]:39397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkjB-0003tQ-VB
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkj7-0005dy-W3
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cfkj7-0005cr-Lf
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:49 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1K9rboV117490
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:48 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28pp6mfdk6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:48 -0500
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 20 Feb 2017 09:57:46 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Mon, 20 Feb 2017 10:57:28 +0100
In-Reply-To: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
References: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
Message-Id: <20170220095734.7890-7-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 06/12] virtio-ccw: Check the number of vqs in
 CCW_CMD_SET_IND
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

We cannot support more than 64 virtqueues with the 64 bits provided by
classic indicators. If a driver tries to setup classic indicators
(which it is free to do even for virtio-1 devices) for a device with
more than 64 virtqueues, we should reject the attempt so that the
driver does not end up with an unusable device.

This is in preparation for bumping the number of supported virtqueues
on the ccw transport.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/virtio-ccw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 613d8c6615..771411ea3c 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -35,6 +35,8 @@
 #include "trace.h"
 #include "hw/s390x/css-bridge.h"
 
+#define NR_CLASSIC_INDICATOR_BITS 64
+
 static void virtio_ccw_bus_new(VirtioBusState *bus, size_t bus_size,
                                VirtioCcwDevice *dev);
 
@@ -509,6 +511,11 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             ret = -ENOSYS;
             break;
         }
+        if (virtio_get_num_queues(vdev) > NR_CLASSIC_INDICATOR_BITS) {
+            /* More queues than indicator bits --> trigger a reject */
+            ret = -ENOSYS;
+            break;
+        }
         if (!ccw.cda) {
             ret = -EFAULT;
         } else {
-- 
2.11.0
