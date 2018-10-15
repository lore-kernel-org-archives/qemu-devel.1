Received: from eggs.gnu.org ([2001:4830:134:3::10]:39712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1RE-0004Hz-Dz
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1RD-0002DK-1E
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gC1RA-0001xM-VK
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EC4A11530
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:53:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 15 Oct 2018 13:52:40 +0200
Message-Id: <20181015115309.17089-7-armbru@redhat.com>
In-Reply-To: <20181015115309.17089-1-armbru@redhat.com>
References: <20181015115309.17089-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/35] vfio: Clean up error reporting after
 previous commit
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

The previous commit changed vfio's warning messages from

    vfio warning: DEV-NAME: Could not frobnicate

to

    warning: vfio DEV-NAME: Could not frobnicate

To match this change, change error messages from

    vfio error: DEV-NAME: On fire

to

    vfio DEV-NAME: On fire

Note the loss of "error".  If we think marking error messages that way
is a good idea, we should mark *all* error messages, i.e. make
error_report() print it.

Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci-quirks.c          | 4 ++--
 hw/vfio/pci.c                 | 8 ++++----
 hw/vfio/platform.c            | 2 +-
 include/hw/vfio/vfio-common.h | 1 -
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 481fd08df7..eae31c74d6 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1670,7 +1670,7 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
      * but also no point in us enabling VGA if disabled in hardware.
      */
     if (!(gmch & 0x2) && !vdev->vga && vfio_populate_vga(vdev, &err)) {
-        error_reportf_err(err, ERR_PREFIX, vdev->vbasedev.name);
+        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         error_report("IGD device %s failed to enable VGA access, "
                      "legacy mode disabled", vdev->vbasedev.name);
         goto out;
@@ -1696,7 +1696,7 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     ret = vfio_pci_igd_opregion_init(vdev, opregion, &err);
     if (ret) {
         error_append_hint(&err, "IGD legacy mode disabled\n");
-        error_reportf_err(err, ERR_PREFIX, vdev->vbasedev.name);
+        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         goto out;
     }
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 79ea45e1f3..0338e08819 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -742,7 +742,7 @@ static void vfio_msi_disable_common(VFIOPCIDevice *vdev)
 
     vfio_intx_enable(vdev, &err);
     if (err) {
-        error_reportf_err(err, ERR_PREFIX, vdev->vbasedev.name);
+        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 }
 
@@ -2193,7 +2193,7 @@ static void vfio_pci_post_reset(VFIOPCIDevice *vdev)
 
     vfio_intx_enable(vdev, &err);
     if (err) {
-        error_reportf_err(err, ERR_PREFIX, vdev->vbasedev.name);
+        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
     for (nr = 0; nr < PCI_NUM_REGIONS - 1; ++nr) {
@@ -2827,7 +2827,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     if (stat(vdev->vbasedev.sysfsdev, &st) < 0) {
         error_setg_errno(errp, errno, "no such host device");
-        error_prepend(errp, ERR_PREFIX, vdev->vbasedev.sysfsdev);
+        error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.sysfsdev);
         return;
     }
 
@@ -3078,7 +3078,7 @@ out_teardown:
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
 error:
-    error_prepend(errp, ERR_PREFIX, vdev->vbasedev.name);
+    error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
 }
 
 static void vfio_instance_finalize(Object *obj)
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index c1aecac43c..61852f711b 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -668,7 +668,7 @@ out:
     }
 
     if (vdev->vbasedev.name) {
-        error_prepend(errp, ERR_PREFIX, vdev->vbasedev.name);
+        error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     } else {
         error_prepend(errp, "vfio error: ");
     }
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c788e68bf8..28483fce7c 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -30,7 +30,6 @@
 #include <linux/vfio.h>
 #endif
 
-#define ERR_PREFIX "vfio error: %s: "
 #define VFIO_MSG_PREFIX "vfio %s: "
 
 enum {
-- 
2.17.1
