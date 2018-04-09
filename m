Received: from eggs.gnu.org ([2001:4830:134:3::10]:47745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5YWR-0006Bq-QR
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5YWO-0005YZ-LZ
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:15:55 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  9 Apr 2018 17:15:31 +0200
Message-Id: <20180409151533.2253-7-cohuck@redhat.com>
In-Reply-To: <20180409151533.2253-1-cohuck@redhat.com>
References: <20180409151533.2253-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.12 6/8] vfio-ccw: fix memory leaks in
 vfio_ccw_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Cornelia Huck <cohuck@redhat.com>

From: Greg Kurz <groug@kaod.org>

If the subchannel is already attached or if vfio_get_device() fails, the
code jumps to the 'out_device_err' label and doesn't free the string it
has just allocated.

The code should be reworked so that vcdev->vdev.name only gets set when
the device has been attached, and freed when it is about to be detached.
This could be achieved  with the addition of a vfio_ccw_get_device()
function that would be the counterpart of vfio_put_device(). But this is
a more elaborate cleanup that should be done in a follow-up. For now,
let's just add calls to g_free() on the buggy error paths.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <152311222681.203086.8874800175539040298.stgit@bahia>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/ccw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 4e5855741a..fe34b50769 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -357,11 +357,13 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         if (strcmp(vbasedev->name, vcdev->vdev.name) == 0) {
             error_setg(&err, "vfio: subchannel %s has already been attached",
                        vcdev->vdev.name);
+            g_free(vcdev->vdev.name);
             goto out_device_err;
         }
     }
 
     if (vfio_get_device(group, cdev->mdevid, &vcdev->vdev, &err)) {
+        g_free(vcdev->vdev.name);
         goto out_device_err;
     }
 
-- 
2.14.3
