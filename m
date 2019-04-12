Received: from eggs.gnu.org ([209.51.188.92]:39148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFu-0002ZN-6K
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFs-0002eA-Tt
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:26:06 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 12 Apr 2019 14:25:18 +0200
Message-Id: <20190412122523.24111-13-thuth@redhat.com>
In-Reply-To: <20190412122523.24111-1-thuth@redhat.com>
References: <20190412122523.24111-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 12/17] s390-bios:
 Refactor virtio to run channel programs via cio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cohuck@redhat.com, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, borntraeger@de.ibm.com

From: "Jason J. Herne" <jjherne@linux.ibm.com>

Now that we have a Channel I/O library let's modify virtio boot code to
make use of it for running channel programs.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1554388475-18329-13-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/virtio.c | 57 +++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index aa9da7253f..35278eaee1 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -14,6 +14,7 @@
 #include "virtio.h"
 #include "virtio-scsi.h"
 #include "bswap.h"
+#include "helper.h"
=20
 #define VRING_WAIT_REPLY_TIMEOUT 30
=20
@@ -89,33 +90,20 @@ int drain_irqs(SubChannelId schid)
     }
 }
=20
-static int run_ccw(VDev *vdev, int cmd, void *ptr, int len)
+static int run_ccw(VDev *vdev, int cmd, void *ptr, int len, bool sli)
 {
     Ccw1 ccw =3D {};
-    CmdOrb orb =3D {};
-    int r;
-
-    enable_subchannel(vdev->schid);
-
-    /* start subchannel command */
-    orb.fmt =3D 1;
-    orb.cpa =3D (u32)(long)&ccw;
-    orb.lpm =3D 0x80;
=20
     ccw.cmd_code =3D cmd;
     ccw.cda =3D (long)ptr;
     ccw.count =3D len;
=20
-    r =3D ssch(vdev->schid, &orb);
-    /*
-     * XXX Wait until device is done processing the CCW. For now we can
-     *     assume that a simple tsch will have finished the CCW processi=
ng,
-     *     but the architecture allows for asynchronous operation
-     */
-    if (!r) {
-        r =3D drain_irqs(vdev->schid);
+    if (sli) {
+        ccw.flags |=3D CCW_FLAG_SLI;
     }
-    return r;
+
+    enable_subchannel(vdev->schid);
+    return do_cio(vdev->schid, vdev->senseid.cu_type, ptr2u32(&ccw), CCW=
_FMT1);
 }
=20
 static void vring_init(VRing *vr, VqInfo *info)
@@ -257,7 +245,7 @@ void virtio_setup_ccw(VDev *vdev)
     vdev->config.blk.blk_size =3D 0; /* mark "illegal" - setup started..=
. */
     vdev->guessed_disk_nature =3D VIRTIO_GDN_NONE;
=20
-    run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0);
+    run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0, false);
=20
     switch (vdev->senseid.cu_model) {
     case VIRTIO_ID_NET:
@@ -278,18 +266,19 @@ void virtio_setup_ccw(VDev *vdev)
     default:
         panic("Unsupported virtio device\n");
     }
-    IPL_assert(run_ccw(vdev, CCW_CMD_READ_CONF, &vdev->config, cfg_size)=
 =3D=3D 0,
-               "Could not get block device configuration");
+    IPL_assert(
+        run_ccw(vdev, CCW_CMD_READ_CONF, &vdev->config, cfg_size, false)=
 =3D=3D 0,
+       "Could not get block device configuration");
=20
     /* Feature negotiation */
     for (i =3D 0; i < ARRAY_SIZE(vdev->guest_features); i++) {
         feats.features =3D 0;
         feats.index =3D i;
-        rc =3D run_ccw(vdev, CCW_CMD_READ_FEAT, &feats, sizeof(feats));
+        rc =3D run_ccw(vdev, CCW_CMD_READ_FEAT, &feats, sizeof(feats), f=
alse);
         IPL_assert(rc =3D=3D 0, "Could not get features bits");
         vdev->guest_features[i] &=3D bswap32(feats.features);
         feats.features =3D bswap32(vdev->guest_features[i]);
-        rc =3D run_ccw(vdev, CCW_CMD_WRITE_FEAT, &feats, sizeof(feats));
+        rc =3D run_ccw(vdev, CCW_CMD_WRITE_FEAT, &feats, sizeof(feats), =
false);
         IPL_assert(rc =3D=3D 0, "Could not set features bits");
     }
=20
@@ -306,16 +295,17 @@ void virtio_setup_ccw(VDev *vdev)
         };
=20
         IPL_assert(
-            run_ccw(vdev, CCW_CMD_READ_VQ_CONF, &config, sizeof(config))=
 =3D=3D 0,
+            run_ccw(vdev, CCW_CMD_READ_VQ_CONF, &config, sizeof(config),=
 false) =3D=3D 0,
             "Could not get block device VQ configuration");
         info.num =3D config.num;
         vring_init(&vdev->vrings[i], &info);
         vdev->vrings[i].schid =3D vdev->schid;
-        IPL_assert(run_ccw(vdev, CCW_CMD_SET_VQ, &info, sizeof(info)) =3D=
=3D 0,
-                   "Cannot set VQ info");
+        IPL_assert(
+            run_ccw(vdev, CCW_CMD_SET_VQ, &info, sizeof(info), false) =3D=
=3D 0,
+            "Cannot set VQ info");
     }
     IPL_assert(
-        run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status)) =3D=
=3D 0,
+        run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), fal=
se) =3D=3D 0,
         "Could not write status to host");
 }
=20
@@ -323,8 +313,15 @@ bool virtio_is_supported(SubChannelId schid)
 {
     vdev.schid =3D schid;
     memset(&vdev.senseid, 0, sizeof(vdev.senseid));
-    /* run sense id command */
-    if (run_ccw(&vdev, CCW_CMD_SENSE_ID, &vdev.senseid, sizeof(vdev.sens=
eid))) {
+
+    /*
+     * Run sense id command.
+     * The size of the senseid data differs between devices (notably,
+     * between virtio devices and dasds), so specify the largest possibl=
e
+     * size and suppress the incorrect length indication for smaller siz=
es.
+     */
+    if (run_ccw(&vdev, CCW_CMD_SENSE_ID, &vdev.senseid, sizeof(vdev.sens=
eid),
+                true)) {
         return false;
     }
     if (vdev.senseid.cu_type =3D=3D 0x3832) {
--=20
2.21.0
