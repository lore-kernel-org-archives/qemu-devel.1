Received: from eggs.gnu.org ([2001:4830:134:3::10]:39164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dUe4r-0004MA-Rx
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dUe4o-0001p4-CI
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:10:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dUe4o-0001oJ-2V
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:10:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0798A369BD
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 19:10:33 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 10 Jul 2017 13:10:30 -0600
Message-ID: <20170710191023.32728.20684.stgit@gimli.home>
In-Reply-To: <20170710190904.32728.74078.stgit@gimli.home>
References: <20170710190904.32728.74078.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 1/2] vfio: Test realized when using
 VFIOGroup.device_list iterator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

VFIOGroup.device_list is effectively our reference tracking mechanism
such that we can teardown a group when all of the device references
are removed.  However, we also use this list from our machine reset
handler for processing resets that affect multiple devices.  Generally
device removals are fully processed (exitfn + finalize) when this
reset handler is invoked, however if the removal is triggered via
another reset handler (piix4_reset->acpi_pcihp_reset) then the device
exitfn may run, but not finalize.  In this case we hit asserts when
we start trying to access PCI helpers since much of the PCI state of
the device is released.  To resolve this, add a pointer to the Object
DeviceState in our common base-device and skip non-realized devices
as we iterate.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c              |    6 ++++--
 hw/vfio/pci.c                 |    7 +++++--
 hw/vfio/platform.c            |    1 +
 include/hw/vfio/vfio-common.h |    1 +
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b9abe77f5a7b..29923e499012 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -858,13 +858,15 @@ void vfio_reset_handler(void *opaque)
 
     QLIST_FOREACH(group, &vfio_group_list, next) {
         QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            vbasedev->ops->vfio_compute_needs_reset(vbasedev);
+            if (vbasedev->dev->realized) {
+                vbasedev->ops->vfio_compute_needs_reset(vbasedev);
+            }
         }
     }
 
     QLIST_FOREACH(group, &vfio_group_list, next) {
         QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->needs_reset) {
+            if (vbasedev->dev->realized && vbasedev->needs_reset) {
                 vbasedev->ops->vfio_hot_reset_multi(vbasedev);
             }
         }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8de8272e964d..ccdb6e1d632a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2116,7 +2116,8 @@ static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
 
         /* Prep dependent devices for reset and clear our marker. */
         QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
-            if (vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
+            if (!vbasedev_iter->dev->realized ||
+                vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
                 continue;
             }
             tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
@@ -2197,7 +2198,8 @@ out:
         }
 
         QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
-            if (vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
+            if (!vbasedev_iter->dev->realized ||
+                vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
                 continue;
             }
             tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
@@ -2647,6 +2649,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vdev->vbasedev.name = g_strdup(basename(vdev->vbasedev.sysfsdev));
     vdev->vbasedev.ops = &vfio_pci_ops;
     vdev->vbasedev.type = VFIO_DEVICE_TYPE_PCI;
+    vdev->vbasedev.dev = &vdev->pdev.qdev;
 
     tmp = g_strdup_printf("%s/iommu_group", vdev->vbasedev.sysfsdev);
     len = readlink(tmp, group_path, sizeof(group_path));
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index a4663c918ea2..7c09deda6143 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -640,6 +640,7 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
     int i, ret;
 
     vbasedev->type = VFIO_DEVICE_TYPE_PLATFORM;
+    vbasedev->dev = dev;
     vbasedev->ops = &vfio_platform_ops;
 
     trace_vfio_platform_realize(vbasedev->sysfsdev ?
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 9521013d52b3..0b475a3596fc 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -115,6 +115,7 @@ typedef struct VFIODevice {
     struct VFIOGroup *group;
     char *sysfsdev;
     char *name;
+    DeviceState *dev;
     int fd;
     int type;
     bool reset_works;
