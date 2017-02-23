Received: from eggs.gnu.org ([2001:4830:134:3::10]:34695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cgz8Z-0005UI-26
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cgz8U-0002E7-2x
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:33:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cgz8T-0002Ce-TY
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:33:06 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15C533A76BB
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 19:33:06 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 23 Feb 2017 12:33:04 -0700
Message-ID: <20170223193258.16909.52582.stgit@gimli.home>
In-Reply-To: <20170223193048.16909.25661.stgit@gimli.home>
References: <20170223193048.16909.25661.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] vfio/pci: Report errors from qdev_unplug()
 via device request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Currently we ignore this error, report it with error_reportf_err()

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/vfio/pci.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 332f41d6627f..f2ba9b6cfafc 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2506,12 +2506,16 @@ static void vfio_unregister_err_notifier(VFIOPCID=
evice *vdev)
 static void vfio_req_notifier_handler(void *opaque)
 {
     VFIOPCIDevice *vdev =3D opaque;
+    Error *err =3D NULL;
=20
     if (!event_notifier_test_and_clear(&vdev->req_notifier)) {
         return;
     }
=20
-    qdev_unplug(&vdev->pdev.qdev, NULL);
+    qdev_unplug(&vdev->pdev.qdev, &err);
+    if (err) {
+        error_reportf_err(err, WARN_PREFIX, vdev->vbasedev.name);
+    }
 }
=20
 static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
