Received: from eggs.gnu.org ([2001:4830:134:3::10]:43639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gX1Ev-0006Ba-89
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gX1Et-0006oq-N5
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:55:37 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 12 Dec 2018 10:55:18 +0100
Message-Id: <20181212095519.6390-6-cohuck@redhat.com>
In-Reply-To: <20181212095519.6390-1-cohuck@redhat.com>
References: <20181212095519.6390-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] vfio-ap: flag as compatible with balloon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, qemu-stable@nongnu.org

vfio-ap devices do not pin any pages in the host. Therefore, they
are compatible with memory ballooning.

Flag them as compatible, so both vfio-ap and a balloon can be
used simultaneously.

Cc: qemu-stable@nongnu.org
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/ap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 65de952f44..0a25f5e096 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -104,6 +104,14 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
     vapdev->vdev.name = g_strdup_printf("%s", mdevid);
     vapdev->vdev.dev = dev;
 
+    /*
+     * vfio-ap devices operate in a way compatible with
+     * memory ballooning, as no pages are pinned in the host.
+     * This needs to be set before vfio_get_device() for vfio common to
+     * handle the balloon inhibitor.
+     */
+    vapdev->vdev.balloon_allowed = true;
+
     ret = vfio_get_device(vfio_group, mdevid, &vapdev->vdev, &local_err);
     if (ret) {
         goto out_get_dev_err;
-- 
2.17.2
