Received: from eggs.gnu.org ([2001:4830:134:3::10]:46384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5ii-0002KY-56
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5ih-0000Fb-7s
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:08 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:21 -0500
Message-Id: <20180619014319.28272-56-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 055/113] vfio-ccw: fix memory leaks in
 vfio_ccw_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, Cornelia Huck <cohuck@redhat.com>

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
(cherry picked from commit be4d026f645eb31078e08d431c93a898b895024e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/vfio/ccw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 636729c03d..c74e107a04 100644
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
2.11.0
