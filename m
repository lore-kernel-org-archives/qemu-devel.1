Received: from eggs.gnu.org ([2001:4830:134:3::10]:43661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ia-00057e-NW
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iX-0007qb-11
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8iW-0007pv-Pb
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:44 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEYSJ043437
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:44 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyea63uu0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:43 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:42 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:34 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-14-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 13/54] virtio_error: don't invoke status
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, "Michael S. Tsirkin" <mst@redhat.com>

From: "Michael S. Tsirkin" <mst@redhat.com>

Backends don't need to know what frontend requested a reset,
and notifying then from virtio_error is messy because
virtio_error itself might be invoked from backend.

Let's just set the status directly.

Cc: qemu-stable@nongnu.org
Reported-by: Ilya Maximets <i.maximets@samsung.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 8fc47c876de638353bb635872f2c25bb7f4a3d6e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index ad564b0132..d6002ee550 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2469,7 +2469,7 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
     va_end(ap);
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET);
+        vdev->status = vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET;
         virtio_notify_config(vdev);
     }
 
-- 
2.11.0
