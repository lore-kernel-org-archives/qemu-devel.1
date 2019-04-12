Received: from eggs.gnu.org ([209.51.188.92]:39030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFp-0002SV-Ka
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFn-0002Ya-Fl
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:26:01 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 12 Apr 2019 14:25:16 +0200
Message-Id: <20190412122523.24111-11-thuth@redhat.com>
In-Reply-To: <20190412122523.24111-1-thuth@redhat.com>
References: <20190412122523.24111-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 10/17] s390-bios: Extend
 find_dev() for non-virtio devices
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

We need a method for finding the subchannel of a dasd device. Let's
modify find_dev to handle this since it mostly does what we need. Up to
this point find_dev has been specific to only virtio devices.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <1554388475-18329-11-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index e403b5f733..d04ea8972a 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -52,6 +52,12 @@ unsigned int get_loadparm_index(void)
     return atoui(loadparm_str);
 }
=20
+/*
+ * Find the subchannel connected to the given device (dev_no) and fill i=
n the
+ * subchannel information block (schib) with the connected subchannel's =
info.
+ * NOTE: The global variable blk_schid is updated to contain the subchan=
nel
+ * information.
+ */
 static bool find_dev(Schib *schib, int dev_no)
 {
     int i, r;
@@ -65,15 +71,15 @@ static bool find_dev(Schib *schib, int dev_no)
         if (!schib->pmcw.dnv) {
             continue;
         }
-        if (!virtio_is_supported(blk_schid)) {
-            continue;
-        }
+
         /* Skip net devices since no IPLB is created and therefore no
-         * no network bootloader has been loaded
+         * network bootloader has been loaded
          */
-        if (virtio_get_device_type() =3D=3D VIRTIO_ID_NET && dev_no < 0)=
 {
+        if (virtio_is_supported(blk_schid) &&
+            virtio_get_device_type() =3D=3D VIRTIO_ID_NET && dev_no < 0)=
 {
             continue;
         }
+
         if ((dev_no < 0) || (schib->pmcw.dev =3D=3D dev_no)) {
             return true;
         }
--=20
2.21.0
