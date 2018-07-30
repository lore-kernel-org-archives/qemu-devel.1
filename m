Received: from eggs.gnu.org ([2001:4830:134:3::10]:60622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fkHNK-0001Ue-Ie
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fkHNH-0006kv-DO
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:14:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fkHNH-0006kX-3l
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:14:47 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 30 Jul 2018 17:14:37 -0600
Message-ID: <153299247733.14411.6837517320997223920.stgit@gimli.home>
In-Reply-To: <153299204130.14411.11438396195753743913.stgit@gimli.home>
References: <153299204130.14411.11438396195753743913.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 4/4] vfio/ccw/pci: Allow devices to opt-in
 for ballooning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, peterx@redhat.com, cohuck@redhat.com, mst@redhat.com, david@redhat.com

If a vfio assigned device makes use of a physical IOMMU, then memory
ballooning is necessarily inhibited due to the page pinning, lack of
page level granularity at the IOMMU, and sufficient notifiers to both
remove the page on balloon inflation and add it back on deflation.
However, not all devices are backed by a physical IOMMU.  In the case
of mediated devices, if a vendor driver is well synchronized with the
guest driver, such that only pages actively used by the guest driver
are pinned by the host mdev vendor driver, then there should be no
overlap between pages available for the balloon driver and pages
actively in use by the device.  Under these conditions, ballooning
should be safe.

vfio-ccw devices are always mediated devices and always operate under
the constraints above.  Therefore we can consider all vfio-ccw devices
as balloon compatible.

The situation is far from straightforward with vfio-pci.  These
devices can be physical devices with physical IOMMU backing or
mediated devices where it is unknown whether a physical IOMMU is in
use or whether the vendor driver is well synchronized to the working
set of the guest driver.  The safest approach is therefore to assume
all vfio-pci devices are incompatible with ballooning, but allow user
opt-in should they have further insight into mediated devices.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/ccw.c                 |    9 +++++++++
 hw/vfio/common.c              |   23 ++++++++++++++++++++++-
 hw/vfio/pci.c                 |   26 +++++++++++++++++++++++++-
 hw/vfio/trace-events          |    1 +
 include/hw/vfio/vfio-common.h |    2 ++
 5 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 351b305e1ae7..40e7b5623e69 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -349,6 +349,15 @@ static void vfio_ccw_get_device(VFIOGroup *group, VFIOCCWDevice *vcdev,
         }
     }
 
+    /*
+     * All vfio-ccw devices are believed to operate compatibly with memory
+     * ballooning, ie. pages pinned in the host are in the current working
+     * set of the guest driver and therefore never overlap with pages
+     * available to the guest balloon driver.  This needs to be set before
+     * vfio_get_device() for vfio common to handle the balloon inhibitor.
+     */
+    vcdev->vdev.balloon_allowed = true;
+
     if (vfio_get_device(group, vcdev->cdev.mdevid, &vcdev->vdev, errp)) {
         goto out_err;
     }
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 4881b691a659..ef5f4b77548a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1356,7 +1356,9 @@ void vfio_put_group(VFIOGroup *group)
         return;
     }
 
-    qemu_balloon_inhibit(false);
+    if (!group->balloon_allowed) {
+        qemu_balloon_inhibit(false);
+    }
     vfio_kvm_device_del_group(group);
     vfio_disconnect_container(group);
     QLIST_REMOVE(group, next);
@@ -1392,6 +1394,25 @@ int vfio_get_device(VFIOGroup *group, const char *name,
         return ret;
     }
 
+    /*
+     * Clear the balloon inhibitor for this group if the driver knows the
+     * device operates compatibly with ballooning.  Setting must be consistent
+     * per group, but since compatibility is really only possible with mdev
+     * currently, we expect singleton groups.
+     */
+    if (vbasedev->balloon_allowed != group->balloon_allowed) {
+        if (!QLIST_EMPTY(&group->device_list)) {
+            error_setg(errp,
+                       "Inconsistent device balloon setting within group");
+            return -1;
+        }
+
+        if (!group->balloon_allowed) {
+            group->balloon_allowed = true;
+            qemu_balloon_inhibit(false);
+        }
+    }
+
     vbasedev->fd = fd;
     vbasedev->group = group;
     QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6cbb8fa0549d..056f3a887a8f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2804,12 +2804,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
-    char *tmp, group_path[PATH_MAX], *group_name;
+    char *tmp, *subsys, group_path[PATH_MAX], *group_name;
     Error *err = NULL;
     ssize_t len;
     struct stat st;
     int groupid;
     int i, ret;
+    bool is_mdev;
 
     if (!vdev->vbasedev.sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
@@ -2869,6 +2870,27 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         }
     }
 
+    /*
+     * Mediated devices *might* operate compatibly with memory ballooning, but
+     * we cannot know for certain, it depends on whether the mdev vendor driver
+     * stays in sync with the active working set of the guest driver.  Prevent
+     * the x-balloon-allowed option unless this is minimally an mdev device.
+     */
+    tmp = g_strdup_printf("%s/subsystem", vdev->vbasedev.sysfsdev);
+    subsys = realpath(tmp, NULL);
+    g_free(tmp);
+    is_mdev = (strcmp(subsys, "/sys/bus/mdev") == 0);
+    free(subsys);
+
+    trace_vfio_mdev(vdev->vbasedev.name, is_mdev);
+
+    if (vdev->vbasedev.balloon_allowed && !is_mdev) {
+        error_setg(errp, "x-balloon-allowed only potentially compatible "
+                   "with mdev devices");
+        vfio_put_group(group);
+        goto error;
+    }
+
     ret = vfio_get_device(group, vdev->vbasedev.name, &vdev->vbasedev, errp);
     if (ret) {
         vfio_put_group(group);
@@ -3170,6 +3192,8 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
+    DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
+                     vbasedev.balloon_allowed, false),
     DEFINE_PROP_BOOL("x-no-kvm-intx", VFIOPCIDevice, no_kvm_intx, false),
     DEFINE_PROP_BOOL("x-no-kvm-msi", VFIOPCIDevice, no_kvm_msi, false),
     DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, false),
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index d2a74952e389..a85e8662eadb 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -39,6 +39,7 @@ vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %
 vfio_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device %s config:\n  size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
 vfio_populate_device_get_irq_info_failure(void) "VFIO_DEVICE_GET_IRQ_INFO failure: %m"
 vfio_realize(const char *name, int group_id) " (%s) group %d"
+vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
 vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s 0x%x@0x%x"
 vfio_pci_reset(const char *name) " (%s)"
 vfio_pci_reset_flr(const char *name) "%s FLR/VFIO_DEVICE_RESET"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index a9036929b220..15ea6c26fdbc 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -112,6 +112,7 @@ typedef struct VFIODevice {
     bool reset_works;
     bool needs_reset;
     bool no_mmap;
+    bool balloon_allowed;
     VFIODeviceOps *ops;
     unsigned int num_irqs;
     unsigned int num_regions;
@@ -131,6 +132,7 @@ typedef struct VFIOGroup {
     QLIST_HEAD(, VFIODevice) device_list;
     QLIST_ENTRY(VFIOGroup) next;
     QLIST_ENTRY(VFIOGroup) container_next;
+    bool balloon_allowed;
 } VFIOGroup;
 
 typedef struct VFIODMABuf {
