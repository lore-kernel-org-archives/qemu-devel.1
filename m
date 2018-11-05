Received: from eggs.gnu.org ([2001:4830:134:3::10]:53638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gJhzn-0008Oe-1x
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gJhzl-0001ik-Jx
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:44:58 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  5 Nov 2018 17:43:35 +0100
Message-Id: <20181105164340.20707-2-cohuck@redhat.com>
In-Reply-To: <20181105164340.20707-1-cohuck@redhat.com>
References: <20181105164340.20707-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 1/6] s390x/vfio-ap: report correct error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Collin Walling <walling@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

If ioctl(..., VFIO_DEVICE_RESET) fails, we want to report errno
instead of ret (which is always -1 on error).

Fixes Coverity issue CID 1396176.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
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
2.14.5
