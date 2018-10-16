Received: from eggs.gnu.org ([2001:4830:134:3::10]:56619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTM7-00063T-6n
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTM5-00005c-0r
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCTM4-0008WT-OJ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1FE8413A90
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 17:42:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 16 Oct 2018 19:41:25 +0200
Message-Id: <20181016174158.15229-6-armbru@redhat.com>
In-Reply-To: <20181016174158.15229-1-armbru@redhat.com>
References: <20181016174158.15229-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 05/38] vfio: Use warn_report() & friends to
 report warnings
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

The vfio code reports warnings like

    error_report(WARN_PREFIX "Could not frobnicate", DEV-NAME);

where WARN_PREFIX is defined so the message comes out as

    vfio warning: DEV-NAME: Could not frobnicate

This usage predates the introduction of warn_report() & friends in
commit 97f40301f1d.  It's time to convert to that interface.  Since
these functions already prefix the message with "warning: ", replace
WARN_PREFIX by VFIO_MSG_PREFIX, so the messages come out like

    warning: vfio DEV-NAME: Could not frobnicate

The next commit will replace ERR_PREFIX.

Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c                 | 14 +++++++-------
 hw/vfio/platform.c            |  4 ++--
 include/hw/vfio/vfio-common.h |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4404c28360..0c3d245932 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -252,7 +252,7 @@ static void vfio_intx_update(PCIDevice *pdev)
 
     vfio_intx_enable_kvm(vdev, &err);
     if (err) {
-        error_reportf_err(err, WARN_PREFIX, vdev->vbasedev.name);
+        warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
     /* Re-enable the interrupt in cased we missed an EOI */
@@ -317,7 +317,7 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 
     vfio_intx_enable_kvm(vdev, &err);
     if (err) {
-        error_reportf_err(err, WARN_PREFIX, vdev->vbasedev.name);
+        warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
     vdev->interrupt = VFIO_INT_INTx;
@@ -1557,7 +1557,7 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
                     &err);
     if (ret < 0) {
         if (ret == -ENOTSUP) {
-            error_report_err(err);
+            warn_report_err(err);
             return 0;
         }
 
@@ -2590,9 +2590,9 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     } else if (irq_info.count == 1) {
         vdev->pci_aer = true;
     } else {
-        error_report(WARN_PREFIX
-                     "Could not enable error recovery for the device",
-                     vbasedev->name);
+        warn_report(VFIO_MSG_PREFIX
+                    "Could not enable error recovery for the device",
+                    vbasedev->name);
     }
 }
 
@@ -2717,7 +2717,7 @@ static void vfio_req_notifier_handler(void *opaque)
 
     qdev_unplug(&vdev->pdev.qdev, &err);
     if (err) {
-        error_reportf_err(err, WARN_PREFIX, vdev->vbasedev.name);
+        warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 }
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 64c1af653d..baf236ae79 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -679,8 +679,8 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < vbasedev->num_regions; i++) {
         if (vfio_region_mmap(vdev->regions[i])) {
-            error_report("%s mmap unsupported. Performance may be slow",
-                         memory_region_name(vdev->regions[i]->mem));
+            warn_report("%s mmap unsupported, performance may be slow",
+                        memory_region_name(vdev->regions[i]->mem));
         }
         sysbus_init_mmio(sbdev, vdev->regions[i]->mem);
     }
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index e46a28910a..1d7630345b 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -32,7 +32,7 @@
 #endif
 
 #define ERR_PREFIX "vfio error: %s: "
-#define WARN_PREFIX "vfio warning: %s: "
+#define VFIO_MSG_PREFIX "vfio %s: "
 
 enum {
     VFIO_DEVICE_TYPE_PCI = 0,
-- 
2.17.1
