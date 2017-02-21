Received: from eggs.gnu.org ([2001:4830:134:3::10]:40256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cgFpV-0002Fx-Ks
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:10:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cgFpQ-0001vM-MP
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:10:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cgFpQ-0001vH-G4
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:10:24 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B839780462
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 19:10:24 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 21 Feb 2017 12:10:23 -0700
Message-ID: <20170221190955.8616.21658.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] vfio/pci: Report errors from qdev_unplug() via
 device request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, alex.williamson@redhat.com

Currently we ignore this error, report it with error_reportf_err()

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 332f41d6627f..f2ba9b6cfafc 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2506,12 +2506,16 @@ static void vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
 static void vfio_req_notifier_handler(void *opaque)
 {
     VFIOPCIDevice *vdev = opaque;
+    Error *err = NULL;
 
     if (!event_notifier_test_and_clear(&vdev->req_notifier)) {
         return;
     }
 
-    qdev_unplug(&vdev->pdev.qdev, NULL);
+    qdev_unplug(&vdev->pdev.qdev, &err);
+    if (err) {
+        error_reportf_err(err, WARN_PREFIX, vdev->vbasedev.name);
+    }
 }
 
 static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
