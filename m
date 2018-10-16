Received: from eggs.gnu.org ([2001:4830:134:3::10]:52533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gCNzh-0007Sk-Mz
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gCNze-00026p-Fj
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:58:37 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 16 Oct 2018 13:58:17 +0200
Message-Id: <20181016115817.14605-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH] s390x/vfio-ap: report correct error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

If ioctl(..., VFIO_DEVICE_RESET) fails, we want to report errno
instead of ret (which is always -1 on error).

Fixes Coverity issue CID 1396176.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 3962bb74e5..65de952f44 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -142,7 +142,7 @@ static void vfio_ap_reset(DeviceState *dev)
     ret = ioctl(vapdev->vdev.fd, VFIO_DEVICE_RESET);
     if (ret) {
         error_report("%s: failed to reset %s device: %s", __func__,
-                     vapdev->vdev.name, strerror(ret));
+                     vapdev->vdev.name, strerror(errno));
     }
 }
 
-- 
2.14.4
