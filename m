Received: from eggs.gnu.org ([209.51.188.92]:39001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEb4d-0003Mx-1C
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEb4b-0000o4-34
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:53:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4041)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hEb4X-0000lj-Um
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:53:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C23F69AE78
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 14:53:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 11 Apr 2019 16:52:49 +0200
Message-Id: <20190411145256.8614-9-armbru@redhat.com>
In-Reply-To: <20190411145256.8614-1-armbru@redhat.com>
References: <20190411145256.8614-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/15] vfio: Report warnings with
 warn_report(), not error_printf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>

Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/vfio/pci.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 504019c458..0142819ea6 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -947,8 +947,10 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
     if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
         /* Since pci handles romfile, just print a message and return */
         if (vfio_blacklist_opt_rom(vdev) && vdev->pdev.romfile) {
-            error_printf("Warning : Device at %s is known to cause system instability issues during option rom execution. Proceeding anyway since user specified romfile\n",
-                         vdev->vbasedev.name);
+            warn_report("Device at %s is known to cause system instability"
+                        " issues during option rom execution",
+                        vdev->vbasedev.name);
+            error_printf("Proceeding anyway since user specified romfile\n");
         }
         return;
     }
@@ -973,11 +975,16 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 
     if (vfio_blacklist_opt_rom(vdev)) {
         if (dev->opts && qemu_opt_get(dev->opts, "rombar")) {
-            error_printf("Warning : Device at %s is known to cause system instability issues during option rom execution. Proceeding anyway since user specified non zero value for rombar\n",
-                         vdev->vbasedev.name);
+            warn_report("Device at %s is known to cause system instability"
+                        " issues during option rom execution",
+                        vdev->vbasedev.name);
+            error_printf("Proceeding anyway since user specified"
+                         " non zero value for rombar\n");
         } else {
-            error_printf("Warning : Rom loading for device at %s has been disabled due to system instability issues. Specify rombar=1 or romfile to force\n",
-                         vdev->vbasedev.name);
+            warn_report("Rom loading for device at %s has been disabled"
+                        " due to system instability issues",
+                        vdev->vbasedev.name);
+            error_printf("Specify rombar=1 or romfile to force\n");
             return;
         }
     }
-- 
2.17.2
